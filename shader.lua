local ffi = require 'ffi'
local gl = require 'gl'
local class = require 'ext.class'
local showcode = require 'template.showcode'
local GetBehavior = require 'gl.get'
local GCWrapper = require 'ffi.gcwrapper.gcwrapper'

local GLShader = class(GetBehavior(
	GCWrapper{
		gctype = 'autorelease_gl_shader_ptr_t',
		ctype = 'GLuint',
		release = function(ptr)
			-- detach first?
			return gl.glDeleteShader(ptr[0])
		end,
	}
))

GLShader:addGetterVars{
	-- wrap it so wgl can replace glGetShaderiv
	getter = function(...)
		return gl.glGetShaderiv(...)
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
function GLShader.createCheckStatus(statusEnum, logGetter)
	return function(self, code)
		local status = self:get(statusEnum)
		if status == gl.GL_FALSE then
			local length = self:get'GL_INFO_LOG_LENGTH'
			local log = ffi.new('char[?]',length+1)
			local result = ffi.new'GLsizei[1]'
			logGetter(self.id, length, result, log);
			if code then
				print(showcode(code))
			end
			print'log:'
			print(ffi.string(log))
	
			for _,get in ipairs(self.getInfo) do
				print(get.name..': '..self:get(get.name))
			end
			
			error(statusEnum..' failed!')
		end 
	end
end

GLShader.checkCompileStatus = GLShader.createCheckStatus('GL_COMPILE_STATUS', function(...) return gl.glGetShaderInfoLog(...) end)

return GLShader
