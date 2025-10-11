local ffi = require 'ffi'
local gl = require 'gl'

local uint8_t_arr = ffi.typeof'uint8_t[?]'

-- TODO hmmmm
-- TEXTURE_1D is allowed in latest GL
-- but not in GLES
-- so I can't design desktop-GL to work with GLSL 320 ES  and use a GL_TEXTURE_1D-exists check here to see if it's compat, because it'll be compat with the API but not the shader
-- so maybe for compatability I should change this to be Tex2D-based?
-- or maybe I should just have a gradienttex2d option?
local Tex1D = require 'gl.tex1d'

local GradientTex = Tex1D:subclass()

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
