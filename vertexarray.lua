local ffi = require 'ffi'
local gl = require 'gl'
local class = require 'ext.class'
local table = require 'ext.table'
local Attribute = require 'gl.attribute'

ffi.cdef[[
typedef struct gl_vertex_array_ptr_t {
	GLuint ptr[1];
} gl_vertex_array_ptr_t;
]]
local gl_vertex_array_ptr_t = ffi.metatype('gl_vertex_array_ptr_t', {
	__gc = function(vertexArray)
		if vertexArray.ptr[0] ~= 0 then
			gl.glDeleteBuffers(1, vertexArray.ptr)
			vertexArray.ptr[0] = 0
		end
	end,
})

-- Attribute is abstract, similar to WebGL's view of attributes
-- VertexArray is something that needs to be bound
local VertexArray = class(Attribute)

function VertexArray:init(args)
	self.idPtr = gl_vertex_array_ptr_t()
	gl.glGenVertexArrays(1, self.idPtr.ptr)
	self.id = self.idPtr.ptr[0]

	VertexArray.super.init(self, args)
end

function VertexArray:bind()
	gl.glBindVertexArray(self.id)
end

return VertexArray 
