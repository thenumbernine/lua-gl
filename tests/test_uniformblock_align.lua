#!/usr/bin/env luajit
local ffi = require 'ffi'
local assert = require 'ext.assert' 
local table = require 'ext.table' 
local tolua = require 'ext.tolua' 
local vec2i = require 'vec-ffi.vec2i'
local vec4i = require 'vec-ffi.vec4i'
local vec4f = require 'vec-ffi.vec4f'
local vec4x4f = require 'vec-ffi.vec4x4f'
local gl = require 'gl'
local GLTex2D = require 'gl.tex2d'
local GLFramebuffer = require 'gl.framebuffer'
local GLUniformBuffer = require 'gl.uniformbuffer'
local struct = require 'struct'

local LightCPU = struct{
	name = 'LightCPU',
	fields = {
		{name='viewProjMat', type='vec4x4f'},		-- used for light depth coord transform, and for determining the light pos
		{name='region', type='vec4f'},               -- uint16_t[4] x y w h / (lightmapWidth, lightmapHeight)
		{name='ambientColor', type='vec4f'},         -- per light ambient (is attenuated, so its diffuse without dot product dependency).
		{name='diffuseColor', type='vec4f'},         -- = vec3(1., 1., 1.);
		{name='specularColor', type='vec4f'},        -- = vec3(.6, .5, .4, 30.);	// w = shininess
		{name='distAtten', type='vec4f'},            -- vec3(const, linear, quadratic) attenuation
		{name='viewPos', type='vec4f'},              -- translation components of inverse-view-matrix of the light
		{name='negViewDir', type='vec4f'},           -- negative-z-axis of inverse-view-matrix of the light
		{name='cosAngleRange', type='vec2f'},        -- cosine(outer angle), 1 / (cosine(inner angle) - cosine(outer angle)) = {0,1}
		{name='enabled', type='int32_t'},
		{name='padding', type='int32_t'},
	},
}

local maxLights = 256

local FragBlockCPU = struct{
	name = 'FragBlockCPU',
	fields = {
		{name='lights', type='LightCPU['..maxLights..']'},

		{name='drawViewMat', type='vec4x4f'},
		{name='drawProjMat', type='vec4x4f'},

		{name='lightAmbientColor', type='vec4f'},
		{name='drawViewPos', type='vec3f'},

		{name='ssaoSampleRadius', type='float'},
		{name='ssaoInfluence', type='float'},
		{name='numLights', type='int32_t'},
		{name='padding', type='vec2i'},
	},
}

local App = require 'gl.app':subclass()
function App:initGL()

	-- how to figure out alignment of uniform blocks ...
	self.obj = require 'gl.sceneobject'{
		program = {
			version = 'latest',
			precision = 'best',
			vertexCode = [[
layout(location=0) in vec2 vertex;
void main() {
	gl_Position = vec4(vertex * 2. - 1., 0., 1.);
}
]],
			fragmentCode = [[
layout(location=0) out uvec4 fragColor;

#define maxLights ]]..maxLights..[[

struct LightGPU {
	mat4 viewProjMat;	// used for light depth coord transform, and for determining the light pos
	vec4 region;	// uint16_t[4] x y w h / (lightmapWidth, lightmapHeight)
	vec3 ambientColor;// per light ambient (is attenuated, so its diffuse without dot product dependency).
	vec3 diffuseColor;// = vec3(1., 1., 1.);
	vec4 specularColor;// = vec3(.6, .5, .4, 30.);	// w = shininess
	vec3 distAtten;	// vec3(const, linear, quadratic) attenuation
	vec3 viewPos;	// translation components of inverse-view-matrix of the light
	vec3 negViewDir;	// negative-z-axis of inverse-view-matrix of the light
	vec2 cosAngleRange;	// cosine(outer angle), 1 / (cosine(inner angle) - cosine(outer angle)) = {0,1}
	bool enabled;
};

layout(std140, binding=0) uniform FragBlockGPU {
	LightGPU lights[maxLights];	
	
	mat4 drawViewMat;
	mat4 drawProjMat;

	vec3 lightAmbientColor;
	vec3 drawViewPos;

	float ssaoSampleRadius;
	float ssaoInfluence;
	int numLights;
};

void main() {
	uint y = ~0u;
#if 0 // Never mind, I thought this was OpenCL, which is C on the GPU, which we had 15 years ago and somehow that's no longer a thing, and we're stuck with this ...	
	if (gl_FragCoord.x == 0) {
		y = sizeof(LightGPU);
	}
#endif	
	fragColor = uvec4(y, 0u, 0u, 0u);
}
]],
		},
		vertexes = {
			data = {
				0,0, 1,0, 0,1, 1,1,
			},
		},
		geometry = {
			mode = gl.GL_TRIANGLE_STRIP,
		},
	}

-- [[ GPU offsets and sizes:
	print(tolua(
		table.mapi(self.obj.program.uniformBlocks, function(o) return o end)
		:sort(function(a,b) return a.offset < b.offset end)
	))
	print(tolua(
		table.mapi(self.obj.program.uniforms, function(o) return table(o, {setters=false}) end)
		:sort(function(a,b) return a.offset < b.offset end)
	))
--]]
-- [[ CPU offsets and sizes
	for fb_name,fb_ctype in FragBlockCPU:fielditer() do
		if fb_name == 'lights' then
			for i=0,maxLights-1 do
				for name, ctype in LightCPU:fielditer() do
					local cpuOffset = tonumber(
						-- how to get offsetof into an array of a primitive in a struct ...
						ffi.cast('intptr_t', 
							ffi.cast('FragBlockCPU*', 0).lights + i
						)
						+ ffi.offsetof('LightCPU', name)
					)
					local cpuSize = tonumber(ffi.sizeof(ctype))
					
					local uniformName = 'lights['..i..'].'..name
					local gpuUniform = self.obj.program.uniforms[uniformName]
					if not gpuUniform then
						print('failed to find '..uniformName)
					else
						local gpuOffset = gpuUniform.offset
						--local gpuSize = hmm nope, no size param that I've saved yet.  just the type and arraySize and matrixStride...

						print(uniformName 
							..' cpu offset='..cpuOffset
							..' gpu offset='..gpuOffset
							..' cpu size='..cpuSize
						)
					end
				end
			end
		else
			local cpuOffset = tonumber(ffi.offsetof('FragBlockCPU', fb_name))
			local cpuSize = tonumber(ffi.sizeof(fb_ctype))
			
			local uniformName = fb_name
			local gpuUniform = self.obj.program.uniforms[uniformName]
			if not gpuUniform then
				print('failed to find '..uniformName)
			else
				local gpuOffset = gpuUniform.offset
				--local gpuSize = hmm nope, no size param that I've saved yet.  just the type and arraySize and matrixStride...

				print(uniformName 
					..' cpu offset='..cpuOffset
					..' gpu offset='..gpuOffset
					..' cpu size='..cpuSize
				)
			end

		end
	end
--]]


	local FragBlockGPU = self.obj.program.uniformBlocks.FragBlockGPU
print("ffi.sizeof'FragBlockCPU'", ffi.sizeof'FragBlockCPU')
print('FragBlockGPU.dataSize', FragBlockGPU.dataSize)
	--assert.eq(ffi.sizeof'FragBlockCPU', FragBlockGPU.dataSize, 'sizeof(FragBlockCPU) vs FragBlockGPU.dataSize')
	self.fragUniCPU = ffi.new'FragBlockCPU'
	self.fragUniCPU.numLights = 100
	self.fragUniGPU = GLUniformBuffer{
		data = self.fragUniCPU,
		size = FragBlockGPU.dataSize,
		usage = gl.GL_DYNAMIC_DRAW,
		binding = FragBlockGPU.binding,
	}:unbind()

	local fboTexSize = vec2i(2048, 1)
	local fboTexData = ffi.new('uint32_t[?]', fboTexSize:volume())
	self.fboTex = GLTex2D{
		width = fboTexSize.x,
		height = fboTexSize.y,
		internalFormat = gl.GL_R32UI,
		minFilter = gl.GL_NEAREST,
		magFilter = gl.GL_NEAREST,
		data = fboTexData,
	}
	self.fbo = GLFramebuffer()
		:bind()
		:setColorAttachmentTex2D(self.fboTex.id, 0)
		:drawBuffers(gl.GL_COLOR_ATTACHMENT0)
		:unbind()
end
function App:update()
--[[	
	self.fbo:check()
	self.fbo:bind()
	gl.glViewport(0, 0, self.fboTex.width, self.fboTex.height)
	gl.glClearBufferiv(gl.GL_COLOR, 0, ffi.new'vec4i'.s)
	self.obj:draw()
	gl.glReadPixels(0, 0, self.fboTex.width, self.fboTex.height, self.fboTex.format, self.fboTex.type, self.fboTex.data)
	self.fbo:unbind()

	print()
	for i=0,math.min(100, self.fboTex.width-1) do
		io.write(' ', self.fboTex.data[i])
	end
	print()
--]]
	self:requestExit()
end
return App():run()
