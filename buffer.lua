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
	size = forwarded to setData
	data (optional) = forwarded to setData
	usage (optional) = forwarded to setData
	target (optional) = this is forwarded to setData, but unlike the other fields it is not assigned to self
my js version has dim and count instead of size, then just size = dim * count
this makes it more compatible with GLProgram:setAttr(buffer)
instead of only GLProgram:setAttr(attr)
--]]
function Buffer:init(args)
	Buffer.super.init(self)
	gl.glGenBuffers(1, self.gc.ptr)
	self.id = self.gc.ptr[0]

	-- TODO bind even if we have no args?  or only if args are provided / setData is called?
	self:bind()
	if args then
		if args.data then
			self:setData(args)
		elseif args.size then
			local empty = ffi.new('uint8_t[?]', args.size)
			self:setData(table(args, {data=empty}))
		end
	end
end

function Buffer:bind(target)
	gl.glBindBuffer(target or self.target, self.id)
	return self
end

function Buffer:unbind(target)
	gl.glBindBuffer(target or self.target, 0)
	return self
end

--[[
args:
	size = size, required.
	data = (optional) data, default is null.
	usage = (optional) GL buffer usage.  default GL_STATIC_DRAW.
	type = (optional) if data is a Lua table, this specifies what c type to convert it to.  default float.
	target = (optional) override self.target in the glBindBuffer call, but unlike the other fields it does not assign to self.
my js version has 'keep' for saving args.data ... I'll just make it default
--]]
function Buffer:setData(args)
	local size = args.size
	local data = args.data
	if type(data) == 'table' then
		local n = #data
		local ctype = args.type or 'float'
		size = size or n * ffi.sizeof(ctype)
		local numFloats = math.floor(size / ffi.sizeof(ctype))
		local cdata = ffi.new(ctype..'[?]', numFloats)
		for i=1,math.min(numFloats, n) do
			cdata[i-1] = data[i]
		end
		data = cdata
	end
	-- mind you, this is saving the cdata, even if you :setData() with Lua data ...
	self.data = data
	self.size = size
	self.usage = args.usage or gl.GL_STATIC_DRAW
	gl.glBufferData(args.target or self.target, self.size, self.data, self.usage)
	return self
end

function Buffer:updateData(offset, size, data)
	gl.glBufferSubData(self.target, offset or 0, size or self.size, data or self.data)
	return self
end

-- https://registry.khronos.org/OpenGL-Refpages/gl4/html/glBindBufferBase.xhtml
-- "target must be one of GL_ATOMIC_COUNTER_BUFFER, GL_TRANSFORM_FEEDBACK_BUFFER, GL_UNIFORM_BUFFER or GL_SHADER_STORAGE_BUFFER."
function Buffer:bindBase(index)
	gl.glBindBufferBase(self.target, index, self.id)
	return self
end

return Buffer
