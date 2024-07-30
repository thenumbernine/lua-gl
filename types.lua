local table = require 'ext.table'
local op = require 'ext.op'
local gl = require 'gl'

local GLTypes = {}

-- used by image and buffer
GLTypes.gltypeForCType = table{
	char = 'GL_UNSIGNED_BYTE',
	['signed char'] = 'GL_UNSIGNED_BYTE',
	['unsigned char'] = 'GL_UNSIGNED_BYTE',
	int8_t = 'GL_UNSIGNED_BYTE',
	uint8_t = 'GL_UNSIGNED_BYTE',

	short = 'GL_SHORT',
	['signed short'] = 'GL_SHORT',
	['unsigned short'] = 'GL_UNSIGNED_SHORT',
	int16_t = 'GL_SHORT',
	uint16_t = 'GL_UNSIGNED_SHORT',

	int = 'GL_INT',
	['signed int'] = 'GL_INT',
	['unsigned int'] = 'GL_UNSIGNED_INT',
	int32_t = 'GL_INT',
	uint32_t = 'GL_UNSIGNED_INT',

	float = 'GL_FLOAT',
	double = 'GL_DOUBLE',

	-- TODO what sort of ctype to associate with half?
}:map(function(glEnumName, ctype)
	local glEnum = op.safeindex(gl, glEnumName)
	if not glEnum then return end
	return glEnum, ctype
end):setmetatable(nil)

-- inverse of 'gltypeForCType' (which I should rename)
GLTypes.ctypeForGLType = table{
	-- these types are per-channel
	GL_UNSIGNED_BYTE = 'uint8_t',
	GL_BYTE = 'int8_t',
	GL_UNSIGNED_SHORT = 'uint16_t',
	GL_SHORT = 'int16_t',
	GL_UNSIGNED_INT = 'uint32_t',
	GL_INT = 'int32_t',
	GL_FLOAT = 'float',
	-- these types incorporate all channels
	-- TODO move this functionality back to GLTex and give more info on what channel maps where
	GL_HALF_FLOAT = 'uint16_t',
	GL_UNSIGNED_BYTE_3_3_2 = 'uint8_t',
	GL_UNSIGNED_BYTE_2_3_3_REV = 'uint8_t',
	GL_UNSIGNED_SHORT_5_6_5 = 'uint16_t',
	GL_UNSIGNED_SHORT_5_6_5_REV = 'uint16_t',
	GL_UNSIGNED_SHORT_4_4_4_4 = 'uint16_t',
	GL_UNSIGNED_SHORT_4_4_4_4_REV = 'uint16_t',
	GL_UNSIGNED_SHORT_5_5_5_1 = 'uint16_t',
	GL_UNSIGNED_SHORT_1_5_5_5_REV = 'uint16_t',
	GL_UNSIGNED_INT_8_8_8_8 = 'uint32_t',
	GL_UNSIGNED_INT_8_8_8_8_REV = 'uint32_t',
	GL_UNSIGNED_INT_10_10_10_2 = 'uint32_t',
	GL_UNSIGNED_INT_2_10_10_10_REV = 'uint32_t',
}:map(function(v,k)
	-- some of these are not in GLES so ...
	-- luajit cdata doesn't let you test for existence with a simple nil value
	k = op.safeindex(gl, k)
	if not k then return end
	return v, k
end):setmetatable(nil)

return GLTypes
