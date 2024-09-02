-- rename file to 'framebuffer' maybe ?
local ffi = require 'ffi'
local class = require 'ext.class'
local op = require 'ext.op'
local gl = require 'gl'
local Tex2D = require 'gl.tex2d'
local glreport = require 'gl.report'

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

--[[
args:
	width
	height
	useDepth = (optional) 'true' to allocate and bind a renderbuffer associated with the depth component
	dest = (optional) a texture, to set color attachment upon init
--]]
function FrameBuffer:init(args)
	args = args or {}

	-- store these for reference later, if we get them
	-- they're actually not needed for only-color buffer fbos
	self.width = args.width
	self.height = args.height

	local id = ffi.new('GLuint[1]')
	gl.glGenFramebuffers(1, id)
	self.id = id[0]
	self:bind()

	-- make a depth buffer render target only if you need it
	self.depthID = 0
	if args.useDepth then
		gl.glGenRenderbuffers(1, id)
		self.depthID = id[0]
		gl.glBindRenderbuffer(gl.GL_RENDERBUFFER, self.depthID)
		gl.glRenderbufferStorage(gl.GL_RENDERBUFFER, defaultDepthComponent, self.width, self.height)
		gl.glFramebufferRenderbuffer(gl.GL_FRAMEBUFFER, gl.GL_DEPTH_ATTACHMENT, gl.GL_RENDERBUFFER, self.depthID)
		gl.glBindRenderbuffer(gl.GL_RENDERBUFFER, 0)
	end

	-- TODO accept a table, and bind each index to each attachment?
	if args.dest then
		self:setColorAttachment(args.dest)
	end
end

function FrameBuffer:bind()
	gl.glBindFramebuffer(gl.GL_FRAMEBUFFER, self.id)
	return self
end

function FrameBuffer:unbind()
	gl.glBindFramebuffer(gl.GL_FRAMEBUFFER, 0)
	return self
end

-- static function
function FrameBuffer.check()
	local status = gl.glCheckFramebufferStatus(gl.GL_FRAMEBUFFER)
	if status ~= gl.GL_FRAMEBUFFER_COMPLETE then
		local errstr = 'glCheckFramebufferStatus status='..status
		local name = fboErrorNames[status]
		if name then errstr = errstr..' error='..name end
		return false, errstr
	end
	return true
end

-- and return-self assert-version
function FrameBuffer:assertcheck()
	assert(self.check())
	return self
end

-- TODO - should we bind() beforehand for assurance's sake?
--		(while texture doesn't support this philosophy with its bind() which doesn't enable() beforehand
--		(thought a texture bind() without enable() would still fulfill its operation, yet wouldn't be visible in some render methods
--			on the other hand, a fbo setColorAttachmet() without bind() wouldn't fulfill its operation
-- or should we leave the app to do this (and reduce the possible binds/unbinds?)
function FrameBuffer:setColorAttachmentTex2D(tex, index, target, level)
	gl.glFramebufferTexture2D(gl.GL_FRAMEBUFFER, gl.GL_COLOR_ATTACHMENT0 + (index or 0), target or gl.GL_TEXTURE_2D, tex, level or 0)
	return self
end

function FrameBuffer:setColorAttachmentTexCubeMapSide(tex, index, side, level)
	gl.glFramebufferTexture2D(gl.GL_FRAMEBUFFER, gl.GL_COLOR_ATTACHMENT0 + (index or 0), gl.GL_TEXTURE_CUBE_MAP_POSITIVE_X + (side or index), tex, level or 0)
	return self
end

function FrameBuffer:setColorAttachmentTexCubeMap(tex, level)
	for i=0,5 do
		gl.glFramebufferTexture2D(gl.GL_FRAMEBUFFER, gl.GL_COLOR_ATTACHMENT0 + i, gl.GL_TEXTURE_CUBE_MAP_POSITIVE_X + i, tex, level or 0)
	end
	return self
end

function FrameBuffer:setColorAttachmentTex3D(tex, index, slice, target, level)
	if not tonumber(slice) then error("unable to convert slice to number: " ..tostring(slice)) end
	slice = tonumber(slice)
	-- legacy:
	--gl.glFramebufferTexture3D(gl.GL_FRAMEBUFFER, gl.GL_COLOR_ATTACHMENT0 + (index or 0), target or gl.GL_TEXTURE_3D, tex, level or 0, slice)
	-- new:
	-- ... how does glFramebufferTextureLayer know what tex target to use?
	-- or is the new standard that all texs have unique ids regardless of targets?
	gl.glFramebufferTextureLayer(gl.GL_FRAMEBUFFER, gl.GL_COLOR_ATTACHMENT0 + (index or 0), tex, level or 0, slice)
	return self
end

--general, object-based type-deducing
-- TODO put index 2nd and make it default to 0
function FrameBuffer:setColorAttachment(tex, index, ...)
	if type(tex) == 'table' then
		local mt = getmetatable(tex)
		if mt == Tex2D then
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

local glint = ffi.new('GLint[1]')
--[[
if index is a number then it binds the associated color attachment at 'GL_COLOR_ATTACHMENT0+index' and runs the callback
if index is a table then it runs through the ipairs,
	binding the associated color attachment at 'GL_COLOR_ATTACHMENT0+index[side]'
	and running the callback for each, passing the side as a parameter
--]]
function FrameBuffer:drawToCallback(index, callback, ...)
	self:bind()

	local res,err = self.check()
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

	self:unbind()
	return self
end

function FrameBuffer.drawScreenQuad()
	gl.glBegin(gl.GL_TRIANGLE_STRIP)
	gl.glTexCoord2f(0,0)	gl.glVertex2f(0,0)
	gl.glTexCoord2f(1,0)	gl.glVertex2f(1,0)
	gl.glTexCoord2f(0,1)	gl.glVertex2f(0,1)
	gl.glTexCoord2f(1,1)	gl.glVertex2f(1,1)
	gl.glEnd()
end

local oldvp = ffi.new('GLuint[4]')
function FrameBuffer:draw(args)
--DEBUG(gl.fbo):glreport('begin drawScreenFBO')
	if args.viewport then
		local vp = args.viewport
		gl.glGetIntegerv(gl.GL_VIEWPORT, oldvp)
		gl.glViewport(vp[1], vp[2], vp[3], vp[4])
	end
--DEBUG(gl.fbo):glreport('drawScreenFBO glViewport')
	if args.resetProjection then
		gl.glMatrixMode(gl.GL_PROJECTION)
		gl.glPushMatrix()
		gl.glLoadIdentity()
		gl.glOrtho(0,1,0,1,-1,1)
		gl.glMatrixMode(gl.GL_MODELVIEW)
		gl.glPushMatrix()
		gl.glLoadIdentity()
	end
--DEBUG(gl.fbo):glreport('drawScreenFBO resetProjection')
	if args.shader then
		local sh = args.shader
		if type(sh) == 'table' then
			sh:use()
		else
			gl.glUseProgram(sh)
		end
	end
--DEBUG(gl.fbo):glreport('drawScreenFBO glUseProgram')
	if args.uniforms then
		assert(args.shader)
		for k,v in pairs(args.uniforms) do
			args.shader:setUniform(k,v)	-- uniformf only, but that still supports vectors =)
--DEBUG(gl.fbo):glreport('drawScreenFBO glUniform '..tostring(k)..' '..tostring(v))
		end
	end
	if args.texs then
		for i,t in ipairs(args.texs) do
			gl.glActiveTexture(gl.GL_TEXTURE0+i-1)
--DEBUG(gl.fbo):glreport('drawScreenFBO glActiveTexture '..tostring(gl.GL_TEXTURE0+i-1))
			if type(t) == 'table' then	-- assume tables are texture objects
				t:bind()
--DEBUG(gl.fbo):glreport('drawScreenFBO glBindTexture '..tostring(t.target)..', '..tostring(t.id))
			else -- texture2d by default
				gl.glBindTexture(gl.GL_TEXTURE_2D, t)
--DEBUG(gl.fbo):glreport('drawScreenFBO glBindTexture '..tostring(t))
			end
		end
	end
	if args.color then
		gl.glColor(args.color)
--DEBUG(gl.fbo):glreport('drawScreenFBO glColor')
	end
	if args.dest then
		-- TODO extra bind here and in drawToCallback ... hmmmm
		self
			:bind()
			:setColorAttachment(args.dest, 0)
	end
--DEBUG(gl.fbo):glreport('drawScreenFBO before callback')

	-- no one seems to use fbo:draw... at all...
	-- so why preserve a function that no one uses?
	-- why not just merge it in here?
	self:drawToCallback(args.colorAttachment or 0, args.callback or self.drawScreenQuad)

--DEBUG(gl.fbo):glreport('drawScreenFBO after callback')
	if args.texs then
		for i=#args.texs,1,-1 do	-- step -1 so we end up at zero
			local t = args.texs[i]
			gl.glActiveTexture(gl.GL_TEXTURE0+i-1)
--DEBUG(gl.fbo):glreport('drawScreenFBO glActiveTexture '..(gl.GL_TEXTURE0+i-1))
			if type(t) == 'table' then
				gl.glBindTexture(t.target, 0)
--DEBUG(gl.fbo):glreport('drawScreenFBO glBindTexture '..tostring(t.target)..', 0')
			else
				gl.glBindTexture(gl.GL_TEXTURE_2D, 0)
--DEBUG(gl.fbo):glreport('drawScreenFBO glBindTexture '..(gl.GL_TEXTURE_2D)..', 0')
			end
		end
	end
	if args.shader then
		gl.glUseProgram(0)
--DEBUG(gl.fbo):glreport('drawScreenFBO glUseProgram nil')
	end
	if args.resetProjection then
		gl.glMatrixMode(gl.GL_PROJECTION)
		gl.glPopMatrix()
		gl.glMatrixMode(gl.GL_MODELVIEW)
		gl.glPopMatrix()
--DEBUG(gl.fbo):glreport('drawScreenFBO resetProjection')
	end
	if args.viewport then
		gl.glViewport(oldvp[0], oldvp[1], oldvp[2], oldvp[3])
--DEBUG(gl.fbo):glreport('drawScreenFBO glViewport')
	end
--DEBUG(gl.fbo):glreport('end drawScreenFBO')
	return self
end

return FrameBuffer
