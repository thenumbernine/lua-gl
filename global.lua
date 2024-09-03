local ffi = require 'ffi'
local table = require 'ext.table'
local asserteq = require 'ext.assert'.eq
local gl = require 'gl'
local GetBehavior = require 'gl.get'
local GLGlobal = GetBehavior()

local function makeString(name)
	return {
		name = name,
		type = 'GLchar*',	-- result is [1] of these ...
		getter = function(self, nameParam, result)
			-- this will pass to gl.get's template:get() correctly ...
			-- but that will return a char* ... not a Lua string ... soo ...
			-- ... TODO post-transform wrapper just for this function
			result[0] = gl.glGetString(nameParam)
		end,
		postxform = function(self, result, count)
			asserteq(count, 1)
			return ffi.string(result[0])
		end
	}
end

local function makeBoolean(name)
	return {
		name = name,
		type = 'GLboolean',
		getter = function(self, nameParam, result)
			return gl.glGetBooleanv(nameParam, result)
		end,
	}
end

local function makeInt(name)
	return {
		name = name,
		type = 'GLint',
		getter = function(self, nameParam, result)
			return gl.glGetIntegerv(nameParam, result)
		end,
	}
end

local function makeInt64(name)
	return {
		name = name,
		type = 'GLint64',
		getter = function(self, nameParam, result)
			return gl.glGetInteger64v(nameParam, result)
		end,
	}
end

local function makeFloat(name)
	return {
		name = name,
		type = 'GLfloat',
		getter = function(self, nameParam, result)
			return gl.glGetFloatv(nameParam, result)
		end,
	}
end

local function makeDouble(name)
	return {
		name = name,
		type = 'GLdouble',
		getter = function(self, nameParam, result)
			return gl.glGetDoublev(nameParam, result)
		end,
	}
end

local function makeIntN(name, count)
	local var = makeInt(name)
	var.count = count
	return var
end

local function makeDoubleN(name, count)
	local var = makeDouble(name)
	var.count = count
	return var
end

local version
local tmp = xpcall(function()
	local int = ffi.new'GLint[1]'
	gl.glGetIntegerv(gl.GL_MAJOR_VERSION, int)
	local major = int[0]
	gl.glGetIntegerv(gl.GL_MINOR_VERSION, int)
	local minor = int[0]
	version = major + .1 * minor
end, function(err)
	print('first attempt to get gl version failed')
	print(err..'\n'..debug.traceback())
end) or xpcall(function()
	version = tonumber(ffi.string(gl.glGetString(gl.GL_VERSION)):split'%s+'[1])
end, function(err)
	print('second attempt to get gl version failed')
	print(err..'\n'..debug.traceback())
end) or error("couldn't get the GL version")

GLGlobal:makeGetter{
	getter = function(self, nameValue, result)
		error'global has no defaults'
	end,
	vars = table{
		makeString'GL_VENDOR',
		makeString'GL_RENDERER',
		makeString'GL_VERSION',
		makeString'GL_SHADING_LANGUAGAE',
		makeInt'GL_MAJOR_VERSION',
		makeInt'GL_MINOR_VERSION',
		makeInt'GL_ACTIVE_TEXTURE',
		makeInt'GL_RED_BITS',				-- gles 300 but not gl 4
		makeInt'GL_GREEN_BITS',				-- gles 300 but not gl 4
		makeInt'GL_BLUE_BITS',				-- gles 300 but not gl 4 ?
		makeInt'GL_ALPHA_BITS',				-- gles 300 but not gl 4 ?
		makeInt'GL_DEPTH_BITS',				-- gles 300 but not gl 4 ?
		makeInt'GL_STENCIL_BITS',			-- gles 300 but not gl 4
		makeInt'GL_SUBPIXEL_BITS',
		makeInt'GL_SUBPIXEL_BITS',

		makeInt'GL_POINT_FADE_THRESHOLD_SIZE',			-- gl 4 but not gles 300
		makeInt'GL_POINT_SIZE',			-- gl 4 but not gles 300
		makeDouble'GL_POINT_SIZE_GRANULARITY',			-- gl 4 but not gles 300
		makeDoubleN('GL_POINT_SIZE_RANGE', 2),			-- gl 4 but not gles 300
		makeDoubleN('GL_ALIASED_POINT_SIZE_RANGE', 2),		-- gles 300 but not gl 4 ?

		makeInt'GL_LINE_SMOOTH',						-- gl 4 but not gles 300
		makeInt'GL_LINE_SMOOTH_HINT',				-- gl 4 but not gles 300
		makeInt'GL_LINE_WIDTH',
		makeInt'GL_SMOOTH_LINE_WIDTH_RANGE',			-- gl 4 but not gles 300
		makeInt'GL_SMOOTH_LINE_WIDTH_GRANULARITY',			-- gl 4 but not gles 300
		makeDoubleN('GL_ALIASED_LINE_WIDTH_RANGE', 2),

		makeInt'GL_POLYGON_SMOOTH',		-- gl 4 but not gles 300
		makeInt'GL_POLYGON_SMOOTH_HINT',		-- gl 4 but not gles 300
		makeInt'GL_POLYGON_OFFSET_FACTOR',
		makeInt'GL_POLYGON_OFFSET_UNITS',
		makeInt'GL_POLYGON_OFFSET_FILL',
		makeInt'GL_POLYGON_OFFSET_LINE',			-- gl 4 but not gles 300
		makeInt'GL_POLYGON_OFFSET_POINT',			-- gl 4 but not gles 300

		makeInt'GL_BLEND',
		makeInt'GL_BLEND_COLOR',						-- getting this causes a segfault upon exit ... gl driver bug?
		makeInt'GL_BLEND_DST_ALPHA',
		makeInt'GL_BLEND_DST_RGB',
		makeInt'GL_BLEND_EQUATION_RGB',
		makeInt'GL_BLEND_EQUATION_ALPHA',			-- gles 300 but not gl 4 ?
		makeInt'GL_BLEND_SRC_ALPHA',
		makeInt'GL_BLEND_SRC_RGB',

		makeInt'GL_COLOR_CLEAR_VALUE',				-- segfault upon exit
		makeInt'GL_COLOR_LOGIC_OP',					-- gl 4 but not gles 300
		makeInt'GL_COLOR_WRITEMASK',

		makeInt'GL_LOGIC_OP_MODE',					-- gl 4 but not gles 300

		-- TODO
		--makeInts('GL_NUM_COMPRESSED_TEXTURE_FORMATS', 'GL_COMPRESSED_TEXTURE_FORMATS'),

	-- and at this point I'm giving up on flagging all getters that cause segfaults  ... 3 out of the first 16 is too much
		makeInt'GL_CONTEXT_FLAGS',					-- gl 4 but not gles 300
		makeInt'GL_CULL_FACE',
		makeInt'GL_CULL_FACE_MODE',
		makeInt'GL_CURRENT_PROGRAM',
		makeInt'GL_DEPTH_CLEAR_VALUE',
		makeInt'GL_DEPTH_FUNC',
		makeInt'GL_DEPTH_RANGE',
		makeInt'GL_DEPTH_TEST',
		makeInt'GL_DEPTH_WRITEMASK',
		makeInt'GL_DITHER',
		makeInt'GL_DOUBLEBUFFER',					-- gl 4 but not gles 300
		makeInt'GL_DRAW_BUFFER',
		--[[ TODO
		local maxDrawBuffers = makeInt'GL_MAX_DRAW_BUFFERS',
		for i=0,maxDrawBuffers-1 do
			makeIntIndex('GL_DRAW_BUFFER', i)
		end
		--]]

		makeInt'GL_ACTIVE_TEXTURE',
		makeInt'GL_ARRAY_BUFFER_BINDING',
		makeInt'GL_DRAW_FRAMEBUFFER_BINDING',
		makeInt'GL_READ_FRAMEBUFFER_BINDING',
		makeInt'GL_ELEMENT_ARRAY_BUFFER_BINDING',
		makeInt'GL_PIXEL_PACK_BUFFER_BINDING',
		makeInt'GL_PIXEL_UNPACK_BUFFER_BINDING',
		makeInt'GL_PROGRAM_PIPELINE_BINDING',			-- gl 4 but not gles 300
		makeInt'GL_RENDERBUFFER_BINDING',
		makeInt'GL_SAMPLER_BINDING',

		makeInt'GL_FRAGMENT_SHADER_DERIVATIVE_HINT',
		makeInt'GL_FRONT_FACE',						-- gles 300 but not gl 4
		makeInt'GL_GENERATE_MIPMAP_HINT',			-- gles 300 but not gl 4
		makeInt'GL_IMPLEMENTATION_COLOR_READ_FORMAT',
		makeInt'GL_IMPLEMENTATION_COLOR_READ_TYPE',

		makeInt'GL_MAX_COMBINED_SHADER_STORAGE_BLOCKS',	-- gl 4 but not gles 300.  segfault upon exit
		makeInt'GL_MAX_DUAL_SOURCE_DRAW_BUFFERS',	-- gl 4 but not gles 300
		makeInt'GL_MAX_3D_TEXTURE_SIZE',
		makeInt'GL_MAX_ARRAY_TEXTURE_LAYERS',
		makeInt'GL_MAX_COLOR_ATTACHMENTS',			-- gles 300 but not gl 4
		makeInt'GL_MAX_CLIP_DISTANCES',				-- gl 4 but not gles 300
		makeInt'GL_MAX_COLOR_TEXTURE_SAMPLES',				-- gl 4 but not gles 300
		makeInt'GL_MAX_COMBINED_ATOMIC_COUNTERS',				-- gl 4 but not gles 300
		makeInt'GL_MAX_COMBINED_FRAGMENT_UNIFORM_COMPONENTS',
		makeInt'GL_MAX_COMBINED_GEOMETRY_UNIFORM_COMPONENTS',				-- gl 4 but not gles 300
		makeInt'GL_MAX_COMBINED_TEXTURE_IMAGE_UNITS',
		makeInt'GL_MAX_COMBINED_UNIFORM_BLOCKS',
		makeInt'GL_MAX_COMBINED_VERTEX_UNIFORM_COMPONENTS',
		makeInt'GL_MAX_CUBE_MAP_TEXTURE_SIZE',
		makeInt'GL_MAX_DEPTH_TEXTURE_SAMPLES',				-- gl 4 but not gles 300
		makeInt'GL_MAX_ELEMENTS_INDICES',
		makeInt'GL_MAX_ELEMENTS_VERTICES',
		makeInt'GL_MAX_FRAGMENT_INPUT_COMPONENTS',
		makeInt'GL_MAX_FRAGMENT_UNIFORM_COMPONENTS',
		makeInt'GL_MAX_FRAGMENT_UNIFORM_VECTORS',
		makeInt'GL_MAX_FRAGMENT_UNIFORM_BLOCKS',
		makeInt'GL_MAX_GEOMETRY_INPUT_COMPONENTS',				-- gl 4 but not gles 300
		makeInt'GL_MAX_GEOMETRY_OUTPUT_COMPONENTS',				-- gl 4 but not gles 300
		makeInt'GL_MAX_GEOMETRY_TEXTURE_IMAGE_UNITS',				-- gl 4 but not gles 300
		makeInt'GL_MAX_GEOMETRY_UNIFORM_BLOCKS',				-- gl 4 but not gles 300
		makeInt'GL_MAX_GEOMETRY_UNIFORM_COMPONENTS',				-- gl 4 but not gles 300
		makeInt'GL_MAX_INTEGER_SAMPLES',				-- gl 4 but not gles 300
		makeInt'GL_MAX_PROGRAM_TEXEL_OFFSET',
		makeInt'GL_MIN_PROGRAM_TEXEL_OFFSET',
		makeInt'GL_MAX_RECTANGLE_TEXTURE_SIZE',			-- gl 4 but not gles 300
		makeInt'GL_MAX_RENDERBUFFER_SIZE',
		makeInt'GL_MAX_SAMPLES',						-- gles 300 but not gl 4
		makeInt'GL_MAX_SAMPLE_MASK_WORDS',			-- gl 4 but not gles 300
		makeInt'GL_MAX_SERVER_WAIT_TIMEOUT',
		makeInt'GL_MAX_TEXTURE_BUFFER_SIZE',						-- gl 4 but not gles 300
		makeInt'GL_MAX_TEXTURE_IMAGE_UNITS',
		makeDouble'GL_MAX_TEXTURE_LOD_BIAS',
		makeInt'GL_MAX_TEXTURE_SIZE',
		makeInt'GL_MAX_TRANSFORM_FEEDBACK_INTERLEAVED_COMPONENTS',	-- gles 300 but not gl 4
		makeInt'GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_ATTRIBS',	-- gles 300 but not gl 4
		makeInt'GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_COMPONENTS',	-- gles 300 but not gl 4
		makeInt'GL_MAX_UNIFORM_BUFFER_BINDINGS',
		makeInt'GL_MAX_UNIFORM_BLOCK_SIZE',
		makeInt'GL_MAX_VARYING_COMPONENTS',
		makeInt'GL_MAX_VARYING_VECTORS',
		makeInt'GL_MAX_VARYING_FLOATS',					-- gl 4 but not gles 300
		makeInt'GL_MAX_VERTEX_ATTRIBS',
		makeInt'GL_MAX_VERTEX_TEXTURE_IMAGE_UNITS',
		makeInt'GL_MAX_VERTEX_UNIFORM_COMPONENTS',
		makeInt'GL_MAX_VERTEX_UNIFORM_VECTORS',
		makeInt'GL_MAX_VERTEX_OUTPUT_COMPONENTS',
		makeInt'GL_MAX_VERTEX_UNIFORM_BLOCKS',
		makeInt'GL_MAX_VIEWPORT_DIMS',
		makeInt'GL_NUM_EXTENSIONS',
		makeInt'GL_NUM_SHADER_BINARY_FORMATS',
		makeInt'GL_PACK_ALIGNMENT',
		makeInt'GL_PACK_IMAGE_HEIGHT',			-- gl 4 but not gles 300
		makeInt'GL_PACK_LSB_FIRST',			-- gl 4 but not gles 300
		makeInt'GL_PACK_ROW_LENGTH',
		makeInt'GL_PACK_SKIP_IMAGES',			-- gl 4 but not gles 300
		makeInt'GL_PACK_SKIP_PIXELS',
		makeInt'GL_PACK_SKIP_ROWS',
		makeInt'GL_PACK_SWAP_BYTES',			-- gl 4 but not gles 300
		makeInt'GL_PRIMITIVE_RESTART_INDEX',			-- gl 4 but not gles 300
		-- TODO
		--makeInts('GL_NUM_PROGRAM_BINARY_FORMATS', 'GL_PROGRAM_BINARY_FORMATS',)
		makeInt'GL_PROGRAM_POINT_SIZE',			-- gl 4 but not gles 300
		makeInt'GL_PROVOKING_VERTEX',			-- gl 4 but not gles 300
		makeInt'GL_PRIMITIVE_RESTART_FIXED_INDEX',	-- gles 300 but not gl 4
		makeInt'GL_RASTERIZER_DISCARD',	-- gles 300 but not gl 4
		makeInt'GL_READ_BUFFER',
		makeInt'GL_SAMPLE_ALPHA_TO_COVERAGE',	-- gles 300 but not gl 4
		makeInt'GL_SAMPLE_BUFFERS',
		makeDouble'GL_SAMPLE_COVERAGE_VALUE',
		makeInt'GL_SAMPLE_COVERAGE_INVERT',
		makeInt'GL_SAMPLE_COVERAGE',		-- gles 300 but not gl 4
		makeInt'GL_SAMPLE_MASK_VALUE',	-- gl 4 but not gles 300
		makeInt'GL_SAMPLES',
		makeIntN('GL_SCISSOR_BOX', 4),
		makeInt'GL_SCISSOR_TEST',
		makeInt'GL_SHADER_BINARY_FORMATS',	-- gles 300 but not gl 4
		makeInt'GL_SHADER_COMPILER',
		makeInt'GL_SHADER_STORAGE_BUFFER_OFFSET_ALIGNMENT',	-- gl 4 but not gles 300
		--[[ TODO
		local maxShaderStorageBufferBindings = makeInt'GL_MAX_SHADER_STORAGE_BUFFER_BINDINGS',	-- gl 4 but not gles 300
		if type(maxShaderStorageBufferBindings) ~= 'string' then
			for i=0,maxShaderStorageBufferBindings-1 do
				--makeIntIndex('GL_SHADER_STORAGE_BUFFER_BINDING', i)	-- can be indexed, but whats the index range?
			end
			for i=0,maxShaderStorageBufferBindings-1 do
				--makeInt64Index('GL_SHADER_STORAGE_BUFFER_START', i)	-- can be indexed, but whats the index range?
			end
			for i=0,maxShaderStorageBufferBindings-1 do
				--makeInt64Index('GL_SHADER_STORAGE_BUFFER_SIZE', i)	-- can be indexed, but whats the index range?
			end
		end
		--]]
		makeInt'GL_STENCIL_BACK_FAIL',
		makeInt'GL_STENCIL_BACK_FUNC',
		makeInt'GL_STENCIL_BACK_PASS_DEPTH_FAIL',
		makeInt'GL_STENCIL_BACK_PASS_DEPTH_PASS',
		makeInt'GL_STENCIL_BACK_REF',
		makeInt'GL_STENCIL_BACK_VALUE_MASK',
		makeInt'GL_STENCIL_BACK_WRITEMASK',
		makeInt'GL_STENCIL_CLEAR_VALUE',
		makeInt'GL_STENCIL_FAIL',
		makeInt'GL_STENCIL_FUNC',
		makeInt'GL_STENCIL_PASS_DEPTH_FAIL',
		makeInt'GL_STENCIL_PASS_DEPTH_PASS',
		makeInt'GL_STENCIL_REF',
		makeInt'GL_STENCIL_TEST',
		makeInt'GL_STENCIL_VALUE_MASK',
		makeInt'GL_STENCIL_WRITEMASK',
		makeInt'GL_STEREO',								-- gl 4 but not gles 300
		makeInt'GL_TEXTURE_BINDING_1D',	-- gl 4 but not gles 300
		makeInt'GL_TEXTURE_BINDING_1D_ARRAY',	-- gl 4 but not gles 300
		makeInt'GL_TEXTURE_BINDING_2D',
		makeInt'GL_TEXTURE_BINDING_2D_ARRAY',
		makeInt'GL_TEXTURE_BINDING_2D_MULTISAMPLE',	-- gl 4 but not gles 300
		makeInt'GL_TEXTURE_BINDING_2D_MULTISAMPLE_ARRAY',	-- gl 4 but not gles 300
		makeInt'GL_TEXTURE_BINDING_3D',
		makeInt'GL_TEXTURE_BINDING_BUFFER',	-- gl 4 but not gles 300
		makeInt'GL_TEXTURE_BINDING_CUBE_MAP',
		makeInt'GL_TEXTURE_BINDING_RECTANGLE',
		makeInt'GL_TEXTURE_COMPRESSION_HINT',
		makeInt64'GL_TIMESTAMP',
		-- which is the max for these?
		--[[ TODO
		if type(maxShaderStorageBufferBindings) ~= 'string' then
			for i=0,maxShaderStorageBufferBindings-1 do
				--makeIntIndex('GL_TRANSFORM_FEEDBACK_BUFFER_BINDING', i)
			end
			for i=0,maxShaderStorageBufferBindings-1 do
				--makeInt64Index('GL_TRANSFORM_FEEDBACK_BUFFER_START', i)
			end
			for i=0,maxShaderStorageBufferBindings-1 do
				--makeInt64Index('GL_TRANSFORM_FEEDBACK_BUFFER_SIZE', i)
			end
			--makeInt64Index('GL_TRANSFORM_FEEDBACK_BINDING', i)	-- gles 300 but not gl 4
			makeInt'GL_MAX_TRANSFORM_FEEDBACK_BUFFERS',
			--makeIntIndex'GL_TRANSFORM_FEEDBACK_ACTIVE',	-- gles 300 but not gl 4
			--makeIntIndex'GL_TRANSFORM_FEEDBACK_PAUSED',	-- gles 300 but not gl 4
			-- which is the max for these?
			for i=0,maxShaderStorageBufferBindings-1 do
				--makeIntIndex('GL_UNIFORM_BUFFER_BINDING', i)
			end
			for i=0,maxShaderStorageBufferBindings-1 do
				--makeInt64Index('GL_UNIFORM_BUFFER_SIZE', i)
			end
			for i=0,maxShaderStorageBufferBindings-1 do
				--makeInt64Index('GL_UNIFORM_BUFFER_START', i)
			end
			if version >= 4.3 then
				-- which is the max for these?
				for i=0,maxShaderStorageBufferBindings-1 do
					--makeIntIndex('GL_VERTEX_BINDING_DIVISOR', i)	-- gl 4 but not gles 300
				end
				for i=0,maxShaderStorageBufferBindings-1 do
					--makeIntIndex('GL_VERTEX_BINDING_OFFSET', i)	-- gl 4 but not gles 300
				end
				for i=0,maxShaderStorageBufferBindings-1 do
					--makeIntIndex('GL_VERTEX_BINDING_STRIDE', i)	-- gl 4 but not gles 300
				end
				for i=0,maxShaderStorageBufferBindings-1 do
					--makeIntIndex('GL_VERTEX_BINDING_BUFFER', i)	-- gl 4 but not gles 300
				end
			end
		end
		--]]
		makeInt'GL_UNIFORM_BUFFER_OFFSET_ALIGNMENT',
		makeInt'GL_UNPACK_ALIGNMENT',
		makeInt'GL_UNPACK_IMAGE_HEIGHT',
		makeInt'GL_UNPACK_LSB_FIRST',		-- gl 4 but not gles 300
		makeInt'GL_UNPACK_ROW_LENGTH',
		makeInt'GL_UNPACK_SKIP_IMAGES',
		makeInt'GL_UNPACK_SKIP_PIXELS',
		makeInt'GL_UNPACK_SKIP_ROWS',
		makeInt'GL_UNPACK_SWAP_BYTES',		-- gl 4 but not gles 300
		makeInt'GL_VERTEX_ARRAY_BINDING',
	}:append(
		version < 4.1 and {} or {
			--print'GL version >= 4.1:'
			--[[ TODO
			local maxViewports = makeInt'GL_MAX_VIEWPORTS',
			for i=0,maxViewports-1 do
				makeInt4Index('GL_VIEWPORT', i)
			end
			--]]
			makeInt'GL_VIEWPORT_SUBPIXEL_BITS',
			makeIntN('GL_VIEWPORT_BOUNDS_RANGE', 2),
			makeInt'GL_LAYER_PROVOKING_VERTEX',
			makeInt'GL_VIEWPORT_INDEX_PROVOKING_VERTEX',
			-- TODO
			--makeInts('GL_NUM_SHADER_BINARY_FORMATS', 'GL_SHADER_BINARY_FORMATS',)
		}
	):append(
		version < 4.2 and {} or {
			--print'GL version >= 4.2:'
			makeInt'GL_MAX_VERTEX_ATOMIC_COUNTERS',
			makeInt'GL_MAX_TESS_CONTROL_ATOMIC_COUNTERS',
			makeInt'GL_MAX_TESS_EVALUATION_ATOMIC_COUNTERS',
			makeInt'GL_MAX_GEOMETRY_ATOMIC_COUNTERS',
			makeInt'GL_MAX_FRAGMENT_ATOMIC_COUNTERS',
			makeInt'GL_MIN_MAP_BUFFER_ALIGNMENT',
		}
	):append(
		version < 4.3 and {} or {
			--print'GL version >= 4.3:'
			makeInt'GL_MAX_ELEMENT_INDEX',
			makeInt'GL_MAX_COMPUTE_UNIFORM_BLOCKS',
			makeInt'GL_MAX_COMPUTE_TEXTURE_IMAGE_UNITS',
			makeInt'GL_MAX_COMPUTE_UNIFORM_COMPONENTS',
			makeInt'GL_MAX_COMPUTE_ATOMIC_COUNTERS',
			makeInt'GL_MAX_COMPUTE_ATOMIC_COUNTER_BUFFERS',
			makeInt'GL_MAX_COMBINED_COMPUTE_UNIFORM_COMPONENTS',
			makeInt'GL_MAX_COMPUTE_WORK_GROUP_INVOCATIONS',
			--[[ TODO
			print('GL_MAX_COMPUTE_WORK_GROUP_COUNT', range(0,2):mapi(function(i)
				return getIntIndex('GL_MAX_COMPUTE_WORK_GROUP_COUNT', i)
			end):concat' ')
			print('GL_MAX_COMPUTE_WORK_GROUP_SIZE', range(0,2):mapi(function(i)
				return getIntIndex('GL_MAX_COMPUTE_WORK_GROUP_SIZE', i)
			end):concat' ')
			--]]
			makeInt'GL_DISPATCH_INDIRECT_BUFFER_BINDING',
			makeInt'GL_MAX_DEBUG_GROUP_STACK_DEPTH',
			makeInt'GL_DEBUG_GROUP_STACK_DEPTH',
			makeInt'GL_MAX_LABEL_LENGTH',
			makeInt'GL_MAX_UNIFORM_LOCATIONS',
			makeInt'GL_MAX_FRAMEBUFFER_WIDTH',
			makeInt'GL_MAX_FRAMEBUFFER_HEIGHT',
			makeInt'GL_MAX_FRAMEBUFFER_LAYERS',
			makeInt'GL_MAX_FRAMEBUFFER_SAMPLES',
			makeInt'GL_MAX_VERTEX_SHADER_STORAGE_BLOCKS',
			makeInt'GL_MAX_TESS_CONTROL_SHADER_STORAGE_BLOCKS',
			makeInt'GL_MAX_TESS_EVALUATION_SHADER_STORAGE_BLOCKS',
			makeInt'GL_MAX_GEOMETRY_SHADER_STORAGE_BLOCKS',
			makeInt'GL_MAX_FRAGMENT_SHADER_STORAGE_BLOCKS',
			makeInt'GL_MAX_COMPUTE_SHADER_STORAGE_BLOCKS',
			makeInt'GL_TEXTURE_BUFFER_OFFSET_ALIGNMENT',
			makeInt'GL_MAX_VERTEX_ATTRIB_RELATIVE_OFFSET',
			makeInt'GL_MAX_VERTEX_ATTRIB_BINDINGS',
		}
	):append(
	--[==[ TODO
		table{
			'GL_VERTEX_SHADER',
			'GL_FRAGMENT_SHADER',
			'GL_GEOMETRY_SHADER',
			'GL_TESS_EVALUATION_SHADER',
			'GL_TESS_CONTROL_SHADER',
			'GL_COMPUTE_SHADER',
		}:mapi(function(shaderTypeParam)
			if require 'ext.op'.safeindex(gl, shaderTypeParam) then
				for _,precParam in ipairs{
					'GL_LOW_FLOAT', 'GL_MEDIUM_FLOAT', 'GL_HIGH_FLOAT',
					'GL_LOW_INT', 'GL_MEDIUM_INT', 'GL_HIGH_INT',
				} do
					local range = ffi.new'GLint[2]'
					local precision = ffi.new'GLint[1]'
					gl.glGetShaderPrecisionFormat(gl[shaderTypeParam], gl[precParam], range, precision)
					print(shaderTypeParam, precParam, 'range={'..range[0]..', '..range[1]..'},\tprecision='..precision[0])
				end
			end
		end

		local strptr = gl.glGetString(gl.GL_EXTENSIONS)
		local str = ffi.string(strptr)
		print('GL_EXTENSIONS', '\n\t'..(str:trim():split' ',:sort():concat
			--' '
			'\n\t'
		))
	--]==]
	):setmetatable(nil),
}
local glGlobal = GLGlobal()
return glGlobal 
