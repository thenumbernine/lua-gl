local GLArrayBuffer = require 'gl.arraybuffer'
local gl = require 'gl'
local class = require 'ext.class'

local ElementArrayBuffer = class(GLArrayBuffer)

ElementArrayBuffer.target = gl.GL_ELEMENT_ARRAY_BUFFER

return ElementArrayBuffer
