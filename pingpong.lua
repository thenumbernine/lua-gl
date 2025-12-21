local table = require 'ext.table'
local class = require 'ext.class'
local GLFramebuffer = require 'gl.framebuffer'
local GLTex2D = require 'gl.tex2d'


local PingPong = class()

--[[
args:
	- fbo = provide your own gl.fbo object.  default one is created.
	- numBuffers = number of buffers for the pingpong. default 2.
	- the rest are forwarded to GLTex2D
--]]
function PingPong:init(args)
	self.hist = table()
	self.fbo = args.fbo or GLFramebuffer{width=args.width, height=args.height}:unbind()
	self.width = args.width
	self.height = args.height
	self.index = 1	--one-based for history index.  don't forget the associated color attachment is zero-based
	local numBuffers = args.numBuffers or 2
	for i=1,numBuffers do
		local tex = GLTex2D(args)
		self.hist:insert(tex)
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
	self.fbo
		:bind()
		:setColorAttachmentTex2D(assert(self:cur().id))
		:unbind()
		:draw(args)
end

function PingPong:clear(index, color)
	self.fbo:bind()
		:setColorAttachmentTex2D(assert(self:cur().id))
		:unbind()
		:draw{
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
