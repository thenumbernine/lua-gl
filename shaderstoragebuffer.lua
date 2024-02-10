local gl = require 'gl'
local Buffer = require 'gl.buffer'

local ShaderStorageBuffer = Buffer:subclass()
ShaderStorageBuffer.target = gl.GL_SHADER_STORAGE_BUFFER

return ShaderStorageBuffer
