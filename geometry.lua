local ffi = require 'ffi'
local class = require 'ext.class'
local gl = require 'gl'
local GLArrayBuffer = require 'gl.arraybuffer'
local GLElementArrayBuffer = require 'gl.elementarraybuffer'

local Geometry = class()

--[[
args:
	mode
	count (optional).  required unless 'indexes' or 'vertexes' is provided.
	indexes (optional).  specifies to use drawElements instead of drawArrays
	vertexes (optional).   solely used for providing 'count' when 'indexes' and 'count' is not used.
		- either GLAttribute (holding GLArrayBuffer)
		- or GLArrayBuffer
		- or if no metatable provided, used as a ctor for an GLArrayBuffer
	offset (optional).  default 0
	indexStart, indexEnd (optional) default to nil, set with indexes to use glDrawRangeElements
	instanceCount (optional) default to nil.  set to use drawArraysInstanced / drawElementsInstanced
--]]
function Geometry:init(args)
	self.mode = args.mode
	self.count = args.count
	self.indexes = args.indexes	-- TODO assert if this exists then it is a ElementArrayBuffer
	self.vertexes = args.vertexes	-- TODO assert this is GLAttribute or GLArrayBuffer

	-- implicit-construction to match behavior of GLSceneObject constructor
	if self.vertexes and not getmetatable(self.vertexes) then
		self.vertexes = GLArrayBuffer(self.vertexes):unbind()
	end
	if self.indexes and not getmetatable(self.indexes) then
		self.indexes = GLElementArrayBuffer(self.indexes):unbind()
	end

	-- TODO
	-- for indexed geometry this is the index pointer
	-- 	for elementarraybuffer indexed geometry this is the offset into the elementarraybuffer
	-- for non-indexed geometry this is the integer offset into the currently-bound vertex arrays.
	self.offset = args.offset or 0

	self.indexStart = args.indexStart
	self.indexEnd = args.indexEnd
	self.instanceCount = args.instanceCount
end

--[[

draw(mode, count, offset, instanceCount)
draw(args)
	args:
		mode : overrides mode
		count : overrides count
		offset : overrides offset
		instanceCount : overrides instanceCount
--]]
function Geometry:draw(mode, count, offset, instanceCount)
	--allow overrides?  for which variables?
	if type(mode) == 'table' then
		local args = mode
		mode = self.mode
		count = self.count
		offset = self.offset
		instanceCount = self.instanceCount
		if args.mode then mode = args.mode end
		if args.count then count = args.count end
		if args.offset then offset = args.offset end
		if args.instanceCount then instanceCount = args.instanceCount end
	else
		mode = mode or self.mode
		count = count or self.count
		offset = offset or self.offset
		instanceCount = instanceCount or self.instanceCount
	end

	-- if we have .indexes then use them
	if self.indexes then
		self.indexes:bind()
		if not count then
			count = self.indexes.count
		end

		-- instances don't get the option of ranged elements so no point in determining the range
		if self.instanceCount then
			gl.glDrawElementsInstanced(mode, count, self.indexes.type, ffi.cast('void*', offset), self.instanceCount)
		else
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
		end
		self.indexes:unbind()
	else
		if not count and self.vertexes then
			count = self.vertexes.count
			if not count and self.vertexes.buffer then
				count = self.vertexes.buffer.count
			end
		end

		if self.instanceCount then
			if self.instanceOffset then
				gl.glDrawArraysInstancedBaseInstance(mode, offset, count, self.instanceCount, self.instanceOffset)
			else
				gl.glDrawArraysInstanced(mode, offset, count, self.instanceCount)
			end
		else
			gl.glDrawArrays(mode, offset, count)
		end
	end
end

return Geometry
