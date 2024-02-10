local gl = require 'gl'
local Buffer = require 'gl.buffer'

local ArrayBuffer = Buffer:subclass()
ArrayBuffer.target = gl.GL_ARRAY_BUFFER

return ArrayBuffer
