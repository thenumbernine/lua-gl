local class = require 'ext.class'
local ffi = require 'ffi'
local gl = require 'gl'
local Tex2D = require 'gl.tex2d'
local Tex3D = require 'gl.tex3d'
local glreport = require 'gl.report'

local fboErrors = {
	'GL_FRAMEBUFFER_INCOMPLETE_ATTACHMENT',
	'GL_FRAMEBUFFER_INCOMPLETE_DRAW_BUFFER',
	'GL_FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT',
}

local fboErrorNames = {}
for i,var in ipairs(fboErrors) do
	fboErrorNames[gl[var]] = var
end

local FBO = class()

function FBO:init(args)
	args = args or {}
	
	-- store these for reference later, if we get them
	-- they're actually not needed for only-color buffer fbos
	self.width = args.width
	self.height = args.height

	local id = ffi.new('GLuint[1]')
	gl.glGenFramebuffers(1, id)
	self.id = id[0]
	gl.glBindFramebuffer(gl.GL_FRAMEBUFFER, self.id)

	-- make a depth buffer render target only if you need it
	self.depthID = 0
	if args.useDepth then
		gl.glGenRenderbuffers(1, id)
		self.depthID = id[0]
		gl.glBindRenderbuffer(gl.GL_RENDERBUFFER, self.depthID)
		gl.glRenderbufferStorage(gl.GL_RENDERBUFFER, gl.GL_DEPTH_COMPONENT, self.width, self.height)
		gl.glBindRenderbuffer(gl.GL_RENDERBUFFER, 0)
		gl.glFramebufferRenderbuffer(gl.GL_FRAMEBUFFER, gl.GL_DEPTH_ATTACHMENT, gl.GL_RENDERBUFFER, self.depthID)
	end
	gl.glBindFramebuffer(gl.GL_FRAMEBUFFER, 0)
end

function FBO:bind()
	gl.glBindFramebuffer(gl.GL_FRAMEBUFFER, self.id)
end

function FBO:unbind()
	gl.glBindFramebuffer(gl.GL_FRAMEBUFFER, 0)
end

-- static function
function FBO.check()
	local status = gl.glCheckFramebufferStatus(gl.GL_FRAMEBUFFER)
	if status ~= gl.GL_FRAMEBUFFER_COMPLETE then
		local errstr = 'glCheckFramebufferStatus status='..status
		local name = fboErrorNames[status]	
		if name then errstr = errstr..' error='..name end
		return false, errstr
	end
	return true
end

-- TODO - should we bind() beforehand for assurance's sake?
--		(while texture doesn't support this philosophy with its bind() which doesn't enable() beforehand
--		(thought a texture bind() without enable() would still fulfill its operation, yet wouldn't be visible in some render methods
--			on the other hand, a fbo setColorAttachmet() without bind() wouldn't fulfill its operation
-- or should we leave the app to do this (and reduce the possible binds/unbinds?)
-- or should we only bind, and leave it to the caller to unbind?
function FBO:setColorAttachmentTex2D(index, tex, target, level)
	self:bind()
	gl.glFramebufferTexture2D(gl.GL_FRAMEBUFFER, gl.GL_COLOR_ATTACHMENT0 + index, target or gl.GL_TEXTURE_2D, tex, level or 0)
	self:unbind()
end

function FBO:setColorAttachmentTexCubeMapSide(index, tex, side, level)
	self:bind()
	gl.glFramebufferTexture2D(gl.GL_FRAMEBUFFER, gl.GL_COLOR_ATTACHMENT0 + index, gl.GL_TEXTURE_CUBE_MAP_POSITIVE_X + (side or index), tex, level or 0)
	self:unbind()
end

function FBO:setColorAttachmentTexCubeMap(tex, level)
	self:bind()
	for i=0,5 do
		gl.glFramebufferTexture2D(gl.GL_FRAMEBUFFER, gl.GL_COLOR_ATTACHMENT0 + i, gl.GL_TEXTURE_CUBE_MAP_POSITIVE_X + i, tex, level or 0)
	end
	self:unbind()
end

function FBO:setColorAttachmentTex3D(index, tex, slice, target, level)
	if not tonumber(slice) then error("unable to convert slice to number: " ..tostring(slice)) end
	slice = tonumber(slice)
	self:bind()
	gl.glFramebufferTexture3D(gl.GL_FRAMEBUFFER, gl.GL_COLOR_ATTACHMENT0 + index, target or gl.GL_TEXTURE_3D, tex, level or 0, slice)
	self:unbind()
end

--general, object-based type-deducing
function FBO:setColorAttachment(index, tex, ...)
	if type(tex) == 'table' then
		local mt = getmetatable(tex)
		if mt == Tex2D then
			self:setColorAttachmentTex2D(index, tex.id, ...)
		-- cube map? side or all at once?
		elseif mt == Tex3D then
			self:setColorAttachmentTex3D(index, tex.id, ...)
		else
			error("Can't deduce how to attach the object.  Try using an explicit attachment method")
		end
	elseif type(tex) == 'number' then
		self:setColorAttachmentTex2D(index, tex, ...)	-- though this could be a 3d slice or a cube side...
	else
		error("Can't deduce how to attach the object.  Try using an explicit attachment method")
	end
end

local glint = ffi.new('GLint[1]')
--[[
if index is a number then it binds the associated color attachment at 'GL_COLOR_ATTACHMENT0+index' and runs the callback
if index is a table then it runs through the ipairs,
	binding the associated color attachment at 'GL_COLOR_ATTACHMENT0+index[side]'
	and running the callback for each, passing the side as a parameter
--]]
function FBO:drawToCallback(index, callback, ...)
	self:bind()

	local res,err = self.check()
	if not res then
		print(err)
		print(debug.traceback())
	else
		gl.glGetIntegerv(gl.GL_DRAW_BUFFER, glint)
		local drawbuffer = glint[0]
		if type(index)=='number' then
			gl.glDrawBuffer(gl.GL_COLOR_ATTACHMENT0 + index)
			callback(...)
		elseif type(index)=='table' then
			-- TODO - table attachments should probably make use of glDrawBuffers for multiple draw to's
			-- cubemaps should go through the tedious-but-readable chore of calling this method six times
			for side,colorAttachment in ipairs(index) do
				gl.glDrawBuffer(gl.GL_COLOR_ATTACHMENT0 + colorAttachment)	--index[side])
				callback(side, ...)
			end
		end
		gl.glDrawBuffer(drawbuffer)
	end

	self:unbind()
end

function FBO:draw(args)
	glreport('begin drawScreenFBO')
	if args.viewport then
		local vp = args.viewport
		gl.glPushAttrib(gl.GL_VIEWPORT_BIT)
		gl.glViewport(vp[1], vp[2], vp[3], vp[4])
	end
	glreport('drawScreenFBO glViewport')
	if args.resetProjection then
		gl.glMatrixMode(gl.GL_PROJECTION)
		gl.glPushMatrix()
		gl.glLoadIdentity()
		gl.glOrtho(0,1,0,1,-1,1)
		gl.glMatrixMode(gl.GL_MODELVIEW)
		gl.glPushMatrix()
		gl.glLoadIdentity()
	end
	glreport('drawScreenFBO resetProjection')
	if args.shader then
		local sh = args.shader
		if type(sh) == 'table' then
			sh:use()
		else
			gl.glUseProgramObjectARB(sh)
		end
	end
	glreport('drawScreenFBO glUseProgram')
	if args.uniforms then
		assert(args.shader)
		for k,v in pairs(args.uniforms) do
			args.shader:setUniform(k,v)	-- uniformf only, but that still supports vectors =)
			glreport('drawScreenFBO glUniform '..tostring(k)..' '..tostring(v))
		end
	end
	if args.texs then
		for i,t in ipairs(args.texs) do
			gl.glActiveTexture(gl.GL_TEXTURE0+i-1)
			glreport('drawScreenFBO glActiveTexture '..tostring(gl.GL_TEXTURE0+i-1))
			if type(t) == 'table' then	-- assume tables are texture objects
				t:bind()
				glreport('drawScreenFBO glBindTexture '..tostring(t.target)..', '..tostring(t.id))
			else -- texture2d by default
				gl.glBindTexture(gl.GL_TEXTURE_2D, t)
				glreport('drawScreenFBO glBindTexture '..tostring(t))
			end
		end
	end
	if args.color then
		gl.glColor(args.color)
		glreport('drawScreenFBO glColor')
	end
	if args.dest then
		self:setColorAttachment(0, args.dest)
	end
	glreport('drawScreenFBO before callback')
	
	-- no one seems to use fbo:draw... at all...
	-- so why preserve a function that no one uses?
	-- why not just merge it in here?
	self:drawToCallback(args.colorAttachment or 0, args.callback or drawScreenQuad)
	
	glreport('drawScreenFBO after callback')
	if args.texs then
		for i=#args.texs,1,-1 do	-- step -1 so we end up at zero
			local t = args.texs[i]
			gl.glActiveTexture(gl.GL_TEXTURE0+i-1)
			glreport('drawScreenFBO glActiveTexture '..(gl.GL_TEXTURE0+i-1))
			if type(t) == 'table' then
				gl.glBindTexture(t.target, 0)
				glreport('drawScreenFBO glBindTexture '..tostring(t.target)..', 0')
			else
				gl.glBindTexture(gl.GL_TEXTURE_2D, 0)
				glreport('drawScreenFBO glBindTexture '..(gl.GL_TEXTURE_2D)..', 0')
			end
		end
	end
	if args.shader then
		gl.glUseProgramObjectARB(nil)
		glreport('drawScreenFBO glUseProgram nil')
	end
	if args.resetProjection then
		gl.glMatrixMode(gl.GL_PROJECTION)
		gl.glPopMatrix()
		gl.glMatrixMode(gl.GL_MODELVIEW)
		gl.glPopMatrix()
		glreport('drawScreenFBO resetProjection')
	end
	if args.viewport then
		gl.glPopAttrib()
		glreport('drawScreenFBO glPopAttrib')
	end
	glreport('end drawScreenFBO')
end

return FBO
