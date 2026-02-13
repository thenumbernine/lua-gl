#!/usr/bin/env luajit
local cmdline = require 'ext.cmdline'(...)
local sdl = require 'sdl.setup'(cmdline.sdl)
local gl = require 'gl.setup'(cmdline.gl)
local getTime = require 'ext.timer'.getTime
local op = require 'ext.op'
local ffi = require 'ffi'
local vec3f = require 'vec-ffi.vec3f'
local GLSceneObject = require 'gl.sceneobject'


local Test = require 'app3d.orbit'()
Test.title = "Spinning Points"

local numPts

function Test:initGL()
	print('SDL_GetVersion:', self.sdlGetVersion())

	local ires = 10
	local jres = 10
	numPts = ires * jres
	self.vertexCPUData = ffi.new('vec3f[?]', numPts)
	self.colorCPUData = ffi.new('vec3f[?]', numPts)

	local umin, umax = -1, 1
	local vmin, vmax = -1, 1
	local f = function(u,v) return u*u + v*v end
	for j=0,jres-1 do
		local t = (j+.5)/jres
		local v = t * (vmax - vmin) + vmin
		for i=0,ires-1 do
			local s = (i+.5)/ires
			local u = s * (umax - umin) + umin
			self.vertexCPUData[i + ires * j]:set(u, v, f(u,v))
			self.colorCPUData[i + ires * j]:set(s, t, .5)
		end
	end

	self.sceneObj = GLSceneObject{
		vertexes = {
			size = numPts * ffi.sizeof(vec3f),
			data = self.vertexCPUData,
			count = numPts,
			dim = 3,
		},
		program = {
			version = 'latest',
			precision = 'best',
			vertexCode = [[
in vec3 vertex;
in vec3 color;
out vec3 colorv;

uniform mat4 modelViewMatrix;
uniform mat4 projectionMatrix;

void main() {
	colorv = color;
	gl_Position = projectionMatrix * (modelViewMatrix * vec4(vertex, 1.));
	gl_PointSize = dot(color, vec3(50., 10., 1.));
}
]],
			fragmentCode = [[
in vec3 colorv;
out vec4 colorf;

void main() {
	vec2 d = gl_PointCoord.xy * 2. - 1.;
	float rsq = dot(d, d);
	if (rsq > 1.) discard;
	colorf = vec4(colorv, 1.);
	colorf.rg += .5 * d;
}
]],
		},
		geometry = {
			mode = gl.GL_POINTS,
		},
		attrs = {
			color = {
				buffer = {
					size = numPts * ffi.sizeof(vec3f),
					data = self.colorCPUData,
				},
			},
		},
	}
end

local hasPointSize = op.safeindex(gl, 'GL_PROGRAM_POINT_SIZE')
local hasPointSprite = op.safeindex(gl, 'GL_POINT_SPRITE')
function Test:update()
	Test.super.update(self)

	gl.glClearColor(0, 0, 0, 0)
	gl.glClear(bit.bor(gl.GL_COLOR_BUFFER_BIT, gl.GL_DEPTH_BUFFER_BIT))

	local t = getTime() % 360
	self.view.mvMat:applyRotate(math.rad(t * 30), 0, 1, 0)
	self.view.mvProjMat:mul4x4(self.view.projMat, self.view.mvMat)

	gl.glEnable(gl.GL_DEPTH_TEST)
	if hasPointSize and hasPointSprite then
		gl.glEnable(gl.GL_PROGRAM_POINT_SIZE)
		gl.glEnable(gl.GL_POINT_SPRITE)
	end

	self.sceneObj.uniforms.modelViewMatrix = self.view.mvMat.ptr
	self.sceneObj.uniforms.projectionMatrix = self.view.projMat.ptr
	self.sceneObj:draw()

	if hasPointSize and hasPointSprite then
		gl.glDisable(gl.GL_POINT_SPRITE)
		gl.glDisable(gl.GL_PROGRAM_POINT_SIZE)
	end
	gl.glDisable(gl.GL_DEPTH_TEST)
end

return Test():run()
