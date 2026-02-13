#!/usr/bin/env luajit
--[[
test of GL_ARB_gl_spirv with vert+frag shaders

CLI:
	method=source			-- from multiple glShaderSource's per shader module
	method=programBinary	-- from one single glProgramBinary for the entire program
	method=spirvPerShader	-- from multiple glShaderBinary's per shader module
	method=spirvMultiple	-- from one single glShaderBinary for the entire program

	useUniformBlocks		-- use uniform-blocks instead of uniforms (off by default)
--]]
require 'ext'
local template = require 'template'
local ffi = require 'ffi'
require 'gl.env'()

-- so far the only thing that works is glShaderSource()
local shaderMethod = cmdline.method or cmdline[1] or 'source'

local useUniformBlocks = cmdline.useUniformBlocks or false
print('useUniformBlocks', useUniformBlocks)


local App = require 'imgui.appwithorbit'()

App.title = 'SPIRV Shader Test'
App.viewDist = 3

function App:initGL()
	App.super.initGL(self)
	self.view.ortho = true
	self.view.orthoSize = 1

	local glGlobal = require 'gl.global'
	local binaryFormats = table{glGlobal:get'GL_SHADER_BINARY_FORMATS'}
	print('GL_SHADER_BINARY_FORMATS', tolua(binaryFormats))

	local GL_SHADER_BINARY_FORMAT_SPIR_V = op.safeindex(gl, 'GL_SHADER_BINARY_FORMAT_SPIR_V') or 38225
	local binaryFormat = GL_SHADER_BINARY_FORMAT_SPIR_V
	assert(binaryFormats:find(GL_SHADER_BINARY_FORMAT_SPIR_V), "failed to find GL_SHADER_BINARY_FORMAT_SPIR_V supported binary format")

	local vertexCode = template([[
#version 450
precision highp float;
layout(location=0) in vec2 vertex;
layout(location=0) out vec2 posv;

<? if not useUniformBlocks then ?>	// as uniform. location required for spirv

layout(location=0) uniform mat4 mvProjMat;

<? else -- useUniformBlocks ?>	// as a uniform-block, which is required for Vulkan (right?)

layout(std140, binding=0, row_major) uniform VertexUniforms {
	mat4 mvProjMat;
};

<? end -- useUniformBlocks ?>

void main() {
	posv = vertex;
	gl_Position = mvProjMat * vec4(vertex, 0., 1.);
}
]],	{
		useUniformBlocks = useUniformBlocks,
	})

	local fragmentCode = [[
#version 450
precision highp float;
layout(location=0) in vec2 posv;
layout(location=0) out vec4 fragColor;
#define dvec2 vec2
#define double float
void main() {
	dvec2 c = posv;
	dvec2 z = vec2(0., 0.);
	double iter = 0.;
	double znorm = 0.;
	for (; iter < 100.; ++iter) {
		z = dvec2( z.x*z.x - z.y*z.y + c.x, 2.*z.x*z.y + c.y );
		znorm = dot(z,z);
		if (znorm > 4.) {
			iter = iter - .5 * double(log(float(znorm)));
			break;
		}
	}

	vec2 zf = vec2(z);
	float zangle = atan(zf.y, zf.x);
	fragColor = vec4(zangle, znorm, iter, 1.);
}
]]

	-- used for shaderMethod is spirvPerShader or spirvMultiple
	local shaderVertSrc = path'test_spirv_shader.vert'
	local shaderFragSrc = path'test_spirv_shader.frag'
	local shaderVertSPV = path'test_spirv_shader-vert.spv'
	local shaderFragSPV = path'test_spirv_shader-frag.spv'
	local shaderLinkedSPV = path'test_spirv_shader.spv'
	local function glslangValidatorCompile()
		shaderVertSrc:write(vertexCode)
		shaderFragSrc:write(fragmentCode)
		assert(os.exec('glslangValidator -S vert -G --glsl-version 450 --target-env opengl '..shaderVertSrc:escape()..' -o '..shaderVertSPV:escape()))
		assert(os.exec('glslangValidator -S frag -G --glsl-version 450 --target-env opengl '..shaderFragSrc:escape()..' -o '..shaderFragSPV:escape()))
		assert(os.exec('spirv-link '..shaderVertSPV:escape()..' '..shaderFragSPV:escape()..' -o '..shaderLinkedSPV:escape()))
	end

	-- used for shaderMethod == programBinary
	local progBinPath = path'test_spirv_programBinaryOut.bin'

	self.sceneObj = GLSceneObject{
		program = assert.index({
			source = function()
				return {
					-- by source code
					vertexCode = vertexCode,
					fragmentCode = fragmentCode,

					--[[
					For using uniform-blocks instead of uniforms.
					Fun Fact:
					With glShaderSource with GLES3, you cannot specify binding= in the GLSL
					But with glShaderBinary + SPIRV you *can only* specify the block binding in the GLSL
						(since the compile phase seems to lose all names, so you have no other way to identify blocks beyond checking sizes or random guesses)
					--]]
					uniformBlocks = {
						VertexUniforms = {
							binding = 0,
						},
					},
				}
			end,
			programBinary = function()
				local progBin = assert(progBinPath:read())
				return {
					-- by previously saved program:getBinary()
					binaryFormat = ffi.cast('uint32_t*', progBin)[0],
					programBinary = progBin:sub(5),
				}
			end,
			spirvPerShader = function()
				glslangValidatorCompile()
				return {
					-- loading one binary shader-module at a time per glShaderBinary() call
					-- NOT WORKING AND NO ERROR
					binaryFormat = binaryFormat,
					vertexBinary = assert(shaderVertSPV:read()),
					fragmentBinary = assert(shaderFragSPV:read()),
				}
			end,
			spirvMultiple = function()
				glslangValidatorCompile()
				return {
					-- loading all binaries in one single glShaderBinary() call
					-- NOT WORKING AND NO ERROR
					binaryFormat = binaryFormat,
					shadersBinary = assert(shaderLinkedSPV:read()),
					-- can you infer the shader-module stages in a SPIR-V from its file?
					shadersBinaryStages = {'vertex', 'fragment'},
				}
			end,
		}, shaderMethod)(),
		vertexes = {
			dim = 2,
			data = {
				-2, -2,
				2, -2,
				-2, 2,
				2, 2,
			},
		},
		geometry = {
			mode = gl.GL_TRIANGLE_STRIP,
			count = 4,
		},
	}

	local program = self.sceneObj.program
	local uniformBlocks = program.uniformBlocks
	local uniforms = program.uniforms
	print'uniform blocks:'
	print(tolua(table.mapi(uniformBlocks, function(x) return x end)))
	print'uniforms:'
	print(tolua(table.mapi(uniforms, function(o) return table(o, {setters=false}) end)))

	local vertexUniformBlock =
		-- This will exist for the GLSL-source-compiled shader.
		-- But it won't work with binary shader ... cuz no names in SPIR-V ?
		uniformBlocks.VertexUniforms
		-- would I need a .uniformBlockForBinding[] ?
		or uniformBlocks[1]

	if not vertexUniformBlock then
		print('no vertexUniformBlock found -- no associated UniformBuffer will be created')
	else
		assert.eq(vertexUniformBlock.dataSize, ffi.sizeof'float' * 16)
print('creating a uniform buffer to map the mvProjMat to the shader uniform block...')
		self.vertexUniformBuf = GLUniformBuffer{
			data = self.view.mvProjMat.ptr,
			size = ffi.sizeof'float' * 16,
			usage = gl.GL_DYNAMIC_DRAW,
			binding = vertexUniformBlock.binding,
		}:unbind()
	end

	-- since spirv doesn't save names,
	-- see if there's a lone, unnamed uniform
	-- and if there is, give it a name
	if not uniforms[1].name then
print('reassigning uniform mvProjMat (SPIRV forgets names)')
		uniforms[1].name = 'mvProjMat'
		uniforms[uniforms[1].name] = uniforms[1]
	end

	-- if I load the SPIR-V shader ... and get my no-errors black-screen ... and then try to save the program ...
	-- OpenGL segfaults.
	if not (
		shaderMethod == 'spirvPerShader'
		or shaderMethod == 'spirvMultiple'
	) then
		-- [[ for glShaderSource() pathway, lets get the program-binary back and see what it is
		local programBinary, programBinaryFormat = program:getBinary()
		print('program binary format:', programBinaryFormat)	-- on Linux this turns out to be GL_PROGRAM_BINARY_FORMAT_MESA = 34655
print('writing program binary to '..progBinPath)
		progBinPath:write(
			ffi.string(ffi.new('uint32_t[1]', programBinaryFormat), 4)
			..programBinary
		)
		--]]
	end
end

function App:update()
	App.super.update(self)

	gl.glClearColor(0,0,1,1)
	gl.glClear(bit.bor(gl.GL_COLOR_BUFFER_BIT, gl.GL_DEPTH_BUFFER_BIT))

	if self.vertexUniformBuf then
		-- using uniform-blocks:
		self.vertexUniformBuf
			:bind()
			:updateData()
			:unbind()
	else
		self.sceneObj.uniforms.mvProjMat = self.view.mvProjMat.ptr
	end
	self.sceneObj:draw()
end

return App():run()
