--[[
holds state info of attributes (enabled, bound buffers/pointers, etc)

usage:
1) create GLVertexArray
2) bind GLVertexArray
3) for all attrs
4)	bind buffer
5)	set vertex attrib pointer
6)	enable attrib array
--]]

local GCWrapper = require 'ffi.gcwrapper.gcwrapper'
local gl = require 'gl'
local table = require 'ext.table'

local GLVertexArray = GCWrapper{
	gctype = 'autorelease_gl_vertex_array_ptr_t',
	ctype = 'GLuint',
	-- retain isn't used
	release = function(ptr)
		return gl.glDeleteVertexArrays(1, ptr)
	end,
}:subclass()

--[[
args:
	program = GLProgram to derive what the attribute type info is
	attrs = (optional) table of ...
		key = attribut name
		value = what to assign it
--]]
function GLVertexArray:init(args)
	GLVertexArray.super.init(self)
	gl.glGenVertexArrays(1, self.gc.ptr)
	self.id = self.gc.ptr[0]

	if args.attrs then
		local GLAttribute = require 'gl.attribute'
		local GLArrayBuffer = require 'gl.arraybuffer'
		local program = assert(args.program, "if you are specifying attrs then you must specify a program")
		self.attrs = table()
		for name,setargs in pairs(args.attrs) do
			local attr = GLAttribute(program.attrs[name])
			self.attrs:insert(attr)
			if GLArrayBuffer:isa(setargs) then
				attr.buffer = setargs
			else
				for k,v in pairs(setargs) do
					attr[k] = v
				end
			end
		end
		self:setAttrs()
	end
end

-- TODO remove bind and unbind as per library convention?
function GLVertexArray:setAttrs(attrs)
	--[[ hmm, no glVertexArray* in GLES3
	-- TODO if attr has a .buffer then is this the same as ...
	for _,attr in ipairs(attrs or self.attrs) do
		-- stored per-attribute + shader bound?
		gl.glVertexArrayAttribFormat(
			self.id,
			attr.loc,
			attr.size,
			attr.type,
			attr.normalize and gl.GL_TRUE or gl.GL_FALSE,
			attr.offset)
		-- stored per-vertex-array
		gl.glVertexArrayVertexBuffer(
			self.id,
			attr.loc,	-- is "binding point" the same as "attribute location" ?
			assert(attr.buffer).id,
			0, --attr.offset,	-- duplicate of glVertexAttribFormat / only set once?
			attr.stride)
	end
	--]]
	-- [[
	-- bind the vao
	self:bind()
	for _,attr in ipairs(attrs or self.attrs) do
		-- set the attr w/buffer <-> bind buffer, set pointer (to buffer), unbind buffer
		attr:enableAndSet()
	end
	-- unbind the vao
	self:unbind()
	--]]
	return self
end

function GLVertexArray:bind(args)
	gl.glBindVertexArray(self.id)
	return self
end

function GLVertexArray:unbind()
	gl.glBindVertexArray(0)
	return self
end

function GLVertexArray:enableAttrs(attrs)
	for _,attr in ipairs(attrs or self.attrs) do
		attr:enable()
	end
	return self
end

function GLVertexArray:disableAttrs(attrs)
	for _,attr in ipairs(attrs or self.attrs) do
		attr:disable()
	end
	return self
end

-- shorthand for bind + enableAttrs
-- TODO if GLProgram:enableAttrs either calls attribute :enable and :set (to bind pointers to vertx attrib arrays)
--   OR calls VAO:enableAttrs
-- then shouldn't VAO:enableAttrs only call bind() and trust that the enable states have already been set?
-- yes.
function GLVertexArray:bindAndEnable()
	return self
		:bind()
		:enableAttrs()
end

-- shorthand for unbind + disableAttrs
function GLVertexArray:unbindAndDisable()
	return self
		:disableAttrs()
		:unbind()
end

return GLVertexArray
