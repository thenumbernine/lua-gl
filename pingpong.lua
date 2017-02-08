--[[

    File: pingpong.lua 

    Copyright (C) 2015 Christopher Moore (christopher.e.moore@gmail.com)
	  
    This software is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.
  
    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.
  
    You should have received a copy of the GNU General Public License along
    with this program; if not, write the Free Software Foundation, Inc., 51
    Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.

--]]

local table = require 'ext.table'
local class = require 'ext.class'
local FBO = require 'gl.fbo'
local GLTex2D = require 'gl.tex2d'


local PingPong = class()

function PingPong:init(args)
	self.hist = table()
	self.fbo = FBO{width=args.width, height=args.height}
	self.width = args.width
	self.height = args.height
	self.index = 1	--one-based for history index.  don't forget the associated color attachment is zero-based
	local numBuffers = args.numBuffers or 2
	for i=1,numBuffers do
		local tex = GLTex2D(args)
		self.hist:insert(tex)
		self.fbo:setColorAttachmentTex2D(i-1, tex.id)
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
	local args = table({
		colorAttachment=self.index-1;
		-- i'm not sure whether i want args.viewport==nil to mean use a default sized to the fbo, or don't touch it
		-- i'm leaning towards not touching it...
	}, args)
	self.fbo:draw(args)
end

function PingPong:clear(index, color)
	self:draw{
		colorAttachment=index-1;
		color=color;
		resetProjection=true;
		viewport={0, 0, self.width, self.height};
	}
end

function PingPong:clearAll(color)
	color = color or {0,0,0,0}
	for i=1,#self.hist do
		self:clear(i, color)
	end
end

return PingPong
