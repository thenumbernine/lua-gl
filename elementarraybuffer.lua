local op = require 'ext.op'
local gl = require 'gl'
local Buffer = require 'gl.buffer'

local ElementArrayBuffer = Buffer:subclass()

-- default data type when converting from lua buffer?
-- change this depending on if it's gles (short) or not (int) ?  but only if ES doesn't have its element_index_uint extension?
if op.safeindex(gl, 'GL_ES_VERSION_2_0') then
	ElementArrayBuffer.type = gl.GL_UNSIGNED_SHORT
else
	ElementArrayBuffer.type = gl.GL_UNSIGNED_INT
end

ElementArrayBuffer.target = gl.GL_ELEMENT_ARRAY_BUFFER

return ElementArrayBuffer
