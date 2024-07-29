local gl = require 'gl'
local GLBuffer = require 'gl.buffer'

local GLShaderStorageBuffer = GLBuffer:subclass()
GLShaderStorageBuffer.target = gl.GL_SHADER_STORAGE_BUFFER

return GLShaderStorageBuffer
