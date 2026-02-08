--[[
TODO consistency of bind() before all texture operations?
or how about a flag for whether to always bind before operations?
or just never bind() before operations?
or TODO use bind-less textures?
--]]
require 'ext.gc'	-- make sure luajit can __gc lua-tables
local ffi = require 'ffi'
local gl = require 'gl'
local GLGet = require 'gl.get'
local assert = require 'ext.assert'
local table = require 'ext.table'
local op = require 'ext.op'

local char_p = ffi.typeof'char*'
local uint8_t_arr = ffi.typeof'uint8_t[?]'
local GLint = ffi.typeof'GLint'
local GLuint_1 = ffi.typeof'GLuint[1]'
local GLfloat = ffi.typeof'GLfloat'

--[[
maybe this should be moved to GLTypes? idk what the scope of that file is, for textures, uniforms, both? neither?

GL "base" formats / GLES "unsized" formats
https://registry.khronos.org/OpenGL-Refpages/gl4/html/glTexImage2D.xhtml
https://registry.khronos.org/OpenGL-Refpages/es3.0/html/glTexImage2D.xhtml
https://registry.khronos.org/OpenGL-Refpages/es3/html/glCompressedTexImage2D.xhtml

internalFormat = internal format
format = compatible format.  only for GLES 3 table 1.
types = set of compatible types.  only for GLES 3 table 1 ... I guess GL works/coerces for all types?)
values = list from the "RGBA and Luminance Values".  only for GLES 3 table 1 ... expected external values? what about GL?
internalComponents = list from "Internal Components" of table 1
baseInternalFormat = base internalFormat for the internalFormat.  only for GL 4 table 2 and 3, or GLES 3 glCompressedTexImage2D.
genericVsSpecific = generic vs specific type of the compressed format.  only for GL 4 table 3.

In the Tex1D/2D/3D loaders, .format and .type are optional and will be picked from this table based on .internalFormat .  .type will pick the first from .types[].

the bits fields
	redBits, greenBits, blueBits, alphaBits, sharedBits, depthBits, stencilBits
... will always share the same prefix in the GL tables, and I'm moving that prefix into its own field
	s, f, ui, i
except stencilBits, which is always an integer.
The 'i' types must be used with ivec4 / isampler2D / etc
The 'ui' types must be used with uvec4 / usampler2D / etc

TODO some GL 4 pixel formats aren't listed:
	GL_BGR, GL_BGRA, GL_BGR_INTEGER, GL_BGRA_INTEGER, GL_STENCIL_INDEX, GL_DEPTH_STENCIL

TODO some GL 4 pixel types aren't listed:
	GL_UNSIGNED_BYTE_3_3_2, GL_UNSIGNED_BYTE_2_3_3_REV, GL_UNSIGNED_SHORT_5_6_5_REV, GL_UNSIGNED_SHORT_4_4_4_4_REV,
	GL_UNSIGNED_SHORT_1_5_5_5_REV, GL_UNSIGNED_INT_8_8_8_8, GL_UNSIGNED_INT_8_8_8_8_REV, GL_UNSIGNED_INT_10_10_10_2
	... what internalFormat goes with these?
--]]
local formatInfos = table{
	-- GLES3.0 table 1 and GL4 table 1:
	{internalFormat='GL_RGB', format='GL_RGB', types={'GL_UNSIGNED_BYTE', 'GL_UNSIGNED_SHORT_5_6_5'}, values={'Red', 'Green', 'Blue'}, internalComponents={'R', 'G', 'B'}},
	{internalFormat='GL_RGBA', format='GL_RGBA', types={'GL_UNSIGNED_BYTE', 'GL_UNSIGNED_SHORT_4_4_4_4', 'GL_UNSIGNED_SHORT_5_5_5_1'}, values={'Red', 'Green', 'Blue', 'Alpha'}, internalComponents={'R', 'G', 'B', 'A'}},
	-- GL4 table 1:
	{internalFormat='GL_DEPTH_COMPONENT', format='GL_DEPTH_COMPONENT', types={'GL_FLOAT'}, values={'Depth'}, internalComponents={'D'}},
	{internalFormat='GL_DEPTH_STENCIL', values={'Depth', 'Stencil'}, internalComponents={'D', 'S'}},
	{internalFormat='GL_RED', values={'Red'}, internalComponents={'R'}},
	{internalFormat='GL_RG', values={'Red', 'Green'}, internalComponents={'R', 'G'}},
	-- GLES3.0 table 1:
	{internalFormat='GL_LUMINANCE_ALPHA', format='GL_LUMINANCE_ALPHA', types={'GL_UNSIGNED_BYTE'}, values={'Luminance', 'Alpha'}, internalCompoents={'L', 'A'}},
	{internalFormat='GL_LUMINANCE', format='GL_LUMINANCE', types={'GL_UNSIGNED_BYTE'}, values={'Luminance'}, internalComponents={'L'}},
	{internalFormat='GL_ALPHA', format='GL_ALPHA', types={'GL_UNSIGNED_BYTE'}, values={'Alpha'}, internalComponents={'A'}},
	-- GL4 table 2:
	{internalFormat='GL_R16', baseInternalFormat='GL_RED', redBits=16},
	{internalFormat='GL_R16_SNORM', baseInternalFormat='GL_RED', redBits=16, internalType='s'},
	{internalFormat='GL_RG16', baseInternalFormat='GL_RG', redBits=16, greenBits=16},
	{internalFormat='GL_RG16_SNORM', baseInternalFormat='GL_RG', redBits=16, greenBits=16, internalType='s'},
	{internalFormat='GL_R3_G3_B2', baseInternalFormat='GL_RGB', redBits=3, greenBits=3, blueBits=2},
	{internalFormat='GL_RGB4', baseInternalFormat='GL_RGB', redBits=4, greenBits=4, blueBits=4},
	{internalFormat='GL_RGB5', baseInternalFormat='GL_RGB', redBits=5, greenBits=5, blueBits=5},
	{internalFormat='GL_RGB10', baseInternalFormat='GL_RGB', redBits=10, greenBits=10, blueBits=10},
	{internalFormat='GL_RGB12', baseInternalFormat='GL_RGB', redBits=12, greenBits=12, blueBits=12},
	{internalFormat='GL_RGB16_SNORM', baseInternalFormat='GL_RGB', redBits=16, greenBits=16, blueBits=16},
	{internalFormat='GL_RGBA2', baseInternalFormat='GL_RGB', redBits=2, greenBits=2, blueBits=2, alphaBits=2},
	{internalFormat='GL_RGBA12', baseInternalFormat='GL_RGBA', redBits=12, greenBits=12, blueBits=12, alphaBits=12},
	{internalFormat='GL_RGBA16', baseInternalFormat='GL_RGBA', redBits=16, greenBits=16, blueBits=16, alphaBits=16},
	-- GLES3 table 2 "unsized internal formats"
	{internalFormat='GL_RGB565', format='GL_RGB', types={'GL_UNSIGNED_BYTE', 'GL_UNSIGNED_SHORT_5_6_5'}, redBits=5, greenBits=6, blueBits=5, colorRenderable=true, textureFilterable=true},
	-- GL4 and GLES3 merged:
	{internalFormat='GL_R8', baseInternalFormat='GL_RED', format='GL_RED', types={'GL_UNSIGNED_BYTE'}, redBits=8, colorRenderable=true, textureFilterable=true},
	{internalFormat='GL_R8_SNORM', baseInternalFormat='GL_RED', format='GL_RED', types={'GL_BYTE'}, redBits=8, colorRenderable=false, textureFilterable=true, internalType='s'},
	{internalFormat='GL_R16F', baseInternalFormat='GL_RED', format='GL_RED', types={'GL_HALF_FLOAT', 'GL_FLOAT'}, redBits=16, colorRenderable=false, textureFilterable=true, internalType='f'},
	{internalFormat='GL_R32F', baseInternalFormat='GL_RED', format='GL_RED', types={'GL_FLOAT'}, redBits=32, colorRenderable=false, textureFilterable=false, internalType='f'},
	{internalFormat='GL_R8UI', baseInternalFormat='GL_RED', format='GL_RED_INTEGER', types={'GL_UNSIGNED_BYTE'}, redBits=8, colorRenderable=true, textureFilterable=false, internalType='ui'},
	{internalFormat='GL_R8I', baseInternalFormat='GL_RED', format='GL_RED_INTEGER', types={'GL_BYTE'}, redBits=8, colorRenderable=true, textureFilterable=false, internalType='i'},
	{internalFormat='GL_R16UI', baseInternalFormat='GL_RED', format='GL_RED_INTEGER', types={'GL_UNSIGNED_SHORT'}, redBits=16, colorRenderable=true, textureFilterable=false, internalType='ui'},
	{internalFormat='GL_R16I', baseInternalFormat='GL_RED', format='GL_RED_INTEGER', types={'GL_SHORT'}, redBits=16, colorRenderable=true, textureFilterable=false, internalType='i'},
	{internalFormat='GL_R32UI', baseInternalFormat='GL_RED', format='GL_RED_INTEGER', types={'GL_UNSIGNED_INT'}, redBits=32, colorRenderable=true, textureFilterable=false, internalType='ui'},
	{internalFormat='GL_R32I', baseInternalFormat='GL_RED', format='GL_RED_INTEGER', types={'GL_INT'}, redBits=32, colorRenderable=true, textureFilterable=false, internalType='i'},
	{internalFormat='GL_RG8', baseInternalFormat='GL_RG', format='GL_RG', types={'GL_UNSIGNED_BYTE'}, redBits=8, greenBits=8, colorRenderable=true, textureFilterable=true},
	{internalFormat='GL_RG8_SNORM', baseInternalFormat='GL_RG', format='GL_RG', types={'GL_BYTE'}, redBits=8, greenBits=8, colorRenderable=false, textureFilterable=true, internalType='s'},
	{internalFormat='GL_RG16F', baseInternalFormat='GL_RG', format='GL_RG', types={'GL_HALF_FLOAT', 'GL_FLOAT'}, redBits=16, greenBits=16, colorRenderable=false, textureFilterable=true, internalType='f'},
	{internalFormat='GL_RG32F', baseInternalFormat='GL_RG', format='GL_RG', types={'GL_FLOAT'}, redBits=32, greenBits=32, colorRenderable=false, textureFilterable=false, internalType='f'},
	{internalFormat='GL_RG8UI', baseInternalFormat='GL_RG', format='GL_RG_INTEGER', types={'GL_UNSIGNED_BYTE'}, redBits=8, greenBits=8, colorRenderable=true, textureFilterable=false, internalType='ui'},
	{internalFormat='GL_RG8I', baseInternalFormat='GL_RG', format='GL_RG_INTEGER', types={'GL_BYTE'}, redBits=8, greenBits=8, colorRenderable=true, textureFilterable=false, internalType='i'},
	{internalFormat='GL_RG16UI', baseInternalFormat='GL_RG', format='GL_RG_INTEGER', types={'GL_UNSIGNED_SHORT'}, redBits=16, greenBits=16, colorRenderable=true, textureFilterable=false, internalType='ui'},
	{internalFormat='GL_RG16I', baseInternalFormat='GL_RG', format='GL_RG_INTEGER', types={'GL_SHORT'}, redBits=16, greenBits=16, colorRenderable=true, textureFilterable=false, internalType='i'},
	{internalFormat='GL_RG32UI', baseInternalFormat='GL_RG', format='GL_RG_INTEGER', types={'GL_UNSIGNED_INT'}, redBits=32, greenBits=32, colorRenderable=true, textureFilterable=false, internalType='ui'},
	{internalFormat='GL_RG32I', baseInternalFormat='GL_RG', format='GL_RG_INTEGER', types={'GL_INT'}, redBits=32, greenBits=32, colorRenderable=true, textureFilterable=false, internalType='i'},
	{internalFormat='GL_RGB8', baseInternalFormat='GL_RGB', format='GL_RGB', types={'GL_UNSIGNED_BYTE'}, redBits=8, greenBits=8, blueBits=8, colorRenderable=true, textureFilterable=true},
	{internalFormat='GL_SRGB8', baseInternalFormat='GL_RGB', format='GL_RGB', types={'GL_UNSIGNED_BYTE'}, redBits=8, greenBits=8, blueBits=8, colorRenderable=false, textureFilterable=true},
	{internalFormat='GL_RGB8_SNORM', baseInternalFormat='GL_RGB', format='GL_RGB', types={'GL_BYTE'}, redBits=8, greenBits=8, blueBits=8, colorRenderable=false, textureFilterable=true, internalType='s'},
	{internalFormat='GL_R11F_G11F_B10F', baseInternalFormat='GL_RGB', format='GL_RGB', types={'GL_UNSIGNED_INT_10F_11F_11F_REV', 'GL_HALF_FLOAT', 'GL_FLOAT'}, redBits=11, greenBits=11, blueBits=10, colorRenderable=false, textureFilterable=true, internalType='f'},
	{internalFormat='GL_RGB9_E5', baseInternalFormat='GL_RGB', format='GL_RGB', types={'GL_UNSIGNED_INT_5_9_9_9_REV', 'GL_HALF_FLOAT', 'GL_FLOAT'}, redBits=9, greenBits=9, blueBits=9, sharedBits=5, colorRenderable=false, textureFilterable=true},
	{internalFormat='GL_RGB16F', baseInternalFormat='GL_RGB', format='GL_RGB', types={'GL_HALF_FLOAT', 'GL_FLOAT'}, redBits=16, greenBits=16, blueBits=16, colorRenderable=false, textureFilterable=true, internalType='f'},
	{internalFormat='GL_RGB32F', baseInternalFormat='GL_RGB', format='GL_RGB', types={'GL_FLOAT'}, redBits=32, greenBits=32, blueBits=32, colorRenderable=false, textureFilterable=false, internalType='f'},
	{internalFormat='GL_RGB8UI', baseInternalFormat='GL_RGB', format='GL_RGB_INTEGER', types={'GL_UNSIGNED_BYTE'}, redBits=8, greenBits=8, blueBits=8, colorRenderable=false, textureFilterable=false, internalType='ui'},
	{internalFormat='GL_RGB8I', baseInternalFormat='GL_RGB', format='GL_RGB_INTEGER', types={'GL_BYTE'}, redBits=8, greenBits=8, blueBits=8, colorRenderable=false, textureFilterable=false, internalType='i'},
	{internalFormat='GL_RGB16UI', baseInternalFormat='GL_RGB', format='GL_RGB_INTEGER', types={'GL_UNSIGNED_SHORT'}, redBits=16, greenBits=16, blueBits=16, colorRenderable=false, textureFilterable=false, internalType='ui'},
	{internalFormat='GL_RGB16I', baseInternalFormat='GL_RGB', format='GL_RGB_INTEGER', types={'GL_SHORT'}, redBits=16, greenBits=16, blueBits=16, colorRenderable=false, textureFilterable=false, internalType='i'},
	{internalFormat='GL_RGB32UI', baseInternalFormat='GL_RGB', format='GL_RGB_INTEGER', types={'GL_UNSIGNED_INT'}, redBits=32, greenBits=32, blueBits=32, colorRenderable=false, textureFilterable=false, internalType='ui'},
	{internalFormat='GL_RGB32I', baseInternalFormat='GL_RGB', format='GL_RGB_INTEGER', types={'GL_INT'}, redBits=32, greenBits=32, blueBits=32, colorRenderable=false, textureFilterable=false, internalType='i'},
	{internalFormat='GL_RGBA8', baseInternalFormat='GL_RGBA', format='GL_RGBA', types={'GL_UNSIGNED_BYTE'}, redBits=8, greenBits=8, blueBits=8, alphaBits=8, colorRenderable=true, textureFilterable=true},
	{internalFormat='GL_SRGB8_ALPHA8', baseInternalFormat='GL_RGBA', format='GL_RGBA', types={'GL_UNSIGNED_BYTE'}, redBits=8, greenBits=8, blueBits=8, alphaBits=8, colorRenderable=true, textureFilterable=true},
	{internalFormat='GL_RGBA8_SNORM', baseInternalFormat='GL_RGBA', format='GL_RGBA', types={'GL_BYTE'}, redBits=8, greenBits=8, blueBits=8, alphaBits=8, colorRenderable=false, textureFilterable=true, internalType='s'},
	{internalFormat='GL_RGB5_A1', baseInternalFormat='GL_RGBA', format='GL_RGBA', types={'GL_UNSIGNED_BYTE', 'GL_UNSIGNED_SHORT_5_5_5_1', 'GL_UNSIGNED_INT_2_10_10_10_REV'}, redBits=5, greenBits=5, blueBits=5, alphaBits=1, colorRenderable=true, textureFilterable=true},
	{internalFormat='GL_RGBA4', baseInternalFormat='GL_RGB', format='GL_RGBA', types={'GL_UNSIGNED_BYTE', 'GL_UNSIGNED_SHORT_4_4_4_4'}, redBits=4, greenBits=4, blueBits=4, alphaBits=4, colorRenderable=true, textureFilterable=true},
	{internalFormat='GL_RGB10_A2', baseInternalFormat='GL_RGBA', format='GL_RGBA', types={'GL_UNSIGNED_INT_2_10_10_10_REV'}, redBits=10, greenBits=10, blueBits=10, alphaBits=2, colorRenderable=true, textureFilterable=true},
	{internalFormat='GL_RGBA16F', baseInternalFormat='GL_RGBA', format='GL_RGBA', types={'GL_HALF_FLOAT', 'GL_FLOAT'}, redBits=16, greenBits=16, blueBits=16, alphaBits=16, colorRenderable=false, textureFilterable=true, internalType='f'},
	{internalFormat='GL_RGBA32F', baseInternalFormat='GL_RGBA', format='GL_RGBA', types={'GL_FLOAT'}, redBits=32, greenBits=32, blueBits=32, alphaBits=32, colorRenderable=false, textureFilterable=false, internalType='f'},
	{internalFormat='GL_RGBA8UI', baseInternalFormat='GL_RGBA', format='GL_RGBA_INTEGER', types={'GL_UNSIGNED_BYTE'}, redBits=8, greenBits=8, blueBits=8, alphaBits=8, colorRenderable=true, textureFilterable=false, internalType='ui'},
	{internalFormat='GL_RGBA8I', baseInternalFormat='GL_RGBA', format='GL_RGBA_INTEGER', types={'GL_BYTE'}, redBits=8, greenBits=8, blueBits=8, alphaBits=8, colorRenderable=true, textureFilterable=false, internalType='i'},
	{internalFormat='GL_RGB10_A2UI', baseInternalFormat='GL_RGBA', format='GL_RGBA_INTEGER', types={'GL_UNSIGNED_INT_2_10_10_10_REV'}, redBits=10, greenBits=10, blueBits=10, alphaBits=2, colorRenderable=true, textureFilterable=false, internalType='ui'},
	{internalFormat='GL_RGBA16UI', baseInternalFormat='GL_RGBA', format='GL_RGBA_INTEGER', types={'GL_UNSIGNED_SHORT'}, redBits=16, greenBits=16, blueBits=16, alphaBits=16, colorRenderable=true, textureFilterable=false, internalType='ui'},
	{internalFormat='GL_RGBA16I', baseInternalFormat='GL_RGBA', format='GL_RGBA_INTEGER', types={'GL_SHORT'}, redBits=16, greenBits=16, blueBits=16, alphaBits=16, colorRenderable=true, textureFilterable=false, internalType='i'},
	{internalFormat='GL_RGBA32I', baseInternalFormat='GL_RGBA', format='GL_RGBA_INTEGER', types={'GL_INT'}, redBits=32, greenBits=32, blueBits=32, alphaBits=32, colorRenderable=true, textureFilterable=false, internalType='i'},
	{internalFormat='GL_RGBA32UI', baseInternalFormat='GL_RGBA', format='GL_RGBA_INTEGER', types={'GL_UNSIGNED_INT'}, redBits=32, greenBits=32, blueBits=32, alphaBits=32, colorRenderable=true, textureFilterable=false, internalType='ui'},
	-- GLES3 table 2 "sized internal formats"
	{internalFormat='GL_DEPTH_COMPONENT16', format='GL_DEPTH_COMPONENT', type={'GL_UNSIGNED_SHORT', 'GL_UNSIGNED_INT'}, depthBits=16},
	{internalFormat='GL_DEPTH_COMPONENT24', format='GL_DEPTH_COMPONENT', type={'GL_UNSIGNED_INT'}, depthBits=24},
	{internalFormat='GL_DEPTH_COMPONENT32F', format='GL_DEPTH_COMPONENT', type={'GL_FLOAT'}, depthBits=32, internalType='f'},
	{internalFormat='GL_DEPTH24_STENCIL8', format='GL_DEPTH_STENCIL', type={'GL_UNSIGNED_INT_24_8'}, depthBits=24, stencilBits=8},
	{internalFormat='GL_DEPTH32F_STENCIL8', format='GL_DEPTH_STENCIL', type={'GL_FLOAT_32_UNSIGNED_INT_24_8_REV'}, depthBits=32, stencilBits=8, internalType='f'},
	-- GL4 table 3
	{internalFormat='GL_COMPRESSED_RED', baseInternalFormat='GL_RED', genericVsSpecific='Generic'},
	{internalFormat='GL_COMPRESSED_RG', baseInternalFormat='GL_RG', genericVsSpecific='Generic'},
	{internalFormat='GL_COMPRESSED_RGB', baseInternalFormat='GL_RGB', genericVsSpecific='Generic'},
	{internalFormat='GL_COMPRESSED_RGBA', baseInternalFormat='GL_RGBA', genericVsSpecific='Generic'},
	{internalFormat='GL_COMPRESSED_SRGB', baseInternalFormat='GL_RGB', genericVsSpecific='Generic'},
	{internalFormat='GL_COMPRESSED_SRGB_ALPHA', baseInternalFormat='GL_RGBA', genericVsSpecific='Generic'},
	{internalFormat='GL_COMPRESSED_RED_RGTC1', baseInternalFormat='GL_RED', genericVsSpecific='Specific'},
	{internalFormat='GL_COMPRESSED_SIGNED_RED_RGTC1', baseInternalFormat='GL_RED', genericVsSpecific='Specific'},
	{internalFormat='GL_COMPRESSED_RG_RGTC2', baseInternalFormat='GL_RG', genericVsSpecific='Specific'},
	{internalFormat='GL_COMPRESSED_SIGNED_RG_RGTC2', baseInternalFormat='GL_RG', genericVsSpecific='Specific'},
	{internalFormat='GL_COMPRESSED_RGBA_BPTC_UNORM', baseInternalFormat='GL_RGBA', genericVsSpecific='Specific'},
	{internalFormat='GL_COMPRESSED_SRGB_ALPHA_BPTC_UNORM', baseInternalFormat='GL_RGBA', genericVsSpecific='Specific'},
	{internalFormat='GL_COMPRESSED_RGB_BPTC_SIGNED_FLOAT', baseInternalFormat='GL_RGB', genericVsSpecific='Specific'},
	{internalFormat='GL_COMPRESSED_RGB_BPTC_UNSIGNED_FLOAT', baseInternalFormat='GL_RGB', genericVsSpecific='Specific'},
	-- GL4 error list of invalid internalFormats from "glCompressedTexImage2D" is a mix of some of the GL4 table 3 compressed internalFormats, and of the GLES3 glCompressedTexImage2D internalFormats
	-- GLES3 table for "glCompressedTexImage2D"
	{internalFormat='GL_COMPRESSED_R11_EAC', baseInternalFormat='GL_RED', calcSize='ceil(width/4) * ceil(height/4) * 8'},
	{internalFormat='GL_COMPRESSED_SIGNED_R11_EAC', baseInternalFormat='GL_RED', calcSize='ceil(width/4) * ceil(height/4) * 8'},
	{internalFormat='GL_COMPRESSED_RG11_EAC', baseInternalFormat='GL_RG', calcSize='ceil(width/4) * ceil(height/4) * 16'},
	{internalFormat='GL_COMPRESSED_SIGNED_RG11_EAC', baseInternalFormat='GL_RG', calcSize='ceil(width/4) * ceil(height/4) * 16'},
	{internalFormat='GL_COMPRESSED_RGB8_ETC2', baseInternalFormat='GL_RGB', calcSize='ceil(width/4) * ceil(height/4) * 8'},
	{internalFormat='GL_COMPRESSED_SRGB8_ETC2', baseInternalFormat='GL_RGB', calcSize='ceil(width/4) * ceil(height/4) * 8'},
	{internalFormat='GL_COMPRESSED_RGB8_PUNCHTHROUGH_ALPHA1_ETC2', baseInternalFormat='GL_RGBA', calcSize='ceil(width/4) * ceil(height/4) * 8'},
	{internalFormat='GL_COMPRESSED_SRGB8_PUNCHTHROUGH_ALPHA1_ETC2', baseInternalFormat='GL_RGBA', calcSize='ceil(width/4) * ceil(height/4) * 8'},
	{internalFormat='GL_COMPRESSED_RGBA8_ETC2_EAC', baseInternalFormat='GL_RGBA', calcSize='ceil(width/4) * ceil(height/4) * 16'},
	{internalFormat='GL_COMPRESSED_SRGB8_ALPHA8_ETC2_EAC', baseInternalFormat='GL_RGBA', calcSize='ceil(width/4) * ceil(height/4) * 16'},
	{internalFormat='GL_COMPRESSED_RGBA_ASTC_4x4', baseInternalFormat='GL_RGBA', calcSize='ceil(width/4) * ceil(height/4) * 16'},
	{internalFormat='GL_COMPRESSED_RGBA_ASTC_5x4', baseInternalFormat='GL_RGBA', calcSize='ceil(width/5) * ceil(height/4) * 16'},
	{internalFormat='GL_COMPRESSED_RGBA_ASTC_5x5', baseInternalFormat='GL_RGBA', calcSize='ceil(width/5) * ceil(height/5) * 16'},
	{internalFormat='GL_COMPRESSED_RGBA_ASTC_6x5', baseInternalFormat='GL_RGBA', calcSize='ceil(width/6) * ceil(height/5) * 16'},
	{internalFormat='GL_COMPRESSED_RGBA_ASTC_6x6', baseInternalFormat='GL_RGBA', calcSize='ceil(width/6) * ceil(height/6) * 16'},
	{internalFormat='GL_COMPRESSED_RGBA_ASTC_8x5', baseInternalFormat='GL_RGBA', calcSize='ceil(width/8) * ceil(height/5) * 16'},
	{internalFormat='GL_COMPRESSED_RGBA_ASTC_8x6', baseInternalFormat='GL_RGBA', calcSize='ceil(width/8) * ceil(height/6) * 16'},
	{internalFormat='GL_COMPRESSED_RGBA_ASTC_8x8', baseInternalFormat='GL_RGBA', calcSize='ceil(width/8) * ceil(height/8) * 16'},
	{internalFormat='GL_COMPRESSED_RGBA_ASTC_10x5', baseInternalFormat='GL_RGBA', calcSize='ceil(width/10) * ceil(height/5) * 16'},
	{internalFormat='GL_COMPRESSED_RGBA_ASTC_10x6', baseInternalFormat='GL_RGBA', calcSize='ceil(width/10) * ceil(height/6) * 16'},
	{internalFormat='GL_COMPRESSED_RGBA_ASTC_10x8', baseInternalFormat='GL_RGBA', calcSize='ceil(width/10) * ceil(height/8) * 16'},
	{internalFormat='GL_COMPRESSED_RGBA_ASTC_10x10', baseInternalFormat='GL_RGBA', calcSize='ceil(width/10) * ceil(height/10) * 16'},
	{internalFormat='GL_COMPRESSED_RGBA_ASTC_12x10', baseInternalFormat='GL_RGBA', calcSize='ceil(width/12) * ceil(height/10) * 16'},
	{internalFormat='GL_COMPRESSED_RGBA_ASTC_12x12', baseInternalFormat='GL_RGBA', calcSize='ceil(width/12) * ceil(height/12) * 16'},
	{internalFormat='GL_COMPRESSED_SRGB8_ALPHA8_ASTC_4x4', baseInternalFormat='GL_RGBA', calcSize='ceil(width/4) * ceil(height/4) * 16'},
	{internalFormat='GL_COMPRESSED_SRGB8_ALPHA8_ASTC_5x4', baseInternalFormat='GL_RGBA', calcSize='ceil(width/5) * ceil(height/4) * 16'},
	{internalFormat='GL_COMPRESSED_SRGB8_ALPHA8_ASTC_5x5', baseInternalFormat='GL_RGBA', calcSize='ceil(width/5) * ceil(height/5) * 16'},
	{internalFormat='GL_COMPRESSED_SRGB8_ALPHA8_ASTC_6x5', baseInternalFormat='GL_RGBA', calcSize='ceil(width/6) * ceil(height/5) * 16'},
	{internalFormat='GL_COMPRESSED_SRGB8_ALPHA8_ASTC_6x6', baseInternalFormat='GL_RGBA', calcSize='ceil(width/6) * ceil(height/6) * 16'},
	{internalFormat='GL_COMPRESSED_SRGB8_ALPHA8_ASTC_8x5', baseInternalFormat='GL_RGBA', calcSize='ceil(width/8) * ceil(height/5) * 16'},
	{internalFormat='GL_COMPRESSED_SRGB8_ALPHA8_ASTC_8x6', baseInternalFormat='GL_RGBA', calcSize='ceil(width/8) * ceil(height/6) * 16'},
	{internalFormat='GL_COMPRESSED_SRGB8_ALPHA8_ASTC_8x8', baseInternalFormat='GL_RGBA', calcSize='ceil(width/8) * ceil(height/8) * 16'},
	{internalFormat='GL_COMPRESSED_SRGB8_ALPHA8_ASTC_10x5', baseInternalFormat='GL_RGBA', calcSize='ceil(width/10) * ceil(height/5) * 16'},
	{internalFormat='GL_COMPRESSED_SRGB8_ALPHA8_ASTC_10x6', baseInternalFormat='GL_RGBA', calcSize='ceil(width/10) * ceil(height/6) * 16'},
	{internalFormat='GL_COMPRESSED_SRGB8_ALPHA8_ASTC_10x8', baseInternalFormat='GL_RGBA', calcSize='ceil(width/10) * ceil(height/8) * 16'},
	{internalFormat='GL_COMPRESSED_SRGB8_ALPHA8_ASTC_10x10', baseInternalFormat='GL_RGBA', calcSize='ceil(width/10) * ceil(height/10) * 16'},
	{internalFormat='GL_COMPRESSED_SRGB8_ALPHA8_ASTC_12x10', baseInternalFormat='GL_RGBA', calcSize='ceil(width/12) * ceil(height/10) * 16'},
	{internalFormat='GL_COMPRESSED_SRGB8_ALPHA8_ASTC_12x12', baseInternalFormat='GL_RGBA', calcSize='ceil(width/12) * ceil(height/12) * 16'},
}
for i=#formatInfos,1,-1 do
	local info = formatInfos[i]

	-- keep the names around
	-- this is useful for errors
	-- but especially, GLSL uses the internalFormat (without the GL_, and lowercased) in its layout() for images/textures
	-- or just cache the glsl format here as well
	info.glslFormatName =  info.internalFormat:match'^GL_(.*)$':lower()

	local internalFormat = op.safeindex(gl, info.internalFormat)
	local baseInternalFormat = op.safeindex(gl, info.baseInternalFormat)
	local format = op.safeindex(gl, info.format)
	local types = info.types and table.mapi(info.types, function(key,i,t)
		return op.safeindex(gl, key), #t+1
	end) or nil
	if types and #types == 0 then types = nil end
	if not internalFormat and info.internalFormat then
--DEBUG:print("failed to find internalFormat", info.internalFormat)
		formatInfos:remove(i)
	elseif not format and info.format then
--DEBUG:print("failed to find format", info.format, "for internalFormat", info.internalFormat)
		formatInfos:remove(i)
	elseif not baseInternalFormat and info.baseInternalFormat then
--DEBUG:print("failed to find baseInternalFormat", info.baseInternalFormat, "for internalFormat", info.internalFormat)
		formatInfos:remove(i)
	elseif not types and info.types then
--DEBUG:print("failed to find any types", table.concat(info.types, ', '), "for internalFormat", info.internalFormat)
		formatInfos:remove(i)
	else
		info.internalFormat = internalFormat
		info.baseInternalFormat = baseInternalFormat
		info.format = format
		info.types = types
	end
end

local formatInfoForInternalFormat = formatInfos:mapi(function(info)
	return info, info.internalFormat
end):setmetatable(nil)

local glslPrefixForInternalType = {
	ui = 'u',
	i = 'i',
	f = '',
	s = '',
}


local GLTex = GLGet.behavior()

GLTex.formatInfos = formatInfos
GLTex.formatInfoForInternalFormat = formatInfoForInternalFormat
GLTex.glslPrefixForInternalType = glslPrefixForInternalType

-- TODO just use GLTex.formatInfos
GLTex.formatForChannels = {
	[1] = op.safeindex(gl, 'GL_LUMINANCE') or op.safeindex(gl, 'GL_RED'),
	[3] = gl.GL_RGB,
	[4] = gl.GL_RGBA,
}

-- inverse of 'formatForChannels'
-- TODO just use GLTex.formatInfos
GLTex.channelsForFormat = table{
	GL_LUMINANCE = 1,
	GL_RED = 1,
	GL_RGB = 3,
	GL_RGBA = 4,
	-- TODO this table is long.
}:map(function(v,k)
	k = op.safeindex(gl, k)
	if not k then return end
	return v, k
end):setmetatable(nil)


local glRetTexParameteri = GLGet.makeRetLastArg{
	name = 'glGetTextureParameteriv',
	ctype = GLint,
	lookup = {1, 2},
}
local function getteri(self, nameValue)
	-- if we're GL 4.5 then we can use glGetTextureParameter* which accepts self.id (like glGetProgram and like the whole CL API)
	-- but otherwise (incl all GLES) we have to use glGetTexParameter*
	-- GL has glGetTextureParameterfv & -iv
	-- GLES1 has only glGetTexParameterf
	-- GLES2 and 3 have glGetTexParameterf and -i
	return glRetTexParameteri(self.target, nameValue)
end

-- hmm 'getter' means call the getter above, which is a wrapper for glGet*
-- so mayb i have to put th branch in the getter above fr now ....
-- another TODO is this should be getterf for GLES2 ... and for GLES1 *all* texture getters are getterf ...
local glRetTexParameterf = GLGet.makeRetLastArg{
	name = 'glGetTextureParameterfv',
	ctype = GLfloat,
	lookup = {1, 2},
}
local function glRetTexParameterfForObj(self, nameValue)
	return glRetTexParameterf(self.target, nameValue)
end

local glRetTexParameterf4 = GLGet.makeRetLastArg{
	name = 'glGetTextureParameterfv',
	lookup = {1, 2},
	ctype = GLfloat,
	count = 4,
}
local function glRetTexParameterf4ForObj(self, nameValue)
	return glRetTexParameterf4(self.target, nameValue)
end

GLTex:makeGetter{
	-- default use int
	-- TODO map and assign based on type and on gl version
	getter = getteri,
	-- https://registry.khronos.org/OpenGL-Refpages/gl4/html/glGetTexParameter.xhtml
	-- would be nice if the docs specified what getter result type was preferred
	vars = {
		{name='GL_TEXTURE_MAG_FILTER'},
		{name='GL_TEXTURE_MIN_FILTER'},
		{name='GL_TEXTURE_MIN_LOD', getter=glRetTexParameterfForObj},
		{name='GL_TEXTURE_MAX_LOD', getter=glRetTexParameterfForObj},
		{name='GL_TEXTURE_BASE_LEVEL'},
		{name='GL_TEXTURE_MAX_LEVEL'},
		{name='GL_TEXTURE_SWIZZLE_R'},
		{name='GL_TEXTURE_SWIZZLE_G'},
		{name='GL_TEXTURE_SWIZZLE_B'},
		{name='GL_TEXTURE_SWIZZLE_A'},
		{name='GL_TEXTURE_SWIZZLE_RGBA', getter=glRetTexParameterf4ForObj},
		{name='GL_TEXTURE_WRAP_S'},
		{name='GL_TEXTURE_WRAP_T'},
		{name='GL_TEXTURE_WRAP_R'},
		{name='GL_TEXTURE_BORDER_COLOR', getter=glRetTexParameterf4ForObj},
		{name='GL_TEXTURE_COMPARE_MODE'},
		{name='GL_TEXTURE_COMPARE_FUNC'},
		{name='GL_TEXTURE_IMMUTABLE_FORMAT'},

		-- 4.2 or later
		{name='GL_IMAGE_FORMAT_COMPATIBILITY_TYPE'},

		-- 4.3 or later
		{name='GL_DEPTH_STENCIL_TEXTURE_MODE'},
		{name='GL_TEXTURE_VIEW_MIN_LEVEL'},
		{name='GL_TEXTURE_VIEW_NUM_LEVELS'},
		{name='GL_TEXTURE_VIEW_MIN_LAYER'},
		{name='GL_TEXTURE_VIEW_NUM_LAYERS'},
		{name='GL_TEXTURE_IMMUTABLE_LEVELS'},

		-- 4.5 or later
		{name='GL_TEXTURE_TARGET'},
	},
}

function GLTex:init(args)
	if type(args) == 'string' then
		args = {filename = args}
	else
		args = table(args)
	end

	local ptr = GLuint_1()
	gl.glGenTextures(1, ptr)
	self.id = ptr[0]

	self.target = args.target	-- if we override then do so before :bind()
	self:bind()
	if args.filename or args.image then
		self:load(args)
	end
	self:create(args)

	if args.minFilter then self:setParameter(gl.GL_TEXTURE_MIN_FILTER, args.minFilter) end
	if args.magFilter then self:setParameter(gl.GL_TEXTURE_MAG_FILTER, args.magFilter) end
	if args.wrap then self:setWrap(args.wrap) end
	if args.generateMipmap then self:generateMipmap() end
end

function GLTex:delete()
	if self.id == nil then return end
	local ptr = GLuint_1(self.id)
	gl.glDeleteTextures(1, ptr)
	self.id = nil
end

GLTex.__gc = GLTex.delete


-- luajit ... why break from lua behavior on table/keys not existing?
-- why does cdata throw exceptions when members are missing
local function safeget(t, k)
	local res, v = pcall(function() return t[k] end)
	if res then return v end
end

local lookupWrap = {
	s = gl.GL_TEXTURE_WRAP_S,
	t = gl.GL_TEXTURE_WRAP_T,
	-- gles 1 & 2 doesn't have GL_TEXTURE_WRAP_R
	r = op.safeindex(gl, 'GL_TEXTURE_WRAP_R'),
}
GLTex.lookupWrap = lookupWrap

function GLTex:setWrap(wrap)
	for k,v in pairs(wrap) do
		k = lookupWrap[k] or k
		assert(k, "tried to set a bad wrap")
		self:setParameter(k, v)
	end
	return self
end

function GLTex:setParameter(k, v)
	if type(k) == 'string' then k = gl[k] or error("couldn't find parameter "..k) end
	-- TODO pick by type? and expose each type call separately?
	gl.glTexParameterf(self.target, k, v)
	return self
end

function GLTex:enable()
	gl.glEnable(self.target)
	return self
end

function GLTex:disable()
	gl.glDisable(self.target)
	return self
end

function GLTex:bind(unit)
	if unit then
		gl.glActiveTexture(gl.GL_TEXTURE0 + unit)
	end
	gl.glBindTexture(self.target, self.id)
	return self
end

function GLTex:unbind(unit)
	if unit then
		gl.glActiveTexture(gl.GL_TEXTURE0 + unit)
	end
	gl.glBindTexture(self.target, 0)
	return self
end

-- used by child classes:

GLTex.resizeNPO2 = false

-- static method (self not required)
function GLTex.rupowoftwo(x)
	local u = 1
	x = x - 1
	while x > 0 do
		x = bit.rshift(x,1)
		u = bit.lshift(u,1)
	end
	return u
end

-- requires bind beforehand (TODO should this also bind?)
function GLTex:generateMipmap()
	gl.glGenerateMipmap(self.target)
	return self
end

-- this is more in tune with the lua-gl library
function GLTex:getImage(ptr, level)
	ptr = ptr or self.data
	if not ptr then
		error("expected ptr or .data")
	end
	gl.glGetTexImage(self.target, level or 0, self.format, self.type, ffi.cast(char_p, ptr))
	return self
end

-- this is a lua-cl compat function
function GLTex:toCPU(ptr, level)
	if not ptr then
		ptr = self.data
		if not ptr then
			-- TODO need to map from format to channels
			-- TOOD need to map from GL type to C type
			--ptr = uint8_t_arr(size)
			-- or TODO default to self.data, that was used for initial texture creation?
			error("expected ptr or .data")
		end
	end
	-- TODO .keep to keep the ptr upon init, and default to it here?
	-- TODO require bind() beforehand like all the other setters? or manually bind() here?
	self:bind()
		:getImage(ptr, level)
	return ptr
end

function GLTex:getFormatInfo()
	return assert.index(formatInfoForInternalFormat, self.internalFormat, "failed to find formatInfo for internalFormat")
end

function GLTex:getGLSLPrefix()
	return glslPrefixForInternalType[self:getFormatInfo().internalType] or ''
end

-- https://www.khronos.org/opengl/wiki/Sampler_(GLSL)#Sampler_types
local samplerSuffixForTarget = table.map({
	GL_TEXTURE_1D = '1D',
	GL_TEXTURE_2D = '2D',
	GL_TEXTURE_3D = '3D',
	GL_TEXTURE_CUBE_MAP = 'Cube',
	GL_TEXTURE_RECTANGLE = 'Rect',
	GL_TEXTURE_1D_ARRAY = '1DArray',
	GL_TEXTURE_2D_ARRAY = '2DArray',
	GL_TEXTURE_CUBE_ARRAY = 'CubeArray',
	GL_TEXTURE_BUFFER = 'Buffer',
	GL_TEXTURE_2D_MULTISAMPLE = '2DMS',
	GL_TEXTURE_2D_MULTISAMPLE_ARRAY = '2DMSArray',
}, function(v,k)
	k = op.safeindex(gl, k)
	if k then return v, k end
end)

function GLTex:getGLSLSamplerType()
	return self:getGLSLPrefix()..'sampler'
	-- if it's not listed there's going to be a GLSL error, so add on a warning
		..(samplerSuffixForTarget[self.target] or '_unknownTarget')
	-- TODO ..(self.isShadow and 'Shadow' or '')
end

function GLTex:getGLSLFragType()
	return self:getGLSLPrefix()..'vec4'
end

return GLTex
