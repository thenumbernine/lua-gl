local ffi = require 'ffi'
local gl = require 'gl'
local GLTex = require 'gl.tex'
local GLTypes = require 'gl.types'


local uint8_t_arr = ffi.typeof'uint8_t[?]'


local GLTex3D = GLTex:subclass()

GLTex3D.target = gl.GL_TEXTURE_3D

function GLTex3D:create(args)
	self.target = args.target
	self.level = args.level	-- TODO store? really?
	self.width = args.width
	self.height = args.height
	self.depth = args.depth
	self.border = args.border
	self.data = args.data
	self.immutable = args.immutable

	-- TODO this is duplicated here and gl/tex1d.lua, gl/tex2d.lua
	self.internalFormat = args.internalFormat
	local formatInfo = GLTex.formatInfoForInternalFormat[self.internalFormat]
	-- if these aren't provided then fall back on the self.internalFormat's formatInfo's .types[1] and .format
	self.format = args.format or (formatInfo and formatInfo.format)
	self.type = args.type or (formatInfo and formatInfo.types[1] or error("args.type not provided, and couldn't find GLTex.formatInfoForInternalFormat["..tostring(self.internalFormat).."]"))

	if self.immutable then
		self.levels = args.levels	-- needs how many up front
		gl.glTexStorage3D(
			self.target,
			self.levels or 1,
			self.internalFormat,
			self.width,
			self.height,
			self.depth)
		if self.data then
			self:subimage()
		end
	else
		gl.glTexImage3D(
			self.target,
			self.level or 0,
			self.internalFormat,
			self.width,
			self.height,
			self.depth,
			self.border or 0,
			self.format,
			self.type,
			self.data)
	end
end

function GLTex3D:load(args)
	local image = args.image
	if not image then
		error('GLTex3D:load expected image')
	end
	assert(image)
	local w,h,d = image:size()
	local data = image:data()
	local nw,nh,nd = self.rupowoftwo(w), self.rupowoftwo(h), self.rupowoftwo(d)
	if w ~= nw or h ~= nh then
		local ndata = uint8_t_arr(nw*nh*nd*4)
		for nz=0,nd-1 do
			for ny=0,nh-1 do
				for nx=0,nw-1 do
					local x = math.floor(nx*(w-1)/(nw-1))
					local y = math.floor(ny*(h-1)/(nh-1))
					local z = math.floor(nz*(d-1)/(nd-1))
					for c=0,3 do
						ndata[c+4*(nx+nw*(ny+nh*nz))] = data[c+4*(x+w*(y+h*z))]
					end
				end
			end
		end
		data = ndata
		w,h,d = nw,nh,nd
	end
	args.width, args.height, args.depth = w, h, d
	args.data = data
	args.internalFormat = args.internalFormat or self.formatForChannels[image.channels]
	args.format = args.format or self.formatForChannels[image.channels] or gl.GL_RGBA
	args.type = args.type or GLTypes.gltypeForCType[tostring(image.format)] or gl.GL_UNSIGNED_BYTE
end

function GLTex3D:subimage(args)
	gl.glTexSubImage3D(
		args and args.target or self.target,
		args and args.level or 0,
		args and args.xoffset or 0,
		args and args.yoffset or 0,
		args and args.zoffset or 0,
		args and args.width or self.width,
		args and args.height or self.height,
		args and args.depth or self.depth,
		args and args.format or self.format,
		args and args.type or self.type,
		args and args.data or self.data
	)
	return self
end

return GLTex3D
