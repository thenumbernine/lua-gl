--[[
there's two ways I can define this structure:
1) as glGetActiveAttrib: name, loc, arraySize, type (glsl type)
2) as glVertexAttribPointer: loc, dim (# channels), type (C/glsl base type), normalize, stride, offset
3) combine?
	- derive dim #channels and ctype from glslType

hmm, it seems that GLGetActiveAttrib isn't 1-1 with glVertexAttribPointer for a few reasons:

1) glVertexAttribPointer ctype can be:
	byte, unsigned byte, short, unsigned short, int, unsigned int, half, float, double, fixed, etc
while glGetActiveAttrib ctypes assoc with glsltypes are only:
	float, int, unsigned int, double

2) matrix types that have >4 channels need to be assigned with multiple glVertexAttribPointer calls:
	and each call needs a separate loc and a separate glVertexAttribDivisor call?

TODO
make this more like the gl-util version?
just a holder for buffer, dim, type, normalize, stride, offset
(the contents of glVertexAttribPointer)
- and then have an optional construction from within gl.program for builtin queried attributes?
--]]
local gl = require 'gl'
local GLGet = require 'gl.get'
local ffi = require 'ffi'
local class = require 'ext.class'
local table = require 'ext.table'
local op = require 'ext.op'

--[[
GLAttribute has the following args:
	dim = number of channels, derived from the glslType
	type =
--]]
local GLAttribute = GLGet.behavior():subclass()

local glRetVertexAttribi = GLGet.makeRetLastArg{
	name = 'glGetVertexAttribiv',
	ctype = ffi.typeof'GLint',
	lookup = {2},
}
GLAttribute:makeGetter{
	getter = function(self, nameValue)
		return glRetVertexAttribi(self.loc, nameValue)
	end,
	-- the names might say 'ATTRIB_ARRAY', but the input is per-attribute-location
	-- so they are really per-attribute
	-- and the assumption of the name is that you'll only use them via bound VAO
	-- but they work just as well with no VAO bound.
	vars = {
		{name='GL_VERTEX_ATTRIB_ARRAY_BUFFER_BINDING'},
		{name='GL_VERTEX_ATTRIB_ARRAY_ENABLED'},
		{name='GL_VERTEX_ATTRIB_ARRAY_SIZE'},
		{name='GL_VERTEX_ATTRIB_ARRAY_STRIDE'},
		{name='GL_VERTEX_ATTRIB_ARRAY_TYPE'},
		{name='GL_VERTEX_ATTRIB_ARRAY_NORMALIZED'},
		{name='GL_VERTEX_ATTRIB_ARRAY_INTEGER'},
		{name='GL_VERTEX_ATTRIB_ARRAY_LONG'},
		{name='GL_VERTEX_ATTRIB_ARRAY_DIVISOR'},
		{name='GL_VERTEX_ATTRIB_BINDING'},
		{name='GL_VERTEX_ATTRIB_RELATIVE_OFFSET'},
		{name='GL_CURRENT_VERTEX_ATTRIB'},
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
GLAttribute.getGLTypeAndDimForGLSLType = table{
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

	name

	buffer = (optional) buffer bound to this array

	dim = number of elements. 1,2,3,4
	type = GL_FLOAT, etc.
		specifies the CPU-side data type
		if dim and type are not defined then they are inferred from glslType

	normalize = flag, true/false.
		initialized to false.
		override in args

	stride = override in args

	offset = offset for buffers, vs CPU pointers for non-buffer attributes.

	divisor = (optional) divisor associated with this vertex attribute.

- properties specific to GLAttribute's within GLProgram .attrs[]

	loc = (optional) GLSL attribute location in the shader

	glslType = (optional) ex: gl.GL_FLOAT_MAT2x4
		specifies the GPU-side data type
		gathered from a GLProgram
		use this to set both the type and dim simultaneously

	arraySize = array size.  3 for "attribute float attr[3];"

TODO make a subclass of this specific to GLProgram queried attributes.
	it will hold .loc, .arraySize, .glslType
--]]
function GLAttribute:init(args)
	self.name = args.name

	self.dim = args.dim
	self.type = args.type

	self.normalize = args.normalize or false
	self.stride = args.stride or 0
	self.offset = ffi.cast('uint8_t*', args.offset)

	self.divisor = args.divisor

	self.glslType = args.glslType
	-- dim is dimension of the data ... 1,2,3,4
	-- type is GL_FLOAT etc
	-- derive dim and type from the glslType
	if self.glslType
	and not (self.type and self.dim)
	then
		if (self.type and self.dim) and (not self.type or not self.dim) then
			error("you specified glslType and either type or dim but not both type and dim")
		end
		self.type, self.dim = table.unpack(self.getGLTypeAndDimForGLSLType[self.glslType]
			or error('missing getGLTypeAndDimForGLSLType['..self.glslType..']')
		)
		if not (self.type and self.dim) then
			error("failed to deduce type and dim from glsl type "..self.glslType)
		end
	end
	if not (self.type and self.dim) then
		error("type and dim were not both provided")
	end

	-- optionally for GLProgram attributes
	-- associate with a shader location
	-- technically, even without any other fields, I can still use GLAttribute:get() with just .loc set ...
	self.loc = args.loc

	-- optional for GLProgram attributes
	self.arraySize = args.arraySize

	-- optionally associate a glArrayBuffer as a field
	-- I'm using this in GLProgram:setAttr and GLVertexArray:setAttr
	self.buffer = args.buffer
end

-- assumes the buffer is bound
local GL_DOUBLE = op.safeindex(gl, 'GL_DOUBLE')
function GLAttribute:setPointer(loc)
	loc = loc or self.loc
--[[
TODO add an option for glVertexAttribIPointer
but how to determine which to use?
if self.type specifies the CPU-side data, should self.glslType store the GPU-side data?
and would we want separate variables for the underlying storage (float vs int) versus the dimension storage (vec3 vs ivec3) ?

https://registry.khronos.org/OpenGL-Refpages/gl4/html/glVertexAttribPointer.xhtml
https://registry.khronos.org/OpenGL-Refpages/es3.0/html/glVertexAttribPointer.xhtml
"type - Specifies the data type of each component in the array. The symbolic constants GL_BYTE, GL_UNSIGNED_BYTE, GL_SHORT, GL_UNSIGNED_SHORT, GL_INT, and GL_UNSIGNED_INT are accepted by glVertexAttribPointer and glVertexAttribIPointer."
"For glVertexAttribIPointer, only the integer types GL_BYTE, GL_UNSIGNED_BYTE, GL_SHORT, GL_UNSIGNED_SHORT, GL_INT, GL_UNSIGNED_INT are accepted."
The docs make it sound like integer types work in the original function call as well, so why have a separate one for integer types?
- glVertexAttribLPointer is only used with GL_DOUBLE ... so the L doesn't stand for 'long', it stands for 'double' ... ?
- "Additionally GL_HALF_FLOAT, GL_FLOAT, GL_DOUBLE, GL_FIXED, GL_INT_2_10_10_10_REV, GL_UNSIGNED_INT_2_10_10_10_REV and GL_UNSIGNED_INT_10F_11F_11F_REV are accepted by glVertexAttribPointer. "
... so GL_DOUBLE works with glVertexAttribPointer ...
... so why even have other functions?

Forum commentary all says that glVertexAttribPointer is for glsl float types, glVertexAttribIPointer is for glsl int types, glVertexAttribLPointer is for glsl double types.
The docs do not say this.  The docs don't seem to mention what glsl type is necessary.
--]]
	local glslPrimType
	if self.glslType then
		glslPrimType = self.getGLTypeAndDimForGLSLType[self.glslType][1]
	end
	if GL_DOUBLE and glslPrimType == GL_DOUBLE then
		gl.glVertexAttribLPointer(
			loc,
			self.dim,
			self.type,
			self.stride,
			self.offset
		)
	elseif glslPrimType == gl.GL_INT or glslPrimType == gl.GL_UNSIGNED_INT then
		gl.glVertexAttribIPointer(
			loc,
			self.dim,
			self.type,
			self.stride,
			self.offset
		)
	else
		gl.glVertexAttribPointer(
			loc,
			self.dim,
			self.type,
			self.normalize and gl.GL_TRUE or gl.GL_FALSE,
			self.stride,
			self.offset
		)
	end
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

function GLAttribute:setDivisor(loc, divisor)
	-- not sure if I should keep this here
	-- or if I should put it back in GLVertexArray:enable
	-- or if I should move all attribute behavior into here?
	divisor = divisor or self.divisor
	if divisor then
		loc = loc or self.loc
		gl.glVertexAttribDivisor(loc, divisor)
	end
	return self
end

function GLAttribute:enableAndSet(loc)
	self:enable(loc)
	self:set(loc)
	self:setDivisor(loc)
	return self
end

return GLAttribute
