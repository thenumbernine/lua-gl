local gl = require 'gl'
local ffi = require 'ffi'
local class = require 'ext.class'

local Attribute = class()

function Attribute:init(args)
	self.loc = assert(args.loc)
	self.size = args.size	-- dimension of the data ... 1,2,3,4
	self.type = args.type or gl.GL_FLOAT
	self.normalize = args.normalize or false
	self.stride = args.stride or 0
	self.offset = ffi.cast('uint8_t*', args.offset)

	-- optionally associate a glArrayBuffer as a field
	-- I'm using this in GLProgram:setAttr
	self.buffer = args.buffer
end

-- assumes the buffer is bound
function Attribute:setPointer()
	gl.glVertexAttribPointer(
		self.loc,
		self.size,
		self.type,
		self.normalize and gl.GL_TRUE or gl.GL_FALSE,
		self.stride,
		self.offset
	)
end

-- assumes the buffer is bound
function Attribute:enable()
	gl.glEnableVertexAttribArray(self.loc)
end

function Attribute:disable()
	gl.glDisableVertexAttribArray(self.loc)
end

-- shorthand for binding to the associated buffer, setPointer, and enable
function Attribute:set()
	if self.buffer then self.buffer:bind() end
	self:setPointer()
	self:enable()
	if self.buffer then self.buffer:unbind() end
end

return Attribute 
