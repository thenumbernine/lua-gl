local gl = require 'gl'

local errors = {
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

local function glGetErrorName(errorCode)
	local name
	for _,v in ipairs(errors) do
		if errorCode == gl[v] then
			return v
		end
	end
	return nil
end

local function glreport(msg)
	local err = gl.glGetError()
	if err == 0 then return true, nil, err end
	local name = glGetErrorName(err)

	local str = msg
	if str then
		str = str .. ': '
	end
	str = str..(' (0x%04x)'):format(err)
	if name then
		str = str .. ' '..name
	end
	print(str)
	print(debug.traceback())
	return nil, str, err
end

return glreport
