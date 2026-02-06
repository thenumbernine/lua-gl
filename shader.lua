require 'ext.gc'	-- make sure luajit can __gc lua-tables
local op = require 'ext.op'
local ffi = require 'ffi'
local gl = require 'gl'
local string = require 'ext.string'
local table = require 'ext.table'
local assert = require 'ext.assert'
local showcode = require 'template.showcode'
local GLGet = require 'gl.get'


local GLchar_arr = ffi.typeof'GLchar[?]'
local char_const_p_1 = ffi.typeof'char const*[1]'
local GLint = ffi.typeof'GLint'
local GLint_1 = ffi.typeof'GLint[1]'
local GLint_2 = ffi.typeof'GLint[2]'
local GLsizei_1 = ffi.typeof'GLsizei[1]'
local GLuint_1 = ffi.typeof'GLuint[1]'


local GLShader = GLGet.behavior()

function GLShader:delete()
	if self.id == nil then return end
	gl.glDeleteShader(self.id)
	self.id = nil
end

GLShader.__gc = GLShader.delete

local glRetShaderi = GLGet.makeRetLastArg{
	name = 'glGetShaderiv',
	ctype = GLint,
	lookup = {2},
}
GLShader:makeGetter{
	-- wrap it so wgl can replace glGetShaderiv
	getter = function(self, nameValue)
		return glRetShaderi(self.id, nameValue)
	end,
	vars = {
		{name='GL_SHADER_TYPE'},
		{name='GL_DELETE_STATUS'},
		{name='GL_COMPILE_STATUS'},
		{name='GL_INFO_LOG_LENGTH'},
		{name='GL_SHADER_SOURCE_LENGTH'},
	},
}

--[[
args:
	code
	version = string to use as version number, for inserting preproc #version into the header.
	precision = string to use as float precision, for inserting into the header.
	header = string to append to header.
	binary = (optional) set to use glShaderBinary
	binaryFormat = (optional) also used with glShaderBinary
if 'args' is a string then it is treated as the code.
--]]
function GLShader:init(args)
	args = args or {}
	local code
	if type(args) == 'string' then
		code = args
	else
		code = args.code
		if args.header then
			assert(code, "need args.code with args.header")
			code = args.header..'\n'..code
		end

		local precision = args.precision
		if precision

		-- Geometry shader doesn't like querying the precision? It is giving me GL_INVALID_ENUM
		-- TODO I wonder what shaders I can query precision vs what I can't?
		and (
			self.type == gl.GL_VERTEX_SHADER
			or self.type == gl.GL_FRAGMENT_SHADER
		)

		then
			assert(code, "need args.code with args.precision")
			if precision ~= 'best' then
				-- TODO this for each type or whatever options glsl has for precision ...
				code = 'precision '..precision..' float;\n'..code
			else
				local range = GLint_2()
				local precv = GLint_1()
				for _,primTypeInfo in ipairs{
					{ctype='float', low='GL_LOW_FLOAT', medium='GL_MEDIUM_FLOAT', high='GL_HIGH_FLOAT'},
					{ctype='int', low='GL_LOW_INT', medium='GL_MEDIUM_INT', high='GL_HIGH_INT'},
				} do
					local bestPrec
					local ctype = primTypeInfo.ctype
					local lowParam = primTypeInfo.low
					local mediumParam = primTypeInfo.medium
					local highParam = primTypeInfo.high
					for _,info in ipairs{
						{name = 'highp', param = highParam},
						{name = 'mediump', param = mediumParam},
						{name = 'lowp', param = lowParam},
						-- TODO int as well?
					} do
						local paramValue = op.safeindex(gl, info.param)
						if paramValue then
							gl.glGetShaderPrecisionFormat(self.type, paramValue, range, precv)
--DEBUG:print(info.param, range[0], range[1], precv[0])
							if range[0] > 0 and range[1] > 0
							and (ctype ~= 'float' or precv[0] > 0) 	-- only for floats
							then
--DEBUG:print('setting bestPrec', ctype, info.name)
								bestPrec = info.name
								break
							end
						end
					end
					-- for OSX 2.1 w/exts, glGetShaderPrecisionFormat runs but always raises GL errors
					-- for OSX 4.1 core w/o exts ... glGetShaderPrecisionFormat doesn't exist ...
					-- sooo whoever is over there at Apple, take your Safari team and introduce them to your GLES team,
					-- cuz this all works perfectly fine when emulated via WebGL2 in Safari
					--assert(bestPrec, "somehow I couldn't find any valid precisions")
					-- not bestPrec then we were asked to find the best but only found that the glGetShaderPrecisionFormat function doesn't work. *cough* OSX *cough*.
					if bestPrec  then
						code = 'precision '..bestPrec..' '..ctype..';\n'..code
					end
				end
			end
		end

		local version = args.version
		if version then
			assert(code, "need args.code with args.version")
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

--DEBUG:print()
--DEBUG:print(require'template.showcode'(code))
--DEBUG:print()

	if code then
		local len = GLint_1(#code)
		local strs = char_const_p_1()
		strs[0] = code	-- doesn't work in ffi.new('char const*[1]')s ctor?
		gl.glShaderSource(self.id, 1, strs, len)
		self:compile()
		self:checkCompileStatus(code)
	elseif args.binary then
		local binary = assert.type(args.binary, 'string', 'args.binary')
		local ids = GLuint_1(self.id)
		gl.glShaderBinary(
			1,
			ids,
			args.binaryFormat,
			binary,
			#binary
		)

		-- plain-gl has and requires glSpecializeShader to be called in 4.6 prior to linking
		-- but gles>=2 has glShaderBinary but doesn't have glSpecializeShader
		if op.safeindex(gl, 'glSpecializeShader') then
			gl.glSpecializeShader(
				self.id,
				args.binaryEntry or 'main',	--const GLchar *pEntryPoint,
				0,		--GLuint numSpecializationConstants,
				nil,	--const GLuint *pConstantIndex,
				nil		--const GLuint *pConstantValue
			)
		end
		-- no need to compile, in fact it gives an invalid operation
		self:checkCompileStatus()
	else
		-- no .code or .binary?  just let them make an empty glCreateShader()
	end
end

function GLShader:compile()
	gl.glCompileShader(self.id)
	return self
end

-- used by GLShader and GLProgram
-- TODO return false w/error? and separate 'assert' function? like FBO has for check()
-- or meh, need case for that yet?
function GLShader.createCheckStatus(statusEnum, logGetter)
	return function(self, code, warnOnly)
		local status = self:get(statusEnum)
		if status == gl.GL_TRUE then
			-- on success, return self
			return self
		end

		local length = self:get'GL_INFO_LOG_LENGTH'
		local log = GLchar_arr(length+1)
		local result = GLsizei_1()
		logGetter(self.id, length, result, log);
		local s = table()
		if code then
			s:insert(showcode(code))
		end
		s:insert('log:')
		log = string.trim(ffi.string(log))
		if log ~= '' then
			s:insert(log)
		end

		for _,get in ipairs(self.getInfo) do
			s:insert(get.name..': '..table{self:get(get.name)}:mapi(tostring):concat' ')
		end

		s:insert(statusEnum..' failed!')
		if warnOnly then
			io.stderr:write('\n'..s:concat'\n'..'\n')
		else
			error('\n'..s:concat'\n')
		end
		-- on fail, return empty
	end
end

GLShader.checkCompileStatus = GLShader.createCheckStatus('GL_COMPILE_STATUS', function(...) return gl.glGetShaderInfoLog(...) end)

return GLShader
