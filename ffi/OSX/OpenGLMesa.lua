-- hmm the whole point of ffi.load was to abstract library loading per OS
-- I never expected Apple to be so stupid as to make me need to abstract multiple different GL libraries within the same OS
--return require 'ffi.load' 'GL'						-- load what ffi/load.lua has now set to the OpenGL.framework library
require 'ffi.load'.GL = '/usr/local/opt/mesa/lib/libGL.dylib'	-- load mesa's GL

return require 'gl.ffi.OpenGLMesa'
