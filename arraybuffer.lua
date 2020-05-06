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
this makes it more compatible with GLProgram:setAttr(buffer)
instead of only GLProgram:setAttr(attr)
--]]
function ArrayBuffer:init(args)
	self.idPtr = gl_buffer_ptr_t()
	gl.glGenBuffers(1, self.idPtr.ptr)
	self.id = self.idPtr.ptr[0]
	
	assert(args, "expected args")
	if args.data then
		self:setData(args)
	elseif args.size then
		local empty = ffi.new('uint8_t[?]', args.size)
		self:setData(table(args, {data=empty}))
	end
end

function ArrayBuffer:bind()
	gl.glBindBuffer(self.target, self.id)
end

function ArrayBuffer:unbind()
	gl.glBindBuffer(self.target, 0)
end

--[[
args:
	size
	data
	usage
my js version has 'keep' for saving args.data ... I'll just make it default
--]]
function ArrayBuffer:setData(args)
	local size = args.size
	local data = args.data
	if type(data) == 'table' then
		local n = #data
		size = size or n * ffi.sizeof'float'
		local numFloats = math.floor(size / ffi.sizeof'float')
		local cdata = ffi.new('float[?]', numFloats)
		for i=1,math.min(numFloats, n) do
			cdata[i-1] = data[i]
		end
		data = cdata
	end
	-- mind you, this is saving the cdata, even if you :setData() with Lua data ... 
	self.data = data
	self.size = size
	self.usage = args.usage or gl.GL_STATIC_DRAW
	self:bind()
	gl.glBufferData(self.target, self.size, self.data, self.usage)
	self:unbind()
end

function ArrayBuffer:updateData(offset, size, data)
	offset = offset or 0
	size = size or self.size
	data = data or self.data
	self:bind()
	gl.glBufferSubData(self.target, offset, size, data)
	self:unbind()
end

return ArrayBuffer
