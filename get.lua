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
local table = require 'ext.table'
local op = require 'ext.op'
local gl = require 'gl'
local glreport = require 'gl.report'
local glSafeCall = require 'gl.error'.glSafeCall

local function unpackptr(p, n)
	if n <= 0 then return end
	return p[0], unpackptr(p+1, n-1)
end

local function returnLastArgAsType(name, ctype, count)
	count = count or 1
	return function(...)
		local resultPtr = ffi.new(ctype..'[?]', count)
		local args = table.pack(...)
		args.n = args.n + 1
		args[args.n] = resultPtr
		local success, msg = glSafeCall(name, args:unpack())
		if not success then return success, msg end
		return unpackptr(resultPtr, count)
	end
end

local boolean = returnLastArgAsType('glGetBooleanv', 'GLboolean')
local int = returnLastArgAsType('glGetIntegerv', 'GLint')
local int64 = returnLastArgAsType('glGetInteger64v', 'GLint64')
local float = returnLastArgAsType('glGetFloatv', 'GLfloat')
local double = returnLastArgAsType('glGetDoublev', 'GLdouble')

local booleanIndex = returnLastArgAsType('glGetBooleani_v', 'GLboolean')
local intIndex = returnLastArgAsType('glGetIntegeri_v', 'GLint')
local int64Index = returnLastArgAsType('glGetInteger64i_v', 'GLint64')
local floatIndex = returnLastArgAsType('glGetFloati_v', 'GLfloat')
local doubleIndex = returnLastArgAsType('glGetDoublei_v', 'GLdouble')

local function string(...)
	local success, value = glSafeCall('glGetString', ...)
	if not success then return nil, value end
	return ffi.string(value)
end

local function behavior(parent)
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
				if self.getInfo[var.name] then
					error(var.name.." added twice")
				end
				self.getInfo[var.name] = var
			else
				var.notfound = true
				var.getter = nil
				self.getInfo[var.name] = var
			end
		end
	end

	function template:get(name, ...)
		glreport'gl.get begin' -- clear error

		local var = self.getInfo[name]
		if not var then
			return nil, "failed to find getter associated with "..tostring(name)
		end
		if var.notfound then
			return nil, tostring(name).." not defined"
		end

		-- TODO this here, and do it every time :get() is called?
		-- or this upon construction, which means .type doesn't match whatever was provided?
		local getter = assert(var.getter)
		local nameValue = assert(gl[name])	-- TODO gl[name] will error if it's not present ... use op.safeindex?

		-- CL has a clean association of getters and classes, and always has the class' object's id first
		-- GL not so much, so instead of passing the id first I'll pass the object first and let the implementer decide what to do with it
		-- (so tex can use self.target, program can use self.id, vao can use who knows ...)
		-- (CL also has a clean interface for interchangeable single vs array getters

		-- Ok here's a weakness in the design ...
		-- All the original glGet's accept the return param
		-- ... so it makes sense to create the result buffer up front.
		-- But then some arguments need a buffer of multiple primitives ...
		-- ... so it makes sense to specify the array size up front.
		-- Now comes getters with separate params for the array size and the results
		-- ... so now I need to allocate the result in the getter.
		-- 	This is exceptional behavior so I'm still keeping the .type and .result around
		--  ... but for varying sized glGet's, the original allocate result isn't needed.
		return getter(self, nameValue, ...)
	end

	return template
end

return {
	-- make a convenient return-based getter for the glGet* functions
	behavior = behavior,
	returnLastArgAsType = returnLastArgAsType,
	boolean = boolean,
	int = int,
	int64 = int64,
	float = float,
	double = double,
	booleanIndex = booleanIndex,
	intIndex = intIndex,
	int64Index = int64Index,
	floatIndex = floatIndex,
	doubleIndex = doubleIndex,
	string = string,
}
