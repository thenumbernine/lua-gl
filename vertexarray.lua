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
require 'ext.gc'	-- make sure luajit can __gc lua-tables
local ffi = require 'ffi'
local gl = require 'gl'
local table = require 'ext.table'
local class = require 'ext.class'

local GLuint_1 = ffi.typeof'GLuint[1]'

local GLVertexArray = class()

function GLVertexArray:delete()
	if self.id == nil then return end
	local ptr = GLuint_1(self.id)
	gl.glDeleteVertexArrays(1, ptr)
	self.id = nil
end

GLVertexArray.__gc = GLVertexArray.delete

--[[
args:
	program = GLProgram to derive what the attribute type info is
	attrs = (optional) table of ...
		key = attribut name
		value = what to assign it
--]]
function GLVertexArray:init(args)
	local ptr = GLuint_1()
	gl.glGenVertexArrays(1, ptr)
	self.id = ptr[0]

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
	--[[ hmm, no glVertexArray* in GLES3.
	-- Neither is glVertexAttribFormat.
	-- Neither is glVertexAttribBinding (for connecting an attribute to a bindingindex).
	-- TODO if attr has a .buffer then is this the same as ...
	for _,attr in ipairs(attrs or self.attrs) do
		-- stored per-attribute + shader bound?
		gl.glVertexArrayAttribFormat(
			self.id,
			attr.loc,
			attr.dim,
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
	self:bind()
	self:enbleAttrs()
	return self
end

-- shorthand for unbind + disableAttrs
function GLVertexArray:unbindAndDisable()
	self:disableAttrs()
	self:unbind()
	return self
end

return GLVertexArray
