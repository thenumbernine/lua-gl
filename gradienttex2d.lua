-- right now this is just a copy of gradient-1D but as a 2D texture.
-- hmm trying to think how to expose gradienttex as either 1D or 2D by API choice
-- when desktop still supports 1D, but ES doesn't support 1D ...
-- TODO maybe generalize it to a 2D gradient, or to a 2D procedural texture, or something
-- or generalize procedural/function-driven textures from the function-driven Image API, 
-- and just provide the 1D or 2D gradient-generation functiosn?

local ffi = require 'ffi'
local gl = require 'gl'
local Tex2D = require 'gl.tex2d'

local uint8_t_arr = ffi.typeof'uint8_t[?]'

local GradientTex = Tex2D:subclass()

function GradientTex:init(w, colors, repeated)
	self.colors = colors

	local channels = 4
	local data = uint8_t_arr(w*channels)
	for i=0,w-1 do
		local f = (i+.5)/w	-- texel normalized coordinate
		f = f * (repeated and #self.colors or (#self.colors-1))	-- find the associated color in the gradient
		local ip = math.floor(f)
		local fn = f - ip
		local fp = 1 - fn
		local n1 = ip+1
		local n2 = n1+1
		if repeated then n2 = n1 % #self.colors + 1 end
		local c1 = self.colors[n1]
		local c2 = self.colors[n2]
		for j=1,4 do
			local c = c1[j] * fp + c2[j] * fn
			data[j-1+channels*i] = math.floor(255 * c)
		end
	end
	GradientTex.super.init(self, {
		internalFormat = gl.GL_RGBA,
		width = w,
		height = 1,
		format = gl.GL_RGBA,
		type = gl.GL_UNSIGNED_BYTE,
		data = data,
		minFilter = gl.GL_NEAREST,
		magFilter = gl.GL_NEAREST,
		wrap = {
			s = repeated and gl.GL_REPEAT or gl.GL_CLAMP_TO_EDGE,
		},
	})
end

return GradientTex
