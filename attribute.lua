local gl = require 'gl'
local ffi = require 'ffi'
local class = require 'ext.class'

local Attribute = class()

function Attribute:init(args)
	self.size = args.size	-- dimension of the data ... 1,2,3,4
	self.type = args.type or gl.GL_FLOAT
	self.normalize = args.normalize or false
	self.stride = args.stride or 0
	self.offset = ffi.cast('uint8_t*', args.offset)
	
	-- optionally associated with a shader location
	self.loc = args.loc

	-- optionally associate a glArrayBuffer as a field
	-- I'm using this in GLProgram:setAttr
	self.buffer = args.buffer
end

-- assumes the buffer is bound
function Attribute:setPointer(loc)
	gl.glVertexAttribPointer(
		loc or self.loc,
		self.size,
		self.type,
		self.normalize and gl.GL_TRUE or gl.GL_FALSE,
		self.stride,
		self.offset
	)
end

-- assumes the buffer is bound
function Attribute:enable(loc)
	gl.glEnableVertexAttribArray(loc or self.loc)
end

function Attribute:disable(loc)
	gl.glDisableVertexAttribArray(loc or self.loc)
end

-- shorthand for binding to the associated buffer, setPointer, and enable
function Attribute:set(loc)
	if self.buffer then self.buffer:bind() end
	self:setPointer(loc)
	self:enable(loc)
	if self.buffer then self.buffer:unbind() end
end

return Attribute 
