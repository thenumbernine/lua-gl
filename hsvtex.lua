local ffi = require 'ffi'
local gl = require 'ffi.OpenGL'
local class = require 'ext.class'
local GLTex1D = require 'gl.tex1d'

local HSVTex = class(GLTex1D)

local colors = {
	{1,0,0},
	{1,1,0},
	{0,1,0},
	{0,1,1},
	{0,0,1},
	{1,0,1},
}

function HSVTex:init(w)
	local c = 4
	local d = ffi.new('unsigned char[?]', w*c)
	for i=0,w-1 do
		local f = (i+.5)/w
		f = f * #colors
		local ip = math.floor(f)
		local fn = f - ip
		local fp = 1 - fn
		local n1 = ip+1
		local n2 = n1%#colors + 1
		local c1 = colors[n1]
		local c2 = colors[n2]
		for j=1,3 do
			local c = c1[j] * fp + c2[j] * fn
			d[j-1+c*i] = math.floor(255 * c)
		end
		d[3+c*i] = 255
	end
	HSVTex.super.init(self, {
		width = w,
		image = {
			size = function() return w, 1 end,
			data = function() return d end, 
		},
		minFilter = gl.GL_LINEAR_MIPMAP_LINEAR,
		magFilter = gl.GL_LINEAR,
		generateMipmap = true,
	})
end

return HSVTex
