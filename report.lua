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

local function glreport(msg)
	local err = gl.glGetError()
	if err == 0 then return true, nil, err end
		
	local name
	for _,v in ipairs(errors) do
		if err == gl[v] then
			name = v
			break
		end
	end
	
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
