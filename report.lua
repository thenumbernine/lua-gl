local gl = require 'gl'

local function glreport(name)
	local e = gl.glGetError()
	if e ~= 0 then
		local str = name
		if str then
			str = str .. ': '..e 
		else
			str = e
		end
		print(str)
		print(debug.traceback())
	end
	return e
end

return glreport
