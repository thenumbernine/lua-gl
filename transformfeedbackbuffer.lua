local gl = require 'gl'
local GLBuffer = require 'gl.buffer'

local GLTransformFeedback = GLBuffer:subclass()
GLTransformFeedback.target = gl.GL_TRANSFORM_FEEDBACK_BUFFER

return GLTransformFeedback
