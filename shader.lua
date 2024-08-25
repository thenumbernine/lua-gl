require 'ext.gc'	-- make sure luajit can __gc lua-tables
local op = require 'ext.op'
local ffi = require 'ffi'
local gl = require 'gl'
local glreport = require 'gl.report'
local table = require 'ext.table'
local assertindex = require 'ext.assert'.index
local showcode = require 'template.showcode'
local GetBehavior = require 'gl.get'

local GLShader = GetBehavior()

function GLShader:delete()
	if self.id == nil then return end
	gl.glDeleteShader(self.id)
	self.id = nil
end

GLShader.__gc = GLShader.delete

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

--[[
args:
	code
	version = string to use as version number, for inserting preproc #version into the header.
	precision = string to use as float precision, for inserting into the header.
	header = string to append to header.
if 'args' is a string then it is treated as the code.
--]]
function GLShader:init(args)
glreport'GLShader:init'
	local code
	if type(args) == 'string' then
		code = args
	else
		code = assertindex(args, 'code')
		if args.header then
			code = args.header..'\n'..code
		end

		local precision = args.precision
		if precision then
			for _,primTypeInfo in ipairs{
				{ctype='float', low='GL_LOW_FLOAT', medium='GL_MEDIUM_FLOAT', high='GL_HIGH_FLOAT'},
				{ctype='int', low='GL_LOW_INT', medium='GL_MEDIUM_INT', high='GL_HIGH_INT'},
			} do
				local bestPrec
				local ctype = primTypeInfo.ctype
				local lowParam = op.safeindex(gl, primTypeInfo.low)
				local mediumParam = op.safeindex(gl, primTypeInfo.medium)
				local highParam = op.safeindex(gl, primTypeInfo.high)
				if precision == 'best'
				and lowParam
				and mediumParam
				and highParam
				then
					local range = ffi.new'GLint[2]'
					local precv = ffi.new'GLint[1]'
					for _,info in ipairs{
						{name = 'highp', param = highParam},
						{name = 'mediump', param = mediumParam},
						{name = 'lowp', param = lowParam},
						-- TODO int as well?
					} do
						gl.glGetShaderPrecisionFormat(self.type, info.param, range, precv)
glreport('glGetShaderPrecisionFormat '..info.name)
						if range[0] > 0 and range[1] > 0 and precv[0] > 0 then
							bestPrec = info.name
							break
						end
					end
					-- for OSX 2.1 w/exts, glGetShaderPrecisionFormat runs but always raises GL errors
					-- for OSX 4.1 core w/o exts ... glGetShaderPrecisionFormat doesn't exist ...
					-- sooo whoever is over there at Apple, take your Safari team and introduce them to your GLES team,
					-- cuz this all works perfectly fine when emulated via WebGL2 in Safari
					--assert(precision ~= 'best', "somehow I couldn't find any valid precisions")
				end
				-- if precision == 'best' then we were asked to find the best but only found that the glGetShaderPrecisionFormat function doesn't work. *cough* OSX *cough*.
				if bestPrec  then
					code = 'precision '..bestPrec..' '..ctype..';\n'..code
				end
			end
		end

		local version = args.version
		if version then
			if version == 'latest' then
				code = require 'gl.program'.getVersionPragma()..'\n'..code
			elseif version == 'latest es' then
				code = require 'gl.program'.getVersionPragma(true)..'\n'..code
			else
				code = '#version '..version..'\n'..code
			end
		end
	end

	self.id = gl.glCreateShader(self.type)

	if gl.glGetError() == gl.GL_INVALID_ENUM then
		error('the shader type '..('0x%x'):format(self.type)..' is not supported')
	end

	local len = ffi.new'int[1]'
	len[0] = #code
	local strs = ffi.new'const char*[1]'
	strs[0] = code
	gl.glShaderSource(self.id, 1, strs, len)

	self:compile()
	self:checkCompileStatus(code)
end

function GLShader:compile()
	gl.glCompileShader(self.id)
	return self
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
		return self
	end
end

GLShader.checkCompileStatus = GLShader.createCheckStatus('GL_COMPILE_STATUS', function(...) return gl.glGetShaderInfoLog(...) end)

return GLShader
