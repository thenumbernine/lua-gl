local GCWrapper = require 'ffi.gcwrapper.gcwrapper'
local gl = require 'gl'
local class = require 'ext.class'
local table = require 'ext.table'

--[[
usage:
1) create VertexArray
2) bind VertexArray
3) for all attrs
4)	bind buffer
5)	set vertex attrib pointer
6)	enable attrib array
--]]
local VertexArray = class(GCWrapper{
	gctype = 'autorelease_gl_vertex_array_ptr_t',
	ctype = 'GLuint',
	-- retain isn't used
	release = function(ptr)
		return gl.glDeleteVertexArrays(1, ptr)
	end,
})

function VertexArray:init(args)
	VertexArray.super.init(self)
	gl.glGenVertexArrays(1, self.gc.ptr)
	self.id = self.gc.ptr[0]

	if args.attrs then
		local GLAttribute = require 'gl.attribute'
		local GLArrayBuffer = require 'gl.arraybuffer'
		local program = assert(args.program, "if you are specifying attrs then you must specify a program")
		self.attrs = table()
		for name,setargs in pairs(args.attrs) do
			local attr = GLAttribute(program.attrs[name])
			self.attrs:insert(attr)
			if GLArrayBuffer:isa(setargs) then
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
	return self
end

function VertexArray:bind(args)
	gl.glBindVertexArray(self.id)
	return self
end

function VertexArray.unbind()
	gl.glBindVertexArray(0)
	return self
end

function VertexArray:enableAttrs(attrs)
	for _,attr in ipairs(attrs or self.attrs) do
		attr:enable()
	end
	return self
end

function VertexArray:disableAttrs(attrs)
	for _,attr in ipairs(attrs or self.attrs) do
		attr:disable()
	end
	return self
end

-- shorthand for bind + enableAttrs
function VertexArray:use()
	self:bind()
	self:enableAttrs()
	return self
end

-- shorthand for unbind + disableAttrs
function VertexArray:useNone()
	self:disableAttrs()
	self:unbind()
	return self
end

return VertexArray
