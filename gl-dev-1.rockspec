package = "gl"
version = "dev-1"
source = {
	url = "git+https://github.com/thenumbernine/lua-gl.git"
}
description = {
	detailed = [[
OOP Wrappers for OpenGL calls in LuaJIT.
]],
	homepage = "https://github.com/thenumbernine/lua-gl",
	license = "MIT"
}
dependencies = {
	"lua >= 5.1"
}
build = {
	type = "builtin",
	modules = {
		["gl.call"] = "call.lua",
		["gl.fbo"] = "fbo.lua",
		["gl.get"] = "get.lua",
		["gl"] = "gl.lua",
		["gl.gradienttex"] = "gradienttex.lua",
		["gl.hsvtex"] = "hsvtex.lua",
		["gl.intersect"] = "intersect.lua",
		["gl.kernelprogram"] = "kernelprogram.lua",
		["gl.pingpong"] = "pingpong.lua",
		["gl.pingpong3d"] = "pingpong3d.lua",
		["gl.program"] = "program.lua",
		["gl.report"] = "report.lua",
		["gl.shader"] = "shader.lua",
		["gl.tex"] = "tex.lua",
		["gl.tex1d"] = "tex1d.lua",
		["gl.tex2d"] = "tex2d.lua",
		["gl.tex3d"] = "tex3d.lua",
		["gl.texcube"] = "texcube.lua"
	}
}
