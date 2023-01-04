local ffi = require 'ffi'
local GCWrapper = require 'ffi.gcwrapper.gcwrapper'
local gl = require 'gl'
local class = require 'ext.class'
local table = require 'ext.table'

local Buffer = class(GCWrapper{
	gctype = 'autorelease_gl_buffer_ptr_t',
	ctype = 'GLuint',
	-- retain isn't used
	release = function(ptr)
		return gl.glDeleteBuffers(1, ptr)
	end,
})

--[[
args:
	size
	data (optional)
	usage
my js version has dim and count instead of size, then just size = dim * count
this makes it more compatible with GLProgram:setAttr(buffer)
instead of only GLProgram:setAttr(attr)
--]]
function Buffer:init(args)
	Buffer.super.init(self)
	gl.glGenBuffers(1, self.gc.ptr)
	self.id = self.gc.ptr[0]
	
	assert(args, "expected args")
	if args.data then
		self:setData(args)
	elseif args.size then
		local empty = ffi.new('uint8_t[?]', args.size)
		self:setData(table(args, {data=empty}))
	end
end

function Buffer:bind()
	gl.glBindBuffer(self.target, self.id)
end

function Buffer:unbind()
	gl.glBindBuffer(self.target, 0)
end

--[[
args:
	size
	data
	usage
my js version has 'keep' for saving args.data ... I'll just make it default
--]]
function Buffer:setData(args)
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

function Buffer:updateData(offset, size, data)
	offset = offset or 0
	size = size or self.size
	data = data or self.data
	self:bind()
	gl.glBufferSubData(self.target, offset, size, data)
	self:unbind()
end

-- https://registry.khronos.org/OpenGL-Refpages/gl4/html/glBindBufferBase.xhtml
-- "target must be one of GL_ATOMIC_COUNTER_BUFFER, GL_TRANSFORM_FEEDBACK_BUFFER, GL_UNIFORM_BUFFER or GL_SHADER_STORAGE_BUFFER."
function Buffer:bindBase(index)
	gl.glBindBufferBase(self.target, index, self.id)
end

return Buffer
