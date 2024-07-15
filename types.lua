local table = require 'ext.table'
local op = require 'ext.op'
local gl = require 'gl'

local GLTypes = {}

-- used by image and buffer
GLTypes.gltypeForCType = {
	['char'] = gl.GL_UNSIGNED_BYTE,
	['signed char'] = gl.GL_UNSIGNED_BYTE,
	['unsigned char'] = gl.GL_UNSIGNED_BYTE,
	['int8_t'] = gl.GL_UNSIGNED_BYTE,
	['uint8_t'] = gl.GL_UNSIGNED_BYTE,
}

-- inverse of 'gltypeForCType' (which I should rename)
GLTypes.ctypeForGLType = table{
	-- these types are per-channel
	{'GL_UNSIGNED_BYTE', 'uint8_t'},
	{'GL_BYTE', 'int8_t'},
	{'GL_UNSIGNED_SHORT', 'uint16_t'},
	{'GL_SHORT', 'int16_t'},
	{'GL_UNSIGNED_INT', 'uint32_t'},
	{'GL_INT', 'int32_t'},
	{'GL_FLOAT', 'float'},
	-- these types incorporate all channels
	{'GL_HALF_FLOAT', 'uint16_t'},
	{'GL_UNSIGNED_BYTE_3_3_2', 'uint8_t'},
	{'GL_UNSIGNED_BYTE_2_3_3_REV', 'uint8_t'},
	{'GL_UNSIGNED_SHORT_5_6_5', 'uint16_t'},
	{'GL_UNSIGNED_SHORT_5_6_5_REV', 'uint16_t'},
	{'GL_UNSIGNED_SHORT_4_4_4_4', 'uint16_t'},
	{'GL_UNSIGNED_SHORT_4_4_4_4_REV', 'uint16_t'},
	{'GL_UNSIGNED_SHORT_5_5_5_1', 'uint16_t'},
	{'GL_UNSIGNED_SHORT_1_5_5_5_REV', 'uint16_t'},
	{'GL_UNSIGNED_INT_8_8_8_8', 'uint32_t'},
	{'GL_UNSIGNED_INT_8_8_8_8_REV', 'uint32_t'},
	{'GL_UNSIGNED_INT_10_10_10_2', 'uint32_t'},
	{'GL_UNSIGNED_INT_2_10_10_10_REV', 'uint32_t'},
}:mapi(function(p)
	-- some of these are not in GLES so ...
	-- luajit cdata doesn't let you test for existence with a simple nil value
	local k = op.safeindex(gl, p[1])
	if not k then return nil end
	return p[2], k
end):setmetatable(nil)

return GLTypes
