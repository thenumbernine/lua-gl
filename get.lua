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
local assert = require 'ext.assert'
local class = require 'ext.class'
local table = require 'ext.table'
local op = require 'ext.op'
local assert = require 'ext.assert'
local gl = require 'gl'
local glSafeCall = require 'gl.error'.glSafeCall


local GLboolean = ffi.typeof'GLboolean'
local GLint = ffi.typeof'GLint'
local GLint64 = ffi.typeof'GLint64'
local GLfloat = ffi.typeof'GLfloat'
local GLdouble = op.land(pcall(ffi.typeof, 'GLdouble')) or nil	-- not in GLES3


local function unpackptr(p, n)
	if n <= 0 then return end
	return p[0], unpackptr(p+1, n-1)
end

local function makeRetLastArg(args)
	local name = assert.index(args, 'name')		-- function name to lookup
	local lookup = args.lookup			-- any arguments to try to convert from string to number via lookup in gl namespace
	local ctype = assert.index(args, 'ctype')	-- result ctype
	local count = args.count or 1		-- result array size

	ctype = ffi.typeof(ctype)
	local ctype_arr = ffi.typeof('$[?]', ctype)

	return function(...)
		local resultPtr = ctype_arr(count)
		local args = table.pack(...)
		if lookup then
			for _,i in ipairs(lookup) do
				if not (i >= 1 and i <= args.n) then error("got an out of bounds lookup index "..tostring(i)) end
				local v = args[i]
				local t = type(v)
				if t == 'string' then
					local value = op.safeindex(gl, v)
					if not value then
						return nil, tostring(v).." not defined"
					end
					args[i] = value
				elseif not (t == 'number' or t == 'cdata') then
					return nil, name.." arg "..i.." must be type string or number, found "..t
				end
			end
		end
		args.n = args.n + 1
		args[args.n] = resultPtr
		local success, msg = glSafeCall(name, args:unpack())
		if not success then return nil, msg end
		return unpackptr(resultPtr, count)
	end
end

local boolean = makeRetLastArg{name='glGetBooleanv', ctype=GLboolean, lookup={1}}
local int = makeRetLastArg{name='glGetIntegerv', ctype=GLint, lookup={1}}
local int64 = makeRetLastArg{name='glGetInteger64v', ctype=GLint64, lookup={1}}
local float = makeRetLastArg{name='glGetFloatv', ctype=GLfloat, lookup={1}}

local double = GLdouble
	and op.safeindex(gl, 'glGetDoublev') 	-- not in GLES3
	and makeRetLastArg{name='glGetDoublev', ctype=GLdouble, lookup={1}}
	or nil

local booleanIndex =
	op.safeindex(gl, 'glGetBooleani_v') 	-- not in GLES3
	and makeRetLastArg{name='glGetBooleani_v', ctype=GLboolean, lookup={1}}
	or nil

local intIndex = makeRetLastArg{name='glGetIntegeri_v', ctype=GLint, lookup={1}}
local int64Index = makeRetLastArg{name='glGetInteger64i_v', ctype=GLint64, lookup={1}}

local floatIndex =
	op.safeindex(gl, 'glGetFloati_v') 	-- not in GLES3
	and makeRetLastArg{name='glGetFloati_v', ctype=GLfloat, lookup={1}}
	or nil

local doubleIndex =
	GLdouble
	and op.safeindex(gl, 'glGetDoublei_v')	-- not in GLES3
	and makeRetLastArg{name='glGetDoublei_v', ctype=GLdouble, lookup={1}}
	or nil

local function string(param, ...)
	local t = type(param)
	if t == 'string' then
		local value = op.safeindex(gl, param)
		if not value then
			return nil, tostring(param).." not defined"
		end
		param = value
	elseif not (t == 'number' or t == 'cdata') then
		return nil, name.." arg 1 must be type string or number, found "..t
	end

	local success, result = glSafeCall('glGetString', param, ...)
	if not success then return nil, result end
	if result == nil then return '(null)' end
	return ffi.string(result)
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
		self.getInfoArray = self.getInfoArray or table()
		local getter = args.getter
		local vars = assert(args.vars)
		for _,var in ipairs(vars) do
			local name = assert.index(var, 'name')
			assert.type(name, 'string')
			var.nameValue = op.safeindex(gl, name)
			if var.nameValue then
				-- keep any per-variable assigned getter if it was specified
				var.getter = var.getter or assert(getter, "you must provide a getter on your vars, or a default getter")
				table.insert(self.getInfo, var)
				if self.getInfo[name] then
					error(name.." added twice")
				end
			else
				var.notfound = true
				var.getter = function()
					return nil, name..' not defined'
				end
			end
			self.getInfo[name] = var
			self.getInfoArray:insert(var)	-- if you want to cycle them in order ...
		end
	end

	function template:get(name, ...)
		local var = self.getInfo[name]
		if not var then
			return nil, "failed to find getter associated with "..tostring(name)
		end
		return var.getter(self, var.nameValue, ...)
	end

	return template
end

return {
	-- make a convenient return-based getter for the glGet* functions
	behavior = behavior,
	makeRetLastArg = makeRetLastArg,
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
