local gl = require 'gl'
local table = require 'ext.table'
local GLTex = require 'gl.tex'
local GLTex2D = require 'gl.tex2d'

local GLTexCube = GLTex:subclass()

GLTexCube.target = gl.GL_TEXTURE_CUBE_MAP

function GLTexCube:create(args)
	-- now args.data should be a 6-indexed array of whatever data you were gonna pass the texture
	local data = args.data or {}
	if args.filenames then data = {} end	-- I'm breaking with tradition: no more GLTexCube.load, now just through the ctor
	local baseWidth = args.width
	local baseHeight = args.height

	-- TODO redo this like tex1d/2d/3d to use internalFormat first's info as defaults for format and type...
	-- ... but it looks like, with the channels detect below, there's pieces of the image-loader mixed in here...
	-- ... so I won't do it right now.
	local baseInternalFormat = args.internalFormat or args.format
	local baseFormat = args.format
	local baseType = args.type

	for i=1,6 do
		local width = baseWidth
		local height = baseHeight

		local internalFormat = baseInternalFormat
		local format = baseFormat
		local glType = baseType

		if args.filenames then
			local filename = args.filenames[i]
			local Image = require 'image'
			local image = Image(filename)
			if baseWidth and baseHeight then image = image:resample(baseWidth, baseHeight) end
			data[i] = image:data()

			local channels
			width, height, channels = image:size()
			glType = gl.GL_UNSIGNED_BYTE
			if channels == 3 then
				format = gl.GL_RGB
				internalFormat = gl.GL_RGB
			else
				format = gl.GL_RGBA
				internalFormat = gl.GL_RGBA
			end
		end
		-- hijacking from GLTex2D...
		GLTex2D.create(self, table(args, {
			target = (args.target or gl.GL_TEXTURE_CUBE_MAP_POSITIVE_X) + i-1,
			data = data[i],
			format = format,
			internalFormat = internalFormat,
			type = glType,
			width = width,
			height = height,
		}))
	end
	self.target = nil
end

return GLTexCube
