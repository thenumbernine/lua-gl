#!/usr/bin/env luajit
local cmdline = require 'ext.cmdline'(...)
local sdl, SDLApp = require 'sdl.setup' (cmdline.sdl)
local getTime = require 'ext.timer'.getTime
local gl = require 'gl.setup' (cmdline.gl)
local ffi = require 'ffi'


local Test = require 'app3d.orbit'()
Test.viewUseGLMatrixMode = true

Test.title = "Spinning Triangle"

function Test:initGL()
	print('SDL_GetVersion:', self.sdlGetVersion())
end

function Test:update()
	Test.super.update(self)

	gl.glClearColor(0, 0, 0, 0)
	gl.glClear(gl.GL_COLOR_BUFFER_BIT)

	local t = getTime() % 360
	gl.glRotatef(t * 30, 0, 1, 0)

	gl.glBegin(gl.GL_TRIANGLES)
	gl.glColor3f(1, 0, 0)
	gl.glVertex3f(-5, -4, 0)
	gl.glColor3f(0, 1, 0)
	gl.glVertex3f(5, -4, 0)
	gl.glColor3f(0, 0, 1)
	gl.glVertex3f(0, 6, 0)
	gl.glEnd()
end

return Test():run()
