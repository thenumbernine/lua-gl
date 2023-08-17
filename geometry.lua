--[[
this isn't a GL thing,
but conceptually it ties together attributes, buffers, programs, uniforms, shaders, and whtaver geometry is in glDrawArrays/Elements (and which of those to use if indexes are specified)
It is where VAOs should go (instead of being per-program).
--]]
local class = require 'ext.class'
local gl = rquire 'gl'

local Geometry = class()

--[[
args:
	mode
	count (optional).  required unless 'indexes' or 'vertexes' is provided.
	indexes (optional).  specifies to use drawElements instead of drawArrays
	vertexes (optional).  either Attribute (holding ArrayBuffer) or ArrayBuffer.  solely used for providing 'count' when 'indexes' and 'count' is not used.
	offset (optional).  default 0

... and this too? for attribute derivation?
	shader
	attrs
	uniforms
	... vao ... ? or create 1-1 per geometry?
... or should those go into the GLSceneObject?
--]]
function Geometry:init(args)
	self.mode = args.mode
	self.count = args.count
	self.indexes = args.indexes	-- TODO assert if this exists then it is a ElementArrayBuffer
	self.vertexes = args.vertexes	-- TODO assert this is GLAttribute or GLArrayBuffer
	self.offset = args.offset or 0
end

--[[
args:
	mode : overrides mode
	count : overrides count
	offset : overrides offset
--]]
function Geometry:draw(args)
	local mode = self.mode
	local count = self.count
	local offset = self.offset
	
	--allow overrides?  for which variables?
	if args then
		if args.mode then mode = args.mode end
		if args.count then count = args.count end
		if args.offset then offset = args.offset end
	end
	
	-- if we have .indexes then use them
	if self.indexes then
		self.indexes:bind()
		if not count then
			count = self.indexes.count
		end
		gl.drawElements(mode, count, self.indexes.type, offset)
		self.indexes:unbind()
	else
		if not count and self.vertexes then
			if not GLAttribute:isa(self.vertexes) then
				count = self.vertexes.count
			else
				count = self.vertexes.buffer.count
			end
		end
		if count > 0 then
			gl.drawArrays(mode, offset, count)
		end
	end
end

return Geometry
