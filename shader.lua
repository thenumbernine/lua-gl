local ffi = require 'ffi'
local gl = require 'gl'
local table = require 'ext.table'
local showcode = require 'template.showcode'
local GetBehavior = require 'gl.get'
local GCWrapper = require 'ffi.gcwrapper.gcwrapper'

local GLShader = GetBehavior(GCWrapper{
	gctype = 'autorelease_gl_shader_ptr_t',
	ctype = 'GLuint',
	release = function(ptr)
		return gl.glDeleteShader(ptr[0])
	end,
}):subclass()

GLShader:makeGetter{
	-- wrap it so wgl can replace glGetShaderiv
	getter = function(self, namevalue, result)
		return gl.glGetShaderiv(self.id, namevalue, result)
	end,
	vars = {
		{name='GL_SHADER_TYPE', type='GLint'},
		{name='GL_DELETE_STATUS', type='GLint'},
		{name='GL_COMPILE_STATUS', type='GLint'},
		{name='GL_INFO_LOG_LENGTH', type='GLint'},
		{name='GL_SHADER_SOURCE_LENGTH', type='GLint'},
	},
}

function GLShader:init(code)
	self.id = gl.glCreateShader(self.type)
	GLShader.super.init(self, self.id)

	if gl.glGetError() == gl.GL_INVALID_ENUM then
		error('the shader type '..('0x%x'):format(self.type)..' is not supported')
	end

	local len = ffi.new'int[1]'
	len[0] = #code
	local strs = ffi.new'const char*[1]'
	strs[0] = code
	gl.glShaderSource(self.id, 1, strs, len)
	gl.glCompileShader(self.id)

	self:checkCompileStatus(code)
end

-- used by GLShader and GLProgram
-- TODO return false w/error? and separate 'assert' function? like FBO has for check()
-- or meh, need case for that yet?
function GLShader.createCheckStatus(statusEnum, logGetter)
	return function(self, code)
		local status = self:get(statusEnum)
		if status == gl.GL_FALSE then
			local length = self:get'GL_INFO_LOG_LENGTH'
			local log = ffi.new('char[?]',length+1)
			local result = ffi.new'GLsizei[1]'
			logGetter(self.id, length, result, log);
			local s = table()
			if code then
				s:insert(showcode(code))
			end
			s:insert('log:')
			s:insert(ffi.string(log))

			for _,get in ipairs(self.getInfo) do
				s:insert(get.name..': '..self:get(get.name))
			end

			s:insert(statusEnum..' failed!')
			error(s:concat'\n')
		end
	end
end

GLShader.checkCompileStatus = GLShader.createCheckStatus('GL_COMPILE_STATUS', function(...) return gl.glGetShaderInfoLog(...) end)

return GLShader
