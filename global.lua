local ffi = require 'ffi'
local table = require 'ext.table'
local string = require 'ext.string'
local range = require 'ext.range'
local op = require 'ext.op'
local assert = require 'ext.assert'
local gl = require 'gl'
local GLGet = require 'gl.get'


local GLboolean = ffi.typeof'GLboolean'
local GLint = ffi.typeof'GLint'
local GLint_1 = ffi.typeof'GLint[1]'
local GLint_2 = ffi.typeof'GLint[2]'
local GLint_arr = ffi.typeof'GLint[?]'
local GLint64 = ffi.typeof'GLint64'
local GLfloat = ffi.typeof'GLfloat'

-- TODO for GLES I don't think there's a GLdouble
-- so for those we'd want ths to fall back on makeFloatN
local GLdouble = op.land(pcall(ffi.typeof, 'GLdouble')) or nil


local GLGlobal = GLGet.behavior()

local function makeString(name)
	return {
		name = name,
		getter = function(self, nameValue) return GLGet.string(nameValue) end,
	}
end

local function makeBoolean(name)
	return {
		name = name,
		getter = function(self, nameValue) return GLGet.boolean(nameValue) end,
	}
end

local function makeInt(name)
	return {
		name = name,
		getter = function(self, nameValue) return GLGet.int(nameValue) end,
	}
end

local function makeInt64(name)
	return {
		name = name,
		getter = function(self, nameValue) return GLGet.int64(nameValue) end,
	}
end

local function makeFloat(name)
	return {
		name = name,
		getter = function(self, nameValue) return GLGet.float(nameValue) end,
	}
end

local function makeDouble(name)
	return {
		name = name,
		getter = function(self, nameValue) return GLGet.double(nameValue) end,
	}
end

local function makeBooleanN(name, count)
	local glRetBooleanN = GLGet.makeRetLastArg{
		name = 'glGetBooleanv',
		lookup = {1},
		ctype = GLboolean,
		count = count,
	}
	return {
		name = name,
		getter = function(self, nameValue)
			return glRetBooleanN(nameValue)
		end,
	}
end

local function makeIntN(name, count)
	local glRetIntN = GLGet.makeRetLastArg{
		name = 'glGetIntegerv',
		lookup = {1},
		ctype = GLint,
		count = count,
	}
	return {
		name = name,
		getter = function(self, nameValue)
			return glRetIntN(nameValue)
		end,
	}
end

local function makeFloatN(name, count)
	local glRetFloatN = GLGet.makeRetLastArg{
		name = 'glGetFloatv',
		lookup = {1},
		ctype = GLfloat,
		count = count,
	}
	return {
		name = name,
		getter = function(self, nameValue)
			return glRetFloatN(nameValue)
		end,
	}
end

local function makeDoubleN(name, count)
	local glRetDoubleN = GLGet.makeRetLastArg{
		name = 'glGetDoublev',
		lookup = {1},
		ctype = GLdouble,
		count = count,
	}
	return {
		name = name,
		getter = function(self, nameValue)
			return glRetDoubleN(nameValue)
		end,
	}
end

-- TODO for GLES I don't think there's a GLdouble
-- so for those we'd want ths to fall back on makeFloatN
if not GLGet.double then
	makeDouble = makeFloat
	makeDoubleN = makeFloatN
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
			assert.type(num, 'number')

			-- if it's a getter that gets the whole array ...
			local result = GLint_arr(num)
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
	local name = assert.index(args, 'name')
	local ctype = assert.index(args, 'type')
	local getterName = assert.index(args, 'getterName')
	local indexedGetterName = assert.index(args, 'indexedGetterName')
	local count = args.count or 1

	ctype = ffi.typeof(ctype)
	local ctype_1 = ffi.typeof('$[1]', ctype)
	local ctype_arr = ffi.typeof('$[?]', ctype)

	local getter = op.safeindex(gl, getterName)
	local indexedGetter = op.safeindex(gl, indexedGetterName)
	return {
		name = name,
		getter = function(self, nameValue, ...)
			if not args.useVec then
				if not getter then
					return nil, getterName..' not found'
				end
				local result = ctype_arr(count)
				local success, msg = glSafeCall(getterName, nameValue, result)
				-- TODO gl.get template:get getter() has no way to report errors ...
				if not success then return nil, msg end
				return range(0,count-1):mapi(function(i) return result[i] end):unpack(1, count)
			else
				if not indexedGetter then
					return nil, indexedGetterName..' not found'
				end
				local result = ctype_1()
				local results = table()
				for index=0,count-1 do
					local success, msg = glSafeCall(indexedGetterName, nameValue, index, result)
					if not success then return nil, msg end
					results[index+1] = result[0]
				end
				return results:unpack()
			end
		end,
	}
end

local function makeIntVec(args)
	if type(args) == 'string' then
		args= {name=args}
	end
	args.type = GLint
	args.getterName = 'glGetIntegerv'
	args.indexedGetterName = 'glGetIntegeri_v'
	return makeVec(args)
end
local function makeInt64Vec(name, count)
	return makeVec{
		name = name,
		type = GLint64,
		getterName = 'glGetInteger64v',
		indexedGetterName = 'glGetInteger64i_v',
		count = count,
	}
end

--[[ version-detect, I guess I wasn't using it, and it existing in global-scope screwed up Windows who can't reference gl until after GLApp:initGL is finished
local version
local tmp = xpcall(function()
	local major = assert(GLGet.int'GL_MAJOR_VERSION')
	local minor = assert(GLGet.int'GL_MINOR_VERSION')
	version = major + .1 * minor
end, function(err)
	print('first attempt to get gl version failed: '..tostring(err))
end) or xpcall(function()
	local versionStr = GLGet.string'GL_VERSION' or ''
	version = tonumber(string.split(versionStr, '%s+')[1])
	if not version then
		-- What about GLES versions?
		-- This is from Emscripten's GLES<->WebGL, so who knows what they put in the results.
		-- TODO test this pathway against desktop GLES's
		local glesVersion = tonumber((versionStr:match'^OpenGL ES ([0-9%.]*)'))
		-- now do the same GL<->GLES that's also in GLProgram.getVersionPragma
		-- TODO oops, that table is GLSL-ES to GLSL
		-- Oh well, GL and GLES are dif things right?  Maybe their versions shouldn't correlate?
		if glesVersion >= 3.1 then
			version = 4.5
		elseif glesVersion >= 3 then
			version = 4.3
		elseif glesVersion >= 1 then
			version = 4.1
		end
	end
	if not version then
		errror('failed to parse '..versionStr)
	end
end, function(err)
	print('second attempt to get gl version failed: '..tostring(err))
end) or xpcall(function()
	-- look for GL_VERSION's defined ...
	--major * 100 + minor
	for _,v in ipairs{101, 102, 103, 104, 105, 200, 201, 300, 301, 302, 303, 400, 401, 402, 403, 404, 405, 406} do
		local b = math.floor(v % 100)
		local a = math.floor((v - b) / 100)
		local k = 'GL_VERSION_'..a..'_'..b
print('testing', k, op.safeindex(gl, k))
		if op.safeindex(gl, k)
			then return a + .1 * b
		end
	end
	error("exhausted all versions")
end, function(err)
    print('third attempt to get gl version failed: '..tostring(err))
end) or (function()
    print("couldn't get the GL version ... assuming 1.1")
    version = 1.1
end)()
--]]

GLGlobal:makeGetter{
	getter = function(self, nameValue, result)
		error'global has no defaults'
	end,
	vars = table{
		-- version >= 1.0

		makeString'GL_VENDOR',
		makeString'GL_RENDERER',
		makeString'GL_VERSION',
		makeString'GL_EXTENSIONS',
		makeInt'GL_ACCUM_CLEAR_VALUE',
		makeInt'GL_ACCUM_ALPHA_BITS',
		makeInt'GL_ACCUM_BLUE_BITS',
		makeInt'GL_ACCUM_GREEN_BITS',
		makeInt'GL_ACCUM_RED_BITS',

		makeInt'GL_RED_BITS',				-- gles 300 but not gl 4
		makeInt'GL_GREEN_BITS',				-- gles 300 but not gl 4
		makeInt'GL_BLUE_BITS',				-- gles 300 but not gl 4 ?
		makeInt'GL_ALPHA_BITS',				-- gles 300 but not gl 4 ?
		makeInt'GL_DEPTH_BITS',				-- gles 300 but not gl 4 ?
		makeInt'GL_STENCIL_BITS',			-- gles 300 but not gl 4
		makeInt'GL_INDEX_BITS',

		makeDouble'GL_RED_BIAS',
		makeDouble'GL_GREEN_BIAS',
		makeDouble'GL_BLUE_BIAS',
		makeDouble'GL_ALPHA_BIAS',
		makeDouble'GL_DEPTH_BIAS',

		makeDouble'GL_RED_SCALE',
		makeDouble'GL_GREEN_SCALE',
		makeDouble'GL_BLUE_SCALE',
		makeDouble'GL_ALPHA_SCALE',
		makeDouble'GL_DEPTH_SCALE',

		makeInt'GL_ACTIVE_TEXTURE',
		makeDoubleN('GL_ALIASED_LINE_WIDTH_RANGE', 2),
		makeBoolean'GL_ALPHA_TEST',
		makeInt'GL_ALPHA_TEST_FUNC',
		makeDouble'GL_ALPHA_TEST_REF',
		makeInt'GL_ATTRIB_STACK_DEPTH',
		makeBoolean'GL_AUTO_NORMAL',
		makeInt'GL_AUX_BUFFERS',
		makeBoolean'GL_BLEND',
		makeDoubleN('GL_BLEND_COLOR', 4),
		makeInt'GL_CLIENT_ACTIVE_TEXTURE',
		makeInt'GL_CLIENT_ATTRIB_STACK_DEPTH',
		makeBoolean'GL_CLIP_PLANE0',
		makeBoolean'GL_CLIP_PLANE1',
		makeBoolean'GL_CLIP_PLANE2',
		makeBoolean'GL_CLIP_PLANE3',
		makeBoolean'GL_CLIP_PLANE4',
		makeBoolean'GL_CLIP_PLANE5',
		makeDoubleN('GL_COLOR_CLEAR_VALUE', 4),
		makeBoolean'GL_COLOR_MATERIAL',
		makeInt'GL_COLOR_MATERIAL_FACE',
		makeInt'GL_COLOR_MATERIAL_PARAMETER',
		makeDoubleN('GL_COLOR_MATRIX', 16),
		makeInt'GL_COLOR_MATRIX_STACK_DEPTH',
		makeBoolean'GL_COLOR_SUM',
		makeBoolean'GL_COLOR_TABLE',
		makeBooleanN('GL_COLOR_WRITEMASK', 4),
		makeBoolean'GL_CONVOLUTION_1D',
		makeBoolean'GL_CONVOLUTION_2D',
		makeBoolean'GL_CULL_FACE',
		makeInt'GL_CULL_FACE_MODE',
		makeDoubleN('GL_CURRENT_COLOR', 4),
		makeInt'GL_CURRENT_INDEX',
		makeDoubleN('GL_CURRENT_NORMAL', 3),
		makeInt'GL_CURRENT_PROGRAM',
		makeDoubleN('GL_CURRENT_RASTER_COLOR', 4),
		makeDouble'GL_CURRENT_RASTER_DISTANCE',
		makeInt'GL_CURRENT_RASTER_INDEX',
		makeIntN('GL_CURRENT_RASTER_POSITION', 4),
		makeBoolean'GL_CURRENT_RASTER_POSITION_VALID',
		makeDoubleN('GL_CURRENT_RASTER_TEXTURE_COORDS', 4),
		makeDoubleN('GL_CURRENT_TEXTURE_COORDS', 4),
		makeDouble'GL_DEPTH_CLEAR_VALUE',
		makeInt'GL_DEPTH_FUNC',
		makeDoubleN('GL_DEPTH_RANGE', 2),
		makeBoolean'GL_DEPTH_TEST',
		makeBoolean'GL_DEPTH_WRITEMASK',
		makeDouble'GL_DITHER',
		makeBoolean'GL_DOUBLEBUFFER',			-- gl 4 but not gles 300
		makeBoolean'GL_EDGE_FLAG',
		makeBoolean'GL_FOG',
		makeBoolean'GL_FOG_COORD_ARRAY',
		makeDoubleN('GL_FOG_COLOR', 4),
		makeDouble'GL_FOG_DENSITY',
		makeDouble'GL_FOG_END',
		makeInt'GL_FOG_HINT',
		makeInt'GL_FOG_INDEX',
		makeInt'GL_FOG_MODE',
		makeDouble'GL_FOG_START',
		makeInt'GL_FRONT_FACE',						-- gles 300 but not gl 4
		makeInt'GL_GENERATE_MIPMAP_HINT',			-- gles 300 but not gl 4
		makeBoolean'GL_HISTOGRAM',
		makeInt'GL_INDEX_CLEAR_VALUE',
		makeBoolean'GL_INDEX_MODE',
		makeInt'GL_INDEX_OFFSET',
		makeInt'GL_INDEX_SHIFT',
		makeInt'GL_INDEX_WRITEMASK',
		makeBoolean'GL_LIGHT0',
		makeBoolean'GL_LIGHT1',
		makeBoolean'GL_LIGHT2',
		makeBoolean'GL_LIGHT3',
		makeBoolean'GL_LIGHT4',
		makeBoolean'GL_LIGHT5',
		makeBoolean'GL_LIGHT6',
		makeBoolean'GL_LIGHT7',
		makeBoolean'GL_LIGHTING',
		makeBoolean'GL_LIGHT_MODEL_LOCAL_VIEWER',
		makeBoolean'GL_LIGHT_MODEL_TWO_SIDE',
		makeBoolean'GL_LINE_SMOOTH',		-- gl 4 but not gles 300
		makeInt'GL_LINE_SMOOTH_HINT',		-- gl 4 but not gles 300
		makeBoolean'GL_LINE_STIPPLE',
		makeInt'GL_LINE_STIPPLE_PATTERN',
		makeDouble'GL_LINE_STIPPLE_REPEAT',
		makeDouble'GL_LINE_WIDTH',
		makeDouble'GL_LINE_WIDTH_GRANULARITY',	-- deprecated in 1.2
		makeDoubleN('GL_LINE_WIDTH_RANGE', 2),	-- deprecated in 1.2
		makeInt'GL_LIST_BASE',
		makeInt'GL_LIST_INDEX',
		makeInt'GL_LIST_MODE',
		makeInt'GL_LOGIC_OP_MODE',					-- gl 4 but not gles 300
		makeBoolean'GL_MAP1_COLOR_4',
		makeDoubleN('GL_MAP1_GRID_DOMAIN', 2),
		makeInt'GL_MAP1_GRID_SEGMENTS',
		makeBoolean'GL_MAP1_INDEX',
		makeBoolean'GL_MAP1_NORMAL',
		makeBoolean'GL_MAP1_TEXTURE_COORD_1',
		makeBoolean'GL_MAP1_TEXTURE_COORD_2',
		makeBoolean'GL_MAP1_TEXTURE_COORD_3',
		makeBoolean'GL_MAP1_TEXTURE_COORD_4',
		makeBoolean'GL_MAP1_VERTEX_3',
		makeBoolean'GL_MAP1_VERTEX_4',
		makeBoolean'GL_MAP2_COLOR_4',
		makeDoubleN('GL_MAP2_GRID_DOMAIN', 4),
		makeDoubleN('GL_MAP2_GRID_SEGMENTS', 2),
		makeBoolean'GL_MAP2_INDEX',
		makeBoolean'GL_MAP2_NORMAL',
		makeBoolean'GL_MAP2_TEXTURE_COORD_1',
		makeBoolean'GL_MAP2_TEXTURE_COORD_2',
		makeBoolean'GL_MAP2_TEXTURE_COORD_3',
		makeBoolean'GL_MAP2_TEXTURE_COORD_4',
		makeBoolean'GL_MAP2_VERTEX_3',
		makeBoolean'GL_MAP2_VERTEX_4',
		makeBoolean'GL_MAP_COLOR',
		makeBoolean'GL_MAP_STENCIL',
		makeInt'GL_MATRIX_MODE',
		makeInt'GL_MAX_CLIENT_ATTRIB_STACK_DEPTH',
		makeInt'GL_MAX_ATTRIB_STACK_DEPTH',
		makeInt'GL_MAX_CLIP_PLANES',
		makeInt'GL_MAX_COLOR_MATRIX_STACK_DEPTH',
		makeInt'GL_MAX_CUBE_MAP_TEXTURE_SIZE',
		makeInt'GL_MAX_EVAL_ORDER',
		makeInt'GL_MAX_LIGHTS',
		makeInt'GL_MAX_LIST_NESTING',
		makeInt'GL_MAX_MODELVIEW_STACK_DEPTH',
		makeInt'GL_MAX_NAME_STACK_DEPTH',
		makeInt'GL_MAX_PIXEL_MAP_TABLE',
		makeInt'GL_MAX_PROJECTION_STACK_DEPTH',
		makeInt'GL_MAX_TEXTURE_SIZE',
		makeInt'GL_MAX_TEXTURE_STACK_DEPTH',
		makeInt'GL_MAX_TEXTURE_UNITS',
		makeIntN('GL_MAX_VIEWPORT_DIMS', 2),
		makeBoolean'GL_MINMAX',
		makeDoubleN('GL_MODELVIEW_MATRIX', 16),
		makeInt'GL_MODELVIEW_STACK_DEPTH',
		makeInt'GL_NAME_STACK_DEPTH',
		makeBoolean'GL_NORMALIZE',
		makeInt'GL_PACK_ALIGNMENT',
		makeBoolean'GL_PACK_LSB_FIRST',	-- gl 4 but not gles 300
		makeInt'GL_PACK_ROW_LENGTH',
		makeInt'GL_PACK_SKIP_PIXELS',
		makeInt'GL_PACK_SKIP_ROWS',
		makeBoolean'GL_PACK_SWAP_BYTES',-- gl 4 but not gles 300
		makeInt'GL_PERSPECTIVE_CORRECTION_HINT',
		makeInt'GL_PIXEL_MAP_A_TO_A_SIZE',
		makeInt'GL_PIXEL_MAP_B_TO_B_SIZE',
		makeInt'GL_PIXEL_MAP_G_TO_G_SIZE',
		makeInt'GL_PIXEL_MAP_I_TO_A_SIZE',
		makeInt'GL_PIXEL_MAP_I_TO_B_SIZE',
		makeInt'GL_PIXEL_MAP_I_TO_G_SIZE',
		makeInt'GL_PIXEL_MAP_I_TO_I_SIZE',
		makeInt'GL_PIXEL_MAP_I_TO_R_SIZE',
		makeInt'GL_PIXEL_MAP_R_TO_R_SIZE',
		makeInt'GL_PIXEL_MAP_S_TO_S_SIZE',
		makeDouble'GL_POINT_SIZE',				-- gl 4 but not gles 300
		makeDouble'GL_POINT_SIZE_GRANULARITY',	-- deprecated in 1.2. gl 4 but not gles 300
		makeDoubleN('GL_POINT_SIZE_RANGE', 2),	-- deprecated in 1.2. gl 4 but not gles 300
		makeBoolean'GL_POINT_SMOOTH',
		makeInt'GL_POINT_SMOOTH_HINT',
		makeInt'GL_POLYGON_MODE',
		makeBoolean'GL_POLYGON_SMOOTH',		-- gl 4 but not gles 300
		makeInt'GL_POLYGON_SMOOTH_HINT',		-- gl 4 but not gles 300
		makeBoolean'GL_POLYGON_STIPPLE',
		makeBoolean'GL_POST_COLOR_MATRIX_COLOR_TABLE',
		makeDouble'GL_POST_COLOR_MATRIX_RED_BIAS',
		makeDouble'GL_POST_COLOR_MATRIX_GREEN_BIAS',
		makeDouble'GL_POST_COLOR_MATRIX_BLUE_BIAS',
		makeDouble'GL_POST_COLOR_MATRIX_ALPHA_BIAS',
		makeDouble'GL_POST_COLOR_MATRIX_RED_SCALE',
		makeDouble'GL_POST_COLOR_MATRIX_GREEN_SCALE',
		makeDouble'GL_POST_COLOR_MATRIX_BLUE_SCALE',
		makeDouble'GL_POST_COLOR_MATRIX_ALPHA_SCALE',
		makeBoolean'GL_POST_CONVOLUTION_COLOR_TABLE',
		makeDouble'GL_POST_CONVOLUTION_RED_BIAS',
		makeDouble'GL_POST_CONVOLUTION_GREEN_BIAS',
		makeDouble'GL_POST_CONVOLUTION_BLUE_BIAS',
		makeDouble'GL_POST_CONVOLUTION_ALPHA_BIAS',
		makeDouble'GL_POST_CONVOLUTION_RED_SCALE',
		makeDouble'GL_POST_CONVOLUTION_GREEN_SCALE',
		makeDouble'GL_POST_CONVOLUTION_BLUE_SCALE',
		makeDouble'GL_POST_CONVOLUTION_ALPHA_SCALE',
		makeDoubleN('GL_PROJECTION_MATRIX', 16),
		makeInt'GL_PROJECTION_STACK_DEPTH',
		makeInt'GL_READ_BUFFER',
		makeInt'GL_RENDER_MODE',
		makeBoolean'GL_RGBA_MODE',
		makeInt'GL_SAMPLE_BUFFERS',
		makeDouble'GL_SAMPLE_COVERAGE_VALUE',
		makeBoolean'GL_SAMPLE_COVERAGE_INVERT',
		makeInt'GL_SAMPLES',
		makeIntN('GL_SCISSOR_BOX', 4),
		makeBoolean'GL_SCISSOR_TEST',
		makeBoolean'GL_SECONDARY_COLOR_ARRAY',
		makeBoolean'GL_SEPARABLE_2D',
		makeInt'GL_SHADE_MODEL',
		makeInt'GL_STENCIL_CLEAR_VALUE',
		makeInt'GL_STENCIL_FAIL',
		makeInt'GL_STENCIL_FUNC',
		makeInt'GL_STENCIL_PASS_DEPTH_FAIL',
		makeInt'GL_STENCIL_PASS_DEPTH_PASS',
		makeInt'GL_STENCIL_REF',
		makeBoolean'GL_STENCIL_TEST',
		makeInt'GL_STENCIL_VALUE_MASK',
		makeInt'GL_STENCIL_WRITEMASK',
		makeBoolean'GL_STEREO',
		makeInt'GL_SUBPIXEL_BITS',
		makeBoolean'GL_TEXTURE_1D',
		makeInt'GL_TEXTURE_BINDING_1D',	-- gl 4 but not gles 300
		makeBoolean'GL_TEXTURE_2D',
		makeInt'GL_TEXTURE_BINDING_2D',
		makeBoolean'GL_TEXTURE_CUBE_MAP',
		makeBoolean'GL_TEXTURE_GEN_Q',
		makeBoolean'GL_TEXTURE_GEN_R',
		makeBoolean'GL_TEXTURE_GEN_S',
		makeBoolean'GL_TEXTURE_GEN_T',
		makeDoubleN('GL_TEXTURE_MATRIX', 16),
		makeInt'GL_TEXTURE_STACK_DEPTH',
		makeDoubleN('GL_TRANSPOSE_COLOR_MATRIX', 16),
		makeDoubleN('GL_TRANSPOSE_MODELVIEW_MATRIX', 16),
		makeDoubleN('GL_TRANSPOSE_PROJECTION_MATRIX', 16),
		makeDoubleN('GL_TRANSPOSE_TEXTURE_MATRIX', 16),
		makeInt'GL_UNPACK_ALIGNMENT',
		makeBoolean'GL_UNPACK_LSB_FIRST',		-- gl 4 but not gles 300
		makeInt'GL_UNPACK_ROW_LENGTH',
		makeInt'GL_UNPACK_SKIP_PIXELS',
		makeInt'GL_UNPACK_SKIP_ROWS',
		makeBoolean'GL_UNPACK_SWAP_BYTES',		-- gl 4 but not gles 300
		makeIntVec{name='GL_VIEWPORT', count=4},	-- vec sized GL_MAX_VIEWPORTS
		makeInt'GL_ZOOM_X',
		makeInt'GL_ZOOM_Y',

		-- version >= 1.1

		makeBoolean'GL_COLOR_LOGIC_OP',		-- gl 4 but not gles 300
		makeBoolean'GL_COLOR_ARRAY',
		makeInt'GL_COLOR_ARRAY_SIZE',
		makeInt'GL_COLOR_ARRAY_STRIDE',
		makeInt'GL_COLOR_ARRAY_TYPE',
		makeBoolean'GL_EDGE_FLAG_ARRAY',
		makeInt'GL_EDGE_FLAG_ARRAY_STRIDE',
		makeBoolean'GL_INDEX_ARRAY',
		makeInt'GL_INDEX_ARRAY_STRIDE',
		makeInt'GL_INDEX_ARRAY_TYPE',
		makeBoolean'GL_INDEX_LOGIC_OP',
		makeBoolean'GL_NORMAL_ARRAY',
		makeInt'GL_NORMAL_ARRAY_STRIDE',
		makeInt'GL_NORMAL_ARRAY_TYPE',
		makeDouble'GL_POLYGON_OFFSET_UNITS',
		makeDouble'GL_POLYGON_OFFSET_FACTOR',
		makeBoolean'GL_POLYGON_OFFSET_FILL',
		makeBoolean'GL_POLYGON_OFFSET_LINE',	-- gl 4 but not gles 300
		makeBoolean'GL_POLYGON_OFFSET_POINT',	-- gl 4 but not gles 300
		makeBoolean'GL_TEXTURE_COORD_ARRAY',
		makeInt'GL_TEXTURE_COORD_ARRAY_SIZE',
		makeInt'GL_TEXTURE_COORD_ARRAY_STRIDE',
		makeInt'GL_TEXTURE_COORD_ARRAY_TYPE',
		makeBoolean'GL_VERTEX_ARRAY',
		makeInt'GL_VERTEX_ARRAY_SIZE',
		makeInt'GL_VERTEX_ARRAY_STRIDE',
		makeInt'GL_VERTEX_ARRAY_TYPE',

		-- version >= 1.2

		makeDoubleN('GL_ALIASED_POINT_SIZE_RANGE', 2),
		makeInt'GL_FEEDBACK_BUFFER_SIZE',
		makeInt'GL_FEEDBACK_BUFFER_TYPE',
		makeDoubleN('GL_LIGHT_MODEL_AMBIENT', 4),
		makeInt'GL_LIGHT_MODEL_COLOR_CONTROL',
		makeInt'GL_MAX_3D_TEXTURE_SIZE',
		makeInt'GL_MAX_ELEMENTS_INDICES',
		makeInt'GL_MAX_ELEMENTS_VERTICES',
		makeInt'GL_PACK_IMAGE_HEIGHT',			-- gl 4 but not gles 300
		makeInt'GL_PACK_SKIP_IMAGES',			-- gl 4 but not gles 300
		makeBoolean'GL_RESCALE_NORMAL',
		makeInt'GL_SELECTION_BUFFER_SIZE',
		makeDouble'GL_SMOOTH_LINE_WIDTH_GRANULARITY',		-- gl 4 but not gles 300
		makeDoubleN('GL_SMOOTH_LINE_WIDTH_RANGE', 2),		-- gl 4 but not gles 300
		makeDouble'GL_SMOOTH_POINT_SIZE_GRANULARITY',
		makeDoubleN('GL_SMOOTH_POINT_SIZE_RANGE', 2),
		makeBoolean'GL_TEXTURE_3D',
		makeInt'GL_TEXTURE_BINDING_3D',
		makeInt'GL_UNPACK_IMAGE_HEIGHT',
		makeInt'GL_UNPACK_SKIP_IMAGES',

		-- version >= 1.3

		makeInt'GL_NUM_COMPRESSED_TEXTURE_FORMATS',
		makeInts('GL_COMPRESSED_TEXTURE_FORMATS', 'GL_NUM_COMPRESSED_TEXTURE_FORMATS'),
		makeInt'GL_TEXTURE_BINDING_CUBE_MAP',
		makeInt'GL_TEXTURE_COMPRESSION_HINT',

		-- version >= 1.4

		makeInt'GL_BLEND_DST_ALPHA',
		makeInt'GL_BLEND_DST_RGB',
		makeInt'GL_BLEND_SRC_ALPHA',
		makeInt'GL_BLEND_SRC_RGB',
		makeDouble'GL_CURRENT_FOG_COORD',
		makeDoubleN('GL_CURRENT_SECONDARY_COLOR', 4),
		makeInt'GL_FOG_COORD_ARRAY_STRIDE',
		makeInt'GL_FOG_COORD_ARRAY_TYPE',
		makeInt'GL_FOG_COORD_SRC',
		makeDouble'GL_MAX_TEXTURE_LOD_BIAS',
		makeDouble'GL_POINT_SIZE_MIN',
		makeDouble'GL_POINT_SIZE_MAX',
		makeDouble'GL_POINT_FADE_THRESHOLD_SIZE',			-- gl 4 but not gles 300
		makeDoubleN('GL_POINT_DISTANCE_ATTENUATION', 3),
		makeInt'GL_SECONDARY_COLOR_ARRAY_SIZE',
		makeInt'GL_SECONDARY_COLOR_ARRAY_STRIDE',
		makeInt'GL_SECONDARY_COLOR_ARRAY_TYPE',

		-- version >= 1.5

		makeInt'GL_ARRAY_BUFFER_BINDING',
		makeInt'GL_COLOR_ARRAY_BUFFER_BINDING',
		makeBoolean'GL_EDGE_FLAG_ARRAY_BUFFER_BINDING',
		makeInt'GL_ELEMENT_ARRAY_BUFFER_BINDING',
		makeInt'GL_FOG_COORD_ARRAY_BUFFER_BINDING',
		makeInt'GL_INDEX_ARRAY_BUFFER_BINDING',
		makeInt'GL_NORMAL_ARRAY_BUFFER_BINDING',
		makeInt'GL_SECONDARY_COLOR_ARRAY_BUFFER_BINDING',
		makeInt'GL_TEXTURE_COORD_ARRAY_BUFFER_BINDING',
		makeInt'GL_VERTEX_ARRAY_BUFFER_BINDING',

		-- version >= 2.0

		makeInt'GL_BLEND_EQUATION_ALPHA',			-- gles 300 but not gl 4 ?
		makeInt'GL_BLEND_EQUATION_RGB',
		makeInt'GL_MAX_DRAW_BUFFERS',
		-- "GL_DRAW_BUFFERi ... is only available for version >= 2.0" ... does that mean GL_DRAW_BUFFER without an index is still working for earlier versions?
		-- TODO Is this accepted both for glGetIntegerv and glGetIntegeri_v?
		-- Does it return different results for each?
		-- TODO There's an argument for adding extra params to :get() here - to get specific indexes instead of getting everything
		makeIntVec'GL_DRAW_BUFFER', -- sized GL_MAX_DRAW_BUFFERS
		makeInt'GL_DRAW_BUFFER0',
		makeInt'GL_DRAW_BUFFER1',
		makeInt'GL_DRAW_BUFFER2',
		makeInt'GL_DRAW_BUFFER3',
		makeInt'GL_DRAW_BUFFER4',
		makeInt'GL_DRAW_BUFFER5',
		makeInt'GL_DRAW_BUFFER6',
		makeInt'GL_DRAW_BUFFER7',
		makeInt'GL_DRAW_BUFFER8',
		makeInt'GL_DRAW_BUFFER9',
		makeInt'GL_DRAW_BUFFER10',
		makeInt'GL_DRAW_BUFFER11',
		makeInt'GL_DRAW_BUFFER12',
		makeInt'GL_DRAW_BUFFER13',
		makeInt'GL_DRAW_BUFFER14',
		makeInt'GL_DRAW_BUFFER15',
		makeInt'GL_FRAGMENT_SHADER_DERIVATIVE_HINT',
		makeInt'GL_MAX_COMBINED_TEXTURE_IMAGE_UNITS',
		makeInt'GL_MAX_FRAGMENT_UNIFORM_COMPONENTS',
		makeInt'GL_MAX_TEXTURE_COORDS',
		makeInt'GL_MAX_TEXTURE_IMAGE_UNITS',
		makeInt'GL_MAX_VARYING_FLOATS',
		makeInt'GL_MAX_VERTEX_ATTRIBS',
		makeInt'GL_MAX_VERTEX_TEXTURE_IMAGE_UNITS',
		makeInt'GL_MAX_VERTEX_UNIFORM_COMPONENTS',
		makeBoolean'GL_POINT_SPRITE',
		makeInt'GL_STENCIL_BACK_FAIL',
		makeInt'GL_STENCIL_BACK_FUNC',
		makeInt'GL_STENCIL_BACK_PASS_DEPTH_FAIL',
		makeInt'GL_STENCIL_BACK_PASS_DEPTH_PASS',
		makeInt'GL_STENCIL_BACK_REF',
		makeInt'GL_STENCIL_BACK_VALUE_MASK',
		makeInt'GL_STENCIL_BACK_WRITEMASK',
		makeBoolean'GL_VERTEX_PROGRAM_POINT_SIZE',
		makeBoolean'GL_VERTEX_PROGRAM_TWO_SIDE',

		-- version >= 2.1

		makeDoubleN('GL_CURRENT_RASTER_SECONDARY_COLOR', 4),
		makeInt'GL_PIXEL_PACK_BUFFER_BINDING',
		makeInt'GL_PIXEL_UNPACK_BUFFER_BINDING',

		-- idk when ...

		makeString'GL_SHADING_LANGUAGE_VERSION',
		makeInt'GL_MAJOR_VERSION',
		makeInt'GL_MINOR_VERSION',

	-- and at this point I'm giving up on flagging all getters that cause segfaults  ... 3 out of the first 16 is too much
		makeInt'GL_CONTEXT_FLAGS',					-- gl 4 but not gles 300

		makeInt'GL_DRAW_FRAMEBUFFER_BINDING',
		makeInt'GL_READ_FRAMEBUFFER_BINDING',
		makeInt'GL_PROGRAM_PIPELINE_BINDING',			-- gl 4 but not gles 300
		makeInt'GL_RENDERBUFFER_BINDING',
		makeInt'GL_SAMPLER_BINDING',

		makeInt'GL_IMPLEMENTATION_COLOR_READ_FORMAT',
		makeInt'GL_IMPLEMENTATION_COLOR_READ_TYPE',

		makeInt'GL_MAX_COMBINED_SHADER_STORAGE_BLOCKS',	-- gl 4 but not gles 300.  segfault upon exit
		makeInt'GL_MAX_DUAL_SOURCE_DRAW_BUFFERS',	-- gl 4 but not gles 300
		makeInt'GL_MAX_ARRAY_TEXTURE_LAYERS',
		makeInt'GL_MAX_COLOR_ATTACHMENTS',			-- gles 300 but not gl 4
		makeInt'GL_MAX_CLIP_DISTANCES',				-- gl 4 but not gles 300
		makeInt'GL_MAX_COLOR_TEXTURE_SAMPLES',				-- gl 4 but not gles 300
		makeInt'GL_MAX_COMBINED_ATOMIC_COUNTERS',				-- gl 4 but not gles 300
		makeInt'GL_MAX_COMBINED_FRAGMENT_UNIFORM_COMPONENTS',
		makeInt'GL_MAX_COMBINED_GEOMETRY_UNIFORM_COMPONENTS',				-- gl 4 but not gles 300
		makeInt'GL_MAX_COMBINED_UNIFORM_BLOCKS',
		makeInt'GL_MAX_COMBINED_VERTEX_UNIFORM_COMPONENTS',
		makeInt'GL_MAX_DEPTH_TEXTURE_SAMPLES',				-- gl 4 but not gles 300
		makeInt'GL_MAX_FRAGMENT_INPUT_COMPONENTS',
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
		makeInt'GL_MAX_TRANSFORM_FEEDBACK_INTERLEAVED_COMPONENTS',	-- gles 300 but not gl 4
		makeInt'GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_ATTRIBS',	-- gles 300 but not gl 4
		makeInt'GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_COMPONENTS',	-- gles 300 but not gl 4
		makeInt'GL_MAX_UNIFORM_BUFFER_BINDINGS',
		makeInt'GL_MAX_UNIFORM_BLOCK_SIZE',
		makeInt'GL_MAX_VARYING_COMPONENTS',
		makeInt'GL_MAX_VARYING_VECTORS',
		makeInt'GL_MAX_VERTEX_UNIFORM_VECTORS',
		makeInt'GL_MAX_VERTEX_OUTPUT_COMPONENTS',
		makeInt'GL_MAX_VERTEX_UNIFORM_BLOCKS',
		makeInt'GL_NUM_EXTENSIONS',
		makeInt'GL_PRIMITIVE_RESTART_INDEX',			-- gl 4 but not gles 300
		makeInt'GL_NUM_PROGRAM_BINARY_FORMATS',
		makeInts('GL_PROGRAM_BINARY_FORMATS', 'GL_NUM_PROGRAM_BINARY_FORMATS'),
		makeInt'GL_PROGRAM_POINT_SIZE',			-- gl 4 but not gles 300
		makeInt'GL_PROVOKING_VERTEX',			-- gl 4 but not gles 300
		makeInt'GL_PRIMITIVE_RESTART_FIXED_INDEX',	-- gles 300 but not gl 4
		makeInt'GL_RASTERIZER_DISCARD',	-- gles 300 but not gl 4
		makeInt'GL_SAMPLE_ALPHA_TO_COVERAGE',	-- gles 300 but not gl 4
		makeInt'GL_SAMPLE_COVERAGE',		-- gles 300 but not gl 4
		makeInt'GL_SAMPLE_MASK_VALUE',	-- gl 4 but not gles 300
		makeInt'GL_SHADER_COMPILER',
		makeInt'GL_SHADER_STORAGE_BUFFER_OFFSET_ALIGNMENT',	-- gl 4 but not gles 300
		makeInt'GL_MAX_SHADER_STORAGE_BUFFER_BINDINGS',	-- gl 4 but not gles 300
		makeInt64Vec'GL_SHADER_STORAGE_BUFFER_BINDING',	-- can be indexed, but whats the index range?
		makeInt64Vec'GL_SHADER_STORAGE_BUFFER_START',	-- can be indexed, but whats the index range?
		makeInt64Vec'GL_SHADER_STORAGE_BUFFER_SIZE',	-- can be indexed, but whats the index range?
		makeInt'GL_TEXTURE_BINDING_1D_ARRAY',	-- gl 4 but not gles 300
		makeInt'GL_TEXTURE_BINDING_2D_ARRAY',
		makeInt'GL_TEXTURE_BINDING_2D_MULTISAMPLE',	-- gl 4 but not gles 300
		makeInt'GL_TEXTURE_BINDING_2D_MULTISAMPLE_ARRAY',	-- gl 4 but not gles 300
		makeInt'GL_TEXTURE_BINDING_BUFFER',	-- gl 4 but not gles 300
		makeInt'GL_TEXTURE_BINDING_RECTANGLE',
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
		makeInt'GL_VERTEX_ARRAY_BINDING',
	}:append(
		-- version < 4.1 and {} or
		{
			--print'GL version >= 4.1:'
			makeInt'GL_MAX_VIEWPORTS',
			makeInt'GL_VIEWPORT_SUBPIXEL_BITS',
			makeIntN('GL_VIEWPORT_BOUNDS_RANGE', 2),
			makeInt'GL_LAYER_PROVOKING_VERTEX',
			makeInt'GL_VIEWPORT_INDEX_PROVOKING_VERTEX',
			makeInt'GL_NUM_SHADER_BINARY_FORMATS',
			makeInts('GL_SHADER_BINARY_FORMATS', 'GL_NUM_SHADER_BINARY_FORMATS'),	-- gles 300 but not gl 4
		}
	):append(
		-- version < 4.2 and {} or
		{
			--print'GL version >= 4.2:'
			makeInt'GL_MAX_VERTEX_ATOMIC_COUNTERS',
			makeInt'GL_MAX_TESS_CONTROL_ATOMIC_COUNTERS',
			makeInt'GL_MAX_TESS_EVALUATION_ATOMIC_COUNTERS',
			makeInt'GL_MAX_GEOMETRY_ATOMIC_COUNTERS',
			makeInt'GL_MAX_FRAGMENT_ATOMIC_COUNTERS',
			makeInt'GL_MIN_MAP_BUFFER_ALIGNMENT',
		}
	):append(
		-- version < 4.3 and {} or
		{
			-- where do these go?  I don't see them in gl4 glGet's docs, but everyone says to use them with gl4 glGetIntegerv ...
			makeInt'GL_MAX_GEOMETRY_OUTPUT_VERTICES',
			makeInt'GL_MAX_GEOMETRY_TOTAL_OUTPUT_COMPONENTS',

			--print'GL version >= 4.3:'
			makeInt'GL_MAX_ELEMENT_INDEX',
			makeInt'GL_MAX_COMPUTE_UNIFORM_BLOCKS',
			makeInt'GL_MAX_COMPUTE_TEXTURE_IMAGE_UNITS',
			makeInt'GL_MAX_COMPUTE_UNIFORM_COMPONENTS',
			makeInt'GL_MAX_COMPUTE_ATOMIC_COUNTERS',
			makeInt'GL_MAX_COMPUTE_ATOMIC_COUNTER_BUFFERS',
			makeInt'GL_MAX_COMBINED_COMPUTE_UNIFORM_COMPONENTS',
			makeInt'GL_MAX_COMPUTE_WORK_GROUP_INVOCATIONS',
			makeIntVec{name='GL_MAX_COMPUTE_WORK_GROUP_COUNT', useVec=true, count=3},
			makeIntVec{name='GL_MAX_COMPUTE_WORK_GROUP_SIZE', useVec=true, count=3},
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
		table{
			'GL_VERTEX_SHADER',
			'GL_FRAGMENT_SHADER',
			'GL_GEOMETRY_SHADER',
			'GL_TESS_EVALUATION_SHADER',
			'GL_TESS_CONTROL_SHADER',
			'GL_COMPUTE_SHADER',
		}:mapi(function(shaderTypeParamName)
			return {
				name = shaderTypeParamName,
				getter = function(self, nameValue, precParamName)
					local precParamValue
					-- TODO this number-or-string for all gl.get's ?
					local typePrecParamName = type(precParamName)
					if typePrecParamName == 'number' then
						precParamValue = precParamName
					elseif typePrecParamName == 'string' then
						precParamValue = op.safeindex(gl, precParamName)
						if not precParamValue then
							return nil, tostring(precParamName)..' not defined'
						end
					else
						return nil, "precision "..tostring(precParamName).." must be a string or number, found type "..tostring(typePrecParamName)
					end

					-- or I could just double-wrap makeRetLastArg ...
					-- ... but nah I can't cuz inside it does a safecall ...
					-- ... I'd need a separate wrapper for determining-of-available and returning-fail otherwise ...
					local rangePtr = GLint_2()
					local precisionPtr = GLint_1()
					local success, msg = glSafeCall('glGetShaderPrecisionFormat', nameValue, precParamValue, rangePtr, precisionPtr)
					if not success then return nil, msg end
					return rangePtr[0], rangePtr[1], precisionPtr[0]
				end,
			}
		end)
	--]==]
	):setmetatable(nil),
}
local glGlobal = GLGlobal()
return glGlobal
