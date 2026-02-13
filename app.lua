local ffi = require 'ffi'
local sdl = require 'sdl'
local SDLApp = require 'sdl.app'
local sdlAssertNonNull = require 'sdl.assert'.nonnull
local gl = require 'gl'


local GLApp = SDLApp:subclass()

GLApp.title = "OpenGL App"

GLApp.sdlCreateWindowFlags = bit.bor(GLApp.sdlCreateWindowFlags, sdl.SDL_WINDOW_OPENGL)

function GLApp:sdlGLSetAttributes()
	-- [[ needed for windows, not for ... android? I forget ...
	self.sdlAssert(sdl.SDL_GL_SetAttribute(sdl.SDL_GL_RED_SIZE, 8))
	self.sdlAssert(sdl.SDL_GL_SetAttribute(sdl.SDL_GL_GREEN_SIZE, 8))
	self.sdlAssert(sdl.SDL_GL_SetAttribute(sdl.SDL_GL_BLUE_SIZE, 8))
	self.sdlAssert(sdl.SDL_GL_SetAttribute(sdl.SDL_GL_ALPHA_SIZE, 8))
	self.sdlAssert(sdl.SDL_GL_SetAttribute(sdl.SDL_GL_DEPTH_SIZE, 24))
	self.sdlAssert(sdl.SDL_GL_SetAttribute(sdl.SDL_GL_DOUBLEBUFFER, 1))
	--]]

	-- [[ OSX wants to set GL to version 2.1 even though they claim they support up to 4.1 ...
	-- is there any way to query the highest available GL version from SDL?  Or do I just have to know that, because it's OSX, it's going to be extra-retarded?
	-- Annnd..... this gives me a black screen with no errors.
	-- Running without these gets us GL 2.1 compat
	-- Running with the context version request only still gets us 2.1
	-- Running with SDL_GL_CONTEXT_PROFILE_MASK gets us a black screen
	-- Running with *only* SDL_GL_CONTEXT_PROFILE_MASK  says I'm getting version 4.1 ... but yeah blank screen ... and glCreateShader fails for GL_VERTEX_SHADER
	-- This page: https://stackoverflow.com/questions/48714591/modern-opengl-macos-only-black-screen
	-- ... sounds like I *must* create a VAO, therefore deprecated GL 1 and GL 2 stuff doesn't work with GL core 4 ...
	-- ... which means I probably want a toggle here, for OSX: GL 2.1 or GL core 4.1 ...
	-- I want to use OpenGL 2.1 w/extensions, and get the best of old and new OpenGL
	--  however when I choose this, OSX only gives me GLSL up to 1.20 ... smh
	-- So if I want new GLSL then I am forced to use OpenGL 4.1 core ...
	if ffi.os == 'OSX' then
		-- is there a good way to look inside gl.setup and determine which one was picked?
		local loaded2 = package.loaded['gl.ffi.OSX.OpenGL2']
		local loaded3 = package.loaded['gl.ffi.OSX.OpenGL3']
		local loadedMesa = package.loaded['gl.ffi.OSX.OpenGLMesa']
		local loadedES = package.loaded['gl.ffi.OpenGLES3']
			or package.loaded['gl.ffi.OpenGLES2']
			or package.loaded['gl.ffi.OpenGLES1']
		-- ... and then choose this accordingly?
		if loadedMesa then
			-- With the /usr/local/opt/mesa/lib/libGL.dylib
			--  I tried same as loaded2 or loaded3, I can't get past a solid red screen.
		elseif loaded3 then
			-- [=[ Using OSX framework GL 4.1 core-context
			-- From OpenGL.framework's OpenGL/gl3.h:
			-- Use this with 'gl.setup' 'OpenGL3'
			-- Or else you'll probably get a black screen, or some shader errors, or something will go wrong
			self.sdlAssert(sdl.SDL_GL_SetAttribute(sdl.SDL_GL_CONTEXT_MAJOR_VERSION, 4))
			self.sdlAssert(sdl.SDL_GL_SetAttribute(sdl.SDL_GL_CONTEXT_MINOR_VERSION, 1))
			self.sdlAssert(sdl.SDL_GL_SetAttribute(sdl.SDL_GL_CONTEXT_PROFILE_MASK, sdl.SDL_GL_CONTEXT_PROFILE_CORE))
			self.sdlAssert(sdl.SDL_GL_SetAttribute(sdl.SDL_GL_CONTEXT_FLAGS, sdl.SDL_GL_CONTEXT_FORWARD_COMPATIBLE_FLAG))
			self.sdlAssert(sdl.SDL_GL_SetAttribute(sdl.SDL_GL_ACCELERATED_VISUAL, 1))
			--]=]
		elseif loaded2 then
			--[=[ Using OSX framework GL 2.0
			-- From OpenGL.framework's OpenGL/gl.h:
			-- Use this with 'gl.setup' 'OpenGL2'
			-- Doesn't really need these, it runs fine as-is:
			self.sdlAssert(sdl.SDL_GL_SetAttribute(sdl.SDL_GL_CONTEXT_MAJOR_VERSION, 2))
			self.sdlAssert(sdl.SDL_GL_SetAttribute(sdl.SDL_GL_CONTEXT_MINOR_VERSION, 0))
			self.sdlAssert(sdl.SDL_GL_SetAttribute(sdl.SDL_GL_CONTEXT_FLAGS, sdl.SDL_GL_CONTEXT_FORWARD_COMPATIBLE_FLAG))
			self.sdlAssert(sdl.SDL_GL_SetAttribute(sdl.SDL_GL_ACCELERATED_VISUAL, 1))
			--]=]
		elseif loadedES then
			-- [=[ trying to get GLES3 working on OSX ... getting "SDL_GetError(): Could not initialize OpenGL / GLES library"
			-- TODO TODO TODO on OSX still haven't figured this out, even with SDL3
			sdl.SDL_SetHint("SDL_HINT_OPENGL_ES_DRIVER", "1")
			sdl.SDL_SetHint("SDL_HINT_RENDER_DRIVER", "opengles")
			--sdl.SDL_SetHint("SDL_HINT_OPENGL_LIBRARY", "GLESv2")
			--sdl.SDL_SetHint("SDL_HINT_EGL_LIBRARY", "EGL")
			sdl.SDL_SetHint("SDL_HINT_OPENGL_LIBRARY", "/usr/local/opt/mesa/lib/libGLESv2.dylib")
			sdl.SDL_SetHint("SDL_HINT_EGL_LIBRARY", "/usr/local/opt/mesa/lib/libEGL.dylib")
			if self.sdlMajorVersion == 2 then	-- only for SDL2, not for SDL3
				self.sdlAssert(sdl.SDL_GL_SetAttribute(sdl.SDL_GL_CONTEXT_EGL, 1))
			end
			self.sdlAssert(sdl.SDL_GL_SetAttribute(sdl.SDL_GL_CONTEXT_PROFILE_MASK, sdl.SDL_GL_CONTEXT_PROFILE_ES))
			self.sdlAssert(sdl.SDL_GL_SetAttribute(sdl.SDL_GL_CONTEXT_MAJOR_VERSION, 3))
			self.sdlAssert(sdl.SDL_GL_SetAttribute(sdl.SDL_GL_CONTEXT_MINOR_VERSION, 0))
			--]=]
		end
	end
	--]]
end

function GLApp:initWindow()
	self:sdlGLSetAttributes()
	GLApp.super.initWindow(self)

	self.sdlCtx = sdlAssertNonNull(sdl.SDL_GL_CreateContext(self.window))

	--sdl.SDL_EnableKeyRepeat(0,0)
	--self.sdlAssert( -- assert not really required, and it fails on raspberry pi, so ...
	sdl.SDL_GL_SetSwapInterval(0)
	--)

	-- you can set this by running your program with
	-- `luajit -e "require'gl.app'.gldebug=true" ...`
	-- or `luajit -lgl.debug ...`
	if self.gldebug then
		self.glDebugCallback = function(source, gltype, id, severity, length, message, userParam)
			print('!!! glDebugCallback source='..tostring(source)
				..' gltype='..tostring(gltype)
				..' id='..tostring(id)
				..' severity='..tostring(severity)
				..' '..ffi.string(message, length)
			)
			print(debug.traceback())
		end
		self.glDebugClosure = ffi.cast('GLDEBUGPROC', self.glDebugCallback)

		gl.glDebugMessageCallback(self.glDebugClosure, nil)
		gl.glDebugMessageControl(gl.GL_DONT_CARE, gl.GL_DONT_CARE, gl.GL_DONT_CARE, 0, nil, gl.GL_TRUE)
		gl.glEnable(gl.GL_DEBUG_OUTPUT)
		gl.glEnable(gl.GL_DEBUG_OUTPUT_SYNCHRONOUS)
	end

	if self.initGL then self:initGL() end
end

function GLApp:resize()
	gl.glViewport(0, 0, self.width, self.height)
end

function GLApp:postUpdate()
--[[ screen
	sdl.SDL_GL_SwapBuffers()
--]]
-- [[ window
	sdl.SDL_GL_SwapWindow(self.window)
--]]
end

function GLApp:exit()
	--[[ manually clean up function pointer closures before the library unloads
	if ffi.os == 'Windows' then
		collectgarbage()
		getmetatable(gl).__gc()
		collectgarbage()
	end
	--]]

	if self.sdlMajorVersion == 2 then
		sdl.SDL_GL_DeleteContext(self.sdlCtx)
	elseif self.sdlMajorVersion == 3 then
		sdl.SDL_GL_DestroyContext(self.sdlCtx)
	else
		error("SDLApp.sdlMajorVersion is unknown: "..require'ext.tolua'(SDLApp.sdlMajorVersion))
	end

	GLApp.super.exit(self)

	if ffi.os == 'Windows' then
		--collectgarbage('stop')
		--jit.off()
		-- got sick of "Error in finalizer" when cleaning up the GL library
		-- or if I tried manually freeing callbacks I got "bad callback"
		-- soooo ... just exit early.
		os.exit()
	end
end

--[[
This is a common feature so I'll put it here.
It is based on Image, but I'll only require() Image within the function so GLApp itself doesn't depend on Image.
I put it here vs lua-opengl because it also depends on GLApp.width and .height, so ultimately it is dependent on GLApp.
It uses a .screenshotContext field for caching the Image buffer of the read pixels, and the buffer for flipping them before saving the screenshot.
--]]
function GLApp:screenshotToFile(filename)
	local Image = require 'image'
	local w, h = self.width, self.height

	self.screenshotContext = self.screenshotContext or {}
	local ssimg = self.screenshotContext.ssimg
	local ssflipped = self.screenshotContext.ssflipped
	if ssimg then
		if w ~= ssimg.width or h ~= ssimg.height then
			ssimg = nil
			ssflipped = nil
		end
	end
	-- hmm, I'm having trouble with anything but RGBA ...
	if not ssimg then
		ssimg = Image(w, h, 3, 'unsigned char')
		ssflipped = Image(w, h, 3, 'unsigned char')
		self.screenshotContext.ssimg = ssimg
		self.screenshotContext.ssflipped = ssflipped
	end

	local push = ffi.new('GLint[1]', 0)
	gl.glGetIntegerv(gl.GL_PACK_ALIGNMENT, push)
	gl.glPixelStorei(gl.GL_PACK_ALIGNMENT, 1)	-- PACK_ALIGNMENT is for glReadPixels
	gl.glReadPixels(0, 0, w, h, gl.GL_RGB, gl.GL_UNSIGNED_BYTE, ssimg.buffer)
	gl.glPixelStorei(gl.GL_PACK_ALIGNMENT, push[0])
	ssimg:flip(ssflipped)
	ssflipped:save(filename)
end

return GLApp
