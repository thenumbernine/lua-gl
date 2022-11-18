local ffi = require 'ffi'
local GCWrapper = require 'ffi.gcwrapper.gcwrapper'
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


local GLVertexShader = class(GLShader)
GLVertexShader.type = gl.GL_VERTEX_SHADER

local GLFragmentShader = class(GLShader)
GLFragmentShader.type = gl.GL_FRAGMENT_SHADER

local GLGeometryShader = class(GLShader)
GLGeometryShader.type = gl.GL_GEOMETRY_SHADER

local GLComputeShader = class(GLShader)
GLComputeShader.type = gl.GL_COMPUTE_SHADER

-- this doesn't work as easy as it does in webgl
-- https://registry.khronos.org/OpenGL-Refpages/gl4/html/glGetActiveUniform.xhtml
local uniformSettersForGLTypes = {}
for name,info in pairs{
	GL_FLOAT = {arg=gl.glUniform1f, glsltype='float'},
	GL_FLOAT_VEC2 = {arg=gl.glUniform2f, type='float', count=2, vec=gl.glUniform2fv, glsltype='vec2'},
	GL_FLOAT_VEC3 = {arg=gl.glUniform3f, type='float', count=3, vec=gl.glUniform3fv, glsltype='vec3'},
	GL_FLOAT_VEC4 = {arg=gl.glUniform4f, type='float', count=4, vec=gl.glUniform4fv, glsltype='vec4'},
	GL_DOUBLE = {arg=gl.glUniform1d, glsltype='double'},
	GL_DOUBLE_VEC2 = {arg=gl.glUniform2d, type='double', count=2, vec=gl.glUniform2fv, glsltype='dvec2'},
	GL_DOUBLE_VEC3 = {arg=gl.glUniform3d, type='double', count=3, vec=gl.glUniform3fv, glsltype='dvec3'},
	GL_DOUBLE_VEC4 = {arg=gl.glUniform4d, type='double', count=4, vec=gl.glUniform4fv, glsltype='dvec4'},
	GL_INT = {arg=gl.glUniform1i, glsltype='int'},
	GL_INT_VEC2 = {arg=gl.glUniform2i, type='int', count=2, vec=gl.glUniform2iv, glsltype='ivec2'},
	GL_INT_VEC3 = {arg=gl.glUniform3i, type='int', count=3, vec=gl.glUniform3iv, glsltype='ivec3'},
	GL_INT_VEC4 = {arg=gl.glUniform4i, type='int', count=4, vec=gl.glUniform4iv, glsltype='ivec4'},
	GL_UNSIGNED_INT = {arg=gl.glUniform1ui, glsltype='unsigned int'},
	GL_UNSIGNED_INT_VEC2 = {arg=gl.glUniform2ui, type='unsigned int', count=2, vec=gl.glUniform2iv, glsltype='uvec2'},
	GL_UNSIGNED_INT_VEC3 = {arg=gl.glUniform3ui, type='unsigned int', count=3, vec=gl.glUniform3iv, glsltype='uvec3'},
	GL_UNSIGNED_INT_VEC4 = {arg=gl.glUniform4ui, type='unsigned int', count=4, vec=gl.glUniform4iv, glsltype='uvec4'},
	GL_BOOL = {arg=gl.glUniform1i, glsltype='bool'},
	GL_BOOL_VEC2 = {arg=gl.glUniform2i, type='int', count=2, vec=gl.glUniform2iv, glsltype='bvec2'},
	GL_BOOL_VEC3 = {arg=gl.glUniform3i, type='int', count=3, vec=gl.glUniform3iv, glsltype='bvec3'},
	GL_BOOL_VEC4 = {arg=gl.glUniform4i, type='int', count=4, vec=gl.glUniform4iv, glsltype='bvec4'},
	GL_FLOAT_MAT2 = {mat=gl.glUniformMatrix2fv, glsltype='mat2'},
	GL_FLOAT_MAT3 = {mat=gl.glUniformMatrix3fv, glsltype='mat3'},
	GL_FLOAT_MAT4 = {mat=gl.glUniformMatrix4fv, glsltype='mat4'},
	GL_FLOAT_MAT2x3 = {mat=gl.glUniformMatrix2x3fv, glsltype='mat2x3'},
	GL_FLOAT_MAT2x4 = {mat=gl.glUniformMatrix3x2fv, glsltype='mat2x4'},
	GL_FLOAT_MAT3x2 = {mat=gl.glUniformMatrix2x4fv, glsltype='mat3x2'},
	GL_FLOAT_MAT3x4 = {mat=gl.glUniformMatrix4x2fv, glsltype='mat3x4'},
	GL_FLOAT_MAT4x2 = {mat=gl.glUniformMatrix3x4fv, glsltype='mat4x2'},
	GL_FLOAT_MAT4x3 = {mat=gl.glUniformMatrix4x3fv, glsltype='mat4x3'},
	GL_DOUBLE_MAT2 = {mat=gl.glUniformMatrix2dv, glsltype='dmat2'},
	GL_DOUBLE_MAT3 = {mat=gl.glUniformMatrix3dv, glsltype='dmat3'},
	GL_DOUBLE_MAT4 = {mat=gl.glUniformMatrix4dv, glsltype='dmat4'},
	GL_DOUBLE_MAT2x3 = {mat=gl.glUniformMatrix2x3dv, glsltype='dmat2x3'},
	GL_DOUBLE_MAT2x4 = {mat=gl.glUniformMatrix3x2dv, glsltype='dmat2x4'},
	GL_DOUBLE_MAT3x2 = {mat=gl.glUniformMatrix2x4dv, glsltype='dmat3x2'},
	GL_DOUBLE_MAT3x4 = {mat=gl.glUniformMatrix4x2dv, glsltype='dmat3x4'},
	GL_DOUBLE_MAT4x2 = {mat=gl.glUniformMatrix3x4dv, glsltype='dmat4x2'},
	GL_DOUBLE_MAT4x3 = {mat=gl.glUniformMatrix4x3dv, glsltype='dmat4x3'},
	GL_SAMPLER_1D = {arg=gl.glUniform1i, glsltype='sampler1D'},
	GL_SAMPLER_2D = {arg=gl.glUniform1i, glsltype='sampler2D'},
	GL_SAMPLER_3D = {arg=gl.glUniform1i, glsltype='sampler3D'},
	GL_SAMPLER_CUBE = {arg=gl.glUniform1i, glsltype='samplerCube'},
	GL_SAMPLER_1D_SHADOW = {arg=gl.glUniform1i, glsltype='sampler1DShadow'},
	GL_SAMPLER_2D_SHADOW = {arg=gl.glUniform1i, glsltype='sampler2DShadow'},
	GL_SAMPLER_1D_ARRAY = {glsltype='sampler1DArray'},
	GL_SAMPLER_2D_ARRAY = {glsltype='sampler2DArray'},
	GL_SAMPLER_1D_ARRAY_SHADOW = {glsltype='sampler1DArrayShadow'},
	GL_SAMPLER_2D_ARRAY_SHADOW = {glsltype='sampler2DArrayShadow'},
	GL_SAMPLER_2D_MULTISAMPLE = {glsltype='sampler2DMS'},
	GL_SAMPLER_2D_MULTISAMPLE_ARRAY = {glsltype='sampler2DMSArray'},
	GL_SAMPLER_CUBE_SHADOW = {glsltype='samplerCubeShadow'},
	GL_SAMPLER_BUFFER = {glsltype='samplerBuffer'},
	GL_SAMPLER_2D_RECT = {glsltype='sampler2DRect'},
	GL_SAMPLER_2D_RECT_SHADOW = {glsltype='sampler2DRectShadow'},
	GL_INT_SAMPLER_1D = {arg=gl.glUniform1i, glsltype='isampler1D'},
	GL_INT_SAMPLER_2D = {arg=gl.glUniform1i, glsltype='isampler2D'},
	GL_INT_SAMPLER_3D = {arg=gl.glUniform1i, glsltype='isampler3D'},
	GL_INT_SAMPLER_CUBE =  {arg=gl.glUniform1i, glsltype='isamplerCube'},
	GL_INT_SAMPLER_1D_ARRAY = {glsltype='isampler1DArray'},
	GL_INT_SAMPLER_2D_ARRAY = {glsltype='isampler2DArray'},
	GL_INT_SAMPLER_2D_MULTISAMPLE = {glsltype='isampler2DMS'},
	GL_INT_SAMPLER_2D_MULTISAMPLE_ARRAY = {glsltype='isampler2DMSArray'},
	GL_INT_SAMPLER_BUFFER = {glsltype='isamplerBuffer'},
	GL_INT_SAMPLER_2D_RECT = {glsltype='isampler2DRect'},
	GL_UNSIGNED_INT_SAMPLER_1D = {arg=gl.glUniform1i, glsltype='usampler1D'},
	GL_UNSIGNED_INT_SAMPLER_2D = {arg=gl.glUniform1i, glsltype='usampler2D'},
	GL_UNSIGNED_INT_SAMPLER_3D = {arg=gl.glUniform1i, glsltype='usampler3D'},
	GL_UNSIGNED_INT_SAMPLER_CUBE = {arg=gl.glUniform1i, glsltype='usamplerCube'},
	GL_UNSIGNED_INT_SAMPLER_1D_ARRAY = {glsltype='usampler2DArray'},
	GL_UNSIGNED_INT_SAMPLER_2D_ARRAY = {glsltype='usampler2DArray'},
	GL_UNSIGNED_INT_SAMPLER_2D_MULTISAMPLE = {glsltype='usampler2DMS'},
	GL_UNSIGNED_INT_SAMPLER_2D_MULTISAMPLE_ARRAY = {glsltype='usampler2DMSArray'},
	GL_UNSIGNED_INT_SAMPLER_BUFFER = {glsltype='usamplerBuffer'},
	GL_UNSIGNED_INT_SAMPLER_2D_RECT = {glsltype='usampler2DRect'},
	GL_IMAGE_1D = {glsltype='image1D'},
	GL_IMAGE_2D = {glsltype='image2D'},
	GL_IMAGE_3D = {glsltype='image3D'},
	GL_IMAGE_2D_RECT = {glsltype='image2DRect'},
	GL_IMAGE_CUBE = {glsltype='imageCube'},
	GL_IMAGE_BUFFER = {glsltype='imageBuffer'},
	GL_IMAGE_1D_ARRAY = {glsltype='image1DArray'},
	GL_IMAGE_2D_ARRAY = {glsltype='image2DArray'},
	GL_IMAGE_2D_MULTISAMPLE = {glsltype='image2DMS'},
	GL_IMAGE_2D_MULTISAMPLE_ARRAY = {glsltype='image2DMSArray'},
	GL_INT_IMAGE_1D = {glsltype='iimage1D'},
	GL_INT_IMAGE_2D = {glsltype='iimage2D'},
	GL_INT_IMAGE_3D = {glsltype='iimage3D'},
	GL_INT_IMAGE_2D_RECT = {glsltype='iimage2DRect'},
	GL_INT_IMAGE_CUBE = {glsltype='iimageCube'},
	GL_INT_IMAGE_BUFFER = {glsltype='iimageBuffer'},
	GL_INT_IMAGE_1D_ARRAY = {glsltype='iimage1DArray'},
	GL_INT_IMAGE_2D_ARRAY = {glsltype='iimage2DArray'},
	GL_INT_IMAGE_2D_MULTISAMPLE = {glsltype='iimage2DMS'},
	GL_INT_IMAGE_2D_MULTISAMPLE_ARRAY = {glsltype='iimage2DMSArray'},
	GL_UNSIGNED_INT_IMAGE_1D = {glsltype='uimage1D'},
	GL_UNSIGNED_INT_IMAGE_2D = {glsltype='uimage2D'},
	GL_UNSIGNED_INT_IMAGE_3D = {glsltype='uimage3D'},
	GL_UNSIGNED_INT_IMAGE_2D_RECT = {glsltype='uimage2DRect'},
	GL_UNSIGNED_INT_IMAGE_CUBE = {glsltype='uimageCube'},
	GL_UNSIGNED_INT_IMAGE_BUFFER = {glsltype='uimageBuffer'},
	GL_UNSIGNED_INT_IMAGE_1D_ARRAY = {glsltype='uimage1DArray'},
	GL_UNSIGNED_INT_IMAGE_2D_ARRAY = {glsltype='uimage2DArray'},
	GL_UNSIGNED_INT_IMAGE_2D_MULTISAMPLE = {glsltype='uimage2DMS'},
	GL_UNSIGNED_INT_IMAGE_2D_MULTISAMPLE_ARRAY = {glsltype='uimage2DMSArray'},
	GL_UNSIGNED_INT_ATOMIC_COUNTER = {glsltype='atomic_uint'},
} do
	local v = gl[name] 
	if v then
		uniformSettersForGLTypes[v] = info
	end
end
local function getUniformSettersForGLType(utype)
	local setters = uniformSettersForGLTypes[utype]
	if not setters then
		error("failed to find getter for type "..utype)
	end
	return setters
end

local GLProgram = class(GetBehavior(GCWrapper{
	gctype = 'autorelease_gl_program_ptr_t',
	ctype = 'GLuint',
	-- retain isn't used
	release = function(ptr)
		return gl.glDeleteProgram(ptr[0])
	end,
}))

GLProgram.checkLinkStatus = GLShader.createCheckStatus('GL_LINK_STATUS', function(...) return gl.glGetProgramInfoLog(...) end)

-- similar to cl/getinfo.lua


GLProgram:addGetterVars{
	-- wrap it so wgl can replace glGetShaderiv
	getter = function(...)
		return gl.glGetProgramiv(...)
	end,
	vars = {
		{name='GL_DELETE_STATUS', type='GLint'},
		{name='GL_LINK_STATUS', type='GLint'},
		{name='GL_VALIDATE_STATUS', type='GLint'},
		{name='GL_INFO_LOG_LENGTH', type='GLint'},
		{name='GL_ATTACHED_SHADERS', type='GLint'},
		{name='GL_ACTIVE_ATTRIBUTES', type='GLint'},
		{name='GL_ACTIVE_ATTRIBUTE_MAX_LENGTH', type='GLint'},
		{name='GL_ACTIVE_UNIFORMS', type='GLint'},
		{name='GL_ACTIVE_UNIFORM_MAX_LENGTH', type='GLint'},
		{name='GL_ACTIVE_ATOMIC_COUNTER_BUFFERS', type='GLint'},
		{name='GL_PROGRAM_BINARY_LENGTH', type='GLint'},
		{name='GL_COMPUTE_WORK_GROUP_SIZE', type='GLint'},
		{name='GL_TRANSFORM_FEEDBACK_BUFFER_MODE', type='GLint'},
		{name='GL_TRANSFORM_FEEDBACK_VARYINGS', type='GLint'},
		{name='GL_TRANSFORM_FEEDBACK_VARYING_MAX_LENGTH', type='GLint'},
		{name='GL_GEOMETRY_VERTICES_OUT', type='GLint'},
		{name='GL_GEOMETRY_INPUT_TYPE', type='GLint'},
		{name='GL_GEOMETRY_OUTPUT_TYPE', type='GLint'},
	},
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
	attrLocs = optional {[attr name] = loc} for binding attribute locations
--]]
function GLProgram:init(args)
	self.id = gl.glCreateProgram()
	GLProgram.super.init(self, self.id)
	
	if args.vertexCode then
		self.vertexShader = GLVertexShader(args.vertexCode)
	end
	if args.fragmentCode then
		self.fragmentShader = GLFragmentShader(args.fragmentCode)
	end
	if args.geometryCode then
		self.geometryShader = GLGeometryShader(args.geometryCode)
	end
	if args.computeCode then
		self.computeShader = GLComputeShader(args.computeCode)
	end

	if self.vertexShader then
		gl.glAttachShader(self.id, self.vertexShader.id)
	end
	if self.fragmentShader then
		gl.glAttachShader(self.id, self.fragmentShader.id)
	end
	if self.geometryShader then
		gl.glAttachShader(self.id, self.geometryShader.id)
	end
	if self.computeShader then
		gl.glAttachShader(self.id, self.computeShader.id)
	end

	if args.attrLocs then
		for k,v in pairs(args.attrLocs) do
			gl.glBindAttribLocation(self.id, v, k);
		end
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
			if GLArrayBuffer:isa(attrargs) then
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


---------------- compute-only ----------------
-- should I just subclass GLProgram?
-- then keep the original GLProgram for vertex/fragment?
-- btw can you link vertex+fragment+compute shaders all together?

local vec3i = require 'vec-ffi.vec3i'

function GLProgram:get3(name)
	local v = vec3i()
	local pname = gl[name]
	gl.glGetIntegeri_v(pname, 0, v.s+0)
	gl.glGetIntegeri_v(pname, 1, v.s+1)
	gl.glGetIntegeri_v(pname, 2, v.s+2)
	return v
end

return GLProgram
