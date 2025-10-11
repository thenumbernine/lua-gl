local ffi = require 'ffi'
local table = require 'ext.table'
local op = require 'ext.op'
local gl = require 'gl'


local char = ffi.typeof'char'
local signed_char = ffi.typeof'signed char'
local unsigned_char = ffi.typeof'unsigned char'
local int8_t = ffi.typeof'int8_t'
local uint8_t = ffi.typeof'uint8_t'

local short = ffi.typeof'short'
local signed_short = ffi.typeof'signed short'
local unsigned_short = ffi.typeof'unsigned short'
local int16_t = ffi.typeof'int16_t'
local uint16_t = ffi.typeof'uint16_t'

local int = ffi.typeof'int'
local signed_int = ffi.typeof'signed int'
local unsigned_int = ffi.typeof'unsigned int'
local int32_t = ffi.typeof'int32_t'
local uint32_t = ffi.typeof'uint32_t'

local float = ffi.typeof'float'
local double = ffi.typeof'double'


local GLTypes = {}

-- used by image and buffer
GLTypes.gltypeForCType = table{
	[tostring(char)] = 'GL_UNSIGNED_BYTE',
	[tostring(signed_char)] = 'GL_UNSIGNED_BYTE',
	[tostring(unsigned_char)] = 'GL_UNSIGNED_BYTE',
	[tostring(int8_t)] = 'GL_UNSIGNED_BYTE',
	[tostring(uint8_t)] = 'GL_UNSIGNED_BYTE',

	[tostring(short)] = 'GL_SHORT',
	[tostring(signed_short)] = 'GL_SHORT',
	[tostring(unsigned_short)] = 'GL_UNSIGNED_SHORT',
	[tostring(int16_t)] = 'GL_SHORT',
	[tostring(uint16_t)] = 'GL_UNSIGNED_SHORT',

	[tostring(int)] = 'GL_INT',
	[tostring(signed_int)] = 'GL_INT',
	[tostring(unsigned_int)] = 'GL_UNSIGNED_INT',
	[tostring(int32_t)] = 'GL_INT',
	[tostring(uint32_t)] = 'GL_UNSIGNED_INT',

	[tostring(float)] = 'GL_FLOAT',
	[tostring(double)] = 'GL_DOUBLE',

	-- TODO what sort of ctype to associate with half?
}:map(function(glEnumName, ctype)
	local glEnum = op.safeindex(gl, glEnumName)
	if not glEnum then return end
	return glEnum, ctype
end):setmetatable(nil)

-- inverse of 'gltypeForCType' (which I should rename)
-- TODO use GLTex.formatInfos
GLTypes.ctypeForGLType = table{
	-- these types are per-channel
	GL_UNSIGNED_BYTE = uint8_t,
	GL_BYTE = int8_t,
	GL_UNSIGNED_SHORT = uint16_t,
	GL_SHORT = int16_t,
	GL_UNSIGNED_INT = uint32_t,
	GL_INT = int32_t,
	GL_FLOAT = float,
	-- these types incorporate all channels
	-- TODO move this functionality back to GLTex and give more info on what channel maps where
	GL_HALF_FLOAT = uint16_t,
	GL_UNSIGNED_BYTE_3_3_2 = uint8_t,
	GL_UNSIGNED_BYTE_2_3_3_REV = uint8_t,
	GL_UNSIGNED_SHORT_5_6_5 = uint16_t,
	GL_UNSIGNED_SHORT_5_6_5_REV = uint16_t,
	GL_UNSIGNED_SHORT_4_4_4_4 = uint16_t,
	GL_UNSIGNED_SHORT_4_4_4_4_REV = uint16_t,
	GL_UNSIGNED_SHORT_5_5_5_1 = uint16_t,
	GL_UNSIGNED_SHORT_1_5_5_5_REV = uint16_t,
	GL_UNSIGNED_INT_8_8_8_8 = uint32_t,
	GL_UNSIGNED_INT_8_8_8_8_REV = uint32_t,
	GL_UNSIGNED_INT_10_10_10_2 = uint32_t,
	GL_UNSIGNED_INT_2_10_10_10_REV = uint32_t,
}:map(function(v,k)
	-- some of these are not in GLES so ...
	-- luajit cdata doesn't let you test for existence with a simple nil value
	k = op.safeindex(gl, k)
	if not k then return end
	return v, k
end):setmetatable(nil)

return GLTypes
