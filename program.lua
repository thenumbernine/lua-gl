local ffi = require 'ffi'
local GCWrapper = require 'ffi.gcwrapper.gcwrapper'
local gl = require 'gl'
local table = require 'ext.table'
local string = require 'ext.string'
local op = require 'ext.op'
local GetBehavior = require 'gl.get'
local GLShader = require 'gl.shader'

-- optional:
local GLAttribute = require 'gl.attribute'
local GLArrayBuffer = require 'gl.arraybuffer'
local GLVertexArray = require 'gl.vertexarray'


-- this doesn't work as easy as it does in webgl
-- https://registry.khronos.org/OpenGL-Refpages/gl4/html/glGetActiveUniform.xhtml
local uniformSettersForGLTypes
local function getUniformSettersForGLType(utype)
	-- this table contains symbols from the gl lib
	-- in Windows these symbols haven't been loaded until after glapp starts
	-- so it's best to build this table upon request
	if not uniformSettersForGLTypes then
		uniformSettersForGLTypes = {}
		for name,info in pairs{
			GL_FLOAT = {arg='glUniform1f', glsltype='float'},
			GL_FLOAT_VEC2 = {arg='glUniform2f', type='float', count=2, vec=gl.glUniform2fv, glsltype='vec2'},
			GL_FLOAT_VEC3 = {arg='glUniform3f', type='float', count=3, vec=gl.glUniform3fv, glsltype='vec3'},
			GL_FLOAT_VEC4 = {arg='glUniform4f', type='float', count=4, vec=gl.glUniform4fv, glsltype='vec4'},
			GL_DOUBLE = {arg='glUniform1d', glsltype='double'},
			GL_DOUBLE_VEC2 = {arg='glUniform2d', type='double', count=2, vec=gl.glUniform2fv, glsltype='dvec2'},
			GL_DOUBLE_VEC3 = {arg='glUniform3d', type='double', count=3, vec=gl.glUniform3fv, glsltype='dvec3'},
			GL_DOUBLE_VEC4 = {arg='glUniform4d', type='double', count=4, vec=gl.glUniform4fv, glsltype='dvec4'},
			GL_INT = {arg='glUniform1i', glsltype='int'},
			GL_INT_VEC2 = {arg='glUniform2i', type='int', count=2, vec=gl.glUniform2iv, glsltype='ivec2'},
			GL_INT_VEC3 = {arg='glUniform3i', type='int', count=3, vec=gl.glUniform3iv, glsltype='ivec3'},
			GL_INT_VEC4 = {arg='glUniform4i', type='int', count=4, vec=gl.glUniform4iv, glsltype='ivec4'},
			GL_UNSIGNED_INT = {arg='glUniform1ui', glsltype='unsigned int'},
			GL_UNSIGNED_INT_VEC2 = {arg='glUniform2ui', type='unsigned int', count=2, vec=gl.glUniform2iv, glsltype='uvec2'},
			GL_UNSIGNED_INT_VEC3 = {arg='glUniform3ui', type='unsigned int', count=3, vec=gl.glUniform3iv, glsltype='uvec3'},
			GL_UNSIGNED_INT_VEC4 = {arg='glUniform4ui', type='unsigned int', count=4, vec=gl.glUniform4iv, glsltype='uvec4'},
			GL_BOOL = {arg='glUniform1i', glsltype='bool'},
			GL_BOOL_VEC2 = {arg='glUniform2i', type='int', count=2, vec=gl.glUniform2iv, glsltype='bvec2'},
			GL_BOOL_VEC3 = {arg='glUniform3i', type='int', count=3, vec=gl.glUniform3iv, glsltype='bvec3'},
			GL_BOOL_VEC4 = {arg='glUniform4i', type='int', count=4, vec=gl.glUniform4iv, glsltype='bvec4'},
			GL_FLOAT_MAT2 = {mat='glUniformMatrix2fv', glsltype='mat2'},
			GL_FLOAT_MAT3 = {mat='glUniformMatrix3fv', glsltype='mat3'},
			GL_FLOAT_MAT4 = {mat='glUniformMatrix4fv', glsltype='mat4'},
			GL_FLOAT_MAT2x3 = {mat='glUniformMatrix2x3fv', glsltype='mat2x3'},
			GL_FLOAT_MAT2x4 = {mat='glUniformMatrix3x2fv', glsltype='mat2x4'},
			GL_FLOAT_MAT3x2 = {mat='glUniformMatrix2x4fv', glsltype='mat3x2'},
			GL_FLOAT_MAT3x4 = {mat='glUniformMatrix4x2fv', glsltype='mat3x4'},
			GL_FLOAT_MAT4x2 = {mat='glUniformMatrix3x4fv', glsltype='mat4x2'},
			GL_FLOAT_MAT4x3 = {mat='glUniformMatrix4x3fv', glsltype='mat4x3'},
			GL_DOUBLE_MAT2 = {mat='glUniformMatrix2dv', glsltype='dmat2'},
			GL_DOUBLE_MAT3 = {mat='glUniformMatrix3dv', glsltype='dmat3'},
			GL_DOUBLE_MAT4 = {mat='glUniformMatrix4dv', glsltype='dmat4'},
			GL_DOUBLE_MAT2x3 = {mat='glUniformMatrix2x3dv', glsltype='dmat2x3'},
			GL_DOUBLE_MAT2x4 = {mat='glUniformMatrix3x2dv', glsltype='dmat2x4'},
			GL_DOUBLE_MAT3x2 = {mat='glUniformMatrix2x4dv', glsltype='dmat3x2'},
			GL_DOUBLE_MAT3x4 = {mat='glUniformMatrix4x2dv', glsltype='dmat3x4'},
			GL_DOUBLE_MAT4x2 = {mat='glUniformMatrix3x4dv', glsltype='dmat4x2'},
			GL_DOUBLE_MAT4x3 = {mat='glUniformMatrix4x3dv', glsltype='dmat4x3'},
			GL_SAMPLER_1D = {arg='glUniform1i', glsltype='sampler1D'},
			GL_SAMPLER_2D = {arg='glUniform1i', glsltype='sampler2D'},
			GL_SAMPLER_3D = {arg='glUniform1i', glsltype='sampler3D'},
			GL_SAMPLER_CUBE = {arg='glUniform1i', glsltype='samplerCube'},
			GL_SAMPLER_1D_SHADOW = {arg='glUniform1i', glsltype='sampler1DShadow'},
			GL_SAMPLER_2D_SHADOW = {arg='glUniform1i', glsltype='sampler2DShadow'},
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
			GL_INT_SAMPLER_1D = {arg='glUniform1i', glsltype='isampler1D'},
			GL_INT_SAMPLER_2D = {arg='glUniform1i', glsltype='isampler2D'},
			GL_INT_SAMPLER_3D = {arg='glUniform1i', glsltype='isampler3D'},
			GL_INT_SAMPLER_CUBE =  {arg='glUniform1i', glsltype='isamplerCube'},
			GL_INT_SAMPLER_1D_ARRAY = {glsltype='isampler1DArray'},
			GL_INT_SAMPLER_2D_ARRAY = {glsltype='isampler2DArray'},
			GL_INT_SAMPLER_2D_MULTISAMPLE = {glsltype='isampler2DMS'},
			GL_INT_SAMPLER_2D_MULTISAMPLE_ARRAY = {glsltype='isampler2DMSArray'},
			GL_INT_SAMPLER_BUFFER = {glsltype='isamplerBuffer'},
			GL_INT_SAMPLER_2D_RECT = {glsltype='isampler2DRect'},
			GL_UNSIGNED_INT_SAMPLER_1D = {arg='glUniform1i', glsltype='usampler1D'},
			GL_UNSIGNED_INT_SAMPLER_2D = {arg='glUniform1i', glsltype='usampler2D'},
			GL_UNSIGNED_INT_SAMPLER_3D = {arg='glUniform1i', glsltype='usampler3D'},
			GL_UNSIGNED_INT_SAMPLER_CUBE = {arg='glUniform1i', glsltype='usamplerCube'},
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
			local v = op.safeindex(gl, name)
			if info and info.arg then
				info.arg = op.safeindex(gl, info.arg)
				if not info.arg then info = nil end
			end
			if info and info.mat then
				info.mat = op.safeindex(gl, info.mat)
				if not info.mat then info = nil end
			end
			if v and info then
				uniformSettersForGLTypes[v] = info
			end
		end
	end

	local setters = uniformSettersForGLTypes[utype]
	if not setters then
		error("failed to find getter for type "..utype)
	end
	return setters
end

local GLProgram = GetBehavior(GCWrapper{
	gctype = 'autorelease_gl_program_ptr_t',
	ctype = 'GLuint',
	-- retain isn't used
	release = function(ptr)
		return gl.glDeleteProgram(ptr[0])
	end,
}):subclass()


local GLVertexShader = GLShader:subclass()
GLVertexShader.type = gl.GL_VERTEX_SHADER
GLProgram.VertexShader = GLVertexShader

local GLFragmentShader = GLShader:subclass()
GLFragmentShader.type = gl.GL_FRAGMENT_SHADER
GLProgram.FragmentShader = GLFragmentShader

local GLGeometryShader
if op.safeindex(gl, 'GL_GEOMETRY_SHADER') then
	GLGeometryShader = GLShader:subclass()
	GLGeometryShader.type = gl.GL_GEOMETRY_SHADER
	GLProgram.GeometryShader = GLGeometryShader
end

local GLTessEvalShader
if op.safeindex(gl, 'GL_TESS_EVALUATION_SHADER') then
	GLTessEvalShader = GLShader:subclass()
	GLTessEvalShader.type = gl.GL_TESS_EVALUATION_SHADER
	GLProgram.TessEvalShader = GLTessEvalShader
end

local GLTessControlShader
if op.safeindex(gl, 'GL_TESS_CONTROL_SHADER') then
	GLTessControlShader = GLShader:subclass()
	GLTessControlShader.type = gl.GL_TESS_CONTROL_SHADER
	GLProgram.TessControlShader = GLTessControlShader
end

local GLComputeShader
if op.safeindex(gl, 'GL_COMPUTE_SHADER') then
	GLComputeShader = GLShader:subclass()
	GLComputeShader.type = gl.GL_COMPUTE_SHADER
	GLProgram.ComputeShader = GLComputeShader
end


GLProgram.checkLinkStatus = GLShader.createCheckStatus('GL_LINK_STATUS', function(...) return gl.glGetProgramInfoLog(...) end)

-- TODO implement gl.get for all the glGet* functions not associated with any objects/binds
-- not sure if I should bother implementing them associated with getters
-- or maybe I'll just put these 'getGlobal*'s in gl/get.lua ...

local function getGlobal(self, namedparam, results)
	gl.glGetIntegerv(namedparam, results)
end

local function getGlobal3(self, namedparam, results)
	for i=0,2 do
		gl.glGetIntegeri_v(namedparam, i, results+i)
	end
end

GLProgram:makeGetter{
	-- wrap it so wgl can replace glGetShaderiv
	getter = function(self, namevalue, result)
		return gl.glGetProgramiv(self.id, namevalue, result)
	end,
	vars = table{
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
		{name='GL_TRANSFORM_FEEDBACK_BUFFER_MODE', type='GLint'},
		{name='GL_TRANSFORM_FEEDBACK_VARYINGS', type='GLint'},
		{name='GL_TRANSFORM_FEEDBACK_VARYING_MAX_LENGTH', type='GLint'},
	}:append(
		GLGeometryShader
		and {
			{name='GL_GEOMETRY_VERTICES_OUT', type='GLint'},
			{name='GL_GEOMETRY_INPUT_TYPE', type='GLint'},
			{name='GL_GEOMETRY_OUTPUT_TYPE', type='GLint'},
		} or nil
	):append(
		GLComputeShader
		and {
			-- global getters, not associated with the program
			{name='GL_COMPUTE_WORK_GROUP_SIZE', type='GLint'},
			{name='GL_MAX_COMPUTE_WORK_GROUP_INVOCATIONS', type='GLuint', getter=getGlobal},
			{name='GL_MAX_COMPUTE_WORK_GROUP_COUNT', type='GLuint[3]', getter=getGlobal3},
			{name='GL_MAX_COMPUTE_WORK_GROUP_SIZE', type='GLuint[3]', getter=getGlobal3},
		} or nil
	),
}

--[[
args:
	shaders = gl.shader objects that are already compiled, to-be-attached and linked

	${shaderType}Code = the code to pass on to compile this shader type
	shaderType is one of the following:
		vertex
		fragment
		geometry		(only if available)
		tessEval		(only if available)
		tessControl		(only if available)
		compute			(only if available)

	header (optional) passed on to each shader's ctor header
	${shaderType}Header = passed on as the header for only that shader type
	version (optional) passed on to each shader's ctor version
	${shaderType}Versoin = passed on as the version for only that shader type

	uniforms = key/value pair of uniform values to initialize
	attrs = key/value pair mapping attr name to GLAttribute (with type & size specified)
		or to GLAttribute ctor args (where type & size can be optionally specified or inferred)
		or to a GLArrayBuffer object (where type & size is inferred by the shader .attrs)
	attrLocs = optional {[attr name] = loc} for binding attribute locations

NOTICE that the preferred way to bind attributes to buffers is via gl.sceneobject
however defaults can still be assigned via gl.program
--]]
function GLProgram:init(args)
	self.id = gl.glCreateProgram()
	GLProgram.super.init(self, self.id)

	local shaders = table(args.shaders)
	local shaderTypes = table{
		{'vertex', GLVertexShader},
		{'fragment', GLFragmentShader},
	}
	if GLGeometryShader then
		shaderTypes:insert{'geometry', GLGeometryShader}
	end
	if GLTessEvalShader then
		shaderTypes:insert{'tessEval', GLTessEvalShader}
	end
	if GLTessControlShader then
		shaderTypes:insert{'tessControl', GLTessControlShader}
	end
	if GLComputeShader then
		shaderTypes:insert{'compute', GLComputeShader}
	end
	for _,st in ipairs(shaderTypes) do
		local field, cl = table.unpack(st)
		local code = args[field..'Code']
		-- TODO how about multiple vertex/fragment shaders per program?
		-- how about just passing a 'args.shaders' to just attach all?
		if code then
			local headers = table():append({args[field..'Header']}, {args.header})
			shaders:insert(cl{
				code = code,
				version = args[field..'Version'] or args.version,
				header = #headers > 0 and headers:concat'\n' or nil,
			})
		end
	end

	for _,shader in ipairs(shaders) do
		gl.glAttachShader(self.id, shader.id)
	end

	if args.attrLocs then
		for k,v in pairs(args.attrLocs) do
			gl.glBindAttribLocation(self.id, v, k);
		end
	end

	gl.glLinkProgram(self.id)
	self:checkLinkStatus()

	-- now that the program is linked, we can detach all shaders (riiigiht?)
	-- https://community.khronos.org/t/correct-way-to-delete-shader-programs/69742/3
	for _,shader in ipairs(shaders) do
		gl.glDetachShader(self.id, shader.id)
	end

	self:use()

-- TODO to give uniforms their own classes?
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
		-- but in the case that I do keep the loc==-1, and simply do not bind them, then I still get gl errors later ...
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
		self:setAttrs()	-- in case any buffers were specified
	end
end

-- TODO 'bind' ?
function GLProgram:use()
	gl.glUseProgram(self.id)
	return self
end

-- TODO 'unuse' ? or just 'unbind' ?
function GLProgram:useNone()
	gl.glUseProgram(0)
	return self
end

---------------- uniforms ----------------

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

---------------- attributes ----------------

-- Correct me here if I'm wrong ...
-- A program's currently-bound uniforms are stored per-program
-- but a program's currently-bound attributes are not?
-- but attributes are stored per-VAO...
-- ... why aren't uniforms stored per-VAO as well?
-- ... or why aren't attributes stored per-program?
-- If this is the case then maybe I shouldn't have the :setAttr / :enableAttr functionality here?

-- Sets all a program's attributes to their associated pointers (in attr.offset)
-- ... or if they have buffers, binds the buffers and sets to their associated offsets (in attr.offset).
-- Expects attrs to be an array of GLAttributes
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
	return self
end

function GLProgram:enableAndSetAttrs()
	for attrname,attr in pairs(self.attrs) do
		-- setPointer() vs set() ?
		-- set() calls bind() too ...
		-- set() is required.
		attr:enableAndSet()
	end
	return self
end
function GLProgram:disableAttrs()
	for attrname,attr in pairs(self.attrs) do
		attr:disable()
	end
	return self
end

---------------- compute-only ----------------
-- should I just subclass GLProgram?
-- then keep the original GLProgram for vertex/fragment?
-- btw can you link vertex+fragment+compute shaders all together?

-- tex is a gl.tex object
function GLProgram:bindImage(unit, tex, format, rw, level, layered, layer)
	gl.glBindImageTexture(
		unit,
		tex.id,
		level or 0,
		layered or gl.GL_FALSE,
		layer or 0,
		rw,
		format)
	return self
end

--[[
static method for getting the glsl version line

how do I somehow incorporate ES vs non-ES here?
https://stackoverflow.com/a/27410925 this has the mapping from GLES version to GLSL ES version
this says ...
	GLSL-ES pragma '100 es' <=> GL 4.1 <=> GLSL 4.1
	GLSL-ES pragma '300 es' <=> GL 4.3 <=> GLSL 4.3
	GLSL-ES pragma '310 es' <=> GL 4.5 <=> GLSL 4.5
	... and idk about 320 es
--]]
function GLProgram.getVersionPragma(es)
	-- should I auto-detect es?
	if es == nil and op.safeindex(gl, 'GL_ES_VERSION_2_0') then es = true end

	local strptr = gl.glGetString(gl.GL_SHADING_LANGUAGE_VERSION)
	assert(strptr ~= nil, "failed to get GL_SHADING_LANGUAGE_VERSION")
	local version = ffi.string(strptr)
	version = version:gsub('%.', '')
	-- even when using gles, the GL_VERSION I get back corresponds to my GL (non-ES) version (is there a different constant I should be using other than GL_VERSION for the ES version?)
	-- so instead I'll use a mapping from GLSL versions to GLSL-ES versions...
	if es then
		-- TODO just do this once? and maybe in another file?
		local exts = {}
		local extstr = gl.glGetString(gl.GL_EXTENSIONS)
		extstr = extstr == nil and '' or string.trim(ffi.string(extstr))
		for _,ext in ipairs(string.split(extstr, '%s+')) do
			exts[ext] = true
		end

		if version == '460' or exts.GL_ARB_ES3_2_compatibility then
			version = '320 es'
		elseif version >= '450' or exts.GL_ARB_ES3_1_compatibility then
			-- GL 4.5 core, or GL_ARB_ES3_1_compatibility, maps to #version 310 es
			version = '310 es'
		elseif version >= '430' or exts.GL_ARB_ES3_compatibility then
			-- GL 4.3 core, or GL_ARB_ES3_compatibility, maps to #version 300 es
			version = '300 es'
		elseif version >= '410' or exts.GL_ARB_ES2_compatibility then
			-- GL 4.1 core, or GL_ARB_ES2_compatibility, maps to ... #version 100 es ... ?
			version = '100 es'
		else
			error("couldn't find a GLSL-ES version compatible with GLSL version "..tostring(version))
		end
	end
	return '#version '..version
end

return GLProgram
