local gl = require 'gl'

local function glreport(name)
	local e = gl.glGetError()
	if e ~= 0 then
		local str = name
		if str then
			str = str .. ': '..e..(' (0x%04x)'):format(e)
		else
			str = e
		end
		print(str)
		print(debug.traceback())
		return nil, str, e
	end
	return true, nil, e
end

return glreport
