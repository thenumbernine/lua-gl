local ffi = require 'ffi'
local gl = require 'ffi.OpenGL'
local class = require 'ext.class'
local GLShader = require 'gl.shader'

local GLVertexShader = class(GLShader)
GLVertexShader.type = gl.GL_VERTEX_SHADER

local GLFragmentShader = class(GLShader)
GLFragmentShader.type = gl.GL_FRAGMENT_SHADER

local GLProgram = class()
function GLProgram:init(args)
	self.vertexShader = GLVertexShader(args.vertexCode)
	self.fragmentShader = GLFragmentShader(args.fragmentCode)
	self.id = gl.glCreateProgram()
	gl.glAttachShader(self.id, self.vertexShader.id)
	gl.glAttachShader(self.id, self.fragmentShader.id)
	gl.glLinkProgram(self.id)
	
	--[[
	local status = ffi.new('int[1]')
	gl.glGetProgramiv(self.id, gl.GL_COMPILE_STATUS, status)
	if status[0] == gl.GL_FALSE then
		local length = ffi.new('int[1]')
		gl.glGetProgramiv(self.id, gl.GL_INFO_LOG_LENGTH, length)
		local log = ffi.new('char[?]',length[0]+1)
		local result = ffi.new('size_t[1]')
		gl.glGetProgramInfoLog(self.id, length[0], result, log);
		print('log: '..ffi.string(log))
		error(code)
	end
	--]]

	self.attributes = {}
	if args.attributes then
		for _,attr in ipairs(args.attributes) do
			local loc = gl.glGetAttribLocation(self.id, attr)
			if loc < 0 then error("failed to find location of attribute "..tostring(attr)) end
			self.attributes[attr] = loc
		end
	end
	self.uniforms = {}
	if args.uniforms then
		for _,uni in ipairs(args.uniforms) do
			local loc = gl.glGetUniformLocation(self.id, uni)
			if loc < 0 then error("failed to find location of uniform "..tostring(uni)) end
			self.uniforms[uni] = loc
		end
	end
end

function GLProgram:use()
	gl.glUseProgram(self.id)
end

function GLProgram.useNone()
	gl.glUseProgram(0)
end

return GLProgram
