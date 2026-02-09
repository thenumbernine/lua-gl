--[[
call this first before any `require 'gl'` calls.
ex: `require 'gl.setup'(gltype)`
it'll setup the gl and gl.gl package to whatever you specify
no more need for globals beyond the package.loaded global
from then on `require 'gl'` or `require 'gl.gl'` will give you the requested GL library (found in the ffi folder)
--]]
return setmetatable(
	{
		default = 'OpenGL',
	},
	{
		__call = function(self, glname)
			glname = glname or self.default
			local gl = require('gl.ffi.'..glname)
			package.loaded.gl = gl
			package.loaded['gl.gl'] = gl
			return gl
		end,
	}
)
