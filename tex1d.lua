local gl = require 'gl'
local GLTex = require 'gl.tex'

local GLTex1D = GLTex:subclass()

GLTex1D.target = gl.GL_TEXTURE_1D

function GLTex1D:create(args)
	self.target = args.target
	self.level = args.level	-- TODO store? really?
	self.internalFormat = args.internalFormat
	self.width = args.width
	self.border = args.border
	self.format = args.format
	self.type = args.type
	self.data = args.data
	gl.glTexImage1D(
		self.target,
		self.level or 0,
		self.internalFormat,
		self.width,
		self.border or 0,
		self.format,
		self.type,
		self.data)
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
		local nw,nh = self.rupowoftwo(w), self.rupowoftwo(h)
		if w ~= nw or h ~= nh then
			image = image:resize(nw, nh, 'nearest')
		end
	end

	args.width = image.width
	args.data = image.buffer
	args.internalFormat = args.internalFormat or self.formatForChannels[image.channels]
	args.format = args.format or self.formatForChannels[image.channels] or gl.GL_RGBA
	args.type = args.type or self.typeForType[image.format] or gl.GL_UNSIGNED_BYTE
end

return GLTex1D
