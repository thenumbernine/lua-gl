local ffi = require 'ffi'
local op = require 'ext.op'
local table = require 'ext.table'
local GCWrapper = require 'ffi.gcwrapper.gcwrapper'
local gl = require 'gl'
local GLTypes = require 'gl.types'

local Buffer = GCWrapper{
	gctype = 'autorelease_gl_buffer_ptr_t',
	ctype = 'GLuint',
	-- retain isn't used
	release = function(ptr)
		return gl.glDeleteBuffers(1, ptr)
	end,
}:subclass()

--[[
args:
	size = size in bytes, forwarded to setData
	data (optional) = source data ptr, forwarded to setData
	usage (optional) = forwarded to setData
	target (optional) = this is forwarded to setData as an override to the class's target, but unlike the other fields it is not assigned to self

	type (optional) = duct tape code ...
		this is used in two places afaik
		- ElementalArrayBuffer, where it expects a GL primitive type const (GL_UNSIGNED_INT, etc)
			- notice that Attribute also expects GL primitive type const
		- Buffer:setData, when used with Lua data, where it expects a string / ffi typename, for casting data
			- TODO instead in this function I shoul derive ctype from GL type
			- and then probably be putting the mapping between ffi types, gl primitive types, gl shader types (including vectors/matrices) all in one place

	count (optional) ...
	dim (optional)
		my js version has dim and count instead of size, then just size = dim * count
		this makes it more compatible with GLProgram:setAttr(buffer)
		instead of only GLProgram:setAttr(attr)
--]]
function Buffer:init(args)
	Buffer.super.init(self)
	gl.glGenBuffers(1, self.gc.ptr)
	self.id = self.gc.ptr[0]

	self.type = args.type	-- optional

	-- TODO bind even if we have no args?  or only if args are provided / setData is called?
	self:bind()
	if args then
		if args.data then
			-- TODO there's enough field setters in here that maybe I should just move the 'elseif args.size' into there ...
			self:setData(args)
		elseif args.size then
			local empty = ffi.new('uint8_t[?]', args.size)
			self:setData(table(args, {data=empty}))
		end
	end
end

function Buffer:bind(target)
	gl.glBindBuffer(target or self.target, self.id)
	return self
end

function Buffer:unbind(target)
	gl.glBindBuffer(target or self.target, 0)
	return self
end

--[[
args:
	size = size, required.
	data = (optional) data, default is null.
	usage = (optional) GL buffer usage.  default GL_STATIC_DRAW.
	type = (optional) if data is a Lua table, this specifies what c type to convert it to.  default float.
	target = (optional) override self.target in the glBindBuffer call, but unlike the other fields it does not assign to self.
	count = (optional) number of elements.  computed if data is a Lua table. used elsewhere.
	dim = (optional) nelems per vectors, for vector arrays only. used elsewhere.
my js version has 'keep' for saving args.data ... I'll just make it default
--]]
function Buffer:setData(args)
	local size = args.size
	local data = args.data
	local count = args.count
	local dim = args.dim
	if type(data) == 'table' then
		local n = #data
		-- TODO move the default into Buffer.type = gl.GL_FLOAT ?
		-- but then i'd have buffers set with .type == GL_FLOAT even if they dont have .data in ctor and therefore might not really have float data ... hmm ...
		local gltype = args.type or self.type
		local ctype = gltype and GLTypes.ctypeForGLType[gltype] or 'float'
		size = size or n * ffi.sizeof(ctype)
		local numElems = math.floor(size / ffi.sizeof(ctype))
		local cdata = ffi.new(ctype..'[?]', numElems)
		for i=1,math.min(numElems, n) do
			cdata[i-1] = data[i]
		end
		data = cdata

		-- count is read from Geometry for drawing
		-- if it wasn't specified then assign count based on the table size and dimension
		if not count then
			count = n
			if dim then
				count = count / dim
			end
		end
	end
	-- mind you, this is saving the cdata, even if you :setData() with Lua data ...
	self.data = data
	self.size = size
	self.usage = args.usage or gl.GL_STATIC_DRAW

	-- extra stuff
	if count then self.count = count end
	self.dim = dim
	gl.glBufferData(args.target or self.target, self.size, self.data, self.usage)
	return self
end

function Buffer:updateData(offset, size, data)
	gl.glBufferSubData(self.target, offset or 0, size or self.size, data or self.data)
	return self
end

-- https://registry.khronos.org/OpenGL-Refpages/gl4/html/glBindBufferBase.xhtml
-- "target must be one of GL_ATOMIC_COUNTER_BUFFER, GL_TRANSFORM_FEEDBACK_BUFFER, GL_UNIFORM_BUFFER or GL_SHADER_STORAGE_BUFFER."
-- Currently only used with my only use of GLShaderStorageBuffer, but I'm not even sure if I need to make separate subclasses, since buffer targets and the buffers themselves seem to be separate things ...
-- ... and for that reason I'm tempted to make 'target' a second argument that defaults to self.target ... or maybe I should use named args ...
function Buffer:bindBase(index)
	gl.glBindBufferBase(self.target, index or 0, self.id)
	return self
end

-- offset is in bytes
-- length is in number of elements
-- access is specified here: https://registry.khronos.org/OpenGL-Refpages/gl4/html/glMapBufferRange.xhtml
-- or here: https://registry.khronos.org/OpenGL-Refpages/gl4/html/glMapBuffer.xhtml
--local hasMap = op.safeindex(gl, 'glMapBuffer')
function Buffer:map(access, offset, length, target)
--	if offset == nil and length == nil and hasMap then
-- TODO I'd use glMapBuffer and glMapBufferRange interchangeable buuuuttttt...
-- glMapBuffer uses for access GL_READ_ONLY, GL_WRITE_ONLY, or GL_READ_WRITE
-- while glMapBufferRange uses GL_MAP_READ_BIT, GL_MAP_WRITE_BIT, and a lot more, and the values between functions aren't interchangeable.
--		return gl.glMapBuffer(target or self.target, access)
--	else
-- TODO or if glMapBuffer isn't available ... then default offset to 0 and length to the buffer count minus the (offset / buffer.dim / sizeof(buffer.type))
	return gl.glMapBufferRange(target or self.target, offset or 0, length or self.count, access)
--	end
end

function Buffer:unmap(target)
	gl.glUnmapBuffer(target or self.target)
	return self
end

return Buffer
