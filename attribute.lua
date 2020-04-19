local gl = require 'gl'
local class = require 'ext.class'
local ArrayBuffer = require 'gl.buffer'

local Attribute = class()

function Attribute:init(args)
	self.buffer = assert(args.buffer)
	self.size = args.size	-- dimension of the data ... 1,2,3,4
	self.type = args.type or gl.GL_FLOAT
	self.normalize = args.normalize or false
	self.stride = args.stride or 0
	self.offset = ffi.cast('uint8_t*', args.offset)
end

-- assumes the buffer is bound
function Attribute:setAttr(loc)
	gl.glVertexAttribPointer(
		loc,
		self.size,
		self.type,
		self.normalize and gl.GL_TRUE or gl.GL_FALSE,
		self.stride,
		self.offset
	)
end

return Attribute 
