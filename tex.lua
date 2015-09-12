local ffi = require 'ffi'
local gl = require 'ffi.OpenGL'
local class = require 'ext.class'
local table = require 'ext.table'


local GLTex = class()

local lookupWrap = {
	s = gl.GL_TEXTURE_WRAP_S,
	t = gl.GL_TEXTURE_WRAP_T,
	r = gl.GL_TEXTURE_WRAP_R,
}

function GLTex:init(args)
	if type(args) == 'string' then
		args = {filename = args}
	else
		args = table(args)
	end
	local tex = ffi.new('GLuint[1]')
	gl.glGenTextures(1, tex)
	self.id = tex[0]

	self:bind()
	if args.filename or args.image then
		self:load(args)
	end
	self:create(args)
	
	if args.minFilter then gl.glTexParameteri(self.target, gl.GL_TEXTURE_MIN_FILTER, args.minFilter) end
	if args.magFilter then gl.glTexParameteri(self.target, gl.GL_TEXTURE_MAG_FILTER, args.magFilter) end
	if args.wrap then self:setWrap(args.wrap) end
end

function GLTex:setWrap(wrap)
	self:bind()
	for k,v in pairs(wrap) do
		k = lookupWrap[k] or k
		assert(k, "tried to set a bad wrap")
		gl.glTexParameteri(self.target, k, v)
	end
end

function GLTex:enable() gl.glEnable(self.target) end
function GLTex:disable() gl.glDisable(self.target) end
function GLTex:bind() gl.glBindTexture(self.target, self.id) end
function GLTex:unbind() gl.glBindTexture(self.target, 0) end

return GLTex
