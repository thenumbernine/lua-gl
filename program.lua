local ffi = require 'ffi'
local gl = require 'ffi.OpenGL'
local class = require 'ext.class'
local GLShader = require 'gl.shader'

local GLVertexShader = class(GLShader)
GLVertexShader.type = gl.GL_VERTEX_SHADER

local GLFragmentShader = class(GLShader)
GLFragmentShader.type = gl.GL_FRAGMENT_SHADER

local function getUniformSettersForGLType(utype)
	return assert( ({
		[gl.GL_FLOAT] = {arg=gl.glUniform1f, count=1},
		[gl.GL_INT] = {arg=gl.glUniform1i, count=1},
		[gl.GL_BOOL] = {arg=gl.glUniform1i, count=1},
		[gl.GL_SAMPLER_1D] = {arg=gl.glUniform1i, count=1},
		[gl.GL_SAMPLER_2D] = {arg=gl.glUniform1i, count=1},
		[gl.GL_SAMPLER_3D] = {arg=gl.glUniform1i, count=1},
		[gl.GL_SAMPLER_CUBE] = {arg=gl.glUniform1i, count=1},
		[gl.GL_SAMPLER_1D_SHADOW] = {arg=gl.glUniform1i, count=1},
		[gl.GL_SAMPLER_2D_SHADOW] = {arg=gl.glUniform1i, count=1},
		[gl.GL_FLOAT_VEC2] = {arg=gl.glUniform2f, count=2, vec=gl.glUniform2fv},
		[gl.GL_INT_VEC2] = {arg=gl.glUniform2i, count=2, vec=gl.glUniform2iv},
		[gl.GL_BOOL_VEC2] = {arg=gl.glUniform2i, count=2, vec=gl.glUniform2iv},
		[gl.GL_FLOAT_VEC3] = {arg=gl.glUniform3f, count=3, vec=gl.glUniform3fv},
		[gl.GL_INT_VEC3] = {arg=gl.glUniform3i, count=3, vec=gl.glUniform3iv},
		[gl.GL_BOOL_VEC3] = {arg=gl.glUniform3i, count=3, vec=gl.glUniform3iv},
		[gl.GL_FLOAT_VEC4] = {arg=gl.glUniform4f, count=4, vec=gl.glUniform4fv},
		[gl.GL_INT_VEC4] = {arg=gl.glUniform4i, count=4, vec=gl.glUniform4iv},
		[gl.GL_BOOL_VEC4] = {arg=gl.glUniform4i, count=4, vec=gl.glUniform4iv},
		[gl.GL_FLOAT_MAT2] = {mat=gl.glUniformMatrix2fv},
		[gl.GL_FLOAT_MAT3] = {mat=gl.glUniformMatrix3fv},
		[gl.GL_FLOAT_MAT4] = {mat=gl.glUniformMatrix4fv},
	})[utype], "failed to find getter for type "..utype )
end

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

	self:use()
	
	self.uniforms = {}
	local maxUniforms = ffi.new('GLint[1]', 0)
	gl.glGetProgramiv(self.id, gl.GL_ACTIVE_UNIFORMS, maxUniforms)
	local maxLen = ffi.new('GLint[1]', 0)
	gl.glGetProgramiv(self.id, gl.GL_ACTIVE_UNIFORM_MAX_LENGTH, maxLen)
	for i=1,maxUniforms[0] do
		local bufSize = maxLen[0]+1
		local name = ffi.new('GLchar[?]', bufSize)
		local length = ffi.new('GLsizei[1]', 0)
		ffi.fill(name, bufSize)
		local size = ffi.new('GLint[1]', 0)
		local utype = ffi.new('GLenum[1]', 0)
		gl.glGetActiveUniform(self.id, i-1, bufSize, length, size, utype, name)
		local info = {
			name = ffi.string(name, length[0]),
			size = size[0],
			type = utype[0],
		}
		info.loc = gl.glGetUniformLocation(self.id, info.name)
		info.setters = getUniformSettersForGLType(info.type)
		self.uniforms[i] = info
		self.uniforms[info.name] = info
	end

	self.attrs = {}
	local maxAttrs = ffi.new('GLint[1]', 0)
	gl.glGetProgramiv(self.id, gl.GL_ACTIVE_ATTRIBUTES, maxAttrs)
	local maxLen = ffi.new('GLint[1]', 0)
	gl.glGetProgramiv(self.id, gl.GL_ACTIVE_ATTRIBUTE_MAX_LENGTH, maxLen)
	for i=1,maxAttrs[0] do
		local bufSize = maxLen[0]+1
		local name = ffi.new('GLchar[?]', bufSize)
		local length = ffi.new('GLsizei[1]', 0)
		ffi.fill(name, bufSize)
		local size = ffi.new('GLint[1]', 0)
		local utype = ffi.new('GLenum[1]', 0)
		gl.glGetActiveAttrib(self.id, i-1, bufSize, length, size, utype, name);
		local info = {
			name = ffi.string(name, length[0]),
			size = size[0],
			type = utype[0],
		}
		info.loc = gl.glGetAttribLocation(self.id, info.name)
		self.attrs[info.name] = info
	end
	
	if args.uniforms then
		self:setUniforms(args.uniforms)
	end

	self:useNone()
end

function GLProgram:use()
	gl.glUseProgram(self.id)
end

function GLProgram.useNone()
	gl.glUseProgram(0)
end

function GLProgram:setUniforms(uniforms)
	for k,v in pairs(uniforms) do
		self:setUniform(k, v)
	end
	return self
end

function GLProgram:setUniform(name, value, ...)
	local info = self.uniforms[name]
	if not info then return end
	local isArray = type(value) == 'table'
	local setters = info.setters
	local loc = info.loc
	if not isArray then
		local setter = setters.arg
		if not setter then 
			error("failed to find non-array setter for uniform "..name) 
		end
		setter(loc, value, ...)
	else
		if setters.vec then
			setters.vec(loc, value)
		elseif setters.mat then
			setters.mat(loc, false, value)
		else
			error("failed to find array setter for uniform "..name)
		end
	end
end

return GLProgram
