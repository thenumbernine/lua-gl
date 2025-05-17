require 'ext.gc'	-- make sure luajit can __gc lua-tables
local op = require 'ext.op'
local ffi = require 'ffi'
local gl = require 'gl'
local glreport = require 'gl.report'
local table = require 'ext.table'
local assert = require 'ext.assert'
local showcode = require 'template.showcode'
local GLGet = require 'gl.get'

local GLShader = GLGet.behavior()

function GLShader:delete()
	if self.id == nil then return end
	gl.glDeleteShader(self.id)
	self.id = nil
end

GLShader.__gc = GLShader.delete

local glRetShaderi = GLGet.makeRetLastArg{
	name = 'glGetShaderiv',
	ctype = 'GLint',
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
if 'args' is a string then it is treated as the code.
--]]
function GLShader:init(args)
glreport'GLShader:init'
	local code
	if type(args) == 'string' then
		code = args
	else
		code = assert.index(args, 'code')
		if args.header then
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
			if precision ~= 'best' then
				-- TODO this for each type or whatever options glsl has for precision ...
				code = 'precision '..precision..' float;\n'..code
			else
				local range = ffi.new'GLint[2]'
				local precv = ffi.new'GLint[1]'
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
--DEBUG(gl.shader):print(info.param, range[0], range[1], precv[0])
glreport('glGetShaderPrecisionFormat '..info.name)
							if range[0] > 0 and range[1] > 0
							and (ctype ~= 'float' or precv[0] > 0) 	-- only for floats
							then
--DEBUG(gl.shader):print('setting bestPrec', ctype, info.name)
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

--DEBUG(gl.shader):print()
--DEBUG(gl.shader):print(require'template.showcode'(code))
--DEBUG(gl.shader):print()

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
				s:insert(get.name..': '..table{self:get(get.name)}:mapi(tostring):concat' ')
			end

			s:insert(statusEnum..' failed!')
			error(s:concat'\n')
		end
		return self
	end
end

GLShader.checkCompileStatus = GLShader.createCheckStatus('GL_COMPILE_STATUS', function(...) return gl.glGetShaderInfoLog(...) end)

return GLShader
