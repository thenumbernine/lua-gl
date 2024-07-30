--[[
TODO consistency of bind() before all texture operations?
or how about a flag for whether to always bind before operations?
or just never bind() before operations?
or TODO use bind-less textures?
--]]
local ffi = require 'ffi'
local GCWrapper = require 'ffi.gcwrapper.gcwrapper'
local gl = require 'gl'
local GetBehavior = require 'gl.get'
local class = require 'ext.class'
local table = require 'ext.table'
local op = require 'ext.op'
local bit = bit32 or require 'bit'
local GLTypes = require 'gl.types'

local GLTex = GetBehavior(GCWrapper{
	gctype = 'autorelease_gl_tex_ptr_t',
	ctype = 'GLuint',
	-- retain isn't used
	release = function(ptr)
		return gl.glDeleteTextures(1, ptr)
	end,
}):subclass()

-- assumes tex is already bound to target
local function getteriv(self, namevalue, result)
	-- if we're GL 4.5 then we can use glGetTextureParameter* which accepts self.id (like glGetProgram and like the whole CL API)
	-- but otherwise (incl all GLES) we have to use glGetTexParameter*
	-- GL has glGetTextureParameterfv & -iv
	-- GLES1 has only glGetTexParameterf
	-- GLES2 and 3 have glGetTexParameterf and -i
	return gl.glGetTextureParameteriv(self.target, namevalue, result)
end

-- hmm 'getter' means call the getter above, which is a wrapper for glGet*
-- so mayb i have to put th branch in the getter above fr now ....
-- another TODO is this should be getterf for GLES2 ... and for GLES1 *all* texture getters are getterf ...
local function getterfv(self, namevalue, result)
	return gl.glGetTextureParameterfv(self.target, namevalue, result)
end

GLTex:makeGetter{
	-- default use int
	-- TODO map and assign based on type and on gl version
	getter = getteriv,
	-- https://registry.khronos.org/OpenGL-Refpages/gl4/html/glGetTexParameter.xhtml
	-- would be nice if the docs specified what getter result type was preferred
	vars = {
		{name='GL_TEXTURE_MAG_FILTER', type='GLuint'},
		{name='GL_TEXTURE_MIN_FILTER', type='GLuint'},
		{name='GL_TEXTURE_MIN_LOD', type='GLfloat', getter=getterfv},
		{name='GL_TEXTURE_MAX_LOD', type='GLfloat', getter=getterfv},
		{name='GL_TEXTURE_BASE_LEVEL', type='GLuint'},
		{name='GL_TEXTURE_MAX_LEVEL', type='GLuint'},
		{name='GL_TEXTURE_SWIZZLE_R', type='GLuint'},
		{name='GL_TEXTURE_SWIZZLE_G', type='GLuint'},
		{name='GL_TEXTURE_SWIZZLE_B', type='GLuint'},
		{name='GL_TEXTURE_SWIZZLE_A', type='GLuint'},
		{name='GL_TEXTURE_SWIZZLE_RGBA', type='GLuint[4]'},
		{name='GL_TEXTURE_WRAP_S', type='GLuint'},
		{name='GL_TEXTURE_WRAP_T', type='GLuint'},
		{name='GL_TEXTURE_WRAP_R', type='GLuint'},
		{name='GL_TEXTURE_BORDER_COLOR', type='GLfloat[4]', getter=getterfv},
		{name='GL_TEXTURE_COMPARE_MODE', type='GLuint'},
		{name='GL_TEXTURE_COMPARE_FUNC', type='GLuint'},
		{name='GL_TEXTURE_IMMUTABLE_FORMAT', type='GLuint'},

		-- 4.2 or later
		{name='GL_IMAGE_FORMAT_COMPATIBILITY_TYPE', type='GLuint'},

		-- 4.3 or later
		{name='GL_DEPTH_STENCIL_TEXTURE_MODE', type='GLuint'},
		{name='GL_TEXTURE_VIEW_MIN_LEVEL', type='GLuint'},
		{name='GL_TEXTURE_VIEW_NUM_LEVELS', type='GLuint'},
		{name='GL_TEXTURE_VIEW_MIN_LAYER', type='GLuint'},
		{name='GL_TEXTURE_VIEW_NUM_LAYERS', type='GLuint'},
		{name='GL_TEXTURE_IMMUTABLE_LEVELS', type='GLuint'},

		-- 4.5 or later
		{name='GL_TEXTURE_TARGET', type='GLuint'},
	},
}

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
GLTex.channelsForFormat = table{
	GL_LUMINANCE = 1,
	GL_RGB = 3,
	GL_RGBA = 4,
	-- TODO this table is long.
}:map(function(v,k)
	k = op.safeindex(gl, k)
	if not k then return end
	return v, k
end):setmetatable(nil)

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
