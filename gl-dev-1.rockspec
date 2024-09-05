package = "gl"
version = "dev-1"
source = {
	url = "git+https://github.com/thenumbernine/lua-gl"
}
description = {
	summary = "OOP Wrappers for OpenGL calls in LuaJIT.",
	detailed = "OOP Wrappers for OpenGL calls in LuaJIT.",
	homepage = "https://github.com/thenumbernine/lua-gl",
	license = "MIT"
}
dependencies = {
	"lua >= 5.1"
}
build = {
	type = "builtin",
	modules = {
		["gl.arraybuffer"] = "arraybuffer.lua",
		["gl.attribute"] = "attribute.lua",
		["gl.buffer"] = "buffer.lua",
		["gl.call"] = "call.lua",
		["gl.elementarraybuffer"] = "elementarraybuffer.lua",
		["gl.error"] = "error.lua",
		["gl.fbo"] = "fbo.lua",
		["gl.geometry"] = "geometry.lua",
		["gl.get"] = "get.lua",
		["gl.global"] = "global.lua",
		["gl"] = "gl.lua",
		["gl.gradienttex"] = "gradienttex.lua",
		["gl.gradienttex2d"] = "gradienttex2d.lua",
		["gl.hsvtex"] = "hsvtex.lua",
		["gl.hsvtex2d"] = "hsvtex2d.lua",
		["gl.intersect"] = "intersect.lua",
		["gl.kernelprogram"] = "kernelprogram.lua",
		["gl.pingpong"] = "pingpong.lua",
		["gl.pingpong3d"] = "pingpong3d.lua",
		["gl.pixelpackbuffer"] = "pixelpackbuffer.lua",
		["gl.pixelunpackbuffer"] = "pixelunpackbuffer.lua",
		["gl.program"] = "program.lua",
		["gl.report"] = "report.lua",
		["gl.sceneobject"] = "sceneobject.lua",
		["gl.setup"] = "setup.lua",
		["gl.shader"] = "shader.lua",
		["gl.shaderstoragebuffer"] = "shaderstoragebuffer.lua",
		["gl.tex"] = "tex.lua",
		["gl.tex1d"] = "tex1d.lua",
		["gl.tex2d"] = "tex2d.lua",
		["gl.tex3d"] = "tex3d.lua",
		["gl.texbuffer"] = "texbuffer.lua",
		["gl.texcube"] = "texcube.lua",
		["gl.transformfeedbackbuffer"] = "transformfeedbackbuffer.lua",
		["gl.types"] = "types.lua",
		["gl.vertexarray"] = "vertexarray.lua"
	}
}
