local ffi = require 'ffi'
local gl = require 'gl'
local class = require 'ext.class'
local table = require 'ext.table'

ffi.cdef[[
typedef struct gl_buffer_ptr_t {
	GLuint ptr[1];
} gl_buffer_ptr_t;
]]
local gl_buffer_ptr_t = ffi.metatype('gl_buffer_ptr_t', {
	__gc = function(buffer)
		if buffer.ptr[0] ~= 0 then
			gl.glDeleteBuffers(1, buffer.ptr)
			buffer.ptr[0] = 0
		end
	end,
})

local ArrayBuffer = class()

ArrayBuffer.target = gl.GL_ARRAY_BUFFER

--[[
args:
	size
	data (optional)
	usage
my js version has dim and count instead of size, then just size = dim * count
--]]
function ArrayBuffer:init(args)
	self.idPtr = gl_buffer_ptr_t()
	gl.glGenBuffers(1, self.idPtr.ptr)
	self.id = self.idPtr.ptr[0]

	assert(args, "expected args")
	if args.data then
		self:setData(args)
	elseif args.count then
		local empty = ffi.new('uint8_t[?]', args.count)
		self:setData(table(args, {data=empty}))
	end
end

--[[
args:
	size
	data
	usage
my js version has 'keep' for saving args.data ... I'll just make it default
--]]
function ArrayBuffer:setData(args)
	self.size = args.size
	self.usage = args.usage
	self.data = args.data
	self:bind()
	gl.glBufferData(self.target, self.size, self.data, self.usage)
	self:unbind()
end

function ArrayBuffer:bind()
	gl.glBindBuffer(self.target, self.id)
end

function ArrayBuffer:unbind()
	gl.glBindBuffer(self.target, 0)
end

return ArrayBuffer
