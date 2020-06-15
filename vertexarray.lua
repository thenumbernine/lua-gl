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

function VertexArray:init(args)
	self.idPtr = gl_vertex_array_ptr_t()
	gl.glGenVertexArrays(1, self.idPtr.ptr)
	self.id = self.idPtr.ptr[0]

	if args.attrs then
		local GLAttribute = require 'gl.attribute'
		local GLArrayBuffer = require 'gl.arraybuffer'
		local program = assert(args.program, "if you are specifying attrs then you must specify a program")
		self.attrs = table()
		for name,setargs in pairs(args.attrs) do
			local attr = GLAttribute(program.attrs[name])
			self.attrs:insert(attr)
			if GLArrayBuffer.is(setargs) then
				attr.buffer = setargs
			else
				for k,v in pairs(setargs) do
					attr[k] = v
				end
			end
		end
		self:setAttrs() 
	end
end

function VertexArray:setAttrs(attrs)
	self:bind()
	for _,attr in ipairs(attrs or self.attrs) do
		attr:set()
	end
	self:unbind()
end

function VertexArray:bind(args)
	gl.glBindVertexArray(self.id)
end

function VertexArray.unbind()
	gl.glBindVertexArray(0)
end

function VertexArray:enableAttrs(attrs)
	for _,attr in ipairs(attrs or self.attrs) do
		attr:enable()
	end
end

function VertexArray:disableAttrs(attr)
	for _,attr in ipairs(attrs or self.attrs) do
		attr:disable()
	end
end

-- shorthand for bind + enableAttrs
function VertexArray:use()
	self:bind()
	self:enableAttrs()
end

-- shorthand for unbind + disableAttrs
function VertexArray:useNone()
	self:disableAttrs()
	self:unbind()
end

return VertexArray 
