local gl = require 'gl'
local op = require 'ext.op'
local table = require 'ext.table'

local glErrors = {
	'GL_NO_ERROR',
	'GL_INVALID_ENUM',
	'GL_INVALID_VALUE',
	'GL_INVALID_OPERATION',
	'GL_STACK_OVERFLOW',
	'GL_STACK_UNDERFLOW',
	'GL_OUT_OF_MEMORY',
	'GL_INVALID_FRAMEBUFFER_OPERATION',
	'GL_INVALID_INDEX',
}

--[[
returns a glError string entry for errorCode
--]]
local function glGetErrorName(errorCode)
	local name
	for _,name in ipairs(glErrors) do
		if errorCode == op.safeindex(gl, name) then
			return name
		end
	end
	return nil
end

--[[
return a string of an error code with name and optional message
--]]
local function glGetStrForError(errorCode, msg)
	local name = glGetErrorName(errorCode)

	local str = msg and msg..': ' or ''
	str = str..(' (0x%04x)'):format(errorCode)
	if name then
		str = str .. ' '..name
	end
	return str
end

--[[
return
	- true if no glGetError
	- nil and the error message if there is an error
--]]
local function glGetErrorStr(msg)
	local errorCode = gl.glGetError()
	if errorCode == 0 then return true, nil, errorCode end
	return nil, glGetStrForError(errorCode, msg), errorCode
end

local function glreport(msg)
	local success, str, errorCode = glGetErrorStr(msg)
	if not success then
		print(str)
		print(debug.traceback())
	end
	return success, str, errorCode
end

-- error if a gl error happened before the safe call
-- errors if the safe call function isn't found
-- returns false, error message if there's an error entering into the call
-- returns true, results if there's no error
local function glSafeCall(name, ...)
assert(glreport('before glSafeCall '..name))
	local f = op.safeindex(gl, name)
	if not f then error('failed to find gl.'..tostring(name)) end
	local result = table.pack(f(...))
	local success, str, errorCode = glGetErrorStr(name)
	if not success then
		return success, str, errorCode
	end
	return true, result:unpack()
end

return {
	glErrors = glErrors,
	glGetErrorName = glGetErrorName,
	glGetStrForError = glGetStrForError,
	glGetErrorStr = glGetErrorStr,
	glreport = glreport,
	glSafeCall = glSafeCall,
}
