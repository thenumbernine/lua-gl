local class = require 'ext.class'
local gl = require 'gl'
local Buffer = require 'gl.buffer'

local ArrayBuffer = class(Buffer)
ArrayBuffer.target = gl.GL_ARRAY_BUFFER

return ArrayBuffer
