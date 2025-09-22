local gl = require 'gl'
local GLTex = require 'gl.tex'
local GLTypes = require 'gl.types'

local GLTex2D = GLTex:subclass()

GLTex2D.target = gl.GL_TEXTURE_2D

function GLTex2D:create(args)
	self.target = args.target
	self.level = args.level	-- TODO store? really?
	self.width = args.width
	self.height = args.height
	self.border = args.border
	self.data = args.data

	-- TODO this is duplicated here and gl/tex1d.lua, gl/tex3d.lua
	self.internalFormat = args.internalFormat
	local formatInfo = GLTex.formatInfoForInternalFormat[self.internalFormat]
	-- if these aren't provided then fall back on the self.internalFormat's formatInfo's .types[1] and .format
	self.format = args.format or (formatInfo and formatInfo.format or error("args.format not provided, and couldn't find GLTex.formatInfoForInternalFormat["..tostring(self.internalFormat).."]"))
	self.type = args.type or (formatInfo and formatInfo.types[1] or error("args.type not provided, and couldn't find GLTex.formatInfoForInternalFormat["..tostring(self.internalFormat).."]"))

	gl.glTexImage2D(
		self.target,
		self.level or 0,
		self.internalFormat,
		self.width,
		self.height,
		self.border or 0,
		self.format,
		self.type,
		self.data)
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
		local nw,nh = self.rupowoftwo(w), self.rupowoftwo(h)
		if w ~= nw or h ~= nh then
			image = image:resize(nw, nh, 'nearest')
		end
	end

	args.width = image.width
	args.height = image.height
	args.data = image.buffer
	-- TODO internalFormat needs to be based image.format in the case of using a float tex
	args.internalFormat = args.internalFormat or self.formatForChannels[image.channels]
	args.format = args.format or self.formatForChannels[image.channels] or gl.GL_RGBA
	args.type = args.type or GLTypes.gltypeForCType[image.format] or gl.GL_UNSIGNED_BYTE
end

function GLTex2D:subimage(args)
	gl.glTexSubImage2D(
		args and args.target or self.target,
		args and args.level or 0,
		args and args.xoffset or 0,
		args and args.yoffset or 0,
		args and args.width or self.width,
		args and args.height or self.height,
		args and args.format or self.format,
		args and args.type or self.type,
		args and args.data or self.data
	)
	return self
end

return GLTex2D
