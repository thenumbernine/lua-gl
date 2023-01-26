local class = require 'ext.class'
local table = require 'ext.table'
local GLProgram = require 'gl.program'

local GLKernelProgram = class(GLProgram)

function GLKernelProgram:init(args)
	local varyingCode = [[
varying vec2 pos;
]]
	local vertexCode = varyingCode..[[
void main() {
	pos = gl_Vertex.xy;
	gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
}
]]
	local fragmentCodePrefix = varyingCode;
	local uniforms = table()
	if args.uniforms then
		for uniformName,uniformType in pairs(args.uniforms) do
			if type(uniformType) == 'table' then	-- if we have a table then assume it's a type/value pair
				uniforms[uniformName] = uniformType[2]
				uniformType = uniformType[1]
			end
			fragmentCodePrefix = fragmentCodePrefix .. 'uniform '..uniformType..' '..uniformName..';\n'
		end
	end
	if args.texs then
		local i = 0
		for _,v in ipairs(args.texs) do
			local name
			local vartype
			if type(v) == 'string' then
				name = v
				vartype = 'sampler2D'
			elseif type(v) == 'table' then	-- specific type
				name = v[1]
				vartype = v[2]
			end
			fragmentCodePrefix = fragmentCodePrefix .. 'uniform '..vartype..' '..name..';\n'
			-- TODO do I need all sampler variables unique, or do I need separate sampler1D's, 2D's, etc unique?
			-- whatever you choose, make sure fbo:draw agrees when it binds textures
			uniforms[name] = i
			i = i + 1
		end
	end

	GLKernelProgram.super.init(self, {
		vertexCode = args.vertexCode or vertexCode,
		fragmentCode = fragmentCodePrefix..assert(args.code),
		uniforms = uniforms,
	})
end

return GLKernelProgram
