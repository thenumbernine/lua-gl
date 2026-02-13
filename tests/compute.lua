#!/usr/bin/env luajit
local cmdline = require 'ext.cmdline'(...)
local sdl, SDLApp = require 'sdl.setup'(cmdline.sdl)
local gl = require 'gl.setup'(cmdline.gl)
local ffi = require 'ffi'
local template = require 'template'
local GLApp = require 'gl.app'
local GLTex2D = require 'gl.tex2d'
local Image = require 'image'
local vec3i = require 'vec-ffi.vec3i'

local App = GLApp:subclass()

function App:initGL(...)
	if App.super.initGL then
		App.super.initGL(self, ...)
	end

	local GLGlobal = require 'gl.global'

	-- each global size dim must be <= this
	print(GLGlobal:get'GL_MAX_COMPUTE_WORK_GROUP_COUNT')

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

	local localSize = vec3i(32,32,1)
	self.computeShader = require 'gl.program'{
		version = 'latest',
		precision = 'best',
		computeCode = template([[
layout(local_size_x=<?=localSize.x
	?>, local_size_y=<?=localSize.y
	?>, local_size_z=<?=localSize.z
	?>) in;

layout(<?=dstFormat?>, binding=0) uniform writeonly image2D dstTex;
layout(<?=srcFormat?>, binding=1) uniform readonly image2D srcTex;

void main() {
	ivec2 itc = ivec2(gl_GlobalInvocationID.xy);
	vec4 pixel = imageLoad(srcTex, itc);
	pixel.xy = pixel.yx;
	pixel.z = 1.;
	imageStore(dstTex, itc, pixel);
}
]], 	{
			localSize = localSize,
			dstFormat = dstTex:getFormatInfo().glslFormatName,
			srcFormat = srcTex:getFormatInfo().glslFormatName,
		})
	}
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
	self.computeShader:useNone()

--[[
	for _,uniform in ipairs(self.computeShader.uniforms) do
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
	img:save'src-resaved.png'

	-- this is reading dstTex correctly
	img = img * 0
	dstTex
		:bind()
		:getImage(img.buffer)
		:unbind()
	dstTex:unbind()
	img:save'dst.png'

	print'done'
	self:requestExit()
end

return App():run()
