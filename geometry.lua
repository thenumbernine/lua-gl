local ffi = require 'ffi'
local class = require 'ext.class'
local gl = require 'gl'

local Geometry = class()

--[[
args:
	mode
	count (optional).  required unless 'indexes' or 'vertexes' is provided.
	indexes (optional).  specifies to use drawElements instead of drawArrays
	vertexes (optional).  either Attribute (holding ArrayBuffer) or ArrayBuffer.  solely used for providing 'count' when 'indexes' and 'count' is not used.
	offset (optional).  default 0
--]]
function Geometry:init(args)
	self.mode = args.mode
	self.count = args.count
	self.indexes = args.indexes	-- TODO assert if this exists then it is a ElementArrayBuffer
	self.vertexes = args.vertexes	-- TODO assert this is GLAttribute or GLArrayBuffer

	-- TODO
	-- for indexed geometry this is the index pointer
	-- 	for elementarraybuffer indexed geometry this is the offset into the elementarraybuffer
	-- for non-indexed geometry this is the integer offset into the currently-bound vertex arrays.
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

		-- auto-deduce indexStart and indexEnd either from vertexes bounds or indexes contents
		local indexStart = self.indexStart
		local indexEnd = self.indexEnd
		if self.vertexes
		and self.vertexes.count
		and not (indexStart and indexEnd)
		then
			indexStart = 0
			indexEnd = self.vertexes.count - 1
		end

		if indexStart and indexEnd then
			gl.glDrawRangeElements(mode, indexStart, indexEnd, count, self.indexes.type, ffi.cast('void*', offset))
		else
			gl.glDrawElements(mode, count, self.indexes.type, ffi.cast('void*', offset))
		end
		self.indexes:unbind()
	else
		if not count and self.vertexes then
			count = self.vertexes.count
			if not count and self.vertexes.buffer then
				count = self.vertexes.buffer.count
			end
		end
		if count and count > 0 then
			gl.glDrawArrays(mode, offset, count)
		end
	end
end

return Geometry
