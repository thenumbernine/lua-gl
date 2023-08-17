--[[
there's two ways I can define this structure:
1) as glGetActiveAttrib: name, loc, arraySize, type (glsl type)
2) as glVertexAttribPointer: loc, size (# channels), type (C/glsl base type), normalize, stride, offset
3) combine?
	- derive size #channels and ctype from glslType

hmm, it seems that GLGetActiveAttrib isn't 1-1 with glVertexAttribPointer for a few reasons:

1) glVertexAttribPointer ctype can be:
	byte, unsigned byte, short, unsigned short, int, unsigned int, half, float, double, fixed, etc
while glGetActiveAttrib ctypes assoc with glsltypes are only:
	float, int, unsigned int, double

2) matrix types that have >4 channels need to be assigned with multiple glVertexAttribPointer calls:
	and each call needs a separate loc and a separate glVertexAttribDivisor call?

--]]
local gl = require 'gl'
local GetBehavior = require 'gl.get'
local ffi = require 'ffi'
local class = require 'ext.class'
local table = require 'ext.table'
local op = require 'ext.op'

--[[
GLAttribute has the following args:
	size = number of channels, derived from the glslType
	type =
--]]
local GLAttribute = GetBehavior():subclass()

GLAttribute:makeGetter{
	getter = function(self, namevalue, result)
		return gl.glGetVertexAttribiv(assert(self.loc), namevalue, result)
	end,
	-- the names might say 'ATTRIB_ARRAY', but the input is per-attribute-location
	-- so they are really per-attribute
	-- and the assumption of the name is that you'll only use them via bound VAO
	-- but they work just as well with no VAO bound.
	vars = {
		{name='GL_VERTEX_ATTRIB_ARRAY_BUFFER_BINDING', type='GLuint'},
		{name='GL_VERTEX_ATTRIB_ARRAY_ENABLED', type='GLuint'},
		{name='GL_VERTEX_ATTRIB_ARRAY_SIZE', type='GLuint'},
		{name='GL_VERTEX_ATTRIB_ARRAY_STRIDE', type='GLuint'},
		{name='GL_VERTEX_ATTRIB_ARRAY_TYPE', type='GLuint'},
		{name='GL_VERTEX_ATTRIB_ARRAY_NORMALIZED', type='GLuint'},
		{name='GL_VERTEX_ATTRIB_ARRAY_INTEGER', type='GLuint'},
		{name='GL_VERTEX_ATTRIB_ARRAY_LONG', type='GLuint'},
		{name='GL_VERTEX_ATTRIB_ARRAY_DIVISOR', type='GLuint'},
		{name='GL_VERTEX_ATTRIB_BINDING', type='GLuint'},
		{name='GL_VERTEX_ATTRIB_RELATIVE_OFFSET', type='GLuint'},
		{name='GL_CURRENT_VERTEX_ATTRIB', type='GLuint'},
--GL_CURRENT_VERTEX_ATTRIB	-- this returns four values ...
-- also,  "All of the parameters except GL_CURRENT_VERTEX_ATTRIB represent state stored in the currently bound vertex array object."
-- so GL_CURRENT_VERTEX_ATTRIB	is not a VAO getter variable
-- even though it is used with glGetVertexAttrib
	},
}

-- glVertexAttribPointer types:
-- GL_BYTE, GL_UNSIGNED_BYTE, GL_SHORT, GL_UNSIGNED_SHORT, GL_INT, GL_UNSIGNED_INT
-- GL_HALF_FLOAT, GL_FLOAT, GL_DOUBLE, GL_FIXED, GL_INT_2_10_10_10_REV, GL_UNSIGNED_INT_2_10_10_10_REV, GL_UNSIGNED_INT_10F_11F_11F_REV

-- [[
GLAttribute.getTypeAndSizeForGLSLType = table{
	{'GL_FLOAT',				{'GL_FLOAT',		1,	1}},
	{'GL_FLOAT_VEC2',			{'GL_FLOAT',		2,	1}},
	{'GL_FLOAT_VEC3',			{'GL_FLOAT',		3,	1}},
	{'GL_FLOAT_VEC4',			{'GL_FLOAT',		4,	1}},
	{'GL_FLOAT_MAT2',			{'GL_FLOAT',		2,	2}},
	{'GL_FLOAT_MAT3',			{'GL_FLOAT',		3,	3}},
	{'GL_FLOAT_MAT4',			{'GL_FLOAT',		4,	4}},
	{'GL_FLOAT_MAT2x3',			{'GL_FLOAT',		2,	3}},
	{'GL_FLOAT_MAT2x4',			{'GL_FLOAT',		2,	4}},
	{'GL_FLOAT_MAT3x2',			{'GL_FLOAT',		3,	2}},
	{'GL_FLOAT_MAT3x4',			{'GL_FLOAT',		3,	4}},
	{'GL_FLOAT_MAT4x2',			{'GL_FLOAT',		4,	2}},
	{'GL_FLOAT_MAT4x3',			{'GL_FLOAT',		4,	2}},
	{'GL_INT',					{'GL_INT',			1,	1}},
	{'GL_INT_VEC2',				{'GL_INT',			2,	1}},
	{'GL_INT_VEC3',				{'GL_INT',			3,	1}},
	{'GL_INT_VEC4',				{'GL_INT',			4,	1}},
	{'GL_DOUBLE',				{'GL_DOUBLE',		1,	1}},
	{'GL_DOUBLE_VEC2',			{'GL_DOUBLE',		2,	1}},
	{'GL_DOUBLE_VEC3',			{'GL_DOUBLE',		3,	1}},
	{'GL_DOUBLE_VEC4',			{'GL_DOUBLE',		4,	1}},
	{'GL_DOUBLE_MAT2',			{'GL_DOUBLE',		2,	2}},
	{'GL_DOUBLE_MAT3',			{'GL_DOUBLE',		3,	3}},
	{'GL_DOUBLE_MAT4',			{'GL_DOUBLE',		4,	4}},
	{'GL_DOUBLE_MAT2x3',		{'GL_DOUBLE',		2,	3}},
	{'GL_DOUBLE_MAT2x4',		{'GL_DOUBLE',		2,	4}},
	{'GL_DOUBLE_MAT3x2',		{'GL_DOUBLE',		3,	2}},
	{'GL_DOUBLE_MAT3x4',		{'GL_DOUBLE',		3,	4}},
	{'GL_DOUBLE_MAT4x2',		{'GL_DOUBLE',		4,	2}},
	{'GL_DOUBLE_MAT4x3',		{'GL_DOUBLE',		4,	2}},
	{'GL_UNSIGNED_INT',			{'GL_UNSIGNED_INT',	1,	1}},
	{'GL_UNSIGNED_INT_VEC2',	{'GL_UNSIGNED_INT',	2,	1}},
	{'GL_UNSIGNED_INT_VEC3',	{'GL_UNSIGNED_INT',	3,	1}},
	{'GL_UNSIGNED_INT_VEC4',	{'GL_UNSIGNED_INT',	4,	1}},
	{'GL_BOOL',					{'GL_BOOL',			1,	1}},
	{'GL_BOOL_VEC2',			{'GL_BOOL',	 	 	2,	1}},
	{'GL_BOOL_VEC3',			{'GL_BOOL',	 	 	3,	1}},
	{'GL_BOOL_VEC4',			{'GL_BOOL',	 	 	4,	1}},
}:mapi(function(p)
	-- some of these are not in GLES so ...
	-- luajit cdata doesn't let you test for existence with a simple nil value
	local k = op.safeindex(gl, p[1])
	p[2][1] = op.safeindex(gl, p[2][1])
	if not p[2][1] then return nil end
	if not k then return nil end
	return p[2], k
end):setmetatable(nil)
--]]

--[[
GLAttribute fields:
	arraySize = array size.  3 for "attribute float attr[3];"
	glslType = ex: gl.GL_FLOAT_MAT2x4

	size = (optional) number of elements. 1,2,3,4
	type = (optional) GL_FLOAT, etc.
		if size and type are not defined then they are inferred from glslType

	normalize = flag, true/false.
		initialized to false.
		override in args

	stride = override in args
	type = override in args

	loc = (optional) GLSL attribute location in the shader

	buffer = (optional) buffer bound to this array
		TODO remove this and make GLAttribute specific to GLProgram
		move this to GL draw instance
--]]
function GLAttribute:init(args)
	self.arraySize = args.arraySize
	self.glslType = args.glslType

	self.normalize = args.normalize or false
	self.stride = args.stride or 0
	self.offset = ffi.cast('uint8_t*', args.offset)

	self.size = args.size
	self.type = args.type
	-- size is dimension of the data ... 1,2,3,4
	-- type is GL_FLOAT etc
	-- derive size and type from the glslType
	if self.glslType
	and not (self.type and self.size)
	then
		if (self.type and self.size) and (not self.type or not self.size) then
			error("you specified glslType and either type or size but not both type and size")
		end
		self.type, self.size = table.unpack(self.getTypeAndSizeForGLSLType[self.glslType])
		if not (self.type and self.size) then
			error("failed to deduce type and size from glsl type "..self.glslType)
		end
	end
	if not (self.type and self.size) then
		error("type and size were not both provided")
	end

	-- optionally associated with a shader location
	-- technically, even without any other fields, I can still use GLAttribute:get() with just .loc set ...
	self.loc = args.loc

	-- optionally associate a glArrayBuffer as a field
	-- I'm using this in GLProgram:setAttr
	self.buffer = args.buffer
end

-- assumes the buffer is bound
function GLAttribute:setPointer(loc)
	loc = loc or self.loc
--if loc == -1 then error'here' end
	-- does glVertxAttribPointer associate loc with ptr *globally*
	-- or does it associate this *per-shader* ?
	-- whose state are we messing with?
	-- same question for glEnableVertexAttrib
	gl.glVertexAttribPointer(
		loc,
		self.size,
		self.type,
		self.normalize and gl.GL_TRUE or gl.GL_FALSE,
		self.stride,
		self.offset
	)
	return self
end

-- assumes the buffer is bound
function GLAttribute:enable(loc)
	gl.glEnableVertexAttribArray(loc or self.loc)
	return self
end

function GLAttribute:disable(loc)
	gl.glDisableVertexAttribArray(loc or self.loc)
	return self
end

-- shorthand for binding to the associated buffer, setPointer, and enable
-- TODO hmm this in light of the idea of all binds being manual
function GLAttribute:set(loc)
	if self.buffer then
		self.buffer:bind()
	end
	self:setPointer(loc)
	if self.buffer then
		self.buffer:unbind()
	end
	return self
end

return GLAttribute
