#!/usr/bin/env luajit
-- ES test using raw gl calls
local cmdline = require 'ext.cmdline'(...)
local vec4x4f = require 'vec-ffi.vec4x4f'
local sdl = require 'sdl.setup'(cmdline.sdl)
local gl = require 'gl.setup'(cmdline.gl)

local ffi = require 'ffi'
local assert = require 'ext.assert'
local getTime = require 'ext.timer'.getTime

local Test = require 'gl.app':subclass()
Test.title = "Spinning Triangle"

local znear = .1
local zfar = 100
local orthoSize = 10
local projMat, mvMat, mvProjMat
local programID
local vertexBufferID
local colorBufferID
local vertexAttrLoc
local colorAttrLoc
local mvProjMatUniformLoc
local vaoID

function Test:initGL()
	local sdl = require 'sdl'

	print('SDL_GetVersion:', self.sdlGetVersion())

	print('GLES Version', ffi.string(gl.glGetString(gl.GL_VERSION)))
	print('GL_SHADING_LANGUAGE_VERSION', ffi.string(gl.glGetString(gl.GL_SHADING_LANGUAGE_VERSION)))
	print('glsl version', require 'gl.program'.getVersionPragma(false))
	print('glsl es version', require 'gl.program'.getVersionPragma(true))

	local aspectRatio = self.width / self.height
	projMat = vec4x4f()
		--[[
		:setFrustum(
			-znear * aspectRatio * tanFovY,
			 znear * aspectRatio * tanFovY,
			-znear * tanFovY,
			 znear * tanFovY,
			 znear,
			 zfar
		)
		--]]
		-- [[
		:setOrtho(
			-orthoSize * aspectRatio,
			 orthoSize * aspectRatio,
			-orthoSize,
			 orthoSize,
			 znear,
			 zfar
		)
		--]]
	mvMat = vec4x4f():setIdent()
	mvProjMat = vec4x4f():setIdent()

	local versionHeader = require 'gl.program'.getVersionPragma()..'\n'

	local vertexShaderID = gl.glCreateShader(gl.GL_VERTEX_SHADER)
	local code = versionHeader..[[
precision highp float;
in vec2 vertex;
in vec3 color;
out vec4 colorv;
uniform mat4 mvProjMat;
void main() {
	colorv = vec4(color, 1.);
	gl_Position = mvProjMat * vec4(vertex, 0., 1.);
}
]]
	local len = ffi.new'int[1]'
	len[0] = #code
	local strs = ffi.new'const char*[1]'
	strs[0] = code
	gl.glShaderSource(vertexShaderID, 1, strs, len)
	gl.glCompileShader(vertexShaderID)
	local status = ffi.new'GLint[1]'
	gl.glGetShaderiv(vertexShaderID, gl.GL_COMPILE_STATUS, status)
	print('vertex shader compile status', status[0])
	do
		local result = ffi.new'GLint[1]'
		gl.glGetShaderiv(vertexShaderID, gl.GL_INFO_LOG_LENGTH, result)
		local length = result[0]
		print('length', length)
		local log = ffi.new('char[?]',length+1)
		local result = ffi.new'GLsizei[1]'
		gl.glGetShaderInfoLog(vertexShaderID, length, result, log);
		print('double check length', result[0])
		print('log:')
		print(ffi.string(log))
	end

	local fragmentShaderID = gl.glCreateShader(gl.GL_FRAGMENT_SHADER)
	local code = versionHeader..[[
precision highp float;
in vec4 colorv;
out vec4 fragColor;
void main() {
	fragColor = colorv;
}
]]
	local len = ffi.new'int[1]'
	len[0] = #code
	local strs = ffi.new'const char*[1]'
	strs[0] = code
	gl.glShaderSource(fragmentShaderID, 1, strs, len)
	gl.glCompileShader(fragmentShaderID)
	local status = ffi.new'GLint[1]'
	gl.glGetShaderiv(fragmentShaderID, gl.GL_COMPILE_STATUS, status)
	print('fragment shader compile status', status[0])
	do
		local result = ffi.new'GLint[1]'
		gl.glGetShaderiv(fragmentShaderID, gl.GL_INFO_LOG_LENGTH, result)
		local length = result[0]
		print('length', length)
		local log = ffi.new('char[?]',length+1)
		local result = ffi.new'GLsizei[1]'
		gl.glGetShaderInfoLog(fragmentShaderID, length, result, log);
		print('double check length', result[0])
		print('log:')
		print(ffi.string(log))
	end

	programID = gl.glCreateProgram()
	gl.glAttachShader(programID, vertexShaderID)
	gl.glAttachShader(programID, fragmentShaderID)
	gl.glLinkProgram(programID)
	gl.glDetachShader(programID, vertexShaderID)
	gl.glDetachShader(programID, fragmentShaderID)
	local status = ffi.new'GLint[1]'
	gl.glGetProgramiv(programID, gl.GL_LINK_STATUS, status)
	print('program link status', status[0])
	do
		local result = ffi.new'GLint[1]'
		gl.glGetProgramiv(programID, gl.GL_INFO_LOG_LENGTH, result)
		local length = result[0]
		print('length', length)
		local log = ffi.new('char[?]',length+1)
		local result = ffi.new'GLsizei[1]'
		gl.glGetProgramInfoLog(programID, length, result, log);
		print('double check length', result[0])
		print('log:')
		print(ffi.string(log))
	end

	local vertexData = ffi.new('float[6]',
		-5, -4,
		5, -4,
		0, 6
	)
	assert.eq(ffi.sizeof(vertexData), 6 * 4)
	do
		local id = ffi.new'GLuint[1]'
		gl.glGenBuffers(1, id)
		vertexBufferID = id[0]
		gl.glBindBuffer(gl.GL_ARRAY_BUFFER, vertexBufferID)
		gl.glBufferData(gl.GL_ARRAY_BUFFER, 6 * 4, vertexData, gl.GL_STATIC_DRAW)
		gl.glBindBuffer(gl.GL_ARRAY_BUFFER, 0)
	end

	local colorData = ffi.new('float[9]',
		1, 0, 0,
		0, 1, 0,
		0, 0, 1
	)
	assert.eq(ffi.sizeof(colorData), 9 * 4)
	do
		local id = ffi.new'GLuint[1]'
		gl.glGenBuffers(1, id)
		colorBufferID = id[0]
		gl.glBindBuffer(gl.GL_ARRAY_BUFFER, colorBufferID)
		gl.glBufferData(gl.GL_ARRAY_BUFFER, 9 * 4, colorData, gl.GL_STATIC_DRAW)
		gl.glBindBuffer(gl.GL_ARRAY_BUFFER, 0)
	end

	vertexAttrLoc = gl.glGetAttribLocation(programID, 'vertex')
	colorAttrLoc = gl.glGetAttribLocation(programID, 'color')

	-- [[ vao or not
	do
		local id = ffi.new'GLuint[1]'
		gl.glGenVertexArrays(1, id)
		vaoID = id[0]
		gl.glBindVertexArray(vaoID)

		gl.glEnableVertexAttribArray(vertexAttrLoc)
		gl.glBindBuffer(gl.GL_ARRAY_BUFFER, vertexBufferID)
		gl.glVertexAttribPointer(vertexAttrLoc, 2, gl.GL_FLOAT, gl.GL_FALSE, 0, ffi.null)
		gl.glBindBuffer(gl.GL_ARRAY_BUFFER, 0)

		gl.glEnableVertexAttribArray(colorAttrLoc)
		gl.glBindBuffer(gl.GL_ARRAY_BUFFER, colorBufferID)
		gl.glVertexAttribPointer(colorAttrLoc, 3, gl.GL_FLOAT, gl.GL_FALSE, 0, ffi.null)
		gl.glBindBuffer(gl.GL_ARRAY_BUFFER, 0)

		gl.glBindVertexArray(0)
	end
	--]]

	mvProjMatUniformLoc = gl.glGetUniformLocation(programID, 'mvProjMat')
	gl.glClearColor(0, 0, 0, 1)
end

function Test:update()
	gl.glClear(gl.GL_COLOR_BUFFER_BIT)

	local aspectRatio = self.width / self.height
	projMat
		:setOrtho(
			-orthoSize * aspectRatio,
			 orthoSize * aspectRatio,
			-orthoSize,
			 orthoSize,
			 znear,
			 zfar
		)
	mvMat:setTranslate(0, 0, -20)

	local t = getTime()
	mvMat:applyRotate(math.rad(t * 30), 0, 1, 0)
	mvProjMat:mul4x4(projMat, mvMat)

	gl.glUseProgram(programID)

	gl.glUniformMatrix4fv(mvProjMatUniformLoc, 1, gl.GL_TRUE, mvProjMat.ptr)

	if vaoID then
		gl.glBindVertexArray(vaoID)
	else
		gl.glEnableVertexAttribArray(vertexAttrLoc)
		gl.glBindBuffer(gl.GL_ARRAY_BUFFER, vertexBufferID)
		gl.glVertexAttribPointer(vertexAttrLoc, 2, gl.GL_FLOAT, gl.GL_FALSE, 0, ffi.null)
		gl.glBindBuffer(gl.GL_ARRAY_BUFFER, 0)

		gl.glEnableVertexAttribArray(colorAttrLoc)
		gl.glBindBuffer(gl.GL_ARRAY_BUFFER, colorBufferID)
		gl.glVertexAttribPointer(colorAttrLoc, 3, gl.GL_FLOAT, gl.GL_FALSE, 0, ffi.null)
		gl.glBindBuffer(gl.GL_ARRAY_BUFFER, 0)
	end

	gl.glDrawArrays(gl.GL_TRIANGLES, 0, 3)

	if vaoID then
		gl.glBindVertexArray(0)
	else
		gl.glDisableVertexAttribArray(vertexAttrLoc)
		gl.glDisableVertexAttribArray(colorAttrLoc)
	end

	gl.glUseProgram(0)
end

return Test():run()
