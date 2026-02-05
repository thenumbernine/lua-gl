local ffi = require 'ffi'
local gl = require 'gl'
local glu = require 'gl.ffi.glu'

-- glSceneIntersect

local readBufferPtr = ffi.new('GLint[1]')
local depthValuePtr = ffi.new('GLfloat[1]')
local modelC = ffi.new('GLdouble[16]')
local projC = ffi.new('GLdouble[16]')
local viewC = ffi.new('GLint[4]')
local objX = ffi.new('GLdouble[1]')
local objY = ffi.new('GLdouble[1]')
local objZ = ffi.new('GLdouble[1]')
local function glSceneIntersect(screenFracPosX, screenFracPosY, renderCallback, ...)
	gl.glGetIntegerv(gl.GL_READ_BUFFER, readBufferPtr)
	local readbuf = readBufferPtr[0]
	gl.glReadBuffer(gl.GL_BACK)

	if renderCallback then renderCallback(...) end

	gl.glGetIntegerv(gl.GL_VIEWPORT, viewC)
	local mx = math.floor(screenFracPosX * (tonumber(viewC[2]) - 1))
	local my = math.floor(screenFracPosY * (tonumber(viewC[3]) - 1))

	gl.glReadPixels(mx, my, 1, 1, gl.GL_DEPTH_COMPONENT, gl.GL_FLOAT, depthValuePtr)
	local pix = depthValuePtr[0]

	--if pix == 1 then return nil end	-- full depth means a cleared-depth value, means nothing was here

	gl.glGetDoublev(gl.GL_MODELVIEW_MATRIX, modelC)
	gl.glGetDoublev(gl.GL_PROJECTION_MATRIX, projC)

	local res = glu.gluUnProject(mx, my, pix, modelC, projC, viewC, objX, objY, objZ)
	local projX = objX[0]
	local projY = objY[0]
	local projZ = objZ[0]

	gl.glReadBuffer(readbuf)

	return projX, projY, projZ, pix, res
end

return glSceneIntersect
