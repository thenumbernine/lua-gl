local ffi = require 'ffi'
local gl = require 'gl'
local class = require 'ext.class'
local GLTex = require 'gl.tex'

local GLTex2D = class(GLTex)

GLTex2D.target = gl.GL_TEXTURE_2D

function GLTex2D:create(args)
	self.width = args.width
	self.height = args.height
	gl.glTexImage2D(
		args.target or self.target,
		args.level or 0,
		args.internalFormat,
		args.width,
		args.height,
		args.border or 0,
		args.format,
		args.type,
		args.data)
end

function GLTex2D:load(args)
	local image = args.image
	if not image then
		local filename = tostring(args.filename)
		if not filename then
			error('GLTex2D:load expected image or filename')
		end
		local Image = require 'image'
		image = Image(filename)
	end
	assert(image)

	if self.resizeNPO2 then	
		local w, h = image.width, image.height
		local data = image.buffer
		local nw,nh = self.rupowoftwo(w), self.rupowoftwo(h)
		if w ~= nw or h ~= nh then
			image = image:resize(nw, nh, 'nearest')
		end
	end
	
	args.width = image.width
	args.height = image.height
	args.data = image.buffer
	args.internalFormat = args.internalFormat or self.formatForChannels[image.channels]
	args.format = args.format or self.formatForChannels[image.channels] or gl.GL_RGBA
	args.type = args.type or self.typeForType[image.format] or gl.GL_UNSIGNED_BYTE
end

return GLTex2D
