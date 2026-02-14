#!/usr/bin/env luajit
-- ES test using gl.sceneobject and objects ...
local cmdline = require 'ext.cmdline'(...)
local sdl, SDLApp = require 'sdl.setup' (cmdline.sdl)
local gl = require 'gl.setup' (cmdline.gl or 'OpenGLES3')
local ffi = require 'ffi'
local getTime = require 'ext.timer'.getTime

local Test = require 'app3d.orbit'()
Test.title = "Spinning Triangle"

Test.viewDist = 20

function Test:initGL()
	print('SDL_GetVersion:', self.sdlGetVersion())

	local glGlobal = require 'gl.global'
	print('GL_VERSION', glGlobal:get'GL_VERSION')
	print('GL_SHADING_LANGUAGE_VERSION', glGlobal:get'GL_SHADING_LANGUAGE_VERSION')

	io.write'glsl version\t'
	xpcall(function()
		print(require 'gl.program'.getVersionPragma(false))
	end, function(err)
		print('error: '..tostring(err))
	end)

	io.write'glsl es version\t'
	xpcall(function()
		print(require 'gl.program'.getVersionPragma(true))
	end, function(err)
		print('error: '..tostring(err))
	end)

	self.view.ortho = true
	self.view.orthoSize = 10

	self.obj = require 'gl.sceneobject'{
		program = {
			version = cmdline.glsl or 'latest',
			precision = 'best',
			vertexCode = [[
in vec2 vertex;
in vec3 color;
out vec4 colorv;
uniform mat4 mvProjMat;
void main() {
	colorv = vec4(color, 1.);
	gl_Position = mvProjMat * vec4(vertex, 0., 1.);
}
]],
			fragmentCode = [[
in vec4 colorv;
out vec4 fragColor;
void main() {
	fragColor = colorv;
}
]],
		},
		vertexes = {
			data = {
				-5, -4,
				5, -4,
				0, 6,
			},
			dim = 2,
		},
		geometry = {
			mode = gl.GL_TRIANGLES,
		},
		attrs = {
			color = {
				buffer = {
					data = {
						1, 0, 0,
						0, 1, 0,
						0, 0, 1,
					},
					dim = 3,
				},
			},
		},
	}

	gl.glClearColor(0, 0, 0, 1)
end

function Test:update()
	Test.super.update(self)
	gl.glClear(gl.GL_COLOR_BUFFER_BIT)

	local t = getTime()
	self.view.mvMat:applyRotate(math.rad(t * 30), 0, 1, 0)
	self.view.mvProjMat:mul4x4(self.view.projMat, self.view.mvMat)

	self.obj.uniforms.mvProjMat = self.view.mvProjMat.ptr
	self.obj:draw()
end

return Test():run()
