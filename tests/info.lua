#!/usr/bin/env luajit
-- https://registry.khronos.org/OpenGL-Refpages/gl4/html/glGet.xhtml
require 'ext'
local ffi = require 'ffi'

-- specify GL version first:
--local gl = require 'gl.setup'()	-- for desktop GL
--local gl = require 'gl.setup' 'OpenGLES1'	-- for GLES1 ... but GLES1 has no shaders afaik?
--local gl = require 'gl.setup' 'OpenGLES2'	-- for GLES2
--local gl = require 'gl.setup' 'OpenGLES3'	-- for GLES3

local gl = require 'gl.setup'((...))	-- choose at cmdline

local App = require 'gl.app':subclass()
function App:initGL()
	local glGlobal = require 'gl.global'

	xpcall(function()
		local egl = assert(op.land(pcall(require, 'gl.ffi.EGL')), 'EGL not found')

		-- how do I find GLES version?  cuz GL doen't show it ...
		-- GLES/OpenGLES1.h has GL_VERSION, but GL_VERSION returns the same as it does for non-ES ...
		-- [[ can EGL version help?
		-- https://registry.khronos.org/EGL/sdk/docs/man/html/eglIntro.xhtml
		-- seems no
		local display = egl.eglGetDisplay(egl.EGL_DEFAULT_DISPLAY)
		print('display', display)
		assert.ne(display, egl.EGL_NO_DISPLAY, "eglGetDisplay(EGL_DEFAULT_DISPLAY) failed")

		local eglVersion = ffi.new('EGLint[2]')
		-- how to debug eglInitialize failing:
		-- env DYLD_PRINT_BINDINGS=YES DYLD_PRINT_LIBRARIES=YES ./info.lua
		assert.eq(egl.EGL_TRUE, egl.eglInitialize(display, eglVersion+0, eglVersion+1), 'eglInitialize failed')
		print('EGL version from eglInitialize:', eglVersion[0], eglVersion[1])

		local attributeListSrc = {
			egl.EGL_RED_SIZE, 1,
			egl.EGL_GREEN_SIZE, 1,
			egl.EGL_BLUE_SIZE, 1,
			egl.EGL_RENDERABLE_TYPE, egl.EGL_OPENGL_ES2_BIT,	-- tell EGL to use GLES3 ... that's right, GLES3, even tho it says ES2 ...
			egl.EGL_NONE,
		}
		local attributeList = ffi.new('EGLint['..#attributeListSrc..']', attributeListSrc)
		local pconfig = ffi.new('EGLConfig[1]')
		local pnumConfig = ffi.new('EGLint[1]')
		egl.eglChooseConfig(display, attributeList, pconfig, 1, pnumConfig);
		local context = egl.eglCreateContext(display, config, egl.EGL_NO_CONTEXT, nil)
		print()
		--]]

		for _,field in ipairs{
			'EGL_CLIENT_APIS',
			'EGL_VENDOR',
			'EGL_VERSION',
			'EGL_EXTENSIONS',
		} do
			local strptr = egl.eglQueryString(egl.EGL_NO_DISPLAY, egl[field])
			local str = strptr ~= nil and ffi.string(strptr) or 'null'
			print(field, str)
		end
	end, function(err)
		print(err)
	end)

	local function get(name, ...)
		return glGlobal:get(name, ...)
	end
	local function show(name, ...)
		local result = table.pack(get(name, ...))
		io.write(name)
		local n = select('#', ...)
		if n > 0 then
			io.write'['
			for i=1,n do
				if i > 1 then io.write',' end
				io.write((select(i, ...)))
			end
			io.write']'
		end
		print(' = '..result:mapi(tostring):concat' ')
		return result:unpack()
	end

	for _,var in ipairs(glGlobal.getInfoArray) do
		-- some vars need extra values
		if var.name == 'GL_VERTEX_SHADER'
		or var.name == 'GL_FRAGMENT_SHADER'
		or var.name == 'GL_GEOMETRY_SHADER'
		or var.name == 'GL_TESS_EVALUATION_SHADER'
		or var.name == 'GL_TESS_CONTROL_SHADER'
		or var.name == 'GL_COMPUTE_SHADER'
		then
			for _,precParamName in ipairs{
				'GL_LOW_FLOAT',
				'GL_MEDIUM_FLOAT',
				'GL_HIGH_FLOAT',
				'GL_LOW_INT',
				'GL_MEDIUM_INT',
				'GL_HIGH_INT',
			} do
				show(var.name, precParamName)
			end
		else
			local maxName = ({
				GL_DRAW_BUFFER = 'GL_MAX_DRAW_BUFFERS',
				GL_SHADER_STORAGE_BUFFER_BINDING = 'GL_MAX_SHADER_STORAGE_BUFFER_BINDINGS',
				GL_SHADER_STORAGE_BUFFER_START = 'GL_MAX_SHADER_STORAGE_BUFFER_BINDINGS',
				GL_SHADER_STORAGE_BUFFER_SIZE = 'GL_MAX_SHADER_STORAGE_BUFFER_BINDINGS',
				GL_TRANSFORM_FEEDBACK_BUFFER_BINDING = 'GL_MAX_TRANSFORM_FEEDBACK_BUFFERS',
				GL_TRANSFORM_FEEDBACK_BUFFER_START = 'GL_MAX_TRANSFORM_FEEDBACK_BUFFERS',
				GL_TRANSFORM_FEEDBACK_BUFFER_SIZE = 'GL_MAX_TRANSFORM_FEEDBACK_BUFFERS',
				GL_TRANSFORM_FEEDBACK_BINDING = 'GL_MAX_TRANSFORM_FEEDBACK_BUFFERS',
				GL_UNIFORM_BUFFER_BINDING = 'GL_MAX_SHADER_STORAGE_BUFFER_BINDINGS',
				GL_UNIFORM_BUFFER_SIZE = 'GL_MAX_SHADER_STORAGE_BUFFER_BINDINGS',
				GL_UNIFORM_BUFFER_START = 'GL_MAX_SHADER_STORAGE_BUFFER_BINDINGS',
				GL_VERTEX_BINDING_DIVISOR = 0,	-- max is the number of uniforms of current bound program?  or something else?
				GL_VERTEX_BINDING_OFFSET = 0, 	-- max is the number of uniforms of current bound program?  or something else?
				GL_VERTEX_BINDING_STRIDE = 0, 	-- max is the number of uniforms of current bound program?  or something else?
				GL_VERTEX_BINDING_BUFFER = 0, 	-- max is the number of uniforms of current bound program?  or something else?
				GL_VIEWPORT = 'GL_MAX_VIEWPORTS',
				GL_MAX_COMPUTE_WORK_GROUP_COUNT = 3,
				GL_MAX_COMPUTE_WORK_GROUP_SIZE = 3,
			})[var.name]
			if maxName then
				show(var.name)
				local n
				if type(maxName) == 'number' then
					n = maxName
				else
					local msg
					n, msg = get(maxName)
					if not n then
						print(table{var.name, '=', nil, msg}:mapi(tostring):concat' ')
					end
				end
				if n then
					for i=0,n-1 do
						show(var.name, i)	 -- gl-error's ... but the docs dont really say the first version at which index-based getters for this were valid ...
					end
				end
			else
				show(var.name)
			end
		end
	end
	self:requestExit()
	print'done'
end
return App():run()
