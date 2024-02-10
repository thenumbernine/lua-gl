local GradientTex = require 'gl.gradienttex'

local HSVTex = GradientTex:subclass()

HSVTex.colors = {
	{1,0,0,1},
	{1,1,0,1},
	{0,1,0,1},
	{0,1,1,1},
	{0,0,1,1},
	{1,0,1,1},
}

return HSVTex
