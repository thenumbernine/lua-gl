local GradientTex2D = require 'gl.gradienttex2d'

local HSVTex2D = GradientTex2D:subclass()

HSVTex2D.colors = {
	{1,0,0,1},
	{1,1,0,1},
	{0,1,0,1},
	{0,1,1,1},
	{0,0,1,1},
	{1,0,1,1},
}

return HSVTex2D
