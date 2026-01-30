return function(env, ...)
	env = env or _G
	env.gl = require 'gl.setup'(...)
	env.GLArrayBuffer = require 'gl.arraybuffer'
	env.GLAttribute = require 'gl.attribute'
	env.GLBuffer = require 'gl.buffer'
	env.glCallOrRun = require 'gl.call'
	env.GLElementArrayBuffer = require 'gl.elementarraybuffer'
	for k,v in pairs(require 'gl.error') do
		env[k] = v
	end
	env.GLFramebuffer = require 'gl.framebuffer'
	env.GLGeometry = require 'gl.geometry'
	env.glGlobal = require 'gl.global'
	env.GLGradientTex2D = require 'gl.gradienttex2d'
	env.GLHSVTex2D = require 'gl.hsvtex2d'
	env.GLKernelProgram = require 'gl.kernelprogram'
	env.glnumber = require 'gl.number'
	env.GLPingPong3D = require 'gl.pingpong3d'
	env.GLPingPong = require 'gl.pingpong'
	env.GLPixelPackBuffer = require 'gl.pixelpackbuffer'
	env.GLPixelUnpackBuffer = require 'gl.pixelunpackbuffer'
	env.GLProgram = require 'gl.program'
	env.GLQuery = require 'gl.query'
	env.glreport = require 'gl.report'
	env.GLSampler = require 'gl.sampler'
	env.GLSceneObject = require 'gl.sceneobject'
	env.GLShader = require 'gl.shader'
	env.GLTex2D = require 'gl.tex2d'
	env.GLTex3D = require 'gl.tex3d'
	env.GLTexCube = require 'gl.texcube'
	env.GLTransformFeedbackBuffer = require 'gl.transformfeedbackbuffer'
	env.GLTypes = require 'gl.types'
	env.GLUniformBuffer = require 'gl.uniformbuffer'
	env.GLVertexArray = require 'gl.vertexarray'

	local op = require 'ext.op'
	if op.safeindex(gl, 'GL_TEXTURE_1D') then
		env.GLTex1D = require 'gl.tex1d'
		env.GLGradientTex = require 'gl.gradienttex'
		env.GLHSVTex = require 'gl.hsvtex'
	end
	if op.safeindex(gl, 'GL_SHADER_STORAGE_BUFFER') then
		env.GLShaderStorageBuffer = require 'gl.shaderstoragebuffer'
	end
	if op.safeindex(gl, 'GL_TEXTURE_BUFFER') then
		env.GLTexBuffer = require 'gl.texbuffer'
	end

	--env.glSceneIntersect = require 'gl.intersect'	-- depends on GLU

	return env
end
