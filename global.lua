local ffi = require 'ffi'
local table = require 'ext.table'
local range = require 'ext.range'
local op = require 'ext.op'
local asserteq = require 'ext.assert'.eq
local asserttype = require 'ext.assert'.type
local assertindex = require 'ext.assert'.index
local gl = require 'gl'
local GLGet = require 'gl.get'

local GLGlobal = GLGet.behavior()

local function makeString(name)
	return {
		name = name,
		getter = function(self, nameValue)
			return GLGet.string(nameValue)
		end,
	}
end

local function makeBoolean(name)
	return {
		name = name,
		getter = function(self, nameValue)
			return GLGet.boolean(nameValue)
		end,
	}
end

local function makeInt(name)
	return {
		name = name,
		getter = function(self, nameValue)
			return GLGet.int(nameValue)
		end,
	}
end

local function makeInt64(name)
	return {
		name = name,
		getter = function(self, nameValue)
			return GLGet.int64(nameValue)
		end,
	}
end

local function makeFloat(name)
	return {
		name = name,
		getter = function(self, nameValue)
			return GLGet.float(nameValue)
		end,
	}
end

local function makeDouble(name)
	return {
		name = name,
		getter = function(self, nameValue)
			return GLGet.double(nameValue)
		end,
	}
end

local function makeN(var, count)
	local oldGetter = assertindex(var, 'getter')
	var.getter = function(...)
	end
end

local function makeIntN(name, count)
	local glRetIntN = GLGet.returnLastArgAsType('glGetIntegerv', 'GLint', count)
	return {
		name = name,
		getter = function(self, nameValue)
			return glRetIntN(nameValue)
		end,
	}
end

local function makeDoubleN(name, count)
	local glRetDoubleN = GLGet.returnLastArgAsType('glGetDoublev', 'GLdouble', count)
	return {
		name = name,
		getter = function(self, nameValue)
			return glRetDoubleN(nameValue)
		end,
	}
end

-- TODO getters-with-num-getters are very exceptional to the gl.get system and are going to make me rewrite everything ...
-- TODO TODO even worse, if some params are used with glGet*v then they return one thing,
--  while if they are used with glGet*i_v then they return another ...
local function makeInts(name, numName)
	return {
		name = name,
		getter = function(self, nameValue, result, ...)
			local num = table.pack(self:get(numName))
			if not num[1] then return num:unpack() end
			num = num[1]
			asserttype(num, 'number')

			-- if it's a getter that gets the whole array ...
			local result = ffi.new('GLint[?]', num)
			gl.glGetIntegerv(nameValue, result)
			return range(0,num-1):mapi(function(i)
				return result[i]
			end):unpack(1,num)
		end,
	}
end

-- this makes getters assocaited with the *i_v indexed gl getters
-- makeIntVec will often have a count-associated param like makeInts
-- but that's entirely arbitrary
-- likewise getters might have a non-indexed getter
--  so I will call the i_v or the regular depending on if an argument is used
local glSafeCall = require 'gl.error'.glSafeCall
local function makeVec(args)
	local name = assertindex(args, 'name')
	local ctype = assertindex(args, 'type')
	local getterName = assertindex(args, 'getterName')
	local indexedGetterName = assertindex(args, 'indexedGetterName')
	local count = args.count or 1

	local getter = op.safeindex(gl, getterName)
	local indexedGetter = op.safeindex(gl, indexedGetterName)
	return {
		name = name,
		getter = function(self, nameValue, ...)
require 'gl.report' 'here'
			if select('#', ...) == 0 then
--print('performing', getterName, name, ...)
				if not getter then
					return nil, getterName..' not found'
				end
				local result = ffi.new(ctype..'[?]', count)
				local success, msg = glSafeCall(getterName, nameValue, result)
				-- TODO gl.get template:get getter() has no way to report errors ...
				if not success then return nil, msg end
				return range(0,count-1):mapi(function(i) return result[i] end):unpack(1, count)
			else
--print('performing indexed', indexedGetterName, name, ...)
				if not indexedGetter then
					return nil, indexedGetterName..' not found'
				end
				local result = ffi.new(ctype..'[?]', count)
				local index = select('#', ...)
				local success, msg = glSafeCall(indexedGetterName, nameValue, index, result)
				if not success then return nil, msg end
				return range(0,count-1):mapi(function(i) return result[i] end):unpack(1, count)
			end
		end,
	}
end

local function makeIntVec(name, count)
	return makeVec{
		name = name,
		type = 'GLint',
		getterName = 'glGetIntegerv',
		indexedGetterName = 'glGetIntegeri_v',
		count = count,
	}
end
local function makeInt64Vec(name, count)
	return makeVec{
		name = name,
		type = 'GLint64',
		getterName = 'glGetInteger64v',
		indexedGetterName = 'glGetInteger64i_v',
		count = count,
	}
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
		makeString'GL_SHADING_LANGUAGE_VERSION',
		makeString'GL_EXTENSIONS',
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
		makeDoubleN('GL_BLEND_COLOR', 4),
		makeInt'GL_BLEND_DST_ALPHA',
		makeInt'GL_BLEND_DST_RGB',
		makeInt'GL_BLEND_EQUATION_RGB',
		makeInt'GL_BLEND_EQUATION_ALPHA',			-- gles 300 but not gl 4 ?
		makeInt'GL_BLEND_SRC_ALPHA',
		makeInt'GL_BLEND_SRC_RGB',

		makeDoubleN('GL_COLOR_CLEAR_VALUE', 4),
		makeInt'GL_COLOR_LOGIC_OP',					-- gl 4 but not gles 300
		makeIntN('GL_COLOR_WRITEMASK', 4),

		makeInt'GL_LOGIC_OP_MODE',					-- gl 4 but not gles 300

		makeInt'GL_NUM_COMPRESSED_TEXTURE_FORMATS',
		makeInts('GL_COMPRESSED_TEXTURE_FORMATS', 'GL_NUM_COMPRESSED_TEXTURE_FORMATS'),

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
		makeInt'GL_MAX_DRAW_BUFFERS',

		-- TODO Is this accepted both for glGetIntegerv and glGetIntegeri_v?
		-- Does it return different results for each?
		-- TODO There's an argument for adding extra params to :get() here - to get specific indexes instead of getting everything
		makeIntVec'GL_DRAW_BUFFER', -- sized GL_MAX_DRAW_BUFFERS

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
		makeInt'GL_NUM_PROGRAM_BINARY_FORMATS',
		makeInts('GL_PROGRAM_BINARY_FORMATS', 'GL_NUM_PROGRAM_BINARY_FORMATS'),
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
		makeInt'GL_MAX_SHADER_STORAGE_BUFFER_BINDINGS',	-- gl 4 but not gles 300
		makeInt64Vec'GL_SHADER_STORAGE_BUFFER_BINDING',	-- can be indexed, but whats the index range?
		makeInt64Vec'GL_SHADER_STORAGE_BUFFER_START',	-- can be indexed, but whats the index range?
		makeInt64Vec'GL_SHADER_STORAGE_BUFFER_SIZE',	-- can be indexed, but whats the index range?
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
		makeInt'GL_MAX_TRANSFORM_FEEDBACK_BUFFERS',
		-- which is the max for these?
		makeIntVec'GL_TRANSFORM_FEEDBACK_BUFFER_BINDING',	-- sized i think by GL_MAX_SHADER_STORAGE_BUFFER_BINDINGS
		makeInt64Vec'GL_TRANSFORM_FEEDBACK_BUFFER_START',	-- sized i think by GL_MAX_SHADER_STORAGE_BUFFER_BINDINGS
		makeInt64Vec'GL_TRANSFORM_FEEDBACK_BUFFER_SIZE',	-- sized i think by GL_MAX_SHADER_STORAGE_BUFFER_BINDINGS
		makeInt64Vec'GL_TRANSFORM_FEEDBACK_BINDING',		-- sized i think by GL_MAX_SHADER_STORAGE_BUFFER_BINDINGS, gles 300 but not gl 4
		makeIntVec'GL_TRANSFORM_FEEDBACK_ACTIVE',	-- gles 300 but not gl 4
		makeIntVec'GL_TRANSFORM_FEEDBACK_PAUSED',	-- gles 300 but not gl 4
		makeIntVec'GL_UNIFORM_BUFFER_BINDING',
		makeInt64Vec'GL_UNIFORM_BUFFER_SIZE',
		makeInt64Vec'GL_UNIFORM_BUFFER_START',
		makeIntVec'GL_VERTEX_BINDING_DIVISOR',	-- gl 4 but not gles 300
		makeIntVec'GL_VERTEX_BINDING_OFFSET',	-- gl 4 but not gles 300
		makeIntVec'GL_VERTEX_BINDING_STRIDE',	-- gl 4 but not gles 300
		makeIntVec'GL_VERTEX_BINDING_BUFFER',	-- gl 4 but not gles 300
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
			makeInt'GL_MAX_VIEWPORTS',
			makeIntVec('GL_VIEWPORT', 4),	-- sized GL_MAX_VIEWPORTS
			makeInt'GL_VIEWPORT_SUBPIXEL_BITS',
			makeIntN('GL_VIEWPORT_BOUNDS_RANGE', 2),
			makeInt'GL_LAYER_PROVOKING_VERTEX',
			makeInt'GL_VIEWPORT_INDEX_PROVOKING_VERTEX',
			makeInt'GL_NUM_SHADER_BINARY_FORMATS',
			makeInts('GL_SHADER_BINARY_FORMATS', 'GL_NUM_SHADER_BINARY_FORMATS'),
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
			makeIntVec'GL_MAX_COMPUTE_WORK_GROUP_COUNT',
			makeIntVec'GL_MAX_COMPUTE_WORK_GROUP_SIZE',
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
	--]==]
	):setmetatable(nil),
}
local glGlobal = GLGlobal()
return glGlobal