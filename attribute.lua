--[[
there's two ways I can define this structure:
1) as glGetActiveAttrib: name, loc, arraySize, type (glsl type)
2) as glVertexAttribPointer: loc, size (# channels), type (C/glsl base type), normalize, stride, offset
3) combine? 
	- derive size #channels and ctype from glsltype

hmm, it seems that GLGetActiveAttrib isn't 1-1 with glVertexAttribPointer for a few reasons:

1) glVertexAttribPointer ctype can be:
	byte, unsigned byte, short, unsigned short, int, unsigned int, half, float, double, fixed, etc
while glGetActiveAttrib ctypes assoc with glsltypes are only:
	float, int, unsigned int, double

2) matrix types that have >4 channels need to be assigned with multiple glVertexAttribPointer calls:
	and each call needs a separate loc and a separate glVertexAttribDivisor call?

--]]
local gl = require 'gl'
local ffi = require 'ffi'
local class = require 'ext.class'

--[[
Attribute has the following args:
	size = number of channels, derived from the glsltype
	type = 
--]]
local Attribute = class()

-- glVertexAttribPointer types:
-- GL_BYTE, GL_UNSIGNED_BYTE, GL_SHORT, GL_UNSIGNED_SHORT, GL_INT, GL_UNSIGNED_INT
-- GL_HALF_FLOAT, GL_FLOAT, GL_DOUBLE, GL_FIXED, GL_INT_2_10_10_10_REV, GL_UNSIGNED_INT_2_10_10_10_REV, GL_UNSIGNED_INT_10F_11F_11F_REV

-- [[
Attribute.getTypeAndSizeForGLSLType = {
	[gl.GL_FLOAT] 				= {gl.GL_FLOAT,			1,	1},
	[gl.GL_FLOAT_VEC2] 			= {gl.GL_FLOAT,			2,	1},
	[gl.GL_FLOAT_VEC3] 			= {gl.GL_FLOAT,			3,	1},
	[gl.GL_FLOAT_VEC4] 			= {gl.GL_FLOAT,			4,	1},
	[gl.GL_FLOAT_MAT2] 			= {gl.GL_FLOAT,			2,	2},
	[gl.GL_FLOAT_MAT3] 			= {gl.GL_FLOAT,			3,	3},
	[gl.GL_FLOAT_MAT4] 			= {gl.GL_FLOAT,			4,	4},
	[gl.GL_FLOAT_MAT2x3] 		= {gl.GL_FLOAT,			2,	3},
	[gl.GL_FLOAT_MAT2x4] 		= {gl.GL_FLOAT,			2,	4},
	[gl.GL_FLOAT_MAT3x2] 		= {gl.GL_FLOAT,			3,	2},
	[gl.GL_FLOAT_MAT3x4] 		= {gl.GL_FLOAT,			3,	4},
	[gl.GL_FLOAT_MAT4x2] 		= {gl.GL_FLOAT,			4,	2},
	[gl.GL_FLOAT_MAT4x3] 		= {gl.GL_FLOAT,			4,	2},
	[gl.GL_INT] 				= {gl.GL_INT,			1,	1},
	[gl.GL_INT_VEC2] 			= {gl.GL_INT,			2,	1},
	[gl.GL_INT_VEC3] 			= {gl.GL_INT,			3,	1},
	[gl.GL_INT_VEC4] 			= {gl.GL_INT,			4,	1},
--	[gl.GL_DOUBLE] 				= {gl.GL_DOUBLE,		1,	1},
--	[gl.GL_DOUBLE_VEC2] 		= {gl.GL_DOUBLE,		2,	1},
--	[gl.GL_DOUBLE_VEC3] 		= {gl.GL_DOUBLE,		3,	1},
--	[gl.GL_DOUBLE_VEC4] 		= {gl.GL_DOUBLE,		4,	1},
--	[gl.GL_DOUBLE_MAT2] 		= {gl.GL_DOUBLE,		2,	2},
--	[gl.GL_DOUBLE_MAT3] 		= {gl.GL_DOUBLE,		3,	3},
--	[gl.GL_DOUBLE_MAT4] 		= {gl.GL_DOUBLE,		4,	4},
--	[gl.GL_DOUBLE_MAT2x3] 		= {gl.GL_DOUBLE,		2,	3},
--	[gl.GL_DOUBLE_MAT2x4] 		= {gl.GL_DOUBLE,		2,	4},
--	[gl.GL_DOUBLE_MAT3x2] 		= {gl.GL_DOUBLE,		3,	2},
--	[gl.GL_DOUBLE_MAT3x4] 		= {gl.GL_DOUBLE,		3,	4},
--	[gl.GL_DOUBLE_MAT4x2] 		= {gl.GL_DOUBLE,		4,	2},
--	[gl.GL_DOUBLE_MAT4x3] 		= {gl.GL_DOUBLE,		4,	2},
--	[gl.GL_UNSIGNED_INT] 		= {gl.GL_UNSIGNED_INT,	1,	1},
--	[gl.GL_UNSIGNED_INT_VEC2] 	= {gl.GL_UNSIGNED_INT,	2,	1},
--	[gl.GL_UNSIGNED_INT_VEC3] 	= {gl.GL_UNSIGNED_INT,	3,	1},
--	[gl.GL_UNSIGNED_INT_VEC4] 	= {gl.GL_UNSIGNED_INT,	4,	1},
--	[gl.GL_BOOL] 				= {gl.GL_BOOL,			1,	1},
--	[gl.GL_BOOL_VEC2] 	 	 	= {gl.GL_BOOL,	 	 	2,	1},
--	[gl.GL_BOOL_VEC3] 	 	 	= {gl.GL_BOOL,	 	 	3,	1},
--	[gl.GL_BOOL_VEC4] 	 	 	= {gl.GL_BOOL,	 	 	4,	1},
}
--]]

function Attribute:init(args)
--[[ these are GLProgram.attrs[i] properties:
	self.arraySize = args.arraySize
	self.glsltype = args.glsltype
--]]

	self.normalize = args.normalize or false
	self.stride = args.stride or 0
	self.offset = ffi.cast('uint8_t*', args.offset)

--[[ derive size and type from the glsltype
	assert(not args.size)
	assert(not args.type)
	-- size is dimension of the data ... 1,2,3,4
	-- type is GL_FLOAT etc	
	self.type, self.size = table.unpack(getTypeAndSizeForGLSLType[self.glsltype])
--]]
-- [[ maybe not, because GetVertexAttrib and VertexAttribPointer aren't 1-1
	self.size = assert(args.size)
	self.type = assert(args.type)
--]]

	-- optionally associated with a shader location
	self.loc = args.loc

	-- optionally associate a glArrayBuffer as a field
	-- I'm using this in GLProgram:setAttr
	self.buffer = args.buffer
end

-- assumes the buffer is bound
function Attribute:setPointer(loc)
	gl.glVertexAttribPointer(
		loc or self.loc,
		self.size,
		self.type,
		self.normalize and gl.GL_TRUE or gl.GL_FALSE,
		self.stride,
		self.offset
	)
end

-- assumes the buffer is bound
function Attribute:enable(loc)
	gl.glEnableVertexAttribArray(loc or self.loc)
end

function Attribute:disable(loc)
	gl.glDisableVertexAttribArray(loc or self.loc)
end

-- shorthand for binding to the associated buffer, setPointer, and enable
function Attribute:set(loc)
	if self.buffer then self.buffer:bind() end
	self:setPointer(loc)
	self:enable(loc)
	if self.buffer then self.buffer:unbind() end
end

return Attribute 
