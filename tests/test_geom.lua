#!/usr/bin/env luajit
local cmdline = require 'ext.cmdline'(...)
local op = require 'ext.op'
local timer = require 'ext.timer'
local template = require 'template'
local sdl = require 'sdl'
local gl = require 'gl.setup'(cmdline.gl)
local GLSceneObject = require 'gl.sceneobject'

local App = require 'app3d.orbit'()
App.viewDist = 3

function App:initGL()
	-- if I do this math in-shader then I get "error: compile-time constant expressions require GLSL 4.40 "
	-- so I'll do it in here/template
	-- TODO pick this based on whatever the max vertices queried are
	local maxTess = cmdline.maxTess or 9

	self.globj = GLSceneObject{
		program = {
			version = 'latest',
			precision = 'best',
			vertexCode = [[
layout(location=0) in vec3 vertex;
layout(location=0) out vec3 vertexv;

layout(location=0) uniform mat4 viewMat;
layout(location=1) uniform mat4 projMat;

void main() {
	vertexv = vertex;
	// if I'm using a gemoetry shader then I can get by without emitting a gl_Position?
	//gl_Position = projMat * (viewMat * vec4(vertex, 1.));
}
]],
			geometryCode = template([[
layout(triangles) in;
layout(triangle_strip,
	max_vertices=<?=maxTess*maxTess*3?>
) out;

layout(location=0) in vec3 vertexv[];
layout(location=0) out vec3 vertexg;

layout(location=0) uniform mat4 viewMat;
layout(location=1) uniform mat4 projMat;
layout(location=2) uniform float triScale;

void emitVtx(vec3 v) {
	// tetrahedron, tesselated, normalized, looks ugly -- too much vertexes bunched at the corners
	// octahedron, tesselated, normalized, looks better
	v = normalize(v);

	vertexg = v;
	gl_Position = projMat * (viewMat * vec4(v, 1.));
	EmitVertex();
}

// triBasis[0] = v1-v0, triBasis[1] = v2-v0, triBasis[2] = v0
vec3 getVertex(vec2 ij, mat3 triBasis) {
	return triBasis[0] * ij.x + triBasis[1] * ij.y + triBasis[2];
}

void emitTri(vec2 ij0, vec2 ij1, vec2 ij2, mat3 triBasis) {
	vec3 v0 = getVertex(ij0, triBasis);
	vec3 v1 = getVertex(ij1, triBasis);
	vec3 v2 = getVertex(ij2, triBasis);
	vec3 avg = (v0 + v1 + v2) / 3.;
	v0 = mix(avg, v0, triScale);
	v1 = mix(avg, v1, triScale);
	v2 = mix(avg, v2, triScale);
	emitVtx(v0);
	emitVtx(v1);
	emitVtx(v2);
	EndPrimitive();
}

void main() {
	// compare inner product between vertices
	// subdivide accordingly
	// or use pixel length somehow

	//dot based on angle from the perpendicular
	float z0 = 1. - abs(viewMat * vec4(vertexv[0], 0.)).z;
	float z1 = 1. - abs(viewMat * vec4(vertexv[1], 0.)).z;
	float z2 = 1. - abs(viewMat * vec4(vertexv[2], 0.)).z;
	// now I'm making one metric for the whole triangle, but really I should be doing this per-edge, but then I'd have to think up a more clever tesselation patch with varing edges, and that's a lot more tough than a simple patch that is evenly subdivided....
	float mindot = 1. - max(z0, max(z1, z2));

	// TODO convert to arclength or something and determine subdivision amount
	const float dotAngleThreshold = 1.;
	if (mindot < dotAngleThreshold) {
		mat3 triBasis;
		triBasis[0] = vertexv[1] - vertexv[0];
		triBasis[1] = vertexv[2] - vertexv[0];
		triBasis[2] = vertexv[0];
		int tess = int((float(<?=maxTess?>) - 1.) * (1. - mindot) * .5 + 1.);
		float tessf = float(tess);
		float dt = 1./tessf;
		for (int i = 0; i < tess; ++i) {
			float fi = float(i) / tessf;
			for (int j = 0; j < tess-i; ++j) {
				float fj = float(j) / tessf;
				emitTri(
					vec2(fi, fj),
					vec2(fi+dt, fj),
					vec2(fi, fj+dt),
					triBasis);
				if (i+1 < tess && j < tess-(i+1)) {
					emitTri(
						vec2(fi, fj+dt),
						vec2(fi+dt, fj),
						vec2(fi+dt, fj+dt),
						triBasis);
				}
			}
		}
	} else {
		// emit as is
		for (int i = 0; i < 3; ++i) {
			vertexg = vertexv[i];
			gl_Position = projMat * (viewMat * vec4(vertexv[i], 1.));
			EmitVertex();
		}
		EndPrimitive();
	}
}
]], 		{
				maxTess = maxTess,
			}),
			fragmentCode = [[
layout(location=0) in vec3 vertexg;
layout(location=0) out vec4 fragColor;
void main() {
	fragColor = vec4(
		normalize(vertexg) * .4 + .6,
		1.);
}
]],
		},
		uniforms = {
			viewMat = self.view.mvMat.ptr,
			projMat = self.view.projMat.ptr,
		},
--[[ tetrahedron
		vertexes = {
			data = {
				0, 0, 1,
				0, math.sqrt(8/9), -1 / 3,
				math.sqrt(2/3), -math.sqrt(2/9), -1 / 3,
				-math.sqrt(2/3), -math.sqrt(2/9), -1 / 3,
			},
		},
		geometry = {
			mode = gl.GL_TRIANGLES,
			indexes = {
				data = {
					2,1,0,
					0,1,3,
					3,2,0,
					1,2,3,
				},
			},
		},
--]]
-- [[ octahedron
		vertexes = {
			data = {
				0, 0, 1,
				1, 0, 0,
				0, 1, 0,
				-1, 0, 0,
				0, -1, 0,
				0, 0, -1,
			},
		},
		geometry = {
			mode = gl.GL_TRIANGLES,
			indexes = {
				data = {
					0,1,2,
					0,2,3,
					0,3,4,
					0,4,1,
					5,2,1,
					5,3,2,
					5,4,3,
					5,1,4,
				},
			},
		},
--]]
	}

	gl.glEnable(gl.GL_DEPTH_TEST)
	gl.glEnable(gl.GL_CULL_FACE)
end

local triScaleTime = 1
function App:update()
	App.super.update(self)
	gl.glClear(bit.bor(gl.GL_COLOR_BUFFER_BIT, gl.GL_DEPTH_BUFFER_BIT))

	local dt = 5 * (timer.getTime() - triScaleTime)
	self.globj:draw{
		uniforms = {
			triScale = 1 - dt*math.exp(-dt*dt)
				/ (1/math.sqrt(2*math.exp(1)))		-- normalize by suprema
			,
		}
	}
end

function App:event(e)
	if e[0].type == sdl.SDL_EVENT_MOUSE_BUTTON_DOWN then
		triScaleTime = timer.getTime()
	end
	App.super.event(self, e)
end

return App():run()
