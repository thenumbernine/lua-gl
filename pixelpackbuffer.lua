local gl = require 'gl'
local Buffer = require 'gl.buffer'

local PixelPackBuffer = Buffer:subclass()
PixelPackBuffer.target = gl.GL_PIXEL_PACK_BUFFER

return PixelPackBuffer
