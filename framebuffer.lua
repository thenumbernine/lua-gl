-- rename file to 'framebuffer' maybe ?
require 'ext.gc'	-- make sure luajit can __gc lua-tables
local ffi = require 'ffi'
local class = require 'ext.class'
local op = require 'ext.op'
local gl = require 'gl'
local GLTex2D = require 'gl.tex2d'

local GLint_1 = ffi.typeof'GLint[1]'
local GLuint_1 = ffi.typeof'GLuint[1]'
local GLuint_4 = ffi.typeof'GLuint[4]'
local GLenum_arr = ffi.typeof'GLenum[?]'

local defaultDepthComponent = gl.GL_DEPTH_COMPONENT
if op.safeindex(gl, 'GL_ES_VERSION_2_0') then
	-- seems DEPTH_COMPONENT doesn't work in webgl ...
	defaultDepthComponent = gl.GL_DEPTH_COMPONENT16
end

local Tex3D
if op.safeindex(gl, 'GL_TEXTURE_3D') then
	Tex3D = require 'gl.tex3d'
end

local fboErrors = {
	'GL_FRAMEBUFFER_INCOMPLETE_ATTACHMENT',
	'GL_FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT',
	'GL_FRAMEBUFFER_INCOMPLETE_DRAW_BUFFER',
	'GL_FRAMEBUFFER_INCOMPLETE_READ_BUFFER',
	'GL_FRAMEBUFFER_UNSUPPORTED',
}

local fboErrorNames = {}
for i,var in ipairs(fboErrors) do
	local k = op.safeindex(gl, var)
	if k then
		fboErrorNames[k] = var
	end
end

local FrameBuffer = class()

FrameBuffer.target = gl.GL_FRAMEBUFFER

--[[
args:
	width
	height
	useDepth = (optional) 'true' to allocate and bind a renderbuffer associated with the depth component.  or value to specify the depth component type.
	dest = (optional) a texture, to set color attachment upon init
--]]
function FrameBuffer:init(args)
	args = args or {}

	-- store these for reference later, if we get them
	-- they're actually not needed for only-color buffer fbos
	self.width = args.width
	self.height = args.height

	local id = GLuint_1()
	gl.glGenFramebuffers(1, id)
	self.id = id[0]
	self:bind()

	-- make a depth buffer render target only if you need it
	self.depthID = 0
	if args.useDepth then
		local depthComponent = args.useDepth
		if type(depthComponent) ~= 'number' then
			depthComponent = defaultDepthComponent
		end
		gl.glGenRenderbuffers(1, id)
		self.depthID = id[0]
		gl.glBindRenderbuffer(gl.GL_RENDERBUFFER, self.depthID)
		gl.glRenderbufferStorage(gl.GL_RENDERBUFFER, depthComponent, self.width, self.height)
		gl.glFramebufferRenderbuffer(self.target, gl.GL_DEPTH_ATTACHMENT, gl.GL_RENDERBUFFER, self.depthID)
		gl.glBindRenderbuffer(gl.GL_RENDERBUFFER, 0)
	end

	-- TODO accept a table, and bind each index to each attachment?
	if args.dest then
		self:setColorAttachment(args.dest)
	end
end

function FrameBuffer:delete()
	if self.depthID then
		local ptr = GLuint_1(self.depthID)
		gl.glDeleteRenderbuffers(1, ptr)
		self.depthID = nil
	end

	if self.id then
		local ptr = GLuint_1(self.id)
		gl.glDeleteFramebuffers(1, ptr)
		self.id = nil
	end
end

FrameBuffer.__gc = FrameBuffer.delete

function FrameBuffer:bind()
	gl.glBindFramebuffer(self.target, self.id)
	return self
end

function FrameBuffer:unbind()
	gl.glBindFramebuffer(self.target, 0)
	return self
end

-- static function
function FrameBuffer:check()
	local status = gl.glCheckFramebufferStatus(self and self.target or gl.GL_FRAMEBUFFER)
	if status ~= gl.GL_FRAMEBUFFER_COMPLETE then
		local errstr = 'glCheckFramebufferStatus status='..status
		local name = fboErrorNames[status]
		if name then errstr = errstr..' error='..name end
		return false, errstr
	end
	return self or true	-- allow fallthrough of self as our 'true' value
end

-- and return-self assert-version
function FrameBuffer:assertcheck()
	assert(self:check())
	return self
end

-- general glFramebufferTexture2D, to-replace setColorAttachmentTex2D
-- but in order of frequency of overriding
-- I'd use glFramebufferTexture, but it's not in GLES 3.0 aka WebGL 2 (but it is in GLES 3.2...)
-- so I should make an 'attach' function that maps to this...
-- TODO why not ':tex2D' to match GL API?
function FrameBuffer:attachTex2D(attachment, tex, textarget, level, target)
	if getmetatable(tex) == GLTex2D then
		textarget = tex.target
		tex = tex.id
	end
	gl.glFramebufferTexture2D(target or self.target, attachment, textarget or gl.GL_TEXTURE_2D, tex, level or 0)
	return self
end

-- TODO - should we bind() beforehand for assurance's sake?
--		(while texture doesn't support this philosophy with its bind() which doesn't enable() beforehand
--		(thought a texture bind() without enable() would still fulfill its operation, yet wouldn't be visible in some render methods
--			on the other hand, a fbo setColorAttachmet() without bind() wouldn't fulfill its operation
-- or should we leave the app to do this (and reduce the possible binds/unbinds?)
function FrameBuffer:setColorAttachmentTex2D(tex, index, target, level)
	gl.glFramebufferTexture2D(self.target, gl.GL_COLOR_ATTACHMENT0 + (index or 0), target or gl.GL_TEXTURE_2D, tex, level or 0)
	return self
end

function FrameBuffer:setColorAttachmentTexCubeMapSide(tex, index, side, level)
	gl.glFramebufferTexture2D(self.target, gl.GL_COLOR_ATTACHMENT0 + (index or 0), gl.GL_TEXTURE_CUBE_MAP_POSITIVE_X + (side or index), tex, level or 0)
	return self
end

function FrameBuffer:setColorAttachmentTexCubeMap(tex, level)
	for i=0,5 do
		gl.glFramebufferTexture2D(self.target, gl.GL_COLOR_ATTACHMENT0 + i, gl.GL_TEXTURE_CUBE_MAP_POSITIVE_X + i, tex, level or 0)
	end
	return self
end

function FrameBuffer:setColorAttachmentTex3D(tex, index, slice, target, level)
	if not tonumber(slice) then error("unable to convert slice to number: " ..tostring(slice)) end
	slice = tonumber(slice)
	-- legacy:
	--gl.glFramebufferTexture3D(self.target, gl.GL_COLOR_ATTACHMENT0 + (index or 0), target or gl.GL_TEXTURE_3D, tex, level or 0, slice)
	-- new:
	-- ... how does glFramebufferTextureLayer know what tex target to use?
	-- or is the new standard that all texs have unique ids regardless of targets?
	gl.glFramebufferTextureLayer(self.target, gl.GL_COLOR_ATTACHMENT0 + (index or 0), tex, level or 0, slice)
	return self
end

--general, object-based type-deducing
-- TODO put index 2nd and make it default to 0
function FrameBuffer:setColorAttachment(tex, index, ...)
	if type(tex) == 'table' then
		local mt = getmetatable(tex)
		if mt == GLTex2D then
			self:setColorAttachmentTex2D(tex.id, index, ...)
		-- cube map? side or all at once?
		elseif Tex3D and mt == Tex3D then
			self:setColorAttachmentTex3D(tex.id, index, ...)
		else
			error("Can't deduce how to attach the object.  Try using an explicit attachment method")
		end
	elseif type(tex) == 'number' then
		self:setColorAttachmentTex2D(tex, index, ...)	-- though this could be a 3d slice or a cube side...
	else
		error("Can't deduce how to attach the object.  Try using an explicit attachment method")
	end
	return self
end

-- assumes the framebuffer is bound
function FrameBuffer:drawBuffers(...)
	local n, p = ...
	if type(p) == 'cdata' then
		gl.glDrawBuffers(n, p)
	else
		-- or use a table? idk?
		n = select('#', ...)
		p = GLenum_arr(n)
		for i=1,n do
			p[i-1] = select(i, ...)
		end
	end
	gl.glDrawBuffers(n, p)
	return self
end

local glint = GLint_1()
--[[
if index is a number then it binds the associated color attachment at 'GL_COLOR_ATTACHMENT0+index' and runs the callback
if index is a table then it runs through the ipairs,
	binding the associated color attachment at 'GL_COLOR_ATTACHMENT0+index[side]'
	and running the callback for each, passing the side as a parameter
--]]
function FrameBuffer:drawToCallback(index, callback, ...)
	self:bind()

	local res,err = self:check()
	if not res then
		print(err)
		print(debug.traceback())
	else
--[[
		gl.glGetIntegerv(gl.GL_DRAW_BUFFER0, glint)
		local drawbuffer = glint[0]
		if type(index)=='number' then
			glint[0] = gl.GL_COLOR_ATTACHMENT0 + index
			gl.glDrawBuffers(1, glint)
			callback(...)
		elseif type(index)=='table' then
			-- TODO - table attachments should probably make use of glDrawBuffers for multiple draw to's
			-- cubemaps should go through the tedious-but-readable chore of calling this method six times
			for side,colorAttachment in ipairs(index) do
				gl.glDrawBuffer(gl.GL_COLOR_ATTACHMENT0 + colorAttachment)	--index[side])
				callback(side, ...)
			end
		end
		glint[0] = drawbuffer
		gl.glDrawBuffers(1, glint)
--]]
-- [[ without drawBuffers ...
-- ... but what about cubemap targets vs cubemap colormap attachments?
		callback(...)
--]]
	end

	return self:unbind()
end

function FrameBuffer.drawScreenQuad()
	gl.glBegin(gl.GL_TRIANGLE_STRIP)
	gl.glTexCoord2f(0,0)	gl.glVertex2f(0,0)
	gl.glTexCoord2f(1,0)	gl.glVertex2f(1,0)
	gl.glTexCoord2f(0,1)	gl.glVertex2f(0,1)
	gl.glTexCoord2f(1,1)	gl.glVertex2f(1,1)
	gl.glEnd()
end

local oldvp = GLuint_4()
function FrameBuffer:draw(args)
	if args.viewport then
		local vp = args.viewport
		gl.glGetIntegerv(gl.GL_VIEWPORT, oldvp)
		gl.glViewport(vp[1], vp[2], vp[3], vp[4])
	end
	if args.resetProjection then
		gl.glMatrixMode(gl.GL_PROJECTION)
		gl.glPushMatrix()
		gl.glLoadIdentity()
		gl.glOrtho(0,1,0,1,-1,1)
		gl.glMatrixMode(gl.GL_MODELVIEW)
		gl.glPushMatrix()
		gl.glLoadIdentity()
	end
	if args.shader then
		local sh = args.shader
		if type(sh) == 'table' then
			sh:use()
		else
			gl.glUseProgram(sh)
		end
	end
	if args.uniforms then
		assert(args.shader)
		for k,v in pairs(args.uniforms) do
			args.shader:setUniform(k,v)	-- uniformf only, but that still supports vectors =)
		end
	end
	if args.texs then
		for i,t in ipairs(args.texs) do
			gl.glActiveTexture(gl.GL_TEXTURE0+i-1)
			if type(t) == 'table' then	-- assume tables are texture objects
				t:bind()
			else -- texture2d by default
				gl.glBindTexture(gl.GL_TEXTURE_2D, t)
			end
		end
	end
	if args.color then
		gl.glColor(args.color)
	end
	if args.dest then
		-- TODO extra bind here and in drawToCallback ... hmmmm
		self
			:bind()
			:setColorAttachment(args.dest, 0)
	end

	-- no one seems to use fbo:draw... at all...
	-- so why preserve a function that no one uses?
	-- why not just merge it in here?
	self:drawToCallback(args.colorAttachment or 0, args.callback or self.drawScreenQuad)

	if args.texs then
		for i=#args.texs,1,-1 do	-- step -1 so we end up at zero
			local t = args.texs[i]
			gl.glActiveTexture(gl.GL_TEXTURE0+i-1)
			if type(t) == 'table' then
				gl.glBindTexture(t.target, 0)
			else
				gl.glBindTexture(gl.GL_TEXTURE_2D, 0)
			end
		end
	end
	if args.shader then
		gl.glUseProgram(0)
	end
	if args.resetProjection then
		gl.glMatrixMode(gl.GL_PROJECTION)
		gl.glPopMatrix()
		gl.glMatrixMode(gl.GL_MODELVIEW)
		gl.glPopMatrix()
	end
	if args.viewport then
		gl.glViewport(oldvp[0], oldvp[1], oldvp[2], oldvp[3])
	end
	return self
end

return FrameBuffer
