local class = require 'ext.class'
local gl = require 'gl'
local Buffer = require 'gl.buffer'

local PixelUnpackBuffer = class(Buffer)
PixelUnpackBuffer.target = gl.GL_PIXEL_UNPACK_BUFFER

return PixelUnpackBuffer
