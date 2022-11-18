local ffi = require 'ffi'
local class = require 'ext.class'
local gl = require 'gl'
local glreport = require 'gl.report'

local function GetBehavior(parent)
	local template = class(parent)
	
	--[[
	static method
	adds fields to class.getInfo and .getInfoForName
	(or should I just index by integer and by name both?)
	--]]
	function template:addGetterVars(args)
		self.getInfo = self.getInfo or {}
		local getter = assert(args.getter)
		local vars = assert(args.vars)
		for _,var in ipairs(vars) do
			if gl[var.name] then
				var.getter = getter
				table.insert(self.getInfo, var)
				self.getInfo[var.name] = var
			end
		end
	end

	function template:get(name)
		glreport'here' -- check error
		
		local var = self.getInfo[name]
		local infoType = assert(var.type)
		local getter = assert(var.getter)
		local nameValue = assert(gl[name])

		local result = ffi.new(infoType..'[1]')
		getter(self.id, nameValue, result)
		
		glreport'here' -- check error
		
		return result[0]
	end

	return template
end

return GetBehavior
