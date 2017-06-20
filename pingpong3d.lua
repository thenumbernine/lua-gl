local table = require 'ext.table'
local class = require 'ext.class'
local PingPong = require 'gl.pingpong'
local FBO = require 'gl.fbo'
local Tex3D = require 'gl.tex3d'


-- almost identical to PingPong 
-- TODO organize better with the above class

local PingPong3D = class(PingPong)

function PingPong3D:init(args)
	self.hist = table()
	self.fbo = FBO{width=args.width, height=args.height}
	self.width = args.width
	self.height = args.height
	self.depth = args.depth
	self.index = 1	--one-based for history index.  don't forget the associated color attachment is zero-based
	local numBuffers = args.numBuffers or 2
	for i=1,numBuffers do
		local tex = Tex3D(args)
		self.hist:insert(tex)
	end
end

-- unlike the above, with all those slices, we have to attach upon request
function PingPong3D:draw(args)
	self.fbo:setColorAttachmentTex3D(0, self.hist[self.index].id, args.slice)
	local args = table({
		colorAttachment=0;
	}, args)
	self.fbo:draw(args)
end

return PingPong3D
