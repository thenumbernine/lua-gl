--[[
this is what unifies:
	geometry
	shader program
	uniforms
	attrs
	texs
--]]
local class = require 'ext.class'
local Attribute = require 'gl.attribute'

local SceneObject = class()

function SceneObject:init(args)
	args = args or {}
	self.shader = args.shader
	self.uniforms = args.uniforms or {}
	if args.attrs then
		self.attrs = {}
		for k,v in pairs(args.attrs) do
			if not Attribute:isa(v) then
				-- TODO auto populate shader as well?
				v = Attribute(v)
			end
			self.attrs[k] = v
		end
	end
	self.texs = args.texs
end

function SceneObject:draw(args)
	local texs = args and args.texs or self.texs
	for i,tex in ipairs(texs) do
		tex:bind(i-1)
	end
	
	local shader = args and args.shader or self.shader
	if shader then
		shader:use()

		if self.uniforms then
			shader:setUniforms(self.uniforms)
		end
		if args and args.uniforms then
			shader:setUniforms(args.uniforms)
		end

		-- TODO set?/ unset? enable? disable? what am I doing?
		if self.attrs then
			shader:setAttrs(self.attrs)
		end
		if args and args.attrs then
			shader:setAttrs(args.attrs)
		end
	end

	if self.geometry then
		self.geometry:draw()
	end

	if shader then
		if self.attrs then
			shader:disableAttrs(self.attrs)
		end
		if args and args.attrs then
			shader:disableAttrs(args.attrs)
		end

		shader:useNone()
	end

	for i=#texs,1,-1 do
		texs[i]:bind(i-1)
	end
end

return SceneObject 
