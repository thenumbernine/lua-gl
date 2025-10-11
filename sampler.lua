require 'ext.gc'	-- make sure luajit can __gc lua-tables
local ffi = require 'ffi'
local class = require 'ext.class'
local gl = require 'gl'
local GLTex = require 'gl.tex'

local GLuint_1 = ffi.typeof'GLuint[1]'

local GLSampler = class()

function GLSampler:init(args)
	local ptr = GLuint_1()
	gl.glGenSamplers(1, ptr)
	self.id = ptr[0]

	-- this much in common with GLTex:
	if args.minFilter then self:setParameter(gl.GL_TEXTURE_MIN_FILTER, args.minFilter) end
	if args.magFilter then self:setParameter(gl.GL_TEXTURE_MAG_FILTER, args.magFilter) end
	if args.wrap then self:setWrap(args.wrap) end
	if args.generateMipmap then self:generateMipmap() end
end

function GLSampler:delete()
	if self.id == nil then return end
	local ptr = GLuint_1(self.id)
	gl.glDeleteSamplers(1, ptr)
	self.id = nil
end

GLSampler.__gc = GLSampler.delete

local lookupWrap = GLTex.lookupWrap

-- in common with GLTex
function GLSampler:setWrap(wrap)
	for k,v in pairs(wrap) do
		k = lookupWrap[k] or k
		assert(k, "tried to set a bad wrap")
		self:setParameter(k, v)
	end
	return self
end

-- in common with GLTex
function GLSampler:setParameter(k, v)
	if type(k) == 'string' then k = gl[k] or error("couldn't find parameter "..k) end
	-- TODO pick by type? and expose each type call separately?
	gl.glSamplerParameterf(self.id, k, v)
	return self
end

function GLSampler:bind(unit)
	gl.glBindSampler(unit, self.id)
	return self
end

function GLSampler:unbind(unit)
	gl.glBindSampler(unit, 0)
	return self
end

return GLSampler
