local ffi = require 'ffi'
local class = require 'ext.class'
local gl = require 'gl'
local glreport = require 'gl.report'

local function GetBehavior(parent)
	local template = class(parent)
	
	function template:init(...)
		self.getTypeMap = {}
		for _,get in ipairs(self.gets) do
			self.getTypeMap[get.name] = get.type
		end
		
		if parent then return parent.init(self, ...) end
	end

	function template:get(name)
		glreport'here' -- check error
		
		local infoType = self.getTypeMap[name]
		local nameValue = assert(gl[name])

		local result = ffi.new(infoType..'[1]')
		self.getter(self.id, nameValue, result)
		
		glreport'here' -- check error
		
		return result[0]
	end

	return template
end

return GetBehavior
