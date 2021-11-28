local ffi = require 'ffi'
local gl = require 'gl'
local class = require 'ext.class'
local table = require 'ext.table'

ffi.cdef[[
typedef struct gl_tex_ptr_t {
	GLuint ptr[1];
} gl_tex_ptr_t;
]]
local gl_tex_ptr_t = ffi.metatype('gl_tex_ptr_t', {
	__gc = function(tex)
		if tex.ptr[0] ~= 0 then
			gl.glDeleteTextures(1, tex.ptr)
			tex.ptr[0] = 0
		end
	end,
})

local GLTex = class()

function GLTex:init(args)
	if type(args) == 'string' then
		args = {filename = args}
	else
		args = table(args)
	end

	-- redundant with id
	-- but I need something ffi ctype to do a gc
	-- for automatic glDeleteTextures
	-- and I'll be using a like ptr for that routine as well 
	self.idPtr = gl_tex_ptr_t()
	
	gl.glGenTextures(1, self.idPtr.ptr)
	self.id = self.idPtr.ptr[0]

	self:bind()
	if args.filename or args.image then
		self:load(args)
	end
	self:create(args)
	
	if args.minFilter then self:setParameter(gl.GL_TEXTURE_MIN_FILTER, args.minFilter) end
	if args.magFilter then self:setParameter(gl.GL_TEXTURE_MAG_FILTER, args.magFilter) end
	if args.wrap then self:setWrap(args.wrap) end
	if args.generateMipmap then gl.glGenerateMipmap(self.target) end
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

function GLTex:delete()
	if self.idPtr.ptr[0] ~= 0 then
		gl.glDeleteTextures(1, self.idPtr.ptr)
		self.idPtr.ptr[0] = 0
		self.id = 0
	end
end

-- used by child classes:

GLTex.resizeNPO2 = false

GLTex.formatForChannels = {
	[1] = gl.GL_LUMINANCE,
	[3] = gl.GL_RGB,
	[4] = gl.GL_RGBA,
}

GLTex.typeForType = {
	['char'] = gl.GL_UNSIGNED_BYTE,
	['signed char'] = gl.GL_UNSIGNED_BYTE,
	['unsigned char'] = gl.GL_UNSIGNED_BYTE,
	['int8_t'] = gl.GL_UNSIGNED_BYTE,
	['uint8_t'] = gl.GL_UNSIGNED_BYTE,
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

return GLTex
