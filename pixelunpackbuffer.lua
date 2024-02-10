local gl = require 'gl'
local Buffer = require 'gl.buffer'

local PixelUnpackBuffer = Buffer:subclass()
PixelUnpackBuffer.target = gl.GL_PIXEL_UNPACK_BUFFER

return PixelUnpackBuffer
