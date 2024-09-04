--[[
TODO consistency of bind() before all texture operations?
or how about a flag for whether to always bind before operations?
or just never bind() before operations?
or TODO use bind-less textures?
--]]
require 'ext.gc'	-- make sure luajit can __gc lua-tables
local ffi = require 'ffi'
local gl = require 'gl'
local GLGet = require 'gl.get'
local class = require 'ext.class'
local table = require 'ext.table'
local op = require 'ext.op'
local bit = bit32 or require 'bit'
local GLTypes = require 'gl.types'

local GLTex = GLGet.behavior()

local glRetTexParami = GLGet.returnLastArgAsType('glGetTextureParameteriv', 'GLint')
local function getteri(self, nameValue)
	-- if we're GL 4.5 then we can use glGetTextureParameter* which accepts self.id (like glGetProgram and like the whole CL API)
	-- but otherwise (incl all GLES) we have to use glGetTexParameter*
	-- GL has glGetTextureParameterfv & -iv
	-- GLES1 has only glGetTexParameterf
	-- GLES2 and 3 have glGetTexParameterf and -i
	return glRetTexParami(self.target, nameValue)
end

-- hmm 'getter' means call the getter above, which is a wrapper for glGet*
-- so mayb i have to put th branch in the getter above fr now ....
-- another TODO is this should be getterf for GLES2 ... and for GLES1 *all* texture getters are getterf ...
local glRetTexParamf = GLGet.returnLastArgAsType('glGetTextureParameterfv', 'GLfloat')
local function glRetTexParamfForObj(self, nameValue)
	return glRetTexParamf(self.target, nameValue)
end

local glRetTexParamf4 = GLGet.returnLastArgAsType('glGetTextureParameterfv', 'GLfloat', 4)
local function glRetTexParamf4ForObj(self, nameValue)
	return glRetTexParamf4(self.target, nameValue)
end

GLTex:makeGetter{
	-- default use int
	-- TODO map and assign based on type and on gl version
	getter = getteri,
	-- https://registry.khronos.org/OpenGL-Refpages/gl4/html/glGetTexParameter.xhtml
	-- would be nice if the docs specified what getter result type was preferred
	vars = {
		{name='GL_TEXTURE_MAG_FILTER'},
		{name='GL_TEXTURE_MIN_FILTER'},
		{name='GL_TEXTURE_MIN_LOD', getter=glRetTexParamfForObj},
		{name='GL_TEXTURE_MAX_LOD', getter=glRetTexParamfForObj},
		{name='GL_TEXTURE_BASE_LEVEL'},
		{name='GL_TEXTURE_MAX_LEVEL'},
		{name='GL_TEXTURE_SWIZZLE_R'},
		{name='GL_TEXTURE_SWIZZLE_G'},
		{name='GL_TEXTURE_SWIZZLE_B'},
		{name='GL_TEXTURE_SWIZZLE_A'},
		{name='GL_TEXTURE_SWIZZLE_RGBA', getter=glRetTexParamf4ForObj},
		{name='GL_TEXTURE_WRAP_S'},
		{name='GL_TEXTURE_WRAP_T'},
		{name='GL_TEXTURE_WRAP_R'},
		{name='GL_TEXTURE_BORDER_COLOR', getter=glRetTexParamf4ForObj},
		{name='GL_TEXTURE_COMPARE_MODE'},
		{name='GL_TEXTURE_COMPARE_FUNC'},
		{name='GL_TEXTURE_IMMUTABLE_FORMAT'},

		-- 4.2 or later
		{name='GL_IMAGE_FORMAT_COMPATIBILITY_TYPE'},

		-- 4.3 or later
		{name='GL_DEPTH_STENCIL_TEXTURE_MODE'},
		{name='GL_TEXTURE_VIEW_MIN_LEVEL'},
		{name='GL_TEXTURE_VIEW_NUM_LEVELS'},
		{name='GL_TEXTURE_VIEW_MIN_LAYER'},
		{name='GL_TEXTURE_VIEW_NUM_LAYERS'},
		{name='GL_TEXTURE_IMMUTABLE_LEVELS'},

		-- 4.5 or later
		{name='GL_TEXTURE_TARGET'},
	},
}

function GLTex:init(args)
	if type(args) == 'string' then
		args = {filename = args}
	else
		args = table(args)
	end

	local ptr = ffi.new'GLuint[1]'
	gl.glGenTextures(1, ptr)
	self.id = ptr[0]

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

function GLTex:delete()
	if self.id == nil then return end
	local ptr = ffi.new'GLuint[1]'
	ptr[0] = self.id
	gl.glDeleteTextures(1, ptr)
	self.id = nil
end

GLTex.__gc = GLTex.delete


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
	[1] = op.safeindex(gl, 'GL_LUMINANCE') or nil,
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
