local ffi = require 'ffi'
local gl = require 'gl'
local Buffer = require 'gl.buffer'

local ElementArrayBuffer = Buffer:subclass()

-- Default data type when converting from lua buffer?
-- Change this depending on if it's gles (short) or not (int) ?  but only if ES doesn't have its element_index_uint extension?
-- Or only switch it to short if we've initialized webgl1 instead, so do that there and not here.
--local op = require 'ext.op'
--if op.safeindex(gl, 'GL_ES_VERSION_2_0') then
--	ElementArrayBuffer.type = gl.GL_UNSIGNED_SHORT
--else
ElementArrayBuffer.type = gl.GL_UNSIGNED_INT
ElementArrayBuffer.ctype = ffi.typeof'uint32_t'
ElementArrayBuffer.dim = 1
--end

ElementArrayBuffer.target = gl.GL_ELEMENT_ARRAY_BUFFER

return ElementArrayBuffer
