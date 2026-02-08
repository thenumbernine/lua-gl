require 'ext.gc'	-- make sure luajit can __gc lua-tables
local ffi = require 'ffi'
local vector = require 'stl.vector-lua'
local op = require 'ext.op'
local assert = require 'ext.assert'
local table = require 'ext.table'
local vec2f = require 'vec-ffi.vec2f'
local vec3f = require 'vec-ffi.vec3f'
local vec4f = require 'vec-ffi.vec4f'
local gl = require 'gl'
local GLTypes = require 'gl.types'
local GLGet = require 'gl.get'


local uint8_t_arr = ffi.typeof'uint8_t[?]'
local float = ffi.typeof'float'
local GLint = ffi.typeof'GLint'
local GLuint_1 = ffi.typeof'GLuint[1]'


local Buffer = GLGet.behavior()

local glRetBufferParameteri = GLGet.makeRetLastArg{
	name = 'glGetBufferParameteriv',
	ctype = GLint,
	lookup = {1, 2},
}

Buffer:makeGetter{
	getter = function(self, nameValue)
		return glRetBufferParameteri(self.target, nameValue)
	end,
	vars = table{
		{name='GL_BUFFER_ACCESS'},
		{name='GL_BUFFER_ACCESS_FLAGS'},
		{name='GL_BUFFER_IMMUTABLE_STORAGE'},
		{name='GL_BUFFER_MAPPED'},
		{name='GL_BUFFER_MAP_LENGTH'},
		{name='GL_BUFFER_MAP_OFFSET'},
		{name='GL_BUFFER_SIZE'},
		{name='GL_BUFFER_STORAGE_FLAGS'},
		{name='GL_BUFFER_USAGE'},
	},
}

--[[
args:
	size = size in bytes, forwarded to setData
	data = (optional) source data ptr, forwarded to setData
	usage = (optional) GL buffer usage.  default GL_STATIC_DRAW.
	target = (optional) this is forwarded to setData as an override to the class's target, but unlike the other fields it is not assigned to self

	type = (optional) duct tape code ...
		this is used in two places afaik
		- ElementalArrayBuffer, where it expects a GL primitive type const (GL_UNSIGNED_INT, etc)
			- notice that Attribute also expects GL primitive type const
		- Buffer:setData, when used with Lua data, where it expects a string / ffi typename, for casting data
			- TODO instead in this function I should derive ctype from GL type
			- and then probably be putting the mapping between ffi types, gl primitive types, gl shader types (including vectors/matrices) all in one place
			- or better yet, derive GL type from C type
			- or better yet (texture case), specify both explicitly

	useVec = (optional) set to initialze .vec as a stl-like vector to use as the CPU side of the buffer.  works with :beginUpdate() and :endUpdate()
	ctype = (optional) used with useVec.  otherwise it uses .dim x float.
		TODO should ctype use dim as well, and be a vector-of-vec-of-ctype-x-dim ?

	count (optional) ...
	dim (optional)
		my js version has dim and count instead of size, then just size = dim * count
		this makes it more compatible with GLProgram:setAttr(buffer)
		instead of only GLProgram:setAttr(attr)

	binding (optional) call :bindBase aka glBindBufferBase upon init
--]]
function Buffer:init(args)
	local ptr = GLuint_1()
	gl.glGenBuffers(1, ptr)
	self.id = ptr[0]

	self.type = args.type	-- optional
	self.dim = args.dim
	self.count = args.count
	self.usage = args.usage or gl.GL_STATIC_DRAW

	if args.useVec then
		local dim = assert.index(args, 'dim')
		local vec = vector(
			args.ctype or ffi.typeof((assert.index({
				'float',
				'vec2f',
				'vec3f',
				'vec4f'
			}, dim))),
			self.count or 0
		)
		self.vec = vec
		assert(not self.data)
		args.data = self.vec.v
		-- hmmmmmm why .capacity and not .size?
		-- probably so the gl buffer doesn't need to reallocate until the cpu vector does ...
		-- but for all the times we're not using dynamic sized buffers, this is a waste of space ...
		args.size = ffi.sizeof(vec.type) * vec.capacity
	end

	-- TODO bind even if we have no args?  or only if args are provided / setData is called?
	self:bind()
	if args then

		-- see if we are supposed to initialize block binding point
		-- TODO what to name this?  everything seems like it has the same name: "index", "location", "binding" ...
		-- TODO also what args to name offset and size for when you want to call :bindRange instead?
		if args.binding then
			self:bindBase(args.binding)
		end

		if args.data then
			-- TODO there's enough field setters in here that maybe I should just move the 'elseif args.size' into there ...
			self:setData(args)
		elseif args.size then
			local empty = uint8_t_arr(args.size)
			self:setData(table(args, {data=empty}))
		end
	end
end

function Buffer:delete()
	if self.id == nil then return end
	local ptr = GLuint_1(self.id)
	gl.glDeleteBuffers(1, ptr)
	self.id = nil
end

Buffer.__gc = Buffer.delete

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
	usage = (optional) GL buffer usage.
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
		local ctype = ffi.typeof(gltype and GLTypes.ctypeForGLType[gltype] or float)
		size = size or n * ffi.sizeof(ctype)
		local numElems = math.floor(size / ffi.sizeof(ctype))
		local ctype_arr = ffi.typeof('$[?]', ctype)
		local cdata = ctype_arr(numElems)
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
	self.ctype = ctype
	self.size = size
	self.usage = args.usage or self.usage
	self.count = count or self.count
	self.dim = dim or self.dim

	gl.glBufferData(args.target or self.target, self.size, self.data, self.usage)

	return self
end

-- TODO put offset 2nd or last to default to zero
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

function Buffer:bindRange(index, offset, size)
	gl.glBindBufferRange(
		self.target,
		index or 0,
		self.id,
		offset or 0,
		size or self.size
	)
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
	return gl.glMapBufferRange(target or self.target, offset or 0, length or self.size, access)
--	end
end

function Buffer:unmap(target)
	gl.glUnmapBuffer(target or self.target)
	return self
end

-- Use this function with buffers initialized with .useVec=true ...
-- It will remember their old capacity, and resize the GPU buffer if it changes.
-- 'checkCapacity' is in case you have multiple attributes, you can verify their sizes all match vs some baseline ('vertex' attribute perhaps?)
function Buffer:beginUpdate(checkCapacity)
	local vec = assert(self.vec, "use beginVtx with GLBuffers initialized with useVec=true")
	self.oldcap = vec.capacity
	if checkCapacity then assert.eq(self.oldcap, checkCapacity) end
	vec:resize(0)
	return vec
end

function Buffer:endUpdate(checkCapacity)
	local vec = assert(self.vec, "use beginVtx with GLBuffers initialized with useVec=true")
	if checkCapacity then assert.eq(vec.capacity, checkCapacity) end
	if vec.capacity ~= self.oldcap then
		self:bind()
			:setData{
				data = vec.v,
				dim = self.dim,
				count = vec.capacity,
				size = ffi.sizeof(vec.type) * vec.capacity,
			}
	else
		-- data cap hasn't resized / data ptr hasn't moved / just copy
		assert.eq(vec.v, self.data)
		self:bind()
			-- only need to upload as much as we're using
			:updateData(0, vec:getNumBytes())
	end
end

return Buffer
