#!/usr/bin/env luajit
local ffi = require 'ffi'
local gl = require 'gl.setup' (...)
local path = require 'ext.path'
local table = require 'ext.table'
local os = require 'ext.os'

local template = require 'template'
local GLApp = require 'gl.app'
local GLProgram = require 'gl.program'
local GLTex2D = require 'gl.tex2d'
local Image = require 'image'
local vec3i = require 'vec-ffi.vec3i'

local App = GLApp:subclass()

function App:initGL(...)
	if App.super.initGL then
		App.super.initGL(self, ...)
	end

	local GLGlobal = require 'gl.global'

	-- TODO gl.get() function for global gets
	-- each global size dim must be <= this
	local maxComputeWorkGroupCount = vec3i(GLGlobal:get'GL_MAX_COMPUTE_WORK_GROUP_COUNT')
	print('GL_MAX_COMPUTE_WORK_GROUP_COUNT = '..maxComputeWorkGroupCount)

	-- each local size dim must be <= this
	local maxComputeWorkGroupSize = vec3i(GLGlobal:get'GL_MAX_COMPUTE_WORK_GROUP_SIZE')
	print('GL_MAX_COMPUTE_WORK_GROUP_SIZE = '..maxComputeWorkGroupSize)

	-- the product of all local size dims must be <= this
	-- also, this is >= 1024
	local maxComputeWorkGroupInvocations = GLGlobal:get'GL_MAX_COMPUTE_WORK_GROUP_INVOCATIONS'
	print('GL_MAX_COMPUTE_WORK_GROUP_INVOCATIONS = '..maxComputeWorkGroupInvocations)

	local w, h = 256, 256
	local img = Image(w, h, 4, 'float', function(i,j)
		return i/w, j/h, .5, 1
	end)
	local srcTex = GLTex2D{
		internalFormat = gl.GL_RGBA32F,
		width = w,
		height = h,
		format = gl.GL_RGBA,
		type = gl.GL_FLOAT,
		data = img.buffer,
		minFilter = gl.GL_LINEAR,
		magFilter = gl.GL_LINEAR,
		generateMipmap = true,
	}

	local img = Image(w, h, 4, 'float', function(i,j) return 0,0,0,1 end)
	local dstTex = GLTex2D{
		internalFormat = gl.GL_RGBA32F,
		width = w,
		height = h,
		format = gl.GL_RGBA,
		type = gl.GL_FLOAT,
		data = img.buffer,	-- can data be null?
		minFilter = gl.GL_LINEAR,
		magFilter = gl.GL_LINEAR,
		generateMipmap = true,
	}

	local glslVersion = GLProgram.getVersionPragma()
	local localSize = vec3i(32,32,1)

	-- works with glslangValidator
	local entryname = 'main'

	-- doesn't work with glslangValidator
	-- ok so if Compute shaders only want 'main' entry points ... and CL kernels can't use 'main' ... ????? how to fix this.
	--local entryname = 'testEntry'

	local computeCode = template(
glslVersion
..[[

layout(local_size_x=<?=localSize.x
	?>, local_size_y=<?=localSize.y
	?>, local_size_z=<?=localSize.z
	?>) in;

layout(<?=dstFormat?>, binding=0) uniform writeonly image2D dstTex;
layout(<?=srcFormat?>, binding=1) uniform readonly image2D srcTex;

void <?=entryname?>() {
	ivec2 itc = ivec2(gl_GlobalInvocationID.xy);
	vec4 pixel = imageLoad(srcTex, itc);
	pixel.xy = pixel.yx;
	pixel.z = 1.;
	imageStore(dstTex, itc, pixel);
}
]], {
		localSize = localSize,
		dstFormat = dstTex:getFormatInfo().glslFormatName,
		srcFormat = srcTex:getFormatInfo().glslFormatName,
		entryname = entryname,
	})

	--[==[ make the program with code
	self.computeProgram = GLProgram{
		computeCode = computeCode,
	}
	--]==]
	--[==[ separating out shader construction first
	local computeShader = GLProgram.ComputeShader(computeCode)	-- compiles and verifies and prints errors if fails
	self.computeProgram = GLProgram{
		shaders = {computeShader},
	}
	--]==]
	-- [==[ make the program with spirv

	-- do the compiling here ...
	-- check out cl/tests/cpptest.lua for an example

	local spvfn = path'compute-spirv.spv'

	-- [=[ using glslangValidator (which means you have to write everything in GLSL-Compute)
	local glslfn = path'compute-spirv.comp'	-- must end in .comp according to glslangValidator
	glslfn:write(computeCode)
	os.exec(table{
		'glslangValidator', '-G', glslfn.path, '-o', spvfn.path,
	}:concat' ')
	--]=]
	--[=[ using clang, compiling c++ to BC to IR
	local bcfn = path'compute-spirv.bc'
	-- TODO same but for CL, not CL-C++
	-- can I use cl-cpp instead of glsl-compute?
	-- there is clvk which compiles clcpp to spv
	-- https://github.com/google/clspv
	-- but idk the fine details about how you'd write a compute shader as a CL shader
	local computeCLCPPCode = template([[
const int width = <?=width?>;

global float4 * dstTex;
global const float4 * srcTex;

kernel
__attribute__((reqd_work_group_size(<?=table.concat({localSize:unpack()}, ',')?>))) 		// TODO can I ever get around this fixed-local-size in Compute?
void <?=entryname?>(
) {
	const int index = get_global_id(0) + width * get_global_id(1);
	float4 pixel = srcTex[index];
	pixel.xy = pixel.yx;
	pixel.z = 1.;
	dstTex[index] = pixel;
}
]],	{
		width = w,
		localSize = localSize,
		entryname = entryname,
	})
	local clcppfn = path'compute-spirv.clcpp'	-- must end in .comp according to glslangValidator
	clcppfn:write(computeCLCPPCode)

	require 'make.targets'{
		verbose = true,
		{
			srcs = {clcppfn.path},
			dsts = {bcfn.path},
			rule = function()
				os.exec(table{
					'clang', '-v', '-Xclang','-finclude-default-header', '--target=spirv64-unknown-unknown', '-emit-llvm', '-c',
					'-o', ('%q'):format(bcfn.path), ('%q'):format(clcppfn.path),
				}:concat' ')
			end,
		}, {
			srcs = {bcfn.path},
			dsts = {spvfn.path},
			rule = function()
				-- [[ if you use -c :
				os.exec(table{
					'llvm-spirv',
					('%q'):format(bcfn.path),
					'-o', ('%q'):format(spvfn.path),
				}:concat' ')
			end,
		}
	}:run(spvfn.path)
	--]=]


--[=====[
	-- manually setup id ...
	-- TODO if we are doing the same thing with .vert and .frag shaders then we're gonna be making multiple shader-objects at once, so this wont port directly into a GLComputeShader alternate ctor
	-- maybe it would belong better into the GLProgram ctor ...
	local computeShader = setmetatable({
		id = gl.glCreateShader(GLProgram.ComputeShader.type),
	}, GLProgram.ComputeShader)
	-- manually call glShaderBinary.  mind you we can initialize more than one shader object at a time here ...
	local computeShaderIDs = ffi.new('GLuint[1]', computeShader.id)
	local binaryFormat = gl.GL_SHADER_BINARY_FORMAT_SPIR_V
	local binaryData = assert(spvfn:read())
	local binaryLen = #binaryData
	gl.glShaderBinary(
		1,
		computeShaderIDs,
		binaryFormat,
		binaryData,
		binaryLen
	)

	-- https://www.khronos.org/opengl/wiki/Example/SPIRV_Full_Compile_Linking
	gl.glSpecializeShader(computeShader.id, entryname, 0, nil, nil)

	--computeShader:compile()	-- no need ...
	computeShader:checkCompileStatus()	-- also no need?

	self.computeProgram = GLProgram{
		shaders = {computeShader},
	}
--]=====]
-- [=====[ ok I finally made it all part of the gl.program class...
	self.computeProgram = GLProgram{
		binaryFormat = gl.GL_SHADER_BINARY_FORMAT_SPIR_V,
		binaryEntryPoint = entryname,
		computeBinary = assert(spvfn:read()),
	}
--]=====]

	--]==]

	self.computeProgram
		-- TODO how do I get the uniform's read/write access, or its format?
		-- or do I have to input that twice, both in the shader code as its glsl-format and in the glBindImageTexture call as a gl enum?
		:bindImage(0, dstTex, gl.GL_WRITE_ONLY)
		:bindImage(1, srcTex, gl.GL_READ_ONLY)

	gl.glDispatchCompute(
		math.ceil(w / tonumber(localSize.x)),
		math.ceil(h / tonumber(localSize.y)),
		1)

	gl.glMemoryBarrier(gl.GL_SHADER_IMAGE_ACCESS_BARRIER_BIT)
	--gl.glMemoryBarrier(gl.GL_ALL_BARRIER_BITS)

	--srcTex:unbindImage(1)
	--dstTex:unbindImage(0)
	self.computeProgram:useNone()

--[[
	for _,uniform in ipairs(self.computeProgram.uniforms) do
		print(require 'ext.tolua'(uniform))
	end
--]]
--[[
	{arraySize=1, loc=0, name="dstTex", setters={glsltype="image2D"}, type=gl.GL_IMAGE_2D}
	{arraySize=1, loc=1, name="srcTex", setters={glsltype="image2D"}, type=gl.GL_IMAGE_2D}
--]]

	srcTex
		:bind()
		:getImage(img.buffer)
		:unbind()
	srcTex:unbind()
	img:save'src-resaved.png'

	-- this is reading dstTex correctly
	img = img * 0
	dstTex
		:bind()
		:getImage(img.buffer)
		:unbind()
	img:save'dst.png'

	print'done'
	self:requestExit()
end

return App():run()
