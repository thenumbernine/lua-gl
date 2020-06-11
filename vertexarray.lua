local ffi = require 'ffi'
local gl = require 'gl'
local class = require 'ext.class'
local table = require 'ext.table'

ffi.cdef[[
typedef struct gl_vertex_array_ptr_t {
	GLuint ptr[1];
} gl_vertex_array_ptr_t;
]]
local gl_vertex_array_ptr_t = ffi.metatype('gl_vertex_array_ptr_t', {
	__gc = function(vertexArray)
		if vertexArray.ptr[0] ~= 0 then
			gl.glDeleteVertexArrays(1, vertexArray.ptr)
			vertexArray.ptr[0] = 0
		end
	end,
})

--[[
usage: 
1) create VertexArray
2) bind VertexArray
3) for all attrs
4)	bind buffer
5)	set vertex attrib pointer
6)	enable attrib array
--]]
local VertexArray = class()

function VertexArray:init(attrs)
	self.idPtr = gl_vertex_array_ptr_t()
	gl.glGenVertexArrays(1, self.idPtr.ptr)
	self.id = self.idPtr.ptr[0]

	if attrs then self:setAttrs(attrs) end
end

function VertexArray:bind(args)
	gl.glBindVertexArray(self.id)
end

function VertexArray.unbind()
	gl.glBindVertexArray(0)
end

function VertexArray:setAttrs(attrs)
	self:bind()
	for _,attr in ipairs(attrs) do
		attr:set()
	end
	self:unbind()
end

return VertexArray 
