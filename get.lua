--[[
similar to cl/getinfo.lua

TODO GL isn't as clean an API as CL
so the getter function might have to be more flexible.
this currntly passes in the obj's id as the 1st arg
this is fine with glGetProgram* stuff
but for glGetVertexAttrib, we want the location as the first,
	but also association of this function with the VAO (tho th VAO .id doesn't get passed into th get)
	(does that mean this function is not associated the attribute itself? even though attribute location *IS* passed into the 1st arg? gah.)
	(or is this associated with globally assigned attributes when no VAO is being used?)
and for textures we want the 1st parameter to be the texture-target, not the .id ... more mess.
--]]
local ffi = require 'ffi'
local class = require 'ext.class'
local op = require 'ext.op'
local gl = require 'gl'
local glreport = require 'gl.report'

local function unpackptr(p, n)
	if n <= 0 then return end
	return p[0], unpackptr(p+1, n-1)
end

local function GetBehavior(parent)
	local template = class(parent)

	--[[
	static method
	adds fields to class.getInfo and .getInfoForName
	(or should I just index by integer and by name both?)
	--]]
	function template:makeGetter(args)
		self.getInfo = self.getInfo or {}
		local getter = assert(args.getter)
		local vars = assert(args.vars)
		for _,var in ipairs(vars) do
			if op.safeindex(gl, var.name) then
				-- keep any per-variable assigned getter if it was specified
				var.getter = var.getter or getter
				table.insert(self.getInfo, var)
				self.getInfo[var.name] = var
			else
				var.getter = nil
			end
		end
	end

	function template:get(name)
		glreport'here' -- check error

		local var = self.getInfo[name]
		if not var then
			error("failed to find getter associated with GL constant "..tostring(name))
		end
		-- TODO this here, and do it every time :get() is called?
		-- or this upon construction, which means .type doesn't match whatever was provided?
		local infoType = assert(var.type)
		local getter = assert(var.getter)
		local nameValue = assert(gl[name])

		-- make sure it's a pointer of some kind (since luajit doesn't handle refs)
		local count = infoType:match'%[(%d+)%]$'
		if count then
			count = assert(tonumber(count))
		else
			count = 1
			infoType = infoType..'[1]'
		end
		local result = ffi.new(infoType)
		-- CL has a clean association of getters and classes, and always has the class' object's id first
		-- GL not so much, so instead of passing the id first I'll pass the object first and let the implementer decide what to do with it
		-- (so tex can use self.target, program can use self.id, vao can use who knows ...)
		-- (CL also has a clean interface for interchangeable single vs array getters
		getter(self, nameValue, result)
		glreport'here' -- check error

		if var.postxform then
			return var.postxform(self, result, count)
		else
			return unpackptr(result, count)
		end
	end

	return template
end

return GetBehavior
