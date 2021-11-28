local ffi = require 'ffi'
local gl = require 'gl'
local class = require 'ext.class'
local GLTex = require 'gl.tex'

local GLTex3D = class(GLTex)

GLTex3D.target = gl.GL_TEXTURE_3D

function GLTex3D:create(args)
	self.width = args.width
	self.height = args.height
	self.depth = args.depth
	gl.glTexImage3D(
		args.target or self.target,
		args.level or 0,
		args.internalFormat,
		args.width,
		args.height,
		args.depth,
		args.border or 0,
		args.format,
		args.type,
		args.data)
end

function GLTex3D:load(args)
	local Image = require 'image'
	local image = args.image
	if not image then
		error('GLTex3D:load expected image')
	end
	assert(image)
	local w,h,d = image:size() 
	local data = image:data()
	local nw,nh,nd = self.rupowoftwo(w), self.rupowoftwo(h), self.rupowoftwo(d)
	if w ~= nw or h ~= nh then
		local ndata = ffi.new('unsigned char[?]', nw*nh*nd*4)
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
	args.type = args.type or self.typeForType[image.format] or gl.GL_UNSIGNED_BYTE
end

return GLTex3D
