#!/usr/bin/env luajit
local ffi = require 'ffi'
local assert = require 'ext.assert'
local egl = require 'gl.ffi.EGL'
print('egl', egl)

-- how do I find GLES version?  cuz GL doen't show it ...
-- GLES/OpenGLES1.h has GL_VERSION, but GL_VERSION returns the same as it does for non-ES ...
-- [[ can EGL version help?
-- https://registry.khronos.org/EGL/sdk/docs/man/html/eglIntro.xhtml
-- seems no
local display = egl.eglGetDisplay(egl.EGL_DEFAULT_DISPLAY)
print('display', display)
assert.ne(display, egl.EGL_NO_DISPLAY, "eglGetDisplay(EGL_DEFAULT_DISPLAY) failed")

local eglVersion = ffi.new('EGLint[2]')
-- how to debug eglInitialize failing:
-- env DYLD_PRINT_BINDINGS=YES DYLD_PRINT_LIBRARIES=YES ./info.lua
if egl.EGL_TRUE ~= egl.eglInitialize(display, eglVersion+0, eglVersion+1) then
	error('eglInitialize failed with error '..tostring(egl.eglGetError()))
end
print('EGL version from eglInitialize:', eglVersion[0], eglVersion[1])

local attributeListSrc = {
	egl.EGL_RED_SIZE, 1,
	egl.EGL_GREEN_SIZE, 1,
	egl.EGL_BLUE_SIZE, 1,
	egl.EGL_RENDERABLE_TYPE, egl.EGL_OPENGL_ES2_BIT,	-- tell EGL to use GLES3 ... that's right, GLES3, even tho it says ES2 ...
	egl.EGL_NONE,
}
local attributeList = ffi.new('EGLint['..#attributeListSrc..']', attributeListSrc)
local pconfig = ffi.new('EGLConfig[1]')
local pnumConfig = ffi.new('EGLint[1]')
egl.eglChooseConfig(display, attributeList, pconfig, 1, pnumConfig);
local context = egl.eglCreateContext(display, config, egl.EGL_NO_CONTEXT, nil)
print()
--]]

for _,field in ipairs{
	'EGL_CLIENT_APIS',
	'EGL_VENDOR',
	'EGL_VERSION',
	'EGL_EXTENSIONS',
} do
	local strptr = egl.eglQueryString(egl.EGL_NO_DISPLAY, egl[field])
	local str = strptr ~= nil and ffi.string(strptr) or 'null'
	print(field, str)
end
