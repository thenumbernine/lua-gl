require 'ext.gc'
local ffi = require 'ffi'
local gl = require 'gl'
local GLGet = require 'gl.get'
local assert = require 'ext.assert'


local GLint = ffi.typeof'GLint'
local GLuint_1 = ffi.typeof'GLuint[1]'


local GLQuery = GLGet.behavior()

local glRetQueryObject = GLGet.makeRetLastArg{
	name = 'glGetQueryObjectiv',
	ctype = GLint,
	lookup = {2},
}
local function getGLQueryObject(self, pname)
	return glRetQueryObject(self.id, pname)
end

-- usage:
-- GLQuery:get(target, pname)
-- or if it's an object with a target already bound:
-- queryObj:get(nil, pname)
-- ... I could reverse them so pname comes first since target is optionally bound ... tempting to do that ...
local glRetQuery = GLGet.makeRetLastArg{
	name = 'glGetQueryiv',
	ctype = GLint,
	lookup = {1,2},
}
local function getGLQuery(self, target, pname)
	return glRetQuery(self.target or target, pname)
end

GLQuery:makeGetter{
	vars = {
		-- glGetQueryObject functions
		{name='GL_QUERY_RESULT', getter=getGLQueryObject},
		{name='GL_QUERY_RESULT_AVAILABLE', getter=getGLQueryObject},
		{name='GL_QUERY_RESULT_NO_WAIT', getter=getGLQueryObject},
		{name='GL_QUERY_TARGET', getter=getGLQueryObject},

		-- glGetQuery functions - static methods
		-- if these are static (i.e. not assoc with any object)
		--  then do they belong in gl.global?
		{name='GL_SAMPLES_PASSED', getter=getGLQuery},
		{name='GL_ANY_SAMPLES_PASSED', getter=getGLQuery},
		{name='GL_ANY_SAMPLES_PASSED_CONSERVATIVE GL_PRIMITIVES_GENERATED', getter=getGLQuery},
		{name='GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN', getter=getGLQuery},
		{name='GL_TIME_ELAPSED', getter=getGLQuery},
		{name='or GL_TIMESTAMP', getter=getGLQuery},
	},
}

function GLQuery:init(target)
	local ptr = GLuint_1()
	gl.glGenQueries(1, ptr)
	self.id = ptr[0]

	-- should this even be here, or should we always pass it into functions?
	self.target = target
end

function GLQuery:delete()
	if self.id == nil then return end
	local ptr = GLuint_1(self.id)
	gl.glDeleteQueries(1, ptr)
	self.id = nil
end

GLQuery.__gc = GLQuery.delete

function GLQuery:begin(target)
	gl.glBeginQuery(target or self.target, self.id)
	return self
end

-- static method if target is provide I guess?
function GLQuery:done(target)
	gl.glEndQuery(target or self.target)
	return self
end

function GLQuery:doneWithResult(target)
	self:done(target)
	return self:get'GL_QUERY_RESULT'
end

return GLQuery
