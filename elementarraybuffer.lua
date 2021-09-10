local class = require 'ext.class'
local gl = require 'gl'
local Buffer = require 'gl.buffer'

local ElementArrayBuffer = class(Buffer)
ElementArrayBuffer.target = gl.GL_ELEMENT_ARRAY_BUFFER

return ElementArrayBuffer
