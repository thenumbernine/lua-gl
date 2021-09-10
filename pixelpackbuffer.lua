local class = require 'ext.class'
local gl = require 'gl'
local Buffer = require 'gl.buffer'

local PixelPackBuffer = class(Buffer)
PixelPackBuffer.target = gl.GL_PIXEL_PACK_BUFFER

return PixelPackBuffer
