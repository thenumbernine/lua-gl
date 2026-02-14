#!/usr/bin/env luajit
-- put this here or in gl ? or in imgui.app ?
local cmdline = require 'ext.cmdline'(...)
local sdl, SDLApp = require 'sdl.setup' (cmdline.sdl)
local gl = require 'gl.setup' (cmdline.gl)
local ffi = require 'ffi'
local table = require 'ext.table'

local GLTexCube = require 'gl.texcube'

local App = require 'imgui.appwithorbit'()

App.title = "Cubemaps"

-- TODO provide your own skybox
local base = cmdline.skybox
--base = base or '../../seashell/beach-skyboxes/HeartInTheSand/'	-- uses pos/neg xyz
base = base or '../../seashell/cloudy/bluecloud_'	-- uses ft bk up dn rt lf

App.viewDist = 1e-7

-- each value has the x,y,z in the 0,1,2 bits (off = 0, on = 1)
local cubeFaces = {
	{5,7,3,1},	-- x+
	{6,4,0,2},	-- x-
	{2,3,7,6},	-- y+
	{4,5,1,0},	-- y-
	{6,7,5,4},	-- z+
	{0,1,3,2},	-- z-
}

function App:initGL(...)
	App.super.initGL(self, ...)
	
	local tex = GLTexCube{
		--[[
		filenames = {
			base..'posx.jpg',
			base..'negx.jpg',
			base..'posy.jpg',
			base..'negy.jpg',
			base..'posz.jpg',
			base..'negz.jpg',
		},
		--]]
		-- [[
		filenames = {
			base..'ft.jpg',
			base..'bk.jpg',
			base..'up.jpg',
			base..'dn.jpg',
			base..'rt.jpg',
			base..'lf.jpg',
		},	
		--]]
		wrap={
			s=gl.GL_CLAMP_TO_EDGE,
			t=gl.GL_CLAMP_TO_EDGE,
			r=gl.GL_CLAMP_TO_EDGE,
		},
		magFilter = gl.GL_LINEAR,
		minFilter = gl.GL_LINEAR,
	}:unbind()

	local vtxdata = table()
	local s = 1
	-- [[ using bitvectors
	for dim=0,2 do
		for bit2 = 0,1 do	-- plus/minus side
			local quad = table()
			for bit1 = 0,1 do	-- v texcoord
				for bit0 = 0,1 do	-- u texcoord
					local i2 = bit.bor(
						bit.bxor(bit0, bit1, bit2),
						bit.lshift(bit1, 1),
						bit.lshift(bit2, 2)
					)
					-- now rotate i2 by dim
					--[=[
					local i = bit.bor(
						bit.lshift(bit.band(1, i2), (dim+0)%3),
						bit.lshift(bit.band(1, bit.rshift(i2, 1)), (dim+1)%3),
						bit.lshift(bit2, (dim+2)%3)
					)
					--]=]
					-- [=[
					local i = bit.band(7, bit.bor(
						bit.lshift(i2, dim),
						bit.rshift(i2, 3 - dim)
					))
					--]=]
					local x = bit.band(1, i)
					local y = bit.band(1, bit.rshift(i, 1))
					local z = bit.band(1, bit.rshift(i, 2))
					quad:insert{s*(x*2-1),s*(y*2-1),s*(z*2-1)}
				end
			end
			for _,i in ipairs{1,2,4,4,2,3} do
				vtxdata:append(quad[i])
			end
		end
	end
	--]]
	--[[ using cubeFaces
	for _,face in ipairs(cubeFaces) do
		local quad = table()
		for _,i in ipairs(face) do
			local x = bit.band(i, 1)
			local y = bit.band(bit.rshift(i, 1), 1)
			local z = bit.band(bit.rshift(i, 2), 1)
			quad:insert{s*(x*2-1),s*(y*2-1),s*(z*2-1)}
		end
		for _,i in ipairs{1,2,4,4,2,3} do
			vtxdata:append(quad[i])
		end
	end
	--]]

	self.cubeObj = require 'gl.sceneobject'{
		program = {
			version = 'latest',
			precision = 'best',
			vertexCode = [[
in vec3 vertex;
out vec3 tcv;
uniform mat4 mvProjMat;
void main() {
	tcv = vertex;
	gl_Position = mvProjMat * vec4(vertex, 1.);
}
]],
			fragmentCode = [[
in vec3 tcv;
out vec4 fragColor;
uniform samplerCube tex;
void main() {
	fragColor = texture(tex, tcv);
}
]],
			uniforms = {
				tex = 0,
			},
		},
		geometry = {
			mode = gl.GL_TRIANGLES,
		},
		vertexes = {
			dim = 3,
			data = vtxdata,
		},
		texs = {tex},
		uniforms = {
			mvProjMat = self.view.mvProjMat.ptr,
		},
	}

	gl.glClearColor(0, 0, 0, 0)
	gl.glEnable(gl.GL_DEPTH_TEST)
	gl.glEnable(gl.GL_CULL_FACE)
end

function App:update(...)
	App.super.update(self, ...)
	gl.glClear(bit.bor(gl.GL_COLOR_BUFFER_BIT, gl.GL_DEPTH_BUFFER_BIT))
	self.cubeObj:draw()
end

return App():run()
