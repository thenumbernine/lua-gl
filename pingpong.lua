local table = require 'ext.table'
local class = require 'ext.class'
local GLFrameBuffer = require 'gl.fbo'
local GLTex2D = require 'gl.tex2d'


local PingPong = class()

--[[
args:
	- fbo = provide your own gl.fbo object.  default one is created.
	- numBuffers = number of buffers for the pingpong. default 2.
	- dontAttach = dont attach the pingpong buffers to GL_COLOR_ATTACHMENT_0 through n-1
	- the rest are forwarded to GLTex2D
--]]
function PingPong:init(args)
	self.hist = table()
	self.fbo = args.fbo or GLFrameBuffer{width=args.width, height=args.height}
	self.width = args.width
	self.height = args.height
	self.index = 1	--one-based for history index.  don't forget the associated color attachment is zero-based
	if not args.dontAttach then
		self.fbo:bind()	-- TODO bind-upon-create? hmmm...
	end
	local numBuffers = args.numBuffers or 2
	for i=1,numBuffers do
		local tex = GLTex2D(args)
		self.hist:insert(tex)
		if not args.dontAttach then
			self.fbo:setColorAttachmentTex2D(tex.id, i-1)
		end
	end
	-- TODO stick with theme and don't unbind automatically upon init
	-- or TODO maybe all objects should unbind upon init? just not upon param call?
	if not args.dontAttach then
		self.fbo:unbind()
	end
end

function PingPong:nextIndex(n)
	if not n then n = 1 end
	return (self.index + n - 1) % #self.hist + 1
end

function PingPong:swap()
	self.index = self:nextIndex()
end

function PingPong:cur()
	return self.hist[self.index]
end

function PingPong:prev(n)
	return self.hist[self:nextIndex(n)]
end	-- prev() = prev(1), ...

function PingPong:last()
	return self:prev(#self.hist-1)
end

function PingPong:draw(args)
	args = table({
		colorAttachment = self.index-1,
		-- i'm not sure whether i want args.viewport==nil to mean use a default sized to the fbo, or don't touch it
		-- i'm leaning towards not touching it...
	}, args)
	self.fbo:draw(args)
end

function PingPong:clear(index, color)
	self:draw{
		colorAttachment = index-1,
		color = color,
		resetProjection = true,
		viewport = {0, 0, self.width, self.height},
	}
end

function PingPong:clearAll(color)
	color = color or {0,0,0,0}
	for i=1,#self.hist do
		self:clear(i, color)
	end
end

return PingPong
