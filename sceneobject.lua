--[[
this isn't a GL thing,
but conceptually it ties together attributes, buffers, programs, uniforms, shaders, and whtaver geometry is in glDrawArrays/Elements (and which of those to use if indexes are specified)
It is where VAOs should go (instead of being per-program).
--]]
local class = require 'ext.class'
local table = require 'ext.table'
local op = require 'ext.op'
local GLAttribute = require 'gl.attribute'
local GLArrayBuffer = require 'gl.arraybuffer'

local gl = require 'gl'
-- for GLES1&2 which doesn't have VAO functionality
local hasVAO = not not op.safeindex(gl, 'glGenVertexArrays')
print('hasVAO', hasVAO)

local GLSceneObject = class()

--[[
args	
	geometry
	program
	uniforms
	attrs
	texs
	createVAO (optional) set to false to diasble 

also creates a .vao for saving bindings of attributes
--]]
function GLSceneObject:init(args)
	args = args or {}
	self.geometry = args.geometry	
	self.program = args.program
	self.uniforms = args.uniforms or {}
	if args.attrs then
		self.attrs = {}
		for k,v in pairs(args.attrs) do
			if not GLAttribute:isa(v) then
				if GLArrayBuffer:isa(v) then
					v = {buffer = v}
				end
				-- auto populate program as well
				if self.program then
					v = table(self.program.attrs[k], v)
				end
				v = GLAttribute(v)
			end
			self.attrs[k] = v
		end
	end
	self.texs = args.texs

	if hasVAO
	and args.createVAO ~= false
	then
		local GLVertexArray = require 'gl.vertexarray'
		self.vao = GLVertexArray{
			program = self,
			attrs = self.attrs,
		}
	end
end

-- enable self.attrs either by binding the VAO or by manually enabling and binding them
function GLSceneObject:enableAttrs()
	if self.vao then
		self.vao:bind()
	else
		for attrname,attr in pairs(self.attrs) do
			-- setPointer() vs set() ?
			-- set() calls bind() too ...
			-- set() is required.
			attr
				:enable()
				:set()
		end
	end
end

function GLSceneObject:disableAttrs()
	if self.vao then
		self.vao:unbind()
	else
		for attrname,attr in pairs(self.attrs) do
			attr:disable()
		end
	end
end

function GLSceneObject:draw(args)
	local texs = args and args.texs or self.texs
	if texs then
		for i,tex in ipairs(texs) do
			tex:bind(i-1)
		end
	end
	
	local program = args and args.program or self.program
	if program then
		program:use()

		if self.uniforms then
			program:setUniforms(self.uniforms)
		end
		if args and args.uniforms then
			program:setUniforms(args.uniforms)
		end

		-- TODO how to handle attribute overrides?  or should I even allow it?
		-- instead 'enableAttrs' will use VAO if present (which means no overriding per-draw-call)
		self:enableAttrs()
	end

	if self.geometry then
		self.geometry:draw()
	end

	if program then
		self:disableAttrs()

		program:useNone()
	end

	if texs then
		for i=#texs,1,-1 do
			texs[i]:bind(i-1)
		end
	end
end

return GLSceneObject 
