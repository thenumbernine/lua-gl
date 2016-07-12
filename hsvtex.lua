local class = require 'ext.class'
local GradientTex = require 'gl.gradienttex'

local HSVTex = class(GradientTex)

HSVTex.colors = {
	{1,0,0,1},
	{1,1,0,1},
	{0,1,0,1},
	{0,1,1,1},
	{0,0,1,1},
	{1,0,1,1},
}

return HSVTex
