#!/usr/bin/env luajit
local ffi = require 'ffi'
local cmdline = require 'ext.cmdline'(...)
local table = require 'ext.table'
local assert = require 'ext.assert'
local tolua = require 'ext.tolua'
local timer = require 'ext.timer'
local vec4x4f = require 'vec-ffi.vec4x4f'
local gl = require 'gl.setup'(cmdline.gl)
local GLUniformBuffer = require 'gl.uniformbuffer'
local GLSceneObject = require 'gl.sceneobject'
local App = require 'app3d.orbit'()

-- define Cdef of uniform blocks:

local VtxMatricesType = ffi.typeof[[struct{
	vec4x4f modelMat;
	vec4x4f viewMat;
	vec4x4f projMat;
}]]

local FragMatricesType = ffi.typeof[[struct{
	vec4x4f colorMat;
}]]

App.viewDist = 3
function App:initGL()
	self.obj = GLSceneObject{
		program = {
			version = 'latest',
			precision = 'best',
			vertexCode = [[
layout(location=0) in vec2 vertex;
out vec2 vertexv;

layout(std140, row_major) uniform VtxMatrices {
	mat4 modelMat;
	mat4 viewMat;
	mat4 projMat;
};

void main() {
	vertexv = vertex;
	gl_Position = 
		projMat * viewMat * modelMat * 
		vec4(2. * vertex - 1., 0., 1.);
}
]],
			fragmentCode = [[
in vec2 vertexv;

layout(location=0) out vec4 fragColor;

layout(std140, row_major) uniform FragMatrices {
	mat4 colorMat;
};

void main() {
	fragColor = colorMat * vec4(vertexv - .5, 0, 1.);
}
]],
			-- setup bindings here since GLES3-WebGL2-ANGLE-GLSL doesn't let us set layout(bindings) like Mesa-GLES3 does
			uniformBlocks = {
				VtxMatrices = {
					binding = 0,
				},
				FragMatrices = {
					binding = 1,
				},
			},
		},
		vertexes = {
			data = {
				0,0, 1,0, 0,1, 1,1,
			},
		},
		geometry = {
			mode = gl.GL_TRIANGLE_STRIP,
		}
	}

	print(tolua(table.mapi(self.obj.program.uniformBlocks, function(o) return o end)))
-- why is the colorMat uniform location -1 even when I am using it?	
	print(tolua(table.mapi(self.obj.program.uniforms, function(o) return table(o, {setters=false}) end)))
	
	self.vtxMatricesCPU = VtxMatricesType()
	self.fragMatricesCPU = FragMatricesType()

	-- make our pointer objects point to it
	-- hmm tempting to make a FFI type for mat4x4's...
	self.view.projMat = self.vtxMatricesCPU.projMat
	self.view.mvMat = self.vtxMatricesCPU.viewMat		-- view's mvMat will be the view-mat ...
	self.modelMat = self.vtxMatricesCPU.modelMat
	self.colorMat = self.fragMatricesCPU.colorMat

	self.view:setup(self.width / self.height)
	self.modelMat:setIdent()
	self.colorMat:setIdent()
		:applyTranslate(.5, .5, .5)

assert.eq(ffi.sizeof(VtxMatricesType), self.obj.program.uniformBlocks.VtxMatrices.dataSize)
	self.vtxMatricesBuf = GLUniformBuffer{
		data = self.vtxMatricesCPU,
		size = ffi.sizeof(self.vtxMatricesCPU),
		usage = gl.GL_DYNAMIC_DRAW,
		binding = self.obj.program.uniformBlocks.VtxMatrices.binding,
	}:unbind()
assert.eq(ffi.sizeof(VtxMatricesType), self.vtxMatricesBuf.size)


assert.eq(ffi.sizeof(FragMatricesType), self.obj.program.uniformBlocks.FragMatrices.dataSize)
	self.fragMatricesBuf = GLUniformBuffer{
		data = self.fragMatricesCPU,
		size = ffi.sizeof(self.fragMatricesCPU),
		usage = gl.GL_DYNAMIC_DRAW,
		binding = self.obj.program.uniformBlocks.FragMatrices.binding,
	}:unbind()
assert.eq(ffi.sizeof(FragMatricesType), self.fragMatricesBuf.size)
end

function App:update()
	App.super.update(self)
	gl.glClear(gl.GL_COLOR_BUFFER_BIT)

	local thisTime = timer.getTime()
	local lastTime = self.lastTime or thisTime 
	local dt = thisTime - lastTime
	self.modelMat:applyRotate(.1 * dt, 0, 1, 0)
	self.colorMat:applyRotate(
		2 * dt,
		math.sin(3 * dt) * math.cos(5 * dt),
		math.sin(3 * dt) * math.sin(5 * dt),
		math.cos(3 * dt)
	)

	self.vtxMatricesBuf
		:bind()
		:updateData()
	self.fragMatricesBuf
		:bind()
		:updateData()
		:unbind()

	self.obj:draw()

	self.lastTime = thisTime
end

return App():run()
