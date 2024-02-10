local gl = require 'gl'
local Buffer = require 'gl.buffer'

local ElementArrayBuffer = Buffer:subclass()
ElementArrayBuffer.target = gl.GL_ELEMENT_ARRAY_BUFFER

return ElementArrayBuffer
