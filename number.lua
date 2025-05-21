-- TODO so many projects require cl just to use clnumber with gl code ... this should be in its own file here or something
local function glnumber(x)
	local s = tostring(tonumber(x))
	if s:find'e' then return s end
	if not s:find'%.' then s = s .. '.' end
	return s
end

return glnumber
