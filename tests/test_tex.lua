#!/usr/bin/env luajit
-- test but with textures
local cmdline = require 'ext.cmdline'(...)
local ffi = require 'ffi'
local string = require 'ext.string'
local sdl, SDLApp = require 'sdl.setup' (cmdline.sdl)
local gl = require 'gl.setup' (cmdline.gl)
local getTime = require 'ext.timer'.getTime
local Image = require 'image'
local GLTex2D = require 'gl.tex2d'

local Test = require 'app3d.orbit'()
Test.title = "Spinning Triangle"

Test.viewDist = 10

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
		print(err..'\n'..debug.traceback())
	end)

	print'GL_EXTENSIONS:'
	local extstr = glGlobal:get'GL_EXTENSIONS' or ''
	print(' '..extstr:gsub(' ', '\n '))

	local img = Image'src.png'
	local tex = GLTex2D{
		image = img,
		generateMipmap = true,
	}:unbind()

	self.obj = require 'gl.sceneobject'{
		program = {
			version = cmdline.glsl or 'latest',
			precision = 'best',
			vertexCode = [[
in vec2 vertex;
in vec2 tc;
in vec3 color;
out vec2 tcv;
out vec4 colorv;
uniform mat4 mvProjMat;
void main() {
	tcv = tc;
	colorv = vec4(color, 1.);
	gl_Position = mvProjMat * vec4(vertex, 0., 1.);
}
]],
			fragmentCode = [[
in vec2 tcv;
in vec4 colorv;
out vec4 fragColor;
uniform sampler2D tex;
void main() {
	fragColor = colorv * texture(tex, tcv);
}
]],
			uniforms = {
				tex = 0,
			},
		},
		vertexes = {
			data = {
				-5, 5,
				5, 5,
				-5, -5,
				5, -5,
			},
			dim = 2,
		},
		geometry = {
			mode = gl.GL_TRIANGLES,
			indexes = {
				data = {0, 1, 2, 3, 2, 1},
			},
		},
		texs = {tex},
		attrs = {
			tc = {
				buffer = {
					data = {
						0, 0,
						1, 0,
						0, 1,
						1, 1,
					},
					dim = 2,
				},
			},
			color = {
				buffer = {
					data = {
						1, .3, .3,
						.3, 1, .3,
						.3, .3, 1,
						1, 1, 1,
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
