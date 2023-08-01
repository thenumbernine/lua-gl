--[[
TODO consistency of bind() before all texture operations?
or how about a flag for whether to always bind before operations?
or just never bind() before operations?
or TODO use bind-less textures?
--]]
local ffi = require 'ffi'
local GCWrapper = require 'ffi.gcwrapper.gcwrapper'
local gl = require 'gl'
local class = require 'ext.class'
local table = require 'ext.table'
local op = require 'ext.op'

local GLTex = class(GCWrapper{
	gctype = 'autorelease_gl_tex_ptr_t',
	ctype = 'GLuint',
	-- retain isn't used
	release = function(ptr)
		return gl.glDeleteTextures(1, ptr)
	end,
})

function GLTex:init(args)
	if type(args) == 'string' then
		args = {filename = args}
	else
		args = table(args)
	end

	-- [[ have the refcount initialize with a null pointer
	GLTex.super.init(self)
	gl.glGenTextures(1, self.gc.ptr)
	self.id = self.gc.ptr[0]
	--]]
	--[[ have it initialize with our proper pointer .. requires an extra allocation
	local idptr = ffi.new('GLuint[1]', 0)
	gl.glGenTextures(1, idptr)
	GLTex.super.init(self, idptr[0])
	--]]

	self:bind()
	if args.filename or args.image then
		self:load(args)
	end
	self:create(args)

	if args.minFilter then self:setParameter(gl.GL_TEXTURE_MIN_FILTER, args.minFilter) end
	if args.magFilter then self:setParameter(gl.GL_TEXTURE_MAG_FILTER, args.magFilter) end
	if args.wrap then self:setWrap(args.wrap) end
	if args.generateMipmap then self:generateMipmap() end
end

-- luajit ... why break from lua behavior on table/keys not existing?
-- why does cdata throw exceptions when members are missing
local function safeget(t, k)
	local res, v = pcall(function() return t[k] end)
	if res then return v end
end

local lookupWrap = {
	s = gl.GL_TEXTURE_WRAP_S,
	t = gl.GL_TEXTURE_WRAP_T,
	-- gles 1 & 2 doesn't have GL_TEXTURE_WRAP_R
	r = op.safeindex(gl, 'GL_TEXTURE_WRAP_R'),
}

function GLTex:setWrap(wrap)
	for k,v in pairs(wrap) do
		k = lookupWrap[k] or k
		assert(k, "tried to set a bad wrap")
		self:setParameter(k, v)
	end
	return self
end

function GLTex:setParameter(k, v)
	if type(k) == 'string' then k = gl[k] or error("couldn't find parameter "..k) end
	-- TODO pick by type? and expose each type call separately?
	gl.glTexParameterf(self.target, k, v)
	return self
end

function GLTex:enable()
	gl.glEnable(self.target)
	return self
end

function GLTex:disable()
	gl.glDisable(self.target)
	return self
end

function GLTex:bind(unit)
	if unit then
		gl.glActiveTexture(gl.GL_TEXTURE0 + unit)
	end
	gl.glBindTexture(self.target, self.id)
	return self
end

function GLTex:unbind(unit)
	if unit then
		gl.glActiveTexture(gl.GL_TEXTURE0 + unit)
	end
	gl.glBindTexture(self.target, 0)
	return self
end

-- used by child classes:

GLTex.resizeNPO2 = false

GLTex.formatForChannels = {
	[1] = gl.GL_LUMINANCE,
	[3] = gl.GL_RGB,
	[4] = gl.GL_RGBA,
}

-- inverse of 'formatForChannels'
GLTex.channelsForFormat = {
	-- TODO this table is long.
}

GLTex.typeForType = {
	['char'] = gl.GL_UNSIGNED_BYTE,
	['signed char'] = gl.GL_UNSIGNED_BYTE,
	['unsigned char'] = gl.GL_UNSIGNED_BYTE,
	['int8_t'] = gl.GL_UNSIGNED_BYTE,
	['uint8_t'] = gl.GL_UNSIGNED_BYTE,
}

-- inverse of 'typeForType' (which I should rename)
GLTex.ctypeForGLType = table{
	-- these types are per-channel
	{'GL_UNSIGNED_BYTE', 'uint8_t'},
	{'GL_BYTE', 'int8_t'},
	{'GL_UNSIGNED_SHORT', 'uint16_t'},
	{'GL_SHORT', 'int16_t'},
	{'GL_UNSIGNED_INT', 'uint32_t'},
	{'GL_INT', 'int32_t'},
	{'GL_FLOAT', 'float'},
	-- these types incorporate all channels
	{'GL_HALF_FLOAT', 'uint16_t'},
	{'GL_UNSIGNED_BYTE_3_3_2', 'uint8_t'},
	{'GL_UNSIGNED_BYTE_2_3_3_REV', 'uint8_t'},
	{'GL_UNSIGNED_SHORT_5_6_5', 'uint16_t'},
	{'GL_UNSIGNED_SHORT_5_6_5_REV', 'uint16_t'},
	{'GL_UNSIGNED_SHORT_4_4_4_4', 'uint16_t'},
	{'GL_UNSIGNED_SHORT_4_4_4_4_REV', 'uint16_t'},
	{'GL_UNSIGNED_SHORT_5_5_5_1', 'uint16_t'},
	{'GL_UNSIGNED_SHORT_1_5_5_5_REV', 'uint16_t'},
	{'GL_UNSIGNED_INT_8_8_8_8', 'uint32_t'},
	{'GL_UNSIGNED_INT_8_8_8_8_REV', 'uint32_t'},
	{'GL_UNSIGNED_INT_10_10_10_2', 'uint32_t'},
	{'GL_UNSIGNED_INT_2_10_10_10_REV', 'uint32_t'},
}:mapi(function(p)
	-- some of these are not in GLES so ...
	-- luajit cdata doesn't let you test for existence with a simple nil value
	local k = op.safeindex(gl, p[1])
	if not k then return nil end
	return p[2], k
end):setmetatable(nil)

local bit = bit32 or require 'bit'

-- static method (self not required)
function GLTex.rupowoftwo(x)
	local u = 1
	x = x - 1
	while x > 0 do
		x = bit.rshift(x,1)
		u = bit.lshift(u,1)
	end
	return u
end

-- requires bind beforehand (TODO should this also bind?)
function GLTex:generateMipmap()
	gl.glGenerateMipmap(self.target)
	return self
end

-- TODO well if now I'm storing .data ...
function GLTex:toCPU(ptr, level)
	if not ptr then
		-- TODO need to map from format to channels
		-- TOOD need to map from GL type to C type
		--ptr = ffi.new('uint8_t[?]', size)
		-- or TODO default to self.data, that was used for initial texture creation?
		error("expected ptr")
	end
	-- TODO .keep to keep the ptr upon init, and default to it here?
	-- TODO require bind() beforehand like all the other setters? or manually bind() here?
	self:bind()
	gl.glGetTexImage(self.target, level or 0, self.format, self.type, ffi.cast('char*', ptr))
	return ptr
end

return GLTex
