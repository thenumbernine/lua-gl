local class = require 'ext.class'
local gl = require 'gl'
local Buffer = require 'gl.buffer'

local ShaderStorageBuffer = class(Buffer)
ShaderStorageBuffer.target = gl.GL_SHADER_STORAGE_BUFFER

return ShaderStorageBuffer
