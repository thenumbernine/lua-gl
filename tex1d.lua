local ffi = require 'ffi'
local gl = require 'gl'
local class = require 'ext.class'
local GLTex = require 'gl.tex'

local GLTex1D = class(GLTex)

GLTex1D.target = gl.GL_TEXTURE_1D

function GLTex1D:create(args)
	self.width = args.width
	gl.glTexImage1D(
		args.target or self.target,
		args.level or 0,
		args.internalFormat,
		args.width,
		args.border or 0,
		args.format,
		args.type,
		args.data)
end

function GLTex1D:load(args)
	local image = args.image
	if not image then
		local filename = tostring(args.filename)
		if not filename then
			error('GLTex1D:load expected image or filename')
		end
		local Image = require 'image'
		image = Image(filename)
	end
	assert(image)
	
	if self.resizeNPO2 then
		local w,h = image.width, image.height
		local data = image.buffer
		local nw,nh = self.rupowoftwo(w), self.rupowoftwo(h)
		if w ~= nw or h ~= nh then
			image = image:resize(nw, nh, 'nearest')
		end
	end

	args.width = image.width
	args.data = data 
	args.internalFormat = args.internalFormat or self.formatForChannels[image.channels]
	args.format = args.format or self.formatForChannels[image.channels] or gl.GL_RGBA
	args.type = args.type or self.typeForType[image.format] or gl.GL_UNSIGNED_BYTE
end

return GLTex1D
