local ffi = require 'ffi'
local gl = require 'gl'
local Buffer = require 'gl.buffer'

local UniformBuffer = Buffer:subclass()

UniformBuffer.target = gl.GL_ELEMENT_ARRAY_BUFFER

return UniformBuffer
