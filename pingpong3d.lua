local table = require 'ext.table'
local PingPong = require 'gl.pingpong'
local GLFramebuffer = require 'gl.framebuffer'
local GLTex3D = require 'gl.tex3d'


-- almost identical to PingPong
-- TODO organize better with the above class

local PingPong3D = PingPong:subclass()

function PingPong3D:init(args)
	self.hist = table()
	self.fbo = GLFramebuffer{width=args.width, height=args.height}
	self.width = args.width
	self.height = args.height
	self.depth = args.depth
	self.index = 1	--one-based for history index.  don't forget the associated color attachment is zero-based
	local numBuffers = args.numBuffers or 2
	for i=1,numBuffers do
		local tex = GLTex3D(args)
		self.hist:insert(tex)
	end
end

-- unlike the above, with all those slices, we have to attach upon request
function PingPong3D:draw(args)
	self.fbo
		:bind()
		:setColorAttachmentTex3D(self.hist[self.index].id, 0, args.slice)
	args = table({
		colorAttachment = 0,
	}, args)
	self.fbo:draw(args)
end

return PingPong3D
