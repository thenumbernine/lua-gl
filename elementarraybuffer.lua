local gl = require 'gl'
local Buffer = require 'gl.buffer'

local ElementArrayBuffer = Buffer:subclass()

-- default data type when converting from lua buffer?
-- TODO change this depending on if it's gles (short) or not (int) ?
ElementArrayBuffer.type = gl.GL_UNSIGNED_INT

ElementArrayBuffer.target = gl.GL_ELEMENT_ARRAY_BUFFER

return ElementArrayBuffer
