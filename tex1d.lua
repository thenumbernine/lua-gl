local gl = require 'gl'
local GLTex = require 'gl.tex'
local GLTypes = require 'gl.types'

local GLTex1D = GLTex:subclass()

GLTex1D.target = gl.GL_TEXTURE_1D

function GLTex1D:create(args)
	self.target = args.target
	self.level = args.level	-- TODO store? really?
	self.width = args.width
	self.border = args.border
	self.data = args.data
	self.immutable = args.immutable

	-- TODO this is duplicated here and gl/tex2d.lua, gl/tex3d.lua
	self.internalFormat = args.internalFormat
	local formatInfo = GLTex.formatInfoForInternalFormat[self.internalFormat]
	-- if these aren't provided then fall back on the self.internalFormat's formatInfo's .types[1] and .format
	self.format = args.format or (formatInfo and formatInfo.format or error("args.format not provided, and couldn't find GLTex.formatInfoForInternalFormat["..tostring(self.internalFormat).."]"))
	self.type = args.type or (formatInfo and formatInfo.types[1] or error("args.type not provided, and couldn't find GLTex.formatInfoForInternalFormat["..tostring(self.internalFormat).."]"))

	if self.immutable then
		self.levels = args.levels
		gl.glTexStorage1D(
			self.target,
			self.levels or 1,
			self.internalFormat,
			self.width)
		if self.data then
			self:subimage()
		end
	else
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
	args.type = args.type or GLTypes.gltypeForCType[tostring(image.format)] or gl.GL_UNSIGNED_BYTE
end

return GLTex1D
