local ffi = require 'ffi'
local gl = require 'ffi.OpenGL'
local class = require 'ext.class'
local table = require 'ext.table'
local GetBehavior = require 'gl.get'
local GLShader = require 'gl.shader'

-- optional stuff:
local GLAttribute = require 'gl.attribute'
local GLArrayBuffer = require 'gl.arraybuffer'
-- TODO instead of storing the VAO in the GLProgram, and calling it next to a separate glDraw command with geom
--  instead, create a 'GLGeom' or 'GLObject' class that combines the shader, geometry, and binding, and store the VAO with this 
local GLVertexArray = require 'gl.vertexarray'


ffi.cdef[[
typedef struct gl_program_ptr_s {
	GLuint ptr[1];
} gl_program_ptr_t;
]]
local gl_program_ptr_t = ffi.metatype('gl_program_ptr_t', {
	__gc = function(program)
		if program.ptr[0] ~= 0 then
			gl.glDeleteProgram(program.ptr[0])
			program.ptr[0] = 0
		end
	end,
})

local GLVertexShader = class(GLShader)
GLVertexShader.type = gl.GL_VERTEX_SHADER

local GLFragmentShader = class(GLShader)
GLFragmentShader.type = gl.GL_FRAGMENT_SHADER

local GLGeometryShader = class(GLShader)
GLGeometryShader.type = gl.GL_GEOMETRY_SHADER

-- this doesn't work as easy as it does in webgl
local function getUniformSettersForGLType(utype)
	return assert( ({
		[gl.GL_FLOAT] = {arg=gl.glUniform1f},
		[gl.GL_INT] = {arg=gl.glUniform1i},
		[gl.GL_BOOL] = {arg=gl.glUniform1i},
		[gl.GL_FLOAT_VEC2] = {arg=gl.glUniform2f, type='float', count=2, vec=gl.glUniform2fv},
		[gl.GL_INT_VEC2] = {arg=gl.glUniform2i, type='int', count=2, vec=gl.glUniform2iv},
		[gl.GL_BOOL_VEC2] = {arg=gl.glUniform2i, type='int', count=2, vec=gl.glUniform2iv},
		[gl.GL_FLOAT_VEC3] = {arg=gl.glUniform3f, type='float', count=3, vec=gl.glUniform3fv},
		[gl.GL_INT_VEC3] = {arg=gl.glUniform3i, type='int', count=3, vec=gl.glUniform3iv},
		[gl.GL_BOOL_VEC3] = {arg=gl.glUniform3i, type='int', count=3, vec=gl.glUniform3iv},
		[gl.GL_FLOAT_VEC4] = {arg=gl.glUniform4f, type='float', count=4, vec=gl.glUniform4fv},
		[gl.GL_INT_VEC4] = {arg=gl.glUniform4i, type='int', count=4, vec=gl.glUniform4iv},
		[gl.GL_BOOL_VEC4] = {arg=gl.glUniform4i, type='int', count=4, vec=gl.glUniform4iv},
		[gl.GL_FLOAT_MAT2] = {mat=gl.glUniformMatrix2fv},
		[gl.GL_FLOAT_MAT3] = {mat=gl.glUniformMatrix3fv},
		[gl.GL_FLOAT_MAT4] = {mat=gl.glUniformMatrix4fv},
	
		[gl.GL_SAMPLER_1D] = {arg=gl.glUniform1i},
		[gl.GL_INT_SAMPLER_1D] = {arg=gl.glUniform1i},
		[gl.GL_UNSIGNED_INT_SAMPLER_1D] = {arg=gl.glUniform1i},
		[gl.GL_SAMPLER_2D] = {arg=gl.glUniform1i},
		[gl.GL_INT_SAMPLER_2D] = {arg=gl.glUniform1i},
		[gl.GL_UNSIGNED_INT_SAMPLER_2D] = {arg=gl.glUniform1i},
		[gl.GL_SAMPLER_3D] = {arg=gl.glUniform1i},
		[gl.GL_INT_SAMPLER_3D] = {arg=gl.glUniform1i},
		[gl.GL_UNSIGNED_INT_SAMPLER_3D] = {arg=gl.glUniform1i},
		[gl.GL_SAMPLER_CUBE] = {arg=gl.glUniform1i},
		[gl.GL_INT_SAMPLER_CUBE] =  {arg=gl.glUniform1i},
		[gl.GL_UNSIGNED_INT_SAMPLER_CUBE] = {arg=gl.glUniform1i},
		[gl.GL_SAMPLER_1D_SHADOW] = {arg=gl.glUniform1i},
		[gl.GL_SAMPLER_2D_SHADOW] = {arg=gl.glUniform1i},

		--GL_SAMPLER_1D_ARRAY
		--GL_SAMPLER_2D_ARRAY
		--GL_SAMPLER_1D_ARRAY_SHADOW
		--GL_SAMPLER_2D_ARRAY_SHADOW
		--GL_INT_SAMPLER_1D_ARRAY
		--GL_INT_SAMPLER_2D_ARRAY 
		--GL_UNSIGNED_INT_SAMPLER_1D_ARRAY
		--GL_UNSIGNED_INT_SAMPLER_2D_ARRAY 
	
	})[utype], "failed to find getter for type "..utype )
end

local GLProgram = class(GetBehavior())

GLProgram.checkLinkStatus = GLShader.createCheckStatus('GL_LINK_STATUS', function(...) return gl.glGetProgramInfoLog(...) end)

-- similar to cl/getinfo.lua

function GLProgram.getter(...)
	return gl.glGetProgramiv(...)
end

GLProgram.gets = {
	{name='GL_DELETE_STATUS', type='GLint'},
	{name='GL_LINK_STATUS', type='GLint'},
	{name='GL_VALIDATE_STATUS', type='GLint'},
	{name='GL_INFO_LOG_LENGTH', type='GLint'},
	{name='GL_ATTACHED_SHADERS', type='GLint'},
	{name='GL_ACTIVE_ATTRIBUTES', type='GLint'},
	{name='GL_ACTIVE_ATTRIBUTE_MAX_LENGTH', type='GLint'},
	{name='GL_ACTIVE_UNIFORMS', type='GLint'},
	{name='GL_ACTIVE_UNIFORM_MAX_LENGTH', type='GLint'},
	--{name='GL_ACTIVE_ATOMIC_COUNTER_BUFFERS', type='GLint'},
	--{name='GL_PROGRAM_BINARY_LENGTH', type='GLint'},
	--{name='GL_COMPUTE_WORK_GROUP_SIZE', type='GLint'},
	--{name='GL_TRANSFORM_FEEDBACK_BUFFER_MODE', type='GLint'},
	--{name='GL_TRANSFORM_FEEDBACK_VARYINGS', type='GLint'},
	--{name='GL_TRANSFORM_FEEDBACK_VARYING_MAX_LENGTH', type='GLint'},
	--{name='GL_GEOMETRY_VERTICES_OUT', type='GLint'},
	--{name='GL_GEOMETRY_INPUT_TYPE', type='GLint'},
	--{name='GL_GEOMETRY_OUTPUT_TYPE', type='GLint'},
}

--[[
args:
	vertexCode
	fragmentCode
	geometryCode
	uniforms = key/value pair of uniform values to initialize
	attrs = key/value pair mapping attr name to GLAttribute
		or to GLAttribute ctor args (type & size is optionally inferred)
		or to a GLArrayBuffer object (type & size is inferred)
	createVAO = whether to create the VAO.  default true.
		the .vao field is set to a VertexArray object for all the attributes specified.
--]]
function GLProgram:init(args)
	GLProgram.super.init(self)
	
	self.vertexShader = GLVertexShader(args.vertexCode)
	self.fragmentShader = GLFragmentShader(args.fragmentCode)
	if args.geometryCode then
		self.geometryShader = GLGeometryShader(args.geometryCode)
	end
	
	self.id = gl.glCreateProgram()
	
	-- automatic resource cleanup
	self.idPtr = gl_program_ptr_t()
	self.idPtr.ptr[0] = self.id
	
	gl.glAttachShader(self.id, self.vertexShader.id)
	gl.glAttachShader(self.id, self.fragmentShader.id)
	if self.geometryShader then
		gl.glAttachShader(self.id, self.geometryShader.id)
	end
	gl.glLinkProgram(self.id)
	
	self:checkLinkStatus()

	self:use()
	
	self.uniforms = {}
	local maxUniforms = self:get'GL_ACTIVE_UNIFORMS'
	local maxLen = self:get'GL_ACTIVE_UNIFORM_MAX_LENGTH'
	for i=1,maxUniforms do
		local bufSize = maxLen+1
		local name = ffi.new('GLchar[?]', bufSize)
		local length = ffi.new('GLsizei[1]', 0)
		ffi.fill(name, bufSize)
		local arraySize = ffi.new('GLint[1]', 0)
		local utype = ffi.new('GLenum[1]', 0)
		gl.glGetActiveUniform(self.id, i-1, bufSize, length, arraySize, utype, name)
		local info = {
			name = ffi.string(name, length[0]),
			arraySize = arraySize[0],
			type = utype[0],
		}
		info.loc = gl.glGetUniformLocation(self.id, info.name)
		info.setters = getUniformSettersForGLType(info.type)
		self.uniforms[i] = info
		self.uniforms[info.name] = info
	end

--[[
so here's my issue
GLProgram has .attrs
.attrs is built by glGetActiveAttrib
it holds:
	- name
	- array size
	- GLSL type
however glVertexAttribPointer (in GLAttribute) holds
	- dimension (1,2,3,4)
	- C type
	- normalize flag
	- stride
	- offset
and glEnableVertexAttribArray / glDisableVertexAttribArray operates on
	- attribute location
... and the two do not match 1-1.  For matrix attributes, you need multiple glVertexAttribPointer calls, since glVertexAttribPointer can only specify up to 4 channels at once.
also GLAttribute associates with GLArrayBuffer for setting when drawing

TODO make a GLSceneObject that combines program, geometry, and attributes
then put the attribute -> buffer mapping information in it
and also put attribute -> buffer mapping information in GLVertexArray

and then make GLAttribute 1-1 with GLProgram's attr objects

--]]
	self.attrs = {}
	local maxAttrs = self:get'GL_ACTIVE_ATTRIBUTES'
	local maxLen = self:get'GL_ACTIVE_ATTRIBUTE_MAX_LENGTH'
	for i=1,maxAttrs do
		local bufSize = maxLen+1
		local name = ffi.new('GLchar[?]', bufSize)
		local length = ffi.new('GLsizei[1]', 0)
		ffi.fill(name, bufSize)
		local arraySize = ffi.new('GLint[1]', 0)
		local utype = ffi.new('GLenum[1]', 0)
		gl.glGetActiveAttrib(self.id, i-1, bufSize, length, arraySize, utype, name);
		
		local name = ffi.string(name, length[0])
		local attrargs
		if args.attrs then
			attrargs = args.attrs[name]
			if GLArrayBuffer.is(attrargs) then
				attrargs = {buffer = attrargs}
			end
		end
		attrargs = table(attrargs)
		attrargs.name = name
		attrargs.arraySize = arraySize[0]
		attrargs.glslType = utype[0]
		attrargs.loc = gl.glGetAttribLocation(self.id, name)
		-- alright here's another interesting caveat that Desktop GL supports probably thanks to backwards compatability:
		-- if you're using a higher shader language version that doesn't require builtins (like gl_Vertex)
		-- and your shader doesn't use this builtin
		-- then the shader still provides a queryable vertexAttribute of it
		-- just with location == -1 i.e. invalid
		-- soooo ... in that case i'm throwing it away.
		-- but i'd like to keep them for completeness
		-- but in the case that i do keep the loc==-1, and simply do not bind them, then i still get gl errors later ...
		-- weird.
		-- maybe loc==-1 is valid? and i'm in trouble for not using it?
		if attrargs.loc ~= -1 then
			self.attrs[name] = GLAttribute(attrargs)
		end
	end
	
	if args.uniforms then
		self:setUniforms(args.uniforms)
	end
	
	if args.attrs then
		if args.createVAO ~= false then
			self.vao = GLVertexArray{
				program = self,
				attrs = self.attrs,
			}
		end
		self:setAttrs()	-- in case any buffers were specified
	else
		assert(args.createVAO == nil, "you specified 'createVAO' but you didn't specify any attrs")
	end

	self:useNone()
end

function GLProgram:use()
	gl.glUseProgram(self.id)
end

function GLProgram.useNone()
	gl.glUseProgram(0)
end

function GLProgram:setUniforms(uniforms)
	for k,v in pairs(uniforms) do
		self:setUniform(k, v)
	end
	return self
end

function GLProgram:setUniform(name, value, ...)
	local info = self.uniforms[name]
	if not info then return end
	local valueType = type(value)
	local setters = info.setters
	local loc = info.loc
	if valueType == 'cdata' then
		-- assume it's a pointer?
		-- test for a pointer? how?
		-- if it's a cdata then we can set by the cdata type and let gl convert
		-- esp for double<->float

		if setters.vec then
			setters.vec(loc, 1, value)
		elseif setters.mat then
			setters.mat(loc, 1, false, value)
		else
			error("failed to find array setter for uniform "..name)
		end

	elseif valueType ~= 'table'then
		
		local setter = setters.arg
		if not setter then 
			error("failed to find non-array setter for uniform "..name) 
		end
		setter(loc, value, ...)
	else
		if setters.vec then
			local cdata = ffi.new(setters.type..'['..setters.count..']')
			for i=1,setters.count do
				cdata[i-1] = value[i]
			end
			setters.vec(loc, 1, cdata)
		elseif setters.mat then
			-- TODO c data conversion
			setters.mat(loc, 1, false, value)
		else
			error("failed to find array setter for uniform "..name)
		end
	end
end

-- expects attrs to be an array of GLAttributes
-- TODO better handling if it isn't?
function GLProgram:setAttrs(attrs)
	for name,attr in pairs(attrs or self.attrs) do
		if attr.loc then
			attr:set()
		else
			local selfattr = self.attrs[name]
			if selfattr then
				attr:set(selfattr.loc)
			end
		end
	end
end

return GLProgram
