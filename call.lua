local gl = require 'gl'

local function glCallOrRun(list, callback, ...)
	assert(type(list) == 'table', "expected first parameter to be a table to store the list id")
	if list.id then
		gl.glCallList(list.id)
	else
		list.id = gl.glGenLists(1)
		gl.glNewList(list.id, gl.GL_COMPILE_AND_EXECUTE)

		callback(...)

		gl.glEndList()
	end
end

return glCallOrRun
