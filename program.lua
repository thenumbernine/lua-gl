require 'ext.gc'	-- make sure luajit can __gc lua-tables
local ffi = require 'ffi'
local gl = require 'gl'
local assert = require 'ext.assert'
local table = require 'ext.table'
local range = require 'ext.range'
local string = require 'ext.string'
local op = require 'ext.op'
local GLGet = require 'gl.get'
local GLShader = require 'gl.shader'
local GLAttribute = require 'gl.attribute'
local GLArrayBuffer = require 'gl.arraybuffer'
local glnumber = require 'gl.number'

local char_arr = ffi.typeof'char[?]'
local char_const_p_arr = ffi.typeof'char const*[?]'
local int = ffi.typeof'int'
local unsigned_int = ffi.typeof'unsigned int'
local float = ffi.typeof'float'
local double = ffi.typeof'double'
local GLchar_arr = ffi.typeof'GLchar[?]'
local GLint = ffi.typeof'GLint'
local GLint_1 = ffi.typeof'GLint[1]'
local GLint_arr = ffi.typeof'GLint[?]'
local GLsizei_1 = ffi.typeof'GLsizei[1]'
local GLenum_1 = ffi.typeof'GLenum[1]'
local GLenum_arr = ffi.typeof'GLenum[?]'

local checkHasGetProgramResource
do
	local hasGetProgramResource
	checkHasGetProgramResource = function()
		if hasGetProgramResource == nil then
			hasGetProgramResource = not not op.safeindex(gl, 'glGetProgramResourceiv')
		end
		return hasGetProgramResource
	end
end

-- this doesn't work as easy as it does in webgl
-- https://registry.khronos.org/OpenGL-Refpages/gl4/html/glGetActiveUniform.xhtml
local uniformSettersForGLTypes
local function getUniformSettersForGLType(utype)
	-- this table contains symbols from the gl lib
	-- in Windows these symbols haven't been loaded until after gl.app starts
	-- so it's best to build this table upon request
	if not uniformSettersForGLTypes then
		uniformSettersForGLTypes = {}
		for name,info in pairs{
			-- TODO too many ".type"s out there, how about call it ".ctype" instead?
			GL_FLOAT = {arg='glUniform1f', glsltype='float'},
			GL_FLOAT_VEC2 = {arg='glUniform2f', type=float, count=2, vec=gl.glUniform2fv, glsltype='vec2'},
			GL_FLOAT_VEC3 = {arg='glUniform3f', type=float, count=3, vec=gl.glUniform3fv, glsltype='vec3'},
			GL_FLOAT_VEC4 = {arg='glUniform4f', type=float, count=4, vec=gl.glUniform4fv, glsltype='vec4'},
			GL_DOUBLE = {arg='glUniform1d', glsltype='double'},
			GL_DOUBLE_VEC2 = {arg='glUniform2d', type=double, count=2, vec=gl.glUniform2fv, glsltype='dvec2'},
			GL_DOUBLE_VEC3 = {arg='glUniform3d', type=double, count=3, vec=gl.glUniform3fv, glsltype='dvec3'},
			GL_DOUBLE_VEC4 = {arg='glUniform4d', type=double, count=4, vec=gl.glUniform4fv, glsltype='dvec4'},
			GL_INT = {arg='glUniform1i', glsltype='int'},
			GL_INT_VEC2 = {arg='glUniform2i', type=int, count=2, vec=gl.glUniform2iv, glsltype='ivec2'},
			GL_INT_VEC3 = {arg='glUniform3i', type=int, count=3, vec=gl.glUniform3iv, glsltype='ivec3'},
			GL_INT_VEC4 = {arg='glUniform4i', type=int, count=4, vec=gl.glUniform4iv, glsltype='ivec4'},
			GL_UNSIGNED_INT = {arg='glUniform1ui', glsltype='unsigned int'},
			GL_UNSIGNED_INT_VEC2 = {arg='glUniform2ui', type=unsigned_int, count=2, vec=gl.glUniform2uiv, glsltype='uvec2'},
			GL_UNSIGNED_INT_VEC3 = {arg='glUniform3ui', type=unsigned_int, count=3, vec=gl.glUniform3uiv, glsltype='uvec3'},
			GL_UNSIGNED_INT_VEC4 = {arg='glUniform4ui', type=unsigned_int, count=4, vec=gl.glUniform4uiv, glsltype='uvec4'},
			GL_BOOL = {arg='glUniform1i', glsltype='bool'},
			GL_BOOL_VEC2 = {arg='glUniform2i', type=int, count=2, vec=gl.glUniform2iv, glsltype='bvec2'},
			GL_BOOL_VEC3 = {arg='glUniform3i', type=int, count=3, vec=gl.glUniform3iv, glsltype='bvec3'},
			GL_BOOL_VEC4 = {arg='glUniform4i', type=int, count=4, vec=gl.glUniform4iv, glsltype='bvec4'},
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
			GL_SAMPLER_2D_RECT = {arg='glUniform1i', glsltype='sampler2DRect'},
			GL_SAMPLER_2D_RECT_SHADOW = {arg='glUniform1i', glsltype='sampler2DRectShadow'},
			GL_INT_SAMPLER_1D = {arg='glUniform1i', glsltype='isampler1D'},
			GL_INT_SAMPLER_2D = {arg='glUniform1i', glsltype='isampler2D'},
			GL_INT_SAMPLER_3D = {arg='glUniform1i', glsltype='isampler3D'},
			GL_INT_SAMPLER_CUBE =  {arg='glUniform1i', glsltype='isamplerCube'},
			GL_INT_SAMPLER_1D_ARRAY = {glsltype='isampler1DArray'},
			GL_INT_SAMPLER_2D_ARRAY = {glsltype='isampler2DArray'},
			GL_INT_SAMPLER_2D_MULTISAMPLE = {glsltype='isampler2DMS'},
			GL_INT_SAMPLER_2D_MULTISAMPLE_ARRAY = {glsltype='isampler2DMSArray'},
			GL_INT_SAMPLER_BUFFER = {glsltype='isamplerBuffer'},
			GL_INT_SAMPLER_2D_RECT = {arg='glUniform1i', glsltype='isampler2DRect'},
			GL_UNSIGNED_INT_SAMPLER_1D = {arg='glUniform1i', glsltype='usampler1D'},
			GL_UNSIGNED_INT_SAMPLER_2D = {arg='glUniform1i', glsltype='usampler2D'},
			GL_UNSIGNED_INT_SAMPLER_3D = {arg='glUniform1i', glsltype='usampler3D'},
			GL_UNSIGNED_INT_SAMPLER_CUBE = {arg='glUniform1i', glsltype='usamplerCube'},
			GL_UNSIGNED_INT_SAMPLER_1D_ARRAY = {arg='glUniform1i', glsltype='usampler2DArray'},
			GL_UNSIGNED_INT_SAMPLER_2D_ARRAY = {arg='glUniform1i', glsltype='usampler2DArray'},
			GL_UNSIGNED_INT_SAMPLER_2D_MULTISAMPLE = {arg='glUniform1i', glsltype='usampler2DMS'},
			GL_UNSIGNED_INT_SAMPLER_2D_MULTISAMPLE_ARRAY = {arg='glUniform1i', glsltype='usampler2DMSArray'},
			GL_UNSIGNED_INT_SAMPLER_BUFFER = {arg='glUniform1i', glsltype='usamplerBuffer'},
			GL_UNSIGNED_INT_SAMPLER_2D_RECT = {arg='glUniform1i', glsltype='usampler2DRect'},
			GL_IMAGE_1D = {arg='glUniform1i', glsltype='image1D'},
			GL_IMAGE_2D = {arg='glUniform1i', glsltype='image2D'},
			GL_IMAGE_3D = {arg='glUniform1i', glsltype='image3D'},
			GL_IMAGE_2D_RECT = {arg='glUniform1i', glsltype='image2DRect'},
			GL_IMAGE_CUBE = {glsltype='imageCube'},
			GL_IMAGE_BUFFER = {glsltype='imageBuffer'},
			GL_IMAGE_1D_ARRAY = {glsltype='image1DArray'},
			GL_IMAGE_2D_ARRAY = {glsltype='image2DArray'},
			GL_IMAGE_2D_MULTISAMPLE = {glsltype='image2DMS'},
			GL_IMAGE_2D_MULTISAMPLE_ARRAY = {glsltype='image2DMSArray'},
			GL_INT_IMAGE_1D = {arg='glUniform1i', glsltype='iimage1D'},
			GL_INT_IMAGE_2D = {arg='glUniform1i', glsltype='iimage2D'},
			GL_INT_IMAGE_3D = {arg='glUniform1i', glsltype='iimage3D'},
			GL_INT_IMAGE_2D_RECT = {arg='glUniform1i', glsltype='iimage2DRect'},
			GL_INT_IMAGE_CUBE = {arg='glUniform1i', glsltype='iimageCube'},
			GL_INT_IMAGE_BUFFER = {glsltype='iimageBuffer'},
			GL_INT_IMAGE_1D_ARRAY = {glsltype='iimage1DArray'},
			GL_INT_IMAGE_2D_ARRAY = {glsltype='iimage2DArray'},
			GL_INT_IMAGE_2D_MULTISAMPLE = {glsltype='iimage2DMS'},
			GL_INT_IMAGE_2D_MULTISAMPLE_ARRAY = {glsltype='iimage2DMSArray'},
			GL_UNSIGNED_INT_IMAGE_1D = {arg='glUniform1i', glsltype='uimage1D'},
			GL_UNSIGNED_INT_IMAGE_2D = {arg='glUniform1i', glsltype='uimage2D'},
			GL_UNSIGNED_INT_IMAGE_3D = {arg='glUniform1i', glsltype='uimage3D'},
			GL_UNSIGNED_INT_IMAGE_2D_RECT = {arg='glUniform1i', glsltype='uimage2DRect'},
			GL_UNSIGNED_INT_IMAGE_CUBE = {arg='glUniform1i', glsltype='uimageCube'},
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
				-- while we're here, if we have a type then get an array-type ctor
				if info.type then
					info.typeArr = ffi.typeof('$[?]', info.type)
				end

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

local GLProgram = GLGet.behavior()

function GLProgram:delete()
	if self.id == nil then return end
	gl.glDeleteProgram(self.id)
	self.id = nil
end

GLProgram.__gc = GLProgram.delete


local shaderClasses = table()

local GLVertexShader = GLShader:subclass()
GLVertexShader.name = 'vertex'	-- shorthand
GLVertexShader.type = gl.GL_VERTEX_SHADER
GLProgram.VertexShader = GLVertexShader
shaderClasses:insert(GLVertexShader)

local GLFragmentShader = GLShader:subclass()
GLFragmentShader.name = 'fragment'
GLFragmentShader.type = gl.GL_FRAGMENT_SHADER
GLProgram.FragmentShader = GLFragmentShader
shaderClasses:insert(GLFragmentShader)

local GLGeometryShader
if op.safeindex(gl, 'GL_GEOMETRY_SHADER') then
	GLGeometryShader = GLShader:subclass()
	GLGeometryShader.name = 'geometry'
	GLGeometryShader.type = gl.GL_GEOMETRY_SHADER
	GLProgram.GeometryShader = GLGeometryShader
	shaderClasses:insert(GLGeometryShader)
else
	shaderClasses:insert{name='geometry', notavailable=true}
end

local GLTessEvalShader
if op.safeindex(gl, 'GL_TESS_EVALUATION_SHADER') then
	GLTessEvalShader = GLShader:subclass()
	GLTessEvalShader.name = 'tessEval'
	GLTessEvalShader.type = gl.GL_TESS_EVALUATION_SHADER
	GLProgram.TessEvalShader = GLTessEvalShader
	shaderClasses:insert(GLTessEvalShader)
else
	shaderClasses:insert{name='tessEval', notavailable=true}
end

local GLTessControlShader
if op.safeindex(gl, 'GL_TESS_CONTROL_SHADER') then
	GLTessControlShader = GLShader:subclass()
	GLTessControlShader.name = 'tessControl'
	GLTessControlShader.type = gl.GL_TESS_CONTROL_SHADER
	GLProgram.TessControlShader = GLTessControlShader
	shaderClasses:insert(GLTessControlShader)
else
	shaderClasses:insert{name='tessControl', notavailable=true}
end

local GLComputeShader
if op.safeindex(gl, 'GL_COMPUTE_SHADER') then
	GLComputeShader = GLShader:subclass()
	GLComputeShader.name = 'compute'
	GLComputeShader.type = gl.GL_COMPUTE_SHADER
	GLProgram.ComputeShader = GLComputeShader
	shaderClasses:insert(GLComputeShader)
else
	shaderClasses:insert{name='compute', notavailable=true}
end


GLProgram.checkLinkStatus = GLShader.createCheckStatus('GL_LINK_STATUS', function(...) return gl.glGetProgramInfoLog(...) end)

local glRetProgrami = GLGet.makeRetLastArg{
	name = 'glGetProgramiv',
	ctype = GLint,
	lookup = {2},
}
local function getGLGetProgrami(self, nameValue)
	return glRetProgrami(self.id, nameValue)
end

local glRetProgramInterfacei = GLGet.makeRetLastArg{
	name = 'glGetProgramInterfaceiv',
	ctype = GLint,
	lookup = {2, 3},
}
local function getGLGetProgramInterfacei(self, programInterface, pname)
	return glRetProgramInterfacei(self.id, programInterface, pname)
end

GLProgram:makeGetter{
	-- wrap it so wgl can replace glGetShaderiv
	vars = table.append(
		table{
			{name='GL_DELETE_STATUS'},
			{name='GL_LINK_STATUS'},
			{name='GL_VALIDATE_STATUS'},
			{name='GL_INFO_LOG_LENGTH'},
			{name='GL_ATTACHED_SHADERS'},
			{name='GL_ACTIVE_ATTRIBUTES'},
			{name='GL_ACTIVE_ATTRIBUTE_MAX_LENGTH'},
			{name='GL_ACTIVE_UNIFORMS'},
			{name='GL_ACTIVE_UNIFORM_MAX_LENGTH'},
			{name='GL_ACTIVE_UNIFORM_BLOCKS'},
			{name='GL_ACTIVE_ATOMIC_COUNTER_BUFFERS'},
			{name='GL_PROGRAM_BINARY_LENGTH'},
			{name='GL_TRANSFORM_FEEDBACK_BUFFER_MODE'},
			{name='GL_TRANSFORM_FEEDBACK_VARYINGS'},
			{name='GL_TRANSFORM_FEEDBACK_VARYING_MAX_LENGTH'},
		}:append(
			GLGeometryShader
			and {
				{name='GL_GEOMETRY_VERTICES_OUT'},
				{name='GL_GEOMETRY_INPUT_TYPE'},
				{name='GL_GEOMETRY_OUTPUT_TYPE'},
			} or nil
		):mapi(function(args)
			args.getter = getGLGetProgrami
			return args
		end),

		table{
			{name='GL_UNIFORM'},
			{name='GL_UNIFORM_BLOCK'},
			{name='GL_ATOMIC_COUNTER_BUFFER'},
			{name='GL_PROGRAM_INPUT'},
			{name='GL_PROGRAM_OUTPUT'},
			{name='GL_VERTEX_SUBROUTINE'},
			{name='GL_TESS_CONTROL_SUBROUTINE'},
			{name='GL_TESS_EVALUATION_SUBROUTINE'},
			{name='GL_GEOMETRY_SUBROUTINE'},
			{name='GL_FRAGMENT_SUBROUTINE'},
			{name='GL_COMPUTE_SUBROUTINE'},
			{name='GL_VERTEX_SUBROUTINE_UNIFORM'},
			{name='GL_TESS_CONTROL_SUBROUTINE_UNIFORM'},
			{name='GL_TESS_EVALUATION_SUBROUTINE_UNIFORM'},
			{name='GL_GEOMETRY_SUBROUTINE_UNIFORM'},
			{name='GL_FRAGMENT_SUBROUTINE_UNIFORM'},
			{name='GL_COMPUTE_SUBROUTINE_UNIFORM'},
			{name='GL_TRANSFORM_FEEDBACK_VARYING'},
			{name='GL_BUFFER_VARIABLE'},
			{name='GL_SHADER_STORAGE_BLOCK'},
			{name='GL_TRANSFORM_FEEDBACK_BUFFER'},
		}:mapi(function(args)
			args.getter = getGLGetProgramInterfacei
			return args
		end)
	),
}

-- TODO glGetProgramResource

GLProgram.rowMajor = true	-- do we transpose input matrices? args can override

--[[
args:
	shaders = gl.shader objects that are already compiled, to-be-attached and linked

	-- or(/and?)

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
	${shaderType}Version = passed on as the version for only that shader type

	precision (optional) passed to each shader's ctor's header
	${shaderType}Precision = " " " for only that shader type

		use precision = 'best' for whatever the best float precision is.  TODO same with int?  or separate into precFloat/precInt?  or just nah because it's only required in GLES for floats?
		use version = 'latest' for whatever the latest GLSL version is.
		use version = 'latest es' for whatever the latest GLSL ES version is.

	-- or

	${shaderType}Binary

	binaryFormat
	${shaderType}BinaryFormat

	binaryEntryPoint
	${shaderType}BinaryEntryPoint

	-- or

	shadersBinary
	shadersBinaryStages
	(with binaryFormat)
	(with binaryEntryPoint or ${shaderType}BinaryEntryPoint)

	-- or

	programBinary
	(with binaryFormat)

	-- and

	uniforms = key/value pair of uniform values to initialize
	attrs = key/value pair mapping attr name to GLAttribute (with type & dim specified)
		or to GLAttribute ctor args (where type & dim can be optionally specified or inferred)
		or to a GLArrayBuffer object (where type & dim is inferred by the shader .attrs)
	attrLocs = optional {[attr name] = loc} for binding attribute locations

NOTICE that the preferred way to bind attributes to buffers is via gl.sceneobject
however defaults can still be assigned via gl.program

	transformFeedback = {
		[i] = name of varying,
		...
		mode = gl.GL_INTERLEAVED_ATTRIBS, gl.GL_SEPARATE_ATTRIBS
			or 'interleaved' or 'separate'
	}

	rowMajor = whether to set the glUniformMatrix to upload rowMajor (I'm defaulting this to true because my C matrices are row-major by default, because I want my C indexes to match math indexes)
--]]
function GLProgram:init(args)
	self.id = gl.glCreateProgram()
	self.rowMajor = args.rowMajor

	if args.programBinary then
		-- glProgramBinary will set the link status,
		-- so do either it or glLinkProgram
		-- in fact, .programBinary should short-circuit all other shader initialization
		local programBinary = args.programBinary
		assert.type(programBinary, 'string')

		gl.glProgramBinary(
			self.id,
			assert.index(args, 'binaryFormat'),
			programBinary,	-- cdata or string
			#programBinary
		)

		self:checkLinkStatus()
	else
		local shaders = table(args.shaders)
		for _,cl in ipairs(shaderClasses) do
			local name = cl.name
			local code = args[name..'Code']
			-- TODO how about multiple vertex/fragment shaders per program?
			-- how about just passing a 'args.shaders' to just attach all?
			if code then
				if cl.notavailable then error("requested shader "..cl.name.." from code but it is not available") end
				local headers = table():append({args[name..'Header']}, {args.header})
				shaders:insert(cl{
					code = code,
					version = args[name..'Version'] or args.version,
					precision = args[name..'Precision'] or args.precision,
					header = #headers > 0 and headers:concat'\n' or nil,
				})
			end
	-- [[ for specifying one binary per one shader-module ... not working and with no errors given
			local binary = args[name..'Binary']
			if binary then
				if cl.notavailable then error("requested shader "..cl.name.." from binary but it is not available") end
				shaders:insert(cl{
					binary = binary,
					binaryFormat = args[name..'BinaryFormat'] or args.binaryFormat,
					binaryEntry = args[name..'BinaryEntry'] or args.binaryEntry,
				})
			end
	--]]
		end

	-- [[ specifying all binaries together.  the API allows it so I get the feeling the implementers only supported one certain way despite the docs not specifying this.
		if args.shadersBinary then
			local binary = assert.type(args.shadersBinary, 'string')
			assert.type(args.shadersBinaryStages, 'table', '.shadersBinary requires .shadersBinaryStages')
			local vector = require 'stl.vector-lua'
			local shaderIDs = vector'GLuint'
			local binShaders = table()

			for _,cl in ipairs(shaderClasses) do
				if cl.notavailable then error("requested shader "..cl.name.." from binary but it is not available") end
				if table.find(args.shadersBinaryStages, cl.name) then
					local shader = cl()
					binShaders:insert(shader)
					shaderIDs:emplace_back()[0] = shader.id
				end
			end
			assert.gt(#shaderIDs, 0, "expected at least one shadersBinaryStages")
			assert.eq(#shaderIDs, #binShaders)

			gl.glShaderBinary(
				#shaderIDs,
				shaderIDs.v,
				assert.index(args, 'binaryFormat'),
				binary,
				#binary
			)

			-- make sure glSpecializeShader exists (in GLES2 when glShaderBinary was first introduced, it doesn't exist)
			if op.safeindex(gl, 'glSpecializeShader') then
				for _,shader in ipairs(binShaders) do
					gl.glSpecializeShader(
						shader.id,
						-- allow per-module entry name in args...
						args[shader.name..'BinaryEntry']
							or args.binaryEntry
							or 'main',	--const GLchar *pEntryPoint,
						0,		--GLuint numSpecializationConstants,
						nil,	--const GLuint *pConstantIndex,
						nil		--const GLuint *pConstantValue
					)
				end
			end

			local success = true
			for _,shader in ipairs(binShaders) do
				success = shader:checkCompileStatus(nil, true) and success
			end
			if not success then
				error("one or more binary shader compile failed")
			end

			shaders:append(binShaders)
		end
	--]]

	-- TODO glProgramBinary support as well

		for _,shader in ipairs(shaders) do
			gl.glAttachShader(self.id, shader.id)
		end

		if args.attrLocs then
			for k,v in pairs(args.attrLocs) do
				gl.glBindAttribLocation(self.id, v, k);
			end
		end

		local transformFeedback = args.transformFeedback
		if transformFeedback then
			local n = #transformFeedback
			local varyings = char_const_p_arr(n)
			for i=1,n do
				varyings[i-1] = transformFeedback[i]
			end
			local mode = transformFeedback.mode
			mode = ({
				interleaved = gl.GL_INTERLEAVED_ATTRIBS,
				separate = gl.GL_SEPARATE_ATTRIBS,
			})[mode] or mode
			if not mode then error("transformFeedback has unknown mode "..tostring(mode)) end
			gl.glTransformFeedbackVaryings(self.id, n, varyings, mode)
		end

		gl.glLinkProgram(self.id)

		self:checkLinkStatus()

		-- now that the program is linked, we can detach all shaders (riiigiht?)
		-- https://community.khronos.org/t/correct-way-to-delete-shader-programs/69742/3
		for _,shader in ipairs(shaders) do
			gl.glDetachShader(self.id, shader.id)
		end
	end

	self:use()

-- TODO to give uniforms their own classes?
	self.uniforms = {}
	local maxUniforms = self:get'GL_ACTIVE_UNIFORMS'
	if checkHasGetProgramResource() then
		local maxUniforms2 = self:get('GL_UNIFORM', gl.GL_ACTIVE_RESOURCES)
		if maxUniforms ~= maxUniforms2 then
			io.stderr:write('!!! glGetProgramiv GL_ACTIVE_UNIFORMS == '..tostring(maxUniforms)..' vs glGetProgramInterfaceiv GL_UNIFORM GL_ACTIVE_RESOURCES == '..tostring(maxUniforms2)..'\n')
		end
	end
	local maxLen = self:get'GL_ACTIVE_UNIFORM_MAX_LENGTH'
	for i=1,maxUniforms do
		local bufSize = maxLen+1
		local name = GLchar_arr(bufSize)
		local length = GLsizei_1()
		ffi.fill(name, bufSize)
		local arraySize = GLint_1()
		local utype = GLenum_1()
		gl.glGetActiveUniform(self.id, i-1, bufSize, length, arraySize, utype, name)
		local info = {
			name = length[0] > 0 and ffi.string(name, length[0]) or nil,
			arraySize = arraySize[0],
			type = utype[0],
		}

		-- in GLES3, you need a uniform name to get its location
		-- but in GL>=4.3 you can use glGetProgramResourceiv
		if checkHasGetProgramResource() then
			local propNames = table{
				--'GL_NAME_LENGTH', already done above
				--'GL_TYPE', already done above
				--'GL_ARRAY_SIZE', already done above
				'GL_OFFSET',
				'GL_BLOCK_INDEX',
				'GL_ARRAY_STRIDE',
				'GL_MATRIX_STRIDE',
				'GL_IS_ROW_MAJOR',
				'GL_ATOMIC_COUNTER_BUFFER_INDEX',
				'GL_REFERENCED_BY_VERTEX_SHADER',
				'GL_REFERENCED_BY_TESS_CONTROL_SHADER',
				'GL_REFERENCED_BY_TESS_EVALUATION_SHADER',
				'GL_REFERENCED_BY_GEOMETRY_SHADER',
				'GL_REFERENCED_BY_FRAGMENT_SHADER',
				'GL_REFERENCED_BY_COMPUTE_SHADER',
				'GL_LOCATION',
			}
			local propForName = propNames:mapi(function(name,i)
				return i-1, name
			end):setmetatable(nil)
			local propsLua = propNames:mapi(function(name)
				return gl[name]
			end)
			local numProps = #propsLua
			local props = GLenum_arr(numProps, propsLua)
			local propResults = GLint_arr(numProps)
			gl.glGetProgramResourceiv(
				self.id,
				gl.GL_UNIFORM,
				i-1,
				numProps,
				props,
				numProps,	-- buffer size ... in ints?
				nil,
				propResults
			)
			info.loc = propResults[propForName.GL_LOCATION]
			info.offset = propResults[propForName.GL_OFFSET]
			info.blockIndex = propResults[propForName.GL_BLOCK_INDEX]
			info.arrayStride = propResults[propForName.GL_ARRAY_STRIDE]
			info.matrixStride = propResults[propForName.GL_MATRIX_STRIDE]
			info.rowMajor = propResults[propForName.GL_IS_ROW_MAJOR] ~= 0
			info.atomicCounterBufferIndex = propResults[propForName.GL_ATOMIC_COUNTER_BUFFER_INDEX]

			info.refByVertex = propResults[propForName.GL_REFERENCED_BY_VERTEX_SHADER] ~= 0 or nil
			info.refByFragment = propResults[propForName.GL_REFERENCED_BY_FRAGMENT_SHADER] ~= 0 or nil
			info.refByGeometry = GLGeometryShader and propResults[propForName.GL_REFERENCED_BY_GEOMETRY_SHADER] ~= 0 or nil
			info.refByTessControl = GLTessControlShader and propResults[propForName.GL_REFERENCED_BY_TESS_CONTROL_SHADER] ~= 0 or nil
			info.refByTessEval = GLTessEvalShader and propResults[propForName.GL_REFERENCED_BY_TESS_EVALUATION_SHADER] ~= 0 or nil
			info.refByCompute = GLComputeShader and propResults[propForName.GL_REFERENCED_BY_COMPUTE_SHADER] ~= 0 or nil
		elseif info.name then
			info.loc = gl.glGetUniformLocation(self.id, info.name)
		else
			-- warning, can't get location of unnamed uniform...
		end

		info.setters = getUniformSettersForGLType(info.type)
		self.uniforms[i] = info		-- index by binding
		if info.name then
			self.uniforms[info.name] = info
		end
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
		- dim (1,2,3,4)
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
	do
		local nameMaxLen = self:get'GL_ACTIVE_ATTRIBUTE_MAX_LENGTH'
		local bufSize = nameMaxLen+1
		local nameBuf = GLchar_arr(bufSize)
		local length = GLsizei_1()
		local arraySize = GLint_1()
		local glslType = GLenum_1()
		for index=0,self:get'GL_ACTIVE_ATTRIBUTES'-1 do
			ffi.fill(nameBuf, bufSize)
			gl.glGetActiveAttrib(self.id, index, bufSize, length, arraySize, glslType, nameBuf)
			local name = ffi.string(nameBuf, length[0])
			-- copy any ctor args into this attr, such as any to-be-bound buffers ...
			-- ... this use-case was for programs whose attributes are bound up front.
			-- not sure if I want to allow this anymore in favor instead of GLSceneObject being the collecting point of all attributes, shaders, geometry, etc.
			local varargs
			if args.attrs then
				varargs = args.attrs[name]
				if GLArrayBuffer:isa(varargs) then
					varargs = {buffer = varargs}
				end
			end
			varargs = table(varargs)
			varargs.name = name
			varargs.arraySize = arraySize[0]
			varargs.glslType = glslType[0]
			varargs.loc = gl.glGetAttribLocation(self.id, name)
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
			if varargs.loc ~= -1 then
				self.attrs[name] = GLAttribute(varargs)
				-- set .index here or it'll get tossed by the GLAttribute ctor
				self.attrs[name].index = index		-- index is not the same as location ... is index the same as binding?
			end
		end
	end

	--[[ TODO
	-- https://registry.khronos.org/OpenGL-Refpages/gl4/html/glGetTransformFeedbackVarying.xhtml
	-- makes this all sound like all it's doing is retelling you whatever you told it in glTransformFeedbackVaryings
	-- If that's the case then I think there's no point to holding onto this.
	-- I thougth maybe there'd be some sort of 'loc' info like there is for in's and out's, but nah.
	-- From the sentence "An index of 0 selects the first varying variable specified in the varyings array passed to glTransformFeedbackVaryings,"
	-- ... it sounds like everything you pass into the .transformFeedback[] is all you'd need for the subsequent :bindBase(index) call
	self.varyings = {}
	do
		local nameMaxLen = self:get'GL_TRANSFORM_FEEDBACK_VARYING_MAX_LENGTH'
		local bufSize = nameMaxLen+1
		local nameBuf = GLchar_arr(bufSize)
		local length = GLsizei_1()
		local arraySize = GLint_1()
		local glslType = GLenum_1()
		for index=0,self:get'GL_TRANSFORM_FEEDBACK_VARYINGS'-1 do
			ffi.fill(nameBuf, bufSize)
			gl.glGetTransformFeedbackVarying(self.id, index, bufSize, length, arraySize, glslType, nameBuf)
			local name = ffi.string(nameBuf, length[0])
			local varargs
			-- TODO I think there's absolutely no purpose to ctor user-specified .varyings[] information.
			-- except maybe for setting transformFeedback varyings
			-- which I already set via ctor arg .transformFeedback and is handled above
			if args.varyings then
				varargs = args.varyings[name]
				if GLArrayBuffer:isa(varargs) then
					varargs = {buffer = varargs}
				end
			end
			varargs = table(varargs)
			varargs.index = index		-- index is not the same as location ... is index the same as binding?
			varargs.name = name
			varargs.arraySize = arraySize[0]
			varargs.glslType = glslType[0]
			-- feedback varyings don't have locations
			-- but they do have bindings
			-- but can those be set?  or retrieved?
			--varargs.loc = gl.glGetAttribLocation(self.id, name)
			-- and TODO should this be a GLAttribute?  should it be a superclass?
			self.varyings[name] = varargs
		end
	end
	--]]

	-- see if the caller is going to tell us to do anything with the program's uniform blocks
	-- specifically, set up any bindings ...
	local srcUniformBlocks = args.uniformBlocks

	self.uniformBlocks = {}
	local numBlocks = self:get'GL_ACTIVE_UNIFORM_BLOCKS'
	for uniformBlockIndex=0,numBlocks-1 do
		local nameLen = GLsizei_1(9999)
		gl.glGetActiveUniformBlockiv(self.id, uniformBlockIndex, gl.GL_UNIFORM_BLOCK_NAME_LENGTH, nameLen);

		local name = char_arr(nameLen[0]+1)
		-- "The actual number of characters written into uniformBlockName, excluding the nul terminator, is returned in length. " from https://registry.khronos.org/OpenGL-Refpages/es3.0/html/glGetActiveUniformBlockName.xhtml
		-- but for a 5-char name I'm getting back "6" result from GL_UNIFORM_BLOCK_NAME_LENGTH ... meaning including-nul-terminator ...
		-- is GL_UNIFORM_BLOCK_NAME_LENGTH different from glGetActiveUniformBlockName?
		-- does glGetActiveUniformBlockName even give a length result if you don't pass in a buffer?
		local nameLen2 = GLsizei_1(9999)
		gl.glGetActiveUniformBlockName(self.id, uniformBlockIndex, nameLen[0], nameLen2, name);
		nameLen2 = nameLen2[0]
		name = nameLen2 > 0 and ffi.string(name, nameLen2) or nil
		-- sure enough, the 2nd-to-last arg returning the buffer length without nul-term is one less than glGetActiveUniformBlockiv GL_UNIFORM_BLOCK_NAME_LENGTH

		-- see if we were asked to set the binding point
		-- do this before querying the binding point for our program's .uniformBlocks table
		local srcUniformBlock = srcUniformBlocks and name and srcUniformBlocks[name]
		if srcUniformBlock then
			if srcUniformBlock.binding then
				gl.glUniformBlockBinding(
					self.id,
					uniformBlockIndex,
					srcUniformBlock.binding
				)
			end
		end

		local binding = GLint_1()
		gl.glGetActiveUniformBlockiv(self.id, uniformBlockIndex, gl.GL_UNIFORM_BLOCK_BINDING, binding)

		local dataSize = GLint_1()
		gl.glGetActiveUniformBlockiv(self.id, uniformBlockIndex, gl.GL_UNIFORM_BLOCK_DATA_SIZE, dataSize)

		local numActiveUniforms = GLint_1()
		gl.glGetActiveUniformBlockiv(self.id, uniformBlockIndex, gl.GL_UNIFORM_BLOCK_ACTIVE_UNIFORMS, numActiveUniforms)

		local numActiveUniformIndices = GLint_arr(numActiveUniforms[0])
		gl.glGetActiveUniformBlockiv(self.id, uniformBlockIndex, gl.GL_UNIFORM_BLOCK_ACTIVE_UNIFORM_INDICES, numActiveUniformIndices)

		local refByVtxShader = GLint_1()
		gl.glGetActiveUniformBlockiv(self.id, uniformBlockIndex, gl.GL_UNIFORM_BLOCK_REFERENCED_BY_VERTEX_SHADER, refByVtxShader)

		local refByFragShader = GLint_1()
		gl.glGetActiveUniformBlockiv(self.id, uniformBlockIndex, gl.GL_UNIFORM_BLOCK_REFERENCED_BY_FRAGMENT_SHADER, refByFragShader)

		local refByGeomShader
		if GLGeometryShader then
			refByGeomShader = GLint_1()
			gl.glGetActiveUniformBlockiv(self.id, uniformBlockIndex, gl.GL_UNIFORM_BLOCK_REFERENCED_BY_GEOMETRY_SHADER, refByGeomShader)
		end

		local refByTessEvalShader
		if GLTessEvalShader then
			refByTessEvalShader = GLint_1()
			gl.glGetActiveUniformBlockiv(self.id, uniformBlockIndex, gl.GL_UNIFORM_BLOCK_REFERENCED_BY_TESS_EVALUATION_SHADER, refByTessEvalShader)
		end

		local refByTessControlShader
		if GLTessControlShader then
			refByTessControlShader = GLint_1()
			gl.glGetActiveUniformBlockiv(self.id, uniformBlockIndex, gl.GL_UNIFORM_BLOCK_REFERENCED_BY_TESS_CONTROL_SHADER, refByTessControlShader)
		end

		local refByComputeShader
		if GLComputeShader then
			refByComputeShader = GLint_1()
			gl.glGetActiveUniformBlockiv(self.id, uniformBlockIndex, gl.GL_UNIFORM_BLOCK_REFERENCED_BY_COMPUTE_SHADER, refByComputeShader)
		end

		local uniformBlock = {
			name = name,
			blockIndex = uniformBlockIndex,
			binding = binding[0],
			dataSize = dataSize[0],
			uniformIndices = range(0,numActiveUniforms[0]-1):mapi(function(i)
				return numActiveUniformIndices[i]
			end),
			refByVertex = refByVtxShader[0] ~= 0 or nil,
			refByFragment = refByFragShader[0] ~= 0 or nil,
			refByGeometry = GLGeometryShader and refByGeomShader[0] ~= 0 or nil,
			refByTessControl = GLTessControlShader and refByTessControlShader[0] ~= 0 or nil,
			refByTessEval = GLTessEvalShader and refByTessEvalShader[0] ~= 0 or nil,
			refByCompute = GLComputeShader and refByComputeShader[0] ~= 0 or nil,
		}

		self.uniformBlocks[1+uniformBlockIndex] = uniformBlock
		if name then self.uniformBlocks[name] = uniformBlock end
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

function GLProgram:getBinary()
	local length = GLsizei_1(self:get'GL_PROGRAM_BINARY_LENGTH')
	local binary = char_arr(length[0])
	local binaryFormat = GLenum_1()
	gl.glGetProgramBinary(self.id, length[0], length, binaryFormat, binary)
	return ffi.string(binary, length[0]), binaryFormat[0]
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
	if not info then return self end
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
			setters.mat(loc, 1, self.rowMajor, value)
		else
			error("failed to find array setter for uniform "..name..' type '..tostring(info.type))
		end
	elseif valueType ~= 'table' then
		local setter = setters.arg
		if not setter then
			error("failed to find non-array setter for uniform "..name..' type '..tostring(info.type))
		end
		setter(loc, value, ...)
	else	-- table
		if setters.arg then
			setters.arg(loc, table.unpack(value, 1, setters.count))
		elseif setters.vec then
			local cdata = setters.typeArr(setters.count)
			for i=1,setters.count do
				cdata[i-1] = value[i]
			end
			setters.vec(loc, 1, cdata)
		elseif setters.mat then
			-- TODO c data conversion
			setters.mat(loc, 1, sfalseelf.rowMajor, value)
		else
			error("failed to find array setter for uniform "..name..' type '..tostring(info.type))
		end
	end
	return self
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
function GLProgram:bindImage(unit, tex, rw, format, level, layered, layer)
	if layered == nil then
		if tex.target == gl.GL_TEXTURE_3D then
			-- tex3D needs layered yet.
			-- technically at https://wikis.khronos.org/opengl/Image_Load_Store
			-- it says "If layered is GL_TRUE, then texture must be an Array Texture (of some type), a Cubemap Texture, or a 3D Texture."
			-- it says layered works with tex3d
			-- but it means tex3d *ONLY WORKS WITH* layered.
			layered = gl.GL_TRUE
		else
			layered = gl.GL_FALSE
		end
	end
	gl.glBindImageTexture(
		unit,
		tex.id or tex,
		level or 0,
		layered or gl.GL_FALSE,
		layer or 0,
		rw,
		format or tex.internalFormat or error("expected format or GLTex to have .internalFormat")
	)
	return self
end

function GLProgram:dispatchCompute(...)
	gl.glDispatchCompute(...)
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

this page says ( https://en.wikipedia.org/wiki/OpenGL_Shading_Language#Versions ):
pragma:			GLSL		OpenGL
#version 110	1.10.59		2.0
#version 120	1.20.8		2.1
#version 130	1.30.10		3.0
#version 140	1.40.08		3.1
#version 150	1.50.11		3.2
#version 330	3.30.6		3.3
#version 400	4.00.9		4.0
#version 410	4.10.6		4.1
#version 420	4.20.1		4.2
#version 430	4.30.8		4.3
#version 440	4.40.9		4.4
#version 450	4.50.7		4.5
#version 460	4.60.5		4.6

pragma:			GLSL-ES GLES	WebGL	GLSL-equivalent
#version 100	1.00.17	2.0		1.0		1.20
#version 300 es	3.00.6	3.0		2.0		3.30
#version 310 es	3.10.5	3.1				GLSL ES 3.00	<- why does this chart say GLSL-equiv of GLSL-ES 3.10 is GLSL-ES 3.00 ?  weird ...
#version 320 es	3.20.6	3.2				GLSL ES 3.10
--]]
function GLProgram.getVersionPragma(es)
	-- should I auto-detect es?
	if es == nil and op.safeindex(gl, 'GL_ES_VERSION_2_0') then es = true end

	local glGlobal = require 'gl.global'
	local versionStr = assert(glGlobal:get'GL_SHADING_LANGUAGE_VERSION')

	-- Emscripten not so much, so here's a case for it:
	local esver = versionStr:match'^OpenGL ES GLSL ES ([0-9%.]*)'
	if esver then
		-- hmm if we know the GLSL ver is ES and getVersionPragma didn't request ES ...
		-- ... what do we do? error? force-set es=true?
		-- nothing?
		return '#version '..esver:gsub('%.', '')..' es'
	end

	local version = versionStr:gsub('%.', '')
	-- somtimes (windows) there's a space and extra crap after the version number ...
	version = version:match'%S+'
	-- When using GLES on Desktop, the GL_VERSION I get back corresponds to my GL (non-ES) version (is there a different constant I should be using other than GL_VERSION for the ES version?)
	-- so instead I'll use a mapping from GLSL versions to GLSL-ES versions...
	if es then
		-- TODO just do this once? and maybe in another file?
		local exts = {}

		-- turns out, when using core gl (as osx now requires for 4.1 support), getting extensions causes a GL error ...
		local extstr = string.trim(glGlobal:get'GL_EXTENSIONS' or '')
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

--[[ getting tired of copy pasting so here's a program builder helper function...
args:
	version
	precision
	vertex = type of vertex, default vec3
	mvAndProjSeparate = true for mvMat and ProjMat separate uniforms, false for just mvProjMat ...
		... alternatively I could just use mvMat and projMat here, and require the caller to pass both in ...
	gl_Program = expression for gl_Program
	color =
		{r,g,b,a}
		| {fixed = {r,g,b,a}}
			= output is 4 component table of the fixed color
		{uniform =
			true
			| ctype of the uniform color (default name 'color')}
			-- TODO in the future maybe let specify uniform name
		{texture = true
			| texcoord attribute name (default type vec2)
			| expression (for reading vertex)
			-- TODO in the future maybe specify ctype as well
--]]
function GLProgram.make(args)
	local function toVec4(ctype, name, w)
		w = w or '1.'
		if type(w) == 'number' then w = glnumber(w) end
		if ctype == 'float' then
			return 'vec4('..name..', 0., 0., '..w..')'
		elseif ctype == 'vec2' then
			return 'vec4('..name..', 0., '..w..')'
		elseif ctype == 'vec3' then
			return 'vec4('..name..', '..w..')'
		else
			return name
		end
	end
	local tex = args.tex
	local texCoordAttr = args.texCoordAttr
	local texCoordVarying = args.texture	-- TODO deduce
	if texCoordVarying then
		texCoordVarying.type = texCoordVarying.type or 'vec2'
		texCoordVarying.name = texCoordVarying.name or 'texcoordv'
		if not texCoordVarying.expr then
			texCoordAttr = {type=texCoordVarying.type, name='texcoord'}
			texCoordVarying.expr = texCoordAttr.name
		end
		tex.type = tex.type or 'sampler2D'
		tex.name = tex.name or 'tex'
	end
	local fixedColor
	if args.color then
		if args.color.fixed then
			fixedColor = args.color.fixed
		elseif type(args.color) == 'table'
		and #args.color == 4
		then
			fixedColor = args.color
		end
	end

	-- default
	local gl_Program_expr = args.gl_Program
		or args.mvAndProjSeparate and 'projMat * mvMat * '..toVec4(args.vertex, 'vertex')
		or 'mvProjMat * '..toVec4(args.vertex, 'vertex')
	-- hmm
	return GLProgram{
		version = args.version or 'latest',
		precision = args.precision or 'best',
		vertexCode = table():append(
			{
				'layout(location=0) in '..args.vertex..' vertex;',
			},
			texCoordAttr and {
				'layout(location=1) in '..texCoordAttr.type..' '..texCoordAttr.name..';',
			} or nil,
			texCoordVarying and {
				'out '..texCoordVarying.type..' '..texCoordVarying.name..';',
			} or nil,
			{
				'uniform mat4 '..(args.mvAndProjSeparate and 'mvMat, projMat;' or 'mvProjMat;'),
				'void main() {',
			},
			texCoordVarying and {
				'	'..texCoordVarying.name..' = '..castVec(texCoordVarying.type, texCoordVarying.expr)..';',
			} or nil,
			{
				'	gl_Position = '..gl_Program_expr..';',
				'}',
			}
		):concat'\n',
		fragmentCode = table():append({
				'out vec4 fragColor;',
			},
			args.color.uniform and {
				'uniform '..args.color.uniform..' color;',
			} or nil,
			tex and {
				'uniform '..tex.type..' '..tex.name..';',
			} or nil,
			{
				'void main() {',
				'	fragColor = '..(
					fixedColor
						and 'vec4('..range(4):mapi(function(i)
							return glnumber(fixedColor[i] or 1)
						end):concat','..')'
						or args.color.uniform and toVec4(args.color.uniform, 'color')
						or args.color.texture and 'texture('..tex.name..', '..texCoordVarying.name..')'
						or error("idk how to handle args.color")
				)..';',
				'}',
			}
		):concat'\n',
	}:useNone()
end

return GLProgram
