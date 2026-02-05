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
local GLGeometry = require 'gl.geometry'

local gl = require 'gl'

-- for GLES1&2 which doesn't have VAO functionality
-- do this upon request so it can be done after GL loads
local checkHasVAO
do
	local hasVAO
	checkHasVAO = function()
		if hasVAO == nil then
			hasVAO = not not op.safeindex(gl, 'glGenVertexArrays')
		end
		return hasVAO
	end
end

local GLSceneObject = class()

--[[
args
	vertexes = GLArrayBuffer or ctor for vertex array
		- if not provided then it is taken from geometry.vertexes
		- passed to geometry for its vertexes for draw count determination
		- passed to attrs.vertex .buffer= as an implicit attribute
	geometry = GLGeometry. if no metatable, implicitly constructed as GLGeometry
	geometries = same as 'geometry' but multiple ... I should merge them eventually ...
		- TODO instead of just an array here, how about a Geometries object which can handle glMultiDrawElements, or fall back on individual glDrawElements calls ...
	program = GLProgram. if no metatable, implicitly constructed as GLProgram
	uniforms
	attrs = keys are attribute names.
		if a value is not a GLAttribute then it is  merged with the program's attr[] of the same name and then constructed as GLAttribute.
		if a value is a GLArrayBuffer then it is converted into a GLAttribute with this .buffer.
		if a value has a .buffer with no metatable then the .buffer is constructed as a GLArrayBuffer
	texs
	createVAO (optional) set this to `false` to disable

also creates a .vao for saving bindings of attributes
--]]
function GLSceneObject:init(args)
	args = args or {}
	self.vertexes = args.vertexes or (args.geometry and args.geometry.vertexes)
	if self.vertexes then
		if not getmetatable(self.vertexes) then
			self.vertexes = GLArrayBuffer(self.vertexes):unbind()
		end
	end

	if args.geometry then
		self.geometry = args.geometry
		-- construct if necessary;
		--if not GLGeometry:isa(self.geometry) then
		if not getmetatable(self.geometry) then
			self.geometry = GLGeometry(self.geometry)
		end
		-- GLGeometry ctor doesn't use so we can assign it after ctor
		if not self.geometry.vertexes then
			self.geometry.vertexes = self.vertexes
		end
	end
	-- one or many?  hmm
	if args.geometries then
		self.geometries = table()
		for _,geometry in ipairs(args.geometries) do
			if not getmetatable(geometry) then
				geometry = GLGeometry(geometry)
			end
			if not geometry.vertexes then
				geometry.vertexes = self.vertexes
			end
			self.geometries:insert(geometry)
		end
	end

	self.program = args.program
	-- construct if necessary;
	local GLProgram = require 'gl.program'
	--if not GLProgram:isa(self.program) then
	if not getmetatable(self.program) then
		self.program = GLProgram(self.program):useNone()
	end

	self.uniforms = args.uniforms or {}
	self.attrs = {}
	local srcattrs = table(args.attrs)
	if not srcattrs.vertex then
		-- TODO should I change the .vertexes field of Geometry and SceneObject to just .vertex ? technically those are plural (multiple vertexes) while the GLSL arg is singular (processing a single vertex at a time) ...
		srcattrs.vertex = self.vertexes
	end
	for k,v in pairs(srcattrs) do
		if self.program.attrs[k] then
			if not GLAttribute:isa(v) then
				if GLArrayBuffer:isa(v) then
					-- if attrs[] value is an ArrayBuffer, wrap it in {buffer= }
					v = {buffer = v}
				end

				-- how to do coercion for attrs[] is tough ...
				if v.buffer and not getmetatable(v.buffer) then
					v.buffer = GLArrayBuffer(v.buffer):unbind()
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

	self.texs = table(args.texs)
	for i,tex in ipairs(self.texs) do
		if type(tex) == 'string' then
			local GLTex2D = require 'gl.tex2d'
			self.texs[i] = GLTex2D(tex)
		--elseif Image:isa(tex) then	-- TODO maybe later
		end
	end

	if checkHasVAO()
	and args.createVAO ~= false
	then
		local GLVertexArray = require 'gl.vertexarray'
		self.vao = GLVertexArray{
			program = self,	-- self.program?
			attrs = self.attrs,
		}
	end
end

-- enable & set self.attrs either by binding the VAO or by manually enabling and binding them
-- TODO call this 'enableAndSet' ?
-- Correct me here if I'm wrong ...
-- A program's currently-bound uniforms are stored per-program
-- but a program's currently-bound attributes are not?
-- but attributes are stored per-VAO...
-- ... why aren't uniforms stored per-VAO as well?
-- ... or why aren't attributes stored per-program?
function GLSceneObject:enableAndSetAttrs()
	if self.vao then
		self.vao:bind()
	else
		for attrname,attr in pairs(self.attrs) do
			-- setPointer() vs set() ?
			-- set() calls bind() too ...
			-- set() is required.
			attr:enableAndSet()
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

--[[
args:
	texs = override textures
	program = override program
	uniforms = additional uniforms
	geometry = override geometry
	geometries = override geometries
	... notice if you have .geometry and you :draw{geometries=} that means it draws both.
--]]
function GLSceneObject:draw(args)
	local texs = args and args.texs or self.texs
	for i,tex in ipairs(texs) do
		tex:bind(i-1)
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
		-- instead 'enablAndSetAttrs' will use VAO if present (which means no overriding per-draw-call)
		self:enableAndSetAttrs()
	end

	local geometry = args and args.geometry or self.geometry
	if geometry then
		geometry:draw()
	end
	local geometries = args and args.geometries or self.geometries
	if geometries then
		for _,geometry in ipairs(geometries) do
			geometry:draw()
		end
	end

	if program then
		self:disableAttrs()

		program:useNone()
	end

	for i=#texs,1,-1 do
		texs[i]:unbind(i-1)
	end
end

-- I want to return all the mapped attr.buffer.vec's, but don't want to build a table, so ...
function GLSceneObject:beginUpdateKth(k, checkCapacity)
	local nextk, attr = next(self.attrs, k)
	if not attr then return end

	local vec
	if not attr.divisor then
		vec = attr.buffer:beginUpdate(checkCapacity)
	else
		-- TODO ...
		vec = attr.buffer:beginUpdate()
	end

	return vec, self:beginUpdateKth(nextk, checkCapacity)
end

-- Use this function with attributes' buffers that are initialized with .useVec=true ...
-- It will remember their old capacity, and resize the GPU buffer if it changes.
function GLSceneObject:beginUpdate()
	-- TODO if there's no 'vertex' ...
	local vtxbuf = self.attrs.vertex.buffer
	--[[
	for _,attr in pairs(self.attrs) do
		if not attr.divisor then
			attr.buffer:beginUpdate(vtxbuf.vec.capacity)
		else
			-- TODO ...
			attr.buffer:beginUpdate()
		end
	end
	--]]
	-- [[ call each buffer's 'beginUpdate' and return all vecs as an arg pack (in no particular order mind you ...)
	return self:beginUpdateKth(nil, vtxbuf.vec.capacity)
	--]]
end

function GLSceneObject:endUpdate(...)
	local vtxbuf = self.attrs.vertex.buffer
	for name,attr in pairs(self.attrs) do
		if not attr.divisor then
			attr.buffer:endUpdate(vtxbuf.vec.capacity)
		else
			-- TODO ...
			attr.buffer:endUpdate()
		end
	end
	self.geometry.count = #vtxbuf.vec
	self:draw(...)
end

return GLSceneObject
