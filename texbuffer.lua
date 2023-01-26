local gl = require 'gl'
local class = require 'ext.class'
local GLTex = require 'gl.tex'

local GLTexBuffer = class(GLTex)

GLTexBuffer.target = gl.GL_TEXTURE_BUFFER

function GLTexBuffer:create(args)
	self.target = args.target
	self.internalFormat = args.internalFormat
	self.buffer = args.buffer
	if type(self.buffer) == 'table' then self.buffer = self.buffer.id end
	gl.glTexBuffer(
		self.target,
		self.internalFormat,
		self.buffer)
end

return GLTexBuffer
