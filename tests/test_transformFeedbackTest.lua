#!/usr/bin/env luajit
local ffi = require 'ffi'
local gl = require 'gl.setup'(...)
local GLProgram = require 'gl.program'
local GLArrayBuffer = require 'gl.arraybuffer'
local GLVertexArray = require 'gl.vertexarray'

-- Create transform feedback buffer
-- TODO create it as an ArrayBuffer and use as target=TRANSFORM_FEEDBACK_BUFFER?
-- or create it as TRANSFORM_FEEDBACK_BUFFER?
-- or does it make a difference?
local GLTransformFeedbackBuffer = require 'gl.transformfeedbackbuffer'

-- from https://open.gl/feedback
local App = require 'gl.app':subclass()

local useVAO = true

function App:initGL()

	local data = ffi.new('GLfloat[5]', { 1, 2, 3, 4, 5 })
	local inBuffer = GLArrayBuffer{
		size = ffi.sizeof'GLfloat' * 5,
		usage = gl.GL_STATIC_DRAW,
		data = data,
	}:unbind()

	local outBuffer = GLTransformFeedbackBuffer{
		size = ffi.sizeof'GLfloat' * 5,
		type = gl.GL_FLOAT,
		count = 5,
		dim = 1,
		usage = gl.GL_STATIC_READ,
	}:unbind()

	local program = GLProgram{
		version = 'latest',
		precision = 'best',
		vertexCode = [[
in float inValue;
out float outValue;
void main() {
	outValue = sqrt(inValue);
}
]],
		transformFeedback = {
			'outValue',
			mode = 'interleaved',	-- TODO default mode?
		},

		-- ok here's me misusing GLProgram as a singleton for its attributes
		attrs = not useVAO and {
			inValue = {
				buffer = inBuffer,
			},
		} or nil,
	}:useNone()

	local vao
	if useVAO then
		vao = GLVertexArray{
			program = program,
			attrs = {
				inValue = {
					buffer = inBuffer,
				},
			},
		}
	end

	program:use()
	if vao then
		vao:bind()
	else
		-- misuse program obj for buffer<->attr association
		for name,attr in pairs(program.attrs) do
			attr:enableAndSet()
		end
	end

	outBuffer
		:bind()
		:bindBase()	-- () == (0) == layout(binding=...) of our one varying (is it? is binding and location the same?)
		:unbind()

	-- Perform feedback transform
	gl.glEnable(gl.GL_RASTERIZER_DISCARD)
	gl.glBeginTransformFeedback(gl.GL_POINTS)
	gl.glDrawArrays(gl.GL_POINTS, 0, 5)
	gl.glEndTransformFeedback()
	gl.glDisable(gl.GL_RASTERIZER_DISCARD)
	gl.glFlush()

	program:useNone()
	if vao then
		vao:unbind()
	else
		-- misuse program obj for buffer<->attr association
		for name,attr in pairs(program.attrs) do
			attr:disable()
		end
	end

	-- Fetch and print results
	-- not available in GLES ... so how do you read data in GLES?
	--[[
	local feedback = ffi.new('GLfloat[5]')
	gl.glGetBufferSubData(gl.GL_TRANSFORM_FEEDBACK_BUFFER, 0, ffi.sizeof(feedback), feedback)
	print(("%f %f %f %f %f"):format(feedback[0], feedback[1], feedback[2], feedback[3], feedback[4]))
	--]]
	-- [[ ... but webgl2 does have glGetBufferData ... but gles3 doesn't ...
	-- but gles does have glMapBufferRange ... but webgl doesn't ...

	-- TODO is 'length' in elements while 'offset' is in bytes?  .... smh
	outBuffer:bind()
	local feedback = ffi.cast('GLfloat*', outBuffer:map(gl.GL_MAP_READ_BIT))
	print('feedback', feedback)
	assert(feedback ~= nil)
	print(("%f %f %f %f %f"):format(feedback[0], feedback[1], feedback[2], feedback[3], feedback[4]))
	outBuffer:unmap()
	--]]

	self:requestExit()
end

return App():run()
