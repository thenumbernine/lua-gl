local ffi = require 'ffi'
local GCWrapper = require 'ffi.gcwrapper.gcwrapper'
local gl = require 'gl'
local class = require 'ext.class'
local table = require 'ext.table'

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

local lookupWrap = {
	s = gl.GL_TEXTURE_WRAP_S,
	t = gl.GL_TEXTURE_WRAP_T,
	r = gl.GL_TEXTURE_WRAP_R,
}

function GLTex:setWrap(wrap)
	self:bind()
	for k,v in pairs(wrap) do
		k = lookupWrap[k] or k
		assert(k, "tried to set a bad wrap")
		self:setParameter(k, v)
	end
end

function GLTex:setParameter(k, v)
	if type(k) == 'string' then k = gl[k] or error("couldn't find parameter "..k) end
	-- TODO pick by type? and expose each type call separately?
	return gl.glTexParameterf(self.target, k, v)
end

function GLTex:enable() gl.glEnable(self.target) end
function GLTex:disable() gl.glDisable(self.target) end

function GLTex:bind(unit)
	if unit then
		gl.glActiveTexture(gl.GL_TEXTURE0 + unit)
	end
	gl.glBindTexture(self.target, self.id)
end

function GLTex:unbind(unit)
	if unit then
		gl.glActiveTexture(gl.GL_TEXTURE0 + unit)
	end
	gl.glBindTexture(self.target, 0)
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
GLTex.cypeForGLType = {
	-- these types are per-channel
	[gl.GL_UNSIGNED_BYTE] = 'uint8_t',
	[gl.GL_BYTE] = 'int8_t',
	[gl.GL_UNSIGNED_SHORT] = 'uint16_t',
	[gl.GL_SHORT] = 'int16_t',
	[gl.GL_UNSIGNED_INT] = 'uint32_t',
	[gl.GL_INT] = 'int32_t',
	[gl.GL_HALF_FLOAT] = 'uint16_t',
	[gl.GL_FLOAT] = 'float',
	-- these types incorporate all channels
	[gl.GL_UNSIGNED_BYTE_3_3_2] = 'uint8_t',
	[gl.GL_UNSIGNED_BYTE_2_3_3_REV] = 'uint8_t',
	[gl.GL_UNSIGNED_SHORT_5_6_5] = 'uint16_t',
	[gl.GL_UNSIGNED_SHORT_5_6_5_REV] = 'uint16_t',
	[gl.GL_UNSIGNED_SHORT_4_4_4_4] = 'uint16_t',
	[gl.GL_UNSIGNED_SHORT_4_4_4_4_REV] = 'uint16_t',
	[gl.GL_UNSIGNED_SHORT_5_5_5_1] = 'uint16_t',
	[gl.GL_UNSIGNED_SHORT_1_5_5_5_REV] = 'uint16_t',
	[gl.GL_UNSIGNED_INT_8_8_8_8] = 'uint32_t',
	[gl.GL_UNSIGNED_INT_8_8_8_8_REV] = 'uint32_t',
	[gl.GL_UNSIGNED_INT_10_10_10_2] = 'uint32_t',
	[gl.GL_UNSIGNED_INT_2_10_10_10_REV] = 'uint32_t',
}

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

function GLTex:generateMipmap()
	gl.glGenerateMipmap(self.target)
end

function GLTex:toCPU(ptr, level)
	if not ptr then
		-- TODO need to map from format to channels
		-- TOOD need to map from GL type to C type
		--ptr = ffi.new('uint8_t[?]', size)
		error("expected ptr")
	end
	-- TODO .keep to keep the ptr upon init, and default to it here?
	self:bind()
	gl.glGetTexImage(self.target, level or 0, self.format, self.type, ptr)
	return ptr
end

return GLTex
