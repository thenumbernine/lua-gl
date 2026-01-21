--[[
for Windows I always have to grab pointers with wglGetProcAddress anyways,
and that means storing them in a new table,
so that means returning a library wrapper that I can modify (instead of a ffi library which I cant and which probably goes a bit faster),
so why not treat our library here like the ffi/libwrapper.lua,
but instead of using ffi.cdef for accessing it, use wglGetProcAddress?
--]]
require 'ext.gc'
local ffi = require 'ffi'
local op = require 'ext.op'
local table = require 'ext.table'
require 'gl.ffi.KHR.khrplatform'
ffi.cdef[[
/* + BEGIN C:/Program Files (x86)/Windows Kits/10/include/10.0.22621.0/um/GL/gl.h */
/* #pragma region Desktop Family */
typedef unsigned int GLenum;
typedef unsigned char GLboolean;
typedef unsigned int GLbitfield;
typedef signed char GLbyte;
typedef short GLshort;
typedef int GLint;
typedef int GLsizei;
typedef unsigned char GLubyte;
typedef unsigned short GLushort;
typedef unsigned int GLuint;
typedef float GLfloat;
typedef float GLclampf;
typedef double GLdouble;
typedef double GLclampd;
typedef void GLvoid;
void glAccum (GLenum op, GLfloat value);
void glAlphaFunc (GLenum func, GLclampf ref);
GLboolean glAreTexturesResident (GLsizei n, const GLuint *textures, GLboolean *residences);
void glArrayElement (GLint i);
void glBegin (GLenum mode);
void glBindTexture (GLenum target, GLuint texture);
void glBitmap (GLsizei width, GLsizei height, GLfloat xorig, GLfloat yorig, GLfloat xmove, GLfloat ymove, const GLubyte *bitmap);
void glBlendFunc (GLenum sfactor, GLenum dfactor);
void glCallList (GLuint list);
void glCallLists (GLsizei n, GLenum type, const GLvoid *lists);
void glClear (GLbitfield mask);
void glClearAccum (GLfloat red, GLfloat green, GLfloat blue, GLfloat alpha);
void glClearColor (GLclampf red, GLclampf green, GLclampf blue, GLclampf alpha);
void glClearDepth (GLclampd depth);
void glClearIndex (GLfloat c);
void glClearStencil (GLint s);
void glClipPlane (GLenum plane, const GLdouble *equation);
void glColor3b (GLbyte red, GLbyte green, GLbyte blue);
void glColor3bv (const GLbyte *v);
void glColor3d (GLdouble red, GLdouble green, GLdouble blue);
void glColor3dv (const GLdouble *v);
void glColor3f (GLfloat red, GLfloat green, GLfloat blue);
void glColor3fv (const GLfloat *v);
void glColor3i (GLint red, GLint green, GLint blue);
void glColor3iv (const GLint *v);
void glColor3s (GLshort red, GLshort green, GLshort blue);
void glColor3sv (const GLshort *v);
void glColor3ub (GLubyte red, GLubyte green, GLubyte blue);
void glColor3ubv (const GLubyte *v);
void glColor3ui (GLuint red, GLuint green, GLuint blue);
void glColor3uiv (const GLuint *v);
void glColor3us (GLushort red, GLushort green, GLushort blue);
void glColor3usv (const GLushort *v);
void glColor4b (GLbyte red, GLbyte green, GLbyte blue, GLbyte alpha);
void glColor4bv (const GLbyte *v);
void glColor4d (GLdouble red, GLdouble green, GLdouble blue, GLdouble alpha);
void glColor4dv (const GLdouble *v);
void glColor4f (GLfloat red, GLfloat green, GLfloat blue, GLfloat alpha);
void glColor4fv (const GLfloat *v);
void glColor4i (GLint red, GLint green, GLint blue, GLint alpha);
void glColor4iv (const GLint *v);
void glColor4s (GLshort red, GLshort green, GLshort blue, GLshort alpha);
void glColor4sv (const GLshort *v);
void glColor4ub (GLubyte red, GLubyte green, GLubyte blue, GLubyte alpha);
void glColor4ubv (const GLubyte *v);
void glColor4ui (GLuint red, GLuint green, GLuint blue, GLuint alpha);
void glColor4uiv (const GLuint *v);
void glColor4us (GLushort red, GLushort green, GLushort blue, GLushort alpha);
void glColor4usv (const GLushort *v);
void glColorMask (GLboolean red, GLboolean green, GLboolean blue, GLboolean alpha);
void glColorMaterial (GLenum face, GLenum mode);
void glColorPointer (GLint size, GLenum type, GLsizei stride, const GLvoid *pointer);
void glCopyPixels (GLint x, GLint y, GLsizei width, GLsizei height, GLenum type);
void glCopyTexImage1D (GLenum target, GLint level, GLenum internalFormat, GLint x, GLint y, GLsizei width, GLint border);
void glCopyTexImage2D (GLenum target, GLint level, GLenum internalFormat, GLint x, GLint y, GLsizei width, GLsizei height, GLint border);
void glCopyTexSubImage1D (GLenum target, GLint level, GLint xoffset, GLint x, GLint y, GLsizei width);
void glCopyTexSubImage2D (GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint x, GLint y, GLsizei width, GLsizei height);
void glCullFace (GLenum mode);
void glDeleteLists (GLuint list, GLsizei range);
void glDeleteTextures (GLsizei n, const GLuint *textures);
void glDepthFunc (GLenum func);
void glDepthMask (GLboolean flag);
void glDepthRange (GLclampd zNear, GLclampd zFar);
void glDisable (GLenum cap);
void glDisableClientState (GLenum array);
void glDrawArrays (GLenum mode, GLint first, GLsizei count);
void glDrawBuffer (GLenum mode);
void glDrawElements (GLenum mode, GLsizei count, GLenum type, const GLvoid *indices);
void glDrawPixels (GLsizei width, GLsizei height, GLenum format, GLenum type, const GLvoid *pixels);
void glEdgeFlag (GLboolean flag);
void glEdgeFlagPointer (GLsizei stride, const GLvoid *pointer);
void glEdgeFlagv (const GLboolean *flag);
void glEnable (GLenum cap);
void glEnableClientState (GLenum array);
void glEnd (void);
void glEndList (void);
void glEvalCoord1d (GLdouble u);
void glEvalCoord1dv (const GLdouble *u);
void glEvalCoord1f (GLfloat u);
void glEvalCoord1fv (const GLfloat *u);
void glEvalCoord2d (GLdouble u, GLdouble v);
void glEvalCoord2dv (const GLdouble *u);
void glEvalCoord2f (GLfloat u, GLfloat v);
void glEvalCoord2fv (const GLfloat *u);
void glEvalMesh1 (GLenum mode, GLint i1, GLint i2);
void glEvalMesh2 (GLenum mode, GLint i1, GLint i2, GLint j1, GLint j2);
void glEvalPoint1 (GLint i);
void glEvalPoint2 (GLint i, GLint j);
void glFeedbackBuffer (GLsizei size, GLenum type, GLfloat *buffer);
void glFinish (void);
void glFlush (void);
void glFogf (GLenum pname, GLfloat param);
void glFogfv (GLenum pname, const GLfloat *params);
void glFogi (GLenum pname, GLint param);
void glFogiv (GLenum pname, const GLint *params);
void glFrontFace (GLenum mode);
void glFrustum (GLdouble left, GLdouble right, GLdouble bottom, GLdouble top, GLdouble zNear, GLdouble zFar);
GLuint glGenLists (GLsizei range);
void glGenTextures (GLsizei n, GLuint *textures);
void glGetBooleanv (GLenum pname, GLboolean *params);
void glGetClipPlane (GLenum plane, GLdouble *equation);
void glGetDoublev (GLenum pname, GLdouble *params);
GLenum glGetError (void);
void glGetFloatv (GLenum pname, GLfloat *params);
void glGetIntegerv (GLenum pname, GLint *params);
void glGetLightfv (GLenum light, GLenum pname, GLfloat *params);
void glGetLightiv (GLenum light, GLenum pname, GLint *params);
void glGetMapdv (GLenum target, GLenum query, GLdouble *v);
void glGetMapfv (GLenum target, GLenum query, GLfloat *v);
void glGetMapiv (GLenum target, GLenum query, GLint *v);
void glGetMaterialfv (GLenum face, GLenum pname, GLfloat *params);
void glGetMaterialiv (GLenum face, GLenum pname, GLint *params);
void glGetPixelMapfv (GLenum map, GLfloat *values);
void glGetPixelMapuiv (GLenum map, GLuint *values);
void glGetPixelMapusv (GLenum map, GLushort *values);
void glGetPointerv (GLenum pname, GLvoid* *params);
void glGetPolygonStipple (GLubyte *mask);
const GLubyte * glGetString (GLenum name);
void glGetTexEnvfv (GLenum target, GLenum pname, GLfloat *params);
void glGetTexEnviv (GLenum target, GLenum pname, GLint *params);
void glGetTexGendv (GLenum coord, GLenum pname, GLdouble *params);
void glGetTexGenfv (GLenum coord, GLenum pname, GLfloat *params);
void glGetTexGeniv (GLenum coord, GLenum pname, GLint *params);
void glGetTexImage (GLenum target, GLint level, GLenum format, GLenum type, GLvoid *pixels);
void glGetTexLevelParameterfv (GLenum target, GLint level, GLenum pname, GLfloat *params);
void glGetTexLevelParameteriv (GLenum target, GLint level, GLenum pname, GLint *params);
void glGetTexParameterfv (GLenum target, GLenum pname, GLfloat *params);
void glGetTexParameteriv (GLenum target, GLenum pname, GLint *params);
void glHint (GLenum target, GLenum mode);
void glIndexMask (GLuint mask);
void glIndexPointer (GLenum type, GLsizei stride, const GLvoid *pointer);
void glIndexd (GLdouble c);
void glIndexdv (const GLdouble *c);
void glIndexf (GLfloat c);
void glIndexfv (const GLfloat *c);
void glIndexi (GLint c);
void glIndexiv (const GLint *c);
void glIndexs (GLshort c);
void glIndexsv (const GLshort *c);
void glIndexub (GLubyte c);
void glIndexubv (const GLubyte *c);
void glInitNames (void);
void glInterleavedArrays (GLenum format, GLsizei stride, const GLvoid *pointer);
GLboolean glIsEnabled (GLenum cap);
GLboolean glIsList (GLuint list);
GLboolean glIsTexture (GLuint texture);
void glLightModelf (GLenum pname, GLfloat param);
void glLightModelfv (GLenum pname, const GLfloat *params);
void glLightModeli (GLenum pname, GLint param);
void glLightModeliv (GLenum pname, const GLint *params);
void glLightf (GLenum light, GLenum pname, GLfloat param);
void glLightfv (GLenum light, GLenum pname, const GLfloat *params);
void glLighti (GLenum light, GLenum pname, GLint param);
void glLightiv (GLenum light, GLenum pname, const GLint *params);
void glLineStipple (GLint factor, GLushort pattern);
void glLineWidth (GLfloat width);
void glListBase (GLuint base);
void glLoadIdentity (void);
void glLoadMatrixd (const GLdouble *m);
void glLoadMatrixf (const GLfloat *m);
void glLoadName (GLuint name);
void glLogicOp (GLenum opcode);
void glMap1d (GLenum target, GLdouble u1, GLdouble u2, GLint stride, GLint order, const GLdouble *points);
void glMap1f (GLenum target, GLfloat u1, GLfloat u2, GLint stride, GLint order, const GLfloat *points);
void glMap2d (GLenum target, GLdouble u1, GLdouble u2, GLint ustride, GLint uorder, GLdouble v1, GLdouble v2, GLint vstride, GLint vorder, const GLdouble *points);
void glMap2f (GLenum target, GLfloat u1, GLfloat u2, GLint ustride, GLint uorder, GLfloat v1, GLfloat v2, GLint vstride, GLint vorder, const GLfloat *points);
void glMapGrid1d (GLint un, GLdouble u1, GLdouble u2);
void glMapGrid1f (GLint un, GLfloat u1, GLfloat u2);
void glMapGrid2d (GLint un, GLdouble u1, GLdouble u2, GLint vn, GLdouble v1, GLdouble v2);
void glMapGrid2f (GLint un, GLfloat u1, GLfloat u2, GLint vn, GLfloat v1, GLfloat v2);
void glMaterialf (GLenum face, GLenum pname, GLfloat param);
void glMaterialfv (GLenum face, GLenum pname, const GLfloat *params);
void glMateriali (GLenum face, GLenum pname, GLint param);
void glMaterialiv (GLenum face, GLenum pname, const GLint *params);
void glMatrixMode (GLenum mode);
void glMultMatrixd (const GLdouble *m);
void glMultMatrixf (const GLfloat *m);
void glNewList (GLuint list, GLenum mode);
void glNormal3b (GLbyte nx, GLbyte ny, GLbyte nz);
void glNormal3bv (const GLbyte *v);
void glNormal3d (GLdouble nx, GLdouble ny, GLdouble nz);
void glNormal3dv (const GLdouble *v);
void glNormal3f (GLfloat nx, GLfloat ny, GLfloat nz);
void glNormal3fv (const GLfloat *v);
void glNormal3i (GLint nx, GLint ny, GLint nz);
void glNormal3iv (const GLint *v);
void glNormal3s (GLshort nx, GLshort ny, GLshort nz);
void glNormal3sv (const GLshort *v);
void glNormalPointer (GLenum type, GLsizei stride, const GLvoid *pointer);
void glOrtho (GLdouble left, GLdouble right, GLdouble bottom, GLdouble top, GLdouble zNear, GLdouble zFar);
void glPassThrough (GLfloat token);
void glPixelMapfv (GLenum map, GLsizei mapsize, const GLfloat *values);
void glPixelMapuiv (GLenum map, GLsizei mapsize, const GLuint *values);
void glPixelMapusv (GLenum map, GLsizei mapsize, const GLushort *values);
void glPixelStoref (GLenum pname, GLfloat param);
void glPixelStorei (GLenum pname, GLint param);
void glPixelTransferf (GLenum pname, GLfloat param);
void glPixelTransferi (GLenum pname, GLint param);
void glPixelZoom (GLfloat xfactor, GLfloat yfactor);
void glPointSize (GLfloat size);
void glPolygonMode (GLenum face, GLenum mode);
void glPolygonOffset (GLfloat factor, GLfloat units);
void glPolygonStipple (const GLubyte *mask);
void glPopAttrib (void);
void glPopClientAttrib (void);
void glPopMatrix (void);
void glPopName (void);
void glPrioritizeTextures (GLsizei n, const GLuint *textures, const GLclampf *priorities);
void glPushAttrib (GLbitfield mask);
void glPushClientAttrib (GLbitfield mask);
void glPushMatrix (void);
void glPushName (GLuint name);
void glRasterPos2d (GLdouble x, GLdouble y);
void glRasterPos2dv (const GLdouble *v);
void glRasterPos2f (GLfloat x, GLfloat y);
void glRasterPos2fv (const GLfloat *v);
void glRasterPos2i (GLint x, GLint y);
void glRasterPos2iv (const GLint *v);
void glRasterPos2s (GLshort x, GLshort y);
void glRasterPos2sv (const GLshort *v);
void glRasterPos3d (GLdouble x, GLdouble y, GLdouble z);
void glRasterPos3dv (const GLdouble *v);
void glRasterPos3f (GLfloat x, GLfloat y, GLfloat z);
void glRasterPos3fv (const GLfloat *v);
void glRasterPos3i (GLint x, GLint y, GLint z);
void glRasterPos3iv (const GLint *v);
void glRasterPos3s (GLshort x, GLshort y, GLshort z);
void glRasterPos3sv (const GLshort *v);
void glRasterPos4d (GLdouble x, GLdouble y, GLdouble z, GLdouble w);
void glRasterPos4dv (const GLdouble *v);
void glRasterPos4f (GLfloat x, GLfloat y, GLfloat z, GLfloat w);
void glRasterPos4fv (const GLfloat *v);
void glRasterPos4i (GLint x, GLint y, GLint z, GLint w);
void glRasterPos4iv (const GLint *v);
void glRasterPos4s (GLshort x, GLshort y, GLshort z, GLshort w);
void glRasterPos4sv (const GLshort *v);
void glReadBuffer (GLenum mode);
void glReadPixels (GLint x, GLint y, GLsizei width, GLsizei height, GLenum format, GLenum type, GLvoid *pixels);
void glRectd (GLdouble x1, GLdouble y1, GLdouble x2, GLdouble y2);
void glRectdv (const GLdouble *v1, const GLdouble *v2);
void glRectf (GLfloat x1, GLfloat y1, GLfloat x2, GLfloat y2);
void glRectfv (const GLfloat *v1, const GLfloat *v2);
void glRecti (GLint x1, GLint y1, GLint x2, GLint y2);
void glRectiv (const GLint *v1, const GLint *v2);
void glRects (GLshort x1, GLshort y1, GLshort x2, GLshort y2);
void glRectsv (const GLshort *v1, const GLshort *v2);
GLint glRenderMode (GLenum mode);
void glRotated (GLdouble angle, GLdouble x, GLdouble y, GLdouble z);
void glRotatef (GLfloat angle, GLfloat x, GLfloat y, GLfloat z);
void glScaled (GLdouble x, GLdouble y, GLdouble z);
void glScalef (GLfloat x, GLfloat y, GLfloat z);
void glScissor (GLint x, GLint y, GLsizei width, GLsizei height);
void glSelectBuffer (GLsizei size, GLuint *buffer);
void glShadeModel (GLenum mode);
void glStencilFunc (GLenum func, GLint ref, GLuint mask);
void glStencilMask (GLuint mask);
void glStencilOp (GLenum fail, GLenum zfail, GLenum zpass);
void glTexCoord1d (GLdouble s);
void glTexCoord1dv (const GLdouble *v);
void glTexCoord1f (GLfloat s);
void glTexCoord1fv (const GLfloat *v);
void glTexCoord1i (GLint s);
void glTexCoord1iv (const GLint *v);
void glTexCoord1s (GLshort s);
void glTexCoord1sv (const GLshort *v);
void glTexCoord2d (GLdouble s, GLdouble t);
void glTexCoord2dv (const GLdouble *v);
void glTexCoord2f (GLfloat s, GLfloat t);
void glTexCoord2fv (const GLfloat *v);
void glTexCoord2i (GLint s, GLint t);
void glTexCoord2iv (const GLint *v);
void glTexCoord2s (GLshort s, GLshort t);
void glTexCoord2sv (const GLshort *v);
void glTexCoord3d (GLdouble s, GLdouble t, GLdouble r);
void glTexCoord3dv (const GLdouble *v);
void glTexCoord3f (GLfloat s, GLfloat t, GLfloat r);
void glTexCoord3fv (const GLfloat *v);
void glTexCoord3i (GLint s, GLint t, GLint r);
void glTexCoord3iv (const GLint *v);
void glTexCoord3s (GLshort s, GLshort t, GLshort r);
void glTexCoord3sv (const GLshort *v);
void glTexCoord4d (GLdouble s, GLdouble t, GLdouble r, GLdouble q);
void glTexCoord4dv (const GLdouble *v);
void glTexCoord4f (GLfloat s, GLfloat t, GLfloat r, GLfloat q);
void glTexCoord4fv (const GLfloat *v);
void glTexCoord4i (GLint s, GLint t, GLint r, GLint q);
void glTexCoord4iv (const GLint *v);
void glTexCoord4s (GLshort s, GLshort t, GLshort r, GLshort q);
void glTexCoord4sv (const GLshort *v);
void glTexCoordPointer (GLint size, GLenum type, GLsizei stride, const GLvoid *pointer);
void glTexEnvf (GLenum target, GLenum pname, GLfloat param);
void glTexEnvfv (GLenum target, GLenum pname, const GLfloat *params);
void glTexEnvi (GLenum target, GLenum pname, GLint param);
void glTexEnviv (GLenum target, GLenum pname, const GLint *params);
void glTexGend (GLenum coord, GLenum pname, GLdouble param);
void glTexGendv (GLenum coord, GLenum pname, const GLdouble *params);
void glTexGenf (GLenum coord, GLenum pname, GLfloat param);
void glTexGenfv (GLenum coord, GLenum pname, const GLfloat *params);
void glTexGeni (GLenum coord, GLenum pname, GLint param);
void glTexGeniv (GLenum coord, GLenum pname, const GLint *params);
void glTexImage1D (GLenum target, GLint level, GLint internalformat, GLsizei width, GLint border, GLenum format, GLenum type, const GLvoid *pixels);
void glTexImage2D (GLenum target, GLint level, GLint internalformat, GLsizei width, GLsizei height, GLint border, GLenum format, GLenum type, const GLvoid *pixels);
void glTexParameterf (GLenum target, GLenum pname, GLfloat param);
void glTexParameterfv (GLenum target, GLenum pname, const GLfloat *params);
void glTexParameteri (GLenum target, GLenum pname, GLint param);
void glTexParameteriv (GLenum target, GLenum pname, const GLint *params);
void glTexSubImage1D (GLenum target, GLint level, GLint xoffset, GLsizei width, GLenum format, GLenum type, const GLvoid *pixels);
void glTexSubImage2D (GLenum target, GLint level, GLint xoffset, GLint yoffset, GLsizei width, GLsizei height, GLenum format, GLenum type, const GLvoid *pixels);
void glTranslated (GLdouble x, GLdouble y, GLdouble z);
void glTranslatef (GLfloat x, GLfloat y, GLfloat z);
void glVertex2d (GLdouble x, GLdouble y);
void glVertex2dv (const GLdouble *v);
void glVertex2f (GLfloat x, GLfloat y);
void glVertex2fv (const GLfloat *v);
void glVertex2i (GLint x, GLint y);
void glVertex2iv (const GLint *v);
void glVertex2s (GLshort x, GLshort y);
void glVertex2sv (const GLshort *v);
void glVertex3d (GLdouble x, GLdouble y, GLdouble z);
void glVertex3dv (const GLdouble *v);
void glVertex3f (GLfloat x, GLfloat y, GLfloat z);
void glVertex3fv (const GLfloat *v);
void glVertex3i (GLint x, GLint y, GLint z);
void glVertex3iv (const GLint *v);
void glVertex3s (GLshort x, GLshort y, GLshort z);
void glVertex3sv (const GLshort *v);
void glVertex4d (GLdouble x, GLdouble y, GLdouble z, GLdouble w);
void glVertex4dv (const GLdouble *v);
void glVertex4f (GLfloat x, GLfloat y, GLfloat z, GLfloat w);
void glVertex4fv (const GLfloat *v);
void glVertex4i (GLint x, GLint y, GLint z, GLint w);
void glVertex4iv (const GLint *v);
void glVertex4s (GLshort x, GLshort y, GLshort z, GLshort w);
void glVertex4sv (const GLshort *v);
void glVertexPointer (GLint size, GLenum type, GLsizei stride, const GLvoid *pointer);
void glViewport (GLint x, GLint y, GLsizei width, GLsizei height);
typedef void ( * PFNGLARRAYELEMENTEXTPROC) (GLint i);
typedef void ( * PFNGLDRAWARRAYSEXTPROC) (GLenum mode, GLint first, GLsizei count);
typedef void ( * PFNGLVERTEXPOINTEREXTPROC) (GLint size, GLenum type, GLsizei stride, GLsizei count, const GLvoid *pointer);
typedef void ( * PFNGLNORMALPOINTEREXTPROC) (GLenum type, GLsizei stride, GLsizei count, const GLvoid *pointer);
typedef void ( * PFNGLCOLORPOINTEREXTPROC) (GLint size, GLenum type, GLsizei stride, GLsizei count, const GLvoid *pointer);
typedef void ( * PFNGLINDEXPOINTEREXTPROC) (GLenum type, GLsizei stride, GLsizei count, const GLvoid *pointer);
typedef void ( * PFNGLTEXCOORDPOINTEREXTPROC) (GLint size, GLenum type, GLsizei stride, GLsizei count, const GLvoid *pointer);
typedef void ( * PFNGLEDGEFLAGPOINTEREXTPROC) (GLsizei stride, GLsizei count, const GLboolean *pointer);
typedef void ( * PFNGLGETPOINTERVEXTPROC) (GLenum pname, GLvoid* *params);
typedef void ( * PFNGLARRAYELEMENTARRAYEXTPROC)(GLenum mode, GLsizei count, const GLvoid* pi);
typedef void ( * PFNGLDRAWRANGEELEMENTSWINPROC) (GLenum mode, GLuint start, GLuint end, GLsizei count, GLenum type, const GLvoid *indices);
typedef void ( * PFNGLADDSWAPHINTRECTWINPROC) (GLint x, GLint y, GLsizei width, GLsizei height);
typedef void ( * PFNGLCOLORTABLEEXTPROC) (GLenum target, GLenum internalFormat, GLsizei width, GLenum format, GLenum type, const GLvoid *data);
typedef void ( * PFNGLCOLORSUBTABLEEXTPROC) (GLenum target, GLsizei start, GLsizei count, GLenum format, GLenum type, const GLvoid *data);
typedef void ( * PFNGLGETCOLORTABLEEXTPROC) (GLenum target, GLenum format, GLenum type, GLvoid *data);
typedef void ( * PFNGLGETCOLORTABLEPARAMETERIVEXTPROC) (GLenum target, GLenum pname, GLint *params);
typedef void ( * PFNGLGETCOLORTABLEPARAMETERFVEXTPROC) (GLenum target, GLenum pname, GLfloat *params);
/* #pragma endregion */
/* + END   C:/Program Files (x86)/Windows Kits/10/include/10.0.22621.0/um/GL/gl.h */
/* + BEGIN C:/Users/Chris/include/GL/glext.h */
/* #define APIENTRYP APIENTRY * ### string, not number "APIENTRY *" */
/* ++ BEGIN C:/Users/Chris/include/KHR/khrplatform.h */
/* ++ END   C:/Users/Chris/include/KHR/khrplatform.h */
typedef void ( * PFNGLDRAWRANGEELEMENTSPROC) (GLenum mode, GLuint start, GLuint end, GLsizei count, GLenum type, const void *indices);
typedef void ( * PFNGLTEXIMAGE3DPROC) (GLenum target, GLint level, GLint internalformat, GLsizei width, GLsizei height, GLsizei depth, GLint border, GLenum format, GLenum type, const void *pixels);
typedef void ( * PFNGLTEXSUBIMAGE3DPROC) (GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth, GLenum format, GLenum type, const void *pixels);
typedef void ( * PFNGLCOPYTEXSUBIMAGE3DPROC) (GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLint x, GLint y, GLsizei width, GLsizei height);
typedef void ( * PFNGLACTIVETEXTUREPROC) (GLenum texture);
typedef void ( * PFNGLSAMPLECOVERAGEPROC) (GLfloat value, GLboolean invert);
typedef void ( * PFNGLCOMPRESSEDTEXIMAGE3DPROC) (GLenum target, GLint level, GLenum internalformat, GLsizei width, GLsizei height, GLsizei depth, GLint border, GLsizei imageSize, const void *data);
typedef void ( * PFNGLCOMPRESSEDTEXIMAGE2DPROC) (GLenum target, GLint level, GLenum internalformat, GLsizei width, GLsizei height, GLint border, GLsizei imageSize, const void *data);
typedef void ( * PFNGLCOMPRESSEDTEXIMAGE1DPROC) (GLenum target, GLint level, GLenum internalformat, GLsizei width, GLint border, GLsizei imageSize, const void *data);
typedef void ( * PFNGLCOMPRESSEDTEXSUBIMAGE3DPROC) (GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth, GLenum format, GLsizei imageSize, const void *data);
typedef void ( * PFNGLCOMPRESSEDTEXSUBIMAGE2DPROC) (GLenum target, GLint level, GLint xoffset, GLint yoffset, GLsizei width, GLsizei height, GLenum format, GLsizei imageSize, const void *data);
typedef void ( * PFNGLCOMPRESSEDTEXSUBIMAGE1DPROC) (GLenum target, GLint level, GLint xoffset, GLsizei width, GLenum format, GLsizei imageSize, const void *data);
typedef void ( * PFNGLGETCOMPRESSEDTEXIMAGEPROC) (GLenum target, GLint level, void *img);
typedef void ( * PFNGLCLIENTACTIVETEXTUREPROC) (GLenum texture);
typedef void ( * PFNGLMULTITEXCOORD1DPROC) (GLenum target, GLdouble s);
typedef void ( * PFNGLMULTITEXCOORD1DVPROC) (GLenum target, const GLdouble *v);
typedef void ( * PFNGLMULTITEXCOORD1FPROC) (GLenum target, GLfloat s);
typedef void ( * PFNGLMULTITEXCOORD1FVPROC) (GLenum target, const GLfloat *v);
typedef void ( * PFNGLMULTITEXCOORD1IPROC) (GLenum target, GLint s);
typedef void ( * PFNGLMULTITEXCOORD1IVPROC) (GLenum target, const GLint *v);
typedef void ( * PFNGLMULTITEXCOORD1SPROC) (GLenum target, GLshort s);
typedef void ( * PFNGLMULTITEXCOORD1SVPROC) (GLenum target, const GLshort *v);
typedef void ( * PFNGLMULTITEXCOORD2DPROC) (GLenum target, GLdouble s, GLdouble t);
typedef void ( * PFNGLMULTITEXCOORD2DVPROC) (GLenum target, const GLdouble *v);
typedef void ( * PFNGLMULTITEXCOORD2FPROC) (GLenum target, GLfloat s, GLfloat t);
typedef void ( * PFNGLMULTITEXCOORD2FVPROC) (GLenum target, const GLfloat *v);
typedef void ( * PFNGLMULTITEXCOORD2IPROC) (GLenum target, GLint s, GLint t);
typedef void ( * PFNGLMULTITEXCOORD2IVPROC) (GLenum target, const GLint *v);
typedef void ( * PFNGLMULTITEXCOORD2SPROC) (GLenum target, GLshort s, GLshort t);
typedef void ( * PFNGLMULTITEXCOORD2SVPROC) (GLenum target, const GLshort *v);
typedef void ( * PFNGLMULTITEXCOORD3DPROC) (GLenum target, GLdouble s, GLdouble t, GLdouble r);
typedef void ( * PFNGLMULTITEXCOORD3DVPROC) (GLenum target, const GLdouble *v);
typedef void ( * PFNGLMULTITEXCOORD3FPROC) (GLenum target, GLfloat s, GLfloat t, GLfloat r);
typedef void ( * PFNGLMULTITEXCOORD3FVPROC) (GLenum target, const GLfloat *v);
typedef void ( * PFNGLMULTITEXCOORD3IPROC) (GLenum target, GLint s, GLint t, GLint r);
typedef void ( * PFNGLMULTITEXCOORD3IVPROC) (GLenum target, const GLint *v);
typedef void ( * PFNGLMULTITEXCOORD3SPROC) (GLenum target, GLshort s, GLshort t, GLshort r);
typedef void ( * PFNGLMULTITEXCOORD3SVPROC) (GLenum target, const GLshort *v);
typedef void ( * PFNGLMULTITEXCOORD4DPROC) (GLenum target, GLdouble s, GLdouble t, GLdouble r, GLdouble q);
typedef void ( * PFNGLMULTITEXCOORD4DVPROC) (GLenum target, const GLdouble *v);
typedef void ( * PFNGLMULTITEXCOORD4FPROC) (GLenum target, GLfloat s, GLfloat t, GLfloat r, GLfloat q);
typedef void ( * PFNGLMULTITEXCOORD4FVPROC) (GLenum target, const GLfloat *v);
typedef void ( * PFNGLMULTITEXCOORD4IPROC) (GLenum target, GLint s, GLint t, GLint r, GLint q);
typedef void ( * PFNGLMULTITEXCOORD4IVPROC) (GLenum target, const GLint *v);
typedef void ( * PFNGLMULTITEXCOORD4SPROC) (GLenum target, GLshort s, GLshort t, GLshort r, GLshort q);
typedef void ( * PFNGLMULTITEXCOORD4SVPROC) (GLenum target, const GLshort *v);
typedef void ( * PFNGLLOADTRANSPOSEMATRIXFPROC) (const GLfloat *m);
typedef void ( * PFNGLLOADTRANSPOSEMATRIXDPROC) (const GLdouble *m);
typedef void ( * PFNGLMULTTRANSPOSEMATRIXFPROC) (const GLfloat *m);
typedef void ( * PFNGLMULTTRANSPOSEMATRIXDPROC) (const GLdouble *m);
typedef void ( * PFNGLBLENDFUNCSEPARATEPROC) (GLenum sfactorRGB, GLenum dfactorRGB, GLenum sfactorAlpha, GLenum dfactorAlpha);
typedef void ( * PFNGLMULTIDRAWARRAYSPROC) (GLenum mode, const GLint *first, const GLsizei *count, GLsizei drawcount);
typedef void ( * PFNGLMULTIDRAWELEMENTSPROC) (GLenum mode, const GLsizei *count, GLenum type, const void *const*indices, GLsizei drawcount);
typedef void ( * PFNGLPOINTPARAMETERFPROC) (GLenum pname, GLfloat param);
typedef void ( * PFNGLPOINTPARAMETERFVPROC) (GLenum pname, const GLfloat *params);
typedef void ( * PFNGLPOINTPARAMETERIPROC) (GLenum pname, GLint param);
typedef void ( * PFNGLPOINTPARAMETERIVPROC) (GLenum pname, const GLint *params);
typedef void ( * PFNGLFOGCOORDFPROC) (GLfloat coord);
typedef void ( * PFNGLFOGCOORDFVPROC) (const GLfloat *coord);
typedef void ( * PFNGLFOGCOORDDPROC) (GLdouble coord);
typedef void ( * PFNGLFOGCOORDDVPROC) (const GLdouble *coord);
typedef void ( * PFNGLFOGCOORDPOINTERPROC) (GLenum type, GLsizei stride, const void *pointer);
typedef void ( * PFNGLSECONDARYCOLOR3BPROC) (GLbyte red, GLbyte green, GLbyte blue);
typedef void ( * PFNGLSECONDARYCOLOR3BVPROC) (const GLbyte *v);
typedef void ( * PFNGLSECONDARYCOLOR3DPROC) (GLdouble red, GLdouble green, GLdouble blue);
typedef void ( * PFNGLSECONDARYCOLOR3DVPROC) (const GLdouble *v);
typedef void ( * PFNGLSECONDARYCOLOR3FPROC) (GLfloat red, GLfloat green, GLfloat blue);
typedef void ( * PFNGLSECONDARYCOLOR3FVPROC) (const GLfloat *v);
typedef void ( * PFNGLSECONDARYCOLOR3IPROC) (GLint red, GLint green, GLint blue);
typedef void ( * PFNGLSECONDARYCOLOR3IVPROC) (const GLint *v);
typedef void ( * PFNGLSECONDARYCOLOR3SPROC) (GLshort red, GLshort green, GLshort blue);
typedef void ( * PFNGLSECONDARYCOLOR3SVPROC) (const GLshort *v);
typedef void ( * PFNGLSECONDARYCOLOR3UBPROC) (GLubyte red, GLubyte green, GLubyte blue);
typedef void ( * PFNGLSECONDARYCOLOR3UBVPROC) (const GLubyte *v);
typedef void ( * PFNGLSECONDARYCOLOR3UIPROC) (GLuint red, GLuint green, GLuint blue);
typedef void ( * PFNGLSECONDARYCOLOR3UIVPROC) (const GLuint *v);
typedef void ( * PFNGLSECONDARYCOLOR3USPROC) (GLushort red, GLushort green, GLushort blue);
typedef void ( * PFNGLSECONDARYCOLOR3USVPROC) (const GLushort *v);
typedef void ( * PFNGLSECONDARYCOLORPOINTERPROC) (GLint size, GLenum type, GLsizei stride, const void *pointer);
typedef void ( * PFNGLWINDOWPOS2DPROC) (GLdouble x, GLdouble y);
typedef void ( * PFNGLWINDOWPOS2DVPROC) (const GLdouble *v);
typedef void ( * PFNGLWINDOWPOS2FPROC) (GLfloat x, GLfloat y);
typedef void ( * PFNGLWINDOWPOS2FVPROC) (const GLfloat *v);
typedef void ( * PFNGLWINDOWPOS2IPROC) (GLint x, GLint y);
typedef void ( * PFNGLWINDOWPOS2IVPROC) (const GLint *v);
typedef void ( * PFNGLWINDOWPOS2SPROC) (GLshort x, GLshort y);
typedef void ( * PFNGLWINDOWPOS2SVPROC) (const GLshort *v);
typedef void ( * PFNGLWINDOWPOS3DPROC) (GLdouble x, GLdouble y, GLdouble z);
typedef void ( * PFNGLWINDOWPOS3DVPROC) (const GLdouble *v);
typedef void ( * PFNGLWINDOWPOS3FPROC) (GLfloat x, GLfloat y, GLfloat z);
typedef void ( * PFNGLWINDOWPOS3FVPROC) (const GLfloat *v);
typedef void ( * PFNGLWINDOWPOS3IPROC) (GLint x, GLint y, GLint z);
typedef void ( * PFNGLWINDOWPOS3IVPROC) (const GLint *v);
typedef void ( * PFNGLWINDOWPOS3SPROC) (GLshort x, GLshort y, GLshort z);
typedef void ( * PFNGLWINDOWPOS3SVPROC) (const GLshort *v);
typedef void ( * PFNGLBLENDCOLORPROC) (GLfloat red, GLfloat green, GLfloat blue, GLfloat alpha);
typedef void ( * PFNGLBLENDEQUATIONPROC) (GLenum mode);
typedef khronos_ssize_t GLsizeiptr;
typedef khronos_intptr_t GLintptr;
typedef void ( * PFNGLGENQUERIESPROC) (GLsizei n, GLuint *ids);
typedef void ( * PFNGLDELETEQUERIESPROC) (GLsizei n, const GLuint *ids);
typedef GLboolean ( * PFNGLISQUERYPROC) (GLuint id);
typedef void ( * PFNGLBEGINQUERYPROC) (GLenum target, GLuint id);
typedef void ( * PFNGLENDQUERYPROC) (GLenum target);
typedef void ( * PFNGLGETQUERYIVPROC) (GLenum target, GLenum pname, GLint *params);
typedef void ( * PFNGLGETQUERYOBJECTIVPROC) (GLuint id, GLenum pname, GLint *params);
typedef void ( * PFNGLGETQUERYOBJECTUIVPROC) (GLuint id, GLenum pname, GLuint *params);
typedef void ( * PFNGLBINDBUFFERPROC) (GLenum target, GLuint buffer);
typedef void ( * PFNGLDELETEBUFFERSPROC) (GLsizei n, const GLuint *buffers);
typedef void ( * PFNGLGENBUFFERSPROC) (GLsizei n, GLuint *buffers);
typedef GLboolean ( * PFNGLISBUFFERPROC) (GLuint buffer);
typedef void ( * PFNGLBUFFERDATAPROC) (GLenum target, GLsizeiptr size, const void *data, GLenum usage);
typedef void ( * PFNGLBUFFERSUBDATAPROC) (GLenum target, GLintptr offset, GLsizeiptr size, const void *data);
typedef void ( * PFNGLGETBUFFERSUBDATAPROC) (GLenum target, GLintptr offset, GLsizeiptr size, void *data);
typedef void *( * PFNGLMAPBUFFERPROC) (GLenum target, GLenum access);
typedef GLboolean ( * PFNGLUNMAPBUFFERPROC) (GLenum target);
typedef void ( * PFNGLGETBUFFERPARAMETERIVPROC) (GLenum target, GLenum pname, GLint *params);
typedef void ( * PFNGLGETBUFFERPOINTERVPROC) (GLenum target, GLenum pname, void **params);
typedef char GLchar;
typedef void ( * PFNGLBLENDEQUATIONSEPARATEPROC) (GLenum modeRGB, GLenum modeAlpha);
typedef void ( * PFNGLDRAWBUFFERSPROC) (GLsizei n, const GLenum *bufs);
typedef void ( * PFNGLSTENCILOPSEPARATEPROC) (GLenum face, GLenum sfail, GLenum dpfail, GLenum dppass);
typedef void ( * PFNGLSTENCILFUNCSEPARATEPROC) (GLenum face, GLenum func, GLint ref, GLuint mask);
typedef void ( * PFNGLSTENCILMASKSEPARATEPROC) (GLenum face, GLuint mask);
typedef void ( * PFNGLATTACHSHADERPROC) (GLuint program, GLuint shader);
typedef void ( * PFNGLBINDATTRIBLOCATIONPROC) (GLuint program, GLuint index, const GLchar *name);
typedef void ( * PFNGLCOMPILESHADERPROC) (GLuint shader);
typedef GLuint ( * PFNGLCREATEPROGRAMPROC) (void);
typedef GLuint ( * PFNGLCREATESHADERPROC) (GLenum type);
typedef void ( * PFNGLDELETEPROGRAMPROC) (GLuint program);
typedef void ( * PFNGLDELETESHADERPROC) (GLuint shader);
typedef void ( * PFNGLDETACHSHADERPROC) (GLuint program, GLuint shader);
typedef void ( * PFNGLDISABLEVERTEXATTRIBARRAYPROC) (GLuint index);
typedef void ( * PFNGLENABLEVERTEXATTRIBARRAYPROC) (GLuint index);
typedef void ( * PFNGLGETACTIVEATTRIBPROC) (GLuint program, GLuint index, GLsizei bufSize, GLsizei *length, GLint *size, GLenum *type, GLchar *name);
typedef void ( * PFNGLGETACTIVEUNIFORMPROC) (GLuint program, GLuint index, GLsizei bufSize, GLsizei *length, GLint *size, GLenum *type, GLchar *name);
typedef void ( * PFNGLGETATTACHEDSHADERSPROC) (GLuint program, GLsizei maxCount, GLsizei *count, GLuint *shaders);
typedef GLint ( * PFNGLGETATTRIBLOCATIONPROC) (GLuint program, const GLchar *name);
typedef void ( * PFNGLGETPROGRAMIVPROC) (GLuint program, GLenum pname, GLint *params);
typedef void ( * PFNGLGETPROGRAMINFOLOGPROC) (GLuint program, GLsizei bufSize, GLsizei *length, GLchar *infoLog);
typedef void ( * PFNGLGETSHADERIVPROC) (GLuint shader, GLenum pname, GLint *params);
typedef void ( * PFNGLGETSHADERINFOLOGPROC) (GLuint shader, GLsizei bufSize, GLsizei *length, GLchar *infoLog);
typedef void ( * PFNGLGETSHADERSOURCEPROC) (GLuint shader, GLsizei bufSize, GLsizei *length, GLchar *source);
typedef GLint ( * PFNGLGETUNIFORMLOCATIONPROC) (GLuint program, const GLchar *name);
typedef void ( * PFNGLGETUNIFORMFVPROC) (GLuint program, GLint location, GLfloat *params);
typedef void ( * PFNGLGETUNIFORMIVPROC) (GLuint program, GLint location, GLint *params);
typedef void ( * PFNGLGETVERTEXATTRIBDVPROC) (GLuint index, GLenum pname, GLdouble *params);
typedef void ( * PFNGLGETVERTEXATTRIBFVPROC) (GLuint index, GLenum pname, GLfloat *params);
typedef void ( * PFNGLGETVERTEXATTRIBIVPROC) (GLuint index, GLenum pname, GLint *params);
typedef void ( * PFNGLGETVERTEXATTRIBPOINTERVPROC) (GLuint index, GLenum pname, void **pointer);
typedef GLboolean ( * PFNGLISPROGRAMPROC) (GLuint program);
typedef GLboolean ( * PFNGLISSHADERPROC) (GLuint shader);
typedef void ( * PFNGLLINKPROGRAMPROC) (GLuint program);
typedef void ( * PFNGLSHADERSOURCEPROC) (GLuint shader, GLsizei count, const GLchar *const*string, const GLint *length);
typedef void ( * PFNGLUSEPROGRAMPROC) (GLuint program);
typedef void ( * PFNGLUNIFORM1FPROC) (GLint location, GLfloat v0);
typedef void ( * PFNGLUNIFORM2FPROC) (GLint location, GLfloat v0, GLfloat v1);
typedef void ( * PFNGLUNIFORM3FPROC) (GLint location, GLfloat v0, GLfloat v1, GLfloat v2);
typedef void ( * PFNGLUNIFORM4FPROC) (GLint location, GLfloat v0, GLfloat v1, GLfloat v2, GLfloat v3);
typedef void ( * PFNGLUNIFORM1IPROC) (GLint location, GLint v0);
typedef void ( * PFNGLUNIFORM2IPROC) (GLint location, GLint v0, GLint v1);
typedef void ( * PFNGLUNIFORM3IPROC) (GLint location, GLint v0, GLint v1, GLint v2);
typedef void ( * PFNGLUNIFORM4IPROC) (GLint location, GLint v0, GLint v1, GLint v2, GLint v3);
typedef void ( * PFNGLUNIFORM1FVPROC) (GLint location, GLsizei count, const GLfloat *value);
typedef void ( * PFNGLUNIFORM2FVPROC) (GLint location, GLsizei count, const GLfloat *value);
typedef void ( * PFNGLUNIFORM3FVPROC) (GLint location, GLsizei count, const GLfloat *value);
typedef void ( * PFNGLUNIFORM4FVPROC) (GLint location, GLsizei count, const GLfloat *value);
typedef void ( * PFNGLUNIFORM1IVPROC) (GLint location, GLsizei count, const GLint *value);
typedef void ( * PFNGLUNIFORM2IVPROC) (GLint location, GLsizei count, const GLint *value);
typedef void ( * PFNGLUNIFORM3IVPROC) (GLint location, GLsizei count, const GLint *value);
typedef void ( * PFNGLUNIFORM4IVPROC) (GLint location, GLsizei count, const GLint *value);
typedef void ( * PFNGLUNIFORMMATRIX2FVPROC) (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
typedef void ( * PFNGLUNIFORMMATRIX3FVPROC) (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
typedef void ( * PFNGLUNIFORMMATRIX4FVPROC) (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
typedef void ( * PFNGLVALIDATEPROGRAMPROC) (GLuint program);
typedef void ( * PFNGLVERTEXATTRIB1DPROC) (GLuint index, GLdouble x);
typedef void ( * PFNGLVERTEXATTRIB1DVPROC) (GLuint index, const GLdouble *v);
typedef void ( * PFNGLVERTEXATTRIB1FPROC) (GLuint index, GLfloat x);
typedef void ( * PFNGLVERTEXATTRIB1FVPROC) (GLuint index, const GLfloat *v);
typedef void ( * PFNGLVERTEXATTRIB1SPROC) (GLuint index, GLshort x);
typedef void ( * PFNGLVERTEXATTRIB1SVPROC) (GLuint index, const GLshort *v);
typedef void ( * PFNGLVERTEXATTRIB2DPROC) (GLuint index, GLdouble x, GLdouble y);
typedef void ( * PFNGLVERTEXATTRIB2DVPROC) (GLuint index, const GLdouble *v);
typedef void ( * PFNGLVERTEXATTRIB2FPROC) (GLuint index, GLfloat x, GLfloat y);
typedef void ( * PFNGLVERTEXATTRIB2FVPROC) (GLuint index, const GLfloat *v);
typedef void ( * PFNGLVERTEXATTRIB2SPROC) (GLuint index, GLshort x, GLshort y);
typedef void ( * PFNGLVERTEXATTRIB2SVPROC) (GLuint index, const GLshort *v);
typedef void ( * PFNGLVERTEXATTRIB3DPROC) (GLuint index, GLdouble x, GLdouble y, GLdouble z);
typedef void ( * PFNGLVERTEXATTRIB3DVPROC) (GLuint index, const GLdouble *v);
typedef void ( * PFNGLVERTEXATTRIB3FPROC) (GLuint index, GLfloat x, GLfloat y, GLfloat z);
typedef void ( * PFNGLVERTEXATTRIB3FVPROC) (GLuint index, const GLfloat *v);
typedef void ( * PFNGLVERTEXATTRIB3SPROC) (GLuint index, GLshort x, GLshort y, GLshort z);
typedef void ( * PFNGLVERTEXATTRIB3SVPROC) (GLuint index, const GLshort *v);
typedef void ( * PFNGLVERTEXATTRIB4NBVPROC) (GLuint index, const GLbyte *v);
typedef void ( * PFNGLVERTEXATTRIB4NIVPROC) (GLuint index, const GLint *v);
typedef void ( * PFNGLVERTEXATTRIB4NSVPROC) (GLuint index, const GLshort *v);
typedef void ( * PFNGLVERTEXATTRIB4NUBPROC) (GLuint index, GLubyte x, GLubyte y, GLubyte z, GLubyte w);
typedef void ( * PFNGLVERTEXATTRIB4NUBVPROC) (GLuint index, const GLubyte *v);
typedef void ( * PFNGLVERTEXATTRIB4NUIVPROC) (GLuint index, const GLuint *v);
typedef void ( * PFNGLVERTEXATTRIB4NUSVPROC) (GLuint index, const GLushort *v);
typedef void ( * PFNGLVERTEXATTRIB4BVPROC) (GLuint index, const GLbyte *v);
typedef void ( * PFNGLVERTEXATTRIB4DPROC) (GLuint index, GLdouble x, GLdouble y, GLdouble z, GLdouble w);
typedef void ( * PFNGLVERTEXATTRIB4DVPROC) (GLuint index, const GLdouble *v);
typedef void ( * PFNGLVERTEXATTRIB4FPROC) (GLuint index, GLfloat x, GLfloat y, GLfloat z, GLfloat w);
typedef void ( * PFNGLVERTEXATTRIB4FVPROC) (GLuint index, const GLfloat *v);
typedef void ( * PFNGLVERTEXATTRIB4IVPROC) (GLuint index, const GLint *v);
typedef void ( * PFNGLVERTEXATTRIB4SPROC) (GLuint index, GLshort x, GLshort y, GLshort z, GLshort w);
typedef void ( * PFNGLVERTEXATTRIB4SVPROC) (GLuint index, const GLshort *v);
typedef void ( * PFNGLVERTEXATTRIB4UBVPROC) (GLuint index, const GLubyte *v);
typedef void ( * PFNGLVERTEXATTRIB4UIVPROC) (GLuint index, const GLuint *v);
typedef void ( * PFNGLVERTEXATTRIB4USVPROC) (GLuint index, const GLushort *v);
typedef void ( * PFNGLVERTEXATTRIBPOINTERPROC) (GLuint index, GLint size, GLenum type, GLboolean normalized, GLsizei stride, const void *pointer);
typedef void ( * PFNGLUNIFORMMATRIX2X3FVPROC) (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
typedef void ( * PFNGLUNIFORMMATRIX3X2FVPROC) (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
typedef void ( * PFNGLUNIFORMMATRIX2X4FVPROC) (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
typedef void ( * PFNGLUNIFORMMATRIX4X2FVPROC) (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
typedef void ( * PFNGLUNIFORMMATRIX3X4FVPROC) (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
typedef void ( * PFNGLUNIFORMMATRIX4X3FVPROC) (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
typedef khronos_uint16_t GLhalf;
typedef void ( * PFNGLCOLORMASKIPROC) (GLuint index, GLboolean r, GLboolean g, GLboolean b, GLboolean a);
typedef void ( * PFNGLGETBOOLEANI_VPROC) (GLenum target, GLuint index, GLboolean *data);
typedef void ( * PFNGLGETINTEGERI_VPROC) (GLenum target, GLuint index, GLint *data);
typedef void ( * PFNGLENABLEIPROC) (GLenum target, GLuint index);
typedef void ( * PFNGLDISABLEIPROC) (GLenum target, GLuint index);
typedef GLboolean ( * PFNGLISENABLEDIPROC) (GLenum target, GLuint index);
typedef void ( * PFNGLBEGINTRANSFORMFEEDBACKPROC) (GLenum primitiveMode);
typedef void ( * PFNGLENDTRANSFORMFEEDBACKPROC) (void);
typedef void ( * PFNGLBINDBUFFERRANGEPROC) (GLenum target, GLuint index, GLuint buffer, GLintptr offset, GLsizeiptr size);
typedef void ( * PFNGLBINDBUFFERBASEPROC) (GLenum target, GLuint index, GLuint buffer);
typedef void ( * PFNGLTRANSFORMFEEDBACKVARYINGSPROC) (GLuint program, GLsizei count, const GLchar *const*varyings, GLenum bufferMode);
typedef void ( * PFNGLGETTRANSFORMFEEDBACKVARYINGPROC) (GLuint program, GLuint index, GLsizei bufSize, GLsizei *length, GLsizei *size, GLenum *type, GLchar *name);
typedef void ( * PFNGLCLAMPCOLORPROC) (GLenum target, GLenum clamp);
typedef void ( * PFNGLBEGINCONDITIONALRENDERPROC) (GLuint id, GLenum mode);
typedef void ( * PFNGLENDCONDITIONALRENDERPROC) (void);
typedef void ( * PFNGLVERTEXATTRIBIPOINTERPROC) (GLuint index, GLint size, GLenum type, GLsizei stride, const void *pointer);
typedef void ( * PFNGLGETVERTEXATTRIBIIVPROC) (GLuint index, GLenum pname, GLint *params);
typedef void ( * PFNGLGETVERTEXATTRIBIUIVPROC) (GLuint index, GLenum pname, GLuint *params);
typedef void ( * PFNGLVERTEXATTRIBI1IPROC) (GLuint index, GLint x);
typedef void ( * PFNGLVERTEXATTRIBI2IPROC) (GLuint index, GLint x, GLint y);
typedef void ( * PFNGLVERTEXATTRIBI3IPROC) (GLuint index, GLint x, GLint y, GLint z);
typedef void ( * PFNGLVERTEXATTRIBI4IPROC) (GLuint index, GLint x, GLint y, GLint z, GLint w);
typedef void ( * PFNGLVERTEXATTRIBI1UIPROC) (GLuint index, GLuint x);
typedef void ( * PFNGLVERTEXATTRIBI2UIPROC) (GLuint index, GLuint x, GLuint y);
typedef void ( * PFNGLVERTEXATTRIBI3UIPROC) (GLuint index, GLuint x, GLuint y, GLuint z);
typedef void ( * PFNGLVERTEXATTRIBI4UIPROC) (GLuint index, GLuint x, GLuint y, GLuint z, GLuint w);
typedef void ( * PFNGLVERTEXATTRIBI1IVPROC) (GLuint index, const GLint *v);
typedef void ( * PFNGLVERTEXATTRIBI2IVPROC) (GLuint index, const GLint *v);
typedef void ( * PFNGLVERTEXATTRIBI3IVPROC) (GLuint index, const GLint *v);
typedef void ( * PFNGLVERTEXATTRIBI4IVPROC) (GLuint index, const GLint *v);
typedef void ( * PFNGLVERTEXATTRIBI1UIVPROC) (GLuint index, const GLuint *v);
typedef void ( * PFNGLVERTEXATTRIBI2UIVPROC) (GLuint index, const GLuint *v);
typedef void ( * PFNGLVERTEXATTRIBI3UIVPROC) (GLuint index, const GLuint *v);
typedef void ( * PFNGLVERTEXATTRIBI4UIVPROC) (GLuint index, const GLuint *v);
typedef void ( * PFNGLVERTEXATTRIBI4BVPROC) (GLuint index, const GLbyte *v);
typedef void ( * PFNGLVERTEXATTRIBI4SVPROC) (GLuint index, const GLshort *v);
typedef void ( * PFNGLVERTEXATTRIBI4UBVPROC) (GLuint index, const GLubyte *v);
typedef void ( * PFNGLVERTEXATTRIBI4USVPROC) (GLuint index, const GLushort *v);
typedef void ( * PFNGLGETUNIFORMUIVPROC) (GLuint program, GLint location, GLuint *params);
typedef void ( * PFNGLBINDFRAGDATALOCATIONPROC) (GLuint program, GLuint color, const GLchar *name);
typedef GLint ( * PFNGLGETFRAGDATALOCATIONPROC) (GLuint program, const GLchar *name);
typedef void ( * PFNGLUNIFORM1UIPROC) (GLint location, GLuint v0);
typedef void ( * PFNGLUNIFORM2UIPROC) (GLint location, GLuint v0, GLuint v1);
typedef void ( * PFNGLUNIFORM3UIPROC) (GLint location, GLuint v0, GLuint v1, GLuint v2);
typedef void ( * PFNGLUNIFORM4UIPROC) (GLint location, GLuint v0, GLuint v1, GLuint v2, GLuint v3);
typedef void ( * PFNGLUNIFORM1UIVPROC) (GLint location, GLsizei count, const GLuint *value);
typedef void ( * PFNGLUNIFORM2UIVPROC) (GLint location, GLsizei count, const GLuint *value);
typedef void ( * PFNGLUNIFORM3UIVPROC) (GLint location, GLsizei count, const GLuint *value);
typedef void ( * PFNGLUNIFORM4UIVPROC) (GLint location, GLsizei count, const GLuint *value);
typedef void ( * PFNGLTEXPARAMETERIIVPROC) (GLenum target, GLenum pname, const GLint *params);
typedef void ( * PFNGLTEXPARAMETERIUIVPROC) (GLenum target, GLenum pname, const GLuint *params);
typedef void ( * PFNGLGETTEXPARAMETERIIVPROC) (GLenum target, GLenum pname, GLint *params);
typedef void ( * PFNGLGETTEXPARAMETERIUIVPROC) (GLenum target, GLenum pname, GLuint *params);
typedef void ( * PFNGLCLEARBUFFERIVPROC) (GLenum buffer, GLint drawbuffer, const GLint *value);
typedef void ( * PFNGLCLEARBUFFERUIVPROC) (GLenum buffer, GLint drawbuffer, const GLuint *value);
typedef void ( * PFNGLCLEARBUFFERFVPROC) (GLenum buffer, GLint drawbuffer, const GLfloat *value);
typedef void ( * PFNGLCLEARBUFFERFIPROC) (GLenum buffer, GLint drawbuffer, GLfloat depth, GLint stencil);
typedef const GLubyte *( * PFNGLGETSTRINGIPROC) (GLenum name, GLuint index);
typedef GLboolean ( * PFNGLISRENDERBUFFERPROC) (GLuint renderbuffer);
typedef void ( * PFNGLBINDRENDERBUFFERPROC) (GLenum target, GLuint renderbuffer);
typedef void ( * PFNGLDELETERENDERBUFFERSPROC) (GLsizei n, const GLuint *renderbuffers);
typedef void ( * PFNGLGENRENDERBUFFERSPROC) (GLsizei n, GLuint *renderbuffers);
typedef void ( * PFNGLRENDERBUFFERSTORAGEPROC) (GLenum target, GLenum internalformat, GLsizei width, GLsizei height);
typedef void ( * PFNGLGETRENDERBUFFERPARAMETERIVPROC) (GLenum target, GLenum pname, GLint *params);
typedef GLboolean ( * PFNGLISFRAMEBUFFERPROC) (GLuint framebuffer);
typedef void ( * PFNGLBINDFRAMEBUFFERPROC) (GLenum target, GLuint framebuffer);
typedef void ( * PFNGLDELETEFRAMEBUFFERSPROC) (GLsizei n, const GLuint *framebuffers);
typedef void ( * PFNGLGENFRAMEBUFFERSPROC) (GLsizei n, GLuint *framebuffers);
typedef GLenum ( * PFNGLCHECKFRAMEBUFFERSTATUSPROC) (GLenum target);
typedef void ( * PFNGLFRAMEBUFFERTEXTURE1DPROC) (GLenum target, GLenum attachment, GLenum textarget, GLuint texture, GLint level);
typedef void ( * PFNGLFRAMEBUFFERTEXTURE2DPROC) (GLenum target, GLenum attachment, GLenum textarget, GLuint texture, GLint level);
typedef void ( * PFNGLFRAMEBUFFERTEXTURE3DPROC) (GLenum target, GLenum attachment, GLenum textarget, GLuint texture, GLint level, GLint zoffset);
typedef void ( * PFNGLFRAMEBUFFERRENDERBUFFERPROC) (GLenum target, GLenum attachment, GLenum renderbuffertarget, GLuint renderbuffer);
typedef void ( * PFNGLGETFRAMEBUFFERATTACHMENTPARAMETERIVPROC) (GLenum target, GLenum attachment, GLenum pname, GLint *params);
typedef void ( * PFNGLGENERATEMIPMAPPROC) (GLenum target);
typedef void ( * PFNGLBLITFRAMEBUFFERPROC) (GLint srcX0, GLint srcY0, GLint srcX1, GLint srcY1, GLint dstX0, GLint dstY0, GLint dstX1, GLint dstY1, GLbitfield mask, GLenum filter);
typedef void ( * PFNGLRENDERBUFFERSTORAGEMULTISAMPLEPROC) (GLenum target, GLsizei samples, GLenum internalformat, GLsizei width, GLsizei height);
typedef void ( * PFNGLFRAMEBUFFERTEXTURELAYERPROC) (GLenum target, GLenum attachment, GLuint texture, GLint level, GLint layer);
typedef void *( * PFNGLMAPBUFFERRANGEPROC) (GLenum target, GLintptr offset, GLsizeiptr length, GLbitfield access);
typedef void ( * PFNGLFLUSHMAPPEDBUFFERRANGEPROC) (GLenum target, GLintptr offset, GLsizeiptr length);
typedef void ( * PFNGLBINDVERTEXARRAYPROC) (GLuint array);
typedef void ( * PFNGLDELETEVERTEXARRAYSPROC) (GLsizei n, const GLuint *arrays);
typedef void ( * PFNGLGENVERTEXARRAYSPROC) (GLsizei n, GLuint *arrays);
typedef GLboolean ( * PFNGLISVERTEXARRAYPROC) (GLuint array);
typedef void ( * PFNGLDRAWARRAYSINSTANCEDPROC) (GLenum mode, GLint first, GLsizei count, GLsizei instancecount);
typedef void ( * PFNGLDRAWELEMENTSINSTANCEDPROC) (GLenum mode, GLsizei count, GLenum type, const void *indices, GLsizei instancecount);
typedef void ( * PFNGLTEXBUFFERPROC) (GLenum target, GLenum internalformat, GLuint buffer);
typedef void ( * PFNGLPRIMITIVERESTARTINDEXPROC) (GLuint index);
typedef void ( * PFNGLCOPYBUFFERSUBDATAPROC) (GLenum readTarget, GLenum writeTarget, GLintptr readOffset, GLintptr writeOffset, GLsizeiptr size);
typedef void ( * PFNGLGETUNIFORMINDICESPROC) (GLuint program, GLsizei uniformCount, const GLchar *const*uniformNames, GLuint *uniformIndices);
typedef void ( * PFNGLGETACTIVEUNIFORMSIVPROC) (GLuint program, GLsizei uniformCount, const GLuint *uniformIndices, GLenum pname, GLint *params);
typedef void ( * PFNGLGETACTIVEUNIFORMNAMEPROC) (GLuint program, GLuint uniformIndex, GLsizei bufSize, GLsizei *length, GLchar *uniformName);
typedef GLuint ( * PFNGLGETUNIFORMBLOCKINDEXPROC) (GLuint program, const GLchar *uniformBlockName);
typedef void ( * PFNGLGETACTIVEUNIFORMBLOCKIVPROC) (GLuint program, GLuint uniformBlockIndex, GLenum pname, GLint *params);
typedef void ( * PFNGLGETACTIVEUNIFORMBLOCKNAMEPROC) (GLuint program, GLuint uniformBlockIndex, GLsizei bufSize, GLsizei *length, GLchar *uniformBlockName);
typedef void ( * PFNGLUNIFORMBLOCKBINDINGPROC) (GLuint program, GLuint uniformBlockIndex, GLuint uniformBlockBinding);
typedef struct __GLsync *GLsync;
typedef khronos_uint64_t GLuint64;
typedef khronos_int64_t GLint64;
/* #define GL_TIMEOUT_IGNORED                0xFFFFFFFFFFFFFFFFull ### string, not number "0xFFFFFFFFFFFFFFFFull" */
typedef void ( * PFNGLDRAWELEMENTSBASEVERTEXPROC) (GLenum mode, GLsizei count, GLenum type, const void *indices, GLint basevertex);
typedef void ( * PFNGLDRAWRANGEELEMENTSBASEVERTEXPROC) (GLenum mode, GLuint start, GLuint end, GLsizei count, GLenum type, const void *indices, GLint basevertex);
typedef void ( * PFNGLDRAWELEMENTSINSTANCEDBASEVERTEXPROC) (GLenum mode, GLsizei count, GLenum type, const void *indices, GLsizei instancecount, GLint basevertex);
typedef void ( * PFNGLMULTIDRAWELEMENTSBASEVERTEXPROC) (GLenum mode, const GLsizei *count, GLenum type, const void *const*indices, GLsizei drawcount, const GLint *basevertex);
typedef void ( * PFNGLPROVOKINGVERTEXPROC) (GLenum mode);
typedef GLsync ( * PFNGLFENCESYNCPROC) (GLenum condition, GLbitfield flags);
typedef GLboolean ( * PFNGLISSYNCPROC) (GLsync sync);
typedef void ( * PFNGLDELETESYNCPROC) (GLsync sync);
typedef GLenum ( * PFNGLCLIENTWAITSYNCPROC) (GLsync sync, GLbitfield flags, GLuint64 timeout);
typedef void ( * PFNGLWAITSYNCPROC) (GLsync sync, GLbitfield flags, GLuint64 timeout);
typedef void ( * PFNGLGETINTEGER64VPROC) (GLenum pname, GLint64 *data);
typedef void ( * PFNGLGETSYNCIVPROC) (GLsync sync, GLenum pname, GLsizei count, GLsizei *length, GLint *values);
typedef void ( * PFNGLGETINTEGER64I_VPROC) (GLenum target, GLuint index, GLint64 *data);
typedef void ( * PFNGLGETBUFFERPARAMETERI64VPROC) (GLenum target, GLenum pname, GLint64 *params);
typedef void ( * PFNGLFRAMEBUFFERTEXTUREPROC) (GLenum target, GLenum attachment, GLuint texture, GLint level);
typedef void ( * PFNGLTEXIMAGE2DMULTISAMPLEPROC) (GLenum target, GLsizei samples, GLenum internalformat, GLsizei width, GLsizei height, GLboolean fixedsamplelocations);
typedef void ( * PFNGLTEXIMAGE3DMULTISAMPLEPROC) (GLenum target, GLsizei samples, GLenum internalformat, GLsizei width, GLsizei height, GLsizei depth, GLboolean fixedsamplelocations);
typedef void ( * PFNGLGETMULTISAMPLEFVPROC) (GLenum pname, GLuint index, GLfloat *val);
typedef void ( * PFNGLSAMPLEMASKIPROC) (GLuint maskNumber, GLbitfield mask);
typedef void ( * PFNGLBINDFRAGDATALOCATIONINDEXEDPROC) (GLuint program, GLuint colorNumber, GLuint index, const GLchar *name);
typedef GLint ( * PFNGLGETFRAGDATAINDEXPROC) (GLuint program, const GLchar *name);
typedef void ( * PFNGLGENSAMPLERSPROC) (GLsizei count, GLuint *samplers);
typedef void ( * PFNGLDELETESAMPLERSPROC) (GLsizei count, const GLuint *samplers);
typedef GLboolean ( * PFNGLISSAMPLERPROC) (GLuint sampler);
typedef void ( * PFNGLBINDSAMPLERPROC) (GLuint unit, GLuint sampler);
typedef void ( * PFNGLSAMPLERPARAMETERIPROC) (GLuint sampler, GLenum pname, GLint param);
typedef void ( * PFNGLSAMPLERPARAMETERIVPROC) (GLuint sampler, GLenum pname, const GLint *param);
typedef void ( * PFNGLSAMPLERPARAMETERFPROC) (GLuint sampler, GLenum pname, GLfloat param);
typedef void ( * PFNGLSAMPLERPARAMETERFVPROC) (GLuint sampler, GLenum pname, const GLfloat *param);
typedef void ( * PFNGLSAMPLERPARAMETERIIVPROC) (GLuint sampler, GLenum pname, const GLint *param);
typedef void ( * PFNGLSAMPLERPARAMETERIUIVPROC) (GLuint sampler, GLenum pname, const GLuint *param);
typedef void ( * PFNGLGETSAMPLERPARAMETERIVPROC) (GLuint sampler, GLenum pname, GLint *params);
typedef void ( * PFNGLGETSAMPLERPARAMETERIIVPROC) (GLuint sampler, GLenum pname, GLint *params);
typedef void ( * PFNGLGETSAMPLERPARAMETERFVPROC) (GLuint sampler, GLenum pname, GLfloat *params);
typedef void ( * PFNGLGETSAMPLERPARAMETERIUIVPROC) (GLuint sampler, GLenum pname, GLuint *params);
typedef void ( * PFNGLQUERYCOUNTERPROC) (GLuint id, GLenum target);
typedef void ( * PFNGLGETQUERYOBJECTI64VPROC) (GLuint id, GLenum pname, GLint64 *params);
typedef void ( * PFNGLGETQUERYOBJECTUI64VPROC) (GLuint id, GLenum pname, GLuint64 *params);
typedef void ( * PFNGLVERTEXATTRIBDIVISORPROC) (GLuint index, GLuint divisor);
typedef void ( * PFNGLVERTEXATTRIBP1UIPROC) (GLuint index, GLenum type, GLboolean normalized, GLuint value);
typedef void ( * PFNGLVERTEXATTRIBP1UIVPROC) (GLuint index, GLenum type, GLboolean normalized, const GLuint *value);
typedef void ( * PFNGLVERTEXATTRIBP2UIPROC) (GLuint index, GLenum type, GLboolean normalized, GLuint value);
typedef void ( * PFNGLVERTEXATTRIBP2UIVPROC) (GLuint index, GLenum type, GLboolean normalized, const GLuint *value);
typedef void ( * PFNGLVERTEXATTRIBP3UIPROC) (GLuint index, GLenum type, GLboolean normalized, GLuint value);
typedef void ( * PFNGLVERTEXATTRIBP3UIVPROC) (GLuint index, GLenum type, GLboolean normalized, const GLuint *value);
typedef void ( * PFNGLVERTEXATTRIBP4UIPROC) (GLuint index, GLenum type, GLboolean normalized, GLuint value);
typedef void ( * PFNGLVERTEXATTRIBP4UIVPROC) (GLuint index, GLenum type, GLboolean normalized, const GLuint *value);
typedef void ( * PFNGLVERTEXP2UIPROC) (GLenum type, GLuint value);
typedef void ( * PFNGLVERTEXP2UIVPROC) (GLenum type, const GLuint *value);
typedef void ( * PFNGLVERTEXP3UIPROC) (GLenum type, GLuint value);
typedef void ( * PFNGLVERTEXP3UIVPROC) (GLenum type, const GLuint *value);
typedef void ( * PFNGLVERTEXP4UIPROC) (GLenum type, GLuint value);
typedef void ( * PFNGLVERTEXP4UIVPROC) (GLenum type, const GLuint *value);
typedef void ( * PFNGLTEXCOORDP1UIPROC) (GLenum type, GLuint coords);
typedef void ( * PFNGLTEXCOORDP1UIVPROC) (GLenum type, const GLuint *coords);
typedef void ( * PFNGLTEXCOORDP2UIPROC) (GLenum type, GLuint coords);
typedef void ( * PFNGLTEXCOORDP2UIVPROC) (GLenum type, const GLuint *coords);
typedef void ( * PFNGLTEXCOORDP3UIPROC) (GLenum type, GLuint coords);
typedef void ( * PFNGLTEXCOORDP3UIVPROC) (GLenum type, const GLuint *coords);
typedef void ( * PFNGLTEXCOORDP4UIPROC) (GLenum type, GLuint coords);
typedef void ( * PFNGLTEXCOORDP4UIVPROC) (GLenum type, const GLuint *coords);
typedef void ( * PFNGLMULTITEXCOORDP1UIPROC) (GLenum texture, GLenum type, GLuint coords);
typedef void ( * PFNGLMULTITEXCOORDP1UIVPROC) (GLenum texture, GLenum type, const GLuint *coords);
typedef void ( * PFNGLMULTITEXCOORDP2UIPROC) (GLenum texture, GLenum type, GLuint coords);
typedef void ( * PFNGLMULTITEXCOORDP2UIVPROC) (GLenum texture, GLenum type, const GLuint *coords);
typedef void ( * PFNGLMULTITEXCOORDP3UIPROC) (GLenum texture, GLenum type, GLuint coords);
typedef void ( * PFNGLMULTITEXCOORDP3UIVPROC) (GLenum texture, GLenum type, const GLuint *coords);
typedef void ( * PFNGLMULTITEXCOORDP4UIPROC) (GLenum texture, GLenum type, GLuint coords);
typedef void ( * PFNGLMULTITEXCOORDP4UIVPROC) (GLenum texture, GLenum type, const GLuint *coords);
typedef void ( * PFNGLNORMALP3UIPROC) (GLenum type, GLuint coords);
typedef void ( * PFNGLNORMALP3UIVPROC) (GLenum type, const GLuint *coords);
typedef void ( * PFNGLCOLORP3UIPROC) (GLenum type, GLuint color);
typedef void ( * PFNGLCOLORP3UIVPROC) (GLenum type, const GLuint *color);
typedef void ( * PFNGLCOLORP4UIPROC) (GLenum type, GLuint color);
typedef void ( * PFNGLCOLORP4UIVPROC) (GLenum type, const GLuint *color);
typedef void ( * PFNGLSECONDARYCOLORP3UIPROC) (GLenum type, GLuint color);
typedef void ( * PFNGLSECONDARYCOLORP3UIVPROC) (GLenum type, const GLuint *color);
typedef void ( * PFNGLMINSAMPLESHADINGPROC) (GLfloat value);
typedef void ( * PFNGLBLENDEQUATIONIPROC) (GLuint buf, GLenum mode);
typedef void ( * PFNGLBLENDEQUATIONSEPARATEIPROC) (GLuint buf, GLenum modeRGB, GLenum modeAlpha);
typedef void ( * PFNGLBLENDFUNCIPROC) (GLuint buf, GLenum src, GLenum dst);
typedef void ( * PFNGLBLENDFUNCSEPARATEIPROC) (GLuint buf, GLenum srcRGB, GLenum dstRGB, GLenum srcAlpha, GLenum dstAlpha);
typedef void ( * PFNGLDRAWARRAYSINDIRECTPROC) (GLenum mode, const void *indirect);
typedef void ( * PFNGLDRAWELEMENTSINDIRECTPROC) (GLenum mode, GLenum type, const void *indirect);
typedef void ( * PFNGLUNIFORM1DPROC) (GLint location, GLdouble x);
typedef void ( * PFNGLUNIFORM2DPROC) (GLint location, GLdouble x, GLdouble y);
typedef void ( * PFNGLUNIFORM3DPROC) (GLint location, GLdouble x, GLdouble y, GLdouble z);
typedef void ( * PFNGLUNIFORM4DPROC) (GLint location, GLdouble x, GLdouble y, GLdouble z, GLdouble w);
typedef void ( * PFNGLUNIFORM1DVPROC) (GLint location, GLsizei count, const GLdouble *value);
typedef void ( * PFNGLUNIFORM2DVPROC) (GLint location, GLsizei count, const GLdouble *value);
typedef void ( * PFNGLUNIFORM3DVPROC) (GLint location, GLsizei count, const GLdouble *value);
typedef void ( * PFNGLUNIFORM4DVPROC) (GLint location, GLsizei count, const GLdouble *value);
typedef void ( * PFNGLUNIFORMMATRIX2DVPROC) (GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
typedef void ( * PFNGLUNIFORMMATRIX3DVPROC) (GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
typedef void ( * PFNGLUNIFORMMATRIX4DVPROC) (GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
typedef void ( * PFNGLUNIFORMMATRIX2X3DVPROC) (GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
typedef void ( * PFNGLUNIFORMMATRIX2X4DVPROC) (GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
typedef void ( * PFNGLUNIFORMMATRIX3X2DVPROC) (GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
typedef void ( * PFNGLUNIFORMMATRIX3X4DVPROC) (GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
typedef void ( * PFNGLUNIFORMMATRIX4X2DVPROC) (GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
typedef void ( * PFNGLUNIFORMMATRIX4X3DVPROC) (GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
typedef void ( * PFNGLGETUNIFORMDVPROC) (GLuint program, GLint location, GLdouble *params);
typedef GLint ( * PFNGLGETSUBROUTINEUNIFORMLOCATIONPROC) (GLuint program, GLenum shadertype, const GLchar *name);
typedef GLuint ( * PFNGLGETSUBROUTINEINDEXPROC) (GLuint program, GLenum shadertype, const GLchar *name);
typedef void ( * PFNGLGETACTIVESUBROUTINEUNIFORMIVPROC) (GLuint program, GLenum shadertype, GLuint index, GLenum pname, GLint *values);
typedef void ( * PFNGLGETACTIVESUBROUTINEUNIFORMNAMEPROC) (GLuint program, GLenum shadertype, GLuint index, GLsizei bufSize, GLsizei *length, GLchar *name);
typedef void ( * PFNGLGETACTIVESUBROUTINENAMEPROC) (GLuint program, GLenum shadertype, GLuint index, GLsizei bufSize, GLsizei *length, GLchar *name);
typedef void ( * PFNGLUNIFORMSUBROUTINESUIVPROC) (GLenum shadertype, GLsizei count, const GLuint *indices);
typedef void ( * PFNGLGETUNIFORMSUBROUTINEUIVPROC) (GLenum shadertype, GLint location, GLuint *params);
typedef void ( * PFNGLGETPROGRAMSTAGEIVPROC) (GLuint program, GLenum shadertype, GLenum pname, GLint *values);
typedef void ( * PFNGLPATCHPARAMETERIPROC) (GLenum pname, GLint value);
typedef void ( * PFNGLPATCHPARAMETERFVPROC) (GLenum pname, const GLfloat *values);
typedef void ( * PFNGLBINDTRANSFORMFEEDBACKPROC) (GLenum target, GLuint id);
typedef void ( * PFNGLDELETETRANSFORMFEEDBACKSPROC) (GLsizei n, const GLuint *ids);
typedef void ( * PFNGLGENTRANSFORMFEEDBACKSPROC) (GLsizei n, GLuint *ids);
typedef GLboolean ( * PFNGLISTRANSFORMFEEDBACKPROC) (GLuint id);
typedef void ( * PFNGLPAUSETRANSFORMFEEDBACKPROC) (void);
typedef void ( * PFNGLRESUMETRANSFORMFEEDBACKPROC) (void);
typedef void ( * PFNGLDRAWTRANSFORMFEEDBACKPROC) (GLenum mode, GLuint id);
typedef void ( * PFNGLDRAWTRANSFORMFEEDBACKSTREAMPROC) (GLenum mode, GLuint id, GLuint stream);
typedef void ( * PFNGLBEGINQUERYINDEXEDPROC) (GLenum target, GLuint index, GLuint id);
typedef void ( * PFNGLENDQUERYINDEXEDPROC) (GLenum target, GLuint index);
typedef void ( * PFNGLGETQUERYINDEXEDIVPROC) (GLenum target, GLuint index, GLenum pname, GLint *params);
typedef void ( * PFNGLRELEASESHADERCOMPILERPROC) (void);
typedef void ( * PFNGLSHADERBINARYPROC) (GLsizei count, const GLuint *shaders, GLenum binaryFormat, const void *binary, GLsizei length);
typedef void ( * PFNGLGETSHADERPRECISIONFORMATPROC) (GLenum shadertype, GLenum precisiontype, GLint *range, GLint *precision);
typedef void ( * PFNGLDEPTHRANGEFPROC) (GLfloat n, GLfloat f);
typedef void ( * PFNGLCLEARDEPTHFPROC) (GLfloat d);
typedef void ( * PFNGLGETPROGRAMBINARYPROC) (GLuint program, GLsizei bufSize, GLsizei *length, GLenum *binaryFormat, void *binary);
typedef void ( * PFNGLPROGRAMBINARYPROC) (GLuint program, GLenum binaryFormat, const void *binary, GLsizei length);
typedef void ( * PFNGLPROGRAMPARAMETERIPROC) (GLuint program, GLenum pname, GLint value);
typedef void ( * PFNGLUSEPROGRAMSTAGESPROC) (GLuint pipeline, GLbitfield stages, GLuint program);
typedef void ( * PFNGLACTIVESHADERPROGRAMPROC) (GLuint pipeline, GLuint program);
typedef GLuint ( * PFNGLCREATESHADERPROGRAMVPROC) (GLenum type, GLsizei count, const GLchar *const*strings);
typedef void ( * PFNGLBINDPROGRAMPIPELINEPROC) (GLuint pipeline);
typedef void ( * PFNGLDELETEPROGRAMPIPELINESPROC) (GLsizei n, const GLuint *pipelines);
typedef void ( * PFNGLGENPROGRAMPIPELINESPROC) (GLsizei n, GLuint *pipelines);
typedef GLboolean ( * PFNGLISPROGRAMPIPELINEPROC) (GLuint pipeline);
typedef void ( * PFNGLGETPROGRAMPIPELINEIVPROC) (GLuint pipeline, GLenum pname, GLint *params);
typedef void ( * PFNGLPROGRAMUNIFORM1IPROC) (GLuint program, GLint location, GLint v0);
typedef void ( * PFNGLPROGRAMUNIFORM1IVPROC) (GLuint program, GLint location, GLsizei count, const GLint *value);
typedef void ( * PFNGLPROGRAMUNIFORM1FPROC) (GLuint program, GLint location, GLfloat v0);
typedef void ( * PFNGLPROGRAMUNIFORM1FVPROC) (GLuint program, GLint location, GLsizei count, const GLfloat *value);
typedef void ( * PFNGLPROGRAMUNIFORM1DPROC) (GLuint program, GLint location, GLdouble v0);
typedef void ( * PFNGLPROGRAMUNIFORM1DVPROC) (GLuint program, GLint location, GLsizei count, const GLdouble *value);
typedef void ( * PFNGLPROGRAMUNIFORM1UIPROC) (GLuint program, GLint location, GLuint v0);
typedef void ( * PFNGLPROGRAMUNIFORM1UIVPROC) (GLuint program, GLint location, GLsizei count, const GLuint *value);
typedef void ( * PFNGLPROGRAMUNIFORM2IPROC) (GLuint program, GLint location, GLint v0, GLint v1);
typedef void ( * PFNGLPROGRAMUNIFORM2IVPROC) (GLuint program, GLint location, GLsizei count, const GLint *value);
typedef void ( * PFNGLPROGRAMUNIFORM2FPROC) (GLuint program, GLint location, GLfloat v0, GLfloat v1);
typedef void ( * PFNGLPROGRAMUNIFORM2FVPROC) (GLuint program, GLint location, GLsizei count, const GLfloat *value);
typedef void ( * PFNGLPROGRAMUNIFORM2DPROC) (GLuint program, GLint location, GLdouble v0, GLdouble v1);
typedef void ( * PFNGLPROGRAMUNIFORM2DVPROC) (GLuint program, GLint location, GLsizei count, const GLdouble *value);
typedef void ( * PFNGLPROGRAMUNIFORM2UIPROC) (GLuint program, GLint location, GLuint v0, GLuint v1);
typedef void ( * PFNGLPROGRAMUNIFORM2UIVPROC) (GLuint program, GLint location, GLsizei count, const GLuint *value);
typedef void ( * PFNGLPROGRAMUNIFORM3IPROC) (GLuint program, GLint location, GLint v0, GLint v1, GLint v2);
typedef void ( * PFNGLPROGRAMUNIFORM3IVPROC) (GLuint program, GLint location, GLsizei count, const GLint *value);
typedef void ( * PFNGLPROGRAMUNIFORM3FPROC) (GLuint program, GLint location, GLfloat v0, GLfloat v1, GLfloat v2);
typedef void ( * PFNGLPROGRAMUNIFORM3FVPROC) (GLuint program, GLint location, GLsizei count, const GLfloat *value);
typedef void ( * PFNGLPROGRAMUNIFORM3DPROC) (GLuint program, GLint location, GLdouble v0, GLdouble v1, GLdouble v2);
typedef void ( * PFNGLPROGRAMUNIFORM3DVPROC) (GLuint program, GLint location, GLsizei count, const GLdouble *value);
typedef void ( * PFNGLPROGRAMUNIFORM3UIPROC) (GLuint program, GLint location, GLuint v0, GLuint v1, GLuint v2);
typedef void ( * PFNGLPROGRAMUNIFORM3UIVPROC) (GLuint program, GLint location, GLsizei count, const GLuint *value);
typedef void ( * PFNGLPROGRAMUNIFORM4IPROC) (GLuint program, GLint location, GLint v0, GLint v1, GLint v2, GLint v3);
typedef void ( * PFNGLPROGRAMUNIFORM4IVPROC) (GLuint program, GLint location, GLsizei count, const GLint *value);
typedef void ( * PFNGLPROGRAMUNIFORM4FPROC) (GLuint program, GLint location, GLfloat v0, GLfloat v1, GLfloat v2, GLfloat v3);
typedef void ( * PFNGLPROGRAMUNIFORM4FVPROC) (GLuint program, GLint location, GLsizei count, const GLfloat *value);
typedef void ( * PFNGLPROGRAMUNIFORM4DPROC) (GLuint program, GLint location, GLdouble v0, GLdouble v1, GLdouble v2, GLdouble v3);
typedef void ( * PFNGLPROGRAMUNIFORM4DVPROC) (GLuint program, GLint location, GLsizei count, const GLdouble *value);
typedef void ( * PFNGLPROGRAMUNIFORM4UIPROC) (GLuint program, GLint location, GLuint v0, GLuint v1, GLuint v2, GLuint v3);
typedef void ( * PFNGLPROGRAMUNIFORM4UIVPROC) (GLuint program, GLint location, GLsizei count, const GLuint *value);
typedef void ( * PFNGLPROGRAMUNIFORMMATRIX2FVPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
typedef void ( * PFNGLPROGRAMUNIFORMMATRIX3FVPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
typedef void ( * PFNGLPROGRAMUNIFORMMATRIX4FVPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
typedef void ( * PFNGLPROGRAMUNIFORMMATRIX2DVPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
typedef void ( * PFNGLPROGRAMUNIFORMMATRIX3DVPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
typedef void ( * PFNGLPROGRAMUNIFORMMATRIX4DVPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
typedef void ( * PFNGLPROGRAMUNIFORMMATRIX2X3FVPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
typedef void ( * PFNGLPROGRAMUNIFORMMATRIX3X2FVPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
typedef void ( * PFNGLPROGRAMUNIFORMMATRIX2X4FVPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
typedef void ( * PFNGLPROGRAMUNIFORMMATRIX4X2FVPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
typedef void ( * PFNGLPROGRAMUNIFORMMATRIX3X4FVPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
typedef void ( * PFNGLPROGRAMUNIFORMMATRIX4X3FVPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
typedef void ( * PFNGLPROGRAMUNIFORMMATRIX2X3DVPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
typedef void ( * PFNGLPROGRAMUNIFORMMATRIX3X2DVPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
typedef void ( * PFNGLPROGRAMUNIFORMMATRIX2X4DVPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
typedef void ( * PFNGLPROGRAMUNIFORMMATRIX4X2DVPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
typedef void ( * PFNGLPROGRAMUNIFORMMATRIX3X4DVPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
typedef void ( * PFNGLPROGRAMUNIFORMMATRIX4X3DVPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
typedef void ( * PFNGLVALIDATEPROGRAMPIPELINEPROC) (GLuint pipeline);
typedef void ( * PFNGLGETPROGRAMPIPELINEINFOLOGPROC) (GLuint pipeline, GLsizei bufSize, GLsizei *length, GLchar *infoLog);
typedef void ( * PFNGLVERTEXATTRIBL1DPROC) (GLuint index, GLdouble x);
typedef void ( * PFNGLVERTEXATTRIBL2DPROC) (GLuint index, GLdouble x, GLdouble y);
typedef void ( * PFNGLVERTEXATTRIBL3DPROC) (GLuint index, GLdouble x, GLdouble y, GLdouble z);
typedef void ( * PFNGLVERTEXATTRIBL4DPROC) (GLuint index, GLdouble x, GLdouble y, GLdouble z, GLdouble w);
typedef void ( * PFNGLVERTEXATTRIBL1DVPROC) (GLuint index, const GLdouble *v);
typedef void ( * PFNGLVERTEXATTRIBL2DVPROC) (GLuint index, const GLdouble *v);
typedef void ( * PFNGLVERTEXATTRIBL3DVPROC) (GLuint index, const GLdouble *v);
typedef void ( * PFNGLVERTEXATTRIBL4DVPROC) (GLuint index, const GLdouble *v);
typedef void ( * PFNGLVERTEXATTRIBLPOINTERPROC) (GLuint index, GLint size, GLenum type, GLsizei stride, const void *pointer);
typedef void ( * PFNGLGETVERTEXATTRIBLDVPROC) (GLuint index, GLenum pname, GLdouble *params);
typedef void ( * PFNGLVIEWPORTARRAYVPROC) (GLuint first, GLsizei count, const GLfloat *v);
typedef void ( * PFNGLVIEWPORTINDEXEDFPROC) (GLuint index, GLfloat x, GLfloat y, GLfloat w, GLfloat h);
typedef void ( * PFNGLVIEWPORTINDEXEDFVPROC) (GLuint index, const GLfloat *v);
typedef void ( * PFNGLSCISSORARRAYVPROC) (GLuint first, GLsizei count, const GLint *v);
typedef void ( * PFNGLSCISSORINDEXEDPROC) (GLuint index, GLint left, GLint bottom, GLsizei width, GLsizei height);
typedef void ( * PFNGLSCISSORINDEXEDVPROC) (GLuint index, const GLint *v);
typedef void ( * PFNGLDEPTHRANGEARRAYVPROC) (GLuint first, GLsizei count, const GLdouble *v);
typedef void ( * PFNGLDEPTHRANGEINDEXEDPROC) (GLuint index, GLdouble n, GLdouble f);
typedef void ( * PFNGLGETFLOATI_VPROC) (GLenum target, GLuint index, GLfloat *data);
typedef void ( * PFNGLGETDOUBLEI_VPROC) (GLenum target, GLuint index, GLdouble *data);
typedef void ( * PFNGLDRAWARRAYSINSTANCEDBASEINSTANCEPROC) (GLenum mode, GLint first, GLsizei count, GLsizei instancecount, GLuint baseinstance);
typedef void ( * PFNGLDRAWELEMENTSINSTANCEDBASEINSTANCEPROC) (GLenum mode, GLsizei count, GLenum type, const void *indices, GLsizei instancecount, GLuint baseinstance);
typedef void ( * PFNGLDRAWELEMENTSINSTANCEDBASEVERTEXBASEINSTANCEPROC) (GLenum mode, GLsizei count, GLenum type, const void *indices, GLsizei instancecount, GLint basevertex, GLuint baseinstance);
typedef void ( * PFNGLGETINTERNALFORMATIVPROC) (GLenum target, GLenum internalformat, GLenum pname, GLsizei count, GLint *params);
typedef void ( * PFNGLGETACTIVEATOMICCOUNTERBUFFERIVPROC) (GLuint program, GLuint bufferIndex, GLenum pname, GLint *params);
typedef void ( * PFNGLBINDIMAGETEXTUREPROC) (GLuint unit, GLuint texture, GLint level, GLboolean layered, GLint layer, GLenum access, GLenum format);
typedef void ( * PFNGLMEMORYBARRIERPROC) (GLbitfield barriers);
typedef void ( * PFNGLTEXSTORAGE1DPROC) (GLenum target, GLsizei levels, GLenum internalformat, GLsizei width);
typedef void ( * PFNGLTEXSTORAGE2DPROC) (GLenum target, GLsizei levels, GLenum internalformat, GLsizei width, GLsizei height);
typedef void ( * PFNGLTEXSTORAGE3DPROC) (GLenum target, GLsizei levels, GLenum internalformat, GLsizei width, GLsizei height, GLsizei depth);
typedef void ( * PFNGLDRAWTRANSFORMFEEDBACKINSTANCEDPROC) (GLenum mode, GLuint id, GLsizei instancecount);
typedef void ( * PFNGLDRAWTRANSFORMFEEDBACKSTREAMINSTANCEDPROC) (GLenum mode, GLuint id, GLuint stream, GLsizei instancecount);
typedef void ( *GLDEBUGPROC)(GLenum source,GLenum type,GLuint id,GLenum severity,GLsizei length,const GLchar *message,const void *userParam);
typedef void ( * PFNGLCLEARBUFFERDATAPROC) (GLenum target, GLenum internalformat, GLenum format, GLenum type, const void *data);
typedef void ( * PFNGLCLEARBUFFERSUBDATAPROC) (GLenum target, GLenum internalformat, GLintptr offset, GLsizeiptr size, GLenum format, GLenum type, const void *data);
typedef void ( * PFNGLDISPATCHCOMPUTEPROC) (GLuint num_groups_x, GLuint num_groups_y, GLuint num_groups_z);
typedef void ( * PFNGLDISPATCHCOMPUTEINDIRECTPROC) (GLintptr indirect);
typedef void ( * PFNGLCOPYIMAGESUBDATAPROC) (GLuint srcName, GLenum srcTarget, GLint srcLevel, GLint srcX, GLint srcY, GLint srcZ, GLuint dstName, GLenum dstTarget, GLint dstLevel, GLint dstX, GLint dstY, GLint dstZ, GLsizei srcWidth, GLsizei srcHeight, GLsizei srcDepth);
typedef void ( * PFNGLFRAMEBUFFERPARAMETERIPROC) (GLenum target, GLenum pname, GLint param);
typedef void ( * PFNGLGETFRAMEBUFFERPARAMETERIVPROC) (GLenum target, GLenum pname, GLint *params);
typedef void ( * PFNGLGETINTERNALFORMATI64VPROC) (GLenum target, GLenum internalformat, GLenum pname, GLsizei count, GLint64 *params);
typedef void ( * PFNGLINVALIDATETEXSUBIMAGEPROC) (GLuint texture, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth);
typedef void ( * PFNGLINVALIDATETEXIMAGEPROC) (GLuint texture, GLint level);
typedef void ( * PFNGLINVALIDATEBUFFERSUBDATAPROC) (GLuint buffer, GLintptr offset, GLsizeiptr length);
typedef void ( * PFNGLINVALIDATEBUFFERDATAPROC) (GLuint buffer);
typedef void ( * PFNGLINVALIDATEFRAMEBUFFERPROC) (GLenum target, GLsizei numAttachments, const GLenum *attachments);
typedef void ( * PFNGLINVALIDATESUBFRAMEBUFFERPROC) (GLenum target, GLsizei numAttachments, const GLenum *attachments, GLint x, GLint y, GLsizei width, GLsizei height);
typedef void ( * PFNGLMULTIDRAWARRAYSINDIRECTPROC) (GLenum mode, const void *indirect, GLsizei drawcount, GLsizei stride);
typedef void ( * PFNGLMULTIDRAWELEMENTSINDIRECTPROC) (GLenum mode, GLenum type, const void *indirect, GLsizei drawcount, GLsizei stride);
typedef void ( * PFNGLGETPROGRAMINTERFACEIVPROC) (GLuint program, GLenum programInterface, GLenum pname, GLint *params);
typedef GLuint ( * PFNGLGETPROGRAMRESOURCEINDEXPROC) (GLuint program, GLenum programInterface, const GLchar *name);
typedef void ( * PFNGLGETPROGRAMRESOURCENAMEPROC) (GLuint program, GLenum programInterface, GLuint index, GLsizei bufSize, GLsizei *length, GLchar *name);
typedef void ( * PFNGLGETPROGRAMRESOURCEIVPROC) (GLuint program, GLenum programInterface, GLuint index, GLsizei propCount, const GLenum *props, GLsizei count, GLsizei *length, GLint *params);
typedef GLint ( * PFNGLGETPROGRAMRESOURCELOCATIONPROC) (GLuint program, GLenum programInterface, const GLchar *name);
typedef GLint ( * PFNGLGETPROGRAMRESOURCELOCATIONINDEXPROC) (GLuint program, GLenum programInterface, const GLchar *name);
typedef void ( * PFNGLSHADERSTORAGEBLOCKBINDINGPROC) (GLuint program, GLuint storageBlockIndex, GLuint storageBlockBinding);
typedef void ( * PFNGLTEXBUFFERRANGEPROC) (GLenum target, GLenum internalformat, GLuint buffer, GLintptr offset, GLsizeiptr size);
typedef void ( * PFNGLTEXSTORAGE2DMULTISAMPLEPROC) (GLenum target, GLsizei samples, GLenum internalformat, GLsizei width, GLsizei height, GLboolean fixedsamplelocations);
typedef void ( * PFNGLTEXSTORAGE3DMULTISAMPLEPROC) (GLenum target, GLsizei samples, GLenum internalformat, GLsizei width, GLsizei height, GLsizei depth, GLboolean fixedsamplelocations);
typedef void ( * PFNGLTEXTUREVIEWPROC) (GLuint texture, GLenum target, GLuint origtexture, GLenum internalformat, GLuint minlevel, GLuint numlevels, GLuint minlayer, GLuint numlayers);
typedef void ( * PFNGLBINDVERTEXBUFFERPROC) (GLuint bindingindex, GLuint buffer, GLintptr offset, GLsizei stride);
typedef void ( * PFNGLVERTEXATTRIBFORMATPROC) (GLuint attribindex, GLint size, GLenum type, GLboolean normalized, GLuint relativeoffset);
typedef void ( * PFNGLVERTEXATTRIBIFORMATPROC) (GLuint attribindex, GLint size, GLenum type, GLuint relativeoffset);
typedef void ( * PFNGLVERTEXATTRIBLFORMATPROC) (GLuint attribindex, GLint size, GLenum type, GLuint relativeoffset);
typedef void ( * PFNGLVERTEXATTRIBBINDINGPROC) (GLuint attribindex, GLuint bindingindex);
typedef void ( * PFNGLVERTEXBINDINGDIVISORPROC) (GLuint bindingindex, GLuint divisor);
typedef void ( * PFNGLDEBUGMESSAGECONTROLPROC) (GLenum source, GLenum type, GLenum severity, GLsizei count, const GLuint *ids, GLboolean enabled);
typedef void ( * PFNGLDEBUGMESSAGEINSERTPROC) (GLenum source, GLenum type, GLuint id, GLenum severity, GLsizei length, const GLchar *buf);
typedef void ( * PFNGLDEBUGMESSAGECALLBACKPROC) (GLDEBUGPROC callback, const void *userParam);
typedef GLuint ( * PFNGLGETDEBUGMESSAGELOGPROC) (GLuint count, GLsizei bufSize, GLenum *sources, GLenum *types, GLuint *ids, GLenum *severities, GLsizei *lengths, GLchar *messageLog);
typedef void ( * PFNGLPUSHDEBUGGROUPPROC) (GLenum source, GLuint id, GLsizei length, const GLchar *message);
typedef void ( * PFNGLPOPDEBUGGROUPPROC) (void);
typedef void ( * PFNGLOBJECTLABELPROC) (GLenum identifier, GLuint name, GLsizei length, const GLchar *label);
typedef void ( * PFNGLGETOBJECTLABELPROC) (GLenum identifier, GLuint name, GLsizei bufSize, GLsizei *length, GLchar *label);
typedef void ( * PFNGLOBJECTPTRLABELPROC) (const void *ptr, GLsizei length, const GLchar *label);
typedef void ( * PFNGLGETOBJECTPTRLABELPROC) (const void *ptr, GLsizei bufSize, GLsizei *length, GLchar *label);
typedef void ( * PFNGLBUFFERSTORAGEPROC) (GLenum target, GLsizeiptr size, const void *data, GLbitfield flags);
typedef void ( * PFNGLCLEARTEXIMAGEPROC) (GLuint texture, GLint level, GLenum format, GLenum type, const void *data);
typedef void ( * PFNGLCLEARTEXSUBIMAGEPROC) (GLuint texture, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth, GLenum format, GLenum type, const void *data);
typedef void ( * PFNGLBINDBUFFERSBASEPROC) (GLenum target, GLuint first, GLsizei count, const GLuint *buffers);
typedef void ( * PFNGLBINDBUFFERSRANGEPROC) (GLenum target, GLuint first, GLsizei count, const GLuint *buffers, const GLintptr *offsets, const GLsizeiptr *sizes);
typedef void ( * PFNGLBINDTEXTURESPROC) (GLuint first, GLsizei count, const GLuint *textures);
typedef void ( * PFNGLBINDSAMPLERSPROC) (GLuint first, GLsizei count, const GLuint *samplers);
typedef void ( * PFNGLBINDIMAGETEXTURESPROC) (GLuint first, GLsizei count, const GLuint *textures);
typedef void ( * PFNGLBINDVERTEXBUFFERSPROC) (GLuint first, GLsizei count, const GLuint *buffers, const GLintptr *offsets, const GLsizei *strides);
typedef void ( * PFNGLCLIPCONTROLPROC) (GLenum origin, GLenum depth);
typedef void ( * PFNGLCREATETRANSFORMFEEDBACKSPROC) (GLsizei n, GLuint *ids);
typedef void ( * PFNGLTRANSFORMFEEDBACKBUFFERBASEPROC) (GLuint xfb, GLuint index, GLuint buffer);
typedef void ( * PFNGLTRANSFORMFEEDBACKBUFFERRANGEPROC) (GLuint xfb, GLuint index, GLuint buffer, GLintptr offset, GLsizeiptr size);
typedef void ( * PFNGLGETTRANSFORMFEEDBACKIVPROC) (GLuint xfb, GLenum pname, GLint *param);
typedef void ( * PFNGLGETTRANSFORMFEEDBACKI_VPROC) (GLuint xfb, GLenum pname, GLuint index, GLint *param);
typedef void ( * PFNGLGETTRANSFORMFEEDBACKI64_VPROC) (GLuint xfb, GLenum pname, GLuint index, GLint64 *param);
typedef void ( * PFNGLCREATEBUFFERSPROC) (GLsizei n, GLuint *buffers);
typedef void ( * PFNGLNAMEDBUFFERSTORAGEPROC) (GLuint buffer, GLsizeiptr size, const void *data, GLbitfield flags);
typedef void ( * PFNGLNAMEDBUFFERDATAPROC) (GLuint buffer, GLsizeiptr size, const void *data, GLenum usage);
typedef void ( * PFNGLNAMEDBUFFERSUBDATAPROC) (GLuint buffer, GLintptr offset, GLsizeiptr size, const void *data);
typedef void ( * PFNGLCOPYNAMEDBUFFERSUBDATAPROC) (GLuint readBuffer, GLuint writeBuffer, GLintptr readOffset, GLintptr writeOffset, GLsizeiptr size);
typedef void ( * PFNGLCLEARNAMEDBUFFERDATAPROC) (GLuint buffer, GLenum internalformat, GLenum format, GLenum type, const void *data);
typedef void ( * PFNGLCLEARNAMEDBUFFERSUBDATAPROC) (GLuint buffer, GLenum internalformat, GLintptr offset, GLsizeiptr size, GLenum format, GLenum type, const void *data);
typedef void *( * PFNGLMAPNAMEDBUFFERPROC) (GLuint buffer, GLenum access);
typedef void *( * PFNGLMAPNAMEDBUFFERRANGEPROC) (GLuint buffer, GLintptr offset, GLsizeiptr length, GLbitfield access);
typedef GLboolean ( * PFNGLUNMAPNAMEDBUFFERPROC) (GLuint buffer);
typedef void ( * PFNGLFLUSHMAPPEDNAMEDBUFFERRANGEPROC) (GLuint buffer, GLintptr offset, GLsizeiptr length);
typedef void ( * PFNGLGETNAMEDBUFFERPARAMETERIVPROC) (GLuint buffer, GLenum pname, GLint *params);
typedef void ( * PFNGLGETNAMEDBUFFERPARAMETERI64VPROC) (GLuint buffer, GLenum pname, GLint64 *params);
typedef void ( * PFNGLGETNAMEDBUFFERPOINTERVPROC) (GLuint buffer, GLenum pname, void **params);
typedef void ( * PFNGLGETNAMEDBUFFERSUBDATAPROC) (GLuint buffer, GLintptr offset, GLsizeiptr size, void *data);
typedef void ( * PFNGLCREATEFRAMEBUFFERSPROC) (GLsizei n, GLuint *framebuffers);
typedef void ( * PFNGLNAMEDFRAMEBUFFERRENDERBUFFERPROC) (GLuint framebuffer, GLenum attachment, GLenum renderbuffertarget, GLuint renderbuffer);
typedef void ( * PFNGLNAMEDFRAMEBUFFERPARAMETERIPROC) (GLuint framebuffer, GLenum pname, GLint param);
typedef void ( * PFNGLNAMEDFRAMEBUFFERTEXTUREPROC) (GLuint framebuffer, GLenum attachment, GLuint texture, GLint level);
typedef void ( * PFNGLNAMEDFRAMEBUFFERTEXTURELAYERPROC) (GLuint framebuffer, GLenum attachment, GLuint texture, GLint level, GLint layer);
typedef void ( * PFNGLNAMEDFRAMEBUFFERDRAWBUFFERPROC) (GLuint framebuffer, GLenum buf);
typedef void ( * PFNGLNAMEDFRAMEBUFFERDRAWBUFFERSPROC) (GLuint framebuffer, GLsizei n, const GLenum *bufs);
typedef void ( * PFNGLNAMEDFRAMEBUFFERREADBUFFERPROC) (GLuint framebuffer, GLenum src);
typedef void ( * PFNGLINVALIDATENAMEDFRAMEBUFFERDATAPROC) (GLuint framebuffer, GLsizei numAttachments, const GLenum *attachments);
typedef void ( * PFNGLINVALIDATENAMEDFRAMEBUFFERSUBDATAPROC) (GLuint framebuffer, GLsizei numAttachments, const GLenum *attachments, GLint x, GLint y, GLsizei width, GLsizei height);
typedef void ( * PFNGLCLEARNAMEDFRAMEBUFFERIVPROC) (GLuint framebuffer, GLenum buffer, GLint drawbuffer, const GLint *value);
typedef void ( * PFNGLCLEARNAMEDFRAMEBUFFERUIVPROC) (GLuint framebuffer, GLenum buffer, GLint drawbuffer, const GLuint *value);
typedef void ( * PFNGLCLEARNAMEDFRAMEBUFFERFVPROC) (GLuint framebuffer, GLenum buffer, GLint drawbuffer, const GLfloat *value);
typedef void ( * PFNGLCLEARNAMEDFRAMEBUFFERFIPROC) (GLuint framebuffer, GLenum buffer, GLint drawbuffer, GLfloat depth, GLint stencil);
typedef void ( * PFNGLBLITNAMEDFRAMEBUFFERPROC) (GLuint readFramebuffer, GLuint drawFramebuffer, GLint srcX0, GLint srcY0, GLint srcX1, GLint srcY1, GLint dstX0, GLint dstY0, GLint dstX1, GLint dstY1, GLbitfield mask, GLenum filter);
typedef GLenum ( * PFNGLCHECKNAMEDFRAMEBUFFERSTATUSPROC) (GLuint framebuffer, GLenum target);
typedef void ( * PFNGLGETNAMEDFRAMEBUFFERPARAMETERIVPROC) (GLuint framebuffer, GLenum pname, GLint *param);
typedef void ( * PFNGLGETNAMEDFRAMEBUFFERATTACHMENTPARAMETERIVPROC) (GLuint framebuffer, GLenum attachment, GLenum pname, GLint *params);
typedef void ( * PFNGLCREATERENDERBUFFERSPROC) (GLsizei n, GLuint *renderbuffers);
typedef void ( * PFNGLNAMEDRENDERBUFFERSTORAGEPROC) (GLuint renderbuffer, GLenum internalformat, GLsizei width, GLsizei height);
typedef void ( * PFNGLNAMEDRENDERBUFFERSTORAGEMULTISAMPLEPROC) (GLuint renderbuffer, GLsizei samples, GLenum internalformat, GLsizei width, GLsizei height);
typedef void ( * PFNGLGETNAMEDRENDERBUFFERPARAMETERIVPROC) (GLuint renderbuffer, GLenum pname, GLint *params);
typedef void ( * PFNGLCREATETEXTURESPROC) (GLenum target, GLsizei n, GLuint *textures);
typedef void ( * PFNGLTEXTUREBUFFERPROC) (GLuint texture, GLenum internalformat, GLuint buffer);
typedef void ( * PFNGLTEXTUREBUFFERRANGEPROC) (GLuint texture, GLenum internalformat, GLuint buffer, GLintptr offset, GLsizeiptr size);
typedef void ( * PFNGLTEXTURESTORAGE1DPROC) (GLuint texture, GLsizei levels, GLenum internalformat, GLsizei width);
typedef void ( * PFNGLTEXTURESTORAGE2DPROC) (GLuint texture, GLsizei levels, GLenum internalformat, GLsizei width, GLsizei height);
typedef void ( * PFNGLTEXTURESTORAGE3DPROC) (GLuint texture, GLsizei levels, GLenum internalformat, GLsizei width, GLsizei height, GLsizei depth);
typedef void ( * PFNGLTEXTURESTORAGE2DMULTISAMPLEPROC) (GLuint texture, GLsizei samples, GLenum internalformat, GLsizei width, GLsizei height, GLboolean fixedsamplelocations);
typedef void ( * PFNGLTEXTURESTORAGE3DMULTISAMPLEPROC) (GLuint texture, GLsizei samples, GLenum internalformat, GLsizei width, GLsizei height, GLsizei depth, GLboolean fixedsamplelocations);
typedef void ( * PFNGLTEXTURESUBIMAGE1DPROC) (GLuint texture, GLint level, GLint xoffset, GLsizei width, GLenum format, GLenum type, const void *pixels);
typedef void ( * PFNGLTEXTURESUBIMAGE2DPROC) (GLuint texture, GLint level, GLint xoffset, GLint yoffset, GLsizei width, GLsizei height, GLenum format, GLenum type, const void *pixels);
typedef void ( * PFNGLTEXTURESUBIMAGE3DPROC) (GLuint texture, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth, GLenum format, GLenum type, const void *pixels);
typedef void ( * PFNGLCOMPRESSEDTEXTURESUBIMAGE1DPROC) (GLuint texture, GLint level, GLint xoffset, GLsizei width, GLenum format, GLsizei imageSize, const void *data);
typedef void ( * PFNGLCOMPRESSEDTEXTURESUBIMAGE2DPROC) (GLuint texture, GLint level, GLint xoffset, GLint yoffset, GLsizei width, GLsizei height, GLenum format, GLsizei imageSize, const void *data);
typedef void ( * PFNGLCOMPRESSEDTEXTURESUBIMAGE3DPROC) (GLuint texture, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth, GLenum format, GLsizei imageSize, const void *data);
typedef void ( * PFNGLCOPYTEXTURESUBIMAGE1DPROC) (GLuint texture, GLint level, GLint xoffset, GLint x, GLint y, GLsizei width);
typedef void ( * PFNGLCOPYTEXTURESUBIMAGE2DPROC) (GLuint texture, GLint level, GLint xoffset, GLint yoffset, GLint x, GLint y, GLsizei width, GLsizei height);
typedef void ( * PFNGLCOPYTEXTURESUBIMAGE3DPROC) (GLuint texture, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLint x, GLint y, GLsizei width, GLsizei height);
typedef void ( * PFNGLTEXTUREPARAMETERFPROC) (GLuint texture, GLenum pname, GLfloat param);
typedef void ( * PFNGLTEXTUREPARAMETERFVPROC) (GLuint texture, GLenum pname, const GLfloat *param);
typedef void ( * PFNGLTEXTUREPARAMETERIPROC) (GLuint texture, GLenum pname, GLint param);
typedef void ( * PFNGLTEXTUREPARAMETERIIVPROC) (GLuint texture, GLenum pname, const GLint *params);
typedef void ( * PFNGLTEXTUREPARAMETERIUIVPROC) (GLuint texture, GLenum pname, const GLuint *params);
typedef void ( * PFNGLTEXTUREPARAMETERIVPROC) (GLuint texture, GLenum pname, const GLint *param);
typedef void ( * PFNGLGENERATETEXTUREMIPMAPPROC) (GLuint texture);
typedef void ( * PFNGLBINDTEXTUREUNITPROC) (GLuint unit, GLuint texture);
typedef void ( * PFNGLGETTEXTUREIMAGEPROC) (GLuint texture, GLint level, GLenum format, GLenum type, GLsizei bufSize, void *pixels);
typedef void ( * PFNGLGETCOMPRESSEDTEXTUREIMAGEPROC) (GLuint texture, GLint level, GLsizei bufSize, void *pixels);
typedef void ( * PFNGLGETTEXTURELEVELPARAMETERFVPROC) (GLuint texture, GLint level, GLenum pname, GLfloat *params);
typedef void ( * PFNGLGETTEXTURELEVELPARAMETERIVPROC) (GLuint texture, GLint level, GLenum pname, GLint *params);
typedef void ( * PFNGLGETTEXTUREPARAMETERFVPROC) (GLuint texture, GLenum pname, GLfloat *params);
typedef void ( * PFNGLGETTEXTUREPARAMETERIIVPROC) (GLuint texture, GLenum pname, GLint *params);
typedef void ( * PFNGLGETTEXTUREPARAMETERIUIVPROC) (GLuint texture, GLenum pname, GLuint *params);
typedef void ( * PFNGLGETTEXTUREPARAMETERIVPROC) (GLuint texture, GLenum pname, GLint *params);
typedef void ( * PFNGLCREATEVERTEXARRAYSPROC) (GLsizei n, GLuint *arrays);
typedef void ( * PFNGLDISABLEVERTEXARRAYATTRIBPROC) (GLuint vaobj, GLuint index);
typedef void ( * PFNGLENABLEVERTEXARRAYATTRIBPROC) (GLuint vaobj, GLuint index);
typedef void ( * PFNGLVERTEXARRAYELEMENTBUFFERPROC) (GLuint vaobj, GLuint buffer);
typedef void ( * PFNGLVERTEXARRAYVERTEXBUFFERPROC) (GLuint vaobj, GLuint bindingindex, GLuint buffer, GLintptr offset, GLsizei stride);
typedef void ( * PFNGLVERTEXARRAYVERTEXBUFFERSPROC) (GLuint vaobj, GLuint first, GLsizei count, const GLuint *buffers, const GLintptr *offsets, const GLsizei *strides);
typedef void ( * PFNGLVERTEXARRAYATTRIBBINDINGPROC) (GLuint vaobj, GLuint attribindex, GLuint bindingindex);
typedef void ( * PFNGLVERTEXARRAYATTRIBFORMATPROC) (GLuint vaobj, GLuint attribindex, GLint size, GLenum type, GLboolean normalized, GLuint relativeoffset);
typedef void ( * PFNGLVERTEXARRAYATTRIBIFORMATPROC) (GLuint vaobj, GLuint attribindex, GLint size, GLenum type, GLuint relativeoffset);
typedef void ( * PFNGLVERTEXARRAYATTRIBLFORMATPROC) (GLuint vaobj, GLuint attribindex, GLint size, GLenum type, GLuint relativeoffset);
typedef void ( * PFNGLVERTEXARRAYBINDINGDIVISORPROC) (GLuint vaobj, GLuint bindingindex, GLuint divisor);
typedef void ( * PFNGLGETVERTEXARRAYIVPROC) (GLuint vaobj, GLenum pname, GLint *param);
typedef void ( * PFNGLGETVERTEXARRAYINDEXEDIVPROC) (GLuint vaobj, GLuint index, GLenum pname, GLint *param);
typedef void ( * PFNGLGETVERTEXARRAYINDEXED64IVPROC) (GLuint vaobj, GLuint index, GLenum pname, GLint64 *param);
typedef void ( * PFNGLCREATESAMPLERSPROC) (GLsizei n, GLuint *samplers);
typedef void ( * PFNGLCREATEPROGRAMPIPELINESPROC) (GLsizei n, GLuint *pipelines);
typedef void ( * PFNGLCREATEQUERIESPROC) (GLenum target, GLsizei n, GLuint *ids);
typedef void ( * PFNGLGETQUERYBUFFEROBJECTI64VPROC) (GLuint id, GLuint buffer, GLenum pname, GLintptr offset);
typedef void ( * PFNGLGETQUERYBUFFEROBJECTIVPROC) (GLuint id, GLuint buffer, GLenum pname, GLintptr offset);
typedef void ( * PFNGLGETQUERYBUFFEROBJECTUI64VPROC) (GLuint id, GLuint buffer, GLenum pname, GLintptr offset);
typedef void ( * PFNGLGETQUERYBUFFEROBJECTUIVPROC) (GLuint id, GLuint buffer, GLenum pname, GLintptr offset);
typedef void ( * PFNGLMEMORYBARRIERBYREGIONPROC) (GLbitfield barriers);
typedef void ( * PFNGLGETTEXTURESUBIMAGEPROC) (GLuint texture, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth, GLenum format, GLenum type, GLsizei bufSize, void *pixels);
typedef void ( * PFNGLGETCOMPRESSEDTEXTURESUBIMAGEPROC) (GLuint texture, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth, GLsizei bufSize, void *pixels);
typedef GLenum ( * PFNGLGETGRAPHICSRESETSTATUSPROC) (void);
typedef void ( * PFNGLGETNCOMPRESSEDTEXIMAGEPROC) (GLenum target, GLint lod, GLsizei bufSize, void *pixels);
typedef void ( * PFNGLGETNTEXIMAGEPROC) (GLenum target, GLint level, GLenum format, GLenum type, GLsizei bufSize, void *pixels);
typedef void ( * PFNGLGETNUNIFORMDVPROC) (GLuint program, GLint location, GLsizei bufSize, GLdouble *params);
typedef void ( * PFNGLGETNUNIFORMFVPROC) (GLuint program, GLint location, GLsizei bufSize, GLfloat *params);
typedef void ( * PFNGLGETNUNIFORMIVPROC) (GLuint program, GLint location, GLsizei bufSize, GLint *params);
typedef void ( * PFNGLGETNUNIFORMUIVPROC) (GLuint program, GLint location, GLsizei bufSize, GLuint *params);
typedef void ( * PFNGLREADNPIXELSPROC) (GLint x, GLint y, GLsizei width, GLsizei height, GLenum format, GLenum type, GLsizei bufSize, void *data);
typedef void ( * PFNGLGETNMAPDVPROC) (GLenum target, GLenum query, GLsizei bufSize, GLdouble *v);
typedef void ( * PFNGLGETNMAPFVPROC) (GLenum target, GLenum query, GLsizei bufSize, GLfloat *v);
typedef void ( * PFNGLGETNMAPIVPROC) (GLenum target, GLenum query, GLsizei bufSize, GLint *v);
typedef void ( * PFNGLGETNPIXELMAPFVPROC) (GLenum map, GLsizei bufSize, GLfloat *values);
typedef void ( * PFNGLGETNPIXELMAPUIVPROC) (GLenum map, GLsizei bufSize, GLuint *values);
typedef void ( * PFNGLGETNPIXELMAPUSVPROC) (GLenum map, GLsizei bufSize, GLushort *values);
typedef void ( * PFNGLGETNPOLYGONSTIPPLEPROC) (GLsizei bufSize, GLubyte *pattern);
typedef void ( * PFNGLGETNCOLORTABLEPROC) (GLenum target, GLenum format, GLenum type, GLsizei bufSize, void *table);
typedef void ( * PFNGLGETNCONVOLUTIONFILTERPROC) (GLenum target, GLenum format, GLenum type, GLsizei bufSize, void *image);
typedef void ( * PFNGLGETNSEPARABLEFILTERPROC) (GLenum target, GLenum format, GLenum type, GLsizei rowBufSize, void *row, GLsizei columnBufSize, void *column, void *span);
typedef void ( * PFNGLGETNHISTOGRAMPROC) (GLenum target, GLboolean reset, GLenum format, GLenum type, GLsizei bufSize, void *values);
typedef void ( * PFNGLGETNMINMAXPROC) (GLenum target, GLboolean reset, GLenum format, GLenum type, GLsizei bufSize, void *values);
typedef void ( * PFNGLTEXTUREBARRIERPROC) (void);
typedef void ( * PFNGLSPECIALIZESHADERPROC) (GLuint shader, const GLchar *pEntryPoint, GLuint numSpecializationConstants, const GLuint *pConstantIndex, const GLuint *pConstantValue);
typedef void ( * PFNGLMULTIDRAWARRAYSINDIRECTCOUNTPROC) (GLenum mode, const void *indirect, GLintptr drawcount, GLsizei maxdrawcount, GLsizei stride);
typedef void ( * PFNGLMULTIDRAWELEMENTSINDIRECTCOUNTPROC) (GLenum mode, GLenum type, const void *indirect, GLintptr drawcount, GLsizei maxdrawcount, GLsizei stride);
typedef void ( * PFNGLPOLYGONOFFSETCLAMPPROC) (GLfloat factor, GLfloat units, GLfloat clamp);
typedef void ( * PFNGLPRIMITIVEBOUNDINGBOXARBPROC) (GLfloat minX, GLfloat minY, GLfloat minZ, GLfloat minW, GLfloat maxX, GLfloat maxY, GLfloat maxZ, GLfloat maxW);
typedef khronos_uint64_t GLuint64EXT;
typedef GLuint64 ( * PFNGLGETTEXTUREHANDLEARBPROC) (GLuint texture);
typedef GLuint64 ( * PFNGLGETTEXTURESAMPLERHANDLEARBPROC) (GLuint texture, GLuint sampler);
typedef void ( * PFNGLMAKETEXTUREHANDLERESIDENTARBPROC) (GLuint64 handle);
typedef void ( * PFNGLMAKETEXTUREHANDLENONRESIDENTARBPROC) (GLuint64 handle);
typedef GLuint64 ( * PFNGLGETIMAGEHANDLEARBPROC) (GLuint texture, GLint level, GLboolean layered, GLint layer, GLenum format);
typedef void ( * PFNGLMAKEIMAGEHANDLERESIDENTARBPROC) (GLuint64 handle, GLenum access);
typedef void ( * PFNGLMAKEIMAGEHANDLENONRESIDENTARBPROC) (GLuint64 handle);
typedef void ( * PFNGLUNIFORMHANDLEUI64ARBPROC) (GLint location, GLuint64 value);
typedef void ( * PFNGLUNIFORMHANDLEUI64VARBPROC) (GLint location, GLsizei count, const GLuint64 *value);
typedef void ( * PFNGLPROGRAMUNIFORMHANDLEUI64ARBPROC) (GLuint program, GLint location, GLuint64 value);
typedef void ( * PFNGLPROGRAMUNIFORMHANDLEUI64VARBPROC) (GLuint program, GLint location, GLsizei count, const GLuint64 *values);
typedef GLboolean ( * PFNGLISTEXTUREHANDLERESIDENTARBPROC) (GLuint64 handle);
typedef GLboolean ( * PFNGLISIMAGEHANDLERESIDENTARBPROC) (GLuint64 handle);
typedef void ( * PFNGLVERTEXATTRIBL1UI64ARBPROC) (GLuint index, GLuint64EXT x);
typedef void ( * PFNGLVERTEXATTRIBL1UI64VARBPROC) (GLuint index, const GLuint64EXT *v);
typedef void ( * PFNGLGETVERTEXATTRIBLUI64VARBPROC) (GLuint index, GLenum pname, GLuint64EXT *params);
struct _cl_context;
struct _cl_event;
typedef GLsync ( * PFNGLCREATESYNCFROMCLEVENTARBPROC) (struct _cl_context *context, struct _cl_event *event, GLbitfield flags);
typedef void ( * PFNGLCLAMPCOLORARBPROC) (GLenum target, GLenum clamp);
typedef void ( * PFNGLDISPATCHCOMPUTEGROUPSIZEARBPROC) (GLuint num_groups_x, GLuint num_groups_y, GLuint num_groups_z, GLuint group_size_x, GLuint group_size_y, GLuint group_size_z);
typedef void ( *GLDEBUGPROCARB)(GLenum source,GLenum type,GLuint id,GLenum severity,GLsizei length,const GLchar *message,const void *userParam);
typedef void ( * PFNGLDEBUGMESSAGECONTROLARBPROC) (GLenum source, GLenum type, GLenum severity, GLsizei count, const GLuint *ids, GLboolean enabled);
typedef void ( * PFNGLDEBUGMESSAGEINSERTARBPROC) (GLenum source, GLenum type, GLuint id, GLenum severity, GLsizei length, const GLchar *buf);
typedef void ( * PFNGLDEBUGMESSAGECALLBACKARBPROC) (GLDEBUGPROCARB callback, const void *userParam);
typedef GLuint ( * PFNGLGETDEBUGMESSAGELOGARBPROC) (GLuint count, GLsizei bufSize, GLenum *sources, GLenum *types, GLuint *ids, GLenum *severities, GLsizei *lengths, GLchar *messageLog);
typedef void ( * PFNGLDRAWBUFFERSARBPROC) (GLsizei n, const GLenum *bufs);
typedef void ( * PFNGLBLENDEQUATIONIARBPROC) (GLuint buf, GLenum mode);
typedef void ( * PFNGLBLENDEQUATIONSEPARATEIARBPROC) (GLuint buf, GLenum modeRGB, GLenum modeAlpha);
typedef void ( * PFNGLBLENDFUNCIARBPROC) (GLuint buf, GLenum src, GLenum dst);
typedef void ( * PFNGLBLENDFUNCSEPARATEIARBPROC) (GLuint buf, GLenum srcRGB, GLenum dstRGB, GLenum srcAlpha, GLenum dstAlpha);
typedef void ( * PFNGLDRAWARRAYSINSTANCEDARBPROC) (GLenum mode, GLint first, GLsizei count, GLsizei primcount);
typedef void ( * PFNGLDRAWELEMENTSINSTANCEDARBPROC) (GLenum mode, GLsizei count, GLenum type, const void *indices, GLsizei primcount);
typedef void ( * PFNGLPROGRAMSTRINGARBPROC) (GLenum target, GLenum format, GLsizei len, const void *string);
typedef void ( * PFNGLBINDPROGRAMARBPROC) (GLenum target, GLuint program);
typedef void ( * PFNGLDELETEPROGRAMSARBPROC) (GLsizei n, const GLuint *programs);
typedef void ( * PFNGLGENPROGRAMSARBPROC) (GLsizei n, GLuint *programs);
typedef void ( * PFNGLPROGRAMENVPARAMETER4DARBPROC) (GLenum target, GLuint index, GLdouble x, GLdouble y, GLdouble z, GLdouble w);
typedef void ( * PFNGLPROGRAMENVPARAMETER4DVARBPROC) (GLenum target, GLuint index, const GLdouble *params);
typedef void ( * PFNGLPROGRAMENVPARAMETER4FARBPROC) (GLenum target, GLuint index, GLfloat x, GLfloat y, GLfloat z, GLfloat w);
typedef void ( * PFNGLPROGRAMENVPARAMETER4FVARBPROC) (GLenum target, GLuint index, const GLfloat *params);
typedef void ( * PFNGLPROGRAMLOCALPARAMETER4DARBPROC) (GLenum target, GLuint index, GLdouble x, GLdouble y, GLdouble z, GLdouble w);
typedef void ( * PFNGLPROGRAMLOCALPARAMETER4DVARBPROC) (GLenum target, GLuint index, const GLdouble *params);
typedef void ( * PFNGLPROGRAMLOCALPARAMETER4FARBPROC) (GLenum target, GLuint index, GLfloat x, GLfloat y, GLfloat z, GLfloat w);
typedef void ( * PFNGLPROGRAMLOCALPARAMETER4FVARBPROC) (GLenum target, GLuint index, const GLfloat *params);
typedef void ( * PFNGLGETPROGRAMENVPARAMETERDVARBPROC) (GLenum target, GLuint index, GLdouble *params);
typedef void ( * PFNGLGETPROGRAMENVPARAMETERFVARBPROC) (GLenum target, GLuint index, GLfloat *params);
typedef void ( * PFNGLGETPROGRAMLOCALPARAMETERDVARBPROC) (GLenum target, GLuint index, GLdouble *params);
typedef void ( * PFNGLGETPROGRAMLOCALPARAMETERFVARBPROC) (GLenum target, GLuint index, GLfloat *params);
typedef void ( * PFNGLGETPROGRAMIVARBPROC) (GLenum target, GLenum pname, GLint *params);
typedef void ( * PFNGLGETPROGRAMSTRINGARBPROC) (GLenum target, GLenum pname, void *string);
typedef GLboolean ( * PFNGLISPROGRAMARBPROC) (GLuint program);
typedef void ( * PFNGLPROGRAMPARAMETERIARBPROC) (GLuint program, GLenum pname, GLint value);
typedef void ( * PFNGLFRAMEBUFFERTEXTUREARBPROC) (GLenum target, GLenum attachment, GLuint texture, GLint level);
typedef void ( * PFNGLFRAMEBUFFERTEXTURELAYERARBPROC) (GLenum target, GLenum attachment, GLuint texture, GLint level, GLint layer);
typedef void ( * PFNGLFRAMEBUFFERTEXTUREFACEARBPROC) (GLenum target, GLenum attachment, GLuint texture, GLint level, GLenum face);
typedef void ( * PFNGLSPECIALIZESHADERARBPROC) (GLuint shader, const GLchar *pEntryPoint, GLuint numSpecializationConstants, const GLuint *pConstantIndex, const GLuint *pConstantValue);
typedef void ( * PFNGLUNIFORM1I64ARBPROC) (GLint location, GLint64 x);
typedef void ( * PFNGLUNIFORM2I64ARBPROC) (GLint location, GLint64 x, GLint64 y);
typedef void ( * PFNGLUNIFORM3I64ARBPROC) (GLint location, GLint64 x, GLint64 y, GLint64 z);
typedef void ( * PFNGLUNIFORM4I64ARBPROC) (GLint location, GLint64 x, GLint64 y, GLint64 z, GLint64 w);
typedef void ( * PFNGLUNIFORM1I64VARBPROC) (GLint location, GLsizei count, const GLint64 *value);
typedef void ( * PFNGLUNIFORM2I64VARBPROC) (GLint location, GLsizei count, const GLint64 *value);
typedef void ( * PFNGLUNIFORM3I64VARBPROC) (GLint location, GLsizei count, const GLint64 *value);
typedef void ( * PFNGLUNIFORM4I64VARBPROC) (GLint location, GLsizei count, const GLint64 *value);
typedef void ( * PFNGLUNIFORM1UI64ARBPROC) (GLint location, GLuint64 x);
typedef void ( * PFNGLUNIFORM2UI64ARBPROC) (GLint location, GLuint64 x, GLuint64 y);
typedef void ( * PFNGLUNIFORM3UI64ARBPROC) (GLint location, GLuint64 x, GLuint64 y, GLuint64 z);
typedef void ( * PFNGLUNIFORM4UI64ARBPROC) (GLint location, GLuint64 x, GLuint64 y, GLuint64 z, GLuint64 w);
typedef void ( * PFNGLUNIFORM1UI64VARBPROC) (GLint location, GLsizei count, const GLuint64 *value);
typedef void ( * PFNGLUNIFORM2UI64VARBPROC) (GLint location, GLsizei count, const GLuint64 *value);
typedef void ( * PFNGLUNIFORM3UI64VARBPROC) (GLint location, GLsizei count, const GLuint64 *value);
typedef void ( * PFNGLUNIFORM4UI64VARBPROC) (GLint location, GLsizei count, const GLuint64 *value);
typedef void ( * PFNGLGETUNIFORMI64VARBPROC) (GLuint program, GLint location, GLint64 *params);
typedef void ( * PFNGLGETUNIFORMUI64VARBPROC) (GLuint program, GLint location, GLuint64 *params);
typedef void ( * PFNGLGETNUNIFORMI64VARBPROC) (GLuint program, GLint location, GLsizei bufSize, GLint64 *params);
typedef void ( * PFNGLGETNUNIFORMUI64VARBPROC) (GLuint program, GLint location, GLsizei bufSize, GLuint64 *params);
typedef void ( * PFNGLPROGRAMUNIFORM1I64ARBPROC) (GLuint program, GLint location, GLint64 x);
typedef void ( * PFNGLPROGRAMUNIFORM2I64ARBPROC) (GLuint program, GLint location, GLint64 x, GLint64 y);
typedef void ( * PFNGLPROGRAMUNIFORM3I64ARBPROC) (GLuint program, GLint location, GLint64 x, GLint64 y, GLint64 z);
typedef void ( * PFNGLPROGRAMUNIFORM4I64ARBPROC) (GLuint program, GLint location, GLint64 x, GLint64 y, GLint64 z, GLint64 w);
typedef void ( * PFNGLPROGRAMUNIFORM1I64VARBPROC) (GLuint program, GLint location, GLsizei count, const GLint64 *value);
typedef void ( * PFNGLPROGRAMUNIFORM2I64VARBPROC) (GLuint program, GLint location, GLsizei count, const GLint64 *value);
typedef void ( * PFNGLPROGRAMUNIFORM3I64VARBPROC) (GLuint program, GLint location, GLsizei count, const GLint64 *value);
typedef void ( * PFNGLPROGRAMUNIFORM4I64VARBPROC) (GLuint program, GLint location, GLsizei count, const GLint64 *value);
typedef void ( * PFNGLPROGRAMUNIFORM1UI64ARBPROC) (GLuint program, GLint location, GLuint64 x);
typedef void ( * PFNGLPROGRAMUNIFORM2UI64ARBPROC) (GLuint program, GLint location, GLuint64 x, GLuint64 y);
typedef void ( * PFNGLPROGRAMUNIFORM3UI64ARBPROC) (GLuint program, GLint location, GLuint64 x, GLuint64 y, GLuint64 z);
typedef void ( * PFNGLPROGRAMUNIFORM4UI64ARBPROC) (GLuint program, GLint location, GLuint64 x, GLuint64 y, GLuint64 z, GLuint64 w);
typedef void ( * PFNGLPROGRAMUNIFORM1UI64VARBPROC) (GLuint program, GLint location, GLsizei count, const GLuint64 *value);
typedef void ( * PFNGLPROGRAMUNIFORM2UI64VARBPROC) (GLuint program, GLint location, GLsizei count, const GLuint64 *value);
typedef void ( * PFNGLPROGRAMUNIFORM3UI64VARBPROC) (GLuint program, GLint location, GLsizei count, const GLuint64 *value);
typedef void ( * PFNGLPROGRAMUNIFORM4UI64VARBPROC) (GLuint program, GLint location, GLsizei count, const GLuint64 *value);
typedef khronos_uint16_t GLhalfARB;
typedef void ( * PFNGLCOLORTABLEPROC) (GLenum target, GLenum internalformat, GLsizei width, GLenum format, GLenum type, const void *table);
typedef void ( * PFNGLCOLORTABLEPARAMETERFVPROC) (GLenum target, GLenum pname, const GLfloat *params);
typedef void ( * PFNGLCOLORTABLEPARAMETERIVPROC) (GLenum target, GLenum pname, const GLint *params);
typedef void ( * PFNGLCOPYCOLORTABLEPROC) (GLenum target, GLenum internalformat, GLint x, GLint y, GLsizei width);
typedef void ( * PFNGLGETCOLORTABLEPROC) (GLenum target, GLenum format, GLenum type, void *table);
typedef void ( * PFNGLGETCOLORTABLEPARAMETERFVPROC) (GLenum target, GLenum pname, GLfloat *params);
typedef void ( * PFNGLGETCOLORTABLEPARAMETERIVPROC) (GLenum target, GLenum pname, GLint *params);
typedef void ( * PFNGLCOLORSUBTABLEPROC) (GLenum target, GLsizei start, GLsizei count, GLenum format, GLenum type, const void *data);
typedef void ( * PFNGLCOPYCOLORSUBTABLEPROC) (GLenum target, GLsizei start, GLint x, GLint y, GLsizei width);
typedef void ( * PFNGLCONVOLUTIONFILTER1DPROC) (GLenum target, GLenum internalformat, GLsizei width, GLenum format, GLenum type, const void *image);
typedef void ( * PFNGLCONVOLUTIONFILTER2DPROC) (GLenum target, GLenum internalformat, GLsizei width, GLsizei height, GLenum format, GLenum type, const void *image);
typedef void ( * PFNGLCONVOLUTIONPARAMETERFPROC) (GLenum target, GLenum pname, GLfloat params);
typedef void ( * PFNGLCONVOLUTIONPARAMETERFVPROC) (GLenum target, GLenum pname, const GLfloat *params);
typedef void ( * PFNGLCONVOLUTIONPARAMETERIPROC) (GLenum target, GLenum pname, GLint params);
typedef void ( * PFNGLCONVOLUTIONPARAMETERIVPROC) (GLenum target, GLenum pname, const GLint *params);
typedef void ( * PFNGLCOPYCONVOLUTIONFILTER1DPROC) (GLenum target, GLenum internalformat, GLint x, GLint y, GLsizei width);
typedef void ( * PFNGLCOPYCONVOLUTIONFILTER2DPROC) (GLenum target, GLenum internalformat, GLint x, GLint y, GLsizei width, GLsizei height);
typedef void ( * PFNGLGETCONVOLUTIONFILTERPROC) (GLenum target, GLenum format, GLenum type, void *image);
typedef void ( * PFNGLGETCONVOLUTIONPARAMETERFVPROC) (GLenum target, GLenum pname, GLfloat *params);
typedef void ( * PFNGLGETCONVOLUTIONPARAMETERIVPROC) (GLenum target, GLenum pname, GLint *params);
typedef void ( * PFNGLGETSEPARABLEFILTERPROC) (GLenum target, GLenum format, GLenum type, void *row, void *column, void *span);
typedef void ( * PFNGLSEPARABLEFILTER2DPROC) (GLenum target, GLenum internalformat, GLsizei width, GLsizei height, GLenum format, GLenum type, const void *row, const void *column);
typedef void ( * PFNGLGETHISTOGRAMPROC) (GLenum target, GLboolean reset, GLenum format, GLenum type, void *values);
typedef void ( * PFNGLGETHISTOGRAMPARAMETERFVPROC) (GLenum target, GLenum pname, GLfloat *params);
typedef void ( * PFNGLGETHISTOGRAMPARAMETERIVPROC) (GLenum target, GLenum pname, GLint *params);
typedef void ( * PFNGLGETMINMAXPROC) (GLenum target, GLboolean reset, GLenum format, GLenum type, void *values);
typedef void ( * PFNGLGETMINMAXPARAMETERFVPROC) (GLenum target, GLenum pname, GLfloat *params);
typedef void ( * PFNGLGETMINMAXPARAMETERIVPROC) (GLenum target, GLenum pname, GLint *params);
typedef void ( * PFNGLHISTOGRAMPROC) (GLenum target, GLsizei width, GLenum internalformat, GLboolean sink);
typedef void ( * PFNGLMINMAXPROC) (GLenum target, GLenum internalformat, GLboolean sink);
typedef void ( * PFNGLRESETHISTOGRAMPROC) (GLenum target);
typedef void ( * PFNGLRESETMINMAXPROC) (GLenum target);
typedef void ( * PFNGLMULTIDRAWARRAYSINDIRECTCOUNTARBPROC) (GLenum mode, const void *indirect, GLintptr drawcount, GLsizei maxdrawcount, GLsizei stride);
typedef void ( * PFNGLMULTIDRAWELEMENTSINDIRECTCOUNTARBPROC) (GLenum mode, GLenum type, const void *indirect, GLintptr drawcount, GLsizei maxdrawcount, GLsizei stride);
typedef void ( * PFNGLVERTEXATTRIBDIVISORARBPROC) (GLuint index, GLuint divisor);
typedef void ( * PFNGLCURRENTPALETTEMATRIXARBPROC) (GLint index);
typedef void ( * PFNGLMATRIXINDEXUBVARBPROC) (GLint size, const GLubyte *indices);
typedef void ( * PFNGLMATRIXINDEXUSVARBPROC) (GLint size, const GLushort *indices);
typedef void ( * PFNGLMATRIXINDEXUIVARBPROC) (GLint size, const GLuint *indices);
typedef void ( * PFNGLMATRIXINDEXPOINTERARBPROC) (GLint size, GLenum type, GLsizei stride, const void *pointer);
typedef void ( * PFNGLSAMPLECOVERAGEARBPROC) (GLfloat value, GLboolean invert);
typedef void ( * PFNGLACTIVETEXTUREARBPROC) (GLenum texture);
typedef void ( * PFNGLCLIENTACTIVETEXTUREARBPROC) (GLenum texture);
typedef void ( * PFNGLMULTITEXCOORD1DARBPROC) (GLenum target, GLdouble s);
typedef void ( * PFNGLMULTITEXCOORD1DVARBPROC) (GLenum target, const GLdouble *v);
typedef void ( * PFNGLMULTITEXCOORD1FARBPROC) (GLenum target, GLfloat s);
typedef void ( * PFNGLMULTITEXCOORD1FVARBPROC) (GLenum target, const GLfloat *v);
typedef void ( * PFNGLMULTITEXCOORD1IARBPROC) (GLenum target, GLint s);
typedef void ( * PFNGLMULTITEXCOORD1IVARBPROC) (GLenum target, const GLint *v);
typedef void ( * PFNGLMULTITEXCOORD1SARBPROC) (GLenum target, GLshort s);
typedef void ( * PFNGLMULTITEXCOORD1SVARBPROC) (GLenum target, const GLshort *v);
typedef void ( * PFNGLMULTITEXCOORD2DARBPROC) (GLenum target, GLdouble s, GLdouble t);
typedef void ( * PFNGLMULTITEXCOORD2DVARBPROC) (GLenum target, const GLdouble *v);
typedef void ( * PFNGLMULTITEXCOORD2FARBPROC) (GLenum target, GLfloat s, GLfloat t);
typedef void ( * PFNGLMULTITEXCOORD2FVARBPROC) (GLenum target, const GLfloat *v);
typedef void ( * PFNGLMULTITEXCOORD2IARBPROC) (GLenum target, GLint s, GLint t);
typedef void ( * PFNGLMULTITEXCOORD2IVARBPROC) (GLenum target, const GLint *v);
typedef void ( * PFNGLMULTITEXCOORD2SARBPROC) (GLenum target, GLshort s, GLshort t);
typedef void ( * PFNGLMULTITEXCOORD2SVARBPROC) (GLenum target, const GLshort *v);
typedef void ( * PFNGLMULTITEXCOORD3DARBPROC) (GLenum target, GLdouble s, GLdouble t, GLdouble r);
typedef void ( * PFNGLMULTITEXCOORD3DVARBPROC) (GLenum target, const GLdouble *v);
typedef void ( * PFNGLMULTITEXCOORD3FARBPROC) (GLenum target, GLfloat s, GLfloat t, GLfloat r);
typedef void ( * PFNGLMULTITEXCOORD3FVARBPROC) (GLenum target, const GLfloat *v);
typedef void ( * PFNGLMULTITEXCOORD3IARBPROC) (GLenum target, GLint s, GLint t, GLint r);
typedef void ( * PFNGLMULTITEXCOORD3IVARBPROC) (GLenum target, const GLint *v);
typedef void ( * PFNGLMULTITEXCOORD3SARBPROC) (GLenum target, GLshort s, GLshort t, GLshort r);
typedef void ( * PFNGLMULTITEXCOORD3SVARBPROC) (GLenum target, const GLshort *v);
typedef void ( * PFNGLMULTITEXCOORD4DARBPROC) (GLenum target, GLdouble s, GLdouble t, GLdouble r, GLdouble q);
typedef void ( * PFNGLMULTITEXCOORD4DVARBPROC) (GLenum target, const GLdouble *v);
typedef void ( * PFNGLMULTITEXCOORD4FARBPROC) (GLenum target, GLfloat s, GLfloat t, GLfloat r, GLfloat q);
typedef void ( * PFNGLMULTITEXCOORD4FVARBPROC) (GLenum target, const GLfloat *v);
typedef void ( * PFNGLMULTITEXCOORD4IARBPROC) (GLenum target, GLint s, GLint t, GLint r, GLint q);
typedef void ( * PFNGLMULTITEXCOORD4IVARBPROC) (GLenum target, const GLint *v);
typedef void ( * PFNGLMULTITEXCOORD4SARBPROC) (GLenum target, GLshort s, GLshort t, GLshort r, GLshort q);
typedef void ( * PFNGLMULTITEXCOORD4SVARBPROC) (GLenum target, const GLshort *v);
typedef void ( * PFNGLGENQUERIESARBPROC) (GLsizei n, GLuint *ids);
typedef void ( * PFNGLDELETEQUERIESARBPROC) (GLsizei n, const GLuint *ids);
typedef GLboolean ( * PFNGLISQUERYARBPROC) (GLuint id);
typedef void ( * PFNGLBEGINQUERYARBPROC) (GLenum target, GLuint id);
typedef void ( * PFNGLENDQUERYARBPROC) (GLenum target);
typedef void ( * PFNGLGETQUERYIVARBPROC) (GLenum target, GLenum pname, GLint *params);
typedef void ( * PFNGLGETQUERYOBJECTIVARBPROC) (GLuint id, GLenum pname, GLint *params);
typedef void ( * PFNGLGETQUERYOBJECTUIVARBPROC) (GLuint id, GLenum pname, GLuint *params);
typedef void ( * PFNGLMAXSHADERCOMPILERTHREADSARBPROC) (GLuint count);
typedef void ( * PFNGLPOINTPARAMETERFARBPROC) (GLenum pname, GLfloat param);
typedef void ( * PFNGLPOINTPARAMETERFVARBPROC) (GLenum pname, const GLfloat *params);
typedef GLenum ( * PFNGLGETGRAPHICSRESETSTATUSARBPROC) (void);
typedef void ( * PFNGLGETNTEXIMAGEARBPROC) (GLenum target, GLint level, GLenum format, GLenum type, GLsizei bufSize, void *img);
typedef void ( * PFNGLREADNPIXELSARBPROC) (GLint x, GLint y, GLsizei width, GLsizei height, GLenum format, GLenum type, GLsizei bufSize, void *data);
typedef void ( * PFNGLGETNCOMPRESSEDTEXIMAGEARBPROC) (GLenum target, GLint lod, GLsizei bufSize, void *img);
typedef void ( * PFNGLGETNUNIFORMFVARBPROC) (GLuint program, GLint location, GLsizei bufSize, GLfloat *params);
typedef void ( * PFNGLGETNUNIFORMIVARBPROC) (GLuint program, GLint location, GLsizei bufSize, GLint *params);
typedef void ( * PFNGLGETNUNIFORMUIVARBPROC) (GLuint program, GLint location, GLsizei bufSize, GLuint *params);
typedef void ( * PFNGLGETNUNIFORMDVARBPROC) (GLuint program, GLint location, GLsizei bufSize, GLdouble *params);
typedef void ( * PFNGLGETNMAPDVARBPROC) (GLenum target, GLenum query, GLsizei bufSize, GLdouble *v);
typedef void ( * PFNGLGETNMAPFVARBPROC) (GLenum target, GLenum query, GLsizei bufSize, GLfloat *v);
typedef void ( * PFNGLGETNMAPIVARBPROC) (GLenum target, GLenum query, GLsizei bufSize, GLint *v);
typedef void ( * PFNGLGETNPIXELMAPFVARBPROC) (GLenum map, GLsizei bufSize, GLfloat *values);
typedef void ( * PFNGLGETNPIXELMAPUIVARBPROC) (GLenum map, GLsizei bufSize, GLuint *values);
typedef void ( * PFNGLGETNPIXELMAPUSVARBPROC) (GLenum map, GLsizei bufSize, GLushort *values);
typedef void ( * PFNGLGETNPOLYGONSTIPPLEARBPROC) (GLsizei bufSize, GLubyte *pattern);
typedef void ( * PFNGLGETNCOLORTABLEARBPROC) (GLenum target, GLenum format, GLenum type, GLsizei bufSize, void *table);
typedef void ( * PFNGLGETNCONVOLUTIONFILTERARBPROC) (GLenum target, GLenum format, GLenum type, GLsizei bufSize, void *image);
typedef void ( * PFNGLGETNSEPARABLEFILTERARBPROC) (GLenum target, GLenum format, GLenum type, GLsizei rowBufSize, void *row, GLsizei columnBufSize, void *column, void *span);
typedef void ( * PFNGLGETNHISTOGRAMARBPROC) (GLenum target, GLboolean reset, GLenum format, GLenum type, GLsizei bufSize, void *values);
typedef void ( * PFNGLGETNMINMAXARBPROC) (GLenum target, GLboolean reset, GLenum format, GLenum type, GLsizei bufSize, void *values);
typedef void ( * PFNGLFRAMEBUFFERSAMPLELOCATIONSFVARBPROC) (GLenum target, GLuint start, GLsizei count, const GLfloat *v);
typedef void ( * PFNGLNAMEDFRAMEBUFFERSAMPLELOCATIONSFVARBPROC) (GLuint framebuffer, GLuint start, GLsizei count, const GLfloat *v);
typedef void ( * PFNGLEVALUATEDEPTHVALUESARBPROC) (void);
typedef void ( * PFNGLMINSAMPLESHADINGARBPROC) (GLfloat value);
typedef unsigned int GLhandleARB;
typedef char GLcharARB;
typedef void ( * PFNGLDELETEOBJECTARBPROC) (GLhandleARB obj);
typedef GLhandleARB ( * PFNGLGETHANDLEARBPROC) (GLenum pname);
typedef void ( * PFNGLDETACHOBJECTARBPROC) (GLhandleARB containerObj, GLhandleARB attachedObj);
typedef GLhandleARB ( * PFNGLCREATESHADEROBJECTARBPROC) (GLenum shaderType);
typedef void ( * PFNGLSHADERSOURCEARBPROC) (GLhandleARB shaderObj, GLsizei count, const GLcharARB **string, const GLint *length);
typedef void ( * PFNGLCOMPILESHADERARBPROC) (GLhandleARB shaderObj);
typedef GLhandleARB ( * PFNGLCREATEPROGRAMOBJECTARBPROC) (void);
typedef void ( * PFNGLATTACHOBJECTARBPROC) (GLhandleARB containerObj, GLhandleARB obj);
typedef void ( * PFNGLLINKPROGRAMARBPROC) (GLhandleARB programObj);
typedef void ( * PFNGLUSEPROGRAMOBJECTARBPROC) (GLhandleARB programObj);
typedef void ( * PFNGLVALIDATEPROGRAMARBPROC) (GLhandleARB programObj);
typedef void ( * PFNGLUNIFORM1FARBPROC) (GLint location, GLfloat v0);
typedef void ( * PFNGLUNIFORM2FARBPROC) (GLint location, GLfloat v0, GLfloat v1);
typedef void ( * PFNGLUNIFORM3FARBPROC) (GLint location, GLfloat v0, GLfloat v1, GLfloat v2);
typedef void ( * PFNGLUNIFORM4FARBPROC) (GLint location, GLfloat v0, GLfloat v1, GLfloat v2, GLfloat v3);
typedef void ( * PFNGLUNIFORM1IARBPROC) (GLint location, GLint v0);
typedef void ( * PFNGLUNIFORM2IARBPROC) (GLint location, GLint v0, GLint v1);
typedef void ( * PFNGLUNIFORM3IARBPROC) (GLint location, GLint v0, GLint v1, GLint v2);
typedef void ( * PFNGLUNIFORM4IARBPROC) (GLint location, GLint v0, GLint v1, GLint v2, GLint v3);
typedef void ( * PFNGLUNIFORM1FVARBPROC) (GLint location, GLsizei count, const GLfloat *value);
typedef void ( * PFNGLUNIFORM2FVARBPROC) (GLint location, GLsizei count, const GLfloat *value);
typedef void ( * PFNGLUNIFORM3FVARBPROC) (GLint location, GLsizei count, const GLfloat *value);
typedef void ( * PFNGLUNIFORM4FVARBPROC) (GLint location, GLsizei count, const GLfloat *value);
typedef void ( * PFNGLUNIFORM1IVARBPROC) (GLint location, GLsizei count, const GLint *value);
typedef void ( * PFNGLUNIFORM2IVARBPROC) (GLint location, GLsizei count, const GLint *value);
typedef void ( * PFNGLUNIFORM3IVARBPROC) (GLint location, GLsizei count, const GLint *value);
typedef void ( * PFNGLUNIFORM4IVARBPROC) (GLint location, GLsizei count, const GLint *value);
typedef void ( * PFNGLUNIFORMMATRIX2FVARBPROC) (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
typedef void ( * PFNGLUNIFORMMATRIX3FVARBPROC) (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
typedef void ( * PFNGLUNIFORMMATRIX4FVARBPROC) (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
typedef void ( * PFNGLGETOBJECTPARAMETERFVARBPROC) (GLhandleARB obj, GLenum pname, GLfloat *params);
typedef void ( * PFNGLGETOBJECTPARAMETERIVARBPROC) (GLhandleARB obj, GLenum pname, GLint *params);
typedef void ( * PFNGLGETINFOLOGARBPROC) (GLhandleARB obj, GLsizei maxLength, GLsizei *length, GLcharARB *infoLog);
typedef void ( * PFNGLGETATTACHEDOBJECTSARBPROC) (GLhandleARB containerObj, GLsizei maxCount, GLsizei *count, GLhandleARB *obj);
typedef GLint ( * PFNGLGETUNIFORMLOCATIONARBPROC) (GLhandleARB programObj, const GLcharARB *name);
typedef void ( * PFNGLGETACTIVEUNIFORMARBPROC) (GLhandleARB programObj, GLuint index, GLsizei maxLength, GLsizei *length, GLint *size, GLenum *type, GLcharARB *name);
typedef void ( * PFNGLGETUNIFORMFVARBPROC) (GLhandleARB programObj, GLint location, GLfloat *params);
typedef void ( * PFNGLGETUNIFORMIVARBPROC) (GLhandleARB programObj, GLint location, GLint *params);
typedef void ( * PFNGLGETSHADERSOURCEARBPROC) (GLhandleARB obj, GLsizei maxLength, GLsizei *length, GLcharARB *source);
typedef void ( * PFNGLNAMEDSTRINGARBPROC) (GLenum type, GLint namelen, const GLchar *name, GLint stringlen, const GLchar *string);
typedef void ( * PFNGLDELETENAMEDSTRINGARBPROC) (GLint namelen, const GLchar *name);
typedef void ( * PFNGLCOMPILESHADERINCLUDEARBPROC) (GLuint shader, GLsizei count, const GLchar *const*path, const GLint *length);
typedef GLboolean ( * PFNGLISNAMEDSTRINGARBPROC) (GLint namelen, const GLchar *name);
typedef void ( * PFNGLGETNAMEDSTRINGARBPROC) (GLint namelen, const GLchar *name, GLsizei bufSize, GLint *stringlen, GLchar *string);
typedef void ( * PFNGLGETNAMEDSTRINGIVARBPROC) (GLint namelen, const GLchar *name, GLenum pname, GLint *params);
typedef void ( * PFNGLBUFFERPAGECOMMITMENTARBPROC) (GLenum target, GLintptr offset, GLsizeiptr size, GLboolean commit);
typedef void ( * PFNGLNAMEDBUFFERPAGECOMMITMENTEXTPROC) (GLuint buffer, GLintptr offset, GLsizeiptr size, GLboolean commit);
typedef void ( * PFNGLNAMEDBUFFERPAGECOMMITMENTARBPROC) (GLuint buffer, GLintptr offset, GLsizeiptr size, GLboolean commit);
typedef void ( * PFNGLTEXPAGECOMMITMENTARBPROC) (GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth, GLboolean commit);
typedef void ( * PFNGLTEXBUFFERARBPROC) (GLenum target, GLenum internalformat, GLuint buffer);
typedef void ( * PFNGLCOMPRESSEDTEXIMAGE3DARBPROC) (GLenum target, GLint level, GLenum internalformat, GLsizei width, GLsizei height, GLsizei depth, GLint border, GLsizei imageSize, const void *data);
typedef void ( * PFNGLCOMPRESSEDTEXIMAGE2DARBPROC) (GLenum target, GLint level, GLenum internalformat, GLsizei width, GLsizei height, GLint border, GLsizei imageSize, const void *data);
typedef void ( * PFNGLCOMPRESSEDTEXIMAGE1DARBPROC) (GLenum target, GLint level, GLenum internalformat, GLsizei width, GLint border, GLsizei imageSize, const void *data);
typedef void ( * PFNGLCOMPRESSEDTEXSUBIMAGE3DARBPROC) (GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth, GLenum format, GLsizei imageSize, const void *data);
typedef void ( * PFNGLCOMPRESSEDTEXSUBIMAGE2DARBPROC) (GLenum target, GLint level, GLint xoffset, GLint yoffset, GLsizei width, GLsizei height, GLenum format, GLsizei imageSize, const void *data);
typedef void ( * PFNGLCOMPRESSEDTEXSUBIMAGE1DARBPROC) (GLenum target, GLint level, GLint xoffset, GLsizei width, GLenum format, GLsizei imageSize, const void *data);
typedef void ( * PFNGLGETCOMPRESSEDTEXIMAGEARBPROC) (GLenum target, GLint level, void *img);
typedef void ( * PFNGLLOADTRANSPOSEMATRIXFARBPROC) (const GLfloat *m);
typedef void ( * PFNGLLOADTRANSPOSEMATRIXDARBPROC) (const GLdouble *m);
typedef void ( * PFNGLMULTTRANSPOSEMATRIXFARBPROC) (const GLfloat *m);
typedef void ( * PFNGLMULTTRANSPOSEMATRIXDARBPROC) (const GLdouble *m);
typedef void ( * PFNGLWEIGHTBVARBPROC) (GLint size, const GLbyte *weights);
typedef void ( * PFNGLWEIGHTSVARBPROC) (GLint size, const GLshort *weights);
typedef void ( * PFNGLWEIGHTIVARBPROC) (GLint size, const GLint *weights);
typedef void ( * PFNGLWEIGHTFVARBPROC) (GLint size, const GLfloat *weights);
typedef void ( * PFNGLWEIGHTDVARBPROC) (GLint size, const GLdouble *weights);
typedef void ( * PFNGLWEIGHTUBVARBPROC) (GLint size, const GLubyte *weights);
typedef void ( * PFNGLWEIGHTUSVARBPROC) (GLint size, const GLushort *weights);
typedef void ( * PFNGLWEIGHTUIVARBPROC) (GLint size, const GLuint *weights);
typedef void ( * PFNGLWEIGHTPOINTERARBPROC) (GLint size, GLenum type, GLsizei stride, const void *pointer);
typedef void ( * PFNGLVERTEXBLENDARBPROC) (GLint count);
typedef khronos_ssize_t GLsizeiptrARB;
typedef khronos_intptr_t GLintptrARB;
typedef void ( * PFNGLBINDBUFFERARBPROC) (GLenum target, GLuint buffer);
typedef void ( * PFNGLDELETEBUFFERSARBPROC) (GLsizei n, const GLuint *buffers);
typedef void ( * PFNGLGENBUFFERSARBPROC) (GLsizei n, GLuint *buffers);
typedef GLboolean ( * PFNGLISBUFFERARBPROC) (GLuint buffer);
typedef void ( * PFNGLBUFFERDATAARBPROC) (GLenum target, GLsizeiptrARB size, const void *data, GLenum usage);
typedef void ( * PFNGLBUFFERSUBDATAARBPROC) (GLenum target, GLintptrARB offset, GLsizeiptrARB size, const void *data);
typedef void ( * PFNGLGETBUFFERSUBDATAARBPROC) (GLenum target, GLintptrARB offset, GLsizeiptrARB size, void *data);
typedef void *( * PFNGLMAPBUFFERARBPROC) (GLenum target, GLenum access);
typedef GLboolean ( * PFNGLUNMAPBUFFERARBPROC) (GLenum target);
typedef void ( * PFNGLGETBUFFERPARAMETERIVARBPROC) (GLenum target, GLenum pname, GLint *params);
typedef void ( * PFNGLGETBUFFERPOINTERVARBPROC) (GLenum target, GLenum pname, void **params);
typedef void ( * PFNGLVERTEXATTRIB1DARBPROC) (GLuint index, GLdouble x);
typedef void ( * PFNGLVERTEXATTRIB1DVARBPROC) (GLuint index, const GLdouble *v);
typedef void ( * PFNGLVERTEXATTRIB1FARBPROC) (GLuint index, GLfloat x);
typedef void ( * PFNGLVERTEXATTRIB1FVARBPROC) (GLuint index, const GLfloat *v);
typedef void ( * PFNGLVERTEXATTRIB1SARBPROC) (GLuint index, GLshort x);
typedef void ( * PFNGLVERTEXATTRIB1SVARBPROC) (GLuint index, const GLshort *v);
typedef void ( * PFNGLVERTEXATTRIB2DARBPROC) (GLuint index, GLdouble x, GLdouble y);
typedef void ( * PFNGLVERTEXATTRIB2DVARBPROC) (GLuint index, const GLdouble *v);
typedef void ( * PFNGLVERTEXATTRIB2FARBPROC) (GLuint index, GLfloat x, GLfloat y);
typedef void ( * PFNGLVERTEXATTRIB2FVARBPROC) (GLuint index, const GLfloat *v);
typedef void ( * PFNGLVERTEXATTRIB2SARBPROC) (GLuint index, GLshort x, GLshort y);
typedef void ( * PFNGLVERTEXATTRIB2SVARBPROC) (GLuint index, const GLshort *v);
typedef void ( * PFNGLVERTEXATTRIB3DARBPROC) (GLuint index, GLdouble x, GLdouble y, GLdouble z);
typedef void ( * PFNGLVERTEXATTRIB3DVARBPROC) (GLuint index, const GLdouble *v);
typedef void ( * PFNGLVERTEXATTRIB3FARBPROC) (GLuint index, GLfloat x, GLfloat y, GLfloat z);
typedef void ( * PFNGLVERTEXATTRIB3FVARBPROC) (GLuint index, const GLfloat *v);
typedef void ( * PFNGLVERTEXATTRIB3SARBPROC) (GLuint index, GLshort x, GLshort y, GLshort z);
typedef void ( * PFNGLVERTEXATTRIB3SVARBPROC) (GLuint index, const GLshort *v);
typedef void ( * PFNGLVERTEXATTRIB4NBVARBPROC) (GLuint index, const GLbyte *v);
typedef void ( * PFNGLVERTEXATTRIB4NIVARBPROC) (GLuint index, const GLint *v);
typedef void ( * PFNGLVERTEXATTRIB4NSVARBPROC) (GLuint index, const GLshort *v);
typedef void ( * PFNGLVERTEXATTRIB4NUBARBPROC) (GLuint index, GLubyte x, GLubyte y, GLubyte z, GLubyte w);
typedef void ( * PFNGLVERTEXATTRIB4NUBVARBPROC) (GLuint index, const GLubyte *v);
typedef void ( * PFNGLVERTEXATTRIB4NUIVARBPROC) (GLuint index, const GLuint *v);
typedef void ( * PFNGLVERTEXATTRIB4NUSVARBPROC) (GLuint index, const GLushort *v);
typedef void ( * PFNGLVERTEXATTRIB4BVARBPROC) (GLuint index, const GLbyte *v);
typedef void ( * PFNGLVERTEXATTRIB4DARBPROC) (GLuint index, GLdouble x, GLdouble y, GLdouble z, GLdouble w);
typedef void ( * PFNGLVERTEXATTRIB4DVARBPROC) (GLuint index, const GLdouble *v);
typedef void ( * PFNGLVERTEXATTRIB4FARBPROC) (GLuint index, GLfloat x, GLfloat y, GLfloat z, GLfloat w);
typedef void ( * PFNGLVERTEXATTRIB4FVARBPROC) (GLuint index, const GLfloat *v);
typedef void ( * PFNGLVERTEXATTRIB4IVARBPROC) (GLuint index, const GLint *v);
typedef void ( * PFNGLVERTEXATTRIB4SARBPROC) (GLuint index, GLshort x, GLshort y, GLshort z, GLshort w);
typedef void ( * PFNGLVERTEXATTRIB4SVARBPROC) (GLuint index, const GLshort *v);
typedef void ( * PFNGLVERTEXATTRIB4UBVARBPROC) (GLuint index, const GLubyte *v);
typedef void ( * PFNGLVERTEXATTRIB4UIVARBPROC) (GLuint index, const GLuint *v);
typedef void ( * PFNGLVERTEXATTRIB4USVARBPROC) (GLuint index, const GLushort *v);
typedef void ( * PFNGLVERTEXATTRIBPOINTERARBPROC) (GLuint index, GLint size, GLenum type, GLboolean normalized, GLsizei stride, const void *pointer);
typedef void ( * PFNGLENABLEVERTEXATTRIBARRAYARBPROC) (GLuint index);
typedef void ( * PFNGLDISABLEVERTEXATTRIBARRAYARBPROC) (GLuint index);
typedef void ( * PFNGLGETVERTEXATTRIBDVARBPROC) (GLuint index, GLenum pname, GLdouble *params);
typedef void ( * PFNGLGETVERTEXATTRIBFVARBPROC) (GLuint index, GLenum pname, GLfloat *params);
typedef void ( * PFNGLGETVERTEXATTRIBIVARBPROC) (GLuint index, GLenum pname, GLint *params);
typedef void ( * PFNGLGETVERTEXATTRIBPOINTERVARBPROC) (GLuint index, GLenum pname, void **pointer);
typedef void ( * PFNGLBINDATTRIBLOCATIONARBPROC) (GLhandleARB programObj, GLuint index, const GLcharARB *name);
typedef void ( * PFNGLGETACTIVEATTRIBARBPROC) (GLhandleARB programObj, GLuint index, GLsizei maxLength, GLsizei *length, GLint *size, GLenum *type, GLcharARB *name);
typedef GLint ( * PFNGLGETATTRIBLOCATIONARBPROC) (GLhandleARB programObj, const GLcharARB *name);
typedef void ( * PFNGLDEPTHRANGEARRAYDVNVPROC) (GLuint first, GLsizei count, const GLdouble *v);
typedef void ( * PFNGLDEPTHRANGEINDEXEDDNVPROC) (GLuint index, GLdouble n, GLdouble f);
typedef void ( * PFNGLWINDOWPOS2DARBPROC) (GLdouble x, GLdouble y);
typedef void ( * PFNGLWINDOWPOS2DVARBPROC) (const GLdouble *v);
typedef void ( * PFNGLWINDOWPOS2FARBPROC) (GLfloat x, GLfloat y);
typedef void ( * PFNGLWINDOWPOS2FVARBPROC) (const GLfloat *v);
typedef void ( * PFNGLWINDOWPOS2IARBPROC) (GLint x, GLint y);
typedef void ( * PFNGLWINDOWPOS2IVARBPROC) (const GLint *v);
typedef void ( * PFNGLWINDOWPOS2SARBPROC) (GLshort x, GLshort y);
typedef void ( * PFNGLWINDOWPOS2SVARBPROC) (const GLshort *v);
typedef void ( * PFNGLWINDOWPOS3DARBPROC) (GLdouble x, GLdouble y, GLdouble z);
typedef void ( * PFNGLWINDOWPOS3DVARBPROC) (const GLdouble *v);
typedef void ( * PFNGLWINDOWPOS3FARBPROC) (GLfloat x, GLfloat y, GLfloat z);
typedef void ( * PFNGLWINDOWPOS3FVARBPROC) (const GLfloat *v);
typedef void ( * PFNGLWINDOWPOS3IARBPROC) (GLint x, GLint y, GLint z);
typedef void ( * PFNGLWINDOWPOS3IVARBPROC) (const GLint *v);
typedef void ( * PFNGLWINDOWPOS3SARBPROC) (GLshort x, GLshort y, GLshort z);
typedef void ( * PFNGLWINDOWPOS3SVARBPROC) (const GLshort *v);
typedef void ( * PFNGLBLENDBARRIERKHRPROC) (void);
typedef void ( * PFNGLMAXSHADERCOMPILERTHREADSKHRPROC) (GLuint count);
typedef void ( * PFNGLMULTITEXCOORD1BOESPROC) (GLenum texture, GLbyte s);
typedef void ( * PFNGLMULTITEXCOORD1BVOESPROC) (GLenum texture, const GLbyte *coords);
typedef void ( * PFNGLMULTITEXCOORD2BOESPROC) (GLenum texture, GLbyte s, GLbyte t);
typedef void ( * PFNGLMULTITEXCOORD2BVOESPROC) (GLenum texture, const GLbyte *coords);
typedef void ( * PFNGLMULTITEXCOORD3BOESPROC) (GLenum texture, GLbyte s, GLbyte t, GLbyte r);
typedef void ( * PFNGLMULTITEXCOORD3BVOESPROC) (GLenum texture, const GLbyte *coords);
typedef void ( * PFNGLMULTITEXCOORD4BOESPROC) (GLenum texture, GLbyte s, GLbyte t, GLbyte r, GLbyte q);
typedef void ( * PFNGLMULTITEXCOORD4BVOESPROC) (GLenum texture, const GLbyte *coords);
typedef void ( * PFNGLTEXCOORD1BOESPROC) (GLbyte s);
typedef void ( * PFNGLTEXCOORD1BVOESPROC) (const GLbyte *coords);
typedef void ( * PFNGLTEXCOORD2BOESPROC) (GLbyte s, GLbyte t);
typedef void ( * PFNGLTEXCOORD2BVOESPROC) (const GLbyte *coords);
typedef void ( * PFNGLTEXCOORD3BOESPROC) (GLbyte s, GLbyte t, GLbyte r);
typedef void ( * PFNGLTEXCOORD3BVOESPROC) (const GLbyte *coords);
typedef void ( * PFNGLTEXCOORD4BOESPROC) (GLbyte s, GLbyte t, GLbyte r, GLbyte q);
typedef void ( * PFNGLTEXCOORD4BVOESPROC) (const GLbyte *coords);
typedef void ( * PFNGLVERTEX2BOESPROC) (GLbyte x, GLbyte y);
typedef void ( * PFNGLVERTEX2BVOESPROC) (const GLbyte *coords);
typedef void ( * PFNGLVERTEX3BOESPROC) (GLbyte x, GLbyte y, GLbyte z);
typedef void ( * PFNGLVERTEX3BVOESPROC) (const GLbyte *coords);
typedef void ( * PFNGLVERTEX4BOESPROC) (GLbyte x, GLbyte y, GLbyte z, GLbyte w);
typedef void ( * PFNGLVERTEX4BVOESPROC) (const GLbyte *coords);
typedef khronos_int32_t GLfixed;
typedef void ( * PFNGLALPHAFUNCXOESPROC) (GLenum func, GLfixed ref);
typedef void ( * PFNGLCLEARCOLORXOESPROC) (GLfixed red, GLfixed green, GLfixed blue, GLfixed alpha);
typedef void ( * PFNGLCLEARDEPTHXOESPROC) (GLfixed depth);
typedef void ( * PFNGLCLIPPLANEXOESPROC) (GLenum plane, const GLfixed *equation);
typedef void ( * PFNGLCOLOR4XOESPROC) (GLfixed red, GLfixed green, GLfixed blue, GLfixed alpha);
typedef void ( * PFNGLDEPTHRANGEXOESPROC) (GLfixed n, GLfixed f);
typedef void ( * PFNGLFOGXOESPROC) (GLenum pname, GLfixed param);
typedef void ( * PFNGLFOGXVOESPROC) (GLenum pname, const GLfixed *param);
typedef void ( * PFNGLFRUSTUMXOESPROC) (GLfixed l, GLfixed r, GLfixed b, GLfixed t, GLfixed n, GLfixed f);
typedef void ( * PFNGLGETCLIPPLANEXOESPROC) (GLenum plane, GLfixed *equation);
typedef void ( * PFNGLGETFIXEDVOESPROC) (GLenum pname, GLfixed *params);
typedef void ( * PFNGLGETTEXENVXVOESPROC) (GLenum target, GLenum pname, GLfixed *params);
typedef void ( * PFNGLGETTEXPARAMETERXVOESPROC) (GLenum target, GLenum pname, GLfixed *params);
typedef void ( * PFNGLLIGHTMODELXOESPROC) (GLenum pname, GLfixed param);
typedef void ( * PFNGLLIGHTMODELXVOESPROC) (GLenum pname, const GLfixed *param);
typedef void ( * PFNGLLIGHTXOESPROC) (GLenum light, GLenum pname, GLfixed param);
typedef void ( * PFNGLLIGHTXVOESPROC) (GLenum light, GLenum pname, const GLfixed *params);
typedef void ( * PFNGLLINEWIDTHXOESPROC) (GLfixed width);
typedef void ( * PFNGLLOADMATRIXXOESPROC) (const GLfixed *m);
typedef void ( * PFNGLMATERIALXOESPROC) (GLenum face, GLenum pname, GLfixed param);
typedef void ( * PFNGLMATERIALXVOESPROC) (GLenum face, GLenum pname, const GLfixed *param);
typedef void ( * PFNGLMULTMATRIXXOESPROC) (const GLfixed *m);
typedef void ( * PFNGLMULTITEXCOORD4XOESPROC) (GLenum texture, GLfixed s, GLfixed t, GLfixed r, GLfixed q);
typedef void ( * PFNGLNORMAL3XOESPROC) (GLfixed nx, GLfixed ny, GLfixed nz);
typedef void ( * PFNGLORTHOXOESPROC) (GLfixed l, GLfixed r, GLfixed b, GLfixed t, GLfixed n, GLfixed f);
typedef void ( * PFNGLPOINTPARAMETERXVOESPROC) (GLenum pname, const GLfixed *params);
typedef void ( * PFNGLPOINTSIZEXOESPROC) (GLfixed size);
typedef void ( * PFNGLPOLYGONOFFSETXOESPROC) (GLfixed factor, GLfixed units);
typedef void ( * PFNGLROTATEXOESPROC) (GLfixed angle, GLfixed x, GLfixed y, GLfixed z);
typedef void ( * PFNGLSCALEXOESPROC) (GLfixed x, GLfixed y, GLfixed z);
typedef void ( * PFNGLTEXENVXOESPROC) (GLenum target, GLenum pname, GLfixed param);
typedef void ( * PFNGLTEXENVXVOESPROC) (GLenum target, GLenum pname, const GLfixed *params);
typedef void ( * PFNGLTEXPARAMETERXOESPROC) (GLenum target, GLenum pname, GLfixed param);
typedef void ( * PFNGLTEXPARAMETERXVOESPROC) (GLenum target, GLenum pname, const GLfixed *params);
typedef void ( * PFNGLTRANSLATEXOESPROC) (GLfixed x, GLfixed y, GLfixed z);
typedef void ( * PFNGLACCUMXOESPROC) (GLenum op, GLfixed value);
typedef void ( * PFNGLBITMAPXOESPROC) (GLsizei width, GLsizei height, GLfixed xorig, GLfixed yorig, GLfixed xmove, GLfixed ymove, const GLubyte *bitmap);
typedef void ( * PFNGLBLENDCOLORXOESPROC) (GLfixed red, GLfixed green, GLfixed blue, GLfixed alpha);
typedef void ( * PFNGLCLEARACCUMXOESPROC) (GLfixed red, GLfixed green, GLfixed blue, GLfixed alpha);
typedef void ( * PFNGLCOLOR3XOESPROC) (GLfixed red, GLfixed green, GLfixed blue);
typedef void ( * PFNGLCOLOR3XVOESPROC) (const GLfixed *components);
typedef void ( * PFNGLCOLOR4XVOESPROC) (const GLfixed *components);
typedef void ( * PFNGLCONVOLUTIONPARAMETERXOESPROC) (GLenum target, GLenum pname, GLfixed param);
typedef void ( * PFNGLCONVOLUTIONPARAMETERXVOESPROC) (GLenum target, GLenum pname, const GLfixed *params);
typedef void ( * PFNGLEVALCOORD1XOESPROC) (GLfixed u);
typedef void ( * PFNGLEVALCOORD1XVOESPROC) (const GLfixed *coords);
typedef void ( * PFNGLEVALCOORD2XOESPROC) (GLfixed u, GLfixed v);
typedef void ( * PFNGLEVALCOORD2XVOESPROC) (const GLfixed *coords);
typedef void ( * PFNGLFEEDBACKBUFFERXOESPROC) (GLsizei n, GLenum type, const GLfixed *buffer);
typedef void ( * PFNGLGETCONVOLUTIONPARAMETERXVOESPROC) (GLenum target, GLenum pname, GLfixed *params);
typedef void ( * PFNGLGETHISTOGRAMPARAMETERXVOESPROC) (GLenum target, GLenum pname, GLfixed *params);
typedef void ( * PFNGLGETLIGHTXOESPROC) (GLenum light, GLenum pname, GLfixed *params);
typedef void ( * PFNGLGETMAPXVOESPROC) (GLenum target, GLenum query, GLfixed *v);
typedef void ( * PFNGLGETMATERIALXOESPROC) (GLenum face, GLenum pname, GLfixed param);
typedef void ( * PFNGLGETPIXELMAPXVPROC) (GLenum map, GLint size, GLfixed *values);
typedef void ( * PFNGLGETTEXGENXVOESPROC) (GLenum coord, GLenum pname, GLfixed *params);
typedef void ( * PFNGLGETTEXLEVELPARAMETERXVOESPROC) (GLenum target, GLint level, GLenum pname, GLfixed *params);
typedef void ( * PFNGLINDEXXOESPROC) (GLfixed component);
typedef void ( * PFNGLINDEXXVOESPROC) (const GLfixed *component);
typedef void ( * PFNGLLOADTRANSPOSEMATRIXXOESPROC) (const GLfixed *m);
typedef void ( * PFNGLMAP1XOESPROC) (GLenum target, GLfixed u1, GLfixed u2, GLint stride, GLint order, GLfixed points);
typedef void ( * PFNGLMAP2XOESPROC) (GLenum target, GLfixed u1, GLfixed u2, GLint ustride, GLint uorder, GLfixed v1, GLfixed v2, GLint vstride, GLint vorder, GLfixed points);
typedef void ( * PFNGLMAPGRID1XOESPROC) (GLint n, GLfixed u1, GLfixed u2);
typedef void ( * PFNGLMAPGRID2XOESPROC) (GLint n, GLfixed u1, GLfixed u2, GLfixed v1, GLfixed v2);
typedef void ( * PFNGLMULTTRANSPOSEMATRIXXOESPROC) (const GLfixed *m);
typedef void ( * PFNGLMULTITEXCOORD1XOESPROC) (GLenum texture, GLfixed s);
typedef void ( * PFNGLMULTITEXCOORD1XVOESPROC) (GLenum texture, const GLfixed *coords);
typedef void ( * PFNGLMULTITEXCOORD2XOESPROC) (GLenum texture, GLfixed s, GLfixed t);
typedef void ( * PFNGLMULTITEXCOORD2XVOESPROC) (GLenum texture, const GLfixed *coords);
typedef void ( * PFNGLMULTITEXCOORD3XOESPROC) (GLenum texture, GLfixed s, GLfixed t, GLfixed r);
typedef void ( * PFNGLMULTITEXCOORD3XVOESPROC) (GLenum texture, const GLfixed *coords);
typedef void ( * PFNGLMULTITEXCOORD4XVOESPROC) (GLenum texture, const GLfixed *coords);
typedef void ( * PFNGLNORMAL3XVOESPROC) (const GLfixed *coords);
typedef void ( * PFNGLPASSTHROUGHXOESPROC) (GLfixed token);
typedef void ( * PFNGLPIXELMAPXPROC) (GLenum map, GLint size, const GLfixed *values);
typedef void ( * PFNGLPIXELSTOREXPROC) (GLenum pname, GLfixed param);
typedef void ( * PFNGLPIXELTRANSFERXOESPROC) (GLenum pname, GLfixed param);
typedef void ( * PFNGLPIXELZOOMXOESPROC) (GLfixed xfactor, GLfixed yfactor);
typedef void ( * PFNGLPRIORITIZETEXTURESXOESPROC) (GLsizei n, const GLuint *textures, const GLfixed *priorities);
typedef void ( * PFNGLRASTERPOS2XOESPROC) (GLfixed x, GLfixed y);
typedef void ( * PFNGLRASTERPOS2XVOESPROC) (const GLfixed *coords);
typedef void ( * PFNGLRASTERPOS3XOESPROC) (GLfixed x, GLfixed y, GLfixed z);
typedef void ( * PFNGLRASTERPOS3XVOESPROC) (const GLfixed *coords);
typedef void ( * PFNGLRASTERPOS4XOESPROC) (GLfixed x, GLfixed y, GLfixed z, GLfixed w);
typedef void ( * PFNGLRASTERPOS4XVOESPROC) (const GLfixed *coords);
typedef void ( * PFNGLRECTXOESPROC) (GLfixed x1, GLfixed y1, GLfixed x2, GLfixed y2);
typedef void ( * PFNGLRECTXVOESPROC) (const GLfixed *v1, const GLfixed *v2);
typedef void ( * PFNGLTEXCOORD1XOESPROC) (GLfixed s);
typedef void ( * PFNGLTEXCOORD1XVOESPROC) (const GLfixed *coords);
typedef void ( * PFNGLTEXCOORD2XOESPROC) (GLfixed s, GLfixed t);
typedef void ( * PFNGLTEXCOORD2XVOESPROC) (const GLfixed *coords);
typedef void ( * PFNGLTEXCOORD3XOESPROC) (GLfixed s, GLfixed t, GLfixed r);
typedef void ( * PFNGLTEXCOORD3XVOESPROC) (const GLfixed *coords);
typedef void ( * PFNGLTEXCOORD4XOESPROC) (GLfixed s, GLfixed t, GLfixed r, GLfixed q);
typedef void ( * PFNGLTEXCOORD4XVOESPROC) (const GLfixed *coords);
typedef void ( * PFNGLTEXGENXOESPROC) (GLenum coord, GLenum pname, GLfixed param);
typedef void ( * PFNGLTEXGENXVOESPROC) (GLenum coord, GLenum pname, const GLfixed *params);
typedef void ( * PFNGLVERTEX2XOESPROC) (GLfixed x);
typedef void ( * PFNGLVERTEX2XVOESPROC) (const GLfixed *coords);
typedef void ( * PFNGLVERTEX3XOESPROC) (GLfixed x, GLfixed y);
typedef void ( * PFNGLVERTEX3XVOESPROC) (const GLfixed *coords);
typedef void ( * PFNGLVERTEX4XOESPROC) (GLfixed x, GLfixed y, GLfixed z);
typedef void ( * PFNGLVERTEX4XVOESPROC) (const GLfixed *coords);
typedef GLbitfield ( * PFNGLQUERYMATRIXXOESPROC) (GLfixed *mantissa, GLint *exponent);
typedef void ( * PFNGLCLEARDEPTHFOESPROC) (GLclampf depth);
typedef void ( * PFNGLCLIPPLANEFOESPROC) (GLenum plane, const GLfloat *equation);
typedef void ( * PFNGLDEPTHRANGEFOESPROC) (GLclampf n, GLclampf f);
typedef void ( * PFNGLFRUSTUMFOESPROC) (GLfloat l, GLfloat r, GLfloat b, GLfloat t, GLfloat n, GLfloat f);
typedef void ( * PFNGLGETCLIPPLANEFOESPROC) (GLenum plane, GLfloat *equation);
typedef void ( * PFNGLORTHOFOESPROC) (GLfloat l, GLfloat r, GLfloat b, GLfloat t, GLfloat n, GLfloat f);
typedef void ( * PFNGLTBUFFERMASK3DFXPROC) (GLuint mask);
typedef void ( *GLDEBUGPROCAMD)(GLuint id,GLenum category,GLenum severity,GLsizei length,const GLchar *message,void *userParam);
typedef void ( * PFNGLDEBUGMESSAGEENABLEAMDPROC) (GLenum category, GLenum severity, GLsizei count, const GLuint *ids, GLboolean enabled);
typedef void ( * PFNGLDEBUGMESSAGEINSERTAMDPROC) (GLenum category, GLenum severity, GLuint id, GLsizei length, const GLchar *buf);
typedef void ( * PFNGLDEBUGMESSAGECALLBACKAMDPROC) (GLDEBUGPROCAMD callback, void *userParam);
typedef GLuint ( * PFNGLGETDEBUGMESSAGELOGAMDPROC) (GLuint count, GLsizei bufSize, GLenum *categories, GLuint *severities, GLuint *ids, GLsizei *lengths, GLchar *message);
typedef void ( * PFNGLBLENDFUNCINDEXEDAMDPROC) (GLuint buf, GLenum src, GLenum dst);
typedef void ( * PFNGLBLENDFUNCSEPARATEINDEXEDAMDPROC) (GLuint buf, GLenum srcRGB, GLenum dstRGB, GLenum srcAlpha, GLenum dstAlpha);
typedef void ( * PFNGLBLENDEQUATIONINDEXEDAMDPROC) (GLuint buf, GLenum mode);
typedef void ( * PFNGLBLENDEQUATIONSEPARATEINDEXEDAMDPROC) (GLuint buf, GLenum modeRGB, GLenum modeAlpha);
typedef void ( * PFNGLRENDERBUFFERSTORAGEMULTISAMPLEADVANCEDAMDPROC) (GLenum target, GLsizei samples, GLsizei storageSamples, GLenum internalformat, GLsizei width, GLsizei height);
typedef void ( * PFNGLNAMEDRENDERBUFFERSTORAGEMULTISAMPLEADVANCEDAMDPROC) (GLuint renderbuffer, GLsizei samples, GLsizei storageSamples, GLenum internalformat, GLsizei width, GLsizei height);
typedef void ( * PFNGLFRAMEBUFFERSAMPLEPOSITIONSFVAMDPROC) (GLenum target, GLuint numsamples, GLuint pixelindex, const GLfloat *values);
typedef void ( * PFNGLNAMEDFRAMEBUFFERSAMPLEPOSITIONSFVAMDPROC) (GLuint framebuffer, GLuint numsamples, GLuint pixelindex, const GLfloat *values);
typedef void ( * PFNGLGETFRAMEBUFFERPARAMETERFVAMDPROC) (GLenum target, GLenum pname, GLuint numsamples, GLuint pixelindex, GLsizei size, GLfloat *values);
typedef void ( * PFNGLGETNAMEDFRAMEBUFFERPARAMETERFVAMDPROC) (GLuint framebuffer, GLenum pname, GLuint numsamples, GLuint pixelindex, GLsizei size, GLfloat *values);
typedef khronos_int64_t GLint64EXT;
typedef void ( * PFNGLUNIFORM1I64NVPROC) (GLint location, GLint64EXT x);
typedef void ( * PFNGLUNIFORM2I64NVPROC) (GLint location, GLint64EXT x, GLint64EXT y);
typedef void ( * PFNGLUNIFORM3I64NVPROC) (GLint location, GLint64EXT x, GLint64EXT y, GLint64EXT z);
typedef void ( * PFNGLUNIFORM4I64NVPROC) (GLint location, GLint64EXT x, GLint64EXT y, GLint64EXT z, GLint64EXT w);
typedef void ( * PFNGLUNIFORM1I64VNVPROC) (GLint location, GLsizei count, const GLint64EXT *value);
typedef void ( * PFNGLUNIFORM2I64VNVPROC) (GLint location, GLsizei count, const GLint64EXT *value);
typedef void ( * PFNGLUNIFORM3I64VNVPROC) (GLint location, GLsizei count, const GLint64EXT *value);
typedef void ( * PFNGLUNIFORM4I64VNVPROC) (GLint location, GLsizei count, const GLint64EXT *value);
typedef void ( * PFNGLUNIFORM1UI64NVPROC) (GLint location, GLuint64EXT x);
typedef void ( * PFNGLUNIFORM2UI64NVPROC) (GLint location, GLuint64EXT x, GLuint64EXT y);
typedef void ( * PFNGLUNIFORM3UI64NVPROC) (GLint location, GLuint64EXT x, GLuint64EXT y, GLuint64EXT z);
typedef void ( * PFNGLUNIFORM4UI64NVPROC) (GLint location, GLuint64EXT x, GLuint64EXT y, GLuint64EXT z, GLuint64EXT w);
typedef void ( * PFNGLUNIFORM1UI64VNVPROC) (GLint location, GLsizei count, const GLuint64EXT *value);
typedef void ( * PFNGLUNIFORM2UI64VNVPROC) (GLint location, GLsizei count, const GLuint64EXT *value);
typedef void ( * PFNGLUNIFORM3UI64VNVPROC) (GLint location, GLsizei count, const GLuint64EXT *value);
typedef void ( * PFNGLUNIFORM4UI64VNVPROC) (GLint location, GLsizei count, const GLuint64EXT *value);
typedef void ( * PFNGLGETUNIFORMI64VNVPROC) (GLuint program, GLint location, GLint64EXT *params);
typedef void ( * PFNGLGETUNIFORMUI64VNVPROC) (GLuint program, GLint location, GLuint64EXT *params);
typedef void ( * PFNGLPROGRAMUNIFORM1I64NVPROC) (GLuint program, GLint location, GLint64EXT x);
typedef void ( * PFNGLPROGRAMUNIFORM2I64NVPROC) (GLuint program, GLint location, GLint64EXT x, GLint64EXT y);
typedef void ( * PFNGLPROGRAMUNIFORM3I64NVPROC) (GLuint program, GLint location, GLint64EXT x, GLint64EXT y, GLint64EXT z);
typedef void ( * PFNGLPROGRAMUNIFORM4I64NVPROC) (GLuint program, GLint location, GLint64EXT x, GLint64EXT y, GLint64EXT z, GLint64EXT w);
typedef void ( * PFNGLPROGRAMUNIFORM1I64VNVPROC) (GLuint program, GLint location, GLsizei count, const GLint64EXT *value);
typedef void ( * PFNGLPROGRAMUNIFORM2I64VNVPROC) (GLuint program, GLint location, GLsizei count, const GLint64EXT *value);
typedef void ( * PFNGLPROGRAMUNIFORM3I64VNVPROC) (GLuint program, GLint location, GLsizei count, const GLint64EXT *value);
typedef void ( * PFNGLPROGRAMUNIFORM4I64VNVPROC) (GLuint program, GLint location, GLsizei count, const GLint64EXT *value);
typedef void ( * PFNGLPROGRAMUNIFORM1UI64NVPROC) (GLuint program, GLint location, GLuint64EXT x);
typedef void ( * PFNGLPROGRAMUNIFORM2UI64NVPROC) (GLuint program, GLint location, GLuint64EXT x, GLuint64EXT y);
typedef void ( * PFNGLPROGRAMUNIFORM3UI64NVPROC) (GLuint program, GLint location, GLuint64EXT x, GLuint64EXT y, GLuint64EXT z);
typedef void ( * PFNGLPROGRAMUNIFORM4UI64NVPROC) (GLuint program, GLint location, GLuint64EXT x, GLuint64EXT y, GLuint64EXT z, GLuint64EXT w);
typedef void ( * PFNGLPROGRAMUNIFORM1UI64VNVPROC) (GLuint program, GLint location, GLsizei count, const GLuint64EXT *value);
typedef void ( * PFNGLPROGRAMUNIFORM2UI64VNVPROC) (GLuint program, GLint location, GLsizei count, const GLuint64EXT *value);
typedef void ( * PFNGLPROGRAMUNIFORM3UI64VNVPROC) (GLuint program, GLint location, GLsizei count, const GLuint64EXT *value);
typedef void ( * PFNGLPROGRAMUNIFORM4UI64VNVPROC) (GLuint program, GLint location, GLsizei count, const GLuint64EXT *value);
typedef void ( * PFNGLVERTEXATTRIBPARAMETERIAMDPROC) (GLuint index, GLenum pname, GLint param);
typedef void ( * PFNGLMULTIDRAWARRAYSINDIRECTAMDPROC) (GLenum mode, const void *indirect, GLsizei primcount, GLsizei stride);
typedef void ( * PFNGLMULTIDRAWELEMENTSINDIRECTAMDPROC) (GLenum mode, GLenum type, const void *indirect, GLsizei primcount, GLsizei stride);
typedef void ( * PFNGLGENNAMESAMDPROC) (GLenum identifier, GLuint num, GLuint *names);
typedef void ( * PFNGLDELETENAMESAMDPROC) (GLenum identifier, GLuint num, const GLuint *names);
typedef GLboolean ( * PFNGLISNAMEAMDPROC) (GLenum identifier, GLuint name);
typedef void ( * PFNGLQUERYOBJECTPARAMETERUIAMDPROC) (GLenum target, GLuint id, GLenum pname, GLuint param);
typedef void ( * PFNGLGETPERFMONITORGROUPSAMDPROC) (GLint *numGroups, GLsizei groupsSize, GLuint *groups);
typedef void ( * PFNGLGETPERFMONITORCOUNTERSAMDPROC) (GLuint group, GLint *numCounters, GLint *maxActiveCounters, GLsizei counterSize, GLuint *counters);
typedef void ( * PFNGLGETPERFMONITORGROUPSTRINGAMDPROC) (GLuint group, GLsizei bufSize, GLsizei *length, GLchar *groupString);
typedef void ( * PFNGLGETPERFMONITORCOUNTERSTRINGAMDPROC) (GLuint group, GLuint counter, GLsizei bufSize, GLsizei *length, GLchar *counterString);
typedef void ( * PFNGLGETPERFMONITORCOUNTERINFOAMDPROC) (GLuint group, GLuint counter, GLenum pname, void *data);
typedef void ( * PFNGLGENPERFMONITORSAMDPROC) (GLsizei n, GLuint *monitors);
typedef void ( * PFNGLDELETEPERFMONITORSAMDPROC) (GLsizei n, GLuint *monitors);
typedef void ( * PFNGLSELECTPERFMONITORCOUNTERSAMDPROC) (GLuint monitor, GLboolean enable, GLuint group, GLint numCounters, GLuint *counterList);
typedef void ( * PFNGLBEGINPERFMONITORAMDPROC) (GLuint monitor);
typedef void ( * PFNGLENDPERFMONITORAMDPROC) (GLuint monitor);
typedef void ( * PFNGLGETPERFMONITORCOUNTERDATAAMDPROC) (GLuint monitor, GLenum pname, GLsizei dataSize, GLuint *data, GLint *bytesWritten);
typedef void ( * PFNGLSETMULTISAMPLEFVAMDPROC) (GLenum pname, GLuint index, const GLfloat *val);
typedef void ( * PFNGLTEXSTORAGESPARSEAMDPROC) (GLenum target, GLenum internalFormat, GLsizei width, GLsizei height, GLsizei depth, GLsizei layers, GLbitfield flags);
typedef void ( * PFNGLTEXTURESTORAGESPARSEAMDPROC) (GLuint texture, GLenum target, GLenum internalFormat, GLsizei width, GLsizei height, GLsizei depth, GLsizei layers, GLbitfield flags);
typedef void ( * PFNGLSTENCILOPVALUEAMDPROC) (GLenum face, GLuint value);
typedef void ( * PFNGLTESSELLATIONFACTORAMDPROC) (GLfloat factor);
typedef void ( * PFNGLTESSELLATIONMODEAMDPROC) (GLenum mode);
typedef void ( * PFNGLELEMENTPOINTERAPPLEPROC) (GLenum type, const void *pointer);
typedef void ( * PFNGLDRAWELEMENTARRAYAPPLEPROC) (GLenum mode, GLint first, GLsizei count);
typedef void ( * PFNGLDRAWRANGEELEMENTARRAYAPPLEPROC) (GLenum mode, GLuint start, GLuint end, GLint first, GLsizei count);
typedef void ( * PFNGLMULTIDRAWELEMENTARRAYAPPLEPROC) (GLenum mode, const GLint *first, const GLsizei *count, GLsizei primcount);
typedef void ( * PFNGLMULTIDRAWRANGEELEMENTARRAYAPPLEPROC) (GLenum mode, GLuint start, GLuint end, const GLint *first, const GLsizei *count, GLsizei primcount);
typedef void ( * PFNGLGENFENCESAPPLEPROC) (GLsizei n, GLuint *fences);
typedef void ( * PFNGLDELETEFENCESAPPLEPROC) (GLsizei n, const GLuint *fences);
typedef void ( * PFNGLSETFENCEAPPLEPROC) (GLuint fence);
typedef GLboolean ( * PFNGLISFENCEAPPLEPROC) (GLuint fence);
typedef GLboolean ( * PFNGLTESTFENCEAPPLEPROC) (GLuint fence);
typedef void ( * PFNGLFINISHFENCEAPPLEPROC) (GLuint fence);
typedef GLboolean ( * PFNGLTESTOBJECTAPPLEPROC) (GLenum object, GLuint name);
typedef void ( * PFNGLFINISHOBJECTAPPLEPROC) (GLenum object, GLint name);
typedef void ( * PFNGLBUFFERPARAMETERIAPPLEPROC) (GLenum target, GLenum pname, GLint param);
typedef void ( * PFNGLFLUSHMAPPEDBUFFERRANGEAPPLEPROC) (GLenum target, GLintptr offset, GLsizeiptr size);
typedef GLenum ( * PFNGLOBJECTPURGEABLEAPPLEPROC) (GLenum objectType, GLuint name, GLenum option);
typedef GLenum ( * PFNGLOBJECTUNPURGEABLEAPPLEPROC) (GLenum objectType, GLuint name, GLenum option);
typedef void ( * PFNGLGETOBJECTPARAMETERIVAPPLEPROC) (GLenum objectType, GLuint name, GLenum pname, GLint *params);
typedef void ( * PFNGLTEXTURERANGEAPPLEPROC) (GLenum target, GLsizei length, const void *pointer);
typedef void ( * PFNGLGETTEXPARAMETERPOINTERVAPPLEPROC) (GLenum target, GLenum pname, void **params);
typedef void ( * PFNGLBINDVERTEXARRAYAPPLEPROC) (GLuint array);
typedef void ( * PFNGLDELETEVERTEXARRAYSAPPLEPROC) (GLsizei n, const GLuint *arrays);
typedef void ( * PFNGLGENVERTEXARRAYSAPPLEPROC) (GLsizei n, GLuint *arrays);
typedef GLboolean ( * PFNGLISVERTEXARRAYAPPLEPROC) (GLuint array);
typedef void ( * PFNGLVERTEXARRAYRANGEAPPLEPROC) (GLsizei length, void *pointer);
typedef void ( * PFNGLFLUSHVERTEXARRAYRANGEAPPLEPROC) (GLsizei length, void *pointer);
typedef void ( * PFNGLVERTEXARRAYPARAMETERIAPPLEPROC) (GLenum pname, GLint param);
typedef void ( * PFNGLENABLEVERTEXATTRIBAPPLEPROC) (GLuint index, GLenum pname);
typedef void ( * PFNGLDISABLEVERTEXATTRIBAPPLEPROC) (GLuint index, GLenum pname);
typedef GLboolean ( * PFNGLISVERTEXATTRIBENABLEDAPPLEPROC) (GLuint index, GLenum pname);
typedef void ( * PFNGLMAPVERTEXATTRIB1DAPPLEPROC) (GLuint index, GLuint size, GLdouble u1, GLdouble u2, GLint stride, GLint order, const GLdouble *points);
typedef void ( * PFNGLMAPVERTEXATTRIB1FAPPLEPROC) (GLuint index, GLuint size, GLfloat u1, GLfloat u2, GLint stride, GLint order, const GLfloat *points);
typedef void ( * PFNGLMAPVERTEXATTRIB2DAPPLEPROC) (GLuint index, GLuint size, GLdouble u1, GLdouble u2, GLint ustride, GLint uorder, GLdouble v1, GLdouble v2, GLint vstride, GLint vorder, const GLdouble *points);
typedef void ( * PFNGLMAPVERTEXATTRIB2FAPPLEPROC) (GLuint index, GLuint size, GLfloat u1, GLfloat u2, GLint ustride, GLint uorder, GLfloat v1, GLfloat v2, GLint vstride, GLint vorder, const GLfloat *points);
typedef void ( * PFNGLDRAWBUFFERSATIPROC) (GLsizei n, const GLenum *bufs);
typedef void ( * PFNGLELEMENTPOINTERATIPROC) (GLenum type, const void *pointer);
typedef void ( * PFNGLDRAWELEMENTARRAYATIPROC) (GLenum mode, GLsizei count);
typedef void ( * PFNGLDRAWRANGEELEMENTARRAYATIPROC) (GLenum mode, GLuint start, GLuint end, GLsizei count);
typedef void ( * PFNGLTEXBUMPPARAMETERIVATIPROC) (GLenum pname, const GLint *param);
typedef void ( * PFNGLTEXBUMPPARAMETERFVATIPROC) (GLenum pname, const GLfloat *param);
typedef void ( * PFNGLGETTEXBUMPPARAMETERIVATIPROC) (GLenum pname, GLint *param);
typedef void ( * PFNGLGETTEXBUMPPARAMETERFVATIPROC) (GLenum pname, GLfloat *param);
typedef GLuint ( * PFNGLGENFRAGMENTSHADERSATIPROC) (GLuint range);
typedef void ( * PFNGLBINDFRAGMENTSHADERATIPROC) (GLuint id);
typedef void ( * PFNGLDELETEFRAGMENTSHADERATIPROC) (GLuint id);
typedef void ( * PFNGLBEGINFRAGMENTSHADERATIPROC) (void);
typedef void ( * PFNGLENDFRAGMENTSHADERATIPROC) (void);
typedef void ( * PFNGLPASSTEXCOORDATIPROC) (GLuint dst, GLuint coord, GLenum swizzle);
typedef void ( * PFNGLSAMPLEMAPATIPROC) (GLuint dst, GLuint interp, GLenum swizzle);
typedef void ( * PFNGLCOLORFRAGMENTOP1ATIPROC) (GLenum op, GLuint dst, GLuint dstMask, GLuint dstMod, GLuint arg1, GLuint arg1Rep, GLuint arg1Mod);
typedef void ( * PFNGLCOLORFRAGMENTOP2ATIPROC) (GLenum op, GLuint dst, GLuint dstMask, GLuint dstMod, GLuint arg1, GLuint arg1Rep, GLuint arg1Mod, GLuint arg2, GLuint arg2Rep, GLuint arg2Mod);
typedef void ( * PFNGLCOLORFRAGMENTOP3ATIPROC) (GLenum op, GLuint dst, GLuint dstMask, GLuint dstMod, GLuint arg1, GLuint arg1Rep, GLuint arg1Mod, GLuint arg2, GLuint arg2Rep, GLuint arg2Mod, GLuint arg3, GLuint arg3Rep, GLuint arg3Mod);
typedef void ( * PFNGLALPHAFRAGMENTOP1ATIPROC) (GLenum op, GLuint dst, GLuint dstMod, GLuint arg1, GLuint arg1Rep, GLuint arg1Mod);
typedef void ( * PFNGLALPHAFRAGMENTOP2ATIPROC) (GLenum op, GLuint dst, GLuint dstMod, GLuint arg1, GLuint arg1Rep, GLuint arg1Mod, GLuint arg2, GLuint arg2Rep, GLuint arg2Mod);
typedef void ( * PFNGLALPHAFRAGMENTOP3ATIPROC) (GLenum op, GLuint dst, GLuint dstMod, GLuint arg1, GLuint arg1Rep, GLuint arg1Mod, GLuint arg2, GLuint arg2Rep, GLuint arg2Mod, GLuint arg3, GLuint arg3Rep, GLuint arg3Mod);
typedef void ( * PFNGLSETFRAGMENTSHADERCONSTANTATIPROC) (GLuint dst, const GLfloat *value);
typedef void *( * PFNGLMAPOBJECTBUFFERATIPROC) (GLuint buffer);
typedef void ( * PFNGLUNMAPOBJECTBUFFERATIPROC) (GLuint buffer);
typedef void ( * PFNGLPNTRIANGLESIATIPROC) (GLenum pname, GLint param);
typedef void ( * PFNGLPNTRIANGLESFATIPROC) (GLenum pname, GLfloat param);
typedef void ( * PFNGLSTENCILOPSEPARATEATIPROC) (GLenum face, GLenum sfail, GLenum dpfail, GLenum dppass);
typedef void ( * PFNGLSTENCILFUNCSEPARATEATIPROC) (GLenum frontfunc, GLenum backfunc, GLint ref, GLuint mask);
typedef GLuint ( * PFNGLNEWOBJECTBUFFERATIPROC) (GLsizei size, const void *pointer, GLenum usage);
typedef GLboolean ( * PFNGLISOBJECTBUFFERATIPROC) (GLuint buffer);
typedef void ( * PFNGLUPDATEOBJECTBUFFERATIPROC) (GLuint buffer, GLuint offset, GLsizei size, const void *pointer, GLenum preserve);
typedef void ( * PFNGLGETOBJECTBUFFERFVATIPROC) (GLuint buffer, GLenum pname, GLfloat *params);
typedef void ( * PFNGLGETOBJECTBUFFERIVATIPROC) (GLuint buffer, GLenum pname, GLint *params);
typedef void ( * PFNGLFREEOBJECTBUFFERATIPROC) (GLuint buffer);
typedef void ( * PFNGLARRAYOBJECTATIPROC) (GLenum array, GLint size, GLenum type, GLsizei stride, GLuint buffer, GLuint offset);
typedef void ( * PFNGLGETARRAYOBJECTFVATIPROC) (GLenum array, GLenum pname, GLfloat *params);
typedef void ( * PFNGLGETARRAYOBJECTIVATIPROC) (GLenum array, GLenum pname, GLint *params);
typedef void ( * PFNGLVARIANTARRAYOBJECTATIPROC) (GLuint id, GLenum type, GLsizei stride, GLuint buffer, GLuint offset);
typedef void ( * PFNGLGETVARIANTARRAYOBJECTFVATIPROC) (GLuint id, GLenum pname, GLfloat *params);
typedef void ( * PFNGLGETVARIANTARRAYOBJECTIVATIPROC) (GLuint id, GLenum pname, GLint *params);
typedef void ( * PFNGLVERTEXATTRIBARRAYOBJECTATIPROC) (GLuint index, GLint size, GLenum type, GLboolean normalized, GLsizei stride, GLuint buffer, GLuint offset);
typedef void ( * PFNGLGETVERTEXATTRIBARRAYOBJECTFVATIPROC) (GLuint index, GLenum pname, GLfloat *params);
typedef void ( * PFNGLGETVERTEXATTRIBARRAYOBJECTIVATIPROC) (GLuint index, GLenum pname, GLint *params);
typedef void ( * PFNGLVERTEXSTREAM1SATIPROC) (GLenum stream, GLshort x);
typedef void ( * PFNGLVERTEXSTREAM1SVATIPROC) (GLenum stream, const GLshort *coords);
typedef void ( * PFNGLVERTEXSTREAM1IATIPROC) (GLenum stream, GLint x);
typedef void ( * PFNGLVERTEXSTREAM1IVATIPROC) (GLenum stream, const GLint *coords);
typedef void ( * PFNGLVERTEXSTREAM1FATIPROC) (GLenum stream, GLfloat x);
typedef void ( * PFNGLVERTEXSTREAM1FVATIPROC) (GLenum stream, const GLfloat *coords);
typedef void ( * PFNGLVERTEXSTREAM1DATIPROC) (GLenum stream, GLdouble x);
typedef void ( * PFNGLVERTEXSTREAM1DVATIPROC) (GLenum stream, const GLdouble *coords);
typedef void ( * PFNGLVERTEXSTREAM2SATIPROC) (GLenum stream, GLshort x, GLshort y);
typedef void ( * PFNGLVERTEXSTREAM2SVATIPROC) (GLenum stream, const GLshort *coords);
typedef void ( * PFNGLVERTEXSTREAM2IATIPROC) (GLenum stream, GLint x, GLint y);
typedef void ( * PFNGLVERTEXSTREAM2IVATIPROC) (GLenum stream, const GLint *coords);
typedef void ( * PFNGLVERTEXSTREAM2FATIPROC) (GLenum stream, GLfloat x, GLfloat y);
typedef void ( * PFNGLVERTEXSTREAM2FVATIPROC) (GLenum stream, const GLfloat *coords);
typedef void ( * PFNGLVERTEXSTREAM2DATIPROC) (GLenum stream, GLdouble x, GLdouble y);
typedef void ( * PFNGLVERTEXSTREAM2DVATIPROC) (GLenum stream, const GLdouble *coords);
typedef void ( * PFNGLVERTEXSTREAM3SATIPROC) (GLenum stream, GLshort x, GLshort y, GLshort z);
typedef void ( * PFNGLVERTEXSTREAM3SVATIPROC) (GLenum stream, const GLshort *coords);
typedef void ( * PFNGLVERTEXSTREAM3IATIPROC) (GLenum stream, GLint x, GLint y, GLint z);
typedef void ( * PFNGLVERTEXSTREAM3IVATIPROC) (GLenum stream, const GLint *coords);
typedef void ( * PFNGLVERTEXSTREAM3FATIPROC) (GLenum stream, GLfloat x, GLfloat y, GLfloat z);
typedef void ( * PFNGLVERTEXSTREAM3FVATIPROC) (GLenum stream, const GLfloat *coords);
typedef void ( * PFNGLVERTEXSTREAM3DATIPROC) (GLenum stream, GLdouble x, GLdouble y, GLdouble z);
typedef void ( * PFNGLVERTEXSTREAM3DVATIPROC) (GLenum stream, const GLdouble *coords);
typedef void ( * PFNGLVERTEXSTREAM4SATIPROC) (GLenum stream, GLshort x, GLshort y, GLshort z, GLshort w);
typedef void ( * PFNGLVERTEXSTREAM4SVATIPROC) (GLenum stream, const GLshort *coords);
typedef void ( * PFNGLVERTEXSTREAM4IATIPROC) (GLenum stream, GLint x, GLint y, GLint z, GLint w);
typedef void ( * PFNGLVERTEXSTREAM4IVATIPROC) (GLenum stream, const GLint *coords);
typedef void ( * PFNGLVERTEXSTREAM4FATIPROC) (GLenum stream, GLfloat x, GLfloat y, GLfloat z, GLfloat w);
typedef void ( * PFNGLVERTEXSTREAM4FVATIPROC) (GLenum stream, const GLfloat *coords);
typedef void ( * PFNGLVERTEXSTREAM4DATIPROC) (GLenum stream, GLdouble x, GLdouble y, GLdouble z, GLdouble w);
typedef void ( * PFNGLVERTEXSTREAM4DVATIPROC) (GLenum stream, const GLdouble *coords);
typedef void ( * PFNGLNORMALSTREAM3BATIPROC) (GLenum stream, GLbyte nx, GLbyte ny, GLbyte nz);
typedef void ( * PFNGLNORMALSTREAM3BVATIPROC) (GLenum stream, const GLbyte *coords);
typedef void ( * PFNGLNORMALSTREAM3SATIPROC) (GLenum stream, GLshort nx, GLshort ny, GLshort nz);
typedef void ( * PFNGLNORMALSTREAM3SVATIPROC) (GLenum stream, const GLshort *coords);
typedef void ( * PFNGLNORMALSTREAM3IATIPROC) (GLenum stream, GLint nx, GLint ny, GLint nz);
typedef void ( * PFNGLNORMALSTREAM3IVATIPROC) (GLenum stream, const GLint *coords);
typedef void ( * PFNGLNORMALSTREAM3FATIPROC) (GLenum stream, GLfloat nx, GLfloat ny, GLfloat nz);
typedef void ( * PFNGLNORMALSTREAM3FVATIPROC) (GLenum stream, const GLfloat *coords);
typedef void ( * PFNGLNORMALSTREAM3DATIPROC) (GLenum stream, GLdouble nx, GLdouble ny, GLdouble nz);
typedef void ( * PFNGLNORMALSTREAM3DVATIPROC) (GLenum stream, const GLdouble *coords);
typedef void ( * PFNGLCLIENTACTIVEVERTEXSTREAMATIPROC) (GLenum stream);
typedef void ( * PFNGLVERTEXBLENDENVIATIPROC) (GLenum pname, GLint param);
typedef void ( * PFNGLVERTEXBLENDENVFATIPROC) (GLenum pname, GLfloat param);
typedef void *GLeglImageOES;
typedef void ( * PFNGLEGLIMAGETARGETTEXSTORAGEEXTPROC) (GLenum target, GLeglImageOES image, const GLint* attrib_list);
typedef void ( * PFNGLEGLIMAGETARGETTEXTURESTORAGEEXTPROC) (GLuint texture, GLeglImageOES image, const GLint* attrib_list);
typedef void ( * PFNGLUNIFORMBUFFEREXTPROC) (GLuint program, GLint location, GLuint buffer);
typedef GLint ( * PFNGLGETUNIFORMBUFFERSIZEEXTPROC) (GLuint program, GLint location);
typedef GLintptr ( * PFNGLGETUNIFORMOFFSETEXTPROC) (GLuint program, GLint location);
typedef void ( * PFNGLBLENDCOLOREXTPROC) (GLfloat red, GLfloat green, GLfloat blue, GLfloat alpha);
typedef void ( * PFNGLBLENDEQUATIONSEPARATEEXTPROC) (GLenum modeRGB, GLenum modeAlpha);
typedef void ( * PFNGLBLENDFUNCSEPARATEEXTPROC) (GLenum sfactorRGB, GLenum dfactorRGB, GLenum sfactorAlpha, GLenum dfactorAlpha);
typedef void ( * PFNGLBLENDEQUATIONEXTPROC) (GLenum mode);
typedef void ( * PFNGLCOLORSUBTABLEEXTPROC) (GLenum target, GLsizei start, GLsizei count, GLenum format, GLenum type, const void *data);
typedef void ( * PFNGLCOPYCOLORSUBTABLEEXTPROC) (GLenum target, GLsizei start, GLint x, GLint y, GLsizei width);
typedef void ( * PFNGLLOCKARRAYSEXTPROC) (GLint first, GLsizei count);
typedef void ( * PFNGLUNLOCKARRAYSEXTPROC) (void);
typedef void ( * PFNGLCONVOLUTIONFILTER1DEXTPROC) (GLenum target, GLenum internalformat, GLsizei width, GLenum format, GLenum type, const void *image);
typedef void ( * PFNGLCONVOLUTIONFILTER2DEXTPROC) (GLenum target, GLenum internalformat, GLsizei width, GLsizei height, GLenum format, GLenum type, const void *image);
typedef void ( * PFNGLCONVOLUTIONPARAMETERFEXTPROC) (GLenum target, GLenum pname, GLfloat params);
typedef void ( * PFNGLCONVOLUTIONPARAMETERFVEXTPROC) (GLenum target, GLenum pname, const GLfloat *params);
typedef void ( * PFNGLCONVOLUTIONPARAMETERIEXTPROC) (GLenum target, GLenum pname, GLint params);
typedef void ( * PFNGLCONVOLUTIONPARAMETERIVEXTPROC) (GLenum target, GLenum pname, const GLint *params);
typedef void ( * PFNGLCOPYCONVOLUTIONFILTER1DEXTPROC) (GLenum target, GLenum internalformat, GLint x, GLint y, GLsizei width);
typedef void ( * PFNGLCOPYCONVOLUTIONFILTER2DEXTPROC) (GLenum target, GLenum internalformat, GLint x, GLint y, GLsizei width, GLsizei height);
typedef void ( * PFNGLGETCONVOLUTIONFILTEREXTPROC) (GLenum target, GLenum format, GLenum type, void *image);
typedef void ( * PFNGLGETCONVOLUTIONPARAMETERFVEXTPROC) (GLenum target, GLenum pname, GLfloat *params);
typedef void ( * PFNGLGETCONVOLUTIONPARAMETERIVEXTPROC) (GLenum target, GLenum pname, GLint *params);
typedef void ( * PFNGLGETSEPARABLEFILTEREXTPROC) (GLenum target, GLenum format, GLenum type, void *row, void *column, void *span);
typedef void ( * PFNGLSEPARABLEFILTER2DEXTPROC) (GLenum target, GLenum internalformat, GLsizei width, GLsizei height, GLenum format, GLenum type, const void *row, const void *column);
typedef void ( * PFNGLTANGENT3BEXTPROC) (GLbyte tx, GLbyte ty, GLbyte tz);
typedef void ( * PFNGLTANGENT3BVEXTPROC) (const GLbyte *v);
typedef void ( * PFNGLTANGENT3DEXTPROC) (GLdouble tx, GLdouble ty, GLdouble tz);
typedef void ( * PFNGLTANGENT3DVEXTPROC) (const GLdouble *v);
typedef void ( * PFNGLTANGENT3FEXTPROC) (GLfloat tx, GLfloat ty, GLfloat tz);
typedef void ( * PFNGLTANGENT3FVEXTPROC) (const GLfloat *v);
typedef void ( * PFNGLTANGENT3IEXTPROC) (GLint tx, GLint ty, GLint tz);
typedef void ( * PFNGLTANGENT3IVEXTPROC) (const GLint *v);
typedef void ( * PFNGLTANGENT3SEXTPROC) (GLshort tx, GLshort ty, GLshort tz);
typedef void ( * PFNGLTANGENT3SVEXTPROC) (const GLshort *v);
typedef void ( * PFNGLBINORMAL3BEXTPROC) (GLbyte bx, GLbyte by, GLbyte bz);
typedef void ( * PFNGLBINORMAL3BVEXTPROC) (const GLbyte *v);
typedef void ( * PFNGLBINORMAL3DEXTPROC) (GLdouble bx, GLdouble by, GLdouble bz);
typedef void ( * PFNGLBINORMAL3DVEXTPROC) (const GLdouble *v);
typedef void ( * PFNGLBINORMAL3FEXTPROC) (GLfloat bx, GLfloat by, GLfloat bz);
typedef void ( * PFNGLBINORMAL3FVEXTPROC) (const GLfloat *v);
typedef void ( * PFNGLBINORMAL3IEXTPROC) (GLint bx, GLint by, GLint bz);
typedef void ( * PFNGLBINORMAL3IVEXTPROC) (const GLint *v);
typedef void ( * PFNGLBINORMAL3SEXTPROC) (GLshort bx, GLshort by, GLshort bz);
typedef void ( * PFNGLBINORMAL3SVEXTPROC) (const GLshort *v);
typedef void ( * PFNGLTANGENTPOINTEREXTPROC) (GLenum type, GLsizei stride, const void *pointer);
typedef void ( * PFNGLBINORMALPOINTEREXTPROC) (GLenum type, GLsizei stride, const void *pointer);
typedef void ( * PFNGLCOPYTEXIMAGE1DEXTPROC) (GLenum target, GLint level, GLenum internalformat, GLint x, GLint y, GLsizei width, GLint border);
typedef void ( * PFNGLCOPYTEXIMAGE2DEXTPROC) (GLenum target, GLint level, GLenum internalformat, GLint x, GLint y, GLsizei width, GLsizei height, GLint border);
typedef void ( * PFNGLCOPYTEXSUBIMAGE1DEXTPROC) (GLenum target, GLint level, GLint xoffset, GLint x, GLint y, GLsizei width);
typedef void ( * PFNGLCOPYTEXSUBIMAGE2DEXTPROC) (GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint x, GLint y, GLsizei width, GLsizei height);
typedef void ( * PFNGLCOPYTEXSUBIMAGE3DEXTPROC) (GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLint x, GLint y, GLsizei width, GLsizei height);
typedef void ( * PFNGLCULLPARAMETERDVEXTPROC) (GLenum pname, GLdouble *params);
typedef void ( * PFNGLCULLPARAMETERFVEXTPROC) (GLenum pname, GLfloat *params);
typedef void ( * PFNGLLABELOBJECTEXTPROC) (GLenum type, GLuint object, GLsizei length, const GLchar *label);
typedef void ( * PFNGLGETOBJECTLABELEXTPROC) (GLenum type, GLuint object, GLsizei bufSize, GLsizei *length, GLchar *label);
typedef void ( * PFNGLINSERTEVENTMARKEREXTPROC) (GLsizei length, const GLchar *marker);
typedef void ( * PFNGLPUSHGROUPMARKEREXTPROC) (GLsizei length, const GLchar *marker);
typedef void ( * PFNGLPOPGROUPMARKEREXTPROC) (void);
typedef void ( * PFNGLDEPTHBOUNDSEXTPROC) (GLclampd zmin, GLclampd zmax);
typedef void ( * PFNGLMATRIXLOADFEXTPROC) (GLenum mode, const GLfloat *m);
typedef void ( * PFNGLMATRIXLOADDEXTPROC) (GLenum mode, const GLdouble *m);
typedef void ( * PFNGLMATRIXMULTFEXTPROC) (GLenum mode, const GLfloat *m);
typedef void ( * PFNGLMATRIXMULTDEXTPROC) (GLenum mode, const GLdouble *m);
typedef void ( * PFNGLMATRIXLOADIDENTITYEXTPROC) (GLenum mode);
typedef void ( * PFNGLMATRIXROTATEFEXTPROC) (GLenum mode, GLfloat angle, GLfloat x, GLfloat y, GLfloat z);
typedef void ( * PFNGLMATRIXROTATEDEXTPROC) (GLenum mode, GLdouble angle, GLdouble x, GLdouble y, GLdouble z);
typedef void ( * PFNGLMATRIXSCALEFEXTPROC) (GLenum mode, GLfloat x, GLfloat y, GLfloat z);
typedef void ( * PFNGLMATRIXSCALEDEXTPROC) (GLenum mode, GLdouble x, GLdouble y, GLdouble z);
typedef void ( * PFNGLMATRIXTRANSLATEFEXTPROC) (GLenum mode, GLfloat x, GLfloat y, GLfloat z);
typedef void ( * PFNGLMATRIXTRANSLATEDEXTPROC) (GLenum mode, GLdouble x, GLdouble y, GLdouble z);
typedef void ( * PFNGLMATRIXFRUSTUMEXTPROC) (GLenum mode, GLdouble left, GLdouble right, GLdouble bottom, GLdouble top, GLdouble zNear, GLdouble zFar);
typedef void ( * PFNGLMATRIXORTHOEXTPROC) (GLenum mode, GLdouble left, GLdouble right, GLdouble bottom, GLdouble top, GLdouble zNear, GLdouble zFar);
typedef void ( * PFNGLMATRIXPOPEXTPROC) (GLenum mode);
typedef void ( * PFNGLMATRIXPUSHEXTPROC) (GLenum mode);
typedef void ( * PFNGLCLIENTATTRIBDEFAULTEXTPROC) (GLbitfield mask);
typedef void ( * PFNGLPUSHCLIENTATTRIBDEFAULTEXTPROC) (GLbitfield mask);
typedef void ( * PFNGLTEXTUREPARAMETERFEXTPROC) (GLuint texture, GLenum target, GLenum pname, GLfloat param);
typedef void ( * PFNGLTEXTUREPARAMETERFVEXTPROC) (GLuint texture, GLenum target, GLenum pname, const GLfloat *params);
typedef void ( * PFNGLTEXTUREPARAMETERIEXTPROC) (GLuint texture, GLenum target, GLenum pname, GLint param);
typedef void ( * PFNGLTEXTUREPARAMETERIVEXTPROC) (GLuint texture, GLenum target, GLenum pname, const GLint *params);
typedef void ( * PFNGLTEXTUREIMAGE1DEXTPROC) (GLuint texture, GLenum target, GLint level, GLint internalformat, GLsizei width, GLint border, GLenum format, GLenum type, const void *pixels);
typedef void ( * PFNGLTEXTUREIMAGE2DEXTPROC) (GLuint texture, GLenum target, GLint level, GLint internalformat, GLsizei width, GLsizei height, GLint border, GLenum format, GLenum type, const void *pixels);
typedef void ( * PFNGLTEXTURESUBIMAGE1DEXTPROC) (GLuint texture, GLenum target, GLint level, GLint xoffset, GLsizei width, GLenum format, GLenum type, const void *pixels);
typedef void ( * PFNGLTEXTURESUBIMAGE2DEXTPROC) (GLuint texture, GLenum target, GLint level, GLint xoffset, GLint yoffset, GLsizei width, GLsizei height, GLenum format, GLenum type, const void *pixels);
typedef void ( * PFNGLCOPYTEXTUREIMAGE1DEXTPROC) (GLuint texture, GLenum target, GLint level, GLenum internalformat, GLint x, GLint y, GLsizei width, GLint border);
typedef void ( * PFNGLCOPYTEXTUREIMAGE2DEXTPROC) (GLuint texture, GLenum target, GLint level, GLenum internalformat, GLint x, GLint y, GLsizei width, GLsizei height, GLint border);
typedef void ( * PFNGLCOPYTEXTURESUBIMAGE1DEXTPROC) (GLuint texture, GLenum target, GLint level, GLint xoffset, GLint x, GLint y, GLsizei width);
typedef void ( * PFNGLCOPYTEXTURESUBIMAGE2DEXTPROC) (GLuint texture, GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint x, GLint y, GLsizei width, GLsizei height);
typedef void ( * PFNGLGETTEXTUREIMAGEEXTPROC) (GLuint texture, GLenum target, GLint level, GLenum format, GLenum type, void *pixels);
typedef void ( * PFNGLGETTEXTUREPARAMETERFVEXTPROC) (GLuint texture, GLenum target, GLenum pname, GLfloat *params);
typedef void ( * PFNGLGETTEXTUREPARAMETERIVEXTPROC) (GLuint texture, GLenum target, GLenum pname, GLint *params);
typedef void ( * PFNGLGETTEXTURELEVELPARAMETERFVEXTPROC) (GLuint texture, GLenum target, GLint level, GLenum pname, GLfloat *params);
typedef void ( * PFNGLGETTEXTURELEVELPARAMETERIVEXTPROC) (GLuint texture, GLenum target, GLint level, GLenum pname, GLint *params);
typedef void ( * PFNGLTEXTUREIMAGE3DEXTPROC) (GLuint texture, GLenum target, GLint level, GLint internalformat, GLsizei width, GLsizei height, GLsizei depth, GLint border, GLenum format, GLenum type, const void *pixels);
typedef void ( * PFNGLTEXTURESUBIMAGE3DEXTPROC) (GLuint texture, GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth, GLenum format, GLenum type, const void *pixels);
typedef void ( * PFNGLCOPYTEXTURESUBIMAGE3DEXTPROC) (GLuint texture, GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLint x, GLint y, GLsizei width, GLsizei height);
typedef void ( * PFNGLBINDMULTITEXTUREEXTPROC) (GLenum texunit, GLenum target, GLuint texture);
typedef void ( * PFNGLMULTITEXCOORDPOINTEREXTPROC) (GLenum texunit, GLint size, GLenum type, GLsizei stride, const void *pointer);
typedef void ( * PFNGLMULTITEXENVFEXTPROC) (GLenum texunit, GLenum target, GLenum pname, GLfloat param);
typedef void ( * PFNGLMULTITEXENVFVEXTPROC) (GLenum texunit, GLenum target, GLenum pname, const GLfloat *params);
typedef void ( * PFNGLMULTITEXENVIEXTPROC) (GLenum texunit, GLenum target, GLenum pname, GLint param);
typedef void ( * PFNGLMULTITEXENVIVEXTPROC) (GLenum texunit, GLenum target, GLenum pname, const GLint *params);
typedef void ( * PFNGLMULTITEXGENDEXTPROC) (GLenum texunit, GLenum coord, GLenum pname, GLdouble param);
typedef void ( * PFNGLMULTITEXGENDVEXTPROC) (GLenum texunit, GLenum coord, GLenum pname, const GLdouble *params);
typedef void ( * PFNGLMULTITEXGENFEXTPROC) (GLenum texunit, GLenum coord, GLenum pname, GLfloat param);
typedef void ( * PFNGLMULTITEXGENFVEXTPROC) (GLenum texunit, GLenum coord, GLenum pname, const GLfloat *params);
typedef void ( * PFNGLMULTITEXGENIEXTPROC) (GLenum texunit, GLenum coord, GLenum pname, GLint param);
typedef void ( * PFNGLMULTITEXGENIVEXTPROC) (GLenum texunit, GLenum coord, GLenum pname, const GLint *params);
typedef void ( * PFNGLGETMULTITEXENVFVEXTPROC) (GLenum texunit, GLenum target, GLenum pname, GLfloat *params);
typedef void ( * PFNGLGETMULTITEXENVIVEXTPROC) (GLenum texunit, GLenum target, GLenum pname, GLint *params);
typedef void ( * PFNGLGETMULTITEXGENDVEXTPROC) (GLenum texunit, GLenum coord, GLenum pname, GLdouble *params);
typedef void ( * PFNGLGETMULTITEXGENFVEXTPROC) (GLenum texunit, GLenum coord, GLenum pname, GLfloat *params);
typedef void ( * PFNGLGETMULTITEXGENIVEXTPROC) (GLenum texunit, GLenum coord, GLenum pname, GLint *params);
typedef void ( * PFNGLMULTITEXPARAMETERIEXTPROC) (GLenum texunit, GLenum target, GLenum pname, GLint param);
typedef void ( * PFNGLMULTITEXPARAMETERIVEXTPROC) (GLenum texunit, GLenum target, GLenum pname, const GLint *params);
typedef void ( * PFNGLMULTITEXPARAMETERFEXTPROC) (GLenum texunit, GLenum target, GLenum pname, GLfloat param);
typedef void ( * PFNGLMULTITEXPARAMETERFVEXTPROC) (GLenum texunit, GLenum target, GLenum pname, const GLfloat *params);
typedef void ( * PFNGLMULTITEXIMAGE1DEXTPROC) (GLenum texunit, GLenum target, GLint level, GLint internalformat, GLsizei width, GLint border, GLenum format, GLenum type, const void *pixels);
typedef void ( * PFNGLMULTITEXIMAGE2DEXTPROC) (GLenum texunit, GLenum target, GLint level, GLint internalformat, GLsizei width, GLsizei height, GLint border, GLenum format, GLenum type, const void *pixels);
typedef void ( * PFNGLMULTITEXSUBIMAGE1DEXTPROC) (GLenum texunit, GLenum target, GLint level, GLint xoffset, GLsizei width, GLenum format, GLenum type, const void *pixels);
typedef void ( * PFNGLMULTITEXSUBIMAGE2DEXTPROC) (GLenum texunit, GLenum target, GLint level, GLint xoffset, GLint yoffset, GLsizei width, GLsizei height, GLenum format, GLenum type, const void *pixels);
typedef void ( * PFNGLCOPYMULTITEXIMAGE1DEXTPROC) (GLenum texunit, GLenum target, GLint level, GLenum internalformat, GLint x, GLint y, GLsizei width, GLint border);
typedef void ( * PFNGLCOPYMULTITEXIMAGE2DEXTPROC) (GLenum texunit, GLenum target, GLint level, GLenum internalformat, GLint x, GLint y, GLsizei width, GLsizei height, GLint border);
typedef void ( * PFNGLCOPYMULTITEXSUBIMAGE1DEXTPROC) (GLenum texunit, GLenum target, GLint level, GLint xoffset, GLint x, GLint y, GLsizei width);
typedef void ( * PFNGLCOPYMULTITEXSUBIMAGE2DEXTPROC) (GLenum texunit, GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint x, GLint y, GLsizei width, GLsizei height);
typedef void ( * PFNGLGETMULTITEXIMAGEEXTPROC) (GLenum texunit, GLenum target, GLint level, GLenum format, GLenum type, void *pixels);
typedef void ( * PFNGLGETMULTITEXPARAMETERFVEXTPROC) (GLenum texunit, GLenum target, GLenum pname, GLfloat *params);
typedef void ( * PFNGLGETMULTITEXPARAMETERIVEXTPROC) (GLenum texunit, GLenum target, GLenum pname, GLint *params);
typedef void ( * PFNGLGETMULTITEXLEVELPARAMETERFVEXTPROC) (GLenum texunit, GLenum target, GLint level, GLenum pname, GLfloat *params);
typedef void ( * PFNGLGETMULTITEXLEVELPARAMETERIVEXTPROC) (GLenum texunit, GLenum target, GLint level, GLenum pname, GLint *params);
typedef void ( * PFNGLMULTITEXIMAGE3DEXTPROC) (GLenum texunit, GLenum target, GLint level, GLint internalformat, GLsizei width, GLsizei height, GLsizei depth, GLint border, GLenum format, GLenum type, const void *pixels);
typedef void ( * PFNGLMULTITEXSUBIMAGE3DEXTPROC) (GLenum texunit, GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth, GLenum format, GLenum type, const void *pixels);
typedef void ( * PFNGLCOPYMULTITEXSUBIMAGE3DEXTPROC) (GLenum texunit, GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLint x, GLint y, GLsizei width, GLsizei height);
typedef void ( * PFNGLENABLECLIENTSTATEINDEXEDEXTPROC) (GLenum array, GLuint index);
typedef void ( * PFNGLDISABLECLIENTSTATEINDEXEDEXTPROC) (GLenum array, GLuint index);
typedef void ( * PFNGLGETFLOATINDEXEDVEXTPROC) (GLenum target, GLuint index, GLfloat *data);
typedef void ( * PFNGLGETDOUBLEINDEXEDVEXTPROC) (GLenum target, GLuint index, GLdouble *data);
typedef void ( * PFNGLGETPOINTERINDEXEDVEXTPROC) (GLenum target, GLuint index, void **data);
typedef void ( * PFNGLENABLEINDEXEDEXTPROC) (GLenum target, GLuint index);
typedef void ( * PFNGLDISABLEINDEXEDEXTPROC) (GLenum target, GLuint index);
typedef GLboolean ( * PFNGLISENABLEDINDEXEDEXTPROC) (GLenum target, GLuint index);
typedef void ( * PFNGLGETINTEGERINDEXEDVEXTPROC) (GLenum target, GLuint index, GLint *data);
typedef void ( * PFNGLGETBOOLEANINDEXEDVEXTPROC) (GLenum target, GLuint index, GLboolean *data);
typedef void ( * PFNGLCOMPRESSEDTEXTUREIMAGE3DEXTPROC) (GLuint texture, GLenum target, GLint level, GLenum internalformat, GLsizei width, GLsizei height, GLsizei depth, GLint border, GLsizei imageSize, const void *bits);
typedef void ( * PFNGLCOMPRESSEDTEXTUREIMAGE2DEXTPROC) (GLuint texture, GLenum target, GLint level, GLenum internalformat, GLsizei width, GLsizei height, GLint border, GLsizei imageSize, const void *bits);
typedef void ( * PFNGLCOMPRESSEDTEXTUREIMAGE1DEXTPROC) (GLuint texture, GLenum target, GLint level, GLenum internalformat, GLsizei width, GLint border, GLsizei imageSize, const void *bits);
typedef void ( * PFNGLCOMPRESSEDTEXTURESUBIMAGE3DEXTPROC) (GLuint texture, GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth, GLenum format, GLsizei imageSize, const void *bits);
typedef void ( * PFNGLCOMPRESSEDTEXTURESUBIMAGE2DEXTPROC) (GLuint texture, GLenum target, GLint level, GLint xoffset, GLint yoffset, GLsizei width, GLsizei height, GLenum format, GLsizei imageSize, const void *bits);
typedef void ( * PFNGLCOMPRESSEDTEXTURESUBIMAGE1DEXTPROC) (GLuint texture, GLenum target, GLint level, GLint xoffset, GLsizei width, GLenum format, GLsizei imageSize, const void *bits);
typedef void ( * PFNGLGETCOMPRESSEDTEXTUREIMAGEEXTPROC) (GLuint texture, GLenum target, GLint lod, void *img);
typedef void ( * PFNGLCOMPRESSEDMULTITEXIMAGE3DEXTPROC) (GLenum texunit, GLenum target, GLint level, GLenum internalformat, GLsizei width, GLsizei height, GLsizei depth, GLint border, GLsizei imageSize, const void *bits);
typedef void ( * PFNGLCOMPRESSEDMULTITEXIMAGE2DEXTPROC) (GLenum texunit, GLenum target, GLint level, GLenum internalformat, GLsizei width, GLsizei height, GLint border, GLsizei imageSize, const void *bits);
typedef void ( * PFNGLCOMPRESSEDMULTITEXIMAGE1DEXTPROC) (GLenum texunit, GLenum target, GLint level, GLenum internalformat, GLsizei width, GLint border, GLsizei imageSize, const void *bits);
typedef void ( * PFNGLCOMPRESSEDMULTITEXSUBIMAGE3DEXTPROC) (GLenum texunit, GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth, GLenum format, GLsizei imageSize, const void *bits);
typedef void ( * PFNGLCOMPRESSEDMULTITEXSUBIMAGE2DEXTPROC) (GLenum texunit, GLenum target, GLint level, GLint xoffset, GLint yoffset, GLsizei width, GLsizei height, GLenum format, GLsizei imageSize, const void *bits);
typedef void ( * PFNGLCOMPRESSEDMULTITEXSUBIMAGE1DEXTPROC) (GLenum texunit, GLenum target, GLint level, GLint xoffset, GLsizei width, GLenum format, GLsizei imageSize, const void *bits);
typedef void ( * PFNGLGETCOMPRESSEDMULTITEXIMAGEEXTPROC) (GLenum texunit, GLenum target, GLint lod, void *img);
typedef void ( * PFNGLMATRIXLOADTRANSPOSEFEXTPROC) (GLenum mode, const GLfloat *m);
typedef void ( * PFNGLMATRIXLOADTRANSPOSEDEXTPROC) (GLenum mode, const GLdouble *m);
typedef void ( * PFNGLMATRIXMULTTRANSPOSEFEXTPROC) (GLenum mode, const GLfloat *m);
typedef void ( * PFNGLMATRIXMULTTRANSPOSEDEXTPROC) (GLenum mode, const GLdouble *m);
typedef void ( * PFNGLNAMEDBUFFERDATAEXTPROC) (GLuint buffer, GLsizeiptr size, const void *data, GLenum usage);
typedef void ( * PFNGLNAMEDBUFFERSUBDATAEXTPROC) (GLuint buffer, GLintptr offset, GLsizeiptr size, const void *data);
typedef void *( * PFNGLMAPNAMEDBUFFEREXTPROC) (GLuint buffer, GLenum access);
typedef GLboolean ( * PFNGLUNMAPNAMEDBUFFEREXTPROC) (GLuint buffer);
typedef void ( * PFNGLGETNAMEDBUFFERPARAMETERIVEXTPROC) (GLuint buffer, GLenum pname, GLint *params);
typedef void ( * PFNGLGETNAMEDBUFFERPOINTERVEXTPROC) (GLuint buffer, GLenum pname, void **params);
typedef void ( * PFNGLGETNAMEDBUFFERSUBDATAEXTPROC) (GLuint buffer, GLintptr offset, GLsizeiptr size, void *data);
typedef void ( * PFNGLPROGRAMUNIFORM1FEXTPROC) (GLuint program, GLint location, GLfloat v0);
typedef void ( * PFNGLPROGRAMUNIFORM2FEXTPROC) (GLuint program, GLint location, GLfloat v0, GLfloat v1);
typedef void ( * PFNGLPROGRAMUNIFORM3FEXTPROC) (GLuint program, GLint location, GLfloat v0, GLfloat v1, GLfloat v2);
typedef void ( * PFNGLPROGRAMUNIFORM4FEXTPROC) (GLuint program, GLint location, GLfloat v0, GLfloat v1, GLfloat v2, GLfloat v3);
typedef void ( * PFNGLPROGRAMUNIFORM1IEXTPROC) (GLuint program, GLint location, GLint v0);
typedef void ( * PFNGLPROGRAMUNIFORM2IEXTPROC) (GLuint program, GLint location, GLint v0, GLint v1);
typedef void ( * PFNGLPROGRAMUNIFORM3IEXTPROC) (GLuint program, GLint location, GLint v0, GLint v1, GLint v2);
typedef void ( * PFNGLPROGRAMUNIFORM4IEXTPROC) (GLuint program, GLint location, GLint v0, GLint v1, GLint v2, GLint v3);
typedef void ( * PFNGLPROGRAMUNIFORM1FVEXTPROC) (GLuint program, GLint location, GLsizei count, const GLfloat *value);
typedef void ( * PFNGLPROGRAMUNIFORM2FVEXTPROC) (GLuint program, GLint location, GLsizei count, const GLfloat *value);
typedef void ( * PFNGLPROGRAMUNIFORM3FVEXTPROC) (GLuint program, GLint location, GLsizei count, const GLfloat *value);
typedef void ( * PFNGLPROGRAMUNIFORM4FVEXTPROC) (GLuint program, GLint location, GLsizei count, const GLfloat *value);
typedef void ( * PFNGLPROGRAMUNIFORM1IVEXTPROC) (GLuint program, GLint location, GLsizei count, const GLint *value);
typedef void ( * PFNGLPROGRAMUNIFORM2IVEXTPROC) (GLuint program, GLint location, GLsizei count, const GLint *value);
typedef void ( * PFNGLPROGRAMUNIFORM3IVEXTPROC) (GLuint program, GLint location, GLsizei count, const GLint *value);
typedef void ( * PFNGLPROGRAMUNIFORM4IVEXTPROC) (GLuint program, GLint location, GLsizei count, const GLint *value);
typedef void ( * PFNGLPROGRAMUNIFORMMATRIX2FVEXTPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
typedef void ( * PFNGLPROGRAMUNIFORMMATRIX3FVEXTPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
typedef void ( * PFNGLPROGRAMUNIFORMMATRIX4FVEXTPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
typedef void ( * PFNGLPROGRAMUNIFORMMATRIX2X3FVEXTPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
typedef void ( * PFNGLPROGRAMUNIFORMMATRIX3X2FVEXTPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
typedef void ( * PFNGLPROGRAMUNIFORMMATRIX2X4FVEXTPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
typedef void ( * PFNGLPROGRAMUNIFORMMATRIX4X2FVEXTPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
typedef void ( * PFNGLPROGRAMUNIFORMMATRIX3X4FVEXTPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
typedef void ( * PFNGLPROGRAMUNIFORMMATRIX4X3FVEXTPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
typedef void ( * PFNGLTEXTUREBUFFEREXTPROC) (GLuint texture, GLenum target, GLenum internalformat, GLuint buffer);
typedef void ( * PFNGLMULTITEXBUFFEREXTPROC) (GLenum texunit, GLenum target, GLenum internalformat, GLuint buffer);
typedef void ( * PFNGLTEXTUREPARAMETERIIVEXTPROC) (GLuint texture, GLenum target, GLenum pname, const GLint *params);
typedef void ( * PFNGLTEXTUREPARAMETERIUIVEXTPROC) (GLuint texture, GLenum target, GLenum pname, const GLuint *params);
typedef void ( * PFNGLGETTEXTUREPARAMETERIIVEXTPROC) (GLuint texture, GLenum target, GLenum pname, GLint *params);
typedef void ( * PFNGLGETTEXTUREPARAMETERIUIVEXTPROC) (GLuint texture, GLenum target, GLenum pname, GLuint *params);
typedef void ( * PFNGLMULTITEXPARAMETERIIVEXTPROC) (GLenum texunit, GLenum target, GLenum pname, const GLint *params);
typedef void ( * PFNGLMULTITEXPARAMETERIUIVEXTPROC) (GLenum texunit, GLenum target, GLenum pname, const GLuint *params);
typedef void ( * PFNGLGETMULTITEXPARAMETERIIVEXTPROC) (GLenum texunit, GLenum target, GLenum pname, GLint *params);
typedef void ( * PFNGLGETMULTITEXPARAMETERIUIVEXTPROC) (GLenum texunit, GLenum target, GLenum pname, GLuint *params);
typedef void ( * PFNGLPROGRAMUNIFORM1UIEXTPROC) (GLuint program, GLint location, GLuint v0);
typedef void ( * PFNGLPROGRAMUNIFORM2UIEXTPROC) (GLuint program, GLint location, GLuint v0, GLuint v1);
typedef void ( * PFNGLPROGRAMUNIFORM3UIEXTPROC) (GLuint program, GLint location, GLuint v0, GLuint v1, GLuint v2);
typedef void ( * PFNGLPROGRAMUNIFORM4UIEXTPROC) (GLuint program, GLint location, GLuint v0, GLuint v1, GLuint v2, GLuint v3);
typedef void ( * PFNGLPROGRAMUNIFORM1UIVEXTPROC) (GLuint program, GLint location, GLsizei count, const GLuint *value);
typedef void ( * PFNGLPROGRAMUNIFORM2UIVEXTPROC) (GLuint program, GLint location, GLsizei count, const GLuint *value);
typedef void ( * PFNGLPROGRAMUNIFORM3UIVEXTPROC) (GLuint program, GLint location, GLsizei count, const GLuint *value);
typedef void ( * PFNGLPROGRAMUNIFORM4UIVEXTPROC) (GLuint program, GLint location, GLsizei count, const GLuint *value);
typedef void ( * PFNGLNAMEDPROGRAMLOCALPARAMETERS4FVEXTPROC) (GLuint program, GLenum target, GLuint index, GLsizei count, const GLfloat *params);
typedef void ( * PFNGLNAMEDPROGRAMLOCALPARAMETERI4IEXTPROC) (GLuint program, GLenum target, GLuint index, GLint x, GLint y, GLint z, GLint w);
typedef void ( * PFNGLNAMEDPROGRAMLOCALPARAMETERI4IVEXTPROC) (GLuint program, GLenum target, GLuint index, const GLint *params);
typedef void ( * PFNGLNAMEDPROGRAMLOCALPARAMETERSI4IVEXTPROC) (GLuint program, GLenum target, GLuint index, GLsizei count, const GLint *params);
typedef void ( * PFNGLNAMEDPROGRAMLOCALPARAMETERI4UIEXTPROC) (GLuint program, GLenum target, GLuint index, GLuint x, GLuint y, GLuint z, GLuint w);
typedef void ( * PFNGLNAMEDPROGRAMLOCALPARAMETERI4UIVEXTPROC) (GLuint program, GLenum target, GLuint index, const GLuint *params);
typedef void ( * PFNGLNAMEDPROGRAMLOCALPARAMETERSI4UIVEXTPROC) (GLuint program, GLenum target, GLuint index, GLsizei count, const GLuint *params);
typedef void ( * PFNGLGETNAMEDPROGRAMLOCALPARAMETERIIVEXTPROC) (GLuint program, GLenum target, GLuint index, GLint *params);
typedef void ( * PFNGLGETNAMEDPROGRAMLOCALPARAMETERIUIVEXTPROC) (GLuint program, GLenum target, GLuint index, GLuint *params);
typedef void ( * PFNGLENABLECLIENTSTATEIEXTPROC) (GLenum array, GLuint index);
typedef void ( * PFNGLDISABLECLIENTSTATEIEXTPROC) (GLenum array, GLuint index);
typedef void ( * PFNGLGETFLOATI_VEXTPROC) (GLenum pname, GLuint index, GLfloat *params);
typedef void ( * PFNGLGETDOUBLEI_VEXTPROC) (GLenum pname, GLuint index, GLdouble *params);
typedef void ( * PFNGLGETPOINTERI_VEXTPROC) (GLenum pname, GLuint index, void **params);
typedef void ( * PFNGLNAMEDPROGRAMSTRINGEXTPROC) (GLuint program, GLenum target, GLenum format, GLsizei len, const void *string);
typedef void ( * PFNGLNAMEDPROGRAMLOCALPARAMETER4DEXTPROC) (GLuint program, GLenum target, GLuint index, GLdouble x, GLdouble y, GLdouble z, GLdouble w);
typedef void ( * PFNGLNAMEDPROGRAMLOCALPARAMETER4DVEXTPROC) (GLuint program, GLenum target, GLuint index, const GLdouble *params);
typedef void ( * PFNGLNAMEDPROGRAMLOCALPARAMETER4FEXTPROC) (GLuint program, GLenum target, GLuint index, GLfloat x, GLfloat y, GLfloat z, GLfloat w);
typedef void ( * PFNGLNAMEDPROGRAMLOCALPARAMETER4FVEXTPROC) (GLuint program, GLenum target, GLuint index, const GLfloat *params);
typedef void ( * PFNGLGETNAMEDPROGRAMLOCALPARAMETERDVEXTPROC) (GLuint program, GLenum target, GLuint index, GLdouble *params);
typedef void ( * PFNGLGETNAMEDPROGRAMLOCALPARAMETERFVEXTPROC) (GLuint program, GLenum target, GLuint index, GLfloat *params);
typedef void ( * PFNGLGETNAMEDPROGRAMIVEXTPROC) (GLuint program, GLenum target, GLenum pname, GLint *params);
typedef void ( * PFNGLGETNAMEDPROGRAMSTRINGEXTPROC) (GLuint program, GLenum target, GLenum pname, void *string);
typedef void ( * PFNGLNAMEDRENDERBUFFERSTORAGEEXTPROC) (GLuint renderbuffer, GLenum internalformat, GLsizei width, GLsizei height);
typedef void ( * PFNGLGETNAMEDRENDERBUFFERPARAMETERIVEXTPROC) (GLuint renderbuffer, GLenum pname, GLint *params);
typedef void ( * PFNGLNAMEDRENDERBUFFERSTORAGEMULTISAMPLEEXTPROC) (GLuint renderbuffer, GLsizei samples, GLenum internalformat, GLsizei width, GLsizei height);
typedef void ( * PFNGLNAMEDRENDERBUFFERSTORAGEMULTISAMPLECOVERAGEEXTPROC) (GLuint renderbuffer, GLsizei coverageSamples, GLsizei colorSamples, GLenum internalformat, GLsizei width, GLsizei height);
typedef GLenum ( * PFNGLCHECKNAMEDFRAMEBUFFERSTATUSEXTPROC) (GLuint framebuffer, GLenum target);
typedef void ( * PFNGLNAMEDFRAMEBUFFERTEXTURE1DEXTPROC) (GLuint framebuffer, GLenum attachment, GLenum textarget, GLuint texture, GLint level);
typedef void ( * PFNGLNAMEDFRAMEBUFFERTEXTURE2DEXTPROC) (GLuint framebuffer, GLenum attachment, GLenum textarget, GLuint texture, GLint level);
typedef void ( * PFNGLNAMEDFRAMEBUFFERTEXTURE3DEXTPROC) (GLuint framebuffer, GLenum attachment, GLenum textarget, GLuint texture, GLint level, GLint zoffset);
typedef void ( * PFNGLNAMEDFRAMEBUFFERRENDERBUFFEREXTPROC) (GLuint framebuffer, GLenum attachment, GLenum renderbuffertarget, GLuint renderbuffer);
typedef void ( * PFNGLGETNAMEDFRAMEBUFFERATTACHMENTPARAMETERIVEXTPROC) (GLuint framebuffer, GLenum attachment, GLenum pname, GLint *params);
typedef void ( * PFNGLGENERATETEXTUREMIPMAPEXTPROC) (GLuint texture, GLenum target);
typedef void ( * PFNGLGENERATEMULTITEXMIPMAPEXTPROC) (GLenum texunit, GLenum target);
typedef void ( * PFNGLFRAMEBUFFERDRAWBUFFEREXTPROC) (GLuint framebuffer, GLenum mode);
typedef void ( * PFNGLFRAMEBUFFERDRAWBUFFERSEXTPROC) (GLuint framebuffer, GLsizei n, const GLenum *bufs);
typedef void ( * PFNGLFRAMEBUFFERREADBUFFEREXTPROC) (GLuint framebuffer, GLenum mode);
typedef void ( * PFNGLGETFRAMEBUFFERPARAMETERIVEXTPROC) (GLuint framebuffer, GLenum pname, GLint *params);
typedef void ( * PFNGLNAMEDCOPYBUFFERSUBDATAEXTPROC) (GLuint readBuffer, GLuint writeBuffer, GLintptr readOffset, GLintptr writeOffset, GLsizeiptr size);
typedef void ( * PFNGLNAMEDFRAMEBUFFERTEXTUREEXTPROC) (GLuint framebuffer, GLenum attachment, GLuint texture, GLint level);
typedef void ( * PFNGLNAMEDFRAMEBUFFERTEXTURELAYEREXTPROC) (GLuint framebuffer, GLenum attachment, GLuint texture, GLint level, GLint layer);
typedef void ( * PFNGLNAMEDFRAMEBUFFERTEXTUREFACEEXTPROC) (GLuint framebuffer, GLenum attachment, GLuint texture, GLint level, GLenum face);
typedef void ( * PFNGLTEXTURERENDERBUFFEREXTPROC) (GLuint texture, GLenum target, GLuint renderbuffer);
typedef void ( * PFNGLMULTITEXRENDERBUFFEREXTPROC) (GLenum texunit, GLenum target, GLuint renderbuffer);
typedef void ( * PFNGLVERTEXARRAYVERTEXOFFSETEXTPROC) (GLuint vaobj, GLuint buffer, GLint size, GLenum type, GLsizei stride, GLintptr offset);
typedef void ( * PFNGLVERTEXARRAYCOLOROFFSETEXTPROC) (GLuint vaobj, GLuint buffer, GLint size, GLenum type, GLsizei stride, GLintptr offset);
typedef void ( * PFNGLVERTEXARRAYEDGEFLAGOFFSETEXTPROC) (GLuint vaobj, GLuint buffer, GLsizei stride, GLintptr offset);
typedef void ( * PFNGLVERTEXARRAYINDEXOFFSETEXTPROC) (GLuint vaobj, GLuint buffer, GLenum type, GLsizei stride, GLintptr offset);
typedef void ( * PFNGLVERTEXARRAYNORMALOFFSETEXTPROC) (GLuint vaobj, GLuint buffer, GLenum type, GLsizei stride, GLintptr offset);
typedef void ( * PFNGLVERTEXARRAYTEXCOORDOFFSETEXTPROC) (GLuint vaobj, GLuint buffer, GLint size, GLenum type, GLsizei stride, GLintptr offset);
typedef void ( * PFNGLVERTEXARRAYMULTITEXCOORDOFFSETEXTPROC) (GLuint vaobj, GLuint buffer, GLenum texunit, GLint size, GLenum type, GLsizei stride, GLintptr offset);
typedef void ( * PFNGLVERTEXARRAYFOGCOORDOFFSETEXTPROC) (GLuint vaobj, GLuint buffer, GLenum type, GLsizei stride, GLintptr offset);
typedef void ( * PFNGLVERTEXARRAYSECONDARYCOLOROFFSETEXTPROC) (GLuint vaobj, GLuint buffer, GLint size, GLenum type, GLsizei stride, GLintptr offset);
typedef void ( * PFNGLVERTEXARRAYVERTEXATTRIBOFFSETEXTPROC) (GLuint vaobj, GLuint buffer, GLuint index, GLint size, GLenum type, GLboolean normalized, GLsizei stride, GLintptr offset);
typedef void ( * PFNGLVERTEXARRAYVERTEXATTRIBIOFFSETEXTPROC) (GLuint vaobj, GLuint buffer, GLuint index, GLint size, GLenum type, GLsizei stride, GLintptr offset);
typedef void ( * PFNGLENABLEVERTEXARRAYEXTPROC) (GLuint vaobj, GLenum array);
typedef void ( * PFNGLDISABLEVERTEXARRAYEXTPROC) (GLuint vaobj, GLenum array);
typedef void ( * PFNGLENABLEVERTEXARRAYATTRIBEXTPROC) (GLuint vaobj, GLuint index);
typedef void ( * PFNGLDISABLEVERTEXARRAYATTRIBEXTPROC) (GLuint vaobj, GLuint index);
typedef void ( * PFNGLGETVERTEXARRAYINTEGERVEXTPROC) (GLuint vaobj, GLenum pname, GLint *param);
typedef void ( * PFNGLGETVERTEXARRAYPOINTERVEXTPROC) (GLuint vaobj, GLenum pname, void **param);
typedef void ( * PFNGLGETVERTEXARRAYINTEGERI_VEXTPROC) (GLuint vaobj, GLuint index, GLenum pname, GLint *param);
typedef void ( * PFNGLGETVERTEXARRAYPOINTERI_VEXTPROC) (GLuint vaobj, GLuint index, GLenum pname, void **param);
typedef void *( * PFNGLMAPNAMEDBUFFERRANGEEXTPROC) (GLuint buffer, GLintptr offset, GLsizeiptr length, GLbitfield access);
typedef void ( * PFNGLFLUSHMAPPEDNAMEDBUFFERRANGEEXTPROC) (GLuint buffer, GLintptr offset, GLsizeiptr length);
typedef void ( * PFNGLNAMEDBUFFERSTORAGEEXTPROC) (GLuint buffer, GLsizeiptr size, const void *data, GLbitfield flags);
typedef void ( * PFNGLCLEARNAMEDBUFFERDATAEXTPROC) (GLuint buffer, GLenum internalformat, GLenum format, GLenum type, const void *data);
typedef void ( * PFNGLCLEARNAMEDBUFFERSUBDATAEXTPROC) (GLuint buffer, GLenum internalformat, GLsizeiptr offset, GLsizeiptr size, GLenum format, GLenum type, const void *data);
typedef void ( * PFNGLNAMEDFRAMEBUFFERPARAMETERIEXTPROC) (GLuint framebuffer, GLenum pname, GLint param);
typedef void ( * PFNGLGETNAMEDFRAMEBUFFERPARAMETERIVEXTPROC) (GLuint framebuffer, GLenum pname, GLint *params);
typedef void ( * PFNGLPROGRAMUNIFORM1DEXTPROC) (GLuint program, GLint location, GLdouble x);
typedef void ( * PFNGLPROGRAMUNIFORM2DEXTPROC) (GLuint program, GLint location, GLdouble x, GLdouble y);
typedef void ( * PFNGLPROGRAMUNIFORM3DEXTPROC) (GLuint program, GLint location, GLdouble x, GLdouble y, GLdouble z);
typedef void ( * PFNGLPROGRAMUNIFORM4DEXTPROC) (GLuint program, GLint location, GLdouble x, GLdouble y, GLdouble z, GLdouble w);
typedef void ( * PFNGLPROGRAMUNIFORM1DVEXTPROC) (GLuint program, GLint location, GLsizei count, const GLdouble *value);
typedef void ( * PFNGLPROGRAMUNIFORM2DVEXTPROC) (GLuint program, GLint location, GLsizei count, const GLdouble *value);
typedef void ( * PFNGLPROGRAMUNIFORM3DVEXTPROC) (GLuint program, GLint location, GLsizei count, const GLdouble *value);
typedef void ( * PFNGLPROGRAMUNIFORM4DVEXTPROC) (GLuint program, GLint location, GLsizei count, const GLdouble *value);
typedef void ( * PFNGLPROGRAMUNIFORMMATRIX2DVEXTPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
typedef void ( * PFNGLPROGRAMUNIFORMMATRIX3DVEXTPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
typedef void ( * PFNGLPROGRAMUNIFORMMATRIX4DVEXTPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
typedef void ( * PFNGLPROGRAMUNIFORMMATRIX2X3DVEXTPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
typedef void ( * PFNGLPROGRAMUNIFORMMATRIX2X4DVEXTPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
typedef void ( * PFNGLPROGRAMUNIFORMMATRIX3X2DVEXTPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
typedef void ( * PFNGLPROGRAMUNIFORMMATRIX3X4DVEXTPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
typedef void ( * PFNGLPROGRAMUNIFORMMATRIX4X2DVEXTPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
typedef void ( * PFNGLPROGRAMUNIFORMMATRIX4X3DVEXTPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
typedef void ( * PFNGLTEXTUREBUFFERRANGEEXTPROC) (GLuint texture, GLenum target, GLenum internalformat, GLuint buffer, GLintptr offset, GLsizeiptr size);
typedef void ( * PFNGLTEXTURESTORAGE1DEXTPROC) (GLuint texture, GLenum target, GLsizei levels, GLenum internalformat, GLsizei width);
typedef void ( * PFNGLTEXTURESTORAGE2DEXTPROC) (GLuint texture, GLenum target, GLsizei levels, GLenum internalformat, GLsizei width, GLsizei height);
typedef void ( * PFNGLTEXTURESTORAGE3DEXTPROC) (GLuint texture, GLenum target, GLsizei levels, GLenum internalformat, GLsizei width, GLsizei height, GLsizei depth);
typedef void ( * PFNGLTEXTURESTORAGE2DMULTISAMPLEEXTPROC) (GLuint texture, GLenum target, GLsizei samples, GLenum internalformat, GLsizei width, GLsizei height, GLboolean fixedsamplelocations);
typedef void ( * PFNGLTEXTURESTORAGE3DMULTISAMPLEEXTPROC) (GLuint texture, GLenum target, GLsizei samples, GLenum internalformat, GLsizei width, GLsizei height, GLsizei depth, GLboolean fixedsamplelocations);
typedef void ( * PFNGLVERTEXARRAYBINDVERTEXBUFFEREXTPROC) (GLuint vaobj, GLuint bindingindex, GLuint buffer, GLintptr offset, GLsizei stride);
typedef void ( * PFNGLVERTEXARRAYVERTEXATTRIBFORMATEXTPROC) (GLuint vaobj, GLuint attribindex, GLint size, GLenum type, GLboolean normalized, GLuint relativeoffset);
typedef void ( * PFNGLVERTEXARRAYVERTEXATTRIBIFORMATEXTPROC) (GLuint vaobj, GLuint attribindex, GLint size, GLenum type, GLuint relativeoffset);
typedef void ( * PFNGLVERTEXARRAYVERTEXATTRIBLFORMATEXTPROC) (GLuint vaobj, GLuint attribindex, GLint size, GLenum type, GLuint relativeoffset);
typedef void ( * PFNGLVERTEXARRAYVERTEXATTRIBBINDINGEXTPROC) (GLuint vaobj, GLuint attribindex, GLuint bindingindex);
typedef void ( * PFNGLVERTEXARRAYVERTEXBINDINGDIVISOREXTPROC) (GLuint vaobj, GLuint bindingindex, GLuint divisor);
typedef void ( * PFNGLVERTEXARRAYVERTEXATTRIBLOFFSETEXTPROC) (GLuint vaobj, GLuint buffer, GLuint index, GLint size, GLenum type, GLsizei stride, GLintptr offset);
typedef void ( * PFNGLTEXTUREPAGECOMMITMENTEXTPROC) (GLuint texture, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth, GLboolean commit);
typedef void ( * PFNGLVERTEXARRAYVERTEXATTRIBDIVISOREXTPROC) (GLuint vaobj, GLuint index, GLuint divisor);
typedef void ( * PFNGLCOLORMASKINDEXEDEXTPROC) (GLuint index, GLboolean r, GLboolean g, GLboolean b, GLboolean a);
typedef void ( * PFNGLDRAWARRAYSINSTANCEDEXTPROC) (GLenum mode, GLint start, GLsizei count, GLsizei primcount);
typedef void ( * PFNGLDRAWELEMENTSINSTANCEDEXTPROC) (GLenum mode, GLsizei count, GLenum type, const void *indices, GLsizei primcount);
typedef void ( * PFNGLDRAWRANGEELEMENTSEXTPROC) (GLenum mode, GLuint start, GLuint end, GLsizei count, GLenum type, const void *indices);
typedef void *GLeglClientBufferEXT;
typedef void ( * PFNGLBUFFERSTORAGEEXTERNALEXTPROC) (GLenum target, GLintptr offset, GLsizeiptr size, GLeglClientBufferEXT clientBuffer, GLbitfield flags);
typedef void ( * PFNGLNAMEDBUFFERSTORAGEEXTERNALEXTPROC) (GLuint buffer, GLintptr offset, GLsizeiptr size, GLeglClientBufferEXT clientBuffer, GLbitfield flags);
typedef void ( * PFNGLFOGCOORDFEXTPROC) (GLfloat coord);
typedef void ( * PFNGLFOGCOORDFVEXTPROC) (const GLfloat *coord);
typedef void ( * PFNGLFOGCOORDDEXTPROC) (GLdouble coord);
typedef void ( * PFNGLFOGCOORDDVEXTPROC) (const GLdouble *coord);
typedef void ( * PFNGLFOGCOORDPOINTEREXTPROC) (GLenum type, GLsizei stride, const void *pointer);
typedef void ( * PFNGLBLITFRAMEBUFFEREXTPROC) (GLint srcX0, GLint srcY0, GLint srcX1, GLint srcY1, GLint dstX0, GLint dstY0, GLint dstX1, GLint dstY1, GLbitfield mask, GLenum filter);
typedef void ( * PFNGLRENDERBUFFERSTORAGEMULTISAMPLEEXTPROC) (GLenum target, GLsizei samples, GLenum internalformat, GLsizei width, GLsizei height);
typedef GLboolean ( * PFNGLISRENDERBUFFEREXTPROC) (GLuint renderbuffer);
typedef void ( * PFNGLBINDRENDERBUFFEREXTPROC) (GLenum target, GLuint renderbuffer);
typedef void ( * PFNGLDELETERENDERBUFFERSEXTPROC) (GLsizei n, const GLuint *renderbuffers);
typedef void ( * PFNGLGENRENDERBUFFERSEXTPROC) (GLsizei n, GLuint *renderbuffers);
typedef void ( * PFNGLRENDERBUFFERSTORAGEEXTPROC) (GLenum target, GLenum internalformat, GLsizei width, GLsizei height);
typedef void ( * PFNGLGETRENDERBUFFERPARAMETERIVEXTPROC) (GLenum target, GLenum pname, GLint *params);
typedef GLboolean ( * PFNGLISFRAMEBUFFEREXTPROC) (GLuint framebuffer);
typedef void ( * PFNGLBINDFRAMEBUFFEREXTPROC) (GLenum target, GLuint framebuffer);
typedef void ( * PFNGLDELETEFRAMEBUFFERSEXTPROC) (GLsizei n, const GLuint *framebuffers);
typedef void ( * PFNGLGENFRAMEBUFFERSEXTPROC) (GLsizei n, GLuint *framebuffers);
typedef GLenum ( * PFNGLCHECKFRAMEBUFFERSTATUSEXTPROC) (GLenum target);
typedef void ( * PFNGLFRAMEBUFFERTEXTURE1DEXTPROC) (GLenum target, GLenum attachment, GLenum textarget, GLuint texture, GLint level);
typedef void ( * PFNGLFRAMEBUFFERTEXTURE2DEXTPROC) (GLenum target, GLenum attachment, GLenum textarget, GLuint texture, GLint level);
typedef void ( * PFNGLFRAMEBUFFERTEXTURE3DEXTPROC) (GLenum target, GLenum attachment, GLenum textarget, GLuint texture, GLint level, GLint zoffset);
typedef void ( * PFNGLFRAMEBUFFERRENDERBUFFEREXTPROC) (GLenum target, GLenum attachment, GLenum renderbuffertarget, GLuint renderbuffer);
typedef void ( * PFNGLGETFRAMEBUFFERATTACHMENTPARAMETERIVEXTPROC) (GLenum target, GLenum attachment, GLenum pname, GLint *params);
typedef void ( * PFNGLGENERATEMIPMAPEXTPROC) (GLenum target);
typedef void ( * PFNGLPROGRAMPARAMETERIEXTPROC) (GLuint program, GLenum pname, GLint value);
typedef void ( * PFNGLPROGRAMENVPARAMETERS4FVEXTPROC) (GLenum target, GLuint index, GLsizei count, const GLfloat *params);
typedef void ( * PFNGLPROGRAMLOCALPARAMETERS4FVEXTPROC) (GLenum target, GLuint index, GLsizei count, const GLfloat *params);
typedef void ( * PFNGLGETUNIFORMUIVEXTPROC) (GLuint program, GLint location, GLuint *params);
typedef void ( * PFNGLBINDFRAGDATALOCATIONEXTPROC) (GLuint program, GLuint color, const GLchar *name);
typedef GLint ( * PFNGLGETFRAGDATALOCATIONEXTPROC) (GLuint program, const GLchar *name);
typedef void ( * PFNGLUNIFORM1UIEXTPROC) (GLint location, GLuint v0);
typedef void ( * PFNGLUNIFORM2UIEXTPROC) (GLint location, GLuint v0, GLuint v1);
typedef void ( * PFNGLUNIFORM3UIEXTPROC) (GLint location, GLuint v0, GLuint v1, GLuint v2);
typedef void ( * PFNGLUNIFORM4UIEXTPROC) (GLint location, GLuint v0, GLuint v1, GLuint v2, GLuint v3);
typedef void ( * PFNGLUNIFORM1UIVEXTPROC) (GLint location, GLsizei count, const GLuint *value);
typedef void ( * PFNGLUNIFORM2UIVEXTPROC) (GLint location, GLsizei count, const GLuint *value);
typedef void ( * PFNGLUNIFORM3UIVEXTPROC) (GLint location, GLsizei count, const GLuint *value);
typedef void ( * PFNGLUNIFORM4UIVEXTPROC) (GLint location, GLsizei count, const GLuint *value);
typedef void ( * PFNGLGETHISTOGRAMEXTPROC) (GLenum target, GLboolean reset, GLenum format, GLenum type, void *values);
typedef void ( * PFNGLGETHISTOGRAMPARAMETERFVEXTPROC) (GLenum target, GLenum pname, GLfloat *params);
typedef void ( * PFNGLGETHISTOGRAMPARAMETERIVEXTPROC) (GLenum target, GLenum pname, GLint *params);
typedef void ( * PFNGLGETMINMAXEXTPROC) (GLenum target, GLboolean reset, GLenum format, GLenum type, void *values);
typedef void ( * PFNGLGETMINMAXPARAMETERFVEXTPROC) (GLenum target, GLenum pname, GLfloat *params);
typedef void ( * PFNGLGETMINMAXPARAMETERIVEXTPROC) (GLenum target, GLenum pname, GLint *params);
typedef void ( * PFNGLHISTOGRAMEXTPROC) (GLenum target, GLsizei width, GLenum internalformat, GLboolean sink);
typedef void ( * PFNGLMINMAXEXTPROC) (GLenum target, GLenum internalformat, GLboolean sink);
typedef void ( * PFNGLRESETHISTOGRAMEXTPROC) (GLenum target);
typedef void ( * PFNGLRESETMINMAXEXTPROC) (GLenum target);
typedef void ( * PFNGLINDEXFUNCEXTPROC) (GLenum func, GLclampf ref);
typedef void ( * PFNGLINDEXMATERIALEXTPROC) (GLenum face, GLenum mode);
typedef void ( * PFNGLAPPLYTEXTUREEXTPROC) (GLenum mode);
typedef void ( * PFNGLTEXTURELIGHTEXTPROC) (GLenum pname);
typedef void ( * PFNGLTEXTUREMATERIALEXTPROC) (GLenum face, GLenum mode);
typedef void ( * PFNGLGETUNSIGNEDBYTEVEXTPROC) (GLenum pname, GLubyte *data);
typedef void ( * PFNGLGETUNSIGNEDBYTEI_VEXTPROC) (GLenum target, GLuint index, GLubyte *data);
typedef void ( * PFNGLDELETEMEMORYOBJECTSEXTPROC) (GLsizei n, const GLuint *memoryObjects);
typedef GLboolean ( * PFNGLISMEMORYOBJECTEXTPROC) (GLuint memoryObject);
typedef void ( * PFNGLCREATEMEMORYOBJECTSEXTPROC) (GLsizei n, GLuint *memoryObjects);
typedef void ( * PFNGLMEMORYOBJECTPARAMETERIVEXTPROC) (GLuint memoryObject, GLenum pname, const GLint *params);
typedef void ( * PFNGLGETMEMORYOBJECTPARAMETERIVEXTPROC) (GLuint memoryObject, GLenum pname, GLint *params);
typedef void ( * PFNGLTEXSTORAGEMEM2DEXTPROC) (GLenum target, GLsizei levels, GLenum internalFormat, GLsizei width, GLsizei height, GLuint memory, GLuint64 offset);
typedef void ( * PFNGLTEXSTORAGEMEM2DMULTISAMPLEEXTPROC) (GLenum target, GLsizei samples, GLenum internalFormat, GLsizei width, GLsizei height, GLboolean fixedSampleLocations, GLuint memory, GLuint64 offset);
typedef void ( * PFNGLTEXSTORAGEMEM3DEXTPROC) (GLenum target, GLsizei levels, GLenum internalFormat, GLsizei width, GLsizei height, GLsizei depth, GLuint memory, GLuint64 offset);
typedef void ( * PFNGLTEXSTORAGEMEM3DMULTISAMPLEEXTPROC) (GLenum target, GLsizei samples, GLenum internalFormat, GLsizei width, GLsizei height, GLsizei depth, GLboolean fixedSampleLocations, GLuint memory, GLuint64 offset);
typedef void ( * PFNGLBUFFERSTORAGEMEMEXTPROC) (GLenum target, GLsizeiptr size, GLuint memory, GLuint64 offset);
typedef void ( * PFNGLTEXTURESTORAGEMEM2DEXTPROC) (GLuint texture, GLsizei levels, GLenum internalFormat, GLsizei width, GLsizei height, GLuint memory, GLuint64 offset);
typedef void ( * PFNGLTEXTURESTORAGEMEM2DMULTISAMPLEEXTPROC) (GLuint texture, GLsizei samples, GLenum internalFormat, GLsizei width, GLsizei height, GLboolean fixedSampleLocations, GLuint memory, GLuint64 offset);
typedef void ( * PFNGLTEXTURESTORAGEMEM3DEXTPROC) (GLuint texture, GLsizei levels, GLenum internalFormat, GLsizei width, GLsizei height, GLsizei depth, GLuint memory, GLuint64 offset);
typedef void ( * PFNGLTEXTURESTORAGEMEM3DMULTISAMPLEEXTPROC) (GLuint texture, GLsizei samples, GLenum internalFormat, GLsizei width, GLsizei height, GLsizei depth, GLboolean fixedSampleLocations, GLuint memory, GLuint64 offset);
typedef void ( * PFNGLNAMEDBUFFERSTORAGEMEMEXTPROC) (GLuint buffer, GLsizeiptr size, GLuint memory, GLuint64 offset);
typedef void ( * PFNGLTEXSTORAGEMEM1DEXTPROC) (GLenum target, GLsizei levels, GLenum internalFormat, GLsizei width, GLuint memory, GLuint64 offset);
typedef void ( * PFNGLTEXTURESTORAGEMEM1DEXTPROC) (GLuint texture, GLsizei levels, GLenum internalFormat, GLsizei width, GLuint memory, GLuint64 offset);
typedef void ( * PFNGLIMPORTMEMORYFDEXTPROC) (GLuint memory, GLuint64 size, GLenum handleType, GLint fd);
typedef void ( * PFNGLIMPORTMEMORYWIN32HANDLEEXTPROC) (GLuint memory, GLuint64 size, GLenum handleType, void *handle);
typedef void ( * PFNGLIMPORTMEMORYWIN32NAMEEXTPROC) (GLuint memory, GLuint64 size, GLenum handleType, const void *name);
typedef void ( * PFNGLMULTIDRAWARRAYSEXTPROC) (GLenum mode, const GLint *first, const GLsizei *count, GLsizei primcount);
typedef void ( * PFNGLMULTIDRAWELEMENTSEXTPROC) (GLenum mode, const GLsizei *count, GLenum type, const void *const*indices, GLsizei primcount);
typedef void ( * PFNGLSAMPLEMASKEXTPROC) (GLclampf value, GLboolean invert);
typedef void ( * PFNGLSAMPLEPATTERNEXTPROC) (GLenum pattern);
typedef void ( * PFNGLPIXELTRANSFORMPARAMETERIEXTPROC) (GLenum target, GLenum pname, GLint param);
typedef void ( * PFNGLPIXELTRANSFORMPARAMETERFEXTPROC) (GLenum target, GLenum pname, GLfloat param);
typedef void ( * PFNGLPIXELTRANSFORMPARAMETERIVEXTPROC) (GLenum target, GLenum pname, const GLint *params);
typedef void ( * PFNGLPIXELTRANSFORMPARAMETERFVEXTPROC) (GLenum target, GLenum pname, const GLfloat *params);
typedef void ( * PFNGLGETPIXELTRANSFORMPARAMETERIVEXTPROC) (GLenum target, GLenum pname, GLint *params);
typedef void ( * PFNGLGETPIXELTRANSFORMPARAMETERFVEXTPROC) (GLenum target, GLenum pname, GLfloat *params);
typedef void ( * PFNGLPOINTPARAMETERFEXTPROC) (GLenum pname, GLfloat param);
typedef void ( * PFNGLPOINTPARAMETERFVEXTPROC) (GLenum pname, const GLfloat *params);
typedef void ( * PFNGLPOLYGONOFFSETEXTPROC) (GLfloat factor, GLfloat bias);
typedef void ( * PFNGLPOLYGONOFFSETCLAMPEXTPROC) (GLfloat factor, GLfloat units, GLfloat clamp);
typedef void ( * PFNGLPROVOKINGVERTEXEXTPROC) (GLenum mode);
typedef void ( * PFNGLRASTERSAMPLESEXTPROC) (GLuint samples, GLboolean fixedsamplelocations);
typedef void ( * PFNGLSECONDARYCOLOR3BEXTPROC) (GLbyte red, GLbyte green, GLbyte blue);
typedef void ( * PFNGLSECONDARYCOLOR3BVEXTPROC) (const GLbyte *v);
typedef void ( * PFNGLSECONDARYCOLOR3DEXTPROC) (GLdouble red, GLdouble green, GLdouble blue);
typedef void ( * PFNGLSECONDARYCOLOR3DVEXTPROC) (const GLdouble *v);
typedef void ( * PFNGLSECONDARYCOLOR3FEXTPROC) (GLfloat red, GLfloat green, GLfloat blue);
typedef void ( * PFNGLSECONDARYCOLOR3FVEXTPROC) (const GLfloat *v);
typedef void ( * PFNGLSECONDARYCOLOR3IEXTPROC) (GLint red, GLint green, GLint blue);
typedef void ( * PFNGLSECONDARYCOLOR3IVEXTPROC) (const GLint *v);
typedef void ( * PFNGLSECONDARYCOLOR3SEXTPROC) (GLshort red, GLshort green, GLshort blue);
typedef void ( * PFNGLSECONDARYCOLOR3SVEXTPROC) (const GLshort *v);
typedef void ( * PFNGLSECONDARYCOLOR3UBEXTPROC) (GLubyte red, GLubyte green, GLubyte blue);
typedef void ( * PFNGLSECONDARYCOLOR3UBVEXTPROC) (const GLubyte *v);
typedef void ( * PFNGLSECONDARYCOLOR3UIEXTPROC) (GLuint red, GLuint green, GLuint blue);
typedef void ( * PFNGLSECONDARYCOLOR3UIVEXTPROC) (const GLuint *v);
typedef void ( * PFNGLSECONDARYCOLOR3USEXTPROC) (GLushort red, GLushort green, GLushort blue);
typedef void ( * PFNGLSECONDARYCOLOR3USVEXTPROC) (const GLushort *v);
typedef void ( * PFNGLSECONDARYCOLORPOINTEREXTPROC) (GLint size, GLenum type, GLsizei stride, const void *pointer);
typedef void ( * PFNGLGENSEMAPHORESEXTPROC) (GLsizei n, GLuint *semaphores);
typedef void ( * PFNGLDELETESEMAPHORESEXTPROC) (GLsizei n, const GLuint *semaphores);
typedef GLboolean ( * PFNGLISSEMAPHOREEXTPROC) (GLuint semaphore);
typedef void ( * PFNGLSEMAPHOREPARAMETERUI64VEXTPROC) (GLuint semaphore, GLenum pname, const GLuint64 *params);
typedef void ( * PFNGLGETSEMAPHOREPARAMETERUI64VEXTPROC) (GLuint semaphore, GLenum pname, GLuint64 *params);
typedef void ( * PFNGLWAITSEMAPHOREEXTPROC) (GLuint semaphore, GLuint numBufferBarriers, const GLuint *buffers, GLuint numTextureBarriers, const GLuint *textures, const GLenum *srcLayouts);
typedef void ( * PFNGLSIGNALSEMAPHOREEXTPROC) (GLuint semaphore, GLuint numBufferBarriers, const GLuint *buffers, GLuint numTextureBarriers, const GLuint *textures, const GLenum *dstLayouts);
typedef void ( * PFNGLIMPORTSEMAPHOREFDEXTPROC) (GLuint semaphore, GLenum handleType, GLint fd);
typedef void ( * PFNGLIMPORTSEMAPHOREWIN32HANDLEEXTPROC) (GLuint semaphore, GLenum handleType, void *handle);
typedef void ( * PFNGLIMPORTSEMAPHOREWIN32NAMEEXTPROC) (GLuint semaphore, GLenum handleType, const void *name);
typedef void ( * PFNGLUSESHADERPROGRAMEXTPROC) (GLenum type, GLuint program);
typedef void ( * PFNGLACTIVEPROGRAMEXTPROC) (GLuint program);
typedef GLuint ( * PFNGLCREATESHADERPROGRAMEXTPROC) (GLenum type, const GLchar *string);
typedef void ( * PFNGLFRAMEBUFFERFETCHBARRIEREXTPROC) (void);
typedef void ( * PFNGLBINDIMAGETEXTUREEXTPROC) (GLuint index, GLuint texture, GLint level, GLboolean layered, GLint layer, GLenum access, GLint format);
typedef void ( * PFNGLMEMORYBARRIEREXTPROC) (GLbitfield barriers);
typedef void ( * PFNGLSTENCILCLEARTAGEXTPROC) (GLsizei stencilTagBits, GLuint stencilClearTag);
typedef void ( * PFNGLACTIVESTENCILFACEEXTPROC) (GLenum face);
typedef void ( * PFNGLTEXSUBIMAGE1DEXTPROC) (GLenum target, GLint level, GLint xoffset, GLsizei width, GLenum format, GLenum type, const void *pixels);
typedef void ( * PFNGLTEXSUBIMAGE2DEXTPROC) (GLenum target, GLint level, GLint xoffset, GLint yoffset, GLsizei width, GLsizei height, GLenum format, GLenum type, const void *pixels);
typedef void ( * PFNGLTEXIMAGE3DEXTPROC) (GLenum target, GLint level, GLenum internalformat, GLsizei width, GLsizei height, GLsizei depth, GLint border, GLenum format, GLenum type, const void *pixels);
typedef void ( * PFNGLTEXSUBIMAGE3DEXTPROC) (GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth, GLenum format, GLenum type, const void *pixels);
typedef void ( * PFNGLFRAMEBUFFERTEXTURELAYEREXTPROC) (GLenum target, GLenum attachment, GLuint texture, GLint level, GLint layer);
typedef void ( * PFNGLTEXBUFFEREXTPROC) (GLenum target, GLenum internalformat, GLuint buffer);
typedef void ( * PFNGLTEXPARAMETERIIVEXTPROC) (GLenum target, GLenum pname, const GLint *params);
typedef void ( * PFNGLTEXPARAMETERIUIVEXTPROC) (GLenum target, GLenum pname, const GLuint *params);
typedef void ( * PFNGLGETTEXPARAMETERIIVEXTPROC) (GLenum target, GLenum pname, GLint *params);
typedef void ( * PFNGLGETTEXPARAMETERIUIVEXTPROC) (GLenum target, GLenum pname, GLuint *params);
typedef void ( * PFNGLCLEARCOLORIIEXTPROC) (GLint red, GLint green, GLint blue, GLint alpha);
typedef void ( * PFNGLCLEARCOLORIUIEXTPROC) (GLuint red, GLuint green, GLuint blue, GLuint alpha);
typedef GLboolean ( * PFNGLARETEXTURESRESIDENTEXTPROC) (GLsizei n, const GLuint *textures, GLboolean *residences);
typedef void ( * PFNGLBINDTEXTUREEXTPROC) (GLenum target, GLuint texture);
typedef void ( * PFNGLDELETETEXTURESEXTPROC) (GLsizei n, const GLuint *textures);
typedef void ( * PFNGLGENTEXTURESEXTPROC) (GLsizei n, GLuint *textures);
typedef GLboolean ( * PFNGLISTEXTUREEXTPROC) (GLuint texture);
typedef void ( * PFNGLPRIORITIZETEXTURESEXTPROC) (GLsizei n, const GLuint *textures, const GLclampf *priorities);
typedef void ( * PFNGLTEXTURENORMALEXTPROC) (GLenum mode);
typedef void ( * PFNGLGETQUERYOBJECTI64VEXTPROC) (GLuint id, GLenum pname, GLint64 *params);
typedef void ( * PFNGLGETQUERYOBJECTUI64VEXTPROC) (GLuint id, GLenum pname, GLuint64 *params);
typedef void ( * PFNGLBEGINTRANSFORMFEEDBACKEXTPROC) (GLenum primitiveMode);
typedef void ( * PFNGLENDTRANSFORMFEEDBACKEXTPROC) (void);
typedef void ( * PFNGLBINDBUFFERRANGEEXTPROC) (GLenum target, GLuint index, GLuint buffer, GLintptr offset, GLsizeiptr size);
typedef void ( * PFNGLBINDBUFFEROFFSETEXTPROC) (GLenum target, GLuint index, GLuint buffer, GLintptr offset);
typedef void ( * PFNGLBINDBUFFERBASEEXTPROC) (GLenum target, GLuint index, GLuint buffer);
typedef void ( * PFNGLTRANSFORMFEEDBACKVARYINGSEXTPROC) (GLuint program, GLsizei count, const GLchar *const*varyings, GLenum bufferMode);
typedef void ( * PFNGLGETTRANSFORMFEEDBACKVARYINGEXTPROC) (GLuint program, GLuint index, GLsizei bufSize, GLsizei *length, GLsizei *size, GLenum *type, GLchar *name);
typedef void ( * PFNGLVERTEXATTRIBL1DEXTPROC) (GLuint index, GLdouble x);
typedef void ( * PFNGLVERTEXATTRIBL2DEXTPROC) (GLuint index, GLdouble x, GLdouble y);
typedef void ( * PFNGLVERTEXATTRIBL3DEXTPROC) (GLuint index, GLdouble x, GLdouble y, GLdouble z);
typedef void ( * PFNGLVERTEXATTRIBL4DEXTPROC) (GLuint index, GLdouble x, GLdouble y, GLdouble z, GLdouble w);
typedef void ( * PFNGLVERTEXATTRIBL1DVEXTPROC) (GLuint index, const GLdouble *v);
typedef void ( * PFNGLVERTEXATTRIBL2DVEXTPROC) (GLuint index, const GLdouble *v);
typedef void ( * PFNGLVERTEXATTRIBL3DVEXTPROC) (GLuint index, const GLdouble *v);
typedef void ( * PFNGLVERTEXATTRIBL4DVEXTPROC) (GLuint index, const GLdouble *v);
typedef void ( * PFNGLVERTEXATTRIBLPOINTEREXTPROC) (GLuint index, GLint size, GLenum type, GLsizei stride, const void *pointer);
typedef void ( * PFNGLGETVERTEXATTRIBLDVEXTPROC) (GLuint index, GLenum pname, GLdouble *params);
typedef void ( * PFNGLBEGINVERTEXSHADEREXTPROC) (void);
typedef void ( * PFNGLENDVERTEXSHADEREXTPROC) (void);
typedef void ( * PFNGLBINDVERTEXSHADEREXTPROC) (GLuint id);
typedef GLuint ( * PFNGLGENVERTEXSHADERSEXTPROC) (GLuint range);
typedef void ( * PFNGLDELETEVERTEXSHADEREXTPROC) (GLuint id);
typedef void ( * PFNGLSHADEROP1EXTPROC) (GLenum op, GLuint res, GLuint arg1);
typedef void ( * PFNGLSHADEROP2EXTPROC) (GLenum op, GLuint res, GLuint arg1, GLuint arg2);
typedef void ( * PFNGLSHADEROP3EXTPROC) (GLenum op, GLuint res, GLuint arg1, GLuint arg2, GLuint arg3);
typedef void ( * PFNGLSWIZZLEEXTPROC) (GLuint res, GLuint in, GLenum outX, GLenum outY, GLenum outZ, GLenum outW);
typedef void ( * PFNGLWRITEMASKEXTPROC) (GLuint res, GLuint in, GLenum outX, GLenum outY, GLenum outZ, GLenum outW);
typedef void ( * PFNGLINSERTCOMPONENTEXTPROC) (GLuint res, GLuint src, GLuint num);
typedef void ( * PFNGLEXTRACTCOMPONENTEXTPROC) (GLuint res, GLuint src, GLuint num);
typedef GLuint ( * PFNGLGENSYMBOLSEXTPROC) (GLenum datatype, GLenum storagetype, GLenum range, GLuint components);
typedef void ( * PFNGLSETINVARIANTEXTPROC) (GLuint id, GLenum type, const void *addr);
typedef void ( * PFNGLSETLOCALCONSTANTEXTPROC) (GLuint id, GLenum type, const void *addr);
typedef void ( * PFNGLVARIANTBVEXTPROC) (GLuint id, const GLbyte *addr);
typedef void ( * PFNGLVARIANTSVEXTPROC) (GLuint id, const GLshort *addr);
typedef void ( * PFNGLVARIANTIVEXTPROC) (GLuint id, const GLint *addr);
typedef void ( * PFNGLVARIANTFVEXTPROC) (GLuint id, const GLfloat *addr);
typedef void ( * PFNGLVARIANTDVEXTPROC) (GLuint id, const GLdouble *addr);
typedef void ( * PFNGLVARIANTUBVEXTPROC) (GLuint id, const GLubyte *addr);
typedef void ( * PFNGLVARIANTUSVEXTPROC) (GLuint id, const GLushort *addr);
typedef void ( * PFNGLVARIANTUIVEXTPROC) (GLuint id, const GLuint *addr);
typedef void ( * PFNGLVARIANTPOINTEREXTPROC) (GLuint id, GLenum type, GLuint stride, const void *addr);
typedef void ( * PFNGLENABLEVARIANTCLIENTSTATEEXTPROC) (GLuint id);
typedef void ( * PFNGLDISABLEVARIANTCLIENTSTATEEXTPROC) (GLuint id);
typedef GLuint ( * PFNGLBINDLIGHTPARAMETEREXTPROC) (GLenum light, GLenum value);
typedef GLuint ( * PFNGLBINDMATERIALPARAMETEREXTPROC) (GLenum face, GLenum value);
typedef GLuint ( * PFNGLBINDTEXGENPARAMETEREXTPROC) (GLenum unit, GLenum coord, GLenum value);
typedef GLuint ( * PFNGLBINDTEXTUREUNITPARAMETEREXTPROC) (GLenum unit, GLenum value);
typedef GLuint ( * PFNGLBINDPARAMETEREXTPROC) (GLenum value);
typedef GLboolean ( * PFNGLISVARIANTENABLEDEXTPROC) (GLuint id, GLenum cap);
typedef void ( * PFNGLGETVARIANTBOOLEANVEXTPROC) (GLuint id, GLenum value, GLboolean *data);
typedef void ( * PFNGLGETVARIANTINTEGERVEXTPROC) (GLuint id, GLenum value, GLint *data);
typedef void ( * PFNGLGETVARIANTFLOATVEXTPROC) (GLuint id, GLenum value, GLfloat *data);
typedef void ( * PFNGLGETVARIANTPOINTERVEXTPROC) (GLuint id, GLenum value, void **data);
typedef void ( * PFNGLGETINVARIANTBOOLEANVEXTPROC) (GLuint id, GLenum value, GLboolean *data);
typedef void ( * PFNGLGETINVARIANTINTEGERVEXTPROC) (GLuint id, GLenum value, GLint *data);
typedef void ( * PFNGLGETINVARIANTFLOATVEXTPROC) (GLuint id, GLenum value, GLfloat *data);
typedef void ( * PFNGLGETLOCALCONSTANTBOOLEANVEXTPROC) (GLuint id, GLenum value, GLboolean *data);
typedef void ( * PFNGLGETLOCALCONSTANTINTEGERVEXTPROC) (GLuint id, GLenum value, GLint *data);
typedef void ( * PFNGLGETLOCALCONSTANTFLOATVEXTPROC) (GLuint id, GLenum value, GLfloat *data);
typedef void ( * PFNGLVERTEXWEIGHTFEXTPROC) (GLfloat weight);
typedef void ( * PFNGLVERTEXWEIGHTFVEXTPROC) (const GLfloat *weight);
typedef void ( * PFNGLVERTEXWEIGHTPOINTEREXTPROC) (GLint size, GLenum type, GLsizei stride, const void *pointer);
typedef GLboolean ( * PFNGLACQUIREKEYEDMUTEXWIN32EXTPROC) (GLuint memory, GLuint64 key, GLuint timeout);
typedef GLboolean ( * PFNGLRELEASEKEYEDMUTEXWIN32EXTPROC) (GLuint memory, GLuint64 key);
typedef void ( * PFNGLWINDOWRECTANGLESEXTPROC) (GLenum mode, GLsizei count, const GLint *box);
typedef GLsync ( * PFNGLIMPORTSYNCEXTPROC) (GLenum external_sync_type, GLintptr external_sync, GLbitfield flags);
typedef void ( * PFNGLFRAMETERMINATORGREMEDYPROC) (void);
typedef void ( * PFNGLSTRINGMARKERGREMEDYPROC) (GLsizei len, const void *string);
typedef void ( * PFNGLIMAGETRANSFORMPARAMETERIHPPROC) (GLenum target, GLenum pname, GLint param);
typedef void ( * PFNGLIMAGETRANSFORMPARAMETERFHPPROC) (GLenum target, GLenum pname, GLfloat param);
typedef void ( * PFNGLIMAGETRANSFORMPARAMETERIVHPPROC) (GLenum target, GLenum pname, const GLint *params);
typedef void ( * PFNGLIMAGETRANSFORMPARAMETERFVHPPROC) (GLenum target, GLenum pname, const GLfloat *params);
typedef void ( * PFNGLGETIMAGETRANSFORMPARAMETERIVHPPROC) (GLenum target, GLenum pname, GLint *params);
typedef void ( * PFNGLGETIMAGETRANSFORMPARAMETERFVHPPROC) (GLenum target, GLenum pname, GLfloat *params);
typedef void ( * PFNGLMULTIMODEDRAWARRAYSIBMPROC) (const GLenum *mode, const GLint *first, const GLsizei *count, GLsizei primcount, GLint modestride);
typedef void ( * PFNGLMULTIMODEDRAWELEMENTSIBMPROC) (const GLenum *mode, const GLsizei *count, GLenum type, const void *const*indices, GLsizei primcount, GLint modestride);
typedef void ( * PFNGLFLUSHSTATICDATAIBMPROC) (GLenum target);
typedef void ( * PFNGLCOLORPOINTERLISTIBMPROC) (GLint size, GLenum type, GLint stride, const void **pointer, GLint ptrstride);
typedef void ( * PFNGLSECONDARYCOLORPOINTERLISTIBMPROC) (GLint size, GLenum type, GLint stride, const void **pointer, GLint ptrstride);
typedef void ( * PFNGLEDGEFLAGPOINTERLISTIBMPROC) (GLint stride, const GLboolean **pointer, GLint ptrstride);
typedef void ( * PFNGLFOGCOORDPOINTERLISTIBMPROC) (GLenum type, GLint stride, const void **pointer, GLint ptrstride);
typedef void ( * PFNGLINDEXPOINTERLISTIBMPROC) (GLenum type, GLint stride, const void **pointer, GLint ptrstride);
typedef void ( * PFNGLNORMALPOINTERLISTIBMPROC) (GLenum type, GLint stride, const void **pointer, GLint ptrstride);
typedef void ( * PFNGLTEXCOORDPOINTERLISTIBMPROC) (GLint size, GLenum type, GLint stride, const void **pointer, GLint ptrstride);
typedef void ( * PFNGLVERTEXPOINTERLISTIBMPROC) (GLint size, GLenum type, GLint stride, const void **pointer, GLint ptrstride);
typedef void ( * PFNGLBLENDFUNCSEPARATEINGRPROC) (GLenum sfactorRGB, GLenum dfactorRGB, GLenum sfactorAlpha, GLenum dfactorAlpha);
typedef void ( * PFNGLAPPLYFRAMEBUFFERATTACHMENTCMAAINTELPROC) (void);
typedef void ( * PFNGLSYNCTEXTUREINTELPROC) (GLuint texture);
typedef void ( * PFNGLUNMAPTEXTURE2DINTELPROC) (GLuint texture, GLint level);
typedef void *( * PFNGLMAPTEXTURE2DINTELPROC) (GLuint texture, GLint level, GLbitfield access, GLint *stride, GLenum *layout);
typedef void ( * PFNGLVERTEXPOINTERVINTELPROC) (GLint size, GLenum type, const void **pointer);
typedef void ( * PFNGLNORMALPOINTERVINTELPROC) (GLenum type, const void **pointer);
typedef void ( * PFNGLCOLORPOINTERVINTELPROC) (GLint size, GLenum type, const void **pointer);
typedef void ( * PFNGLTEXCOORDPOINTERVINTELPROC) (GLint size, GLenum type, const void **pointer);
typedef void ( * PFNGLBEGINPERFQUERYINTELPROC) (GLuint queryHandle);
typedef void ( * PFNGLCREATEPERFQUERYINTELPROC) (GLuint queryId, GLuint *queryHandle);
typedef void ( * PFNGLDELETEPERFQUERYINTELPROC) (GLuint queryHandle);
typedef void ( * PFNGLENDPERFQUERYINTELPROC) (GLuint queryHandle);
typedef void ( * PFNGLGETFIRSTPERFQUERYIDINTELPROC) (GLuint *queryId);
typedef void ( * PFNGLGETNEXTPERFQUERYIDINTELPROC) (GLuint queryId, GLuint *nextQueryId);
typedef void ( * PFNGLGETPERFCOUNTERINFOINTELPROC) (GLuint queryId, GLuint counterId, GLuint counterNameLength, GLchar *counterName, GLuint counterDescLength, GLchar *counterDesc, GLuint *counterOffset, GLuint *counterDataSize, GLuint *counterTypeEnum, GLuint *counterDataTypeEnum, GLuint64 *rawCounterMaxValue);
typedef void ( * PFNGLGETPERFQUERYDATAINTELPROC) (GLuint queryHandle, GLuint flags, GLsizei dataSize, void *data, GLuint *bytesWritten);
typedef void ( * PFNGLGETPERFQUERYIDBYNAMEINTELPROC) (GLchar *queryName, GLuint *queryId);
typedef void ( * PFNGLGETPERFQUERYINFOINTELPROC) (GLuint queryId, GLuint queryNameLength, GLchar *queryName, GLuint *dataSize, GLuint *noCounters, GLuint *noInstances, GLuint *capsMask);
typedef void ( * PFNGLFRAMEBUFFERPARAMETERIMESAPROC) (GLenum target, GLenum pname, GLint param);
typedef void ( * PFNGLGETFRAMEBUFFERPARAMETERIVMESAPROC) (GLenum target, GLenum pname, GLint *params);
typedef void ( * PFNGLRESIZEBUFFERSMESAPROC) (void);
typedef void ( * PFNGLWINDOWPOS2DMESAPROC) (GLdouble x, GLdouble y);
typedef void ( * PFNGLWINDOWPOS2DVMESAPROC) (const GLdouble *v);
typedef void ( * PFNGLWINDOWPOS2FMESAPROC) (GLfloat x, GLfloat y);
typedef void ( * PFNGLWINDOWPOS2FVMESAPROC) (const GLfloat *v);
typedef void ( * PFNGLWINDOWPOS2IMESAPROC) (GLint x, GLint y);
typedef void ( * PFNGLWINDOWPOS2IVMESAPROC) (const GLint *v);
typedef void ( * PFNGLWINDOWPOS2SMESAPROC) (GLshort x, GLshort y);
typedef void ( * PFNGLWINDOWPOS2SVMESAPROC) (const GLshort *v);
typedef void ( * PFNGLWINDOWPOS3DMESAPROC) (GLdouble x, GLdouble y, GLdouble z);
typedef void ( * PFNGLWINDOWPOS3DVMESAPROC) (const GLdouble *v);
typedef void ( * PFNGLWINDOWPOS3FMESAPROC) (GLfloat x, GLfloat y, GLfloat z);
typedef void ( * PFNGLWINDOWPOS3FVMESAPROC) (const GLfloat *v);
typedef void ( * PFNGLWINDOWPOS3IMESAPROC) (GLint x, GLint y, GLint z);
typedef void ( * PFNGLWINDOWPOS3IVMESAPROC) (const GLint *v);
typedef void ( * PFNGLWINDOWPOS3SMESAPROC) (GLshort x, GLshort y, GLshort z);
typedef void ( * PFNGLWINDOWPOS3SVMESAPROC) (const GLshort *v);
typedef void ( * PFNGLWINDOWPOS4DMESAPROC) (GLdouble x, GLdouble y, GLdouble z, GLdouble w);
typedef void ( * PFNGLWINDOWPOS4DVMESAPROC) (const GLdouble *v);
typedef void ( * PFNGLWINDOWPOS4FMESAPROC) (GLfloat x, GLfloat y, GLfloat z, GLfloat w);
typedef void ( * PFNGLWINDOWPOS4FVMESAPROC) (const GLfloat *v);
typedef void ( * PFNGLWINDOWPOS4IMESAPROC) (GLint x, GLint y, GLint z, GLint w);
typedef void ( * PFNGLWINDOWPOS4IVMESAPROC) (const GLint *v);
typedef void ( * PFNGLWINDOWPOS4SMESAPROC) (GLshort x, GLshort y, GLshort z, GLshort w);
typedef void ( * PFNGLWINDOWPOS4SVMESAPROC) (const GLshort *v);
typedef void ( * PFNGLBEGINCONDITIONALRENDERNVXPROC) (GLuint id);
typedef void ( * PFNGLENDCONDITIONALRENDERNVXPROC) (void);
typedef void ( * PFNGLUPLOADGPUMASKNVXPROC) (GLbitfield mask);
typedef void ( * PFNGLMULTICASTVIEWPORTARRAYVNVXPROC) (GLuint gpu, GLuint first, GLsizei count, const GLfloat *v);
typedef void ( * PFNGLMULTICASTVIEWPORTPOSITIONWSCALENVXPROC) (GLuint gpu, GLuint index, GLfloat xcoeff, GLfloat ycoeff);
typedef void ( * PFNGLMULTICASTSCISSORARRAYVNVXPROC) (GLuint gpu, GLuint first, GLsizei count, const GLint *v);
typedef GLuint ( * PFNGLASYNCCOPYBUFFERSUBDATANVXPROC) (GLsizei waitSemaphoreCount, const GLuint *waitSemaphoreArray, const GLuint64 *fenceValueArray, GLuint readGpu, GLbitfield writeGpuMask, GLuint readBuffer, GLuint writeBuffer, GLintptr readOffset, GLintptr writeOffset, GLsizeiptr size, GLsizei signalSemaphoreCount, const GLuint *signalSemaphoreArray, const GLuint64 *signalValueArray);
typedef GLuint ( * PFNGLASYNCCOPYIMAGESUBDATANVXPROC) (GLsizei waitSemaphoreCount, const GLuint *waitSemaphoreArray, const GLuint64 *waitValueArray, GLuint srcGpu, GLbitfield dstGpuMask, GLuint srcName, GLenum srcTarget, GLint srcLevel, GLint srcX, GLint srcY, GLint srcZ, GLuint dstName, GLenum dstTarget, GLint dstLevel, GLint dstX, GLint dstY, GLint dstZ, GLsizei srcWidth, GLsizei srcHeight, GLsizei srcDepth, GLsizei signalSemaphoreCount, const GLuint *signalSemaphoreArray, const GLuint64 *signalValueArray);
typedef void ( * PFNGLLGPUNAMEDBUFFERSUBDATANVXPROC) (GLbitfield gpuMask, GLuint buffer, GLintptr offset, GLsizeiptr size, const void *data);
typedef void ( * PFNGLLGPUCOPYIMAGESUBDATANVXPROC) (GLuint sourceGpu, GLbitfield destinationGpuMask, GLuint srcName, GLenum srcTarget, GLint srcLevel, GLint srcX, GLint srxY, GLint srcZ, GLuint dstName, GLenum dstTarget, GLint dstLevel, GLint dstX, GLint dstY, GLint dstZ, GLsizei width, GLsizei height, GLsizei depth);
typedef void ( * PFNGLLGPUINTERLOCKNVXPROC) (void);
typedef GLuint ( * PFNGLCREATEPROGRESSFENCENVXPROC) (void);
typedef void ( * PFNGLSIGNALSEMAPHOREUI64NVXPROC) (GLuint signalGpu, GLsizei fenceObjectCount, const GLuint *semaphoreArray, const GLuint64 *fenceValueArray);
typedef void ( * PFNGLWAITSEMAPHOREUI64NVXPROC) (GLuint waitGpu, GLsizei fenceObjectCount, const GLuint *semaphoreArray, const GLuint64 *fenceValueArray);
typedef void ( * PFNGLCLIENTWAITSEMAPHOREUI64NVXPROC) (GLsizei fenceObjectCount, const GLuint *semaphoreArray, const GLuint64 *fenceValueArray);
typedef void ( * PFNGLALPHATOCOVERAGEDITHERCONTROLNVPROC) (GLenum mode);
typedef void ( * PFNGLMULTIDRAWARRAYSINDIRECTBINDLESSNVPROC) (GLenum mode, const void *indirect, GLsizei drawCount, GLsizei stride, GLint vertexBufferCount);
typedef void ( * PFNGLMULTIDRAWELEMENTSINDIRECTBINDLESSNVPROC) (GLenum mode, GLenum type, const void *indirect, GLsizei drawCount, GLsizei stride, GLint vertexBufferCount);
typedef void ( * PFNGLMULTIDRAWARRAYSINDIRECTBINDLESSCOUNTNVPROC) (GLenum mode, const void *indirect, GLsizei drawCount, GLsizei maxDrawCount, GLsizei stride, GLint vertexBufferCount);
typedef void ( * PFNGLMULTIDRAWELEMENTSINDIRECTBINDLESSCOUNTNVPROC) (GLenum mode, GLenum type, const void *indirect, GLsizei drawCount, GLsizei maxDrawCount, GLsizei stride, GLint vertexBufferCount);
typedef GLuint64 ( * PFNGLGETTEXTUREHANDLENVPROC) (GLuint texture);
typedef GLuint64 ( * PFNGLGETTEXTURESAMPLERHANDLENVPROC) (GLuint texture, GLuint sampler);
typedef void ( * PFNGLMAKETEXTUREHANDLERESIDENTNVPROC) (GLuint64 handle);
typedef void ( * PFNGLMAKETEXTUREHANDLENONRESIDENTNVPROC) (GLuint64 handle);
typedef GLuint64 ( * PFNGLGETIMAGEHANDLENVPROC) (GLuint texture, GLint level, GLboolean layered, GLint layer, GLenum format);
typedef void ( * PFNGLMAKEIMAGEHANDLERESIDENTNVPROC) (GLuint64 handle, GLenum access);
typedef void ( * PFNGLMAKEIMAGEHANDLENONRESIDENTNVPROC) (GLuint64 handle);
typedef void ( * PFNGLUNIFORMHANDLEUI64NVPROC) (GLint location, GLuint64 value);
typedef void ( * PFNGLUNIFORMHANDLEUI64VNVPROC) (GLint location, GLsizei count, const GLuint64 *value);
typedef void ( * PFNGLPROGRAMUNIFORMHANDLEUI64NVPROC) (GLuint program, GLint location, GLuint64 value);
typedef void ( * PFNGLPROGRAMUNIFORMHANDLEUI64VNVPROC) (GLuint program, GLint location, GLsizei count, const GLuint64 *values);
typedef GLboolean ( * PFNGLISTEXTUREHANDLERESIDENTNVPROC) (GLuint64 handle);
typedef GLboolean ( * PFNGLISIMAGEHANDLERESIDENTNVPROC) (GLuint64 handle);
typedef void ( * PFNGLBLENDPARAMETERINVPROC) (GLenum pname, GLint value);
typedef void ( * PFNGLBLENDBARRIERNVPROC) (void);
typedef void ( * PFNGLVIEWPORTPOSITIONWSCALENVPROC) (GLuint index, GLfloat xcoeff, GLfloat ycoeff);
typedef void ( * PFNGLCREATESTATESNVPROC) (GLsizei n, GLuint *states);
typedef void ( * PFNGLDELETESTATESNVPROC) (GLsizei n, const GLuint *states);
typedef GLboolean ( * PFNGLISSTATENVPROC) (GLuint state);
typedef void ( * PFNGLSTATECAPTURENVPROC) (GLuint state, GLenum mode);
typedef GLuint ( * PFNGLGETCOMMANDHEADERNVPROC) (GLenum tokenID, GLuint size);
typedef GLushort ( * PFNGLGETSTAGEINDEXNVPROC) (GLenum shadertype);
typedef void ( * PFNGLDRAWCOMMANDSNVPROC) (GLenum primitiveMode, GLuint buffer, const GLintptr *indirects, const GLsizei *sizes, GLuint count);
typedef void ( * PFNGLDRAWCOMMANDSADDRESSNVPROC) (GLenum primitiveMode, const GLuint64 *indirects, const GLsizei *sizes, GLuint count);
typedef void ( * PFNGLDRAWCOMMANDSSTATESNVPROC) (GLuint buffer, const GLintptr *indirects, const GLsizei *sizes, const GLuint *states, const GLuint *fbos, GLuint count);
typedef void ( * PFNGLDRAWCOMMANDSSTATESADDRESSNVPROC) (const GLuint64 *indirects, const GLsizei *sizes, const GLuint *states, const GLuint *fbos, GLuint count);
typedef void ( * PFNGLCREATECOMMANDLISTSNVPROC) (GLsizei n, GLuint *lists);
typedef void ( * PFNGLDELETECOMMANDLISTSNVPROC) (GLsizei n, const GLuint *lists);
typedef GLboolean ( * PFNGLISCOMMANDLISTNVPROC) (GLuint list);
typedef void ( * PFNGLLISTDRAWCOMMANDSSTATESCLIENTNVPROC) (GLuint list, GLuint segment, const void **indirects, const GLsizei *sizes, const GLuint *states, const GLuint *fbos, GLuint count);
typedef void ( * PFNGLCOMMANDLISTSEGMENTSNVPROC) (GLuint list, GLuint segments);
typedef void ( * PFNGLCOMPILECOMMANDLISTNVPROC) (GLuint list);
typedef void ( * PFNGLCALLCOMMANDLISTNVPROC) (GLuint list);
typedef void ( * PFNGLBEGINCONDITIONALRENDERNVPROC) (GLuint id, GLenum mode);
typedef void ( * PFNGLENDCONDITIONALRENDERNVPROC) (void);
typedef void ( * PFNGLSUBPIXELPRECISIONBIASNVPROC) (GLuint xbits, GLuint ybits);
typedef void ( * PFNGLCONSERVATIVERASTERPARAMETERFNVPROC) (GLenum pname, GLfloat value);
typedef void ( * PFNGLCONSERVATIVERASTERPARAMETERINVPROC) (GLenum pname, GLint param);
typedef void ( * PFNGLCOPYIMAGESUBDATANVPROC) (GLuint srcName, GLenum srcTarget, GLint srcLevel, GLint srcX, GLint srcY, GLint srcZ, GLuint dstName, GLenum dstTarget, GLint dstLevel, GLint dstX, GLint dstY, GLint dstZ, GLsizei width, GLsizei height, GLsizei depth);
typedef void ( * PFNGLDEPTHRANGEDNVPROC) (GLdouble zNear, GLdouble zFar);
typedef void ( * PFNGLCLEARDEPTHDNVPROC) (GLdouble depth);
typedef void ( * PFNGLDEPTHBOUNDSDNVPROC) (GLdouble zmin, GLdouble zmax);
typedef void ( * PFNGLDRAWTEXTURENVPROC) (GLuint texture, GLuint sampler, GLfloat x0, GLfloat y0, GLfloat x1, GLfloat y1, GLfloat z, GLfloat s0, GLfloat t0, GLfloat s1, GLfloat t1);
typedef void ( *GLVULKANPROCNV)(void);
typedef void ( * PFNGLDRAWVKIMAGENVPROC) (GLuint64 vkImage, GLuint sampler, GLfloat x0, GLfloat y0, GLfloat x1, GLfloat y1, GLfloat z, GLfloat s0, GLfloat t0, GLfloat s1, GLfloat t1);
typedef GLVULKANPROCNV ( * PFNGLGETVKPROCADDRNVPROC) (const GLchar *name);
typedef void ( * PFNGLWAITVKSEMAPHORENVPROC) (GLuint64 vkSemaphore);
typedef void ( * PFNGLSIGNALVKSEMAPHORENVPROC) (GLuint64 vkSemaphore);
typedef void ( * PFNGLSIGNALVKFENCENVPROC) (GLuint64 vkFence);
typedef void ( * PFNGLMAPCONTROLPOINTSNVPROC) (GLenum target, GLuint index, GLenum type, GLsizei ustride, GLsizei vstride, GLint uorder, GLint vorder, GLboolean packed, const void *points);
typedef void ( * PFNGLMAPPARAMETERIVNVPROC) (GLenum target, GLenum pname, const GLint *params);
typedef void ( * PFNGLMAPPARAMETERFVNVPROC) (GLenum target, GLenum pname, const GLfloat *params);
typedef void ( * PFNGLGETMAPCONTROLPOINTSNVPROC) (GLenum target, GLuint index, GLenum type, GLsizei ustride, GLsizei vstride, GLboolean packed, void *points);
typedef void ( * PFNGLGETMAPPARAMETERIVNVPROC) (GLenum target, GLenum pname, GLint *params);
typedef void ( * PFNGLGETMAPPARAMETERFVNVPROC) (GLenum target, GLenum pname, GLfloat *params);
typedef void ( * PFNGLGETMAPATTRIBPARAMETERIVNVPROC) (GLenum target, GLuint index, GLenum pname, GLint *params);
typedef void ( * PFNGLGETMAPATTRIBPARAMETERFVNVPROC) (GLenum target, GLuint index, GLenum pname, GLfloat *params);
typedef void ( * PFNGLEVALMAPSNVPROC) (GLenum target, GLenum mode);
typedef void ( * PFNGLGETMULTISAMPLEFVNVPROC) (GLenum pname, GLuint index, GLfloat *val);
typedef void ( * PFNGLSAMPLEMASKINDEXEDNVPROC) (GLuint index, GLbitfield mask);
typedef void ( * PFNGLTEXRENDERBUFFERNVPROC) (GLenum target, GLuint renderbuffer);
typedef void ( * PFNGLDELETEFENCESNVPROC) (GLsizei n, const GLuint *fences);
typedef void ( * PFNGLGENFENCESNVPROC) (GLsizei n, GLuint *fences);
typedef GLboolean ( * PFNGLISFENCENVPROC) (GLuint fence);
typedef GLboolean ( * PFNGLTESTFENCENVPROC) (GLuint fence);
typedef void ( * PFNGLGETFENCEIVNVPROC) (GLuint fence, GLenum pname, GLint *params);
typedef void ( * PFNGLFINISHFENCENVPROC) (GLuint fence);
typedef void ( * PFNGLSETFENCENVPROC) (GLuint fence, GLenum condition);
typedef void ( * PFNGLFRAGMENTCOVERAGECOLORNVPROC) (GLuint color);
typedef void ( * PFNGLPROGRAMNAMEDPARAMETER4FNVPROC) (GLuint id, GLsizei len, const GLubyte *name, GLfloat x, GLfloat y, GLfloat z, GLfloat w);
typedef void ( * PFNGLPROGRAMNAMEDPARAMETER4FVNVPROC) (GLuint id, GLsizei len, const GLubyte *name, const GLfloat *v);
typedef void ( * PFNGLPROGRAMNAMEDPARAMETER4DNVPROC) (GLuint id, GLsizei len, const GLubyte *name, GLdouble x, GLdouble y, GLdouble z, GLdouble w);
typedef void ( * PFNGLPROGRAMNAMEDPARAMETER4DVNVPROC) (GLuint id, GLsizei len, const GLubyte *name, const GLdouble *v);
typedef void ( * PFNGLGETPROGRAMNAMEDPARAMETERFVNVPROC) (GLuint id, GLsizei len, const GLubyte *name, GLfloat *params);
typedef void ( * PFNGLGETPROGRAMNAMEDPARAMETERDVNVPROC) (GLuint id, GLsizei len, const GLubyte *name, GLdouble *params);
typedef void ( * PFNGLCOVERAGEMODULATIONTABLENVPROC) (GLsizei n, const GLfloat *v);
typedef void ( * PFNGLGETCOVERAGEMODULATIONTABLENVPROC) (GLsizei bufSize, GLfloat *v);
typedef void ( * PFNGLCOVERAGEMODULATIONNVPROC) (GLenum components);
typedef void ( * PFNGLRENDERBUFFERSTORAGEMULTISAMPLECOVERAGENVPROC) (GLenum target, GLsizei coverageSamples, GLsizei colorSamples, GLenum internalformat, GLsizei width, GLsizei height);
typedef void ( * PFNGLPROGRAMVERTEXLIMITNVPROC) (GLenum target, GLint limit);
typedef void ( * PFNGLFRAMEBUFFERTEXTUREEXTPROC) (GLenum target, GLenum attachment, GLuint texture, GLint level);
typedef void ( * PFNGLFRAMEBUFFERTEXTUREFACEEXTPROC) (GLenum target, GLenum attachment, GLuint texture, GLint level, GLenum face);
typedef void ( * PFNGLRENDERGPUMASKNVPROC) (GLbitfield mask);
typedef void ( * PFNGLMULTICASTBUFFERSUBDATANVPROC) (GLbitfield gpuMask, GLuint buffer, GLintptr offset, GLsizeiptr size, const void *data);
typedef void ( * PFNGLMULTICASTCOPYBUFFERSUBDATANVPROC) (GLuint readGpu, GLbitfield writeGpuMask, GLuint readBuffer, GLuint writeBuffer, GLintptr readOffset, GLintptr writeOffset, GLsizeiptr size);
typedef void ( * PFNGLMULTICASTCOPYIMAGESUBDATANVPROC) (GLuint srcGpu, GLbitfield dstGpuMask, GLuint srcName, GLenum srcTarget, GLint srcLevel, GLint srcX, GLint srcY, GLint srcZ, GLuint dstName, GLenum dstTarget, GLint dstLevel, GLint dstX, GLint dstY, GLint dstZ, GLsizei srcWidth, GLsizei srcHeight, GLsizei srcDepth);
typedef void ( * PFNGLMULTICASTBLITFRAMEBUFFERNVPROC) (GLuint srcGpu, GLuint dstGpu, GLint srcX0, GLint srcY0, GLint srcX1, GLint srcY1, GLint dstX0, GLint dstY0, GLint dstX1, GLint dstY1, GLbitfield mask, GLenum filter);
typedef void ( * PFNGLMULTICASTFRAMEBUFFERSAMPLELOCATIONSFVNVPROC) (GLuint gpu, GLuint framebuffer, GLuint start, GLsizei count, const GLfloat *v);
typedef void ( * PFNGLMULTICASTBARRIERNVPROC) (void);
typedef void ( * PFNGLMULTICASTWAITSYNCNVPROC) (GLuint signalGpu, GLbitfield waitGpuMask);
typedef void ( * PFNGLMULTICASTGETQUERYOBJECTIVNVPROC) (GLuint gpu, GLuint id, GLenum pname, GLint *params);
typedef void ( * PFNGLMULTICASTGETQUERYOBJECTUIVNVPROC) (GLuint gpu, GLuint id, GLenum pname, GLuint *params);
typedef void ( * PFNGLMULTICASTGETQUERYOBJECTI64VNVPROC) (GLuint gpu, GLuint id, GLenum pname, GLint64 *params);
typedef void ( * PFNGLMULTICASTGETQUERYOBJECTUI64VNVPROC) (GLuint gpu, GLuint id, GLenum pname, GLuint64 *params);
typedef void ( * PFNGLPROGRAMLOCALPARAMETERI4INVPROC) (GLenum target, GLuint index, GLint x, GLint y, GLint z, GLint w);
typedef void ( * PFNGLPROGRAMLOCALPARAMETERI4IVNVPROC) (GLenum target, GLuint index, const GLint *params);
typedef void ( * PFNGLPROGRAMLOCALPARAMETERSI4IVNVPROC) (GLenum target, GLuint index, GLsizei count, const GLint *params);
typedef void ( * PFNGLPROGRAMLOCALPARAMETERI4UINVPROC) (GLenum target, GLuint index, GLuint x, GLuint y, GLuint z, GLuint w);
typedef void ( * PFNGLPROGRAMLOCALPARAMETERI4UIVNVPROC) (GLenum target, GLuint index, const GLuint *params);
typedef void ( * PFNGLPROGRAMLOCALPARAMETERSI4UIVNVPROC) (GLenum target, GLuint index, GLsizei count, const GLuint *params);
typedef void ( * PFNGLPROGRAMENVPARAMETERI4INVPROC) (GLenum target, GLuint index, GLint x, GLint y, GLint z, GLint w);
typedef void ( * PFNGLPROGRAMENVPARAMETERI4IVNVPROC) (GLenum target, GLuint index, const GLint *params);
typedef void ( * PFNGLPROGRAMENVPARAMETERSI4IVNVPROC) (GLenum target, GLuint index, GLsizei count, const GLint *params);
typedef void ( * PFNGLPROGRAMENVPARAMETERI4UINVPROC) (GLenum target, GLuint index, GLuint x, GLuint y, GLuint z, GLuint w);
typedef void ( * PFNGLPROGRAMENVPARAMETERI4UIVNVPROC) (GLenum target, GLuint index, const GLuint *params);
typedef void ( * PFNGLPROGRAMENVPARAMETERSI4UIVNVPROC) (GLenum target, GLuint index, GLsizei count, const GLuint *params);
typedef void ( * PFNGLGETPROGRAMLOCALPARAMETERIIVNVPROC) (GLenum target, GLuint index, GLint *params);
typedef void ( * PFNGLGETPROGRAMLOCALPARAMETERIUIVNVPROC) (GLenum target, GLuint index, GLuint *params);
typedef void ( * PFNGLGETPROGRAMENVPARAMETERIIVNVPROC) (GLenum target, GLuint index, GLint *params);
typedef void ( * PFNGLGETPROGRAMENVPARAMETERIUIVNVPROC) (GLenum target, GLuint index, GLuint *params);
typedef void ( * PFNGLPROGRAMSUBROUTINEPARAMETERSUIVNVPROC) (GLenum target, GLsizei count, const GLuint *params);
typedef void ( * PFNGLGETPROGRAMSUBROUTINEPARAMETERUIVNVPROC) (GLenum target, GLuint index, GLuint *param);
typedef unsigned short GLhalfNV;
typedef void ( * PFNGLVERTEX2HNVPROC) (GLhalfNV x, GLhalfNV y);
typedef void ( * PFNGLVERTEX2HVNVPROC) (const GLhalfNV *v);
typedef void ( * PFNGLVERTEX3HNVPROC) (GLhalfNV x, GLhalfNV y, GLhalfNV z);
typedef void ( * PFNGLVERTEX3HVNVPROC) (const GLhalfNV *v);
typedef void ( * PFNGLVERTEX4HNVPROC) (GLhalfNV x, GLhalfNV y, GLhalfNV z, GLhalfNV w);
typedef void ( * PFNGLVERTEX4HVNVPROC) (const GLhalfNV *v);
typedef void ( * PFNGLNORMAL3HNVPROC) (GLhalfNV nx, GLhalfNV ny, GLhalfNV nz);
typedef void ( * PFNGLNORMAL3HVNVPROC) (const GLhalfNV *v);
typedef void ( * PFNGLCOLOR3HNVPROC) (GLhalfNV red, GLhalfNV green, GLhalfNV blue);
typedef void ( * PFNGLCOLOR3HVNVPROC) (const GLhalfNV *v);
typedef void ( * PFNGLCOLOR4HNVPROC) (GLhalfNV red, GLhalfNV green, GLhalfNV blue, GLhalfNV alpha);
typedef void ( * PFNGLCOLOR4HVNVPROC) (const GLhalfNV *v);
typedef void ( * PFNGLTEXCOORD1HNVPROC) (GLhalfNV s);
typedef void ( * PFNGLTEXCOORD1HVNVPROC) (const GLhalfNV *v);
typedef void ( * PFNGLTEXCOORD2HNVPROC) (GLhalfNV s, GLhalfNV t);
typedef void ( * PFNGLTEXCOORD2HVNVPROC) (const GLhalfNV *v);
typedef void ( * PFNGLTEXCOORD3HNVPROC) (GLhalfNV s, GLhalfNV t, GLhalfNV r);
typedef void ( * PFNGLTEXCOORD3HVNVPROC) (const GLhalfNV *v);
typedef void ( * PFNGLTEXCOORD4HNVPROC) (GLhalfNV s, GLhalfNV t, GLhalfNV r, GLhalfNV q);
typedef void ( * PFNGLTEXCOORD4HVNVPROC) (const GLhalfNV *v);
typedef void ( * PFNGLMULTITEXCOORD1HNVPROC) (GLenum target, GLhalfNV s);
typedef void ( * PFNGLMULTITEXCOORD1HVNVPROC) (GLenum target, const GLhalfNV *v);
typedef void ( * PFNGLMULTITEXCOORD2HNVPROC) (GLenum target, GLhalfNV s, GLhalfNV t);
typedef void ( * PFNGLMULTITEXCOORD2HVNVPROC) (GLenum target, const GLhalfNV *v);
typedef void ( * PFNGLMULTITEXCOORD3HNVPROC) (GLenum target, GLhalfNV s, GLhalfNV t, GLhalfNV r);
typedef void ( * PFNGLMULTITEXCOORD3HVNVPROC) (GLenum target, const GLhalfNV *v);
typedef void ( * PFNGLMULTITEXCOORD4HNVPROC) (GLenum target, GLhalfNV s, GLhalfNV t, GLhalfNV r, GLhalfNV q);
typedef void ( * PFNGLMULTITEXCOORD4HVNVPROC) (GLenum target, const GLhalfNV *v);
typedef void ( * PFNGLFOGCOORDHNVPROC) (GLhalfNV fog);
typedef void ( * PFNGLFOGCOORDHVNVPROC) (const GLhalfNV *fog);
typedef void ( * PFNGLSECONDARYCOLOR3HNVPROC) (GLhalfNV red, GLhalfNV green, GLhalfNV blue);
typedef void ( * PFNGLSECONDARYCOLOR3HVNVPROC) (const GLhalfNV *v);
typedef void ( * PFNGLVERTEXWEIGHTHNVPROC) (GLhalfNV weight);
typedef void ( * PFNGLVERTEXWEIGHTHVNVPROC) (const GLhalfNV *weight);
typedef void ( * PFNGLVERTEXATTRIB1HNVPROC) (GLuint index, GLhalfNV x);
typedef void ( * PFNGLVERTEXATTRIB1HVNVPROC) (GLuint index, const GLhalfNV *v);
typedef void ( * PFNGLVERTEXATTRIB2HNVPROC) (GLuint index, GLhalfNV x, GLhalfNV y);
typedef void ( * PFNGLVERTEXATTRIB2HVNVPROC) (GLuint index, const GLhalfNV *v);
typedef void ( * PFNGLVERTEXATTRIB3HNVPROC) (GLuint index, GLhalfNV x, GLhalfNV y, GLhalfNV z);
typedef void ( * PFNGLVERTEXATTRIB3HVNVPROC) (GLuint index, const GLhalfNV *v);
typedef void ( * PFNGLVERTEXATTRIB4HNVPROC) (GLuint index, GLhalfNV x, GLhalfNV y, GLhalfNV z, GLhalfNV w);
typedef void ( * PFNGLVERTEXATTRIB4HVNVPROC) (GLuint index, const GLhalfNV *v);
typedef void ( * PFNGLVERTEXATTRIBS1HVNVPROC) (GLuint index, GLsizei n, const GLhalfNV *v);
typedef void ( * PFNGLVERTEXATTRIBS2HVNVPROC) (GLuint index, GLsizei n, const GLhalfNV *v);
typedef void ( * PFNGLVERTEXATTRIBS3HVNVPROC) (GLuint index, GLsizei n, const GLhalfNV *v);
typedef void ( * PFNGLVERTEXATTRIBS4HVNVPROC) (GLuint index, GLsizei n, const GLhalfNV *v);
typedef void ( * PFNGLGETINTERNALFORMATSAMPLEIVNVPROC) (GLenum target, GLenum internalformat, GLsizei samples, GLenum pname, GLsizei count, GLint *params);
typedef void ( * PFNGLGETMEMORYOBJECTDETACHEDRESOURCESUIVNVPROC) (GLuint memory, GLenum pname, GLint first, GLsizei count, GLuint *params);
typedef void ( * PFNGLRESETMEMORYOBJECTPARAMETERNVPROC) (GLuint memory, GLenum pname);
typedef void ( * PFNGLTEXATTACHMEMORYNVPROC) (GLenum target, GLuint memory, GLuint64 offset);
typedef void ( * PFNGLBUFFERATTACHMEMORYNVPROC) (GLenum target, GLuint memory, GLuint64 offset);
typedef void ( * PFNGLTEXTUREATTACHMEMORYNVPROC) (GLuint texture, GLuint memory, GLuint64 offset);
typedef void ( * PFNGLNAMEDBUFFERATTACHMEMORYNVPROC) (GLuint buffer, GLuint memory, GLuint64 offset);
typedef void ( * PFNGLBUFFERPAGECOMMITMENTMEMNVPROC) (GLenum target, GLintptr offset, GLsizeiptr size, GLuint memory, GLuint64 memOffset, GLboolean commit);
typedef void ( * PFNGLTEXPAGECOMMITMENTMEMNVPROC) (GLenum target, GLint layer, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth, GLuint memory, GLuint64 offset, GLboolean commit);
typedef void ( * PFNGLNAMEDBUFFERPAGECOMMITMENTMEMNVPROC) (GLuint buffer, GLintptr offset, GLsizeiptr size, GLuint memory, GLuint64 memOffset, GLboolean commit);
typedef void ( * PFNGLTEXTUREPAGECOMMITMENTMEMNVPROC) (GLuint texture, GLint layer, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth, GLuint memory, GLuint64 offset, GLboolean commit);
typedef void ( * PFNGLDRAWMESHTASKSNVPROC) (GLuint first, GLuint count);
typedef void ( * PFNGLDRAWMESHTASKSINDIRECTNVPROC) (GLintptr indirect);
typedef void ( * PFNGLMULTIDRAWMESHTASKSINDIRECTNVPROC) (GLintptr indirect, GLsizei drawcount, GLsizei stride);
typedef void ( * PFNGLMULTIDRAWMESHTASKSINDIRECTCOUNTNVPROC) (GLintptr indirect, GLintptr drawcount, GLsizei maxdrawcount, GLsizei stride);
typedef void ( * PFNGLGENOCCLUSIONQUERIESNVPROC) (GLsizei n, GLuint *ids);
typedef void ( * PFNGLDELETEOCCLUSIONQUERIESNVPROC) (GLsizei n, const GLuint *ids);
typedef GLboolean ( * PFNGLISOCCLUSIONQUERYNVPROC) (GLuint id);
typedef void ( * PFNGLBEGINOCCLUSIONQUERYNVPROC) (GLuint id);
typedef void ( * PFNGLENDOCCLUSIONQUERYNVPROC) (void);
typedef void ( * PFNGLGETOCCLUSIONQUERYIVNVPROC) (GLuint id, GLenum pname, GLint *params);
typedef void ( * PFNGLGETOCCLUSIONQUERYUIVNVPROC) (GLuint id, GLenum pname, GLuint *params);
typedef void ( * PFNGLPROGRAMBUFFERPARAMETERSFVNVPROC) (GLenum target, GLuint bindingIndex, GLuint wordIndex, GLsizei count, const GLfloat *params);
typedef void ( * PFNGLPROGRAMBUFFERPARAMETERSIIVNVPROC) (GLenum target, GLuint bindingIndex, GLuint wordIndex, GLsizei count, const GLint *params);
typedef void ( * PFNGLPROGRAMBUFFERPARAMETERSIUIVNVPROC) (GLenum target, GLuint bindingIndex, GLuint wordIndex, GLsizei count, const GLuint *params);
typedef GLuint ( * PFNGLGENPATHSNVPROC) (GLsizei range);
typedef void ( * PFNGLDELETEPATHSNVPROC) (GLuint path, GLsizei range);
typedef GLboolean ( * PFNGLISPATHNVPROC) (GLuint path);
typedef void ( * PFNGLPATHCOMMANDSNVPROC) (GLuint path, GLsizei numCommands, const GLubyte *commands, GLsizei numCoords, GLenum coordType, const void *coords);
typedef void ( * PFNGLPATHCOORDSNVPROC) (GLuint path, GLsizei numCoords, GLenum coordType, const void *coords);
typedef void ( * PFNGLPATHSUBCOMMANDSNVPROC) (GLuint path, GLsizei commandStart, GLsizei commandsToDelete, GLsizei numCommands, const GLubyte *commands, GLsizei numCoords, GLenum coordType, const void *coords);
typedef void ( * PFNGLPATHSUBCOORDSNVPROC) (GLuint path, GLsizei coordStart, GLsizei numCoords, GLenum coordType, const void *coords);
typedef void ( * PFNGLPATHSTRINGNVPROC) (GLuint path, GLenum format, GLsizei length, const void *pathString);
typedef void ( * PFNGLPATHGLYPHSNVPROC) (GLuint firstPathName, GLenum fontTarget, const void *fontName, GLbitfield fontStyle, GLsizei numGlyphs, GLenum type, const void *charcodes, GLenum handleMissingGlyphs, GLuint pathParameterTemplate, GLfloat emScale);
typedef void ( * PFNGLPATHGLYPHRANGENVPROC) (GLuint firstPathName, GLenum fontTarget, const void *fontName, GLbitfield fontStyle, GLuint firstGlyph, GLsizei numGlyphs, GLenum handleMissingGlyphs, GLuint pathParameterTemplate, GLfloat emScale);
typedef void ( * PFNGLWEIGHTPATHSNVPROC) (GLuint resultPath, GLsizei numPaths, const GLuint *paths, const GLfloat *weights);
typedef void ( * PFNGLCOPYPATHNVPROC) (GLuint resultPath, GLuint srcPath);
typedef void ( * PFNGLINTERPOLATEPATHSNVPROC) (GLuint resultPath, GLuint pathA, GLuint pathB, GLfloat weight);
typedef void ( * PFNGLTRANSFORMPATHNVPROC) (GLuint resultPath, GLuint srcPath, GLenum transformType, const GLfloat *transformValues);
typedef void ( * PFNGLPATHPARAMETERIVNVPROC) (GLuint path, GLenum pname, const GLint *value);
typedef void ( * PFNGLPATHPARAMETERINVPROC) (GLuint path, GLenum pname, GLint value);
typedef void ( * PFNGLPATHPARAMETERFVNVPROC) (GLuint path, GLenum pname, const GLfloat *value);
typedef void ( * PFNGLPATHPARAMETERFNVPROC) (GLuint path, GLenum pname, GLfloat value);
typedef void ( * PFNGLPATHDASHARRAYNVPROC) (GLuint path, GLsizei dashCount, const GLfloat *dashArray);
typedef void ( * PFNGLPATHSTENCILFUNCNVPROC) (GLenum func, GLint ref, GLuint mask);
typedef void ( * PFNGLPATHSTENCILDEPTHOFFSETNVPROC) (GLfloat factor, GLfloat units);
typedef void ( * PFNGLSTENCILFILLPATHNVPROC) (GLuint path, GLenum fillMode, GLuint mask);
typedef void ( * PFNGLSTENCILSTROKEPATHNVPROC) (GLuint path, GLint reference, GLuint mask);
typedef void ( * PFNGLSTENCILFILLPATHINSTANCEDNVPROC) (GLsizei numPaths, GLenum pathNameType, const void *paths, GLuint pathBase, GLenum fillMode, GLuint mask, GLenum transformType, const GLfloat *transformValues);
typedef void ( * PFNGLSTENCILSTROKEPATHINSTANCEDNVPROC) (GLsizei numPaths, GLenum pathNameType, const void *paths, GLuint pathBase, GLint reference, GLuint mask, GLenum transformType, const GLfloat *transformValues);
typedef void ( * PFNGLPATHCOVERDEPTHFUNCNVPROC) (GLenum func);
typedef void ( * PFNGLCOVERFILLPATHNVPROC) (GLuint path, GLenum coverMode);
typedef void ( * PFNGLCOVERSTROKEPATHNVPROC) (GLuint path, GLenum coverMode);
typedef void ( * PFNGLCOVERFILLPATHINSTANCEDNVPROC) (GLsizei numPaths, GLenum pathNameType, const void *paths, GLuint pathBase, GLenum coverMode, GLenum transformType, const GLfloat *transformValues);
typedef void ( * PFNGLCOVERSTROKEPATHINSTANCEDNVPROC) (GLsizei numPaths, GLenum pathNameType, const void *paths, GLuint pathBase, GLenum coverMode, GLenum transformType, const GLfloat *transformValues);
typedef void ( * PFNGLGETPATHPARAMETERIVNVPROC) (GLuint path, GLenum pname, GLint *value);
typedef void ( * PFNGLGETPATHPARAMETERFVNVPROC) (GLuint path, GLenum pname, GLfloat *value);
typedef void ( * PFNGLGETPATHCOMMANDSNVPROC) (GLuint path, GLubyte *commands);
typedef void ( * PFNGLGETPATHCOORDSNVPROC) (GLuint path, GLfloat *coords);
typedef void ( * PFNGLGETPATHDASHARRAYNVPROC) (GLuint path, GLfloat *dashArray);
typedef void ( * PFNGLGETPATHMETRICSNVPROC) (GLbitfield metricQueryMask, GLsizei numPaths, GLenum pathNameType, const void *paths, GLuint pathBase, GLsizei stride, GLfloat *metrics);
typedef void ( * PFNGLGETPATHMETRICRANGENVPROC) (GLbitfield metricQueryMask, GLuint firstPathName, GLsizei numPaths, GLsizei stride, GLfloat *metrics);
typedef void ( * PFNGLGETPATHSPACINGNVPROC) (GLenum pathListMode, GLsizei numPaths, GLenum pathNameType, const void *paths, GLuint pathBase, GLfloat advanceScale, GLfloat kerningScale, GLenum transformType, GLfloat *returnedSpacing);
typedef GLboolean ( * PFNGLISPOINTINFILLPATHNVPROC) (GLuint path, GLuint mask, GLfloat x, GLfloat y);
typedef GLboolean ( * PFNGLISPOINTINSTROKEPATHNVPROC) (GLuint path, GLfloat x, GLfloat y);
typedef GLfloat ( * PFNGLGETPATHLENGTHNVPROC) (GLuint path, GLsizei startSegment, GLsizei numSegments);
typedef GLboolean ( * PFNGLPOINTALONGPATHNVPROC) (GLuint path, GLsizei startSegment, GLsizei numSegments, GLfloat distance, GLfloat *x, GLfloat *y, GLfloat *tangentX, GLfloat *tangentY);
typedef void ( * PFNGLMATRIXLOAD3X2FNVPROC) (GLenum matrixMode, const GLfloat *m);
typedef void ( * PFNGLMATRIXLOAD3X3FNVPROC) (GLenum matrixMode, const GLfloat *m);
typedef void ( * PFNGLMATRIXLOADTRANSPOSE3X3FNVPROC) (GLenum matrixMode, const GLfloat *m);
typedef void ( * PFNGLMATRIXMULT3X2FNVPROC) (GLenum matrixMode, const GLfloat *m);
typedef void ( * PFNGLMATRIXMULT3X3FNVPROC) (GLenum matrixMode, const GLfloat *m);
typedef void ( * PFNGLMATRIXMULTTRANSPOSE3X3FNVPROC) (GLenum matrixMode, const GLfloat *m);
typedef void ( * PFNGLSTENCILTHENCOVERFILLPATHNVPROC) (GLuint path, GLenum fillMode, GLuint mask, GLenum coverMode);
typedef void ( * PFNGLSTENCILTHENCOVERSTROKEPATHNVPROC) (GLuint path, GLint reference, GLuint mask, GLenum coverMode);
typedef void ( * PFNGLSTENCILTHENCOVERFILLPATHINSTANCEDNVPROC) (GLsizei numPaths, GLenum pathNameType, const void *paths, GLuint pathBase, GLenum fillMode, GLuint mask, GLenum coverMode, GLenum transformType, const GLfloat *transformValues);
typedef void ( * PFNGLSTENCILTHENCOVERSTROKEPATHINSTANCEDNVPROC) (GLsizei numPaths, GLenum pathNameType, const void *paths, GLuint pathBase, GLint reference, GLuint mask, GLenum coverMode, GLenum transformType, const GLfloat *transformValues);
typedef GLenum ( * PFNGLPATHGLYPHINDEXRANGENVPROC) (GLenum fontTarget, const void *fontName, GLbitfield fontStyle, GLuint pathParameterTemplate, GLfloat emScale, GLuint baseAndCount[2]);
typedef GLenum ( * PFNGLPATHGLYPHINDEXARRAYNVPROC) (GLuint firstPathName, GLenum fontTarget, const void *fontName, GLbitfield fontStyle, GLuint firstGlyphIndex, GLsizei numGlyphs, GLuint pathParameterTemplate, GLfloat emScale);
typedef GLenum ( * PFNGLPATHMEMORYGLYPHINDEXARRAYNVPROC) (GLuint firstPathName, GLenum fontTarget, GLsizeiptr fontSize, const void *fontData, GLsizei faceIndex, GLuint firstGlyphIndex, GLsizei numGlyphs, GLuint pathParameterTemplate, GLfloat emScale);
typedef void ( * PFNGLPROGRAMPATHFRAGMENTINPUTGENNVPROC) (GLuint program, GLint location, GLenum genMode, GLint components, const GLfloat *coeffs);
typedef void ( * PFNGLGETPROGRAMRESOURCEFVNVPROC) (GLuint program, GLenum programInterface, GLuint index, GLsizei propCount, const GLenum *props, GLsizei count, GLsizei *length, GLfloat *params);
typedef void ( * PFNGLPATHCOLORGENNVPROC) (GLenum color, GLenum genMode, GLenum colorFormat, const GLfloat *coeffs);
typedef void ( * PFNGLPATHTEXGENNVPROC) (GLenum texCoordSet, GLenum genMode, GLint components, const GLfloat *coeffs);
typedef void ( * PFNGLPATHFOGGENNVPROC) (GLenum genMode);
typedef void ( * PFNGLGETPATHCOLORGENIVNVPROC) (GLenum color, GLenum pname, GLint *value);
typedef void ( * PFNGLGETPATHCOLORGENFVNVPROC) (GLenum color, GLenum pname, GLfloat *value);
typedef void ( * PFNGLGETPATHTEXGENIVNVPROC) (GLenum texCoordSet, GLenum pname, GLint *value);
typedef void ( * PFNGLGETPATHTEXGENFVNVPROC) (GLenum texCoordSet, GLenum pname, GLfloat *value);
typedef void ( * PFNGLPIXELDATARANGENVPROC) (GLenum target, GLsizei length, const void *pointer);
typedef void ( * PFNGLFLUSHPIXELDATARANGENVPROC) (GLenum target);
typedef void ( * PFNGLPOINTPARAMETERINVPROC) (GLenum pname, GLint param);
typedef void ( * PFNGLPOINTPARAMETERIVNVPROC) (GLenum pname, const GLint *params);
typedef void ( * PFNGLPRESENTFRAMEKEYEDNVPROC) (GLuint video_slot, GLuint64EXT minPresentTime, GLuint beginPresentTimeId, GLuint presentDurationId, GLenum type, GLenum target0, GLuint fill0, GLuint key0, GLenum target1, GLuint fill1, GLuint key1);
typedef void ( * PFNGLPRESENTFRAMEDUALFILLNVPROC) (GLuint video_slot, GLuint64EXT minPresentTime, GLuint beginPresentTimeId, GLuint presentDurationId, GLenum type, GLenum target0, GLuint fill0, GLenum target1, GLuint fill1, GLenum target2, GLuint fill2, GLenum target3, GLuint fill3);
typedef void ( * PFNGLGETVIDEOIVNVPROC) (GLuint video_slot, GLenum pname, GLint *params);
typedef void ( * PFNGLGETVIDEOUIVNVPROC) (GLuint video_slot, GLenum pname, GLuint *params);
typedef void ( * PFNGLGETVIDEOI64VNVPROC) (GLuint video_slot, GLenum pname, GLint64EXT *params);
typedef void ( * PFNGLGETVIDEOUI64VNVPROC) (GLuint video_slot, GLenum pname, GLuint64EXT *params);
typedef void ( * PFNGLPRIMITIVERESTARTNVPROC) (void);
typedef void ( * PFNGLPRIMITIVERESTARTINDEXNVPROC) (GLuint index);
typedef GLint ( * PFNGLQUERYRESOURCENVPROC) (GLenum queryType, GLint tagId, GLuint count, GLint *buffer);
typedef void ( * PFNGLGENQUERYRESOURCETAGNVPROC) (GLsizei n, GLint *tagIds);
typedef void ( * PFNGLDELETEQUERYRESOURCETAGNVPROC) (GLsizei n, const GLint *tagIds);
typedef void ( * PFNGLQUERYRESOURCETAGNVPROC) (GLint tagId, const GLchar *tagString);
typedef void ( * PFNGLCOMBINERPARAMETERFVNVPROC) (GLenum pname, const GLfloat *params);
typedef void ( * PFNGLCOMBINERPARAMETERFNVPROC) (GLenum pname, GLfloat param);
typedef void ( * PFNGLCOMBINERPARAMETERIVNVPROC) (GLenum pname, const GLint *params);
typedef void ( * PFNGLCOMBINERPARAMETERINVPROC) (GLenum pname, GLint param);
typedef void ( * PFNGLCOMBINERINPUTNVPROC) (GLenum stage, GLenum portion, GLenum variable, GLenum input, GLenum mapping, GLenum componentUsage);
typedef void ( * PFNGLCOMBINEROUTPUTNVPROC) (GLenum stage, GLenum portion, GLenum abOutput, GLenum cdOutput, GLenum sumOutput, GLenum scale, GLenum bias, GLboolean abDotProduct, GLboolean cdDotProduct, GLboolean muxSum);
typedef void ( * PFNGLFINALCOMBINERINPUTNVPROC) (GLenum variable, GLenum input, GLenum mapping, GLenum componentUsage);
typedef void ( * PFNGLGETCOMBINERINPUTPARAMETERFVNVPROC) (GLenum stage, GLenum portion, GLenum variable, GLenum pname, GLfloat *params);
typedef void ( * PFNGLGETCOMBINERINPUTPARAMETERIVNVPROC) (GLenum stage, GLenum portion, GLenum variable, GLenum pname, GLint *params);
typedef void ( * PFNGLGETCOMBINEROUTPUTPARAMETERFVNVPROC) (GLenum stage, GLenum portion, GLenum pname, GLfloat *params);
typedef void ( * PFNGLGETCOMBINEROUTPUTPARAMETERIVNVPROC) (GLenum stage, GLenum portion, GLenum pname, GLint *params);
typedef void ( * PFNGLGETFINALCOMBINERINPUTPARAMETERFVNVPROC) (GLenum variable, GLenum pname, GLfloat *params);
typedef void ( * PFNGLGETFINALCOMBINERINPUTPARAMETERIVNVPROC) (GLenum variable, GLenum pname, GLint *params);
typedef void ( * PFNGLCOMBINERSTAGEPARAMETERFVNVPROC) (GLenum stage, GLenum pname, const GLfloat *params);
typedef void ( * PFNGLGETCOMBINERSTAGEPARAMETERFVNVPROC) (GLenum stage, GLenum pname, GLfloat *params);
typedef void ( * PFNGLFRAMEBUFFERSAMPLELOCATIONSFVNVPROC) (GLenum target, GLuint start, GLsizei count, const GLfloat *v);
typedef void ( * PFNGLNAMEDFRAMEBUFFERSAMPLELOCATIONSFVNVPROC) (GLuint framebuffer, GLuint start, GLsizei count, const GLfloat *v);
typedef void ( * PFNGLRESOLVEDEPTHVALUESNVPROC) (void);
typedef void ( * PFNGLSCISSOREXCLUSIVENVPROC) (GLint x, GLint y, GLsizei width, GLsizei height);
typedef void ( * PFNGLSCISSOREXCLUSIVEARRAYVNVPROC) (GLuint first, GLsizei count, const GLint *v);
typedef void ( * PFNGLMAKEBUFFERRESIDENTNVPROC) (GLenum target, GLenum access);
typedef void ( * PFNGLMAKEBUFFERNONRESIDENTNVPROC) (GLenum target);
typedef GLboolean ( * PFNGLISBUFFERRESIDENTNVPROC) (GLenum target);
typedef void ( * PFNGLMAKENAMEDBUFFERRESIDENTNVPROC) (GLuint buffer, GLenum access);
typedef void ( * PFNGLMAKENAMEDBUFFERNONRESIDENTNVPROC) (GLuint buffer);
typedef GLboolean ( * PFNGLISNAMEDBUFFERRESIDENTNVPROC) (GLuint buffer);
typedef void ( * PFNGLGETBUFFERPARAMETERUI64VNVPROC) (GLenum target, GLenum pname, GLuint64EXT *params);
typedef void ( * PFNGLGETNAMEDBUFFERPARAMETERUI64VNVPROC) (GLuint buffer, GLenum pname, GLuint64EXT *params);
typedef void ( * PFNGLGETINTEGERUI64VNVPROC) (GLenum value, GLuint64EXT *result);
typedef void ( * PFNGLUNIFORMUI64NVPROC) (GLint location, GLuint64EXT value);
typedef void ( * PFNGLUNIFORMUI64VNVPROC) (GLint location, GLsizei count, const GLuint64EXT *value);
typedef void ( * PFNGLPROGRAMUNIFORMUI64NVPROC) (GLuint program, GLint location, GLuint64EXT value);
typedef void ( * PFNGLPROGRAMUNIFORMUI64VNVPROC) (GLuint program, GLint location, GLsizei count, const GLuint64EXT *value);
typedef void ( * PFNGLBINDSHADINGRATEIMAGENVPROC) (GLuint texture);
typedef void ( * PFNGLGETSHADINGRATEIMAGEPALETTENVPROC) (GLuint viewport, GLuint entry, GLenum *rate);
typedef void ( * PFNGLGETSHADINGRATESAMPLELOCATIONIVNVPROC) (GLenum rate, GLuint samples, GLuint index, GLint *location);
typedef void ( * PFNGLSHADINGRATEIMAGEBARRIERNVPROC) (GLboolean synchronize);
typedef void ( * PFNGLSHADINGRATEIMAGEPALETTENVPROC) (GLuint viewport, GLuint first, GLsizei count, const GLenum *rates);
typedef void ( * PFNGLSHADINGRATESAMPLEORDERNVPROC) (GLenum order);
typedef void ( * PFNGLSHADINGRATESAMPLEORDERCUSTOMNVPROC) (GLenum rate, GLuint samples, const GLint *locations);
typedef void ( * PFNGLTEXTUREBARRIERNVPROC) (void);
typedef void ( * PFNGLTEXIMAGE2DMULTISAMPLECOVERAGENVPROC) (GLenum target, GLsizei coverageSamples, GLsizei colorSamples, GLint internalFormat, GLsizei width, GLsizei height, GLboolean fixedSampleLocations);
typedef void ( * PFNGLTEXIMAGE3DMULTISAMPLECOVERAGENVPROC) (GLenum target, GLsizei coverageSamples, GLsizei colorSamples, GLint internalFormat, GLsizei width, GLsizei height, GLsizei depth, GLboolean fixedSampleLocations);
typedef void ( * PFNGLTEXTUREIMAGE2DMULTISAMPLENVPROC) (GLuint texture, GLenum target, GLsizei samples, GLint internalFormat, GLsizei width, GLsizei height, GLboolean fixedSampleLocations);
typedef void ( * PFNGLTEXTUREIMAGE3DMULTISAMPLENVPROC) (GLuint texture, GLenum target, GLsizei samples, GLint internalFormat, GLsizei width, GLsizei height, GLsizei depth, GLboolean fixedSampleLocations);
typedef void ( * PFNGLTEXTUREIMAGE2DMULTISAMPLECOVERAGENVPROC) (GLuint texture, GLenum target, GLsizei coverageSamples, GLsizei colorSamples, GLint internalFormat, GLsizei width, GLsizei height, GLboolean fixedSampleLocations);
typedef void ( * PFNGLTEXTUREIMAGE3DMULTISAMPLECOVERAGENVPROC) (GLuint texture, GLenum target, GLsizei coverageSamples, GLsizei colorSamples, GLint internalFormat, GLsizei width, GLsizei height, GLsizei depth, GLboolean fixedSampleLocations);
typedef void ( * PFNGLCREATESEMAPHORESNVPROC) (GLsizei n, GLuint *semaphores);
typedef void ( * PFNGLSEMAPHOREPARAMETERIVNVPROC) (GLuint semaphore, GLenum pname, const GLint *params);
typedef void ( * PFNGLGETSEMAPHOREPARAMETERIVNVPROC) (GLuint semaphore, GLenum pname, GLint *params);
typedef void ( * PFNGLBEGINTRANSFORMFEEDBACKNVPROC) (GLenum primitiveMode);
typedef void ( * PFNGLENDTRANSFORMFEEDBACKNVPROC) (void);
typedef void ( * PFNGLTRANSFORMFEEDBACKATTRIBSNVPROC) (GLsizei count, const GLint *attribs, GLenum bufferMode);
typedef void ( * PFNGLBINDBUFFERRANGENVPROC) (GLenum target, GLuint index, GLuint buffer, GLintptr offset, GLsizeiptr size);
typedef void ( * PFNGLBINDBUFFEROFFSETNVPROC) (GLenum target, GLuint index, GLuint buffer, GLintptr offset);
typedef void ( * PFNGLBINDBUFFERBASENVPROC) (GLenum target, GLuint index, GLuint buffer);
typedef void ( * PFNGLTRANSFORMFEEDBACKVARYINGSNVPROC) (GLuint program, GLsizei count, const GLint *locations, GLenum bufferMode);
typedef void ( * PFNGLACTIVEVARYINGNVPROC) (GLuint program, const GLchar *name);
typedef GLint ( * PFNGLGETVARYINGLOCATIONNVPROC) (GLuint program, const GLchar *name);
typedef void ( * PFNGLGETACTIVEVARYINGNVPROC) (GLuint program, GLuint index, GLsizei bufSize, GLsizei *length, GLsizei *size, GLenum *type, GLchar *name);
typedef void ( * PFNGLGETTRANSFORMFEEDBACKVARYINGNVPROC) (GLuint program, GLuint index, GLint *location);
typedef void ( * PFNGLTRANSFORMFEEDBACKSTREAMATTRIBSNVPROC) (GLsizei count, const GLint *attribs, GLsizei nbuffers, const GLint *bufstreams, GLenum bufferMode);
typedef void ( * PFNGLBINDTRANSFORMFEEDBACKNVPROC) (GLenum target, GLuint id);
typedef void ( * PFNGLDELETETRANSFORMFEEDBACKSNVPROC) (GLsizei n, const GLuint *ids);
typedef void ( * PFNGLGENTRANSFORMFEEDBACKSNVPROC) (GLsizei n, GLuint *ids);
typedef GLboolean ( * PFNGLISTRANSFORMFEEDBACKNVPROC) (GLuint id);
typedef void ( * PFNGLPAUSETRANSFORMFEEDBACKNVPROC) (void);
typedef void ( * PFNGLRESUMETRANSFORMFEEDBACKNVPROC) (void);
typedef void ( * PFNGLDRAWTRANSFORMFEEDBACKNVPROC) (GLenum mode, GLuint id);
typedef GLintptr GLvdpauSurfaceNV;
typedef void ( * PFNGLVDPAUINITNVPROC) (const void *vdpDevice, const void *getProcAddress);
typedef void ( * PFNGLVDPAUFININVPROC) (void);
typedef GLvdpauSurfaceNV ( * PFNGLVDPAUREGISTERVIDEOSURFACENVPROC) (const void *vdpSurface, GLenum target, GLsizei numTextureNames, const GLuint *textureNames);
typedef GLvdpauSurfaceNV ( * PFNGLVDPAUREGISTEROUTPUTSURFACENVPROC) (const void *vdpSurface, GLenum target, GLsizei numTextureNames, const GLuint *textureNames);
typedef GLboolean ( * PFNGLVDPAUISSURFACENVPROC) (GLvdpauSurfaceNV surface);
typedef void ( * PFNGLVDPAUUNREGISTERSURFACENVPROC) (GLvdpauSurfaceNV surface);
typedef void ( * PFNGLVDPAUGETSURFACEIVNVPROC) (GLvdpauSurfaceNV surface, GLenum pname, GLsizei count, GLsizei *length, GLint *values);
typedef void ( * PFNGLVDPAUSURFACEACCESSNVPROC) (GLvdpauSurfaceNV surface, GLenum access);
typedef void ( * PFNGLVDPAUMAPSURFACESNVPROC) (GLsizei numSurfaces, const GLvdpauSurfaceNV *surfaces);
typedef void ( * PFNGLVDPAUUNMAPSURFACESNVPROC) (GLsizei numSurface, const GLvdpauSurfaceNV *surfaces);
typedef GLvdpauSurfaceNV ( * PFNGLVDPAUREGISTERVIDEOSURFACEWITHPICTURESTRUCTURENVPROC) (const void *vdpSurface, GLenum target, GLsizei numTextureNames, const GLuint *textureNames, GLboolean isFrameStructure);
typedef void ( * PFNGLFLUSHVERTEXARRAYRANGENVPROC) (void);
typedef void ( * PFNGLVERTEXARRAYRANGENVPROC) (GLsizei length, const void *pointer);
typedef void ( * PFNGLVERTEXATTRIBL1I64NVPROC) (GLuint index, GLint64EXT x);
typedef void ( * PFNGLVERTEXATTRIBL2I64NVPROC) (GLuint index, GLint64EXT x, GLint64EXT y);
typedef void ( * PFNGLVERTEXATTRIBL3I64NVPROC) (GLuint index, GLint64EXT x, GLint64EXT y, GLint64EXT z);
typedef void ( * PFNGLVERTEXATTRIBL4I64NVPROC) (GLuint index, GLint64EXT x, GLint64EXT y, GLint64EXT z, GLint64EXT w);
typedef void ( * PFNGLVERTEXATTRIBL1I64VNVPROC) (GLuint index, const GLint64EXT *v);
typedef void ( * PFNGLVERTEXATTRIBL2I64VNVPROC) (GLuint index, const GLint64EXT *v);
typedef void ( * PFNGLVERTEXATTRIBL3I64VNVPROC) (GLuint index, const GLint64EXT *v);
typedef void ( * PFNGLVERTEXATTRIBL4I64VNVPROC) (GLuint index, const GLint64EXT *v);
typedef void ( * PFNGLVERTEXATTRIBL1UI64NVPROC) (GLuint index, GLuint64EXT x);
typedef void ( * PFNGLVERTEXATTRIBL2UI64NVPROC) (GLuint index, GLuint64EXT x, GLuint64EXT y);
typedef void ( * PFNGLVERTEXATTRIBL3UI64NVPROC) (GLuint index, GLuint64EXT x, GLuint64EXT y, GLuint64EXT z);
typedef void ( * PFNGLVERTEXATTRIBL4UI64NVPROC) (GLuint index, GLuint64EXT x, GLuint64EXT y, GLuint64EXT z, GLuint64EXT w);
typedef void ( * PFNGLVERTEXATTRIBL1UI64VNVPROC) (GLuint index, const GLuint64EXT *v);
typedef void ( * PFNGLVERTEXATTRIBL2UI64VNVPROC) (GLuint index, const GLuint64EXT *v);
typedef void ( * PFNGLVERTEXATTRIBL3UI64VNVPROC) (GLuint index, const GLuint64EXT *v);
typedef void ( * PFNGLVERTEXATTRIBL4UI64VNVPROC) (GLuint index, const GLuint64EXT *v);
typedef void ( * PFNGLGETVERTEXATTRIBLI64VNVPROC) (GLuint index, GLenum pname, GLint64EXT *params);
typedef void ( * PFNGLGETVERTEXATTRIBLUI64VNVPROC) (GLuint index, GLenum pname, GLuint64EXT *params);
typedef void ( * PFNGLVERTEXATTRIBLFORMATNVPROC) (GLuint index, GLint size, GLenum type, GLsizei stride);
typedef void ( * PFNGLBUFFERADDRESSRANGENVPROC) (GLenum pname, GLuint index, GLuint64EXT address, GLsizeiptr length);
typedef void ( * PFNGLVERTEXFORMATNVPROC) (GLint size, GLenum type, GLsizei stride);
typedef void ( * PFNGLNORMALFORMATNVPROC) (GLenum type, GLsizei stride);
typedef void ( * PFNGLCOLORFORMATNVPROC) (GLint size, GLenum type, GLsizei stride);
typedef void ( * PFNGLINDEXFORMATNVPROC) (GLenum type, GLsizei stride);
typedef void ( * PFNGLTEXCOORDFORMATNVPROC) (GLint size, GLenum type, GLsizei stride);
typedef void ( * PFNGLEDGEFLAGFORMATNVPROC) (GLsizei stride);
typedef void ( * PFNGLSECONDARYCOLORFORMATNVPROC) (GLint size, GLenum type, GLsizei stride);
typedef void ( * PFNGLFOGCOORDFORMATNVPROC) (GLenum type, GLsizei stride);
typedef void ( * PFNGLVERTEXATTRIBFORMATNVPROC) (GLuint index, GLint size, GLenum type, GLboolean normalized, GLsizei stride);
typedef void ( * PFNGLVERTEXATTRIBIFORMATNVPROC) (GLuint index, GLint size, GLenum type, GLsizei stride);
typedef void ( * PFNGLGETINTEGERUI64I_VNVPROC) (GLenum value, GLuint index, GLuint64EXT *result);
typedef GLboolean ( * PFNGLAREPROGRAMSRESIDENTNVPROC) (GLsizei n, const GLuint *programs, GLboolean *residences);
typedef void ( * PFNGLBINDPROGRAMNVPROC) (GLenum target, GLuint id);
typedef void ( * PFNGLDELETEPROGRAMSNVPROC) (GLsizei n, const GLuint *programs);
typedef void ( * PFNGLEXECUTEPROGRAMNVPROC) (GLenum target, GLuint id, const GLfloat *params);
typedef void ( * PFNGLGENPROGRAMSNVPROC) (GLsizei n, GLuint *programs);
typedef void ( * PFNGLGETPROGRAMPARAMETERDVNVPROC) (GLenum target, GLuint index, GLenum pname, GLdouble *params);
typedef void ( * PFNGLGETPROGRAMPARAMETERFVNVPROC) (GLenum target, GLuint index, GLenum pname, GLfloat *params);
typedef void ( * PFNGLGETPROGRAMIVNVPROC) (GLuint id, GLenum pname, GLint *params);
typedef void ( * PFNGLGETPROGRAMSTRINGNVPROC) (GLuint id, GLenum pname, GLubyte *program);
typedef void ( * PFNGLGETTRACKMATRIXIVNVPROC) (GLenum target, GLuint address, GLenum pname, GLint *params);
typedef void ( * PFNGLGETVERTEXATTRIBDVNVPROC) (GLuint index, GLenum pname, GLdouble *params);
typedef void ( * PFNGLGETVERTEXATTRIBFVNVPROC) (GLuint index, GLenum pname, GLfloat *params);
typedef void ( * PFNGLGETVERTEXATTRIBIVNVPROC) (GLuint index, GLenum pname, GLint *params);
typedef void ( * PFNGLGETVERTEXATTRIBPOINTERVNVPROC) (GLuint index, GLenum pname, void **pointer);
typedef GLboolean ( * PFNGLISPROGRAMNVPROC) (GLuint id);
typedef void ( * PFNGLLOADPROGRAMNVPROC) (GLenum target, GLuint id, GLsizei len, const GLubyte *program);
typedef void ( * PFNGLPROGRAMPARAMETER4DNVPROC) (GLenum target, GLuint index, GLdouble x, GLdouble y, GLdouble z, GLdouble w);
typedef void ( * PFNGLPROGRAMPARAMETER4DVNVPROC) (GLenum target, GLuint index, const GLdouble *v);
typedef void ( * PFNGLPROGRAMPARAMETER4FNVPROC) (GLenum target, GLuint index, GLfloat x, GLfloat y, GLfloat z, GLfloat w);
typedef void ( * PFNGLPROGRAMPARAMETER4FVNVPROC) (GLenum target, GLuint index, const GLfloat *v);
typedef void ( * PFNGLPROGRAMPARAMETERS4DVNVPROC) (GLenum target, GLuint index, GLsizei count, const GLdouble *v);
typedef void ( * PFNGLPROGRAMPARAMETERS4FVNVPROC) (GLenum target, GLuint index, GLsizei count, const GLfloat *v);
typedef void ( * PFNGLREQUESTRESIDENTPROGRAMSNVPROC) (GLsizei n, const GLuint *programs);
typedef void ( * PFNGLTRACKMATRIXNVPROC) (GLenum target, GLuint address, GLenum matrix, GLenum transform);
typedef void ( * PFNGLVERTEXATTRIBPOINTERNVPROC) (GLuint index, GLint fsize, GLenum type, GLsizei stride, const void *pointer);
typedef void ( * PFNGLVERTEXATTRIB1DNVPROC) (GLuint index, GLdouble x);
typedef void ( * PFNGLVERTEXATTRIB1DVNVPROC) (GLuint index, const GLdouble *v);
typedef void ( * PFNGLVERTEXATTRIB1FNVPROC) (GLuint index, GLfloat x);
typedef void ( * PFNGLVERTEXATTRIB1FVNVPROC) (GLuint index, const GLfloat *v);
typedef void ( * PFNGLVERTEXATTRIB1SNVPROC) (GLuint index, GLshort x);
typedef void ( * PFNGLVERTEXATTRIB1SVNVPROC) (GLuint index, const GLshort *v);
typedef void ( * PFNGLVERTEXATTRIB2DNVPROC) (GLuint index, GLdouble x, GLdouble y);
typedef void ( * PFNGLVERTEXATTRIB2DVNVPROC) (GLuint index, const GLdouble *v);
typedef void ( * PFNGLVERTEXATTRIB2FNVPROC) (GLuint index, GLfloat x, GLfloat y);
typedef void ( * PFNGLVERTEXATTRIB2FVNVPROC) (GLuint index, const GLfloat *v);
typedef void ( * PFNGLVERTEXATTRIB2SNVPROC) (GLuint index, GLshort x, GLshort y);
typedef void ( * PFNGLVERTEXATTRIB2SVNVPROC) (GLuint index, const GLshort *v);
typedef void ( * PFNGLVERTEXATTRIB3DNVPROC) (GLuint index, GLdouble x, GLdouble y, GLdouble z);
typedef void ( * PFNGLVERTEXATTRIB3DVNVPROC) (GLuint index, const GLdouble *v);
typedef void ( * PFNGLVERTEXATTRIB3FNVPROC) (GLuint index, GLfloat x, GLfloat y, GLfloat z);
typedef void ( * PFNGLVERTEXATTRIB3FVNVPROC) (GLuint index, const GLfloat *v);
typedef void ( * PFNGLVERTEXATTRIB3SNVPROC) (GLuint index, GLshort x, GLshort y, GLshort z);
typedef void ( * PFNGLVERTEXATTRIB3SVNVPROC) (GLuint index, const GLshort *v);
typedef void ( * PFNGLVERTEXATTRIB4DNVPROC) (GLuint index, GLdouble x, GLdouble y, GLdouble z, GLdouble w);
typedef void ( * PFNGLVERTEXATTRIB4DVNVPROC) (GLuint index, const GLdouble *v);
typedef void ( * PFNGLVERTEXATTRIB4FNVPROC) (GLuint index, GLfloat x, GLfloat y, GLfloat z, GLfloat w);
typedef void ( * PFNGLVERTEXATTRIB4FVNVPROC) (GLuint index, const GLfloat *v);
typedef void ( * PFNGLVERTEXATTRIB4SNVPROC) (GLuint index, GLshort x, GLshort y, GLshort z, GLshort w);
typedef void ( * PFNGLVERTEXATTRIB4SVNVPROC) (GLuint index, const GLshort *v);
typedef void ( * PFNGLVERTEXATTRIB4UBNVPROC) (GLuint index, GLubyte x, GLubyte y, GLubyte z, GLubyte w);
typedef void ( * PFNGLVERTEXATTRIB4UBVNVPROC) (GLuint index, const GLubyte *v);
typedef void ( * PFNGLVERTEXATTRIBS1DVNVPROC) (GLuint index, GLsizei count, const GLdouble *v);
typedef void ( * PFNGLVERTEXATTRIBS1FVNVPROC) (GLuint index, GLsizei count, const GLfloat *v);
typedef void ( * PFNGLVERTEXATTRIBS1SVNVPROC) (GLuint index, GLsizei count, const GLshort *v);
typedef void ( * PFNGLVERTEXATTRIBS2DVNVPROC) (GLuint index, GLsizei count, const GLdouble *v);
typedef void ( * PFNGLVERTEXATTRIBS2FVNVPROC) (GLuint index, GLsizei count, const GLfloat *v);
typedef void ( * PFNGLVERTEXATTRIBS2SVNVPROC) (GLuint index, GLsizei count, const GLshort *v);
typedef void ( * PFNGLVERTEXATTRIBS3DVNVPROC) (GLuint index, GLsizei count, const GLdouble *v);
typedef void ( * PFNGLVERTEXATTRIBS3FVNVPROC) (GLuint index, GLsizei count, const GLfloat *v);
typedef void ( * PFNGLVERTEXATTRIBS3SVNVPROC) (GLuint index, GLsizei count, const GLshort *v);
typedef void ( * PFNGLVERTEXATTRIBS4DVNVPROC) (GLuint index, GLsizei count, const GLdouble *v);
typedef void ( * PFNGLVERTEXATTRIBS4FVNVPROC) (GLuint index, GLsizei count, const GLfloat *v);
typedef void ( * PFNGLVERTEXATTRIBS4SVNVPROC) (GLuint index, GLsizei count, const GLshort *v);
typedef void ( * PFNGLVERTEXATTRIBS4UBVNVPROC) (GLuint index, GLsizei count, const GLubyte *v);
typedef void ( * PFNGLVERTEXATTRIBI1IEXTPROC) (GLuint index, GLint x);
typedef void ( * PFNGLVERTEXATTRIBI2IEXTPROC) (GLuint index, GLint x, GLint y);
typedef void ( * PFNGLVERTEXATTRIBI3IEXTPROC) (GLuint index, GLint x, GLint y, GLint z);
typedef void ( * PFNGLVERTEXATTRIBI4IEXTPROC) (GLuint index, GLint x, GLint y, GLint z, GLint w);
typedef void ( * PFNGLVERTEXATTRIBI1UIEXTPROC) (GLuint index, GLuint x);
typedef void ( * PFNGLVERTEXATTRIBI2UIEXTPROC) (GLuint index, GLuint x, GLuint y);
typedef void ( * PFNGLVERTEXATTRIBI3UIEXTPROC) (GLuint index, GLuint x, GLuint y, GLuint z);
typedef void ( * PFNGLVERTEXATTRIBI4UIEXTPROC) (GLuint index, GLuint x, GLuint y, GLuint z, GLuint w);
typedef void ( * PFNGLVERTEXATTRIBI1IVEXTPROC) (GLuint index, const GLint *v);
typedef void ( * PFNGLVERTEXATTRIBI2IVEXTPROC) (GLuint index, const GLint *v);
typedef void ( * PFNGLVERTEXATTRIBI3IVEXTPROC) (GLuint index, const GLint *v);
typedef void ( * PFNGLVERTEXATTRIBI4IVEXTPROC) (GLuint index, const GLint *v);
typedef void ( * PFNGLVERTEXATTRIBI1UIVEXTPROC) (GLuint index, const GLuint *v);
typedef void ( * PFNGLVERTEXATTRIBI2UIVEXTPROC) (GLuint index, const GLuint *v);
typedef void ( * PFNGLVERTEXATTRIBI3UIVEXTPROC) (GLuint index, const GLuint *v);
typedef void ( * PFNGLVERTEXATTRIBI4UIVEXTPROC) (GLuint index, const GLuint *v);
typedef void ( * PFNGLVERTEXATTRIBI4BVEXTPROC) (GLuint index, const GLbyte *v);
typedef void ( * PFNGLVERTEXATTRIBI4SVEXTPROC) (GLuint index, const GLshort *v);
typedef void ( * PFNGLVERTEXATTRIBI4UBVEXTPROC) (GLuint index, const GLubyte *v);
typedef void ( * PFNGLVERTEXATTRIBI4USVEXTPROC) (GLuint index, const GLushort *v);
typedef void ( * PFNGLVERTEXATTRIBIPOINTEREXTPROC) (GLuint index, GLint size, GLenum type, GLsizei stride, const void *pointer);
typedef void ( * PFNGLGETVERTEXATTRIBIIVEXTPROC) (GLuint index, GLenum pname, GLint *params);
typedef void ( * PFNGLGETVERTEXATTRIBIUIVEXTPROC) (GLuint index, GLenum pname, GLuint *params);
typedef void ( * PFNGLBEGINVIDEOCAPTURENVPROC) (GLuint video_capture_slot);
typedef void ( * PFNGLBINDVIDEOCAPTURESTREAMBUFFERNVPROC) (GLuint video_capture_slot, GLuint stream, GLenum frame_region, GLintptrARB offset);
typedef void ( * PFNGLBINDVIDEOCAPTURESTREAMTEXTURENVPROC) (GLuint video_capture_slot, GLuint stream, GLenum frame_region, GLenum target, GLuint texture);
typedef void ( * PFNGLENDVIDEOCAPTURENVPROC) (GLuint video_capture_slot);
typedef void ( * PFNGLGETVIDEOCAPTUREIVNVPROC) (GLuint video_capture_slot, GLenum pname, GLint *params);
typedef void ( * PFNGLGETVIDEOCAPTURESTREAMIVNVPROC) (GLuint video_capture_slot, GLuint stream, GLenum pname, GLint *params);
typedef void ( * PFNGLGETVIDEOCAPTURESTREAMFVNVPROC) (GLuint video_capture_slot, GLuint stream, GLenum pname, GLfloat *params);
typedef void ( * PFNGLGETVIDEOCAPTURESTREAMDVNVPROC) (GLuint video_capture_slot, GLuint stream, GLenum pname, GLdouble *params);
typedef GLenum ( * PFNGLVIDEOCAPTURENVPROC) (GLuint video_capture_slot, GLuint *sequence_num, GLuint64EXT *capture_time);
typedef void ( * PFNGLVIDEOCAPTURESTREAMPARAMETERIVNVPROC) (GLuint video_capture_slot, GLuint stream, GLenum pname, const GLint *params);
typedef void ( * PFNGLVIDEOCAPTURESTREAMPARAMETERFVNVPROC) (GLuint video_capture_slot, GLuint stream, GLenum pname, const GLfloat *params);
typedef void ( * PFNGLVIDEOCAPTURESTREAMPARAMETERDVNVPROC) (GLuint video_capture_slot, GLuint stream, GLenum pname, const GLdouble *params);
typedef void ( * PFNGLVIEWPORTSWIZZLENVPROC) (GLuint index, GLenum swizzlex, GLenum swizzley, GLenum swizzlez, GLenum swizzlew);
typedef void ( * PFNGLFRAMEBUFFERTEXTUREMULTIVIEWOVRPROC) (GLenum target, GLenum attachment, GLuint texture, GLint level, GLint baseViewIndex, GLsizei numViews);
typedef void ( * PFNGLHINTPGIPROC) (GLenum target, GLint mode);
typedef void ( * PFNGLDETAILTEXFUNCSGISPROC) (GLenum target, GLsizei n, const GLfloat *points);
typedef void ( * PFNGLGETDETAILTEXFUNCSGISPROC) (GLenum target, GLfloat *points);
typedef void ( * PFNGLFOGFUNCSGISPROC) (GLsizei n, const GLfloat *points);
typedef void ( * PFNGLGETFOGFUNCSGISPROC) (GLfloat *points);
typedef void ( * PFNGLSAMPLEMASKSGISPROC) (GLclampf value, GLboolean invert);
typedef void ( * PFNGLSAMPLEPATTERNSGISPROC) (GLenum pattern);
typedef void ( * PFNGLPIXELTEXGENPARAMETERISGISPROC) (GLenum pname, GLint param);
typedef void ( * PFNGLPIXELTEXGENPARAMETERIVSGISPROC) (GLenum pname, const GLint *params);
typedef void ( * PFNGLPIXELTEXGENPARAMETERFSGISPROC) (GLenum pname, GLfloat param);
typedef void ( * PFNGLPIXELTEXGENPARAMETERFVSGISPROC) (GLenum pname, const GLfloat *params);
typedef void ( * PFNGLGETPIXELTEXGENPARAMETERIVSGISPROC) (GLenum pname, GLint *params);
typedef void ( * PFNGLGETPIXELTEXGENPARAMETERFVSGISPROC) (GLenum pname, GLfloat *params);
typedef void ( * PFNGLPOINTPARAMETERFSGISPROC) (GLenum pname, GLfloat param);
typedef void ( * PFNGLPOINTPARAMETERFVSGISPROC) (GLenum pname, const GLfloat *params);
typedef void ( * PFNGLSHARPENTEXFUNCSGISPROC) (GLenum target, GLsizei n, const GLfloat *points);
typedef void ( * PFNGLGETSHARPENTEXFUNCSGISPROC) (GLenum target, GLfloat *points);
typedef void ( * PFNGLTEXIMAGE4DSGISPROC) (GLenum target, GLint level, GLenum internalformat, GLsizei width, GLsizei height, GLsizei depth, GLsizei size4d, GLint border, GLenum format, GLenum type, const void *pixels);
typedef void ( * PFNGLTEXSUBIMAGE4DSGISPROC) (GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLint woffset, GLsizei width, GLsizei height, GLsizei depth, GLsizei size4d, GLenum format, GLenum type, const void *pixels);
typedef void ( * PFNGLTEXTURECOLORMASKSGISPROC) (GLboolean red, GLboolean green, GLboolean blue, GLboolean alpha);
typedef void ( * PFNGLGETTEXFILTERFUNCSGISPROC) (GLenum target, GLenum filter, GLfloat *weights);
typedef void ( * PFNGLTEXFILTERFUNCSGISPROC) (GLenum target, GLenum filter, GLsizei n, const GLfloat *weights);
typedef void ( * PFNGLASYNCMARKERSGIXPROC) (GLuint marker);
typedef GLint ( * PFNGLFINISHASYNCSGIXPROC) (GLuint *markerp);
typedef GLint ( * PFNGLPOLLASYNCSGIXPROC) (GLuint *markerp);
typedef GLuint ( * PFNGLGENASYNCMARKERSSGIXPROC) (GLsizei range);
typedef void ( * PFNGLDELETEASYNCMARKERSSGIXPROC) (GLuint marker, GLsizei range);
typedef GLboolean ( * PFNGLISASYNCMARKERSGIXPROC) (GLuint marker);
typedef void ( * PFNGLFLUSHRASTERSGIXPROC) (void);
typedef void ( * PFNGLFRAGMENTCOLORMATERIALSGIXPROC) (GLenum face, GLenum mode);
typedef void ( * PFNGLFRAGMENTLIGHTFSGIXPROC) (GLenum light, GLenum pname, GLfloat param);
typedef void ( * PFNGLFRAGMENTLIGHTFVSGIXPROC) (GLenum light, GLenum pname, const GLfloat *params);
typedef void ( * PFNGLFRAGMENTLIGHTISGIXPROC) (GLenum light, GLenum pname, GLint param);
typedef void ( * PFNGLFRAGMENTLIGHTIVSGIXPROC) (GLenum light, GLenum pname, const GLint *params);
typedef void ( * PFNGLFRAGMENTLIGHTMODELFSGIXPROC) (GLenum pname, GLfloat param);
typedef void ( * PFNGLFRAGMENTLIGHTMODELFVSGIXPROC) (GLenum pname, const GLfloat *params);
typedef void ( * PFNGLFRAGMENTLIGHTMODELISGIXPROC) (GLenum pname, GLint param);
typedef void ( * PFNGLFRAGMENTLIGHTMODELIVSGIXPROC) (GLenum pname, const GLint *params);
typedef void ( * PFNGLFRAGMENTMATERIALFSGIXPROC) (GLenum face, GLenum pname, GLfloat param);
typedef void ( * PFNGLFRAGMENTMATERIALFVSGIXPROC) (GLenum face, GLenum pname, const GLfloat *params);
typedef void ( * PFNGLFRAGMENTMATERIALISGIXPROC) (GLenum face, GLenum pname, GLint param);
typedef void ( * PFNGLFRAGMENTMATERIALIVSGIXPROC) (GLenum face, GLenum pname, const GLint *params);
typedef void ( * PFNGLGETFRAGMENTLIGHTFVSGIXPROC) (GLenum light, GLenum pname, GLfloat *params);
typedef void ( * PFNGLGETFRAGMENTLIGHTIVSGIXPROC) (GLenum light, GLenum pname, GLint *params);
typedef void ( * PFNGLGETFRAGMENTMATERIALFVSGIXPROC) (GLenum face, GLenum pname, GLfloat *params);
typedef void ( * PFNGLGETFRAGMENTMATERIALIVSGIXPROC) (GLenum face, GLenum pname, GLint *params);
typedef void ( * PFNGLLIGHTENVISGIXPROC) (GLenum pname, GLint param);
typedef void ( * PFNGLFRAMEZOOMSGIXPROC) (GLint factor);
typedef void ( * PFNGLIGLOOINTERFACESGIXPROC) (GLenum pname, const void *params);
typedef GLint ( * PFNGLGETINSTRUMENTSSGIXPROC) (void);
typedef void ( * PFNGLINSTRUMENTSBUFFERSGIXPROC) (GLsizei size, GLint *buffer);
typedef GLint ( * PFNGLPOLLINSTRUMENTSSGIXPROC) (GLint *marker_p);
typedef void ( * PFNGLREADINSTRUMENTSSGIXPROC) (GLint marker);
typedef void ( * PFNGLSTARTINSTRUMENTSSGIXPROC) (void);
typedef void ( * PFNGLSTOPINSTRUMENTSSGIXPROC) (GLint marker);
typedef void ( * PFNGLGETLISTPARAMETERFVSGIXPROC) (GLuint list, GLenum pname, GLfloat *params);
typedef void ( * PFNGLGETLISTPARAMETERIVSGIXPROC) (GLuint list, GLenum pname, GLint *params);
typedef void ( * PFNGLLISTPARAMETERFSGIXPROC) (GLuint list, GLenum pname, GLfloat param);
typedef void ( * PFNGLLISTPARAMETERFVSGIXPROC) (GLuint list, GLenum pname, const GLfloat *params);
typedef void ( * PFNGLLISTPARAMETERISGIXPROC) (GLuint list, GLenum pname, GLint param);
typedef void ( * PFNGLLISTPARAMETERIVSGIXPROC) (GLuint list, GLenum pname, const GLint *params);
typedef void ( * PFNGLPIXELTEXGENSGIXPROC) (GLenum mode);
typedef void ( * PFNGLDEFORMATIONMAP3DSGIXPROC) (GLenum target, GLdouble u1, GLdouble u2, GLint ustride, GLint uorder, GLdouble v1, GLdouble v2, GLint vstride, GLint vorder, GLdouble w1, GLdouble w2, GLint wstride, GLint worder, const GLdouble *points);
typedef void ( * PFNGLDEFORMATIONMAP3FSGIXPROC) (GLenum target, GLfloat u1, GLfloat u2, GLint ustride, GLint uorder, GLfloat v1, GLfloat v2, GLint vstride, GLint vorder, GLfloat w1, GLfloat w2, GLint wstride, GLint worder, const GLfloat *points);
typedef void ( * PFNGLDEFORMSGIXPROC) (GLbitfield mask);
typedef void ( * PFNGLLOADIDENTITYDEFORMATIONMAPSGIXPROC) (GLbitfield mask);
typedef void ( * PFNGLREFERENCEPLANESGIXPROC) (const GLdouble *equation);
typedef void ( * PFNGLSPRITEPARAMETERFSGIXPROC) (GLenum pname, GLfloat param);
typedef void ( * PFNGLSPRITEPARAMETERFVSGIXPROC) (GLenum pname, const GLfloat *params);
typedef void ( * PFNGLSPRITEPARAMETERISGIXPROC) (GLenum pname, GLint param);
typedef void ( * PFNGLSPRITEPARAMETERIVSGIXPROC) (GLenum pname, const GLint *params);
typedef void ( * PFNGLTAGSAMPLEBUFFERSGIXPROC) (void);
typedef void ( * PFNGLCOLORTABLESGIPROC) (GLenum target, GLenum internalformat, GLsizei width, GLenum format, GLenum type, const void *table);
typedef void ( * PFNGLCOLORTABLEPARAMETERFVSGIPROC) (GLenum target, GLenum pname, const GLfloat *params);
typedef void ( * PFNGLCOLORTABLEPARAMETERIVSGIPROC) (GLenum target, GLenum pname, const GLint *params);
typedef void ( * PFNGLCOPYCOLORTABLESGIPROC) (GLenum target, GLenum internalformat, GLint x, GLint y, GLsizei width);
typedef void ( * PFNGLGETCOLORTABLESGIPROC) (GLenum target, GLenum format, GLenum type, void *table);
typedef void ( * PFNGLGETCOLORTABLEPARAMETERFVSGIPROC) (GLenum target, GLenum pname, GLfloat *params);
typedef void ( * PFNGLGETCOLORTABLEPARAMETERIVSGIPROC) (GLenum target, GLenum pname, GLint *params);
typedef void ( * PFNGLFINISHTEXTURESUNXPROC) (void);
typedef void ( * PFNGLGLOBALALPHAFACTORBSUNPROC) (GLbyte factor);
typedef void ( * PFNGLGLOBALALPHAFACTORSSUNPROC) (GLshort factor);
typedef void ( * PFNGLGLOBALALPHAFACTORISUNPROC) (GLint factor);
typedef void ( * PFNGLGLOBALALPHAFACTORFSUNPROC) (GLfloat factor);
typedef void ( * PFNGLGLOBALALPHAFACTORDSUNPROC) (GLdouble factor);
typedef void ( * PFNGLGLOBALALPHAFACTORUBSUNPROC) (GLubyte factor);
typedef void ( * PFNGLGLOBALALPHAFACTORUSSUNPROC) (GLushort factor);
typedef void ( * PFNGLGLOBALALPHAFACTORUISUNPROC) (GLuint factor);
typedef void ( * PFNGLDRAWMESHARRAYSSUNPROC) (GLenum mode, GLint first, GLsizei count, GLsizei width);
typedef void ( * PFNGLREPLACEMENTCODEUISUNPROC) (GLuint code);
typedef void ( * PFNGLREPLACEMENTCODEUSSUNPROC) (GLushort code);
typedef void ( * PFNGLREPLACEMENTCODEUBSUNPROC) (GLubyte code);
typedef void ( * PFNGLREPLACEMENTCODEUIVSUNPROC) (const GLuint *code);
typedef void ( * PFNGLREPLACEMENTCODEUSVSUNPROC) (const GLushort *code);
typedef void ( * PFNGLREPLACEMENTCODEUBVSUNPROC) (const GLubyte *code);
typedef void ( * PFNGLREPLACEMENTCODEPOINTERSUNPROC) (GLenum type, GLsizei stride, const void **pointer);
typedef void ( * PFNGLCOLOR4UBVERTEX2FSUNPROC) (GLubyte r, GLubyte g, GLubyte b, GLubyte a, GLfloat x, GLfloat y);
typedef void ( * PFNGLCOLOR4UBVERTEX2FVSUNPROC) (const GLubyte *c, const GLfloat *v);
typedef void ( * PFNGLCOLOR4UBVERTEX3FSUNPROC) (GLubyte r, GLubyte g, GLubyte b, GLubyte a, GLfloat x, GLfloat y, GLfloat z);
typedef void ( * PFNGLCOLOR4UBVERTEX3FVSUNPROC) (const GLubyte *c, const GLfloat *v);
typedef void ( * PFNGLCOLOR3FVERTEX3FSUNPROC) (GLfloat r, GLfloat g, GLfloat b, GLfloat x, GLfloat y, GLfloat z);
typedef void ( * PFNGLCOLOR3FVERTEX3FVSUNPROC) (const GLfloat *c, const GLfloat *v);
typedef void ( * PFNGLNORMAL3FVERTEX3FSUNPROC) (GLfloat nx, GLfloat ny, GLfloat nz, GLfloat x, GLfloat y, GLfloat z);
typedef void ( * PFNGLNORMAL3FVERTEX3FVSUNPROC) (const GLfloat *n, const GLfloat *v);
typedef void ( * PFNGLCOLOR4FNORMAL3FVERTEX3FSUNPROC) (GLfloat r, GLfloat g, GLfloat b, GLfloat a, GLfloat nx, GLfloat ny, GLfloat nz, GLfloat x, GLfloat y, GLfloat z);
typedef void ( * PFNGLCOLOR4FNORMAL3FVERTEX3FVSUNPROC) (const GLfloat *c, const GLfloat *n, const GLfloat *v);
typedef void ( * PFNGLTEXCOORD2FVERTEX3FSUNPROC) (GLfloat s, GLfloat t, GLfloat x, GLfloat y, GLfloat z);
typedef void ( * PFNGLTEXCOORD2FVERTEX3FVSUNPROC) (const GLfloat *tc, const GLfloat *v);
typedef void ( * PFNGLTEXCOORD4FVERTEX4FSUNPROC) (GLfloat s, GLfloat t, GLfloat p, GLfloat q, GLfloat x, GLfloat y, GLfloat z, GLfloat w);
typedef void ( * PFNGLTEXCOORD4FVERTEX4FVSUNPROC) (const GLfloat *tc, const GLfloat *v);
typedef void ( * PFNGLTEXCOORD2FCOLOR4UBVERTEX3FSUNPROC) (GLfloat s, GLfloat t, GLubyte r, GLubyte g, GLubyte b, GLubyte a, GLfloat x, GLfloat y, GLfloat z);
typedef void ( * PFNGLTEXCOORD2FCOLOR4UBVERTEX3FVSUNPROC) (const GLfloat *tc, const GLubyte *c, const GLfloat *v);
typedef void ( * PFNGLTEXCOORD2FCOLOR3FVERTEX3FSUNPROC) (GLfloat s, GLfloat t, GLfloat r, GLfloat g, GLfloat b, GLfloat x, GLfloat y, GLfloat z);
typedef void ( * PFNGLTEXCOORD2FCOLOR3FVERTEX3FVSUNPROC) (const GLfloat *tc, const GLfloat *c, const GLfloat *v);
typedef void ( * PFNGLTEXCOORD2FNORMAL3FVERTEX3FSUNPROC) (GLfloat s, GLfloat t, GLfloat nx, GLfloat ny, GLfloat nz, GLfloat x, GLfloat y, GLfloat z);
typedef void ( * PFNGLTEXCOORD2FNORMAL3FVERTEX3FVSUNPROC) (const GLfloat *tc, const GLfloat *n, const GLfloat *v);
typedef void ( * PFNGLTEXCOORD2FCOLOR4FNORMAL3FVERTEX3FSUNPROC) (GLfloat s, GLfloat t, GLfloat r, GLfloat g, GLfloat b, GLfloat a, GLfloat nx, GLfloat ny, GLfloat nz, GLfloat x, GLfloat y, GLfloat z);
typedef void ( * PFNGLTEXCOORD2FCOLOR4FNORMAL3FVERTEX3FVSUNPROC) (const GLfloat *tc, const GLfloat *c, const GLfloat *n, const GLfloat *v);
typedef void ( * PFNGLTEXCOORD4FCOLOR4FNORMAL3FVERTEX4FSUNPROC) (GLfloat s, GLfloat t, GLfloat p, GLfloat q, GLfloat r, GLfloat g, GLfloat b, GLfloat a, GLfloat nx, GLfloat ny, GLfloat nz, GLfloat x, GLfloat y, GLfloat z, GLfloat w);
typedef void ( * PFNGLTEXCOORD4FCOLOR4FNORMAL3FVERTEX4FVSUNPROC) (const GLfloat *tc, const GLfloat *c, const GLfloat *n, const GLfloat *v);
typedef void ( * PFNGLREPLACEMENTCODEUIVERTEX3FSUNPROC) (GLuint rc, GLfloat x, GLfloat y, GLfloat z);
typedef void ( * PFNGLREPLACEMENTCODEUIVERTEX3FVSUNPROC) (const GLuint *rc, const GLfloat *v);
typedef void ( * PFNGLREPLACEMENTCODEUICOLOR4UBVERTEX3FSUNPROC) (GLuint rc, GLubyte r, GLubyte g, GLubyte b, GLubyte a, GLfloat x, GLfloat y, GLfloat z);
typedef void ( * PFNGLREPLACEMENTCODEUICOLOR4UBVERTEX3FVSUNPROC) (const GLuint *rc, const GLubyte *c, const GLfloat *v);
typedef void ( * PFNGLREPLACEMENTCODEUICOLOR3FVERTEX3FSUNPROC) (GLuint rc, GLfloat r, GLfloat g, GLfloat b, GLfloat x, GLfloat y, GLfloat z);
typedef void ( * PFNGLREPLACEMENTCODEUICOLOR3FVERTEX3FVSUNPROC) (const GLuint *rc, const GLfloat *c, const GLfloat *v);
typedef void ( * PFNGLREPLACEMENTCODEUINORMAL3FVERTEX3FSUNPROC) (GLuint rc, GLfloat nx, GLfloat ny, GLfloat nz, GLfloat x, GLfloat y, GLfloat z);
typedef void ( * PFNGLREPLACEMENTCODEUINORMAL3FVERTEX3FVSUNPROC) (const GLuint *rc, const GLfloat *n, const GLfloat *v);
typedef void ( * PFNGLREPLACEMENTCODEUICOLOR4FNORMAL3FVERTEX3FSUNPROC) (GLuint rc, GLfloat r, GLfloat g, GLfloat b, GLfloat a, GLfloat nx, GLfloat ny, GLfloat nz, GLfloat x, GLfloat y, GLfloat z);
typedef void ( * PFNGLREPLACEMENTCODEUICOLOR4FNORMAL3FVERTEX3FVSUNPROC) (const GLuint *rc, const GLfloat *c, const GLfloat *n, const GLfloat *v);
typedef void ( * PFNGLREPLACEMENTCODEUITEXCOORD2FVERTEX3FSUNPROC) (GLuint rc, GLfloat s, GLfloat t, GLfloat x, GLfloat y, GLfloat z);
typedef void ( * PFNGLREPLACEMENTCODEUITEXCOORD2FVERTEX3FVSUNPROC) (const GLuint *rc, const GLfloat *tc, const GLfloat *v);
typedef void ( * PFNGLREPLACEMENTCODEUITEXCOORD2FNORMAL3FVERTEX3FSUNPROC) (GLuint rc, GLfloat s, GLfloat t, GLfloat nx, GLfloat ny, GLfloat nz, GLfloat x, GLfloat y, GLfloat z);
typedef void ( * PFNGLREPLACEMENTCODEUITEXCOORD2FNORMAL3FVERTEX3FVSUNPROC) (const GLuint *rc, const GLfloat *tc, const GLfloat *n, const GLfloat *v);
typedef void ( * PFNGLREPLACEMENTCODEUITEXCOORD2FCOLOR4FNORMAL3FVERTEX3FSUNPROC) (GLuint rc, GLfloat s, GLfloat t, GLfloat r, GLfloat g, GLfloat b, GLfloat a, GLfloat nx, GLfloat ny, GLfloat nz, GLfloat x, GLfloat y, GLfloat z);
typedef void ( * PFNGLREPLACEMENTCODEUITEXCOORD2FCOLOR4FNORMAL3FVERTEX3FVSUNPROC) (const GLuint *rc, const GLfloat *tc, const GLfloat *c, const GLfloat *n, const GLfloat *v);
/* redefining matching value: #define GL_PHONG_WIN                      0x80EA */
/* redefining matching value: #define GL_PHONG_HINT_WIN                 0x80EB */
/* redefining matching value: #define GL_FOG_SPECULAR_TEXTURE_WIN       0x80EC */
/* + END   C:/Users/Chris/include/GL/glext.h */

// wingdi.h
//PROC wglGetProcAddress(LPCSTR unnamedParam1);
typedef void (*PROC)();
PROC wglGetProcAddress(char const * unnamedParam1);
]]

-- store cdef function loading code here
-- these are all the "extern" declared functions in glext.h
-- The non-"extern" functions are up in the cdef contents.
-- Windows GLApp needs to be able to read the ffi.cdef string for parsing out wglGetProcAddress's
local defs = {
glDrawRangeElements = 'void glDrawRangeElements (GLenum mode, GLuint start, GLuint end, GLsizei count, GLenum type, const void *indices);',
glTexImage3D = 'void glTexImage3D (GLenum target, GLint level, GLint internalformat, GLsizei width, GLsizei height, GLsizei depth, GLint border, GLenum format, GLenum type, const void *pixels);',
glTexSubImage3D = 'void glTexSubImage3D (GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth, GLenum format, GLenum type, const void *pixels);',
glCopyTexSubImage3D = 'void glCopyTexSubImage3D (GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLint x, GLint y, GLsizei width, GLsizei height);',
glActiveTexture = 'void glActiveTexture (GLenum texture);',
glSampleCoverage = 'void glSampleCoverage (GLfloat value, GLboolean invert);',
glCompressedTexImage3D = 'void glCompressedTexImage3D (GLenum target, GLint level, GLenum internalformat, GLsizei width, GLsizei height, GLsizei depth, GLint border, GLsizei imageSize, const void *data);',
glCompressedTexImage2D = 'void glCompressedTexImage2D (GLenum target, GLint level, GLenum internalformat, GLsizei width, GLsizei height, GLint border, GLsizei imageSize, const void *data);',
glCompressedTexImage1D = 'void glCompressedTexImage1D (GLenum target, GLint level, GLenum internalformat, GLsizei width, GLint border, GLsizei imageSize, const void *data);',
glCompressedTexSubImage3D = 'void glCompressedTexSubImage3D (GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth, GLenum format, GLsizei imageSize, const void *data);',
glCompressedTexSubImage2D = 'void glCompressedTexSubImage2D (GLenum target, GLint level, GLint xoffset, GLint yoffset, GLsizei width, GLsizei height, GLenum format, GLsizei imageSize, const void *data);',
glCompressedTexSubImage1D = 'void glCompressedTexSubImage1D (GLenum target, GLint level, GLint xoffset, GLsizei width, GLenum format, GLsizei imageSize, const void *data);',
glGetCompressedTexImage = 'void glGetCompressedTexImage (GLenum target, GLint level, void *img);',
glClientActiveTexture = 'void glClientActiveTexture (GLenum texture);',
glMultiTexCoord1d = 'void glMultiTexCoord1d (GLenum target, GLdouble s);',
glMultiTexCoord1dv = 'void glMultiTexCoord1dv (GLenum target, const GLdouble *v);',
glMultiTexCoord1f = 'void glMultiTexCoord1f (GLenum target, GLfloat s);',
glMultiTexCoord1fv = 'void glMultiTexCoord1fv (GLenum target, const GLfloat *v);',
glMultiTexCoord1i = 'void glMultiTexCoord1i (GLenum target, GLint s);',
glMultiTexCoord1iv = 'void glMultiTexCoord1iv (GLenum target, const GLint *v);',
glMultiTexCoord1s = 'void glMultiTexCoord1s (GLenum target, GLshort s);',
glMultiTexCoord1sv = 'void glMultiTexCoord1sv (GLenum target, const GLshort *v);',
glMultiTexCoord2d = 'void glMultiTexCoord2d (GLenum target, GLdouble s, GLdouble t);',
glMultiTexCoord2dv = 'void glMultiTexCoord2dv (GLenum target, const GLdouble *v);',
glMultiTexCoord2f = 'void glMultiTexCoord2f (GLenum target, GLfloat s, GLfloat t);',
glMultiTexCoord2fv = 'void glMultiTexCoord2fv (GLenum target, const GLfloat *v);',
glMultiTexCoord2i = 'void glMultiTexCoord2i (GLenum target, GLint s, GLint t);',
glMultiTexCoord2iv = 'void glMultiTexCoord2iv (GLenum target, const GLint *v);',
glMultiTexCoord2s = 'void glMultiTexCoord2s (GLenum target, GLshort s, GLshort t);',
glMultiTexCoord2sv = 'void glMultiTexCoord2sv (GLenum target, const GLshort *v);',
glMultiTexCoord3d = 'void glMultiTexCoord3d (GLenum target, GLdouble s, GLdouble t, GLdouble r);',
glMultiTexCoord3dv = 'void glMultiTexCoord3dv (GLenum target, const GLdouble *v);',
glMultiTexCoord3f = 'void glMultiTexCoord3f (GLenum target, GLfloat s, GLfloat t, GLfloat r);',
glMultiTexCoord3fv = 'void glMultiTexCoord3fv (GLenum target, const GLfloat *v);',
glMultiTexCoord3i = 'void glMultiTexCoord3i (GLenum target, GLint s, GLint t, GLint r);',
glMultiTexCoord3iv = 'void glMultiTexCoord3iv (GLenum target, const GLint *v);',
glMultiTexCoord3s = 'void glMultiTexCoord3s (GLenum target, GLshort s, GLshort t, GLshort r);',
glMultiTexCoord3sv = 'void glMultiTexCoord3sv (GLenum target, const GLshort *v);',
glMultiTexCoord4d = 'void glMultiTexCoord4d (GLenum target, GLdouble s, GLdouble t, GLdouble r, GLdouble q);',
glMultiTexCoord4dv = 'void glMultiTexCoord4dv (GLenum target, const GLdouble *v);',
glMultiTexCoord4f = 'void glMultiTexCoord4f (GLenum target, GLfloat s, GLfloat t, GLfloat r, GLfloat q);',
glMultiTexCoord4fv = 'void glMultiTexCoord4fv (GLenum target, const GLfloat *v);',
glMultiTexCoord4i = 'void glMultiTexCoord4i (GLenum target, GLint s, GLint t, GLint r, GLint q);',
glMultiTexCoord4iv = 'void glMultiTexCoord4iv (GLenum target, const GLint *v);',
glMultiTexCoord4s = 'void glMultiTexCoord4s (GLenum target, GLshort s, GLshort t, GLshort r, GLshort q);',
glMultiTexCoord4sv = 'void glMultiTexCoord4sv (GLenum target, const GLshort *v);',
glLoadTransposeMatrixf = 'void glLoadTransposeMatrixf (const GLfloat *m);',
glLoadTransposeMatrixd = 'void glLoadTransposeMatrixd (const GLdouble *m);',
glMultTransposeMatrixf = 'void glMultTransposeMatrixf (const GLfloat *m);',
glMultTransposeMatrixd = 'void glMultTransposeMatrixd (const GLdouble *m);',
glBlendFuncSeparate = 'void glBlendFuncSeparate (GLenum sfactorRGB, GLenum dfactorRGB, GLenum sfactorAlpha, GLenum dfactorAlpha);',
glMultiDrawArrays = 'void glMultiDrawArrays (GLenum mode, const GLint *first, const GLsizei *count, GLsizei drawcount);',
glMultiDrawElements = 'void glMultiDrawElements (GLenum mode, const GLsizei *count, GLenum type, const void *const*indices, GLsizei drawcount);',
glPointParameterf = 'void glPointParameterf (GLenum pname, GLfloat param);',
glPointParameterfv = 'void glPointParameterfv (GLenum pname, const GLfloat *params);',
glPointParameteri = 'void glPointParameteri (GLenum pname, GLint param);',
glPointParameteriv = 'void glPointParameteriv (GLenum pname, const GLint *params);',
glFogCoordf = 'void glFogCoordf (GLfloat coord);',
glFogCoordfv = 'void glFogCoordfv (const GLfloat *coord);',
glFogCoordd = 'void glFogCoordd (GLdouble coord);',
glFogCoorddv = 'void glFogCoorddv (const GLdouble *coord);',
glFogCoordPointer = 'void glFogCoordPointer (GLenum type, GLsizei stride, const void *pointer);',
glSecondaryColor3b = 'void glSecondaryColor3b (GLbyte red, GLbyte green, GLbyte blue);',
glSecondaryColor3bv = 'void glSecondaryColor3bv (const GLbyte *v);',
glSecondaryColor3d = 'void glSecondaryColor3d (GLdouble red, GLdouble green, GLdouble blue);',
glSecondaryColor3dv = 'void glSecondaryColor3dv (const GLdouble *v);',
glSecondaryColor3f = 'void glSecondaryColor3f (GLfloat red, GLfloat green, GLfloat blue);',
glSecondaryColor3fv = 'void glSecondaryColor3fv (const GLfloat *v);',
glSecondaryColor3i = 'void glSecondaryColor3i (GLint red, GLint green, GLint blue);',
glSecondaryColor3iv = 'void glSecondaryColor3iv (const GLint *v);',
glSecondaryColor3s = 'void glSecondaryColor3s (GLshort red, GLshort green, GLshort blue);',
glSecondaryColor3sv = 'void glSecondaryColor3sv (const GLshort *v);',
glSecondaryColor3ub = 'void glSecondaryColor3ub (GLubyte red, GLubyte green, GLubyte blue);',
glSecondaryColor3ubv = 'void glSecondaryColor3ubv (const GLubyte *v);',
glSecondaryColor3ui = 'void glSecondaryColor3ui (GLuint red, GLuint green, GLuint blue);',
glSecondaryColor3uiv = 'void glSecondaryColor3uiv (const GLuint *v);',
glSecondaryColor3us = 'void glSecondaryColor3us (GLushort red, GLushort green, GLushort blue);',
glSecondaryColor3usv = 'void glSecondaryColor3usv (const GLushort *v);',
glSecondaryColorPointer = 'void glSecondaryColorPointer (GLint size, GLenum type, GLsizei stride, const void *pointer);',
glWindowPos2d = 'void glWindowPos2d (GLdouble x, GLdouble y);',
glWindowPos2dv = 'void glWindowPos2dv (const GLdouble *v);',
glWindowPos2f = 'void glWindowPos2f (GLfloat x, GLfloat y);',
glWindowPos2fv = 'void glWindowPos2fv (const GLfloat *v);',
glWindowPos2i = 'void glWindowPos2i (GLint x, GLint y);',
glWindowPos2iv = 'void glWindowPos2iv (const GLint *v);',
glWindowPos2s = 'void glWindowPos2s (GLshort x, GLshort y);',
glWindowPos2sv = 'void glWindowPos2sv (const GLshort *v);',
glWindowPos3d = 'void glWindowPos3d (GLdouble x, GLdouble y, GLdouble z);',
glWindowPos3dv = 'void glWindowPos3dv (const GLdouble *v);',
glWindowPos3f = 'void glWindowPos3f (GLfloat x, GLfloat y, GLfloat z);',
glWindowPos3fv = 'void glWindowPos3fv (const GLfloat *v);',
glWindowPos3i = 'void glWindowPos3i (GLint x, GLint y, GLint z);',
glWindowPos3iv = 'void glWindowPos3iv (const GLint *v);',
glWindowPos3s = 'void glWindowPos3s (GLshort x, GLshort y, GLshort z);',
glWindowPos3sv = 'void glWindowPos3sv (const GLshort *v);',
glBlendColor = 'void glBlendColor (GLfloat red, GLfloat green, GLfloat blue, GLfloat alpha);',
glBlendEquation = 'void glBlendEquation (GLenum mode);',
glGenQueries = 'void glGenQueries (GLsizei n, GLuint *ids);',
glDeleteQueries = 'void glDeleteQueries (GLsizei n, const GLuint *ids);',
glIsQuery = 'GLboolean glIsQuery (GLuint id);',
glBeginQuery = 'void glBeginQuery (GLenum target, GLuint id);',
glEndQuery = 'void glEndQuery (GLenum target);',
glGetQueryiv = 'void glGetQueryiv (GLenum target, GLenum pname, GLint *params);',
glGetQueryObjectiv = 'void glGetQueryObjectiv (GLuint id, GLenum pname, GLint *params);',
glGetQueryObjectuiv = 'void glGetQueryObjectuiv (GLuint id, GLenum pname, GLuint *params);',
glBindBuffer = 'void glBindBuffer (GLenum target, GLuint buffer);',
glDeleteBuffers = 'void glDeleteBuffers (GLsizei n, const GLuint *buffers);',
glGenBuffers = 'void glGenBuffers (GLsizei n, GLuint *buffers);',
glIsBuffer = 'GLboolean glIsBuffer (GLuint buffer);',
glBufferData = 'void glBufferData (GLenum target, GLsizeiptr size, const void *data, GLenum usage);',
glBufferSubData = 'void glBufferSubData (GLenum target, GLintptr offset, GLsizeiptr size, const void *data);',
glGetBufferSubData = 'void glGetBufferSubData (GLenum target, GLintptr offset, GLsizeiptr size, void *data);',
glMapBuffer = 'void * glMapBuffer (GLenum target, GLenum access);',
glUnmapBuffer = 'GLboolean glUnmapBuffer (GLenum target);',
glGetBufferParameteriv = 'void glGetBufferParameteriv (GLenum target, GLenum pname, GLint *params);',
glGetBufferPointerv = 'void glGetBufferPointerv (GLenum target, GLenum pname, void **params);',
glBlendEquationSeparate = 'void glBlendEquationSeparate (GLenum modeRGB, GLenum modeAlpha);',
glDrawBuffers = 'void glDrawBuffers (GLsizei n, const GLenum *bufs);',
glStencilOpSeparate = 'void glStencilOpSeparate (GLenum face, GLenum sfail, GLenum dpfail, GLenum dppass);',
glStencilFuncSeparate = 'void glStencilFuncSeparate (GLenum face, GLenum func, GLint ref, GLuint mask);',
glStencilMaskSeparate = 'void glStencilMaskSeparate (GLenum face, GLuint mask);',
glAttachShader = 'void glAttachShader (GLuint program, GLuint shader);',
glBindAttribLocation = 'void glBindAttribLocation (GLuint program, GLuint index, const GLchar *name);',
glCompileShader = 'void glCompileShader (GLuint shader);',
glCreateProgram = 'GLuint glCreateProgram (void);',
glCreateShader = 'GLuint glCreateShader (GLenum type);',
glDeleteProgram = 'void glDeleteProgram (GLuint program);',
glDeleteShader = 'void glDeleteShader (GLuint shader);',
glDetachShader = 'void glDetachShader (GLuint program, GLuint shader);',
glDisableVertexAttribArray = 'void glDisableVertexAttribArray (GLuint index);',
glEnableVertexAttribArray = 'void glEnableVertexAttribArray (GLuint index);',
glGetActiveAttrib = 'void glGetActiveAttrib (GLuint program, GLuint index, GLsizei bufSize, GLsizei *length, GLint *size, GLenum *type, GLchar *name);',
glGetActiveUniform = 'void glGetActiveUniform (GLuint program, GLuint index, GLsizei bufSize, GLsizei *length, GLint *size, GLenum *type, GLchar *name);',
glGetAttachedShaders = 'void glGetAttachedShaders (GLuint program, GLsizei maxCount, GLsizei *count, GLuint *shaders);',
glGetAttribLocation = 'GLint glGetAttribLocation (GLuint program, const GLchar *name);',
glGetProgramiv = 'void glGetProgramiv (GLuint program, GLenum pname, GLint *params);',
glGetProgramInfoLog = 'void glGetProgramInfoLog (GLuint program, GLsizei bufSize, GLsizei *length, GLchar *infoLog);',
glGetShaderiv = 'void glGetShaderiv (GLuint shader, GLenum pname, GLint *params);',
glGetShaderInfoLog = 'void glGetShaderInfoLog (GLuint shader, GLsizei bufSize, GLsizei *length, GLchar *infoLog);',
glGetShaderSource = 'void glGetShaderSource (GLuint shader, GLsizei bufSize, GLsizei *length, GLchar *source);',
glGetUniformLocation = 'GLint glGetUniformLocation (GLuint program, const GLchar *name);',
glGetUniformfv = 'void glGetUniformfv (GLuint program, GLint location, GLfloat *params);',
glGetUniformiv = 'void glGetUniformiv (GLuint program, GLint location, GLint *params);',
glGetVertexAttribdv = 'void glGetVertexAttribdv (GLuint index, GLenum pname, GLdouble *params);',
glGetVertexAttribfv = 'void glGetVertexAttribfv (GLuint index, GLenum pname, GLfloat *params);',
glGetVertexAttribiv = 'void glGetVertexAttribiv (GLuint index, GLenum pname, GLint *params);',
glGetVertexAttribPointerv = 'void glGetVertexAttribPointerv (GLuint index, GLenum pname, void **pointer);',
glIsProgram = 'GLboolean glIsProgram (GLuint program);',
glIsShader = 'GLboolean glIsShader (GLuint shader);',
glLinkProgram = 'void glLinkProgram (GLuint program);',
glShaderSource = 'void glShaderSource (GLuint shader, GLsizei count, const GLchar *const*string, const GLint *length);',
glUseProgram = 'void glUseProgram (GLuint program);',
glUniform1f = 'void glUniform1f (GLint location, GLfloat v0);',
glUniform2f = 'void glUniform2f (GLint location, GLfloat v0, GLfloat v1);',
glUniform3f = 'void glUniform3f (GLint location, GLfloat v0, GLfloat v1, GLfloat v2);',
glUniform4f = 'void glUniform4f (GLint location, GLfloat v0, GLfloat v1, GLfloat v2, GLfloat v3);',
glUniform1i = 'void glUniform1i (GLint location, GLint v0);',
glUniform2i = 'void glUniform2i (GLint location, GLint v0, GLint v1);',
glUniform3i = 'void glUniform3i (GLint location, GLint v0, GLint v1, GLint v2);',
glUniform4i = 'void glUniform4i (GLint location, GLint v0, GLint v1, GLint v2, GLint v3);',
glUniform1fv = 'void glUniform1fv (GLint location, GLsizei count, const GLfloat *value);',
glUniform2fv = 'void glUniform2fv (GLint location, GLsizei count, const GLfloat *value);',
glUniform3fv = 'void glUniform3fv (GLint location, GLsizei count, const GLfloat *value);',
glUniform4fv = 'void glUniform4fv (GLint location, GLsizei count, const GLfloat *value);',
glUniform1iv = 'void glUniform1iv (GLint location, GLsizei count, const GLint *value);',
glUniform2iv = 'void glUniform2iv (GLint location, GLsizei count, const GLint *value);',
glUniform3iv = 'void glUniform3iv (GLint location, GLsizei count, const GLint *value);',
glUniform4iv = 'void glUniform4iv (GLint location, GLsizei count, const GLint *value);',
glUniformMatrix2fv = 'void glUniformMatrix2fv (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);',
glUniformMatrix3fv = 'void glUniformMatrix3fv (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);',
glUniformMatrix4fv = 'void glUniformMatrix4fv (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);',
glValidateProgram = 'void glValidateProgram (GLuint program);',
glVertexAttrib1d = 'void glVertexAttrib1d (GLuint index, GLdouble x);',
glVertexAttrib1dv = 'void glVertexAttrib1dv (GLuint index, const GLdouble *v);',
glVertexAttrib1f = 'void glVertexAttrib1f (GLuint index, GLfloat x);',
glVertexAttrib1fv = 'void glVertexAttrib1fv (GLuint index, const GLfloat *v);',
glVertexAttrib1s = 'void glVertexAttrib1s (GLuint index, GLshort x);',
glVertexAttrib1sv = 'void glVertexAttrib1sv (GLuint index, const GLshort *v);',
glVertexAttrib2d = 'void glVertexAttrib2d (GLuint index, GLdouble x, GLdouble y);',
glVertexAttrib2dv = 'void glVertexAttrib2dv (GLuint index, const GLdouble *v);',
glVertexAttrib2f = 'void glVertexAttrib2f (GLuint index, GLfloat x, GLfloat y);',
glVertexAttrib2fv = 'void glVertexAttrib2fv (GLuint index, const GLfloat *v);',
glVertexAttrib2s = 'void glVertexAttrib2s (GLuint index, GLshort x, GLshort y);',
glVertexAttrib2sv = 'void glVertexAttrib2sv (GLuint index, const GLshort *v);',
glVertexAttrib3d = 'void glVertexAttrib3d (GLuint index, GLdouble x, GLdouble y, GLdouble z);',
glVertexAttrib3dv = 'void glVertexAttrib3dv (GLuint index, const GLdouble *v);',
glVertexAttrib3f = 'void glVertexAttrib3f (GLuint index, GLfloat x, GLfloat y, GLfloat z);',
glVertexAttrib3fv = 'void glVertexAttrib3fv (GLuint index, const GLfloat *v);',
glVertexAttrib3s = 'void glVertexAttrib3s (GLuint index, GLshort x, GLshort y, GLshort z);',
glVertexAttrib3sv = 'void glVertexAttrib3sv (GLuint index, const GLshort *v);',
glVertexAttrib4Nbv = 'void glVertexAttrib4Nbv (GLuint index, const GLbyte *v);',
glVertexAttrib4Niv = 'void glVertexAttrib4Niv (GLuint index, const GLint *v);',
glVertexAttrib4Nsv = 'void glVertexAttrib4Nsv (GLuint index, const GLshort *v);',
glVertexAttrib4Nub = 'void glVertexAttrib4Nub (GLuint index, GLubyte x, GLubyte y, GLubyte z, GLubyte w);',
glVertexAttrib4Nubv = 'void glVertexAttrib4Nubv (GLuint index, const GLubyte *v);',
glVertexAttrib4Nuiv = 'void glVertexAttrib4Nuiv (GLuint index, const GLuint *v);',
glVertexAttrib4Nusv = 'void glVertexAttrib4Nusv (GLuint index, const GLushort *v);',
glVertexAttrib4bv = 'void glVertexAttrib4bv (GLuint index, const GLbyte *v);',
glVertexAttrib4d = 'void glVertexAttrib4d (GLuint index, GLdouble x, GLdouble y, GLdouble z, GLdouble w);',
glVertexAttrib4dv = 'void glVertexAttrib4dv (GLuint index, const GLdouble *v);',
glVertexAttrib4f = 'void glVertexAttrib4f (GLuint index, GLfloat x, GLfloat y, GLfloat z, GLfloat w);',
glVertexAttrib4fv = 'void glVertexAttrib4fv (GLuint index, const GLfloat *v);',
glVertexAttrib4iv = 'void glVertexAttrib4iv (GLuint index, const GLint *v);',
glVertexAttrib4s = 'void glVertexAttrib4s (GLuint index, GLshort x, GLshort y, GLshort z, GLshort w);',
glVertexAttrib4sv = 'void glVertexAttrib4sv (GLuint index, const GLshort *v);',
glVertexAttrib4ubv = 'void glVertexAttrib4ubv (GLuint index, const GLubyte *v);',
glVertexAttrib4uiv = 'void glVertexAttrib4uiv (GLuint index, const GLuint *v);',
glVertexAttrib4usv = 'void glVertexAttrib4usv (GLuint index, const GLushort *v);',
glVertexAttribPointer = 'void glVertexAttribPointer (GLuint index, GLint size, GLenum type, GLboolean normalized, GLsizei stride, const void *pointer);',
glUniformMatrix2x3fv = 'void glUniformMatrix2x3fv (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);',
glUniformMatrix3x2fv = 'void glUniformMatrix3x2fv (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);',
glUniformMatrix2x4fv = 'void glUniformMatrix2x4fv (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);',
glUniformMatrix4x2fv = 'void glUniformMatrix4x2fv (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);',
glUniformMatrix3x4fv = 'void glUniformMatrix3x4fv (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);',
glUniformMatrix4x3fv = 'void glUniformMatrix4x3fv (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);',
glColorMaski = 'void glColorMaski (GLuint index, GLboolean r, GLboolean g, GLboolean b, GLboolean a);',
glGetBooleani_v = 'void glGetBooleani_v (GLenum target, GLuint index, GLboolean *data);',
glGetIntegeri_v = 'void glGetIntegeri_v (GLenum target, GLuint index, GLint *data);',
glEnablei = 'void glEnablei (GLenum target, GLuint index);',
glDisablei = 'void glDisablei (GLenum target, GLuint index);',
glIsEnabledi = 'GLboolean glIsEnabledi (GLenum target, GLuint index);',
glBeginTransformFeedback = 'void glBeginTransformFeedback (GLenum primitiveMode);',
glEndTransformFeedback = 'void glEndTransformFeedback (void);',
glBindBufferRange = 'void glBindBufferRange (GLenum target, GLuint index, GLuint buffer, GLintptr offset, GLsizeiptr size);',
glBindBufferBase = 'void glBindBufferBase (GLenum target, GLuint index, GLuint buffer);',
glTransformFeedbackVaryings = 'void glTransformFeedbackVaryings (GLuint program, GLsizei count, const GLchar *const*varyings, GLenum bufferMode);',
glGetTransformFeedbackVarying = 'void glGetTransformFeedbackVarying (GLuint program, GLuint index, GLsizei bufSize, GLsizei *length, GLsizei *size, GLenum *type, GLchar *name);',
glClampColor = 'void glClampColor (GLenum target, GLenum clamp);',
glBeginConditionalRender = 'void glBeginConditionalRender (GLuint id, GLenum mode);',
glEndConditionalRender = 'void glEndConditionalRender (void);',
glVertexAttribIPointer = 'void glVertexAttribIPointer (GLuint index, GLint size, GLenum type, GLsizei stride, const void *pointer);',
glGetVertexAttribIiv = 'void glGetVertexAttribIiv (GLuint index, GLenum pname, GLint *params);',
glGetVertexAttribIuiv = 'void glGetVertexAttribIuiv (GLuint index, GLenum pname, GLuint *params);',
glVertexAttribI1i = 'void glVertexAttribI1i (GLuint index, GLint x);',
glVertexAttribI2i = 'void glVertexAttribI2i (GLuint index, GLint x, GLint y);',
glVertexAttribI3i = 'void glVertexAttribI3i (GLuint index, GLint x, GLint y, GLint z);',
glVertexAttribI4i = 'void glVertexAttribI4i (GLuint index, GLint x, GLint y, GLint z, GLint w);',
glVertexAttribI1ui = 'void glVertexAttribI1ui (GLuint index, GLuint x);',
glVertexAttribI2ui = 'void glVertexAttribI2ui (GLuint index, GLuint x, GLuint y);',
glVertexAttribI3ui = 'void glVertexAttribI3ui (GLuint index, GLuint x, GLuint y, GLuint z);',
glVertexAttribI4ui = 'void glVertexAttribI4ui (GLuint index, GLuint x, GLuint y, GLuint z, GLuint w);',
glVertexAttribI1iv = 'void glVertexAttribI1iv (GLuint index, const GLint *v);',
glVertexAttribI2iv = 'void glVertexAttribI2iv (GLuint index, const GLint *v);',
glVertexAttribI3iv = 'void glVertexAttribI3iv (GLuint index, const GLint *v);',
glVertexAttribI4iv = 'void glVertexAttribI4iv (GLuint index, const GLint *v);',
glVertexAttribI1uiv = 'void glVertexAttribI1uiv (GLuint index, const GLuint *v);',
glVertexAttribI2uiv = 'void glVertexAttribI2uiv (GLuint index, const GLuint *v);',
glVertexAttribI3uiv = 'void glVertexAttribI3uiv (GLuint index, const GLuint *v);',
glVertexAttribI4uiv = 'void glVertexAttribI4uiv (GLuint index, const GLuint *v);',
glVertexAttribI4bv = 'void glVertexAttribI4bv (GLuint index, const GLbyte *v);',
glVertexAttribI4sv = 'void glVertexAttribI4sv (GLuint index, const GLshort *v);',
glVertexAttribI4ubv = 'void glVertexAttribI4ubv (GLuint index, const GLubyte *v);',
glVertexAttribI4usv = 'void glVertexAttribI4usv (GLuint index, const GLushort *v);',
glGetUniformuiv = 'void glGetUniformuiv (GLuint program, GLint location, GLuint *params);',
glBindFragDataLocation = 'void glBindFragDataLocation (GLuint program, GLuint color, const GLchar *name);',
glGetFragDataLocation = 'GLint glGetFragDataLocation (GLuint program, const GLchar *name);',
glUniform1ui = 'void glUniform1ui (GLint location, GLuint v0);',
glUniform2ui = 'void glUniform2ui (GLint location, GLuint v0, GLuint v1);',
glUniform3ui = 'void glUniform3ui (GLint location, GLuint v0, GLuint v1, GLuint v2);',
glUniform4ui = 'void glUniform4ui (GLint location, GLuint v0, GLuint v1, GLuint v2, GLuint v3);',
glUniform1uiv = 'void glUniform1uiv (GLint location, GLsizei count, const GLuint *value);',
glUniform2uiv = 'void glUniform2uiv (GLint location, GLsizei count, const GLuint *value);',
glUniform3uiv = 'void glUniform3uiv (GLint location, GLsizei count, const GLuint *value);',
glUniform4uiv = 'void glUniform4uiv (GLint location, GLsizei count, const GLuint *value);',
glTexParameterIiv = 'void glTexParameterIiv (GLenum target, GLenum pname, const GLint *params);',
glTexParameterIuiv = 'void glTexParameterIuiv (GLenum target, GLenum pname, const GLuint *params);',
glGetTexParameterIiv = 'void glGetTexParameterIiv (GLenum target, GLenum pname, GLint *params);',
glGetTexParameterIuiv = 'void glGetTexParameterIuiv (GLenum target, GLenum pname, GLuint *params);',
glClearBufferiv = 'void glClearBufferiv (GLenum buffer, GLint drawbuffer, const GLint *value);',
glClearBufferuiv = 'void glClearBufferuiv (GLenum buffer, GLint drawbuffer, const GLuint *value);',
glClearBufferfv = 'void glClearBufferfv (GLenum buffer, GLint drawbuffer, const GLfloat *value);',
glClearBufferfi = 'void glClearBufferfi (GLenum buffer, GLint drawbuffer, GLfloat depth, GLint stencil);',
glGetStringi = 'const GLubyte * glGetStringi (GLenum name, GLuint index);',
glIsRenderbuffer = 'GLboolean glIsRenderbuffer (GLuint renderbuffer);',
glBindRenderbuffer = 'void glBindRenderbuffer (GLenum target, GLuint renderbuffer);',
glDeleteRenderbuffers = 'void glDeleteRenderbuffers (GLsizei n, const GLuint *renderbuffers);',
glGenRenderbuffers = 'void glGenRenderbuffers (GLsizei n, GLuint *renderbuffers);',
glRenderbufferStorage = 'void glRenderbufferStorage (GLenum target, GLenum internalformat, GLsizei width, GLsizei height);',
glGetRenderbufferParameteriv = 'void glGetRenderbufferParameteriv (GLenum target, GLenum pname, GLint *params);',
glIsFramebuffer = 'GLboolean glIsFramebuffer (GLuint framebuffer);',
glBindFramebuffer = 'void glBindFramebuffer (GLenum target, GLuint framebuffer);',
glDeleteFramebuffers = 'void glDeleteFramebuffers (GLsizei n, const GLuint *framebuffers);',
glGenFramebuffers = 'void glGenFramebuffers (GLsizei n, GLuint *framebuffers);',
glCheckFramebufferStatus = 'GLenum glCheckFramebufferStatus (GLenum target);',
glFramebufferTexture1D = 'void glFramebufferTexture1D (GLenum target, GLenum attachment, GLenum textarget, GLuint texture, GLint level);',
glFramebufferTexture2D = 'void glFramebufferTexture2D (GLenum target, GLenum attachment, GLenum textarget, GLuint texture, GLint level);',
glFramebufferTexture3D = 'void glFramebufferTexture3D (GLenum target, GLenum attachment, GLenum textarget, GLuint texture, GLint level, GLint zoffset);',
glFramebufferRenderbuffer = 'void glFramebufferRenderbuffer (GLenum target, GLenum attachment, GLenum renderbuffertarget, GLuint renderbuffer);',
glGetFramebufferAttachmentParameteriv = 'void glGetFramebufferAttachmentParameteriv (GLenum target, GLenum attachment, GLenum pname, GLint *params);',
glGenerateMipmap = 'void glGenerateMipmap (GLenum target);',
glBlitFramebuffer = 'void glBlitFramebuffer (GLint srcX0, GLint srcY0, GLint srcX1, GLint srcY1, GLint dstX0, GLint dstY0, GLint dstX1, GLint dstY1, GLbitfield mask, GLenum filter);',
glRenderbufferStorageMultisample = 'void glRenderbufferStorageMultisample (GLenum target, GLsizei samples, GLenum internalformat, GLsizei width, GLsizei height);',
glFramebufferTextureLayer = 'void glFramebufferTextureLayer (GLenum target, GLenum attachment, GLuint texture, GLint level, GLint layer);',
glMapBufferRange = 'void * glMapBufferRange (GLenum target, GLintptr offset, GLsizeiptr length, GLbitfield access);',
glFlushMappedBufferRange = 'void glFlushMappedBufferRange (GLenum target, GLintptr offset, GLsizeiptr length);',
glBindVertexArray = 'void glBindVertexArray (GLuint array);',
glDeleteVertexArrays = 'void glDeleteVertexArrays (GLsizei n, const GLuint *arrays);',
glGenVertexArrays = 'void glGenVertexArrays (GLsizei n, GLuint *arrays);',
glIsVertexArray = 'GLboolean glIsVertexArray (GLuint array);',
glDrawArraysInstanced = 'void glDrawArraysInstanced (GLenum mode, GLint first, GLsizei count, GLsizei instancecount);',
glDrawElementsInstanced = 'void glDrawElementsInstanced (GLenum mode, GLsizei count, GLenum type, const void *indices, GLsizei instancecount);',
glTexBuffer = 'void glTexBuffer (GLenum target, GLenum internalformat, GLuint buffer);',
glPrimitiveRestartIndex = 'void glPrimitiveRestartIndex (GLuint index);',
glCopyBufferSubData = 'void glCopyBufferSubData (GLenum readTarget, GLenum writeTarget, GLintptr readOffset, GLintptr writeOffset, GLsizeiptr size);',
glGetUniformIndices = 'void glGetUniformIndices (GLuint program, GLsizei uniformCount, const GLchar *const*uniformNames, GLuint *uniformIndices);',
glGetActiveUniformsiv = 'void glGetActiveUniformsiv (GLuint program, GLsizei uniformCount, const GLuint *uniformIndices, GLenum pname, GLint *params);',
glGetActiveUniformName = 'void glGetActiveUniformName (GLuint program, GLuint uniformIndex, GLsizei bufSize, GLsizei *length, GLchar *uniformName);',
glGetUniformBlockIndex = 'GLuint glGetUniformBlockIndex (GLuint program, const GLchar *uniformBlockName);',
glGetActiveUniformBlockiv = 'void glGetActiveUniformBlockiv (GLuint program, GLuint uniformBlockIndex, GLenum pname, GLint *params);',
glGetActiveUniformBlockName = 'void glGetActiveUniformBlockName (GLuint program, GLuint uniformBlockIndex, GLsizei bufSize, GLsizei *length, GLchar *uniformBlockName);',
glUniformBlockBinding = 'void glUniformBlockBinding (GLuint program, GLuint uniformBlockIndex, GLuint uniformBlockBinding);',
glDrawElementsBaseVertex = 'void glDrawElementsBaseVertex (GLenum mode, GLsizei count, GLenum type, const void *indices, GLint basevertex);',
glDrawRangeElementsBaseVertex = 'void glDrawRangeElementsBaseVertex (GLenum mode, GLuint start, GLuint end, GLsizei count, GLenum type, const void *indices, GLint basevertex);',
glDrawElementsInstancedBaseVertex = 'void glDrawElementsInstancedBaseVertex (GLenum mode, GLsizei count, GLenum type, const void *indices, GLsizei instancecount, GLint basevertex);',
glMultiDrawElementsBaseVertex = 'void glMultiDrawElementsBaseVertex (GLenum mode, const GLsizei *count, GLenum type, const void *const*indices, GLsizei drawcount, const GLint *basevertex);',
glProvokingVertex = 'void glProvokingVertex (GLenum mode);',
glFenceSync = 'GLsync glFenceSync (GLenum condition, GLbitfield flags);',
glIsSync = 'GLboolean glIsSync (GLsync sync);',
glDeleteSync = 'void glDeleteSync (GLsync sync);',
glClientWaitSync = 'GLenum glClientWaitSync (GLsync sync, GLbitfield flags, GLuint64 timeout);',
glWaitSync = 'void glWaitSync (GLsync sync, GLbitfield flags, GLuint64 timeout);',
glGetInteger64v = 'void glGetInteger64v (GLenum pname, GLint64 *data);',
glGetSynciv = 'void glGetSynciv (GLsync sync, GLenum pname, GLsizei count, GLsizei *length, GLint *values);',
glGetInteger64i_v = 'void glGetInteger64i_v (GLenum target, GLuint index, GLint64 *data);',
glGetBufferParameteri64v = 'void glGetBufferParameteri64v (GLenum target, GLenum pname, GLint64 *params);',
glFramebufferTexture = 'void glFramebufferTexture (GLenum target, GLenum attachment, GLuint texture, GLint level);',
glTexImage2DMultisample = 'void glTexImage2DMultisample (GLenum target, GLsizei samples, GLenum internalformat, GLsizei width, GLsizei height, GLboolean fixedsamplelocations);',
glTexImage3DMultisample = 'void glTexImage3DMultisample (GLenum target, GLsizei samples, GLenum internalformat, GLsizei width, GLsizei height, GLsizei depth, GLboolean fixedsamplelocations);',
glGetMultisamplefv = 'void glGetMultisamplefv (GLenum pname, GLuint index, GLfloat *val);',
glSampleMaski = 'void glSampleMaski (GLuint maskNumber, GLbitfield mask);',
glBindFragDataLocationIndexed = 'void glBindFragDataLocationIndexed (GLuint program, GLuint colorNumber, GLuint index, const GLchar *name);',
glGetFragDataIndex = 'GLint glGetFragDataIndex (GLuint program, const GLchar *name);',
glGenSamplers = 'void glGenSamplers (GLsizei count, GLuint *samplers);',
glDeleteSamplers = 'void glDeleteSamplers (GLsizei count, const GLuint *samplers);',
glIsSampler = 'GLboolean glIsSampler (GLuint sampler);',
glBindSampler = 'void glBindSampler (GLuint unit, GLuint sampler);',
glSamplerParameteri = 'void glSamplerParameteri (GLuint sampler, GLenum pname, GLint param);',
glSamplerParameteriv = 'void glSamplerParameteriv (GLuint sampler, GLenum pname, const GLint *param);',
glSamplerParameterf = 'void glSamplerParameterf (GLuint sampler, GLenum pname, GLfloat param);',
glSamplerParameterfv = 'void glSamplerParameterfv (GLuint sampler, GLenum pname, const GLfloat *param);',
glSamplerParameterIiv = 'void glSamplerParameterIiv (GLuint sampler, GLenum pname, const GLint *param);',
glSamplerParameterIuiv = 'void glSamplerParameterIuiv (GLuint sampler, GLenum pname, const GLuint *param);',
glGetSamplerParameteriv = 'void glGetSamplerParameteriv (GLuint sampler, GLenum pname, GLint *params);',
glGetSamplerParameterIiv = 'void glGetSamplerParameterIiv (GLuint sampler, GLenum pname, GLint *params);',
glGetSamplerParameterfv = 'void glGetSamplerParameterfv (GLuint sampler, GLenum pname, GLfloat *params);',
glGetSamplerParameterIuiv = 'void glGetSamplerParameterIuiv (GLuint sampler, GLenum pname, GLuint *params);',
glQueryCounter = 'void glQueryCounter (GLuint id, GLenum target);',
glGetQueryObjecti64v = 'void glGetQueryObjecti64v (GLuint id, GLenum pname, GLint64 *params);',
glGetQueryObjectui64v = 'void glGetQueryObjectui64v (GLuint id, GLenum pname, GLuint64 *params);',
glVertexAttribDivisor = 'void glVertexAttribDivisor (GLuint index, GLuint divisor);',
glVertexAttribP1ui = 'void glVertexAttribP1ui (GLuint index, GLenum type, GLboolean normalized, GLuint value);',
glVertexAttribP1uiv = 'void glVertexAttribP1uiv (GLuint index, GLenum type, GLboolean normalized, const GLuint *value);',
glVertexAttribP2ui = 'void glVertexAttribP2ui (GLuint index, GLenum type, GLboolean normalized, GLuint value);',
glVertexAttribP2uiv = 'void glVertexAttribP2uiv (GLuint index, GLenum type, GLboolean normalized, const GLuint *value);',
glVertexAttribP3ui = 'void glVertexAttribP3ui (GLuint index, GLenum type, GLboolean normalized, GLuint value);',
glVertexAttribP3uiv = 'void glVertexAttribP3uiv (GLuint index, GLenum type, GLboolean normalized, const GLuint *value);',
glVertexAttribP4ui = 'void glVertexAttribP4ui (GLuint index, GLenum type, GLboolean normalized, GLuint value);',
glVertexAttribP4uiv = 'void glVertexAttribP4uiv (GLuint index, GLenum type, GLboolean normalized, const GLuint *value);',
glVertexP2ui = 'void glVertexP2ui (GLenum type, GLuint value);',
glVertexP2uiv = 'void glVertexP2uiv (GLenum type, const GLuint *value);',
glVertexP3ui = 'void glVertexP3ui (GLenum type, GLuint value);',
glVertexP3uiv = 'void glVertexP3uiv (GLenum type, const GLuint *value);',
glVertexP4ui = 'void glVertexP4ui (GLenum type, GLuint value);',
glVertexP4uiv = 'void glVertexP4uiv (GLenum type, const GLuint *value);',
glTexCoordP1ui = 'void glTexCoordP1ui (GLenum type, GLuint coords);',
glTexCoordP1uiv = 'void glTexCoordP1uiv (GLenum type, const GLuint *coords);',
glTexCoordP2ui = 'void glTexCoordP2ui (GLenum type, GLuint coords);',
glTexCoordP2uiv = 'void glTexCoordP2uiv (GLenum type, const GLuint *coords);',
glTexCoordP3ui = 'void glTexCoordP3ui (GLenum type, GLuint coords);',
glTexCoordP3uiv = 'void glTexCoordP3uiv (GLenum type, const GLuint *coords);',
glTexCoordP4ui = 'void glTexCoordP4ui (GLenum type, GLuint coords);',
glTexCoordP4uiv = 'void glTexCoordP4uiv (GLenum type, const GLuint *coords);',
glMultiTexCoordP1ui = 'void glMultiTexCoordP1ui (GLenum texture, GLenum type, GLuint coords);',
glMultiTexCoordP1uiv = 'void glMultiTexCoordP1uiv (GLenum texture, GLenum type, const GLuint *coords);',
glMultiTexCoordP2ui = 'void glMultiTexCoordP2ui (GLenum texture, GLenum type, GLuint coords);',
glMultiTexCoordP2uiv = 'void glMultiTexCoordP2uiv (GLenum texture, GLenum type, const GLuint *coords);',
glMultiTexCoordP3ui = 'void glMultiTexCoordP3ui (GLenum texture, GLenum type, GLuint coords);',
glMultiTexCoordP3uiv = 'void glMultiTexCoordP3uiv (GLenum texture, GLenum type, const GLuint *coords);',
glMultiTexCoordP4ui = 'void glMultiTexCoordP4ui (GLenum texture, GLenum type, GLuint coords);',
glMultiTexCoordP4uiv = 'void glMultiTexCoordP4uiv (GLenum texture, GLenum type, const GLuint *coords);',
glNormalP3ui = 'void glNormalP3ui (GLenum type, GLuint coords);',
glNormalP3uiv = 'void glNormalP3uiv (GLenum type, const GLuint *coords);',
glColorP3ui = 'void glColorP3ui (GLenum type, GLuint color);',
glColorP3uiv = 'void glColorP3uiv (GLenum type, const GLuint *color);',
glColorP4ui = 'void glColorP4ui (GLenum type, GLuint color);',
glColorP4uiv = 'void glColorP4uiv (GLenum type, const GLuint *color);',
glSecondaryColorP3ui = 'void glSecondaryColorP3ui (GLenum type, GLuint color);',
glSecondaryColorP3uiv = 'void glSecondaryColorP3uiv (GLenum type, const GLuint *color);',
glMinSampleShading = 'void glMinSampleShading (GLfloat value);',
glBlendEquationi = 'void glBlendEquationi (GLuint buf, GLenum mode);',
glBlendEquationSeparatei = 'void glBlendEquationSeparatei (GLuint buf, GLenum modeRGB, GLenum modeAlpha);',
glBlendFunci = 'void glBlendFunci (GLuint buf, GLenum src, GLenum dst);',
glBlendFuncSeparatei = 'void glBlendFuncSeparatei (GLuint buf, GLenum srcRGB, GLenum dstRGB, GLenum srcAlpha, GLenum dstAlpha);',
glDrawArraysIndirect = 'void glDrawArraysIndirect (GLenum mode, const void *indirect);',
glDrawElementsIndirect = 'void glDrawElementsIndirect (GLenum mode, GLenum type, const void *indirect);',
glUniform1d = 'void glUniform1d (GLint location, GLdouble x);',
glUniform2d = 'void glUniform2d (GLint location, GLdouble x, GLdouble y);',
glUniform3d = 'void glUniform3d (GLint location, GLdouble x, GLdouble y, GLdouble z);',
glUniform4d = 'void glUniform4d (GLint location, GLdouble x, GLdouble y, GLdouble z, GLdouble w);',
glUniform1dv = 'void glUniform1dv (GLint location, GLsizei count, const GLdouble *value);',
glUniform2dv = 'void glUniform2dv (GLint location, GLsizei count, const GLdouble *value);',
glUniform3dv = 'void glUniform3dv (GLint location, GLsizei count, const GLdouble *value);',
glUniform4dv = 'void glUniform4dv (GLint location, GLsizei count, const GLdouble *value);',
glUniformMatrix2dv = 'void glUniformMatrix2dv (GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);',
glUniformMatrix3dv = 'void glUniformMatrix3dv (GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);',
glUniformMatrix4dv = 'void glUniformMatrix4dv (GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);',
glUniformMatrix2x3dv = 'void glUniformMatrix2x3dv (GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);',
glUniformMatrix2x4dv = 'void glUniformMatrix2x4dv (GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);',
glUniformMatrix3x2dv = 'void glUniformMatrix3x2dv (GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);',
glUniformMatrix3x4dv = 'void glUniformMatrix3x4dv (GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);',
glUniformMatrix4x2dv = 'void glUniformMatrix4x2dv (GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);',
glUniformMatrix4x3dv = 'void glUniformMatrix4x3dv (GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);',
glGetUniformdv = 'void glGetUniformdv (GLuint program, GLint location, GLdouble *params);',
glGetSubroutineUniformLocation = 'GLint glGetSubroutineUniformLocation (GLuint program, GLenum shadertype, const GLchar *name);',
glGetSubroutineIndex = 'GLuint glGetSubroutineIndex (GLuint program, GLenum shadertype, const GLchar *name);',
glGetActiveSubroutineUniformiv = 'void glGetActiveSubroutineUniformiv (GLuint program, GLenum shadertype, GLuint index, GLenum pname, GLint *values);',
glGetActiveSubroutineUniformName = 'void glGetActiveSubroutineUniformName (GLuint program, GLenum shadertype, GLuint index, GLsizei bufSize, GLsizei *length, GLchar *name);',
glGetActiveSubroutineName = 'void glGetActiveSubroutineName (GLuint program, GLenum shadertype, GLuint index, GLsizei bufSize, GLsizei *length, GLchar *name);',
glUniformSubroutinesuiv = 'void glUniformSubroutinesuiv (GLenum shadertype, GLsizei count, const GLuint *indices);',
glGetUniformSubroutineuiv = 'void glGetUniformSubroutineuiv (GLenum shadertype, GLint location, GLuint *params);',
glGetProgramStageiv = 'void glGetProgramStageiv (GLuint program, GLenum shadertype, GLenum pname, GLint *values);',
glPatchParameteri = 'void glPatchParameteri (GLenum pname, GLint value);',
glPatchParameterfv = 'void glPatchParameterfv (GLenum pname, const GLfloat *values);',
glBindTransformFeedback = 'void glBindTransformFeedback (GLenum target, GLuint id);',
glDeleteTransformFeedbacks = 'void glDeleteTransformFeedbacks (GLsizei n, const GLuint *ids);',
glGenTransformFeedbacks = 'void glGenTransformFeedbacks (GLsizei n, GLuint *ids);',
glIsTransformFeedback = 'GLboolean glIsTransformFeedback (GLuint id);',
glPauseTransformFeedback = 'void glPauseTransformFeedback (void);',
glResumeTransformFeedback = 'void glResumeTransformFeedback (void);',
glDrawTransformFeedback = 'void glDrawTransformFeedback (GLenum mode, GLuint id);',
glDrawTransformFeedbackStream = 'void glDrawTransformFeedbackStream (GLenum mode, GLuint id, GLuint stream);',
glBeginQueryIndexed = 'void glBeginQueryIndexed (GLenum target, GLuint index, GLuint id);',
glEndQueryIndexed = 'void glEndQueryIndexed (GLenum target, GLuint index);',
glGetQueryIndexediv = 'void glGetQueryIndexediv (GLenum target, GLuint index, GLenum pname, GLint *params);',
glReleaseShaderCompiler = 'void glReleaseShaderCompiler (void);',
glShaderBinary = 'void glShaderBinary (GLsizei count, const GLuint *shaders, GLenum binaryFormat, const void *binary, GLsizei length);',
glGetShaderPrecisionFormat = 'void glGetShaderPrecisionFormat (GLenum shadertype, GLenum precisiontype, GLint *range, GLint *precision);',
glDepthRangef = 'void glDepthRangef (GLfloat n, GLfloat f);',
glClearDepthf = 'void glClearDepthf (GLfloat d);',
glGetProgramBinary = 'void glGetProgramBinary (GLuint program, GLsizei bufSize, GLsizei *length, GLenum *binaryFormat, void *binary);',
glProgramBinary = 'void glProgramBinary (GLuint program, GLenum binaryFormat, const void *binary, GLsizei length);',
glProgramParameteri = 'void glProgramParameteri (GLuint program, GLenum pname, GLint value);',
glUseProgramStages = 'void glUseProgramStages (GLuint pipeline, GLbitfield stages, GLuint program);',
glActiveShaderProgram = 'void glActiveShaderProgram (GLuint pipeline, GLuint program);',
glCreateShaderProgramv = 'GLuint glCreateShaderProgramv (GLenum type, GLsizei count, const GLchar *const*strings);',
glBindProgramPipeline = 'void glBindProgramPipeline (GLuint pipeline);',
glDeleteProgramPipelines = 'void glDeleteProgramPipelines (GLsizei n, const GLuint *pipelines);',
glGenProgramPipelines = 'void glGenProgramPipelines (GLsizei n, GLuint *pipelines);',
glIsProgramPipeline = 'GLboolean glIsProgramPipeline (GLuint pipeline);',
glGetProgramPipelineiv = 'void glGetProgramPipelineiv (GLuint pipeline, GLenum pname, GLint *params);',
glProgramUniform1i = 'void glProgramUniform1i (GLuint program, GLint location, GLint v0);',
glProgramUniform1iv = 'void glProgramUniform1iv (GLuint program, GLint location, GLsizei count, const GLint *value);',
glProgramUniform1f = 'void glProgramUniform1f (GLuint program, GLint location, GLfloat v0);',
glProgramUniform1fv = 'void glProgramUniform1fv (GLuint program, GLint location, GLsizei count, const GLfloat *value);',
glProgramUniform1d = 'void glProgramUniform1d (GLuint program, GLint location, GLdouble v0);',
glProgramUniform1dv = 'void glProgramUniform1dv (GLuint program, GLint location, GLsizei count, const GLdouble *value);',
glProgramUniform1ui = 'void glProgramUniform1ui (GLuint program, GLint location, GLuint v0);',
glProgramUniform1uiv = 'void glProgramUniform1uiv (GLuint program, GLint location, GLsizei count, const GLuint *value);',
glProgramUniform2i = 'void glProgramUniform2i (GLuint program, GLint location, GLint v0, GLint v1);',
glProgramUniform2iv = 'void glProgramUniform2iv (GLuint program, GLint location, GLsizei count, const GLint *value);',
glProgramUniform2f = 'void glProgramUniform2f (GLuint program, GLint location, GLfloat v0, GLfloat v1);',
glProgramUniform2fv = 'void glProgramUniform2fv (GLuint program, GLint location, GLsizei count, const GLfloat *value);',
glProgramUniform2d = 'void glProgramUniform2d (GLuint program, GLint location, GLdouble v0, GLdouble v1);',
glProgramUniform2dv = 'void glProgramUniform2dv (GLuint program, GLint location, GLsizei count, const GLdouble *value);',
glProgramUniform2ui = 'void glProgramUniform2ui (GLuint program, GLint location, GLuint v0, GLuint v1);',
glProgramUniform2uiv = 'void glProgramUniform2uiv (GLuint program, GLint location, GLsizei count, const GLuint *value);',
glProgramUniform3i = 'void glProgramUniform3i (GLuint program, GLint location, GLint v0, GLint v1, GLint v2);',
glProgramUniform3iv = 'void glProgramUniform3iv (GLuint program, GLint location, GLsizei count, const GLint *value);',
glProgramUniform3f = 'void glProgramUniform3f (GLuint program, GLint location, GLfloat v0, GLfloat v1, GLfloat v2);',
glProgramUniform3fv = 'void glProgramUniform3fv (GLuint program, GLint location, GLsizei count, const GLfloat *value);',
glProgramUniform3d = 'void glProgramUniform3d (GLuint program, GLint location, GLdouble v0, GLdouble v1, GLdouble v2);',
glProgramUniform3dv = 'void glProgramUniform3dv (GLuint program, GLint location, GLsizei count, const GLdouble *value);',
glProgramUniform3ui = 'void glProgramUniform3ui (GLuint program, GLint location, GLuint v0, GLuint v1, GLuint v2);',
glProgramUniform3uiv = 'void glProgramUniform3uiv (GLuint program, GLint location, GLsizei count, const GLuint *value);',
glProgramUniform4i = 'void glProgramUniform4i (GLuint program, GLint location, GLint v0, GLint v1, GLint v2, GLint v3);',
glProgramUniform4iv = 'void glProgramUniform4iv (GLuint program, GLint location, GLsizei count, const GLint *value);',
glProgramUniform4f = 'void glProgramUniform4f (GLuint program, GLint location, GLfloat v0, GLfloat v1, GLfloat v2, GLfloat v3);',
glProgramUniform4fv = 'void glProgramUniform4fv (GLuint program, GLint location, GLsizei count, const GLfloat *value);',
glProgramUniform4d = 'void glProgramUniform4d (GLuint program, GLint location, GLdouble v0, GLdouble v1, GLdouble v2, GLdouble v3);',
glProgramUniform4dv = 'void glProgramUniform4dv (GLuint program, GLint location, GLsizei count, const GLdouble *value);',
glProgramUniform4ui = 'void glProgramUniform4ui (GLuint program, GLint location, GLuint v0, GLuint v1, GLuint v2, GLuint v3);',
glProgramUniform4uiv = 'void glProgramUniform4uiv (GLuint program, GLint location, GLsizei count, const GLuint *value);',
glProgramUniformMatrix2fv = 'void glProgramUniformMatrix2fv (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);',
glProgramUniformMatrix3fv = 'void glProgramUniformMatrix3fv (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);',
glProgramUniformMatrix4fv = 'void glProgramUniformMatrix4fv (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);',
glProgramUniformMatrix2dv = 'void glProgramUniformMatrix2dv (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);',
glProgramUniformMatrix3dv = 'void glProgramUniformMatrix3dv (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);',
glProgramUniformMatrix4dv = 'void glProgramUniformMatrix4dv (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);',
glProgramUniformMatrix2x3fv = 'void glProgramUniformMatrix2x3fv (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);',
glProgramUniformMatrix3x2fv = 'void glProgramUniformMatrix3x2fv (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);',
glProgramUniformMatrix2x4fv = 'void glProgramUniformMatrix2x4fv (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);',
glProgramUniformMatrix4x2fv = 'void glProgramUniformMatrix4x2fv (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);',
glProgramUniformMatrix3x4fv = 'void glProgramUniformMatrix3x4fv (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);',
glProgramUniformMatrix4x3fv = 'void glProgramUniformMatrix4x3fv (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);',
glProgramUniformMatrix2x3dv = 'void glProgramUniformMatrix2x3dv (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);',
glProgramUniformMatrix3x2dv = 'void glProgramUniformMatrix3x2dv (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);',
glProgramUniformMatrix2x4dv = 'void glProgramUniformMatrix2x4dv (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);',
glProgramUniformMatrix4x2dv = 'void glProgramUniformMatrix4x2dv (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);',
glProgramUniformMatrix3x4dv = 'void glProgramUniformMatrix3x4dv (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);',
glProgramUniformMatrix4x3dv = 'void glProgramUniformMatrix4x3dv (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);',
glValidateProgramPipeline = 'void glValidateProgramPipeline (GLuint pipeline);',
glGetProgramPipelineInfoLog = 'void glGetProgramPipelineInfoLog (GLuint pipeline, GLsizei bufSize, GLsizei *length, GLchar *infoLog);',
glVertexAttribL1d = 'void glVertexAttribL1d (GLuint index, GLdouble x);',
glVertexAttribL2d = 'void glVertexAttribL2d (GLuint index, GLdouble x, GLdouble y);',
glVertexAttribL3d = 'void glVertexAttribL3d (GLuint index, GLdouble x, GLdouble y, GLdouble z);',
glVertexAttribL4d = 'void glVertexAttribL4d (GLuint index, GLdouble x, GLdouble y, GLdouble z, GLdouble w);',
glVertexAttribL1dv = 'void glVertexAttribL1dv (GLuint index, const GLdouble *v);',
glVertexAttribL2dv = 'void glVertexAttribL2dv (GLuint index, const GLdouble *v);',
glVertexAttribL3dv = 'void glVertexAttribL3dv (GLuint index, const GLdouble *v);',
glVertexAttribL4dv = 'void glVertexAttribL4dv (GLuint index, const GLdouble *v);',
glVertexAttribLPointer = 'void glVertexAttribLPointer (GLuint index, GLint size, GLenum type, GLsizei stride, const void *pointer);',
glGetVertexAttribLdv = 'void glGetVertexAttribLdv (GLuint index, GLenum pname, GLdouble *params);',
glViewportArrayv = 'void glViewportArrayv (GLuint first, GLsizei count, const GLfloat *v);',
glViewportIndexedf = 'void glViewportIndexedf (GLuint index, GLfloat x, GLfloat y, GLfloat w, GLfloat h);',
glViewportIndexedfv = 'void glViewportIndexedfv (GLuint index, const GLfloat *v);',
glScissorArrayv = 'void glScissorArrayv (GLuint first, GLsizei count, const GLint *v);',
glScissorIndexed = 'void glScissorIndexed (GLuint index, GLint left, GLint bottom, GLsizei width, GLsizei height);',
glScissorIndexedv = 'void glScissorIndexedv (GLuint index, const GLint *v);',
glDepthRangeArrayv = 'void glDepthRangeArrayv (GLuint first, GLsizei count, const GLdouble *v);',
glDepthRangeIndexed = 'void glDepthRangeIndexed (GLuint index, GLdouble n, GLdouble f);',
glGetFloati_v = 'void glGetFloati_v (GLenum target, GLuint index, GLfloat *data);',
glGetDoublei_v = 'void glGetDoublei_v (GLenum target, GLuint index, GLdouble *data);',
glDrawArraysInstancedBaseInstance = 'void glDrawArraysInstancedBaseInstance (GLenum mode, GLint first, GLsizei count, GLsizei instancecount, GLuint baseinstance);',
glDrawElementsInstancedBaseInstance = 'void glDrawElementsInstancedBaseInstance (GLenum mode, GLsizei count, GLenum type, const void *indices, GLsizei instancecount, GLuint baseinstance);',
glDrawElementsInstancedBaseVertexBaseInstance = 'void glDrawElementsInstancedBaseVertexBaseInstance (GLenum mode, GLsizei count, GLenum type, const void *indices, GLsizei instancecount, GLint basevertex, GLuint baseinstance);',
glGetInternalformativ = 'void glGetInternalformativ (GLenum target, GLenum internalformat, GLenum pname, GLsizei count, GLint *params);',
glGetActiveAtomicCounterBufferiv = 'void glGetActiveAtomicCounterBufferiv (GLuint program, GLuint bufferIndex, GLenum pname, GLint *params);',
glBindImageTexture = 'void glBindImageTexture (GLuint unit, GLuint texture, GLint level, GLboolean layered, GLint layer, GLenum access, GLenum format);',
glMemoryBarrier = 'void glMemoryBarrier (GLbitfield barriers);',
glTexStorage1D = 'void glTexStorage1D (GLenum target, GLsizei levels, GLenum internalformat, GLsizei width);',
glTexStorage2D = 'void glTexStorage2D (GLenum target, GLsizei levels, GLenum internalformat, GLsizei width, GLsizei height);',
glTexStorage3D = 'void glTexStorage3D (GLenum target, GLsizei levels, GLenum internalformat, GLsizei width, GLsizei height, GLsizei depth);',
glDrawTransformFeedbackInstanced = 'void glDrawTransformFeedbackInstanced (GLenum mode, GLuint id, GLsizei instancecount);',
glDrawTransformFeedbackStreamInstanced = 'void glDrawTransformFeedbackStreamInstanced (GLenum mode, GLuint id, GLuint stream, GLsizei instancecount);',
glClearBufferData = 'void glClearBufferData (GLenum target, GLenum internalformat, GLenum format, GLenum type, const void *data);',
glClearBufferSubData = 'void glClearBufferSubData (GLenum target, GLenum internalformat, GLintptr offset, GLsizeiptr size, GLenum format, GLenum type, const void *data);',
glDispatchCompute = 'void glDispatchCompute (GLuint num_groups_x, GLuint num_groups_y, GLuint num_groups_z);',
glDispatchComputeIndirect = 'void glDispatchComputeIndirect (GLintptr indirect);',
glCopyImageSubData = 'void glCopyImageSubData (GLuint srcName, GLenum srcTarget, GLint srcLevel, GLint srcX, GLint srcY, GLint srcZ, GLuint dstName, GLenum dstTarget, GLint dstLevel, GLint dstX, GLint dstY, GLint dstZ, GLsizei srcWidth, GLsizei srcHeight, GLsizei srcDepth);',
glFramebufferParameteri = 'void glFramebufferParameteri (GLenum target, GLenum pname, GLint param);',
glGetFramebufferParameteriv = 'void glGetFramebufferParameteriv (GLenum target, GLenum pname, GLint *params);',
glGetInternalformati64v = 'void glGetInternalformati64v (GLenum target, GLenum internalformat, GLenum pname, GLsizei count, GLint64 *params);',
glInvalidateTexSubImage = 'void glInvalidateTexSubImage (GLuint texture, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth);',
glInvalidateTexImage = 'void glInvalidateTexImage (GLuint texture, GLint level);',
glInvalidateBufferSubData = 'void glInvalidateBufferSubData (GLuint buffer, GLintptr offset, GLsizeiptr length);',
glInvalidateBufferData = 'void glInvalidateBufferData (GLuint buffer);',
glInvalidateFramebuffer = 'void glInvalidateFramebuffer (GLenum target, GLsizei numAttachments, const GLenum *attachments);',
glInvalidateSubFramebuffer = 'void glInvalidateSubFramebuffer (GLenum target, GLsizei numAttachments, const GLenum *attachments, GLint x, GLint y, GLsizei width, GLsizei height);',
glMultiDrawArraysIndirect = 'void glMultiDrawArraysIndirect (GLenum mode, const void *indirect, GLsizei drawcount, GLsizei stride);',
glMultiDrawElementsIndirect = 'void glMultiDrawElementsIndirect (GLenum mode, GLenum type, const void *indirect, GLsizei drawcount, GLsizei stride);',
glGetProgramInterfaceiv = 'void glGetProgramInterfaceiv (GLuint program, GLenum programInterface, GLenum pname, GLint *params);',
glGetProgramResourceIndex = 'GLuint glGetProgramResourceIndex (GLuint program, GLenum programInterface, const GLchar *name);',
glGetProgramResourceName = 'void glGetProgramResourceName (GLuint program, GLenum programInterface, GLuint index, GLsizei bufSize, GLsizei *length, GLchar *name);',
glGetProgramResourceiv = 'void glGetProgramResourceiv (GLuint program, GLenum programInterface, GLuint index, GLsizei propCount, const GLenum *props, GLsizei count, GLsizei *length, GLint *params);',
glGetProgramResourceLocation = 'GLint glGetProgramResourceLocation (GLuint program, GLenum programInterface, const GLchar *name);',
glGetProgramResourceLocationIndex = 'GLint glGetProgramResourceLocationIndex (GLuint program, GLenum programInterface, const GLchar *name);',
glShaderStorageBlockBinding = 'void glShaderStorageBlockBinding (GLuint program, GLuint storageBlockIndex, GLuint storageBlockBinding);',
glTexBufferRange = 'void glTexBufferRange (GLenum target, GLenum internalformat, GLuint buffer, GLintptr offset, GLsizeiptr size);',
glTexStorage2DMultisample = 'void glTexStorage2DMultisample (GLenum target, GLsizei samples, GLenum internalformat, GLsizei width, GLsizei height, GLboolean fixedsamplelocations);',
glTexStorage3DMultisample = 'void glTexStorage3DMultisample (GLenum target, GLsizei samples, GLenum internalformat, GLsizei width, GLsizei height, GLsizei depth, GLboolean fixedsamplelocations);',
glTextureView = 'void glTextureView (GLuint texture, GLenum target, GLuint origtexture, GLenum internalformat, GLuint minlevel, GLuint numlevels, GLuint minlayer, GLuint numlayers);',
glBindVertexBuffer = 'void glBindVertexBuffer (GLuint bindingindex, GLuint buffer, GLintptr offset, GLsizei stride);',
glVertexAttribFormat = 'void glVertexAttribFormat (GLuint attribindex, GLint size, GLenum type, GLboolean normalized, GLuint relativeoffset);',
glVertexAttribIFormat = 'void glVertexAttribIFormat (GLuint attribindex, GLint size, GLenum type, GLuint relativeoffset);',
glVertexAttribLFormat = 'void glVertexAttribLFormat (GLuint attribindex, GLint size, GLenum type, GLuint relativeoffset);',
glVertexAttribBinding = 'void glVertexAttribBinding (GLuint attribindex, GLuint bindingindex);',
glVertexBindingDivisor = 'void glVertexBindingDivisor (GLuint bindingindex, GLuint divisor);',
glDebugMessageControl = 'void glDebugMessageControl (GLenum source, GLenum type, GLenum severity, GLsizei count, const GLuint *ids, GLboolean enabled);',
glDebugMessageInsert = 'void glDebugMessageInsert (GLenum source, GLenum type, GLuint id, GLenum severity, GLsizei length, const GLchar *buf);',
glDebugMessageCallback = 'void glDebugMessageCallback (GLDEBUGPROC callback, const void *userParam);',
glGetDebugMessageLog = 'GLuint glGetDebugMessageLog (GLuint count, GLsizei bufSize, GLenum *sources, GLenum *types, GLuint *ids, GLenum *severities, GLsizei *lengths, GLchar *messageLog);',
glPushDebugGroup = 'void glPushDebugGroup (GLenum source, GLuint id, GLsizei length, const GLchar *message);',
glPopDebugGroup = 'void glPopDebugGroup (void);',
glObjectLabel = 'void glObjectLabel (GLenum identifier, GLuint name, GLsizei length, const GLchar *label);',
glGetObjectLabel = 'void glGetObjectLabel (GLenum identifier, GLuint name, GLsizei bufSize, GLsizei *length, GLchar *label);',
glObjectPtrLabel = 'void glObjectPtrLabel (const void *ptr, GLsizei length, const GLchar *label);',
glGetObjectPtrLabel = 'void glGetObjectPtrLabel (const void *ptr, GLsizei bufSize, GLsizei *length, GLchar *label);',
glBufferStorage = 'void glBufferStorage (GLenum target, GLsizeiptr size, const void *data, GLbitfield flags);',
glClearTexImage = 'void glClearTexImage (GLuint texture, GLint level, GLenum format, GLenum type, const void *data);',
glClearTexSubImage = 'void glClearTexSubImage (GLuint texture, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth, GLenum format, GLenum type, const void *data);',
glBindBuffersBase = 'void glBindBuffersBase (GLenum target, GLuint first, GLsizei count, const GLuint *buffers);',
glBindBuffersRange = 'void glBindBuffersRange (GLenum target, GLuint first, GLsizei count, const GLuint *buffers, const GLintptr *offsets, const GLsizeiptr *sizes);',
glBindTextures = 'void glBindTextures (GLuint first, GLsizei count, const GLuint *textures);',
glBindSamplers = 'void glBindSamplers (GLuint first, GLsizei count, const GLuint *samplers);',
glBindImageTextures = 'void glBindImageTextures (GLuint first, GLsizei count, const GLuint *textures);',
glBindVertexBuffers = 'void glBindVertexBuffers (GLuint first, GLsizei count, const GLuint *buffers, const GLintptr *offsets, const GLsizei *strides);',
glClipControl = 'void glClipControl (GLenum origin, GLenum depth);',
glCreateTransformFeedbacks = 'void glCreateTransformFeedbacks (GLsizei n, GLuint *ids);',
glTransformFeedbackBufferBase = 'void glTransformFeedbackBufferBase (GLuint xfb, GLuint index, GLuint buffer);',
glTransformFeedbackBufferRange = 'void glTransformFeedbackBufferRange (GLuint xfb, GLuint index, GLuint buffer, GLintptr offset, GLsizeiptr size);',
glGetTransformFeedbackiv = 'void glGetTransformFeedbackiv (GLuint xfb, GLenum pname, GLint *param);',
glGetTransformFeedbacki_v = 'void glGetTransformFeedbacki_v (GLuint xfb, GLenum pname, GLuint index, GLint *param);',
glGetTransformFeedbacki64_v = 'void glGetTransformFeedbacki64_v (GLuint xfb, GLenum pname, GLuint index, GLint64 *param);',
glCreateBuffers = 'void glCreateBuffers (GLsizei n, GLuint *buffers);',
glNamedBufferStorage = 'void glNamedBufferStorage (GLuint buffer, GLsizeiptr size, const void *data, GLbitfield flags);',
glNamedBufferData = 'void glNamedBufferData (GLuint buffer, GLsizeiptr size, const void *data, GLenum usage);',
glNamedBufferSubData = 'void glNamedBufferSubData (GLuint buffer, GLintptr offset, GLsizeiptr size, const void *data);',
glCopyNamedBufferSubData = 'void glCopyNamedBufferSubData (GLuint readBuffer, GLuint writeBuffer, GLintptr readOffset, GLintptr writeOffset, GLsizeiptr size);',
glClearNamedBufferData = 'void glClearNamedBufferData (GLuint buffer, GLenum internalformat, GLenum format, GLenum type, const void *data);',
glClearNamedBufferSubData = 'void glClearNamedBufferSubData (GLuint buffer, GLenum internalformat, GLintptr offset, GLsizeiptr size, GLenum format, GLenum type, const void *data);',
glMapNamedBuffer = 'void * glMapNamedBuffer (GLuint buffer, GLenum access);',
glMapNamedBufferRange = 'void * glMapNamedBufferRange (GLuint buffer, GLintptr offset, GLsizeiptr length, GLbitfield access);',
glUnmapNamedBuffer = 'GLboolean glUnmapNamedBuffer (GLuint buffer);',
glFlushMappedNamedBufferRange = 'void glFlushMappedNamedBufferRange (GLuint buffer, GLintptr offset, GLsizeiptr length);',
glGetNamedBufferParameteriv = 'void glGetNamedBufferParameteriv (GLuint buffer, GLenum pname, GLint *params);',
glGetNamedBufferParameteri64v = 'void glGetNamedBufferParameteri64v (GLuint buffer, GLenum pname, GLint64 *params);',
glGetNamedBufferPointerv = 'void glGetNamedBufferPointerv (GLuint buffer, GLenum pname, void **params);',
glGetNamedBufferSubData = 'void glGetNamedBufferSubData (GLuint buffer, GLintptr offset, GLsizeiptr size, void *data);',
glCreateFramebuffers = 'void glCreateFramebuffers (GLsizei n, GLuint *framebuffers);',
glNamedFramebufferRenderbuffer = 'void glNamedFramebufferRenderbuffer (GLuint framebuffer, GLenum attachment, GLenum renderbuffertarget, GLuint renderbuffer);',
glNamedFramebufferParameteri = 'void glNamedFramebufferParameteri (GLuint framebuffer, GLenum pname, GLint param);',
glNamedFramebufferTexture = 'void glNamedFramebufferTexture (GLuint framebuffer, GLenum attachment, GLuint texture, GLint level);',
glNamedFramebufferTextureLayer = 'void glNamedFramebufferTextureLayer (GLuint framebuffer, GLenum attachment, GLuint texture, GLint level, GLint layer);',
glNamedFramebufferDrawBuffer = 'void glNamedFramebufferDrawBuffer (GLuint framebuffer, GLenum buf);',
glNamedFramebufferDrawBuffers = 'void glNamedFramebufferDrawBuffers (GLuint framebuffer, GLsizei n, const GLenum *bufs);',
glNamedFramebufferReadBuffer = 'void glNamedFramebufferReadBuffer (GLuint framebuffer, GLenum src);',
glInvalidateNamedFramebufferData = 'void glInvalidateNamedFramebufferData (GLuint framebuffer, GLsizei numAttachments, const GLenum *attachments);',
glInvalidateNamedFramebufferSubData = 'void glInvalidateNamedFramebufferSubData (GLuint framebuffer, GLsizei numAttachments, const GLenum *attachments, GLint x, GLint y, GLsizei width, GLsizei height);',
glClearNamedFramebufferiv = 'void glClearNamedFramebufferiv (GLuint framebuffer, GLenum buffer, GLint drawbuffer, const GLint *value);',
glClearNamedFramebufferuiv = 'void glClearNamedFramebufferuiv (GLuint framebuffer, GLenum buffer, GLint drawbuffer, const GLuint *value);',
glClearNamedFramebufferfv = 'void glClearNamedFramebufferfv (GLuint framebuffer, GLenum buffer, GLint drawbuffer, const GLfloat *value);',
glClearNamedFramebufferfi = 'void glClearNamedFramebufferfi (GLuint framebuffer, GLenum buffer, GLint drawbuffer, GLfloat depth, GLint stencil);',
glBlitNamedFramebuffer = 'void glBlitNamedFramebuffer (GLuint readFramebuffer, GLuint drawFramebuffer, GLint srcX0, GLint srcY0, GLint srcX1, GLint srcY1, GLint dstX0, GLint dstY0, GLint dstX1, GLint dstY1, GLbitfield mask, GLenum filter);',
glCheckNamedFramebufferStatus = 'GLenum glCheckNamedFramebufferStatus (GLuint framebuffer, GLenum target);',
glGetNamedFramebufferParameteriv = 'void glGetNamedFramebufferParameteriv (GLuint framebuffer, GLenum pname, GLint *param);',
glGetNamedFramebufferAttachmentParameteriv = 'void glGetNamedFramebufferAttachmentParameteriv (GLuint framebuffer, GLenum attachment, GLenum pname, GLint *params);',
glCreateRenderbuffers = 'void glCreateRenderbuffers (GLsizei n, GLuint *renderbuffers);',
glNamedRenderbufferStorage = 'void glNamedRenderbufferStorage (GLuint renderbuffer, GLenum internalformat, GLsizei width, GLsizei height);',
glNamedRenderbufferStorageMultisample = 'void glNamedRenderbufferStorageMultisample (GLuint renderbuffer, GLsizei samples, GLenum internalformat, GLsizei width, GLsizei height);',
glGetNamedRenderbufferParameteriv = 'void glGetNamedRenderbufferParameteriv (GLuint renderbuffer, GLenum pname, GLint *params);',
glCreateTextures = 'void glCreateTextures (GLenum target, GLsizei n, GLuint *textures);',
glTextureBuffer = 'void glTextureBuffer (GLuint texture, GLenum internalformat, GLuint buffer);',
glTextureBufferRange = 'void glTextureBufferRange (GLuint texture, GLenum internalformat, GLuint buffer, GLintptr offset, GLsizeiptr size);',
glTextureStorage1D = 'void glTextureStorage1D (GLuint texture, GLsizei levels, GLenum internalformat, GLsizei width);',
glTextureStorage2D = 'void glTextureStorage2D (GLuint texture, GLsizei levels, GLenum internalformat, GLsizei width, GLsizei height);',
glTextureStorage3D = 'void glTextureStorage3D (GLuint texture, GLsizei levels, GLenum internalformat, GLsizei width, GLsizei height, GLsizei depth);',
glTextureStorage2DMultisample = 'void glTextureStorage2DMultisample (GLuint texture, GLsizei samples, GLenum internalformat, GLsizei width, GLsizei height, GLboolean fixedsamplelocations);',
glTextureStorage3DMultisample = 'void glTextureStorage3DMultisample (GLuint texture, GLsizei samples, GLenum internalformat, GLsizei width, GLsizei height, GLsizei depth, GLboolean fixedsamplelocations);',
glTextureSubImage1D = 'void glTextureSubImage1D (GLuint texture, GLint level, GLint xoffset, GLsizei width, GLenum format, GLenum type, const void *pixels);',
glTextureSubImage2D = 'void glTextureSubImage2D (GLuint texture, GLint level, GLint xoffset, GLint yoffset, GLsizei width, GLsizei height, GLenum format, GLenum type, const void *pixels);',
glTextureSubImage3D = 'void glTextureSubImage3D (GLuint texture, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth, GLenum format, GLenum type, const void *pixels);',
glCompressedTextureSubImage1D = 'void glCompressedTextureSubImage1D (GLuint texture, GLint level, GLint xoffset, GLsizei width, GLenum format, GLsizei imageSize, const void *data);',
glCompressedTextureSubImage2D = 'void glCompressedTextureSubImage2D (GLuint texture, GLint level, GLint xoffset, GLint yoffset, GLsizei width, GLsizei height, GLenum format, GLsizei imageSize, const void *data);',
glCompressedTextureSubImage3D = 'void glCompressedTextureSubImage3D (GLuint texture, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth, GLenum format, GLsizei imageSize, const void *data);',
glCopyTextureSubImage1D = 'void glCopyTextureSubImage1D (GLuint texture, GLint level, GLint xoffset, GLint x, GLint y, GLsizei width);',
glCopyTextureSubImage2D = 'void glCopyTextureSubImage2D (GLuint texture, GLint level, GLint xoffset, GLint yoffset, GLint x, GLint y, GLsizei width, GLsizei height);',
glCopyTextureSubImage3D = 'void glCopyTextureSubImage3D (GLuint texture, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLint x, GLint y, GLsizei width, GLsizei height);',
glTextureParameterf = 'void glTextureParameterf (GLuint texture, GLenum pname, GLfloat param);',
glTextureParameterfv = 'void glTextureParameterfv (GLuint texture, GLenum pname, const GLfloat *param);',
glTextureParameteri = 'void glTextureParameteri (GLuint texture, GLenum pname, GLint param);',
glTextureParameterIiv = 'void glTextureParameterIiv (GLuint texture, GLenum pname, const GLint *params);',
glTextureParameterIuiv = 'void glTextureParameterIuiv (GLuint texture, GLenum pname, const GLuint *params);',
glTextureParameteriv = 'void glTextureParameteriv (GLuint texture, GLenum pname, const GLint *param);',
glGenerateTextureMipmap = 'void glGenerateTextureMipmap (GLuint texture);',
glBindTextureUnit = 'void glBindTextureUnit (GLuint unit, GLuint texture);',
glGetTextureImage = 'void glGetTextureImage (GLuint texture, GLint level, GLenum format, GLenum type, GLsizei bufSize, void *pixels);',
glGetCompressedTextureImage = 'void glGetCompressedTextureImage (GLuint texture, GLint level, GLsizei bufSize, void *pixels);',
glGetTextureLevelParameterfv = 'void glGetTextureLevelParameterfv (GLuint texture, GLint level, GLenum pname, GLfloat *params);',
glGetTextureLevelParameteriv = 'void glGetTextureLevelParameteriv (GLuint texture, GLint level, GLenum pname, GLint *params);',
glGetTextureParameterfv = 'void glGetTextureParameterfv (GLuint texture, GLenum pname, GLfloat *params);',
glGetTextureParameterIiv = 'void glGetTextureParameterIiv (GLuint texture, GLenum pname, GLint *params);',
glGetTextureParameterIuiv = 'void glGetTextureParameterIuiv (GLuint texture, GLenum pname, GLuint *params);',
glGetTextureParameteriv = 'void glGetTextureParameteriv (GLuint texture, GLenum pname, GLint *params);',
glCreateVertexArrays = 'void glCreateVertexArrays (GLsizei n, GLuint *arrays);',
glDisableVertexArrayAttrib = 'void glDisableVertexArrayAttrib (GLuint vaobj, GLuint index);',
glEnableVertexArrayAttrib = 'void glEnableVertexArrayAttrib (GLuint vaobj, GLuint index);',
glVertexArrayElementBuffer = 'void glVertexArrayElementBuffer (GLuint vaobj, GLuint buffer);',
glVertexArrayVertexBuffer = 'void glVertexArrayVertexBuffer (GLuint vaobj, GLuint bindingindex, GLuint buffer, GLintptr offset, GLsizei stride);',
glVertexArrayVertexBuffers = 'void glVertexArrayVertexBuffers (GLuint vaobj, GLuint first, GLsizei count, const GLuint *buffers, const GLintptr *offsets, const GLsizei *strides);',
glVertexArrayAttribBinding = 'void glVertexArrayAttribBinding (GLuint vaobj, GLuint attribindex, GLuint bindingindex);',
glVertexArrayAttribFormat = 'void glVertexArrayAttribFormat (GLuint vaobj, GLuint attribindex, GLint size, GLenum type, GLboolean normalized, GLuint relativeoffset);',
glVertexArrayAttribIFormat = 'void glVertexArrayAttribIFormat (GLuint vaobj, GLuint attribindex, GLint size, GLenum type, GLuint relativeoffset);',
glVertexArrayAttribLFormat = 'void glVertexArrayAttribLFormat (GLuint vaobj, GLuint attribindex, GLint size, GLenum type, GLuint relativeoffset);',
glVertexArrayBindingDivisor = 'void glVertexArrayBindingDivisor (GLuint vaobj, GLuint bindingindex, GLuint divisor);',
glGetVertexArrayiv = 'void glGetVertexArrayiv (GLuint vaobj, GLenum pname, GLint *param);',
glGetVertexArrayIndexediv = 'void glGetVertexArrayIndexediv (GLuint vaobj, GLuint index, GLenum pname, GLint *param);',
glGetVertexArrayIndexed64iv = 'void glGetVertexArrayIndexed64iv (GLuint vaobj, GLuint index, GLenum pname, GLint64 *param);',
glCreateSamplers = 'void glCreateSamplers (GLsizei n, GLuint *samplers);',
glCreateProgramPipelines = 'void glCreateProgramPipelines (GLsizei n, GLuint *pipelines);',
glCreateQueries = 'void glCreateQueries (GLenum target, GLsizei n, GLuint *ids);',
glGetQueryBufferObjecti64v = 'void glGetQueryBufferObjecti64v (GLuint id, GLuint buffer, GLenum pname, GLintptr offset);',
glGetQueryBufferObjectiv = 'void glGetQueryBufferObjectiv (GLuint id, GLuint buffer, GLenum pname, GLintptr offset);',
glGetQueryBufferObjectui64v = 'void glGetQueryBufferObjectui64v (GLuint id, GLuint buffer, GLenum pname, GLintptr offset);',
glGetQueryBufferObjectuiv = 'void glGetQueryBufferObjectuiv (GLuint id, GLuint buffer, GLenum pname, GLintptr offset);',
glMemoryBarrierByRegion = 'void glMemoryBarrierByRegion (GLbitfield barriers);',
glGetTextureSubImage = 'void glGetTextureSubImage (GLuint texture, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth, GLenum format, GLenum type, GLsizei bufSize, void *pixels);',
glGetCompressedTextureSubImage = 'void glGetCompressedTextureSubImage (GLuint texture, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth, GLsizei bufSize, void *pixels);',
glGetGraphicsResetStatus = 'GLenum glGetGraphicsResetStatus (void);',
glGetnCompressedTexImage = 'void glGetnCompressedTexImage (GLenum target, GLint lod, GLsizei bufSize, void *pixels);',
glGetnTexImage = 'void glGetnTexImage (GLenum target, GLint level, GLenum format, GLenum type, GLsizei bufSize, void *pixels);',
glGetnUniformdv = 'void glGetnUniformdv (GLuint program, GLint location, GLsizei bufSize, GLdouble *params);',
glGetnUniformfv = 'void glGetnUniformfv (GLuint program, GLint location, GLsizei bufSize, GLfloat *params);',
glGetnUniformiv = 'void glGetnUniformiv (GLuint program, GLint location, GLsizei bufSize, GLint *params);',
glGetnUniformuiv = 'void glGetnUniformuiv (GLuint program, GLint location, GLsizei bufSize, GLuint *params);',
glReadnPixels = 'void glReadnPixels (GLint x, GLint y, GLsizei width, GLsizei height, GLenum format, GLenum type, GLsizei bufSize, void *data);',
glGetnMapdv = 'void glGetnMapdv (GLenum target, GLenum query, GLsizei bufSize, GLdouble *v);',
glGetnMapfv = 'void glGetnMapfv (GLenum target, GLenum query, GLsizei bufSize, GLfloat *v);',
glGetnMapiv = 'void glGetnMapiv (GLenum target, GLenum query, GLsizei bufSize, GLint *v);',
glGetnPixelMapfv = 'void glGetnPixelMapfv (GLenum map, GLsizei bufSize, GLfloat *values);',
glGetnPixelMapuiv = 'void glGetnPixelMapuiv (GLenum map, GLsizei bufSize, GLuint *values);',
glGetnPixelMapusv = 'void glGetnPixelMapusv (GLenum map, GLsizei bufSize, GLushort *values);',
glGetnPolygonStipple = 'void glGetnPolygonStipple (GLsizei bufSize, GLubyte *pattern);',
glGetnColorTable = 'void glGetnColorTable (GLenum target, GLenum format, GLenum type, GLsizei bufSize, void *table);',
glGetnConvolutionFilter = 'void glGetnConvolutionFilter (GLenum target, GLenum format, GLenum type, GLsizei bufSize, void *image);',
glGetnSeparableFilter = 'void glGetnSeparableFilter (GLenum target, GLenum format, GLenum type, GLsizei rowBufSize, void *row, GLsizei columnBufSize, void *column, void *span);',
glGetnHistogram = 'void glGetnHistogram (GLenum target, GLboolean reset, GLenum format, GLenum type, GLsizei bufSize, void *values);',
glGetnMinmax = 'void glGetnMinmax (GLenum target, GLboolean reset, GLenum format, GLenum type, GLsizei bufSize, void *values);',
glTextureBarrier = 'void glTextureBarrier (void);',
glSpecializeShader = 'void glSpecializeShader (GLuint shader, const GLchar *pEntryPoint, GLuint numSpecializationConstants, const GLuint *pConstantIndex, const GLuint *pConstantValue);',
glMultiDrawArraysIndirectCount = 'void glMultiDrawArraysIndirectCount (GLenum mode, const void *indirect, GLintptr drawcount, GLsizei maxdrawcount, GLsizei stride);',
glMultiDrawElementsIndirectCount = 'void glMultiDrawElementsIndirectCount (GLenum mode, GLenum type, const void *indirect, GLintptr drawcount, GLsizei maxdrawcount, GLsizei stride);',
glPolygonOffsetClamp = 'void glPolygonOffsetClamp (GLfloat factor, GLfloat units, GLfloat clamp);',
glPrimitiveBoundingBoxARB = 'void glPrimitiveBoundingBoxARB (GLfloat minX, GLfloat minY, GLfloat minZ, GLfloat minW, GLfloat maxX, GLfloat maxY, GLfloat maxZ, GLfloat maxW);',
glGetTextureHandleARB = 'GLuint64 glGetTextureHandleARB (GLuint texture);',
glGetTextureSamplerHandleARB = 'GLuint64 glGetTextureSamplerHandleARB (GLuint texture, GLuint sampler);',
glMakeTextureHandleResidentARB = 'void glMakeTextureHandleResidentARB (GLuint64 handle);',
glMakeTextureHandleNonResidentARB = 'void glMakeTextureHandleNonResidentARB (GLuint64 handle);',
glGetImageHandleARB = 'GLuint64 glGetImageHandleARB (GLuint texture, GLint level, GLboolean layered, GLint layer, GLenum format);',
glMakeImageHandleResidentARB = 'void glMakeImageHandleResidentARB (GLuint64 handle, GLenum access);',
glMakeImageHandleNonResidentARB = 'void glMakeImageHandleNonResidentARB (GLuint64 handle);',
glUniformHandleui64ARB = 'void glUniformHandleui64ARB (GLint location, GLuint64 value);',
glUniformHandleui64vARB = 'void glUniformHandleui64vARB (GLint location, GLsizei count, const GLuint64 *value);',
glProgramUniformHandleui64ARB = 'void glProgramUniformHandleui64ARB (GLuint program, GLint location, GLuint64 value);',
glProgramUniformHandleui64vARB = 'void glProgramUniformHandleui64vARB (GLuint program, GLint location, GLsizei count, const GLuint64 *values);',
glIsTextureHandleResidentARB = 'GLboolean glIsTextureHandleResidentARB (GLuint64 handle);',
glIsImageHandleResidentARB = 'GLboolean glIsImageHandleResidentARB (GLuint64 handle);',
glVertexAttribL1ui64ARB = 'void glVertexAttribL1ui64ARB (GLuint index, GLuint64EXT x);',
glVertexAttribL1ui64vARB = 'void glVertexAttribL1ui64vARB (GLuint index, const GLuint64EXT *v);',
glGetVertexAttribLui64vARB = 'void glGetVertexAttribLui64vARB (GLuint index, GLenum pname, GLuint64EXT *params);',
glCreateSyncFromCLeventARB = 'GLsync glCreateSyncFromCLeventARB (struct _cl_context *context, struct _cl_event *event, GLbitfield flags);',
glClampColorARB = 'void glClampColorARB (GLenum target, GLenum clamp);',
glDispatchComputeGroupSizeARB = 'void glDispatchComputeGroupSizeARB (GLuint num_groups_x, GLuint num_groups_y, GLuint num_groups_z, GLuint group_size_x, GLuint group_size_y, GLuint group_size_z);',
glDebugMessageControlARB = 'void glDebugMessageControlARB (GLenum source, GLenum type, GLenum severity, GLsizei count, const GLuint *ids, GLboolean enabled);',
glDebugMessageInsertARB = 'void glDebugMessageInsertARB (GLenum source, GLenum type, GLuint id, GLenum severity, GLsizei length, const GLchar *buf);',
glDebugMessageCallbackARB = 'void glDebugMessageCallbackARB (GLDEBUGPROCARB callback, const void *userParam);',
glGetDebugMessageLogARB = 'GLuint glGetDebugMessageLogARB (GLuint count, GLsizei bufSize, GLenum *sources, GLenum *types, GLuint *ids, GLenum *severities, GLsizei *lengths, GLchar *messageLog);',
glDrawBuffersARB = 'void glDrawBuffersARB (GLsizei n, const GLenum *bufs);',
glBlendEquationiARB = 'void glBlendEquationiARB (GLuint buf, GLenum mode);',
glBlendEquationSeparateiARB = 'void glBlendEquationSeparateiARB (GLuint buf, GLenum modeRGB, GLenum modeAlpha);',
glBlendFunciARB = 'void glBlendFunciARB (GLuint buf, GLenum src, GLenum dst);',
glBlendFuncSeparateiARB = 'void glBlendFuncSeparateiARB (GLuint buf, GLenum srcRGB, GLenum dstRGB, GLenum srcAlpha, GLenum dstAlpha);',
glDrawArraysInstancedARB = 'void glDrawArraysInstancedARB (GLenum mode, GLint first, GLsizei count, GLsizei primcount);',
glDrawElementsInstancedARB = 'void glDrawElementsInstancedARB (GLenum mode, GLsizei count, GLenum type, const void *indices, GLsizei primcount);',
glProgramStringARB = 'void glProgramStringARB (GLenum target, GLenum format, GLsizei len, const void *string);',
glBindProgramARB = 'void glBindProgramARB (GLenum target, GLuint program);',
glDeleteProgramsARB = 'void glDeleteProgramsARB (GLsizei n, const GLuint *programs);',
glGenProgramsARB = 'void glGenProgramsARB (GLsizei n, GLuint *programs);',
glProgramEnvParameter4dARB = 'void glProgramEnvParameter4dARB (GLenum target, GLuint index, GLdouble x, GLdouble y, GLdouble z, GLdouble w);',
glProgramEnvParameter4dvARB = 'void glProgramEnvParameter4dvARB (GLenum target, GLuint index, const GLdouble *params);',
glProgramEnvParameter4fARB = 'void glProgramEnvParameter4fARB (GLenum target, GLuint index, GLfloat x, GLfloat y, GLfloat z, GLfloat w);',
glProgramEnvParameter4fvARB = 'void glProgramEnvParameter4fvARB (GLenum target, GLuint index, const GLfloat *params);',
glProgramLocalParameter4dARB = 'void glProgramLocalParameter4dARB (GLenum target, GLuint index, GLdouble x, GLdouble y, GLdouble z, GLdouble w);',
glProgramLocalParameter4dvARB = 'void glProgramLocalParameter4dvARB (GLenum target, GLuint index, const GLdouble *params);',
glProgramLocalParameter4fARB = 'void glProgramLocalParameter4fARB (GLenum target, GLuint index, GLfloat x, GLfloat y, GLfloat z, GLfloat w);',
glProgramLocalParameter4fvARB = 'void glProgramLocalParameter4fvARB (GLenum target, GLuint index, const GLfloat *params);',
glGetProgramEnvParameterdvARB = 'void glGetProgramEnvParameterdvARB (GLenum target, GLuint index, GLdouble *params);',
glGetProgramEnvParameterfvARB = 'void glGetProgramEnvParameterfvARB (GLenum target, GLuint index, GLfloat *params);',
glGetProgramLocalParameterdvARB = 'void glGetProgramLocalParameterdvARB (GLenum target, GLuint index, GLdouble *params);',
glGetProgramLocalParameterfvARB = 'void glGetProgramLocalParameterfvARB (GLenum target, GLuint index, GLfloat *params);',
glGetProgramivARB = 'void glGetProgramivARB (GLenum target, GLenum pname, GLint *params);',
glGetProgramStringARB = 'void glGetProgramStringARB (GLenum target, GLenum pname, void *string);',
glIsProgramARB = 'GLboolean glIsProgramARB (GLuint program);',
glProgramParameteriARB = 'void glProgramParameteriARB (GLuint program, GLenum pname, GLint value);',
glFramebufferTextureARB = 'void glFramebufferTextureARB (GLenum target, GLenum attachment, GLuint texture, GLint level);',
glFramebufferTextureLayerARB = 'void glFramebufferTextureLayerARB (GLenum target, GLenum attachment, GLuint texture, GLint level, GLint layer);',
glFramebufferTextureFaceARB = 'void glFramebufferTextureFaceARB (GLenum target, GLenum attachment, GLuint texture, GLint level, GLenum face);',
glSpecializeShaderARB = 'void glSpecializeShaderARB (GLuint shader, const GLchar *pEntryPoint, GLuint numSpecializationConstants, const GLuint *pConstantIndex, const GLuint *pConstantValue);',
glUniform1i64ARB = 'void glUniform1i64ARB (GLint location, GLint64 x);',
glUniform2i64ARB = 'void glUniform2i64ARB (GLint location, GLint64 x, GLint64 y);',
glUniform3i64ARB = 'void glUniform3i64ARB (GLint location, GLint64 x, GLint64 y, GLint64 z);',
glUniform4i64ARB = 'void glUniform4i64ARB (GLint location, GLint64 x, GLint64 y, GLint64 z, GLint64 w);',
glUniform1i64vARB = 'void glUniform1i64vARB (GLint location, GLsizei count, const GLint64 *value);',
glUniform2i64vARB = 'void glUniform2i64vARB (GLint location, GLsizei count, const GLint64 *value);',
glUniform3i64vARB = 'void glUniform3i64vARB (GLint location, GLsizei count, const GLint64 *value);',
glUniform4i64vARB = 'void glUniform4i64vARB (GLint location, GLsizei count, const GLint64 *value);',
glUniform1ui64ARB = 'void glUniform1ui64ARB (GLint location, GLuint64 x);',
glUniform2ui64ARB = 'void glUniform2ui64ARB (GLint location, GLuint64 x, GLuint64 y);',
glUniform3ui64ARB = 'void glUniform3ui64ARB (GLint location, GLuint64 x, GLuint64 y, GLuint64 z);',
glUniform4ui64ARB = 'void glUniform4ui64ARB (GLint location, GLuint64 x, GLuint64 y, GLuint64 z, GLuint64 w);',
glUniform1ui64vARB = 'void glUniform1ui64vARB (GLint location, GLsizei count, const GLuint64 *value);',
glUniform2ui64vARB = 'void glUniform2ui64vARB (GLint location, GLsizei count, const GLuint64 *value);',
glUniform3ui64vARB = 'void glUniform3ui64vARB (GLint location, GLsizei count, const GLuint64 *value);',
glUniform4ui64vARB = 'void glUniform4ui64vARB (GLint location, GLsizei count, const GLuint64 *value);',
glGetUniformi64vARB = 'void glGetUniformi64vARB (GLuint program, GLint location, GLint64 *params);',
glGetUniformui64vARB = 'void glGetUniformui64vARB (GLuint program, GLint location, GLuint64 *params);',
glGetnUniformi64vARB = 'void glGetnUniformi64vARB (GLuint program, GLint location, GLsizei bufSize, GLint64 *params);',
glGetnUniformui64vARB = 'void glGetnUniformui64vARB (GLuint program, GLint location, GLsizei bufSize, GLuint64 *params);',
glProgramUniform1i64ARB = 'void glProgramUniform1i64ARB (GLuint program, GLint location, GLint64 x);',
glProgramUniform2i64ARB = 'void glProgramUniform2i64ARB (GLuint program, GLint location, GLint64 x, GLint64 y);',
glProgramUniform3i64ARB = 'void glProgramUniform3i64ARB (GLuint program, GLint location, GLint64 x, GLint64 y, GLint64 z);',
glProgramUniform4i64ARB = 'void glProgramUniform4i64ARB (GLuint program, GLint location, GLint64 x, GLint64 y, GLint64 z, GLint64 w);',
glProgramUniform1i64vARB = 'void glProgramUniform1i64vARB (GLuint program, GLint location, GLsizei count, const GLint64 *value);',
glProgramUniform2i64vARB = 'void glProgramUniform2i64vARB (GLuint program, GLint location, GLsizei count, const GLint64 *value);',
glProgramUniform3i64vARB = 'void glProgramUniform3i64vARB (GLuint program, GLint location, GLsizei count, const GLint64 *value);',
glProgramUniform4i64vARB = 'void glProgramUniform4i64vARB (GLuint program, GLint location, GLsizei count, const GLint64 *value);',
glProgramUniform1ui64ARB = 'void glProgramUniform1ui64ARB (GLuint program, GLint location, GLuint64 x);',
glProgramUniform2ui64ARB = 'void glProgramUniform2ui64ARB (GLuint program, GLint location, GLuint64 x, GLuint64 y);',
glProgramUniform3ui64ARB = 'void glProgramUniform3ui64ARB (GLuint program, GLint location, GLuint64 x, GLuint64 y, GLuint64 z);',
glProgramUniform4ui64ARB = 'void glProgramUniform4ui64ARB (GLuint program, GLint location, GLuint64 x, GLuint64 y, GLuint64 z, GLuint64 w);',
glProgramUniform1ui64vARB = 'void glProgramUniform1ui64vARB (GLuint program, GLint location, GLsizei count, const GLuint64 *value);',
glProgramUniform2ui64vARB = 'void glProgramUniform2ui64vARB (GLuint program, GLint location, GLsizei count, const GLuint64 *value);',
glProgramUniform3ui64vARB = 'void glProgramUniform3ui64vARB (GLuint program, GLint location, GLsizei count, const GLuint64 *value);',
glProgramUniform4ui64vARB = 'void glProgramUniform4ui64vARB (GLuint program, GLint location, GLsizei count, const GLuint64 *value);',
glColorTable = 'void glColorTable (GLenum target, GLenum internalformat, GLsizei width, GLenum format, GLenum type, const void *table);',
glColorTableParameterfv = 'void glColorTableParameterfv (GLenum target, GLenum pname, const GLfloat *params);',
glColorTableParameteriv = 'void glColorTableParameteriv (GLenum target, GLenum pname, const GLint *params);',
glCopyColorTable = 'void glCopyColorTable (GLenum target, GLenum internalformat, GLint x, GLint y, GLsizei width);',
glGetColorTable = 'void glGetColorTable (GLenum target, GLenum format, GLenum type, void *table);',
glGetColorTableParameterfv = 'void glGetColorTableParameterfv (GLenum target, GLenum pname, GLfloat *params);',
glGetColorTableParameteriv = 'void glGetColorTableParameteriv (GLenum target, GLenum pname, GLint *params);',
glColorSubTable = 'void glColorSubTable (GLenum target, GLsizei start, GLsizei count, GLenum format, GLenum type, const void *data);',
glCopyColorSubTable = 'void glCopyColorSubTable (GLenum target, GLsizei start, GLint x, GLint y, GLsizei width);',
glConvolutionFilter1D = 'void glConvolutionFilter1D (GLenum target, GLenum internalformat, GLsizei width, GLenum format, GLenum type, const void *image);',
glConvolutionFilter2D = 'void glConvolutionFilter2D (GLenum target, GLenum internalformat, GLsizei width, GLsizei height, GLenum format, GLenum type, const void *image);',
glConvolutionParameterf = 'void glConvolutionParameterf (GLenum target, GLenum pname, GLfloat params);',
glConvolutionParameterfv = 'void glConvolutionParameterfv (GLenum target, GLenum pname, const GLfloat *params);',
glConvolutionParameteri = 'void glConvolutionParameteri (GLenum target, GLenum pname, GLint params);',
glConvolutionParameteriv = 'void glConvolutionParameteriv (GLenum target, GLenum pname, const GLint *params);',
glCopyConvolutionFilter1D = 'void glCopyConvolutionFilter1D (GLenum target, GLenum internalformat, GLint x, GLint y, GLsizei width);',
glCopyConvolutionFilter2D = 'void glCopyConvolutionFilter2D (GLenum target, GLenum internalformat, GLint x, GLint y, GLsizei width, GLsizei height);',
glGetConvolutionFilter = 'void glGetConvolutionFilter (GLenum target, GLenum format, GLenum type, void *image);',
glGetConvolutionParameterfv = 'void glGetConvolutionParameterfv (GLenum target, GLenum pname, GLfloat *params);',
glGetConvolutionParameteriv = 'void glGetConvolutionParameteriv (GLenum target, GLenum pname, GLint *params);',
glGetSeparableFilter = 'void glGetSeparableFilter (GLenum target, GLenum format, GLenum type, void *row, void *column, void *span);',
glSeparableFilter2D = 'void glSeparableFilter2D (GLenum target, GLenum internalformat, GLsizei width, GLsizei height, GLenum format, GLenum type, const void *row, const void *column);',
glGetHistogram = 'void glGetHistogram (GLenum target, GLboolean reset, GLenum format, GLenum type, void *values);',
glGetHistogramParameterfv = 'void glGetHistogramParameterfv (GLenum target, GLenum pname, GLfloat *params);',
glGetHistogramParameteriv = 'void glGetHistogramParameteriv (GLenum target, GLenum pname, GLint *params);',
glGetMinmax = 'void glGetMinmax (GLenum target, GLboolean reset, GLenum format, GLenum type, void *values);',
glGetMinmaxParameterfv = 'void glGetMinmaxParameterfv (GLenum target, GLenum pname, GLfloat *params);',
glGetMinmaxParameteriv = 'void glGetMinmaxParameteriv (GLenum target, GLenum pname, GLint *params);',
glHistogram = 'void glHistogram (GLenum target, GLsizei width, GLenum internalformat, GLboolean sink);',
glMinmax = 'void glMinmax (GLenum target, GLenum internalformat, GLboolean sink);',
glResetHistogram = 'void glResetHistogram (GLenum target);',
glResetMinmax = 'void glResetMinmax (GLenum target);',
glMultiDrawArraysIndirectCountARB = 'void glMultiDrawArraysIndirectCountARB (GLenum mode, const void *indirect, GLintptr drawcount, GLsizei maxdrawcount, GLsizei stride);',
glMultiDrawElementsIndirectCountARB = 'void glMultiDrawElementsIndirectCountARB (GLenum mode, GLenum type, const void *indirect, GLintptr drawcount, GLsizei maxdrawcount, GLsizei stride);',
glVertexAttribDivisorARB = 'void glVertexAttribDivisorARB (GLuint index, GLuint divisor);',
glCurrentPaletteMatrixARB = 'void glCurrentPaletteMatrixARB (GLint index);',
glMatrixIndexubvARB = 'void glMatrixIndexubvARB (GLint size, const GLubyte *indices);',
glMatrixIndexusvARB = 'void glMatrixIndexusvARB (GLint size, const GLushort *indices);',
glMatrixIndexuivARB = 'void glMatrixIndexuivARB (GLint size, const GLuint *indices);',
glMatrixIndexPointerARB = 'void glMatrixIndexPointerARB (GLint size, GLenum type, GLsizei stride, const void *pointer);',
glSampleCoverageARB = 'void glSampleCoverageARB (GLfloat value, GLboolean invert);',
glActiveTextureARB = 'void glActiveTextureARB (GLenum texture);',
glClientActiveTextureARB = 'void glClientActiveTextureARB (GLenum texture);',
glMultiTexCoord1dARB = 'void glMultiTexCoord1dARB (GLenum target, GLdouble s);',
glMultiTexCoord1dvARB = 'void glMultiTexCoord1dvARB (GLenum target, const GLdouble *v);',
glMultiTexCoord1fARB = 'void glMultiTexCoord1fARB (GLenum target, GLfloat s);',
glMultiTexCoord1fvARB = 'void glMultiTexCoord1fvARB (GLenum target, const GLfloat *v);',
glMultiTexCoord1iARB = 'void glMultiTexCoord1iARB (GLenum target, GLint s);',
glMultiTexCoord1ivARB = 'void glMultiTexCoord1ivARB (GLenum target, const GLint *v);',
glMultiTexCoord1sARB = 'void glMultiTexCoord1sARB (GLenum target, GLshort s);',
glMultiTexCoord1svARB = 'void glMultiTexCoord1svARB (GLenum target, const GLshort *v);',
glMultiTexCoord2dARB = 'void glMultiTexCoord2dARB (GLenum target, GLdouble s, GLdouble t);',
glMultiTexCoord2dvARB = 'void glMultiTexCoord2dvARB (GLenum target, const GLdouble *v);',
glMultiTexCoord2fARB = 'void glMultiTexCoord2fARB (GLenum target, GLfloat s, GLfloat t);',
glMultiTexCoord2fvARB = 'void glMultiTexCoord2fvARB (GLenum target, const GLfloat *v);',
glMultiTexCoord2iARB = 'void glMultiTexCoord2iARB (GLenum target, GLint s, GLint t);',
glMultiTexCoord2ivARB = 'void glMultiTexCoord2ivARB (GLenum target, const GLint *v);',
glMultiTexCoord2sARB = 'void glMultiTexCoord2sARB (GLenum target, GLshort s, GLshort t);',
glMultiTexCoord2svARB = 'void glMultiTexCoord2svARB (GLenum target, const GLshort *v);',
glMultiTexCoord3dARB = 'void glMultiTexCoord3dARB (GLenum target, GLdouble s, GLdouble t, GLdouble r);',
glMultiTexCoord3dvARB = 'void glMultiTexCoord3dvARB (GLenum target, const GLdouble *v);',
glMultiTexCoord3fARB = 'void glMultiTexCoord3fARB (GLenum target, GLfloat s, GLfloat t, GLfloat r);',
glMultiTexCoord3fvARB = 'void glMultiTexCoord3fvARB (GLenum target, const GLfloat *v);',
glMultiTexCoord3iARB = 'void glMultiTexCoord3iARB (GLenum target, GLint s, GLint t, GLint r);',
glMultiTexCoord3ivARB = 'void glMultiTexCoord3ivARB (GLenum target, const GLint *v);',
glMultiTexCoord3sARB = 'void glMultiTexCoord3sARB (GLenum target, GLshort s, GLshort t, GLshort r);',
glMultiTexCoord3svARB = 'void glMultiTexCoord3svARB (GLenum target, const GLshort *v);',
glMultiTexCoord4dARB = 'void glMultiTexCoord4dARB (GLenum target, GLdouble s, GLdouble t, GLdouble r, GLdouble q);',
glMultiTexCoord4dvARB = 'void glMultiTexCoord4dvARB (GLenum target, const GLdouble *v);',
glMultiTexCoord4fARB = 'void glMultiTexCoord4fARB (GLenum target, GLfloat s, GLfloat t, GLfloat r, GLfloat q);',
glMultiTexCoord4fvARB = 'void glMultiTexCoord4fvARB (GLenum target, const GLfloat *v);',
glMultiTexCoord4iARB = 'void glMultiTexCoord4iARB (GLenum target, GLint s, GLint t, GLint r, GLint q);',
glMultiTexCoord4ivARB = 'void glMultiTexCoord4ivARB (GLenum target, const GLint *v);',
glMultiTexCoord4sARB = 'void glMultiTexCoord4sARB (GLenum target, GLshort s, GLshort t, GLshort r, GLshort q);',
glMultiTexCoord4svARB = 'void glMultiTexCoord4svARB (GLenum target, const GLshort *v);',
glGenQueriesARB = 'void glGenQueriesARB (GLsizei n, GLuint *ids);',
glDeleteQueriesARB = 'void glDeleteQueriesARB (GLsizei n, const GLuint *ids);',
glIsQueryARB = 'GLboolean glIsQueryARB (GLuint id);',
glBeginQueryARB = 'void glBeginQueryARB (GLenum target, GLuint id);',
glEndQueryARB = 'void glEndQueryARB (GLenum target);',
glGetQueryivARB = 'void glGetQueryivARB (GLenum target, GLenum pname, GLint *params);',
glGetQueryObjectivARB = 'void glGetQueryObjectivARB (GLuint id, GLenum pname, GLint *params);',
glGetQueryObjectuivARB = 'void glGetQueryObjectuivARB (GLuint id, GLenum pname, GLuint *params);',
glMaxShaderCompilerThreadsARB = 'void glMaxShaderCompilerThreadsARB (GLuint count);',
glPointParameterfARB = 'void glPointParameterfARB (GLenum pname, GLfloat param);',
glPointParameterfvARB = 'void glPointParameterfvARB (GLenum pname, const GLfloat *params);',
glGetGraphicsResetStatusARB = 'GLenum glGetGraphicsResetStatusARB (void);',
glGetnTexImageARB = 'void glGetnTexImageARB (GLenum target, GLint level, GLenum format, GLenum type, GLsizei bufSize, void *img);',
glReadnPixelsARB = 'void glReadnPixelsARB (GLint x, GLint y, GLsizei width, GLsizei height, GLenum format, GLenum type, GLsizei bufSize, void *data);',
glGetnCompressedTexImageARB = 'void glGetnCompressedTexImageARB (GLenum target, GLint lod, GLsizei bufSize, void *img);',
glGetnUniformfvARB = 'void glGetnUniformfvARB (GLuint program, GLint location, GLsizei bufSize, GLfloat *params);',
glGetnUniformivARB = 'void glGetnUniformivARB (GLuint program, GLint location, GLsizei bufSize, GLint *params);',
glGetnUniformuivARB = 'void glGetnUniformuivARB (GLuint program, GLint location, GLsizei bufSize, GLuint *params);',
glGetnUniformdvARB = 'void glGetnUniformdvARB (GLuint program, GLint location, GLsizei bufSize, GLdouble *params);',
glGetnMapdvARB = 'void glGetnMapdvARB (GLenum target, GLenum query, GLsizei bufSize, GLdouble *v);',
glGetnMapfvARB = 'void glGetnMapfvARB (GLenum target, GLenum query, GLsizei bufSize, GLfloat *v);',
glGetnMapivARB = 'void glGetnMapivARB (GLenum target, GLenum query, GLsizei bufSize, GLint *v);',
glGetnPixelMapfvARB = 'void glGetnPixelMapfvARB (GLenum map, GLsizei bufSize, GLfloat *values);',
glGetnPixelMapuivARB = 'void glGetnPixelMapuivARB (GLenum map, GLsizei bufSize, GLuint *values);',
glGetnPixelMapusvARB = 'void glGetnPixelMapusvARB (GLenum map, GLsizei bufSize, GLushort *values);',
glGetnPolygonStippleARB = 'void glGetnPolygonStippleARB (GLsizei bufSize, GLubyte *pattern);',
glGetnColorTableARB = 'void glGetnColorTableARB (GLenum target, GLenum format, GLenum type, GLsizei bufSize, void *table);',
glGetnConvolutionFilterARB = 'void glGetnConvolutionFilterARB (GLenum target, GLenum format, GLenum type, GLsizei bufSize, void *image);',
glGetnSeparableFilterARB = 'void glGetnSeparableFilterARB (GLenum target, GLenum format, GLenum type, GLsizei rowBufSize, void *row, GLsizei columnBufSize, void *column, void *span);',
glGetnHistogramARB = 'void glGetnHistogramARB (GLenum target, GLboolean reset, GLenum format, GLenum type, GLsizei bufSize, void *values);',
glGetnMinmaxARB = 'void glGetnMinmaxARB (GLenum target, GLboolean reset, GLenum format, GLenum type, GLsizei bufSize, void *values);',
glFramebufferSampleLocationsfvARB = 'void glFramebufferSampleLocationsfvARB (GLenum target, GLuint start, GLsizei count, const GLfloat *v);',
glNamedFramebufferSampleLocationsfvARB = 'void glNamedFramebufferSampleLocationsfvARB (GLuint framebuffer, GLuint start, GLsizei count, const GLfloat *v);',
glEvaluateDepthValuesARB = 'void glEvaluateDepthValuesARB (void);',
glMinSampleShadingARB = 'void glMinSampleShadingARB (GLfloat value);',
glDeleteObjectARB = 'void glDeleteObjectARB (GLhandleARB obj);',
glGetHandleARB = 'GLhandleARB glGetHandleARB (GLenum pname);',
glDetachObjectARB = 'void glDetachObjectARB (GLhandleARB containerObj, GLhandleARB attachedObj);',
glCreateShaderObjectARB = 'GLhandleARB glCreateShaderObjectARB (GLenum shaderType);',
glShaderSourceARB = 'void glShaderSourceARB (GLhandleARB shaderObj, GLsizei count, const GLcharARB **string, const GLint *length);',
glCompileShaderARB = 'void glCompileShaderARB (GLhandleARB shaderObj);',
glCreateProgramObjectARB = 'GLhandleARB glCreateProgramObjectARB (void);',
glAttachObjectARB = 'void glAttachObjectARB (GLhandleARB containerObj, GLhandleARB obj);',
glLinkProgramARB = 'void glLinkProgramARB (GLhandleARB programObj);',
glUseProgramObjectARB = 'void glUseProgramObjectARB (GLhandleARB programObj);',
glValidateProgramARB = 'void glValidateProgramARB (GLhandleARB programObj);',
glUniform1fARB = 'void glUniform1fARB (GLint location, GLfloat v0);',
glUniform2fARB = 'void glUniform2fARB (GLint location, GLfloat v0, GLfloat v1);',
glUniform3fARB = 'void glUniform3fARB (GLint location, GLfloat v0, GLfloat v1, GLfloat v2);',
glUniform4fARB = 'void glUniform4fARB (GLint location, GLfloat v0, GLfloat v1, GLfloat v2, GLfloat v3);',
glUniform1iARB = 'void glUniform1iARB (GLint location, GLint v0);',
glUniform2iARB = 'void glUniform2iARB (GLint location, GLint v0, GLint v1);',
glUniform3iARB = 'void glUniform3iARB (GLint location, GLint v0, GLint v1, GLint v2);',
glUniform4iARB = 'void glUniform4iARB (GLint location, GLint v0, GLint v1, GLint v2, GLint v3);',
glUniform1fvARB = 'void glUniform1fvARB (GLint location, GLsizei count, const GLfloat *value);',
glUniform2fvARB = 'void glUniform2fvARB (GLint location, GLsizei count, const GLfloat *value);',
glUniform3fvARB = 'void glUniform3fvARB (GLint location, GLsizei count, const GLfloat *value);',
glUniform4fvARB = 'void glUniform4fvARB (GLint location, GLsizei count, const GLfloat *value);',
glUniform1ivARB = 'void glUniform1ivARB (GLint location, GLsizei count, const GLint *value);',
glUniform2ivARB = 'void glUniform2ivARB (GLint location, GLsizei count, const GLint *value);',
glUniform3ivARB = 'void glUniform3ivARB (GLint location, GLsizei count, const GLint *value);',
glUniform4ivARB = 'void glUniform4ivARB (GLint location, GLsizei count, const GLint *value);',
glUniformMatrix2fvARB = 'void glUniformMatrix2fvARB (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);',
glUniformMatrix3fvARB = 'void glUniformMatrix3fvARB (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);',
glUniformMatrix4fvARB = 'void glUniformMatrix4fvARB (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);',
glGetObjectParameterfvARB = 'void glGetObjectParameterfvARB (GLhandleARB obj, GLenum pname, GLfloat *params);',
glGetObjectParameterivARB = 'void glGetObjectParameterivARB (GLhandleARB obj, GLenum pname, GLint *params);',
glGetInfoLogARB = 'void glGetInfoLogARB (GLhandleARB obj, GLsizei maxLength, GLsizei *length, GLcharARB *infoLog);',
glGetAttachedObjectsARB = 'void glGetAttachedObjectsARB (GLhandleARB containerObj, GLsizei maxCount, GLsizei *count, GLhandleARB *obj);',
glGetUniformLocationARB = 'GLint glGetUniformLocationARB (GLhandleARB programObj, const GLcharARB *name);',
glGetActiveUniformARB = 'void glGetActiveUniformARB (GLhandleARB programObj, GLuint index, GLsizei maxLength, GLsizei *length, GLint *size, GLenum *type, GLcharARB *name);',
glGetUniformfvARB = 'void glGetUniformfvARB (GLhandleARB programObj, GLint location, GLfloat *params);',
glGetUniformivARB = 'void glGetUniformivARB (GLhandleARB programObj, GLint location, GLint *params);',
glGetShaderSourceARB = 'void glGetShaderSourceARB (GLhandleARB obj, GLsizei maxLength, GLsizei *length, GLcharARB *source);',
glNamedStringARB = 'void glNamedStringARB (GLenum type, GLint namelen, const GLchar *name, GLint stringlen, const GLchar *string);',
glDeleteNamedStringARB = 'void glDeleteNamedStringARB (GLint namelen, const GLchar *name);',
glCompileShaderIncludeARB = 'void glCompileShaderIncludeARB (GLuint shader, GLsizei count, const GLchar *const*path, const GLint *length);',
glIsNamedStringARB = 'GLboolean glIsNamedStringARB (GLint namelen, const GLchar *name);',
glGetNamedStringARB = 'void glGetNamedStringARB (GLint namelen, const GLchar *name, GLsizei bufSize, GLint *stringlen, GLchar *string);',
glGetNamedStringivARB = 'void glGetNamedStringivARB (GLint namelen, const GLchar *name, GLenum pname, GLint *params);',
glBufferPageCommitmentARB = 'void glBufferPageCommitmentARB (GLenum target, GLintptr offset, GLsizeiptr size, GLboolean commit);',
glNamedBufferPageCommitmentEXT = 'void glNamedBufferPageCommitmentEXT (GLuint buffer, GLintptr offset, GLsizeiptr size, GLboolean commit);',
glNamedBufferPageCommitmentARB = 'void glNamedBufferPageCommitmentARB (GLuint buffer, GLintptr offset, GLsizeiptr size, GLboolean commit);',
glTexPageCommitmentARB = 'void glTexPageCommitmentARB (GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth, GLboolean commit);',
glTexBufferARB = 'void glTexBufferARB (GLenum target, GLenum internalformat, GLuint buffer);',
glCompressedTexImage3DARB = 'void glCompressedTexImage3DARB (GLenum target, GLint level, GLenum internalformat, GLsizei width, GLsizei height, GLsizei depth, GLint border, GLsizei imageSize, const void *data);',
glCompressedTexImage2DARB = 'void glCompressedTexImage2DARB (GLenum target, GLint level, GLenum internalformat, GLsizei width, GLsizei height, GLint border, GLsizei imageSize, const void *data);',
glCompressedTexImage1DARB = 'void glCompressedTexImage1DARB (GLenum target, GLint level, GLenum internalformat, GLsizei width, GLint border, GLsizei imageSize, const void *data);',
glCompressedTexSubImage3DARB = 'void glCompressedTexSubImage3DARB (GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth, GLenum format, GLsizei imageSize, const void *data);',
glCompressedTexSubImage2DARB = 'void glCompressedTexSubImage2DARB (GLenum target, GLint level, GLint xoffset, GLint yoffset, GLsizei width, GLsizei height, GLenum format, GLsizei imageSize, const void *data);',
glCompressedTexSubImage1DARB = 'void glCompressedTexSubImage1DARB (GLenum target, GLint level, GLint xoffset, GLsizei width, GLenum format, GLsizei imageSize, const void *data);',
glGetCompressedTexImageARB = 'void glGetCompressedTexImageARB (GLenum target, GLint level, void *img);',
glLoadTransposeMatrixfARB = 'void glLoadTransposeMatrixfARB (const GLfloat *m);',
glLoadTransposeMatrixdARB = 'void glLoadTransposeMatrixdARB (const GLdouble *m);',
glMultTransposeMatrixfARB = 'void glMultTransposeMatrixfARB (const GLfloat *m);',
glMultTransposeMatrixdARB = 'void glMultTransposeMatrixdARB (const GLdouble *m);',
glWeightbvARB = 'void glWeightbvARB (GLint size, const GLbyte *weights);',
glWeightsvARB = 'void glWeightsvARB (GLint size, const GLshort *weights);',
glWeightivARB = 'void glWeightivARB (GLint size, const GLint *weights);',
glWeightfvARB = 'void glWeightfvARB (GLint size, const GLfloat *weights);',
glWeightdvARB = 'void glWeightdvARB (GLint size, const GLdouble *weights);',
glWeightubvARB = 'void glWeightubvARB (GLint size, const GLubyte *weights);',
glWeightusvARB = 'void glWeightusvARB (GLint size, const GLushort *weights);',
glWeightuivARB = 'void glWeightuivARB (GLint size, const GLuint *weights);',
glWeightPointerARB = 'void glWeightPointerARB (GLint size, GLenum type, GLsizei stride, const void *pointer);',
glVertexBlendARB = 'void glVertexBlendARB (GLint count);',
glBindBufferARB = 'void glBindBufferARB (GLenum target, GLuint buffer);',
glDeleteBuffersARB = 'void glDeleteBuffersARB (GLsizei n, const GLuint *buffers);',
glGenBuffersARB = 'void glGenBuffersARB (GLsizei n, GLuint *buffers);',
glIsBufferARB = 'GLboolean glIsBufferARB (GLuint buffer);',
glBufferDataARB = 'void glBufferDataARB (GLenum target, GLsizeiptrARB size, const void *data, GLenum usage);',
glBufferSubDataARB = 'void glBufferSubDataARB (GLenum target, GLintptrARB offset, GLsizeiptrARB size, const void *data);',
glGetBufferSubDataARB = 'void glGetBufferSubDataARB (GLenum target, GLintptrARB offset, GLsizeiptrARB size, void *data);',
glMapBufferARB = 'void * glMapBufferARB (GLenum target, GLenum access);',
glUnmapBufferARB = 'GLboolean glUnmapBufferARB (GLenum target);',
glGetBufferParameterivARB = 'void glGetBufferParameterivARB (GLenum target, GLenum pname, GLint *params);',
glGetBufferPointervARB = 'void glGetBufferPointervARB (GLenum target, GLenum pname, void **params);',
glVertexAttrib1dARB = 'void glVertexAttrib1dARB (GLuint index, GLdouble x);',
glVertexAttrib1dvARB = 'void glVertexAttrib1dvARB (GLuint index, const GLdouble *v);',
glVertexAttrib1fARB = 'void glVertexAttrib1fARB (GLuint index, GLfloat x);',
glVertexAttrib1fvARB = 'void glVertexAttrib1fvARB (GLuint index, const GLfloat *v);',
glVertexAttrib1sARB = 'void glVertexAttrib1sARB (GLuint index, GLshort x);',
glVertexAttrib1svARB = 'void glVertexAttrib1svARB (GLuint index, const GLshort *v);',
glVertexAttrib2dARB = 'void glVertexAttrib2dARB (GLuint index, GLdouble x, GLdouble y);',
glVertexAttrib2dvARB = 'void glVertexAttrib2dvARB (GLuint index, const GLdouble *v);',
glVertexAttrib2fARB = 'void glVertexAttrib2fARB (GLuint index, GLfloat x, GLfloat y);',
glVertexAttrib2fvARB = 'void glVertexAttrib2fvARB (GLuint index, const GLfloat *v);',
glVertexAttrib2sARB = 'void glVertexAttrib2sARB (GLuint index, GLshort x, GLshort y);',
glVertexAttrib2svARB = 'void glVertexAttrib2svARB (GLuint index, const GLshort *v);',
glVertexAttrib3dARB = 'void glVertexAttrib3dARB (GLuint index, GLdouble x, GLdouble y, GLdouble z);',
glVertexAttrib3dvARB = 'void glVertexAttrib3dvARB (GLuint index, const GLdouble *v);',
glVertexAttrib3fARB = 'void glVertexAttrib3fARB (GLuint index, GLfloat x, GLfloat y, GLfloat z);',
glVertexAttrib3fvARB = 'void glVertexAttrib3fvARB (GLuint index, const GLfloat *v);',
glVertexAttrib3sARB = 'void glVertexAttrib3sARB (GLuint index, GLshort x, GLshort y, GLshort z);',
glVertexAttrib3svARB = 'void glVertexAttrib3svARB (GLuint index, const GLshort *v);',
glVertexAttrib4NbvARB = 'void glVertexAttrib4NbvARB (GLuint index, const GLbyte *v);',
glVertexAttrib4NivARB = 'void glVertexAttrib4NivARB (GLuint index, const GLint *v);',
glVertexAttrib4NsvARB = 'void glVertexAttrib4NsvARB (GLuint index, const GLshort *v);',
glVertexAttrib4NubARB = 'void glVertexAttrib4NubARB (GLuint index, GLubyte x, GLubyte y, GLubyte z, GLubyte w);',
glVertexAttrib4NubvARB = 'void glVertexAttrib4NubvARB (GLuint index, const GLubyte *v);',
glVertexAttrib4NuivARB = 'void glVertexAttrib4NuivARB (GLuint index, const GLuint *v);',
glVertexAttrib4NusvARB = 'void glVertexAttrib4NusvARB (GLuint index, const GLushort *v);',
glVertexAttrib4bvARB = 'void glVertexAttrib4bvARB (GLuint index, const GLbyte *v);',
glVertexAttrib4dARB = 'void glVertexAttrib4dARB (GLuint index, GLdouble x, GLdouble y, GLdouble z, GLdouble w);',
glVertexAttrib4dvARB = 'void glVertexAttrib4dvARB (GLuint index, const GLdouble *v);',
glVertexAttrib4fARB = 'void glVertexAttrib4fARB (GLuint index, GLfloat x, GLfloat y, GLfloat z, GLfloat w);',
glVertexAttrib4fvARB = 'void glVertexAttrib4fvARB (GLuint index, const GLfloat *v);',
glVertexAttrib4ivARB = 'void glVertexAttrib4ivARB (GLuint index, const GLint *v);',
glVertexAttrib4sARB = 'void glVertexAttrib4sARB (GLuint index, GLshort x, GLshort y, GLshort z, GLshort w);',
glVertexAttrib4svARB = 'void glVertexAttrib4svARB (GLuint index, const GLshort *v);',
glVertexAttrib4ubvARB = 'void glVertexAttrib4ubvARB (GLuint index, const GLubyte *v);',
glVertexAttrib4uivARB = 'void glVertexAttrib4uivARB (GLuint index, const GLuint *v);',
glVertexAttrib4usvARB = 'void glVertexAttrib4usvARB (GLuint index, const GLushort *v);',
glVertexAttribPointerARB = 'void glVertexAttribPointerARB (GLuint index, GLint size, GLenum type, GLboolean normalized, GLsizei stride, const void *pointer);',
glEnableVertexAttribArrayARB = 'void glEnableVertexAttribArrayARB (GLuint index);',
glDisableVertexAttribArrayARB = 'void glDisableVertexAttribArrayARB (GLuint index);',
glGetVertexAttribdvARB = 'void glGetVertexAttribdvARB (GLuint index, GLenum pname, GLdouble *params);',
glGetVertexAttribfvARB = 'void glGetVertexAttribfvARB (GLuint index, GLenum pname, GLfloat *params);',
glGetVertexAttribivARB = 'void glGetVertexAttribivARB (GLuint index, GLenum pname, GLint *params);',
glGetVertexAttribPointervARB = 'void glGetVertexAttribPointervARB (GLuint index, GLenum pname, void **pointer);',
glBindAttribLocationARB = 'void glBindAttribLocationARB (GLhandleARB programObj, GLuint index, const GLcharARB *name);',
glGetActiveAttribARB = 'void glGetActiveAttribARB (GLhandleARB programObj, GLuint index, GLsizei maxLength, GLsizei *length, GLint *size, GLenum *type, GLcharARB *name);',
glGetAttribLocationARB = 'GLint glGetAttribLocationARB (GLhandleARB programObj, const GLcharARB *name);',
glDepthRangeArraydvNV = 'void glDepthRangeArraydvNV (GLuint first, GLsizei count, const GLdouble *v);',
glDepthRangeIndexeddNV = 'void glDepthRangeIndexeddNV (GLuint index, GLdouble n, GLdouble f);',
glWindowPos2dARB = 'void glWindowPos2dARB (GLdouble x, GLdouble y);',
glWindowPos2dvARB = 'void glWindowPos2dvARB (const GLdouble *v);',
glWindowPos2fARB = 'void glWindowPos2fARB (GLfloat x, GLfloat y);',
glWindowPos2fvARB = 'void glWindowPos2fvARB (const GLfloat *v);',
glWindowPos2iARB = 'void glWindowPos2iARB (GLint x, GLint y);',
glWindowPos2ivARB = 'void glWindowPos2ivARB (const GLint *v);',
glWindowPos2sARB = 'void glWindowPos2sARB (GLshort x, GLshort y);',
glWindowPos2svARB = 'void glWindowPos2svARB (const GLshort *v);',
glWindowPos3dARB = 'void glWindowPos3dARB (GLdouble x, GLdouble y, GLdouble z);',
glWindowPos3dvARB = 'void glWindowPos3dvARB (const GLdouble *v);',
glWindowPos3fARB = 'void glWindowPos3fARB (GLfloat x, GLfloat y, GLfloat z);',
glWindowPos3fvARB = 'void glWindowPos3fvARB (const GLfloat *v);',
glWindowPos3iARB = 'void glWindowPos3iARB (GLint x, GLint y, GLint z);',
glWindowPos3ivARB = 'void glWindowPos3ivARB (const GLint *v);',
glWindowPos3sARB = 'void glWindowPos3sARB (GLshort x, GLshort y, GLshort z);',
glWindowPos3svARB = 'void glWindowPos3svARB (const GLshort *v);',
glBlendBarrierKHR = 'void glBlendBarrierKHR (void);',
glMaxShaderCompilerThreadsKHR = 'void glMaxShaderCompilerThreadsKHR (GLuint count);',
glMultiTexCoord1bOES = 'void glMultiTexCoord1bOES (GLenum texture, GLbyte s);',
glMultiTexCoord1bvOES = 'void glMultiTexCoord1bvOES (GLenum texture, const GLbyte *coords);',
glMultiTexCoord2bOES = 'void glMultiTexCoord2bOES (GLenum texture, GLbyte s, GLbyte t);',
glMultiTexCoord2bvOES = 'void glMultiTexCoord2bvOES (GLenum texture, const GLbyte *coords);',
glMultiTexCoord3bOES = 'void glMultiTexCoord3bOES (GLenum texture, GLbyte s, GLbyte t, GLbyte r);',
glMultiTexCoord3bvOES = 'void glMultiTexCoord3bvOES (GLenum texture, const GLbyte *coords);',
glMultiTexCoord4bOES = 'void glMultiTexCoord4bOES (GLenum texture, GLbyte s, GLbyte t, GLbyte r, GLbyte q);',
glMultiTexCoord4bvOES = 'void glMultiTexCoord4bvOES (GLenum texture, const GLbyte *coords);',
glTexCoord1bOES = 'void glTexCoord1bOES (GLbyte s);',
glTexCoord1bvOES = 'void glTexCoord1bvOES (const GLbyte *coords);',
glTexCoord2bOES = 'void glTexCoord2bOES (GLbyte s, GLbyte t);',
glTexCoord2bvOES = 'void glTexCoord2bvOES (const GLbyte *coords);',
glTexCoord3bOES = 'void glTexCoord3bOES (GLbyte s, GLbyte t, GLbyte r);',
glTexCoord3bvOES = 'void glTexCoord3bvOES (const GLbyte *coords);',
glTexCoord4bOES = 'void glTexCoord4bOES (GLbyte s, GLbyte t, GLbyte r, GLbyte q);',
glTexCoord4bvOES = 'void glTexCoord4bvOES (const GLbyte *coords);',
glVertex2bOES = 'void glVertex2bOES (GLbyte x, GLbyte y);',
glVertex2bvOES = 'void glVertex2bvOES (const GLbyte *coords);',
glVertex3bOES = 'void glVertex3bOES (GLbyte x, GLbyte y, GLbyte z);',
glVertex3bvOES = 'void glVertex3bvOES (const GLbyte *coords);',
glVertex4bOES = 'void glVertex4bOES (GLbyte x, GLbyte y, GLbyte z, GLbyte w);',
glVertex4bvOES = 'void glVertex4bvOES (const GLbyte *coords);',
glAlphaFuncxOES = 'void glAlphaFuncxOES (GLenum func, GLfixed ref);',
glClearColorxOES = 'void glClearColorxOES (GLfixed red, GLfixed green, GLfixed blue, GLfixed alpha);',
glClearDepthxOES = 'void glClearDepthxOES (GLfixed depth);',
glClipPlanexOES = 'void glClipPlanexOES (GLenum plane, const GLfixed *equation);',
glColor4xOES = 'void glColor4xOES (GLfixed red, GLfixed green, GLfixed blue, GLfixed alpha);',
glDepthRangexOES = 'void glDepthRangexOES (GLfixed n, GLfixed f);',
glFogxOES = 'void glFogxOES (GLenum pname, GLfixed param);',
glFogxvOES = 'void glFogxvOES (GLenum pname, const GLfixed *param);',
glFrustumxOES = 'void glFrustumxOES (GLfixed l, GLfixed r, GLfixed b, GLfixed t, GLfixed n, GLfixed f);',
glGetClipPlanexOES = 'void glGetClipPlanexOES (GLenum plane, GLfixed *equation);',
glGetFixedvOES = 'void glGetFixedvOES (GLenum pname, GLfixed *params);',
glGetTexEnvxvOES = 'void glGetTexEnvxvOES (GLenum target, GLenum pname, GLfixed *params);',
glGetTexParameterxvOES = 'void glGetTexParameterxvOES (GLenum target, GLenum pname, GLfixed *params);',
glLightModelxOES = 'void glLightModelxOES (GLenum pname, GLfixed param);',
glLightModelxvOES = 'void glLightModelxvOES (GLenum pname, const GLfixed *param);',
glLightxOES = 'void glLightxOES (GLenum light, GLenum pname, GLfixed param);',
glLightxvOES = 'void glLightxvOES (GLenum light, GLenum pname, const GLfixed *params);',
glLineWidthxOES = 'void glLineWidthxOES (GLfixed width);',
glLoadMatrixxOES = 'void glLoadMatrixxOES (const GLfixed *m);',
glMaterialxOES = 'void glMaterialxOES (GLenum face, GLenum pname, GLfixed param);',
glMaterialxvOES = 'void glMaterialxvOES (GLenum face, GLenum pname, const GLfixed *param);',
glMultMatrixxOES = 'void glMultMatrixxOES (const GLfixed *m);',
glMultiTexCoord4xOES = 'void glMultiTexCoord4xOES (GLenum texture, GLfixed s, GLfixed t, GLfixed r, GLfixed q);',
glNormal3xOES = 'void glNormal3xOES (GLfixed nx, GLfixed ny, GLfixed nz);',
glOrthoxOES = 'void glOrthoxOES (GLfixed l, GLfixed r, GLfixed b, GLfixed t, GLfixed n, GLfixed f);',
glPointParameterxvOES = 'void glPointParameterxvOES (GLenum pname, const GLfixed *params);',
glPointSizexOES = 'void glPointSizexOES (GLfixed size);',
glPolygonOffsetxOES = 'void glPolygonOffsetxOES (GLfixed factor, GLfixed units);',
glRotatexOES = 'void glRotatexOES (GLfixed angle, GLfixed x, GLfixed y, GLfixed z);',
glScalexOES = 'void glScalexOES (GLfixed x, GLfixed y, GLfixed z);',
glTexEnvxOES = 'void glTexEnvxOES (GLenum target, GLenum pname, GLfixed param);',
glTexEnvxvOES = 'void glTexEnvxvOES (GLenum target, GLenum pname, const GLfixed *params);',
glTexParameterxOES = 'void glTexParameterxOES (GLenum target, GLenum pname, GLfixed param);',
glTexParameterxvOES = 'void glTexParameterxvOES (GLenum target, GLenum pname, const GLfixed *params);',
glTranslatexOES = 'void glTranslatexOES (GLfixed x, GLfixed y, GLfixed z);',
glAccumxOES = 'void glAccumxOES (GLenum op, GLfixed value);',
glBitmapxOES = 'void glBitmapxOES (GLsizei width, GLsizei height, GLfixed xorig, GLfixed yorig, GLfixed xmove, GLfixed ymove, const GLubyte *bitmap);',
glBlendColorxOES = 'void glBlendColorxOES (GLfixed red, GLfixed green, GLfixed blue, GLfixed alpha);',
glClearAccumxOES = 'void glClearAccumxOES (GLfixed red, GLfixed green, GLfixed blue, GLfixed alpha);',
glColor3xOES = 'void glColor3xOES (GLfixed red, GLfixed green, GLfixed blue);',
glColor3xvOES = 'void glColor3xvOES (const GLfixed *components);',
glColor4xvOES = 'void glColor4xvOES (const GLfixed *components);',
glConvolutionParameterxOES = 'void glConvolutionParameterxOES (GLenum target, GLenum pname, GLfixed param);',
glConvolutionParameterxvOES = 'void glConvolutionParameterxvOES (GLenum target, GLenum pname, const GLfixed *params);',
glEvalCoord1xOES = 'void glEvalCoord1xOES (GLfixed u);',
glEvalCoord1xvOES = 'void glEvalCoord1xvOES (const GLfixed *coords);',
glEvalCoord2xOES = 'void glEvalCoord2xOES (GLfixed u, GLfixed v);',
glEvalCoord2xvOES = 'void glEvalCoord2xvOES (const GLfixed *coords);',
glFeedbackBufferxOES = 'void glFeedbackBufferxOES (GLsizei n, GLenum type, const GLfixed *buffer);',
glGetConvolutionParameterxvOES = 'void glGetConvolutionParameterxvOES (GLenum target, GLenum pname, GLfixed *params);',
glGetHistogramParameterxvOES = 'void glGetHistogramParameterxvOES (GLenum target, GLenum pname, GLfixed *params);',
glGetLightxOES = 'void glGetLightxOES (GLenum light, GLenum pname, GLfixed *params);',
glGetMapxvOES = 'void glGetMapxvOES (GLenum target, GLenum query, GLfixed *v);',
glGetMaterialxOES = 'void glGetMaterialxOES (GLenum face, GLenum pname, GLfixed param);',
glGetPixelMapxv = 'void glGetPixelMapxv (GLenum map, GLint size, GLfixed *values);',
glGetTexGenxvOES = 'void glGetTexGenxvOES (GLenum coord, GLenum pname, GLfixed *params);',
glGetTexLevelParameterxvOES = 'void glGetTexLevelParameterxvOES (GLenum target, GLint level, GLenum pname, GLfixed *params);',
glIndexxOES = 'void glIndexxOES (GLfixed component);',
glIndexxvOES = 'void glIndexxvOES (const GLfixed *component);',
glLoadTransposeMatrixxOES = 'void glLoadTransposeMatrixxOES (const GLfixed *m);',
glMap1xOES = 'void glMap1xOES (GLenum target, GLfixed u1, GLfixed u2, GLint stride, GLint order, GLfixed points);',
glMap2xOES = 'void glMap2xOES (GLenum target, GLfixed u1, GLfixed u2, GLint ustride, GLint uorder, GLfixed v1, GLfixed v2, GLint vstride, GLint vorder, GLfixed points);',
glMapGrid1xOES = 'void glMapGrid1xOES (GLint n, GLfixed u1, GLfixed u2);',
glMapGrid2xOES = 'void glMapGrid2xOES (GLint n, GLfixed u1, GLfixed u2, GLfixed v1, GLfixed v2);',
glMultTransposeMatrixxOES = 'void glMultTransposeMatrixxOES (const GLfixed *m);',
glMultiTexCoord1xOES = 'void glMultiTexCoord1xOES (GLenum texture, GLfixed s);',
glMultiTexCoord1xvOES = 'void glMultiTexCoord1xvOES (GLenum texture, const GLfixed *coords);',
glMultiTexCoord2xOES = 'void glMultiTexCoord2xOES (GLenum texture, GLfixed s, GLfixed t);',
glMultiTexCoord2xvOES = 'void glMultiTexCoord2xvOES (GLenum texture, const GLfixed *coords);',
glMultiTexCoord3xOES = 'void glMultiTexCoord3xOES (GLenum texture, GLfixed s, GLfixed t, GLfixed r);',
glMultiTexCoord3xvOES = 'void glMultiTexCoord3xvOES (GLenum texture, const GLfixed *coords);',
glMultiTexCoord4xvOES = 'void glMultiTexCoord4xvOES (GLenum texture, const GLfixed *coords);',
glNormal3xvOES = 'void glNormal3xvOES (const GLfixed *coords);',
glPassThroughxOES = 'void glPassThroughxOES (GLfixed token);',
glPixelMapx = 'void glPixelMapx (GLenum map, GLint size, const GLfixed *values);',
glPixelStorex = 'void glPixelStorex (GLenum pname, GLfixed param);',
glPixelTransferxOES = 'void glPixelTransferxOES (GLenum pname, GLfixed param);',
glPixelZoomxOES = 'void glPixelZoomxOES (GLfixed xfactor, GLfixed yfactor);',
glPrioritizeTexturesxOES = 'void glPrioritizeTexturesxOES (GLsizei n, const GLuint *textures, const GLfixed *priorities);',
glRasterPos2xOES = 'void glRasterPos2xOES (GLfixed x, GLfixed y);',
glRasterPos2xvOES = 'void glRasterPos2xvOES (const GLfixed *coords);',
glRasterPos3xOES = 'void glRasterPos3xOES (GLfixed x, GLfixed y, GLfixed z);',
glRasterPos3xvOES = 'void glRasterPos3xvOES (const GLfixed *coords);',
glRasterPos4xOES = 'void glRasterPos4xOES (GLfixed x, GLfixed y, GLfixed z, GLfixed w);',
glRasterPos4xvOES = 'void glRasterPos4xvOES (const GLfixed *coords);',
glRectxOES = 'void glRectxOES (GLfixed x1, GLfixed y1, GLfixed x2, GLfixed y2);',
glRectxvOES = 'void glRectxvOES (const GLfixed *v1, const GLfixed *v2);',
glTexCoord1xOES = 'void glTexCoord1xOES (GLfixed s);',
glTexCoord1xvOES = 'void glTexCoord1xvOES (const GLfixed *coords);',
glTexCoord2xOES = 'void glTexCoord2xOES (GLfixed s, GLfixed t);',
glTexCoord2xvOES = 'void glTexCoord2xvOES (const GLfixed *coords);',
glTexCoord3xOES = 'void glTexCoord3xOES (GLfixed s, GLfixed t, GLfixed r);',
glTexCoord3xvOES = 'void glTexCoord3xvOES (const GLfixed *coords);',
glTexCoord4xOES = 'void glTexCoord4xOES (GLfixed s, GLfixed t, GLfixed r, GLfixed q);',
glTexCoord4xvOES = 'void glTexCoord4xvOES (const GLfixed *coords);',
glTexGenxOES = 'void glTexGenxOES (GLenum coord, GLenum pname, GLfixed param);',
glTexGenxvOES = 'void glTexGenxvOES (GLenum coord, GLenum pname, const GLfixed *params);',
glVertex2xOES = 'void glVertex2xOES (GLfixed x);',
glVertex2xvOES = 'void glVertex2xvOES (const GLfixed *coords);',
glVertex3xOES = 'void glVertex3xOES (GLfixed x, GLfixed y);',
glVertex3xvOES = 'void glVertex3xvOES (const GLfixed *coords);',
glVertex4xOES = 'void glVertex4xOES (GLfixed x, GLfixed y, GLfixed z);',
glVertex4xvOES = 'void glVertex4xvOES (const GLfixed *coords);',
glQueryMatrixxOES = 'GLbitfield glQueryMatrixxOES (GLfixed *mantissa, GLint *exponent);',
glClearDepthfOES = 'void glClearDepthfOES (GLclampf depth);',
glClipPlanefOES = 'void glClipPlanefOES (GLenum plane, const GLfloat *equation);',
glDepthRangefOES = 'void glDepthRangefOES (GLclampf n, GLclampf f);',
glFrustumfOES = 'void glFrustumfOES (GLfloat l, GLfloat r, GLfloat b, GLfloat t, GLfloat n, GLfloat f);',
glGetClipPlanefOES = 'void glGetClipPlanefOES (GLenum plane, GLfloat *equation);',
glOrthofOES = 'void glOrthofOES (GLfloat l, GLfloat r, GLfloat b, GLfloat t, GLfloat n, GLfloat f);',
glTbufferMask3DFX = 'void glTbufferMask3DFX (GLuint mask);',
glDebugMessageEnableAMD = 'void glDebugMessageEnableAMD (GLenum category, GLenum severity, GLsizei count, const GLuint *ids, GLboolean enabled);',
glDebugMessageInsertAMD = 'void glDebugMessageInsertAMD (GLenum category, GLenum severity, GLuint id, GLsizei length, const GLchar *buf);',
glDebugMessageCallbackAMD = 'void glDebugMessageCallbackAMD (GLDEBUGPROCAMD callback, void *userParam);',
glGetDebugMessageLogAMD = 'GLuint glGetDebugMessageLogAMD (GLuint count, GLsizei bufSize, GLenum *categories, GLuint *severities, GLuint *ids, GLsizei *lengths, GLchar *message);',
glBlendFuncIndexedAMD = 'void glBlendFuncIndexedAMD (GLuint buf, GLenum src, GLenum dst);',
glBlendFuncSeparateIndexedAMD = 'void glBlendFuncSeparateIndexedAMD (GLuint buf, GLenum srcRGB, GLenum dstRGB, GLenum srcAlpha, GLenum dstAlpha);',
glBlendEquationIndexedAMD = 'void glBlendEquationIndexedAMD (GLuint buf, GLenum mode);',
glBlendEquationSeparateIndexedAMD = 'void glBlendEquationSeparateIndexedAMD (GLuint buf, GLenum modeRGB, GLenum modeAlpha);',
glRenderbufferStorageMultisampleAdvancedAMD = 'void glRenderbufferStorageMultisampleAdvancedAMD (GLenum target, GLsizei samples, GLsizei storageSamples, GLenum internalformat, GLsizei width, GLsizei height);',
glNamedRenderbufferStorageMultisampleAdvancedAMD = 'void glNamedRenderbufferStorageMultisampleAdvancedAMD (GLuint renderbuffer, GLsizei samples, GLsizei storageSamples, GLenum internalformat, GLsizei width, GLsizei height);',
glFramebufferSamplePositionsfvAMD = 'void glFramebufferSamplePositionsfvAMD (GLenum target, GLuint numsamples, GLuint pixelindex, const GLfloat *values);',
glNamedFramebufferSamplePositionsfvAMD = 'void glNamedFramebufferSamplePositionsfvAMD (GLuint framebuffer, GLuint numsamples, GLuint pixelindex, const GLfloat *values);',
glGetFramebufferParameterfvAMD = 'void glGetFramebufferParameterfvAMD (GLenum target, GLenum pname, GLuint numsamples, GLuint pixelindex, GLsizei size, GLfloat *values);',
glGetNamedFramebufferParameterfvAMD = 'void glGetNamedFramebufferParameterfvAMD (GLuint framebuffer, GLenum pname, GLuint numsamples, GLuint pixelindex, GLsizei size, GLfloat *values);',
glUniform1i64NV = 'void glUniform1i64NV (GLint location, GLint64EXT x);',
glUniform2i64NV = 'void glUniform2i64NV (GLint location, GLint64EXT x, GLint64EXT y);',
glUniform3i64NV = 'void glUniform3i64NV (GLint location, GLint64EXT x, GLint64EXT y, GLint64EXT z);',
glUniform4i64NV = 'void glUniform4i64NV (GLint location, GLint64EXT x, GLint64EXT y, GLint64EXT z, GLint64EXT w);',
glUniform1i64vNV = 'void glUniform1i64vNV (GLint location, GLsizei count, const GLint64EXT *value);',
glUniform2i64vNV = 'void glUniform2i64vNV (GLint location, GLsizei count, const GLint64EXT *value);',
glUniform3i64vNV = 'void glUniform3i64vNV (GLint location, GLsizei count, const GLint64EXT *value);',
glUniform4i64vNV = 'void glUniform4i64vNV (GLint location, GLsizei count, const GLint64EXT *value);',
glUniform1ui64NV = 'void glUniform1ui64NV (GLint location, GLuint64EXT x);',
glUniform2ui64NV = 'void glUniform2ui64NV (GLint location, GLuint64EXT x, GLuint64EXT y);',
glUniform3ui64NV = 'void glUniform3ui64NV (GLint location, GLuint64EXT x, GLuint64EXT y, GLuint64EXT z);',
glUniform4ui64NV = 'void glUniform4ui64NV (GLint location, GLuint64EXT x, GLuint64EXT y, GLuint64EXT z, GLuint64EXT w);',
glUniform1ui64vNV = 'void glUniform1ui64vNV (GLint location, GLsizei count, const GLuint64EXT *value);',
glUniform2ui64vNV = 'void glUniform2ui64vNV (GLint location, GLsizei count, const GLuint64EXT *value);',
glUniform3ui64vNV = 'void glUniform3ui64vNV (GLint location, GLsizei count, const GLuint64EXT *value);',
glUniform4ui64vNV = 'void glUniform4ui64vNV (GLint location, GLsizei count, const GLuint64EXT *value);',
glGetUniformi64vNV = 'void glGetUniformi64vNV (GLuint program, GLint location, GLint64EXT *params);',
glGetUniformui64vNV = 'void glGetUniformui64vNV (GLuint program, GLint location, GLuint64EXT *params);',
glProgramUniform1i64NV = 'void glProgramUniform1i64NV (GLuint program, GLint location, GLint64EXT x);',
glProgramUniform2i64NV = 'void glProgramUniform2i64NV (GLuint program, GLint location, GLint64EXT x, GLint64EXT y);',
glProgramUniform3i64NV = 'void glProgramUniform3i64NV (GLuint program, GLint location, GLint64EXT x, GLint64EXT y, GLint64EXT z);',
glProgramUniform4i64NV = 'void glProgramUniform4i64NV (GLuint program, GLint location, GLint64EXT x, GLint64EXT y, GLint64EXT z, GLint64EXT w);',
glProgramUniform1i64vNV = 'void glProgramUniform1i64vNV (GLuint program, GLint location, GLsizei count, const GLint64EXT *value);',
glProgramUniform2i64vNV = 'void glProgramUniform2i64vNV (GLuint program, GLint location, GLsizei count, const GLint64EXT *value);',
glProgramUniform3i64vNV = 'void glProgramUniform3i64vNV (GLuint program, GLint location, GLsizei count, const GLint64EXT *value);',
glProgramUniform4i64vNV = 'void glProgramUniform4i64vNV (GLuint program, GLint location, GLsizei count, const GLint64EXT *value);',
glProgramUniform1ui64NV = 'void glProgramUniform1ui64NV (GLuint program, GLint location, GLuint64EXT x);',
glProgramUniform2ui64NV = 'void glProgramUniform2ui64NV (GLuint program, GLint location, GLuint64EXT x, GLuint64EXT y);',
glProgramUniform3ui64NV = 'void glProgramUniform3ui64NV (GLuint program, GLint location, GLuint64EXT x, GLuint64EXT y, GLuint64EXT z);',
glProgramUniform4ui64NV = 'void glProgramUniform4ui64NV (GLuint program, GLint location, GLuint64EXT x, GLuint64EXT y, GLuint64EXT z, GLuint64EXT w);',
glProgramUniform1ui64vNV = 'void glProgramUniform1ui64vNV (GLuint program, GLint location, GLsizei count, const GLuint64EXT *value);',
glProgramUniform2ui64vNV = 'void glProgramUniform2ui64vNV (GLuint program, GLint location, GLsizei count, const GLuint64EXT *value);',
glProgramUniform3ui64vNV = 'void glProgramUniform3ui64vNV (GLuint program, GLint location, GLsizei count, const GLuint64EXT *value);',
glProgramUniform4ui64vNV = 'void glProgramUniform4ui64vNV (GLuint program, GLint location, GLsizei count, const GLuint64EXT *value);',
glVertexAttribParameteriAMD = 'void glVertexAttribParameteriAMD (GLuint index, GLenum pname, GLint param);',
glMultiDrawArraysIndirectAMD = 'void glMultiDrawArraysIndirectAMD (GLenum mode, const void *indirect, GLsizei primcount, GLsizei stride);',
glMultiDrawElementsIndirectAMD = 'void glMultiDrawElementsIndirectAMD (GLenum mode, GLenum type, const void *indirect, GLsizei primcount, GLsizei stride);',
glGenNamesAMD = 'void glGenNamesAMD (GLenum identifier, GLuint num, GLuint *names);',
glDeleteNamesAMD = 'void glDeleteNamesAMD (GLenum identifier, GLuint num, const GLuint *names);',
glIsNameAMD = 'GLboolean glIsNameAMD (GLenum identifier, GLuint name);',
glQueryObjectParameteruiAMD = 'void glQueryObjectParameteruiAMD (GLenum target, GLuint id, GLenum pname, GLuint param);',
glGetPerfMonitorGroupsAMD = 'void glGetPerfMonitorGroupsAMD (GLint *numGroups, GLsizei groupsSize, GLuint *groups);',
glGetPerfMonitorCountersAMD = 'void glGetPerfMonitorCountersAMD (GLuint group, GLint *numCounters, GLint *maxActiveCounters, GLsizei counterSize, GLuint *counters);',
glGetPerfMonitorGroupStringAMD = 'void glGetPerfMonitorGroupStringAMD (GLuint group, GLsizei bufSize, GLsizei *length, GLchar *groupString);',
glGetPerfMonitorCounterStringAMD = 'void glGetPerfMonitorCounterStringAMD (GLuint group, GLuint counter, GLsizei bufSize, GLsizei *length, GLchar *counterString);',
glGetPerfMonitorCounterInfoAMD = 'void glGetPerfMonitorCounterInfoAMD (GLuint group, GLuint counter, GLenum pname, void *data);',
glGenPerfMonitorsAMD = 'void glGenPerfMonitorsAMD (GLsizei n, GLuint *monitors);',
glDeletePerfMonitorsAMD = 'void glDeletePerfMonitorsAMD (GLsizei n, GLuint *monitors);',
glSelectPerfMonitorCountersAMD = 'void glSelectPerfMonitorCountersAMD (GLuint monitor, GLboolean enable, GLuint group, GLint numCounters, GLuint *counterList);',
glBeginPerfMonitorAMD = 'void glBeginPerfMonitorAMD (GLuint monitor);',
glEndPerfMonitorAMD = 'void glEndPerfMonitorAMD (GLuint monitor);',
glGetPerfMonitorCounterDataAMD = 'void glGetPerfMonitorCounterDataAMD (GLuint monitor, GLenum pname, GLsizei dataSize, GLuint *data, GLint *bytesWritten);',
glSetMultisamplefvAMD = 'void glSetMultisamplefvAMD (GLenum pname, GLuint index, const GLfloat *val);',
glTexStorageSparseAMD = 'void glTexStorageSparseAMD (GLenum target, GLenum internalFormat, GLsizei width, GLsizei height, GLsizei depth, GLsizei layers, GLbitfield flags);',
glTextureStorageSparseAMD = 'void glTextureStorageSparseAMD (GLuint texture, GLenum target, GLenum internalFormat, GLsizei width, GLsizei height, GLsizei depth, GLsizei layers, GLbitfield flags);',
glStencilOpValueAMD = 'void glStencilOpValueAMD (GLenum face, GLuint value);',
glTessellationFactorAMD = 'void glTessellationFactorAMD (GLfloat factor);',
glTessellationModeAMD = 'void glTessellationModeAMD (GLenum mode);',
glElementPointerAPPLE = 'void glElementPointerAPPLE (GLenum type, const void *pointer);',
glDrawElementArrayAPPLE = 'void glDrawElementArrayAPPLE (GLenum mode, GLint first, GLsizei count);',
glDrawRangeElementArrayAPPLE = 'void glDrawRangeElementArrayAPPLE (GLenum mode, GLuint start, GLuint end, GLint first, GLsizei count);',
glMultiDrawElementArrayAPPLE = 'void glMultiDrawElementArrayAPPLE (GLenum mode, const GLint *first, const GLsizei *count, GLsizei primcount);',
glMultiDrawRangeElementArrayAPPLE = 'void glMultiDrawRangeElementArrayAPPLE (GLenum mode, GLuint start, GLuint end, const GLint *first, const GLsizei *count, GLsizei primcount);',
glGenFencesAPPLE = 'void glGenFencesAPPLE (GLsizei n, GLuint *fences);',
glDeleteFencesAPPLE = 'void glDeleteFencesAPPLE (GLsizei n, const GLuint *fences);',
glSetFenceAPPLE = 'void glSetFenceAPPLE (GLuint fence);',
glIsFenceAPPLE = 'GLboolean glIsFenceAPPLE (GLuint fence);',
glTestFenceAPPLE = 'GLboolean glTestFenceAPPLE (GLuint fence);',
glFinishFenceAPPLE = 'void glFinishFenceAPPLE (GLuint fence);',
glTestObjectAPPLE = 'GLboolean glTestObjectAPPLE (GLenum object, GLuint name);',
glFinishObjectAPPLE = 'void glFinishObjectAPPLE (GLenum object, GLint name);',
glBufferParameteriAPPLE = 'void glBufferParameteriAPPLE (GLenum target, GLenum pname, GLint param);',
glFlushMappedBufferRangeAPPLE = 'void glFlushMappedBufferRangeAPPLE (GLenum target, GLintptr offset, GLsizeiptr size);',
glObjectPurgeableAPPLE = 'GLenum glObjectPurgeableAPPLE (GLenum objectType, GLuint name, GLenum option);',
glObjectUnpurgeableAPPLE = 'GLenum glObjectUnpurgeableAPPLE (GLenum objectType, GLuint name, GLenum option);',
glGetObjectParameterivAPPLE = 'void glGetObjectParameterivAPPLE (GLenum objectType, GLuint name, GLenum pname, GLint *params);',
glTextureRangeAPPLE = 'void glTextureRangeAPPLE (GLenum target, GLsizei length, const void *pointer);',
glGetTexParameterPointervAPPLE = 'void glGetTexParameterPointervAPPLE (GLenum target, GLenum pname, void **params);',
glBindVertexArrayAPPLE = 'void glBindVertexArrayAPPLE (GLuint array);',
glDeleteVertexArraysAPPLE = 'void glDeleteVertexArraysAPPLE (GLsizei n, const GLuint *arrays);',
glGenVertexArraysAPPLE = 'void glGenVertexArraysAPPLE (GLsizei n, GLuint *arrays);',
glIsVertexArrayAPPLE = 'GLboolean glIsVertexArrayAPPLE (GLuint array);',
glVertexArrayRangeAPPLE = 'void glVertexArrayRangeAPPLE (GLsizei length, void *pointer);',
glFlushVertexArrayRangeAPPLE = 'void glFlushVertexArrayRangeAPPLE (GLsizei length, void *pointer);',
glVertexArrayParameteriAPPLE = 'void glVertexArrayParameteriAPPLE (GLenum pname, GLint param);',
glEnableVertexAttribAPPLE = 'void glEnableVertexAttribAPPLE (GLuint index, GLenum pname);',
glDisableVertexAttribAPPLE = 'void glDisableVertexAttribAPPLE (GLuint index, GLenum pname);',
glIsVertexAttribEnabledAPPLE = 'GLboolean glIsVertexAttribEnabledAPPLE (GLuint index, GLenum pname);',
glMapVertexAttrib1dAPPLE = 'void glMapVertexAttrib1dAPPLE (GLuint index, GLuint size, GLdouble u1, GLdouble u2, GLint stride, GLint order, const GLdouble *points);',
glMapVertexAttrib1fAPPLE = 'void glMapVertexAttrib1fAPPLE (GLuint index, GLuint size, GLfloat u1, GLfloat u2, GLint stride, GLint order, const GLfloat *points);',
glMapVertexAttrib2dAPPLE = 'void glMapVertexAttrib2dAPPLE (GLuint index, GLuint size, GLdouble u1, GLdouble u2, GLint ustride, GLint uorder, GLdouble v1, GLdouble v2, GLint vstride, GLint vorder, const GLdouble *points);',
glMapVertexAttrib2fAPPLE = 'void glMapVertexAttrib2fAPPLE (GLuint index, GLuint size, GLfloat u1, GLfloat u2, GLint ustride, GLint uorder, GLfloat v1, GLfloat v2, GLint vstride, GLint vorder, const GLfloat *points);',
glDrawBuffersATI = 'void glDrawBuffersATI (GLsizei n, const GLenum *bufs);',
glElementPointerATI = 'void glElementPointerATI (GLenum type, const void *pointer);',
glDrawElementArrayATI = 'void glDrawElementArrayATI (GLenum mode, GLsizei count);',
glDrawRangeElementArrayATI = 'void glDrawRangeElementArrayATI (GLenum mode, GLuint start, GLuint end, GLsizei count);',
glTexBumpParameterivATI = 'void glTexBumpParameterivATI (GLenum pname, const GLint *param);',
glTexBumpParameterfvATI = 'void glTexBumpParameterfvATI (GLenum pname, const GLfloat *param);',
glGetTexBumpParameterivATI = 'void glGetTexBumpParameterivATI (GLenum pname, GLint *param);',
glGetTexBumpParameterfvATI = 'void glGetTexBumpParameterfvATI (GLenum pname, GLfloat *param);',
glGenFragmentShadersATI = 'GLuint glGenFragmentShadersATI (GLuint range);',
glBindFragmentShaderATI = 'void glBindFragmentShaderATI (GLuint id);',
glDeleteFragmentShaderATI = 'void glDeleteFragmentShaderATI (GLuint id);',
glBeginFragmentShaderATI = 'void glBeginFragmentShaderATI (void);',
glEndFragmentShaderATI = 'void glEndFragmentShaderATI (void);',
glPassTexCoordATI = 'void glPassTexCoordATI (GLuint dst, GLuint coord, GLenum swizzle);',
glSampleMapATI = 'void glSampleMapATI (GLuint dst, GLuint interp, GLenum swizzle);',
glColorFragmentOp1ATI = 'void glColorFragmentOp1ATI (GLenum op, GLuint dst, GLuint dstMask, GLuint dstMod, GLuint arg1, GLuint arg1Rep, GLuint arg1Mod);',
glColorFragmentOp2ATI = 'void glColorFragmentOp2ATI (GLenum op, GLuint dst, GLuint dstMask, GLuint dstMod, GLuint arg1, GLuint arg1Rep, GLuint arg1Mod, GLuint arg2, GLuint arg2Rep, GLuint arg2Mod);',
glColorFragmentOp3ATI = 'void glColorFragmentOp3ATI (GLenum op, GLuint dst, GLuint dstMask, GLuint dstMod, GLuint arg1, GLuint arg1Rep, GLuint arg1Mod, GLuint arg2, GLuint arg2Rep, GLuint arg2Mod, GLuint arg3, GLuint arg3Rep, GLuint arg3Mod);',
glAlphaFragmentOp1ATI = 'void glAlphaFragmentOp1ATI (GLenum op, GLuint dst, GLuint dstMod, GLuint arg1, GLuint arg1Rep, GLuint arg1Mod);',
glAlphaFragmentOp2ATI = 'void glAlphaFragmentOp2ATI (GLenum op, GLuint dst, GLuint dstMod, GLuint arg1, GLuint arg1Rep, GLuint arg1Mod, GLuint arg2, GLuint arg2Rep, GLuint arg2Mod);',
glAlphaFragmentOp3ATI = 'void glAlphaFragmentOp3ATI (GLenum op, GLuint dst, GLuint dstMod, GLuint arg1, GLuint arg1Rep, GLuint arg1Mod, GLuint arg2, GLuint arg2Rep, GLuint arg2Mod, GLuint arg3, GLuint arg3Rep, GLuint arg3Mod);',
glSetFragmentShaderConstantATI = 'void glSetFragmentShaderConstantATI (GLuint dst, const GLfloat *value);',
glMapObjectBufferATI = 'void * glMapObjectBufferATI (GLuint buffer);',
glUnmapObjectBufferATI = 'void glUnmapObjectBufferATI (GLuint buffer);',
glPNTrianglesiATI = 'void glPNTrianglesiATI (GLenum pname, GLint param);',
glPNTrianglesfATI = 'void glPNTrianglesfATI (GLenum pname, GLfloat param);',
glStencilOpSeparateATI = 'void glStencilOpSeparateATI (GLenum face, GLenum sfail, GLenum dpfail, GLenum dppass);',
glStencilFuncSeparateATI = 'void glStencilFuncSeparateATI (GLenum frontfunc, GLenum backfunc, GLint ref, GLuint mask);',
glNewObjectBufferATI = 'GLuint glNewObjectBufferATI (GLsizei size, const void *pointer, GLenum usage);',
glIsObjectBufferATI = 'GLboolean glIsObjectBufferATI (GLuint buffer);',
glUpdateObjectBufferATI = 'void glUpdateObjectBufferATI (GLuint buffer, GLuint offset, GLsizei size, const void *pointer, GLenum preserve);',
glGetObjectBufferfvATI = 'void glGetObjectBufferfvATI (GLuint buffer, GLenum pname, GLfloat *params);',
glGetObjectBufferivATI = 'void glGetObjectBufferivATI (GLuint buffer, GLenum pname, GLint *params);',
glFreeObjectBufferATI = 'void glFreeObjectBufferATI (GLuint buffer);',
glArrayObjectATI = 'void glArrayObjectATI (GLenum array, GLint size, GLenum type, GLsizei stride, GLuint buffer, GLuint offset);',
glGetArrayObjectfvATI = 'void glGetArrayObjectfvATI (GLenum array, GLenum pname, GLfloat *params);',
glGetArrayObjectivATI = 'void glGetArrayObjectivATI (GLenum array, GLenum pname, GLint *params);',
glVariantArrayObjectATI = 'void glVariantArrayObjectATI (GLuint id, GLenum type, GLsizei stride, GLuint buffer, GLuint offset);',
glGetVariantArrayObjectfvATI = 'void glGetVariantArrayObjectfvATI (GLuint id, GLenum pname, GLfloat *params);',
glGetVariantArrayObjectivATI = 'void glGetVariantArrayObjectivATI (GLuint id, GLenum pname, GLint *params);',
glVertexAttribArrayObjectATI = 'void glVertexAttribArrayObjectATI (GLuint index, GLint size, GLenum type, GLboolean normalized, GLsizei stride, GLuint buffer, GLuint offset);',
glGetVertexAttribArrayObjectfvATI = 'void glGetVertexAttribArrayObjectfvATI (GLuint index, GLenum pname, GLfloat *params);',
glGetVertexAttribArrayObjectivATI = 'void glGetVertexAttribArrayObjectivATI (GLuint index, GLenum pname, GLint *params);',
glVertexStream1sATI = 'void glVertexStream1sATI (GLenum stream, GLshort x);',
glVertexStream1svATI = 'void glVertexStream1svATI (GLenum stream, const GLshort *coords);',
glVertexStream1iATI = 'void glVertexStream1iATI (GLenum stream, GLint x);',
glVertexStream1ivATI = 'void glVertexStream1ivATI (GLenum stream, const GLint *coords);',
glVertexStream1fATI = 'void glVertexStream1fATI (GLenum stream, GLfloat x);',
glVertexStream1fvATI = 'void glVertexStream1fvATI (GLenum stream, const GLfloat *coords);',
glVertexStream1dATI = 'void glVertexStream1dATI (GLenum stream, GLdouble x);',
glVertexStream1dvATI = 'void glVertexStream1dvATI (GLenum stream, const GLdouble *coords);',
glVertexStream2sATI = 'void glVertexStream2sATI (GLenum stream, GLshort x, GLshort y);',
glVertexStream2svATI = 'void glVertexStream2svATI (GLenum stream, const GLshort *coords);',
glVertexStream2iATI = 'void glVertexStream2iATI (GLenum stream, GLint x, GLint y);',
glVertexStream2ivATI = 'void glVertexStream2ivATI (GLenum stream, const GLint *coords);',
glVertexStream2fATI = 'void glVertexStream2fATI (GLenum stream, GLfloat x, GLfloat y);',
glVertexStream2fvATI = 'void glVertexStream2fvATI (GLenum stream, const GLfloat *coords);',
glVertexStream2dATI = 'void glVertexStream2dATI (GLenum stream, GLdouble x, GLdouble y);',
glVertexStream2dvATI = 'void glVertexStream2dvATI (GLenum stream, const GLdouble *coords);',
glVertexStream3sATI = 'void glVertexStream3sATI (GLenum stream, GLshort x, GLshort y, GLshort z);',
glVertexStream3svATI = 'void glVertexStream3svATI (GLenum stream, const GLshort *coords);',
glVertexStream3iATI = 'void glVertexStream3iATI (GLenum stream, GLint x, GLint y, GLint z);',
glVertexStream3ivATI = 'void glVertexStream3ivATI (GLenum stream, const GLint *coords);',
glVertexStream3fATI = 'void glVertexStream3fATI (GLenum stream, GLfloat x, GLfloat y, GLfloat z);',
glVertexStream3fvATI = 'void glVertexStream3fvATI (GLenum stream, const GLfloat *coords);',
glVertexStream3dATI = 'void glVertexStream3dATI (GLenum stream, GLdouble x, GLdouble y, GLdouble z);',
glVertexStream3dvATI = 'void glVertexStream3dvATI (GLenum stream, const GLdouble *coords);',
glVertexStream4sATI = 'void glVertexStream4sATI (GLenum stream, GLshort x, GLshort y, GLshort z, GLshort w);',
glVertexStream4svATI = 'void glVertexStream4svATI (GLenum stream, const GLshort *coords);',
glVertexStream4iATI = 'void glVertexStream4iATI (GLenum stream, GLint x, GLint y, GLint z, GLint w);',
glVertexStream4ivATI = 'void glVertexStream4ivATI (GLenum stream, const GLint *coords);',
glVertexStream4fATI = 'void glVertexStream4fATI (GLenum stream, GLfloat x, GLfloat y, GLfloat z, GLfloat w);',
glVertexStream4fvATI = 'void glVertexStream4fvATI (GLenum stream, const GLfloat *coords);',
glVertexStream4dATI = 'void glVertexStream4dATI (GLenum stream, GLdouble x, GLdouble y, GLdouble z, GLdouble w);',
glVertexStream4dvATI = 'void glVertexStream4dvATI (GLenum stream, const GLdouble *coords);',
glNormalStream3bATI = 'void glNormalStream3bATI (GLenum stream, GLbyte nx, GLbyte ny, GLbyte nz);',
glNormalStream3bvATI = 'void glNormalStream3bvATI (GLenum stream, const GLbyte *coords);',
glNormalStream3sATI = 'void glNormalStream3sATI (GLenum stream, GLshort nx, GLshort ny, GLshort nz);',
glNormalStream3svATI = 'void glNormalStream3svATI (GLenum stream, const GLshort *coords);',
glNormalStream3iATI = 'void glNormalStream3iATI (GLenum stream, GLint nx, GLint ny, GLint nz);',
glNormalStream3ivATI = 'void glNormalStream3ivATI (GLenum stream, const GLint *coords);',
glNormalStream3fATI = 'void glNormalStream3fATI (GLenum stream, GLfloat nx, GLfloat ny, GLfloat nz);',
glNormalStream3fvATI = 'void glNormalStream3fvATI (GLenum stream, const GLfloat *coords);',
glNormalStream3dATI = 'void glNormalStream3dATI (GLenum stream, GLdouble nx, GLdouble ny, GLdouble nz);',
glNormalStream3dvATI = 'void glNormalStream3dvATI (GLenum stream, const GLdouble *coords);',
glClientActiveVertexStreamATI = 'void glClientActiveVertexStreamATI (GLenum stream);',
glVertexBlendEnviATI = 'void glVertexBlendEnviATI (GLenum pname, GLint param);',
glVertexBlendEnvfATI = 'void glVertexBlendEnvfATI (GLenum pname, GLfloat param);',
glEGLImageTargetTexStorageEXT = 'void glEGLImageTargetTexStorageEXT (GLenum target, GLeglImageOES image, const GLint* attrib_list);',
glEGLImageTargetTextureStorageEXT = 'void glEGLImageTargetTextureStorageEXT (GLuint texture, GLeglImageOES image, const GLint* attrib_list);',
glUniformBufferEXT = 'void glUniformBufferEXT (GLuint program, GLint location, GLuint buffer);',
glGetUniformBufferSizeEXT = 'GLint glGetUniformBufferSizeEXT (GLuint program, GLint location);',
glGetUniformOffsetEXT = 'GLintptr glGetUniformOffsetEXT (GLuint program, GLint location);',
glBlendColorEXT = 'void glBlendColorEXT (GLfloat red, GLfloat green, GLfloat blue, GLfloat alpha);',
glBlendEquationSeparateEXT = 'void glBlendEquationSeparateEXT (GLenum modeRGB, GLenum modeAlpha);',
glBlendFuncSeparateEXT = 'void glBlendFuncSeparateEXT (GLenum sfactorRGB, GLenum dfactorRGB, GLenum sfactorAlpha, GLenum dfactorAlpha);',
glBlendEquationEXT = 'void glBlendEquationEXT (GLenum mode);',
glColorSubTableEXT = 'void glColorSubTableEXT (GLenum target, GLsizei start, GLsizei count, GLenum format, GLenum type, const void *data);',
glCopyColorSubTableEXT = 'void glCopyColorSubTableEXT (GLenum target, GLsizei start, GLint x, GLint y, GLsizei width);',
glLockArraysEXT = 'void glLockArraysEXT (GLint first, GLsizei count);',
glUnlockArraysEXT = 'void glUnlockArraysEXT (void);',
glConvolutionFilter1DEXT = 'void glConvolutionFilter1DEXT (GLenum target, GLenum internalformat, GLsizei width, GLenum format, GLenum type, const void *image);',
glConvolutionFilter2DEXT = 'void glConvolutionFilter2DEXT (GLenum target, GLenum internalformat, GLsizei width, GLsizei height, GLenum format, GLenum type, const void *image);',
glConvolutionParameterfEXT = 'void glConvolutionParameterfEXT (GLenum target, GLenum pname, GLfloat params);',
glConvolutionParameterfvEXT = 'void glConvolutionParameterfvEXT (GLenum target, GLenum pname, const GLfloat *params);',
glConvolutionParameteriEXT = 'void glConvolutionParameteriEXT (GLenum target, GLenum pname, GLint params);',
glConvolutionParameterivEXT = 'void glConvolutionParameterivEXT (GLenum target, GLenum pname, const GLint *params);',
glCopyConvolutionFilter1DEXT = 'void glCopyConvolutionFilter1DEXT (GLenum target, GLenum internalformat, GLint x, GLint y, GLsizei width);',
glCopyConvolutionFilter2DEXT = 'void glCopyConvolutionFilter2DEXT (GLenum target, GLenum internalformat, GLint x, GLint y, GLsizei width, GLsizei height);',
glGetConvolutionFilterEXT = 'void glGetConvolutionFilterEXT (GLenum target, GLenum format, GLenum type, void *image);',
glGetConvolutionParameterfvEXT = 'void glGetConvolutionParameterfvEXT (GLenum target, GLenum pname, GLfloat *params);',
glGetConvolutionParameterivEXT = 'void glGetConvolutionParameterivEXT (GLenum target, GLenum pname, GLint *params);',
glGetSeparableFilterEXT = 'void glGetSeparableFilterEXT (GLenum target, GLenum format, GLenum type, void *row, void *column, void *span);',
glSeparableFilter2DEXT = 'void glSeparableFilter2DEXT (GLenum target, GLenum internalformat, GLsizei width, GLsizei height, GLenum format, GLenum type, const void *row, const void *column);',
glTangent3bEXT = 'void glTangent3bEXT (GLbyte tx, GLbyte ty, GLbyte tz);',
glTangent3bvEXT = 'void glTangent3bvEXT (const GLbyte *v);',
glTangent3dEXT = 'void glTangent3dEXT (GLdouble tx, GLdouble ty, GLdouble tz);',
glTangent3dvEXT = 'void glTangent3dvEXT (const GLdouble *v);',
glTangent3fEXT = 'void glTangent3fEXT (GLfloat tx, GLfloat ty, GLfloat tz);',
glTangent3fvEXT = 'void glTangent3fvEXT (const GLfloat *v);',
glTangent3iEXT = 'void glTangent3iEXT (GLint tx, GLint ty, GLint tz);',
glTangent3ivEXT = 'void glTangent3ivEXT (const GLint *v);',
glTangent3sEXT = 'void glTangent3sEXT (GLshort tx, GLshort ty, GLshort tz);',
glTangent3svEXT = 'void glTangent3svEXT (const GLshort *v);',
glBinormal3bEXT = 'void glBinormal3bEXT (GLbyte bx, GLbyte by, GLbyte bz);',
glBinormal3bvEXT = 'void glBinormal3bvEXT (const GLbyte *v);',
glBinormal3dEXT = 'void glBinormal3dEXT (GLdouble bx, GLdouble by, GLdouble bz);',
glBinormal3dvEXT = 'void glBinormal3dvEXT (const GLdouble *v);',
glBinormal3fEXT = 'void glBinormal3fEXT (GLfloat bx, GLfloat by, GLfloat bz);',
glBinormal3fvEXT = 'void glBinormal3fvEXT (const GLfloat *v);',
glBinormal3iEXT = 'void glBinormal3iEXT (GLint bx, GLint by, GLint bz);',
glBinormal3ivEXT = 'void glBinormal3ivEXT (const GLint *v);',
glBinormal3sEXT = 'void glBinormal3sEXT (GLshort bx, GLshort by, GLshort bz);',
glBinormal3svEXT = 'void glBinormal3svEXT (const GLshort *v);',
glTangentPointerEXT = 'void glTangentPointerEXT (GLenum type, GLsizei stride, const void *pointer);',
glBinormalPointerEXT = 'void glBinormalPointerEXT (GLenum type, GLsizei stride, const void *pointer);',
glCopyTexImage1DEXT = 'void glCopyTexImage1DEXT (GLenum target, GLint level, GLenum internalformat, GLint x, GLint y, GLsizei width, GLint border);',
glCopyTexImage2DEXT = 'void glCopyTexImage2DEXT (GLenum target, GLint level, GLenum internalformat, GLint x, GLint y, GLsizei width, GLsizei height, GLint border);',
glCopyTexSubImage1DEXT = 'void glCopyTexSubImage1DEXT (GLenum target, GLint level, GLint xoffset, GLint x, GLint y, GLsizei width);',
glCopyTexSubImage2DEXT = 'void glCopyTexSubImage2DEXT (GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint x, GLint y, GLsizei width, GLsizei height);',
glCopyTexSubImage3DEXT = 'void glCopyTexSubImage3DEXT (GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLint x, GLint y, GLsizei width, GLsizei height);',
glCullParameterdvEXT = 'void glCullParameterdvEXT (GLenum pname, GLdouble *params);',
glCullParameterfvEXT = 'void glCullParameterfvEXT (GLenum pname, GLfloat *params);',
glLabelObjectEXT = 'void glLabelObjectEXT (GLenum type, GLuint object, GLsizei length, const GLchar *label);',
glGetObjectLabelEXT = 'void glGetObjectLabelEXT (GLenum type, GLuint object, GLsizei bufSize, GLsizei *length, GLchar *label);',
glInsertEventMarkerEXT = 'void glInsertEventMarkerEXT (GLsizei length, const GLchar *marker);',
glPushGroupMarkerEXT = 'void glPushGroupMarkerEXT (GLsizei length, const GLchar *marker);',
glPopGroupMarkerEXT = 'void glPopGroupMarkerEXT (void);',
glDepthBoundsEXT = 'void glDepthBoundsEXT (GLclampd zmin, GLclampd zmax);',
glMatrixLoadfEXT = 'void glMatrixLoadfEXT (GLenum mode, const GLfloat *m);',
glMatrixLoaddEXT = 'void glMatrixLoaddEXT (GLenum mode, const GLdouble *m);',
glMatrixMultfEXT = 'void glMatrixMultfEXT (GLenum mode, const GLfloat *m);',
glMatrixMultdEXT = 'void glMatrixMultdEXT (GLenum mode, const GLdouble *m);',
glMatrixLoadIdentityEXT = 'void glMatrixLoadIdentityEXT (GLenum mode);',
glMatrixRotatefEXT = 'void glMatrixRotatefEXT (GLenum mode, GLfloat angle, GLfloat x, GLfloat y, GLfloat z);',
glMatrixRotatedEXT = 'void glMatrixRotatedEXT (GLenum mode, GLdouble angle, GLdouble x, GLdouble y, GLdouble z);',
glMatrixScalefEXT = 'void glMatrixScalefEXT (GLenum mode, GLfloat x, GLfloat y, GLfloat z);',
glMatrixScaledEXT = 'void glMatrixScaledEXT (GLenum mode, GLdouble x, GLdouble y, GLdouble z);',
glMatrixTranslatefEXT = 'void glMatrixTranslatefEXT (GLenum mode, GLfloat x, GLfloat y, GLfloat z);',
glMatrixTranslatedEXT = 'void glMatrixTranslatedEXT (GLenum mode, GLdouble x, GLdouble y, GLdouble z);',
glMatrixFrustumEXT = 'void glMatrixFrustumEXT (GLenum mode, GLdouble left, GLdouble right, GLdouble bottom, GLdouble top, GLdouble zNear, GLdouble zFar);',
glMatrixOrthoEXT = 'void glMatrixOrthoEXT (GLenum mode, GLdouble left, GLdouble right, GLdouble bottom, GLdouble top, GLdouble zNear, GLdouble zFar);',
glMatrixPopEXT = 'void glMatrixPopEXT (GLenum mode);',
glMatrixPushEXT = 'void glMatrixPushEXT (GLenum mode);',
glClientAttribDefaultEXT = 'void glClientAttribDefaultEXT (GLbitfield mask);',
glPushClientAttribDefaultEXT = 'void glPushClientAttribDefaultEXT (GLbitfield mask);',
glTextureParameterfEXT = 'void glTextureParameterfEXT (GLuint texture, GLenum target, GLenum pname, GLfloat param);',
glTextureParameterfvEXT = 'void glTextureParameterfvEXT (GLuint texture, GLenum target, GLenum pname, const GLfloat *params);',
glTextureParameteriEXT = 'void glTextureParameteriEXT (GLuint texture, GLenum target, GLenum pname, GLint param);',
glTextureParameterivEXT = 'void glTextureParameterivEXT (GLuint texture, GLenum target, GLenum pname, const GLint *params);',
glTextureImage1DEXT = 'void glTextureImage1DEXT (GLuint texture, GLenum target, GLint level, GLint internalformat, GLsizei width, GLint border, GLenum format, GLenum type, const void *pixels);',
glTextureImage2DEXT = 'void glTextureImage2DEXT (GLuint texture, GLenum target, GLint level, GLint internalformat, GLsizei width, GLsizei height, GLint border, GLenum format, GLenum type, const void *pixels);',
glTextureSubImage1DEXT = 'void glTextureSubImage1DEXT (GLuint texture, GLenum target, GLint level, GLint xoffset, GLsizei width, GLenum format, GLenum type, const void *pixels);',
glTextureSubImage2DEXT = 'void glTextureSubImage2DEXT (GLuint texture, GLenum target, GLint level, GLint xoffset, GLint yoffset, GLsizei width, GLsizei height, GLenum format, GLenum type, const void *pixels);',
glCopyTextureImage1DEXT = 'void glCopyTextureImage1DEXT (GLuint texture, GLenum target, GLint level, GLenum internalformat, GLint x, GLint y, GLsizei width, GLint border);',
glCopyTextureImage2DEXT = 'void glCopyTextureImage2DEXT (GLuint texture, GLenum target, GLint level, GLenum internalformat, GLint x, GLint y, GLsizei width, GLsizei height, GLint border);',
glCopyTextureSubImage1DEXT = 'void glCopyTextureSubImage1DEXT (GLuint texture, GLenum target, GLint level, GLint xoffset, GLint x, GLint y, GLsizei width);',
glCopyTextureSubImage2DEXT = 'void glCopyTextureSubImage2DEXT (GLuint texture, GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint x, GLint y, GLsizei width, GLsizei height);',
glGetTextureImageEXT = 'void glGetTextureImageEXT (GLuint texture, GLenum target, GLint level, GLenum format, GLenum type, void *pixels);',
glGetTextureParameterfvEXT = 'void glGetTextureParameterfvEXT (GLuint texture, GLenum target, GLenum pname, GLfloat *params);',
glGetTextureParameterivEXT = 'void glGetTextureParameterivEXT (GLuint texture, GLenum target, GLenum pname, GLint *params);',
glGetTextureLevelParameterfvEXT = 'void glGetTextureLevelParameterfvEXT (GLuint texture, GLenum target, GLint level, GLenum pname, GLfloat *params);',
glGetTextureLevelParameterivEXT = 'void glGetTextureLevelParameterivEXT (GLuint texture, GLenum target, GLint level, GLenum pname, GLint *params);',
glTextureImage3DEXT = 'void glTextureImage3DEXT (GLuint texture, GLenum target, GLint level, GLint internalformat, GLsizei width, GLsizei height, GLsizei depth, GLint border, GLenum format, GLenum type, const void *pixels);',
glTextureSubImage3DEXT = 'void glTextureSubImage3DEXT (GLuint texture, GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth, GLenum format, GLenum type, const void *pixels);',
glCopyTextureSubImage3DEXT = 'void glCopyTextureSubImage3DEXT (GLuint texture, GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLint x, GLint y, GLsizei width, GLsizei height);',
glBindMultiTextureEXT = 'void glBindMultiTextureEXT (GLenum texunit, GLenum target, GLuint texture);',
glMultiTexCoordPointerEXT = 'void glMultiTexCoordPointerEXT (GLenum texunit, GLint size, GLenum type, GLsizei stride, const void *pointer);',
glMultiTexEnvfEXT = 'void glMultiTexEnvfEXT (GLenum texunit, GLenum target, GLenum pname, GLfloat param);',
glMultiTexEnvfvEXT = 'void glMultiTexEnvfvEXT (GLenum texunit, GLenum target, GLenum pname, const GLfloat *params);',
glMultiTexEnviEXT = 'void glMultiTexEnviEXT (GLenum texunit, GLenum target, GLenum pname, GLint param);',
glMultiTexEnvivEXT = 'void glMultiTexEnvivEXT (GLenum texunit, GLenum target, GLenum pname, const GLint *params);',
glMultiTexGendEXT = 'void glMultiTexGendEXT (GLenum texunit, GLenum coord, GLenum pname, GLdouble param);',
glMultiTexGendvEXT = 'void glMultiTexGendvEXT (GLenum texunit, GLenum coord, GLenum pname, const GLdouble *params);',
glMultiTexGenfEXT = 'void glMultiTexGenfEXT (GLenum texunit, GLenum coord, GLenum pname, GLfloat param);',
glMultiTexGenfvEXT = 'void glMultiTexGenfvEXT (GLenum texunit, GLenum coord, GLenum pname, const GLfloat *params);',
glMultiTexGeniEXT = 'void glMultiTexGeniEXT (GLenum texunit, GLenum coord, GLenum pname, GLint param);',
glMultiTexGenivEXT = 'void glMultiTexGenivEXT (GLenum texunit, GLenum coord, GLenum pname, const GLint *params);',
glGetMultiTexEnvfvEXT = 'void glGetMultiTexEnvfvEXT (GLenum texunit, GLenum target, GLenum pname, GLfloat *params);',
glGetMultiTexEnvivEXT = 'void glGetMultiTexEnvivEXT (GLenum texunit, GLenum target, GLenum pname, GLint *params);',
glGetMultiTexGendvEXT = 'void glGetMultiTexGendvEXT (GLenum texunit, GLenum coord, GLenum pname, GLdouble *params);',
glGetMultiTexGenfvEXT = 'void glGetMultiTexGenfvEXT (GLenum texunit, GLenum coord, GLenum pname, GLfloat *params);',
glGetMultiTexGenivEXT = 'void glGetMultiTexGenivEXT (GLenum texunit, GLenum coord, GLenum pname, GLint *params);',
glMultiTexParameteriEXT = 'void glMultiTexParameteriEXT (GLenum texunit, GLenum target, GLenum pname, GLint param);',
glMultiTexParameterivEXT = 'void glMultiTexParameterivEXT (GLenum texunit, GLenum target, GLenum pname, const GLint *params);',
glMultiTexParameterfEXT = 'void glMultiTexParameterfEXT (GLenum texunit, GLenum target, GLenum pname, GLfloat param);',
glMultiTexParameterfvEXT = 'void glMultiTexParameterfvEXT (GLenum texunit, GLenum target, GLenum pname, const GLfloat *params);',
glMultiTexImage1DEXT = 'void glMultiTexImage1DEXT (GLenum texunit, GLenum target, GLint level, GLint internalformat, GLsizei width, GLint border, GLenum format, GLenum type, const void *pixels);',
glMultiTexImage2DEXT = 'void glMultiTexImage2DEXT (GLenum texunit, GLenum target, GLint level, GLint internalformat, GLsizei width, GLsizei height, GLint border, GLenum format, GLenum type, const void *pixels);',
glMultiTexSubImage1DEXT = 'void glMultiTexSubImage1DEXT (GLenum texunit, GLenum target, GLint level, GLint xoffset, GLsizei width, GLenum format, GLenum type, const void *pixels);',
glMultiTexSubImage2DEXT = 'void glMultiTexSubImage2DEXT (GLenum texunit, GLenum target, GLint level, GLint xoffset, GLint yoffset, GLsizei width, GLsizei height, GLenum format, GLenum type, const void *pixels);',
glCopyMultiTexImage1DEXT = 'void glCopyMultiTexImage1DEXT (GLenum texunit, GLenum target, GLint level, GLenum internalformat, GLint x, GLint y, GLsizei width, GLint border);',
glCopyMultiTexImage2DEXT = 'void glCopyMultiTexImage2DEXT (GLenum texunit, GLenum target, GLint level, GLenum internalformat, GLint x, GLint y, GLsizei width, GLsizei height, GLint border);',
glCopyMultiTexSubImage1DEXT = 'void glCopyMultiTexSubImage1DEXT (GLenum texunit, GLenum target, GLint level, GLint xoffset, GLint x, GLint y, GLsizei width);',
glCopyMultiTexSubImage2DEXT = 'void glCopyMultiTexSubImage2DEXT (GLenum texunit, GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint x, GLint y, GLsizei width, GLsizei height);',
glGetMultiTexImageEXT = 'void glGetMultiTexImageEXT (GLenum texunit, GLenum target, GLint level, GLenum format, GLenum type, void *pixels);',
glGetMultiTexParameterfvEXT = 'void glGetMultiTexParameterfvEXT (GLenum texunit, GLenum target, GLenum pname, GLfloat *params);',
glGetMultiTexParameterivEXT = 'void glGetMultiTexParameterivEXT (GLenum texunit, GLenum target, GLenum pname, GLint *params);',
glGetMultiTexLevelParameterfvEXT = 'void glGetMultiTexLevelParameterfvEXT (GLenum texunit, GLenum target, GLint level, GLenum pname, GLfloat *params);',
glGetMultiTexLevelParameterivEXT = 'void glGetMultiTexLevelParameterivEXT (GLenum texunit, GLenum target, GLint level, GLenum pname, GLint *params);',
glMultiTexImage3DEXT = 'void glMultiTexImage3DEXT (GLenum texunit, GLenum target, GLint level, GLint internalformat, GLsizei width, GLsizei height, GLsizei depth, GLint border, GLenum format, GLenum type, const void *pixels);',
glMultiTexSubImage3DEXT = 'void glMultiTexSubImage3DEXT (GLenum texunit, GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth, GLenum format, GLenum type, const void *pixels);',
glCopyMultiTexSubImage3DEXT = 'void glCopyMultiTexSubImage3DEXT (GLenum texunit, GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLint x, GLint y, GLsizei width, GLsizei height);',
glEnableClientStateIndexedEXT = 'void glEnableClientStateIndexedEXT (GLenum array, GLuint index);',
glDisableClientStateIndexedEXT = 'void glDisableClientStateIndexedEXT (GLenum array, GLuint index);',
glGetFloatIndexedvEXT = 'void glGetFloatIndexedvEXT (GLenum target, GLuint index, GLfloat *data);',
glGetDoubleIndexedvEXT = 'void glGetDoubleIndexedvEXT (GLenum target, GLuint index, GLdouble *data);',
glGetPointerIndexedvEXT = 'void glGetPointerIndexedvEXT (GLenum target, GLuint index, void **data);',
glEnableIndexedEXT = 'void glEnableIndexedEXT (GLenum target, GLuint index);',
glDisableIndexedEXT = 'void glDisableIndexedEXT (GLenum target, GLuint index);',
glIsEnabledIndexedEXT = 'GLboolean glIsEnabledIndexedEXT (GLenum target, GLuint index);',
glGetIntegerIndexedvEXT = 'void glGetIntegerIndexedvEXT (GLenum target, GLuint index, GLint *data);',
glGetBooleanIndexedvEXT = 'void glGetBooleanIndexedvEXT (GLenum target, GLuint index, GLboolean *data);',
glCompressedTextureImage3DEXT = 'void glCompressedTextureImage3DEXT (GLuint texture, GLenum target, GLint level, GLenum internalformat, GLsizei width, GLsizei height, GLsizei depth, GLint border, GLsizei imageSize, const void *bits);',
glCompressedTextureImage2DEXT = 'void glCompressedTextureImage2DEXT (GLuint texture, GLenum target, GLint level, GLenum internalformat, GLsizei width, GLsizei height, GLint border, GLsizei imageSize, const void *bits);',
glCompressedTextureImage1DEXT = 'void glCompressedTextureImage1DEXT (GLuint texture, GLenum target, GLint level, GLenum internalformat, GLsizei width, GLint border, GLsizei imageSize, const void *bits);',
glCompressedTextureSubImage3DEXT = 'void glCompressedTextureSubImage3DEXT (GLuint texture, GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth, GLenum format, GLsizei imageSize, const void *bits);',
glCompressedTextureSubImage2DEXT = 'void glCompressedTextureSubImage2DEXT (GLuint texture, GLenum target, GLint level, GLint xoffset, GLint yoffset, GLsizei width, GLsizei height, GLenum format, GLsizei imageSize, const void *bits);',
glCompressedTextureSubImage1DEXT = 'void glCompressedTextureSubImage1DEXT (GLuint texture, GLenum target, GLint level, GLint xoffset, GLsizei width, GLenum format, GLsizei imageSize, const void *bits);',
glGetCompressedTextureImageEXT = 'void glGetCompressedTextureImageEXT (GLuint texture, GLenum target, GLint lod, void *img);',
glCompressedMultiTexImage3DEXT = 'void glCompressedMultiTexImage3DEXT (GLenum texunit, GLenum target, GLint level, GLenum internalformat, GLsizei width, GLsizei height, GLsizei depth, GLint border, GLsizei imageSize, const void *bits);',
glCompressedMultiTexImage2DEXT = 'void glCompressedMultiTexImage2DEXT (GLenum texunit, GLenum target, GLint level, GLenum internalformat, GLsizei width, GLsizei height, GLint border, GLsizei imageSize, const void *bits);',
glCompressedMultiTexImage1DEXT = 'void glCompressedMultiTexImage1DEXT (GLenum texunit, GLenum target, GLint level, GLenum internalformat, GLsizei width, GLint border, GLsizei imageSize, const void *bits);',
glCompressedMultiTexSubImage3DEXT = 'void glCompressedMultiTexSubImage3DEXT (GLenum texunit, GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth, GLenum format, GLsizei imageSize, const void *bits);',
glCompressedMultiTexSubImage2DEXT = 'void glCompressedMultiTexSubImage2DEXT (GLenum texunit, GLenum target, GLint level, GLint xoffset, GLint yoffset, GLsizei width, GLsizei height, GLenum format, GLsizei imageSize, const void *bits);',
glCompressedMultiTexSubImage1DEXT = 'void glCompressedMultiTexSubImage1DEXT (GLenum texunit, GLenum target, GLint level, GLint xoffset, GLsizei width, GLenum format, GLsizei imageSize, const void *bits);',
glGetCompressedMultiTexImageEXT = 'void glGetCompressedMultiTexImageEXT (GLenum texunit, GLenum target, GLint lod, void *img);',
glMatrixLoadTransposefEXT = 'void glMatrixLoadTransposefEXT (GLenum mode, const GLfloat *m);',
glMatrixLoadTransposedEXT = 'void glMatrixLoadTransposedEXT (GLenum mode, const GLdouble *m);',
glMatrixMultTransposefEXT = 'void glMatrixMultTransposefEXT (GLenum mode, const GLfloat *m);',
glMatrixMultTransposedEXT = 'void glMatrixMultTransposedEXT (GLenum mode, const GLdouble *m);',
glNamedBufferDataEXT = 'void glNamedBufferDataEXT (GLuint buffer, GLsizeiptr size, const void *data, GLenum usage);',
glNamedBufferSubDataEXT = 'void glNamedBufferSubDataEXT (GLuint buffer, GLintptr offset, GLsizeiptr size, const void *data);',
glMapNamedBufferEXT = 'void * glMapNamedBufferEXT (GLuint buffer, GLenum access);',
glUnmapNamedBufferEXT = 'GLboolean glUnmapNamedBufferEXT (GLuint buffer);',
glGetNamedBufferParameterivEXT = 'void glGetNamedBufferParameterivEXT (GLuint buffer, GLenum pname, GLint *params);',
glGetNamedBufferPointervEXT = 'void glGetNamedBufferPointervEXT (GLuint buffer, GLenum pname, void **params);',
glGetNamedBufferSubDataEXT = 'void glGetNamedBufferSubDataEXT (GLuint buffer, GLintptr offset, GLsizeiptr size, void *data);',
glProgramUniform1fEXT = 'void glProgramUniform1fEXT (GLuint program, GLint location, GLfloat v0);',
glProgramUniform2fEXT = 'void glProgramUniform2fEXT (GLuint program, GLint location, GLfloat v0, GLfloat v1);',
glProgramUniform3fEXT = 'void glProgramUniform3fEXT (GLuint program, GLint location, GLfloat v0, GLfloat v1, GLfloat v2);',
glProgramUniform4fEXT = 'void glProgramUniform4fEXT (GLuint program, GLint location, GLfloat v0, GLfloat v1, GLfloat v2, GLfloat v3);',
glProgramUniform1iEXT = 'void glProgramUniform1iEXT (GLuint program, GLint location, GLint v0);',
glProgramUniform2iEXT = 'void glProgramUniform2iEXT (GLuint program, GLint location, GLint v0, GLint v1);',
glProgramUniform3iEXT = 'void glProgramUniform3iEXT (GLuint program, GLint location, GLint v0, GLint v1, GLint v2);',
glProgramUniform4iEXT = 'void glProgramUniform4iEXT (GLuint program, GLint location, GLint v0, GLint v1, GLint v2, GLint v3);',
glProgramUniform1fvEXT = 'void glProgramUniform1fvEXT (GLuint program, GLint location, GLsizei count, const GLfloat *value);',
glProgramUniform2fvEXT = 'void glProgramUniform2fvEXT (GLuint program, GLint location, GLsizei count, const GLfloat *value);',
glProgramUniform3fvEXT = 'void glProgramUniform3fvEXT (GLuint program, GLint location, GLsizei count, const GLfloat *value);',
glProgramUniform4fvEXT = 'void glProgramUniform4fvEXT (GLuint program, GLint location, GLsizei count, const GLfloat *value);',
glProgramUniform1ivEXT = 'void glProgramUniform1ivEXT (GLuint program, GLint location, GLsizei count, const GLint *value);',
glProgramUniform2ivEXT = 'void glProgramUniform2ivEXT (GLuint program, GLint location, GLsizei count, const GLint *value);',
glProgramUniform3ivEXT = 'void glProgramUniform3ivEXT (GLuint program, GLint location, GLsizei count, const GLint *value);',
glProgramUniform4ivEXT = 'void glProgramUniform4ivEXT (GLuint program, GLint location, GLsizei count, const GLint *value);',
glProgramUniformMatrix2fvEXT = 'void glProgramUniformMatrix2fvEXT (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);',
glProgramUniformMatrix3fvEXT = 'void glProgramUniformMatrix3fvEXT (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);',
glProgramUniformMatrix4fvEXT = 'void glProgramUniformMatrix4fvEXT (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);',
glProgramUniformMatrix2x3fvEXT = 'void glProgramUniformMatrix2x3fvEXT (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);',
glProgramUniformMatrix3x2fvEXT = 'void glProgramUniformMatrix3x2fvEXT (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);',
glProgramUniformMatrix2x4fvEXT = 'void glProgramUniformMatrix2x4fvEXT (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);',
glProgramUniformMatrix4x2fvEXT = 'void glProgramUniformMatrix4x2fvEXT (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);',
glProgramUniformMatrix3x4fvEXT = 'void glProgramUniformMatrix3x4fvEXT (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);',
glProgramUniformMatrix4x3fvEXT = 'void glProgramUniformMatrix4x3fvEXT (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);',
glTextureBufferEXT = 'void glTextureBufferEXT (GLuint texture, GLenum target, GLenum internalformat, GLuint buffer);',
glMultiTexBufferEXT = 'void glMultiTexBufferEXT (GLenum texunit, GLenum target, GLenum internalformat, GLuint buffer);',
glTextureParameterIivEXT = 'void glTextureParameterIivEXT (GLuint texture, GLenum target, GLenum pname, const GLint *params);',
glTextureParameterIuivEXT = 'void glTextureParameterIuivEXT (GLuint texture, GLenum target, GLenum pname, const GLuint *params);',
glGetTextureParameterIivEXT = 'void glGetTextureParameterIivEXT (GLuint texture, GLenum target, GLenum pname, GLint *params);',
glGetTextureParameterIuivEXT = 'void glGetTextureParameterIuivEXT (GLuint texture, GLenum target, GLenum pname, GLuint *params);',
glMultiTexParameterIivEXT = 'void glMultiTexParameterIivEXT (GLenum texunit, GLenum target, GLenum pname, const GLint *params);',
glMultiTexParameterIuivEXT = 'void glMultiTexParameterIuivEXT (GLenum texunit, GLenum target, GLenum pname, const GLuint *params);',
glGetMultiTexParameterIivEXT = 'void glGetMultiTexParameterIivEXT (GLenum texunit, GLenum target, GLenum pname, GLint *params);',
glGetMultiTexParameterIuivEXT = 'void glGetMultiTexParameterIuivEXT (GLenum texunit, GLenum target, GLenum pname, GLuint *params);',
glProgramUniform1uiEXT = 'void glProgramUniform1uiEXT (GLuint program, GLint location, GLuint v0);',
glProgramUniform2uiEXT = 'void glProgramUniform2uiEXT (GLuint program, GLint location, GLuint v0, GLuint v1);',
glProgramUniform3uiEXT = 'void glProgramUniform3uiEXT (GLuint program, GLint location, GLuint v0, GLuint v1, GLuint v2);',
glProgramUniform4uiEXT = 'void glProgramUniform4uiEXT (GLuint program, GLint location, GLuint v0, GLuint v1, GLuint v2, GLuint v3);',
glProgramUniform1uivEXT = 'void glProgramUniform1uivEXT (GLuint program, GLint location, GLsizei count, const GLuint *value);',
glProgramUniform2uivEXT = 'void glProgramUniform2uivEXT (GLuint program, GLint location, GLsizei count, const GLuint *value);',
glProgramUniform3uivEXT = 'void glProgramUniform3uivEXT (GLuint program, GLint location, GLsizei count, const GLuint *value);',
glProgramUniform4uivEXT = 'void glProgramUniform4uivEXT (GLuint program, GLint location, GLsizei count, const GLuint *value);',
glNamedProgramLocalParameters4fvEXT = 'void glNamedProgramLocalParameters4fvEXT (GLuint program, GLenum target, GLuint index, GLsizei count, const GLfloat *params);',
glNamedProgramLocalParameterI4iEXT = 'void glNamedProgramLocalParameterI4iEXT (GLuint program, GLenum target, GLuint index, GLint x, GLint y, GLint z, GLint w);',
glNamedProgramLocalParameterI4ivEXT = 'void glNamedProgramLocalParameterI4ivEXT (GLuint program, GLenum target, GLuint index, const GLint *params);',
glNamedProgramLocalParametersI4ivEXT = 'void glNamedProgramLocalParametersI4ivEXT (GLuint program, GLenum target, GLuint index, GLsizei count, const GLint *params);',
glNamedProgramLocalParameterI4uiEXT = 'void glNamedProgramLocalParameterI4uiEXT (GLuint program, GLenum target, GLuint index, GLuint x, GLuint y, GLuint z, GLuint w);',
glNamedProgramLocalParameterI4uivEXT = 'void glNamedProgramLocalParameterI4uivEXT (GLuint program, GLenum target, GLuint index, const GLuint *params);',
glNamedProgramLocalParametersI4uivEXT = 'void glNamedProgramLocalParametersI4uivEXT (GLuint program, GLenum target, GLuint index, GLsizei count, const GLuint *params);',
glGetNamedProgramLocalParameterIivEXT = 'void glGetNamedProgramLocalParameterIivEXT (GLuint program, GLenum target, GLuint index, GLint *params);',
glGetNamedProgramLocalParameterIuivEXT = 'void glGetNamedProgramLocalParameterIuivEXT (GLuint program, GLenum target, GLuint index, GLuint *params);',
glEnableClientStateiEXT = 'void glEnableClientStateiEXT (GLenum array, GLuint index);',
glDisableClientStateiEXT = 'void glDisableClientStateiEXT (GLenum array, GLuint index);',
glGetFloati_vEXT = 'void glGetFloati_vEXT (GLenum pname, GLuint index, GLfloat *params);',
glGetDoublei_vEXT = 'void glGetDoublei_vEXT (GLenum pname, GLuint index, GLdouble *params);',
glGetPointeri_vEXT = 'void glGetPointeri_vEXT (GLenum pname, GLuint index, void **params);',
glNamedProgramStringEXT = 'void glNamedProgramStringEXT (GLuint program, GLenum target, GLenum format, GLsizei len, const void *string);',
glNamedProgramLocalParameter4dEXT = 'void glNamedProgramLocalParameter4dEXT (GLuint program, GLenum target, GLuint index, GLdouble x, GLdouble y, GLdouble z, GLdouble w);',
glNamedProgramLocalParameter4dvEXT = 'void glNamedProgramLocalParameter4dvEXT (GLuint program, GLenum target, GLuint index, const GLdouble *params);',
glNamedProgramLocalParameter4fEXT = 'void glNamedProgramLocalParameter4fEXT (GLuint program, GLenum target, GLuint index, GLfloat x, GLfloat y, GLfloat z, GLfloat w);',
glNamedProgramLocalParameter4fvEXT = 'void glNamedProgramLocalParameter4fvEXT (GLuint program, GLenum target, GLuint index, const GLfloat *params);',
glGetNamedProgramLocalParameterdvEXT = 'void glGetNamedProgramLocalParameterdvEXT (GLuint program, GLenum target, GLuint index, GLdouble *params);',
glGetNamedProgramLocalParameterfvEXT = 'void glGetNamedProgramLocalParameterfvEXT (GLuint program, GLenum target, GLuint index, GLfloat *params);',
glGetNamedProgramivEXT = 'void glGetNamedProgramivEXT (GLuint program, GLenum target, GLenum pname, GLint *params);',
glGetNamedProgramStringEXT = 'void glGetNamedProgramStringEXT (GLuint program, GLenum target, GLenum pname, void *string);',
glNamedRenderbufferStorageEXT = 'void glNamedRenderbufferStorageEXT (GLuint renderbuffer, GLenum internalformat, GLsizei width, GLsizei height);',
glGetNamedRenderbufferParameterivEXT = 'void glGetNamedRenderbufferParameterivEXT (GLuint renderbuffer, GLenum pname, GLint *params);',
glNamedRenderbufferStorageMultisampleEXT = 'void glNamedRenderbufferStorageMultisampleEXT (GLuint renderbuffer, GLsizei samples, GLenum internalformat, GLsizei width, GLsizei height);',
glNamedRenderbufferStorageMultisampleCoverageEXT = 'void glNamedRenderbufferStorageMultisampleCoverageEXT (GLuint renderbuffer, GLsizei coverageSamples, GLsizei colorSamples, GLenum internalformat, GLsizei width, GLsizei height);',
glCheckNamedFramebufferStatusEXT = 'GLenum glCheckNamedFramebufferStatusEXT (GLuint framebuffer, GLenum target);',
glNamedFramebufferTexture1DEXT = 'void glNamedFramebufferTexture1DEXT (GLuint framebuffer, GLenum attachment, GLenum textarget, GLuint texture, GLint level);',
glNamedFramebufferTexture2DEXT = 'void glNamedFramebufferTexture2DEXT (GLuint framebuffer, GLenum attachment, GLenum textarget, GLuint texture, GLint level);',
glNamedFramebufferTexture3DEXT = 'void glNamedFramebufferTexture3DEXT (GLuint framebuffer, GLenum attachment, GLenum textarget, GLuint texture, GLint level, GLint zoffset);',
glNamedFramebufferRenderbufferEXT = 'void glNamedFramebufferRenderbufferEXT (GLuint framebuffer, GLenum attachment, GLenum renderbuffertarget, GLuint renderbuffer);',
glGetNamedFramebufferAttachmentParameterivEXT = 'void glGetNamedFramebufferAttachmentParameterivEXT (GLuint framebuffer, GLenum attachment, GLenum pname, GLint *params);',
glGenerateTextureMipmapEXT = 'void glGenerateTextureMipmapEXT (GLuint texture, GLenum target);',
glGenerateMultiTexMipmapEXT = 'void glGenerateMultiTexMipmapEXT (GLenum texunit, GLenum target);',
glFramebufferDrawBufferEXT = 'void glFramebufferDrawBufferEXT (GLuint framebuffer, GLenum mode);',
glFramebufferDrawBuffersEXT = 'void glFramebufferDrawBuffersEXT (GLuint framebuffer, GLsizei n, const GLenum *bufs);',
glFramebufferReadBufferEXT = 'void glFramebufferReadBufferEXT (GLuint framebuffer, GLenum mode);',
glGetFramebufferParameterivEXT = 'void glGetFramebufferParameterivEXT (GLuint framebuffer, GLenum pname, GLint *params);',
glNamedCopyBufferSubDataEXT = 'void glNamedCopyBufferSubDataEXT (GLuint readBuffer, GLuint writeBuffer, GLintptr readOffset, GLintptr writeOffset, GLsizeiptr size);',
glNamedFramebufferTextureEXT = 'void glNamedFramebufferTextureEXT (GLuint framebuffer, GLenum attachment, GLuint texture, GLint level);',
glNamedFramebufferTextureLayerEXT = 'void glNamedFramebufferTextureLayerEXT (GLuint framebuffer, GLenum attachment, GLuint texture, GLint level, GLint layer);',
glNamedFramebufferTextureFaceEXT = 'void glNamedFramebufferTextureFaceEXT (GLuint framebuffer, GLenum attachment, GLuint texture, GLint level, GLenum face);',
glTextureRenderbufferEXT = 'void glTextureRenderbufferEXT (GLuint texture, GLenum target, GLuint renderbuffer);',
glMultiTexRenderbufferEXT = 'void glMultiTexRenderbufferEXT (GLenum texunit, GLenum target, GLuint renderbuffer);',
glVertexArrayVertexOffsetEXT = 'void glVertexArrayVertexOffsetEXT (GLuint vaobj, GLuint buffer, GLint size, GLenum type, GLsizei stride, GLintptr offset);',
glVertexArrayColorOffsetEXT = 'void glVertexArrayColorOffsetEXT (GLuint vaobj, GLuint buffer, GLint size, GLenum type, GLsizei stride, GLintptr offset);',
glVertexArrayEdgeFlagOffsetEXT = 'void glVertexArrayEdgeFlagOffsetEXT (GLuint vaobj, GLuint buffer, GLsizei stride, GLintptr offset);',
glVertexArrayIndexOffsetEXT = 'void glVertexArrayIndexOffsetEXT (GLuint vaobj, GLuint buffer, GLenum type, GLsizei stride, GLintptr offset);',
glVertexArrayNormalOffsetEXT = 'void glVertexArrayNormalOffsetEXT (GLuint vaobj, GLuint buffer, GLenum type, GLsizei stride, GLintptr offset);',
glVertexArrayTexCoordOffsetEXT = 'void glVertexArrayTexCoordOffsetEXT (GLuint vaobj, GLuint buffer, GLint size, GLenum type, GLsizei stride, GLintptr offset);',
glVertexArrayMultiTexCoordOffsetEXT = 'void glVertexArrayMultiTexCoordOffsetEXT (GLuint vaobj, GLuint buffer, GLenum texunit, GLint size, GLenum type, GLsizei stride, GLintptr offset);',
glVertexArrayFogCoordOffsetEXT = 'void glVertexArrayFogCoordOffsetEXT (GLuint vaobj, GLuint buffer, GLenum type, GLsizei stride, GLintptr offset);',
glVertexArraySecondaryColorOffsetEXT = 'void glVertexArraySecondaryColorOffsetEXT (GLuint vaobj, GLuint buffer, GLint size, GLenum type, GLsizei stride, GLintptr offset);',
glVertexArrayVertexAttribOffsetEXT = 'void glVertexArrayVertexAttribOffsetEXT (GLuint vaobj, GLuint buffer, GLuint index, GLint size, GLenum type, GLboolean normalized, GLsizei stride, GLintptr offset);',
glVertexArrayVertexAttribIOffsetEXT = 'void glVertexArrayVertexAttribIOffsetEXT (GLuint vaobj, GLuint buffer, GLuint index, GLint size, GLenum type, GLsizei stride, GLintptr offset);',
glEnableVertexArrayEXT = 'void glEnableVertexArrayEXT (GLuint vaobj, GLenum array);',
glDisableVertexArrayEXT = 'void glDisableVertexArrayEXT (GLuint vaobj, GLenum array);',
glEnableVertexArrayAttribEXT = 'void glEnableVertexArrayAttribEXT (GLuint vaobj, GLuint index);',
glDisableVertexArrayAttribEXT = 'void glDisableVertexArrayAttribEXT (GLuint vaobj, GLuint index);',
glGetVertexArrayIntegervEXT = 'void glGetVertexArrayIntegervEXT (GLuint vaobj, GLenum pname, GLint *param);',
glGetVertexArrayPointervEXT = 'void glGetVertexArrayPointervEXT (GLuint vaobj, GLenum pname, void **param);',
glGetVertexArrayIntegeri_vEXT = 'void glGetVertexArrayIntegeri_vEXT (GLuint vaobj, GLuint index, GLenum pname, GLint *param);',
glGetVertexArrayPointeri_vEXT = 'void glGetVertexArrayPointeri_vEXT (GLuint vaobj, GLuint index, GLenum pname, void **param);',
glMapNamedBufferRangeEXT = 'void * glMapNamedBufferRangeEXT (GLuint buffer, GLintptr offset, GLsizeiptr length, GLbitfield access);',
glFlushMappedNamedBufferRangeEXT = 'void glFlushMappedNamedBufferRangeEXT (GLuint buffer, GLintptr offset, GLsizeiptr length);',
glNamedBufferStorageEXT = 'void glNamedBufferStorageEXT (GLuint buffer, GLsizeiptr size, const void *data, GLbitfield flags);',
glClearNamedBufferDataEXT = 'void glClearNamedBufferDataEXT (GLuint buffer, GLenum internalformat, GLenum format, GLenum type, const void *data);',
glClearNamedBufferSubDataEXT = 'void glClearNamedBufferSubDataEXT (GLuint buffer, GLenum internalformat, GLsizeiptr offset, GLsizeiptr size, GLenum format, GLenum type, const void *data);',
glNamedFramebufferParameteriEXT = 'void glNamedFramebufferParameteriEXT (GLuint framebuffer, GLenum pname, GLint param);',
glGetNamedFramebufferParameterivEXT = 'void glGetNamedFramebufferParameterivEXT (GLuint framebuffer, GLenum pname, GLint *params);',
glProgramUniform1dEXT = 'void glProgramUniform1dEXT (GLuint program, GLint location, GLdouble x);',
glProgramUniform2dEXT = 'void glProgramUniform2dEXT (GLuint program, GLint location, GLdouble x, GLdouble y);',
glProgramUniform3dEXT = 'void glProgramUniform3dEXT (GLuint program, GLint location, GLdouble x, GLdouble y, GLdouble z);',
glProgramUniform4dEXT = 'void glProgramUniform4dEXT (GLuint program, GLint location, GLdouble x, GLdouble y, GLdouble z, GLdouble w);',
glProgramUniform1dvEXT = 'void glProgramUniform1dvEXT (GLuint program, GLint location, GLsizei count, const GLdouble *value);',
glProgramUniform2dvEXT = 'void glProgramUniform2dvEXT (GLuint program, GLint location, GLsizei count, const GLdouble *value);',
glProgramUniform3dvEXT = 'void glProgramUniform3dvEXT (GLuint program, GLint location, GLsizei count, const GLdouble *value);',
glProgramUniform4dvEXT = 'void glProgramUniform4dvEXT (GLuint program, GLint location, GLsizei count, const GLdouble *value);',
glProgramUniformMatrix2dvEXT = 'void glProgramUniformMatrix2dvEXT (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);',
glProgramUniformMatrix3dvEXT = 'void glProgramUniformMatrix3dvEXT (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);',
glProgramUniformMatrix4dvEXT = 'void glProgramUniformMatrix4dvEXT (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);',
glProgramUniformMatrix2x3dvEXT = 'void glProgramUniformMatrix2x3dvEXT (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);',
glProgramUniformMatrix2x4dvEXT = 'void glProgramUniformMatrix2x4dvEXT (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);',
glProgramUniformMatrix3x2dvEXT = 'void glProgramUniformMatrix3x2dvEXT (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);',
glProgramUniformMatrix3x4dvEXT = 'void glProgramUniformMatrix3x4dvEXT (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);',
glProgramUniformMatrix4x2dvEXT = 'void glProgramUniformMatrix4x2dvEXT (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);',
glProgramUniformMatrix4x3dvEXT = 'void glProgramUniformMatrix4x3dvEXT (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);',
glTextureBufferRangeEXT = 'void glTextureBufferRangeEXT (GLuint texture, GLenum target, GLenum internalformat, GLuint buffer, GLintptr offset, GLsizeiptr size);',
glTextureStorage1DEXT = 'void glTextureStorage1DEXT (GLuint texture, GLenum target, GLsizei levels, GLenum internalformat, GLsizei width);',
glTextureStorage2DEXT = 'void glTextureStorage2DEXT (GLuint texture, GLenum target, GLsizei levels, GLenum internalformat, GLsizei width, GLsizei height);',
glTextureStorage3DEXT = 'void glTextureStorage3DEXT (GLuint texture, GLenum target, GLsizei levels, GLenum internalformat, GLsizei width, GLsizei height, GLsizei depth);',
glTextureStorage2DMultisampleEXT = 'void glTextureStorage2DMultisampleEXT (GLuint texture, GLenum target, GLsizei samples, GLenum internalformat, GLsizei width, GLsizei height, GLboolean fixedsamplelocations);',
glTextureStorage3DMultisampleEXT = 'void glTextureStorage3DMultisampleEXT (GLuint texture, GLenum target, GLsizei samples, GLenum internalformat, GLsizei width, GLsizei height, GLsizei depth, GLboolean fixedsamplelocations);',
glVertexArrayBindVertexBufferEXT = 'void glVertexArrayBindVertexBufferEXT (GLuint vaobj, GLuint bindingindex, GLuint buffer, GLintptr offset, GLsizei stride);',
glVertexArrayVertexAttribFormatEXT = 'void glVertexArrayVertexAttribFormatEXT (GLuint vaobj, GLuint attribindex, GLint size, GLenum type, GLboolean normalized, GLuint relativeoffset);',
glVertexArrayVertexAttribIFormatEXT = 'void glVertexArrayVertexAttribIFormatEXT (GLuint vaobj, GLuint attribindex, GLint size, GLenum type, GLuint relativeoffset);',
glVertexArrayVertexAttribLFormatEXT = 'void glVertexArrayVertexAttribLFormatEXT (GLuint vaobj, GLuint attribindex, GLint size, GLenum type, GLuint relativeoffset);',
glVertexArrayVertexAttribBindingEXT = 'void glVertexArrayVertexAttribBindingEXT (GLuint vaobj, GLuint attribindex, GLuint bindingindex);',
glVertexArrayVertexBindingDivisorEXT = 'void glVertexArrayVertexBindingDivisorEXT (GLuint vaobj, GLuint bindingindex, GLuint divisor);',
glVertexArrayVertexAttribLOffsetEXT = 'void glVertexArrayVertexAttribLOffsetEXT (GLuint vaobj, GLuint buffer, GLuint index, GLint size, GLenum type, GLsizei stride, GLintptr offset);',
glTexturePageCommitmentEXT = 'void glTexturePageCommitmentEXT (GLuint texture, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth, GLboolean commit);',
glVertexArrayVertexAttribDivisorEXT = 'void glVertexArrayVertexAttribDivisorEXT (GLuint vaobj, GLuint index, GLuint divisor);',
glColorMaskIndexedEXT = 'void glColorMaskIndexedEXT (GLuint index, GLboolean r, GLboolean g, GLboolean b, GLboolean a);',
glDrawArraysInstancedEXT = 'void glDrawArraysInstancedEXT (GLenum mode, GLint start, GLsizei count, GLsizei primcount);',
glDrawElementsInstancedEXT = 'void glDrawElementsInstancedEXT (GLenum mode, GLsizei count, GLenum type, const void *indices, GLsizei primcount);',
glDrawRangeElementsEXT = 'void glDrawRangeElementsEXT (GLenum mode, GLuint start, GLuint end, GLsizei count, GLenum type, const void *indices);',
glBufferStorageExternalEXT = 'void glBufferStorageExternalEXT (GLenum target, GLintptr offset, GLsizeiptr size, GLeglClientBufferEXT clientBuffer, GLbitfield flags);',
glNamedBufferStorageExternalEXT = 'void glNamedBufferStorageExternalEXT (GLuint buffer, GLintptr offset, GLsizeiptr size, GLeglClientBufferEXT clientBuffer, GLbitfield flags);',
glFogCoordfEXT = 'void glFogCoordfEXT (GLfloat coord);',
glFogCoordfvEXT = 'void glFogCoordfvEXT (const GLfloat *coord);',
glFogCoorddEXT = 'void glFogCoorddEXT (GLdouble coord);',
glFogCoorddvEXT = 'void glFogCoorddvEXT (const GLdouble *coord);',
glFogCoordPointerEXT = 'void glFogCoordPointerEXT (GLenum type, GLsizei stride, const void *pointer);',
glBlitFramebufferEXT = 'void glBlitFramebufferEXT (GLint srcX0, GLint srcY0, GLint srcX1, GLint srcY1, GLint dstX0, GLint dstY0, GLint dstX1, GLint dstY1, GLbitfield mask, GLenum filter);',
glRenderbufferStorageMultisampleEXT = 'void glRenderbufferStorageMultisampleEXT (GLenum target, GLsizei samples, GLenum internalformat, GLsizei width, GLsizei height);',
glIsRenderbufferEXT = 'GLboolean glIsRenderbufferEXT (GLuint renderbuffer);',
glBindRenderbufferEXT = 'void glBindRenderbufferEXT (GLenum target, GLuint renderbuffer);',
glDeleteRenderbuffersEXT = 'void glDeleteRenderbuffersEXT (GLsizei n, const GLuint *renderbuffers);',
glGenRenderbuffersEXT = 'void glGenRenderbuffersEXT (GLsizei n, GLuint *renderbuffers);',
glRenderbufferStorageEXT = 'void glRenderbufferStorageEXT (GLenum target, GLenum internalformat, GLsizei width, GLsizei height);',
glGetRenderbufferParameterivEXT = 'void glGetRenderbufferParameterivEXT (GLenum target, GLenum pname, GLint *params);',
glIsFramebufferEXT = 'GLboolean glIsFramebufferEXT (GLuint framebuffer);',
glBindFramebufferEXT = 'void glBindFramebufferEXT (GLenum target, GLuint framebuffer);',
glDeleteFramebuffersEXT = 'void glDeleteFramebuffersEXT (GLsizei n, const GLuint *framebuffers);',
glGenFramebuffersEXT = 'void glGenFramebuffersEXT (GLsizei n, GLuint *framebuffers);',
glCheckFramebufferStatusEXT = 'GLenum glCheckFramebufferStatusEXT (GLenum target);',
glFramebufferTexture1DEXT = 'void glFramebufferTexture1DEXT (GLenum target, GLenum attachment, GLenum textarget, GLuint texture, GLint level);',
glFramebufferTexture2DEXT = 'void glFramebufferTexture2DEXT (GLenum target, GLenum attachment, GLenum textarget, GLuint texture, GLint level);',
glFramebufferTexture3DEXT = 'void glFramebufferTexture3DEXT (GLenum target, GLenum attachment, GLenum textarget, GLuint texture, GLint level, GLint zoffset);',
glFramebufferRenderbufferEXT = 'void glFramebufferRenderbufferEXT (GLenum target, GLenum attachment, GLenum renderbuffertarget, GLuint renderbuffer);',
glGetFramebufferAttachmentParameterivEXT = 'void glGetFramebufferAttachmentParameterivEXT (GLenum target, GLenum attachment, GLenum pname, GLint *params);',
glGenerateMipmapEXT = 'void glGenerateMipmapEXT (GLenum target);',
glProgramParameteriEXT = 'void glProgramParameteriEXT (GLuint program, GLenum pname, GLint value);',
glProgramEnvParameters4fvEXT = 'void glProgramEnvParameters4fvEXT (GLenum target, GLuint index, GLsizei count, const GLfloat *params);',
glProgramLocalParameters4fvEXT = 'void glProgramLocalParameters4fvEXT (GLenum target, GLuint index, GLsizei count, const GLfloat *params);',
glGetUniformuivEXT = 'void glGetUniformuivEXT (GLuint program, GLint location, GLuint *params);',
glBindFragDataLocationEXT = 'void glBindFragDataLocationEXT (GLuint program, GLuint color, const GLchar *name);',
glGetFragDataLocationEXT = 'GLint glGetFragDataLocationEXT (GLuint program, const GLchar *name);',
glUniform1uiEXT = 'void glUniform1uiEXT (GLint location, GLuint v0);',
glUniform2uiEXT = 'void glUniform2uiEXT (GLint location, GLuint v0, GLuint v1);',
glUniform3uiEXT = 'void glUniform3uiEXT (GLint location, GLuint v0, GLuint v1, GLuint v2);',
glUniform4uiEXT = 'void glUniform4uiEXT (GLint location, GLuint v0, GLuint v1, GLuint v2, GLuint v3);',
glUniform1uivEXT = 'void glUniform1uivEXT (GLint location, GLsizei count, const GLuint *value);',
glUniform2uivEXT = 'void glUniform2uivEXT (GLint location, GLsizei count, const GLuint *value);',
glUniform3uivEXT = 'void glUniform3uivEXT (GLint location, GLsizei count, const GLuint *value);',
glUniform4uivEXT = 'void glUniform4uivEXT (GLint location, GLsizei count, const GLuint *value);',
glGetHistogramEXT = 'void glGetHistogramEXT (GLenum target, GLboolean reset, GLenum format, GLenum type, void *values);',
glGetHistogramParameterfvEXT = 'void glGetHistogramParameterfvEXT (GLenum target, GLenum pname, GLfloat *params);',
glGetHistogramParameterivEXT = 'void glGetHistogramParameterivEXT (GLenum target, GLenum pname, GLint *params);',
glGetMinmaxEXT = 'void glGetMinmaxEXT (GLenum target, GLboolean reset, GLenum format, GLenum type, void *values);',
glGetMinmaxParameterfvEXT = 'void glGetMinmaxParameterfvEXT (GLenum target, GLenum pname, GLfloat *params);',
glGetMinmaxParameterivEXT = 'void glGetMinmaxParameterivEXT (GLenum target, GLenum pname, GLint *params);',
glHistogramEXT = 'void glHistogramEXT (GLenum target, GLsizei width, GLenum internalformat, GLboolean sink);',
glMinmaxEXT = 'void glMinmaxEXT (GLenum target, GLenum internalformat, GLboolean sink);',
glResetHistogramEXT = 'void glResetHistogramEXT (GLenum target);',
glResetMinmaxEXT = 'void glResetMinmaxEXT (GLenum target);',
glIndexFuncEXT = 'void glIndexFuncEXT (GLenum func, GLclampf ref);',
glIndexMaterialEXT = 'void glIndexMaterialEXT (GLenum face, GLenum mode);',
glApplyTextureEXT = 'void glApplyTextureEXT (GLenum mode);',
glTextureLightEXT = 'void glTextureLightEXT (GLenum pname);',
glTextureMaterialEXT = 'void glTextureMaterialEXT (GLenum face, GLenum mode);',
glGetUnsignedBytevEXT = 'void glGetUnsignedBytevEXT (GLenum pname, GLubyte *data);',
glGetUnsignedBytei_vEXT = 'void glGetUnsignedBytei_vEXT (GLenum target, GLuint index, GLubyte *data);',
glDeleteMemoryObjectsEXT = 'void glDeleteMemoryObjectsEXT (GLsizei n, const GLuint *memoryObjects);',
glIsMemoryObjectEXT = 'GLboolean glIsMemoryObjectEXT (GLuint memoryObject);',
glCreateMemoryObjectsEXT = 'void glCreateMemoryObjectsEXT (GLsizei n, GLuint *memoryObjects);',
glMemoryObjectParameterivEXT = 'void glMemoryObjectParameterivEXT (GLuint memoryObject, GLenum pname, const GLint *params);',
glGetMemoryObjectParameterivEXT = 'void glGetMemoryObjectParameterivEXT (GLuint memoryObject, GLenum pname, GLint *params);',
glTexStorageMem2DEXT = 'void glTexStorageMem2DEXT (GLenum target, GLsizei levels, GLenum internalFormat, GLsizei width, GLsizei height, GLuint memory, GLuint64 offset);',
glTexStorageMem2DMultisampleEXT = 'void glTexStorageMem2DMultisampleEXT (GLenum target, GLsizei samples, GLenum internalFormat, GLsizei width, GLsizei height, GLboolean fixedSampleLocations, GLuint memory, GLuint64 offset);',
glTexStorageMem3DEXT = 'void glTexStorageMem3DEXT (GLenum target, GLsizei levels, GLenum internalFormat, GLsizei width, GLsizei height, GLsizei depth, GLuint memory, GLuint64 offset);',
glTexStorageMem3DMultisampleEXT = 'void glTexStorageMem3DMultisampleEXT (GLenum target, GLsizei samples, GLenum internalFormat, GLsizei width, GLsizei height, GLsizei depth, GLboolean fixedSampleLocations, GLuint memory, GLuint64 offset);',
glBufferStorageMemEXT = 'void glBufferStorageMemEXT (GLenum target, GLsizeiptr size, GLuint memory, GLuint64 offset);',
glTextureStorageMem2DEXT = 'void glTextureStorageMem2DEXT (GLuint texture, GLsizei levels, GLenum internalFormat, GLsizei width, GLsizei height, GLuint memory, GLuint64 offset);',
glTextureStorageMem2DMultisampleEXT = 'void glTextureStorageMem2DMultisampleEXT (GLuint texture, GLsizei samples, GLenum internalFormat, GLsizei width, GLsizei height, GLboolean fixedSampleLocations, GLuint memory, GLuint64 offset);',
glTextureStorageMem3DEXT = 'void glTextureStorageMem3DEXT (GLuint texture, GLsizei levels, GLenum internalFormat, GLsizei width, GLsizei height, GLsizei depth, GLuint memory, GLuint64 offset);',
glTextureStorageMem3DMultisampleEXT = 'void glTextureStorageMem3DMultisampleEXT (GLuint texture, GLsizei samples, GLenum internalFormat, GLsizei width, GLsizei height, GLsizei depth, GLboolean fixedSampleLocations, GLuint memory, GLuint64 offset);',
glNamedBufferStorageMemEXT = 'void glNamedBufferStorageMemEXT (GLuint buffer, GLsizeiptr size, GLuint memory, GLuint64 offset);',
glTexStorageMem1DEXT = 'void glTexStorageMem1DEXT (GLenum target, GLsizei levels, GLenum internalFormat, GLsizei width, GLuint memory, GLuint64 offset);',
glTextureStorageMem1DEXT = 'void glTextureStorageMem1DEXT (GLuint texture, GLsizei levels, GLenum internalFormat, GLsizei width, GLuint memory, GLuint64 offset);',
glImportMemoryFdEXT = 'void glImportMemoryFdEXT (GLuint memory, GLuint64 size, GLenum handleType, GLint fd);',
glImportMemoryWin32HandleEXT = 'void glImportMemoryWin32HandleEXT (GLuint memory, GLuint64 size, GLenum handleType, void *handle);',
glImportMemoryWin32NameEXT = 'void glImportMemoryWin32NameEXT (GLuint memory, GLuint64 size, GLenum handleType, const void *name);',
glMultiDrawArraysEXT = 'void glMultiDrawArraysEXT (GLenum mode, const GLint *first, const GLsizei *count, GLsizei primcount);',
glMultiDrawElementsEXT = 'void glMultiDrawElementsEXT (GLenum mode, const GLsizei *count, GLenum type, const void *const*indices, GLsizei primcount);',
glSampleMaskEXT = 'void glSampleMaskEXT (GLclampf value, GLboolean invert);',
glSamplePatternEXT = 'void glSamplePatternEXT (GLenum pattern);',
glPixelTransformParameteriEXT = 'void glPixelTransformParameteriEXT (GLenum target, GLenum pname, GLint param);',
glPixelTransformParameterfEXT = 'void glPixelTransformParameterfEXT (GLenum target, GLenum pname, GLfloat param);',
glPixelTransformParameterivEXT = 'void glPixelTransformParameterivEXT (GLenum target, GLenum pname, const GLint *params);',
glPixelTransformParameterfvEXT = 'void glPixelTransformParameterfvEXT (GLenum target, GLenum pname, const GLfloat *params);',
glGetPixelTransformParameterivEXT = 'void glGetPixelTransformParameterivEXT (GLenum target, GLenum pname, GLint *params);',
glGetPixelTransformParameterfvEXT = 'void glGetPixelTransformParameterfvEXT (GLenum target, GLenum pname, GLfloat *params);',
glPointParameterfEXT = 'void glPointParameterfEXT (GLenum pname, GLfloat param);',
glPointParameterfvEXT = 'void glPointParameterfvEXT (GLenum pname, const GLfloat *params);',
glPolygonOffsetEXT = 'void glPolygonOffsetEXT (GLfloat factor, GLfloat bias);',
glPolygonOffsetClampEXT = 'void glPolygonOffsetClampEXT (GLfloat factor, GLfloat units, GLfloat clamp);',
glProvokingVertexEXT = 'void glProvokingVertexEXT (GLenum mode);',
glRasterSamplesEXT = 'void glRasterSamplesEXT (GLuint samples, GLboolean fixedsamplelocations);',
glSecondaryColor3bEXT = 'void glSecondaryColor3bEXT (GLbyte red, GLbyte green, GLbyte blue);',
glSecondaryColor3bvEXT = 'void glSecondaryColor3bvEXT (const GLbyte *v);',
glSecondaryColor3dEXT = 'void glSecondaryColor3dEXT (GLdouble red, GLdouble green, GLdouble blue);',
glSecondaryColor3dvEXT = 'void glSecondaryColor3dvEXT (const GLdouble *v);',
glSecondaryColor3fEXT = 'void glSecondaryColor3fEXT (GLfloat red, GLfloat green, GLfloat blue);',
glSecondaryColor3fvEXT = 'void glSecondaryColor3fvEXT (const GLfloat *v);',
glSecondaryColor3iEXT = 'void glSecondaryColor3iEXT (GLint red, GLint green, GLint blue);',
glSecondaryColor3ivEXT = 'void glSecondaryColor3ivEXT (const GLint *v);',
glSecondaryColor3sEXT = 'void glSecondaryColor3sEXT (GLshort red, GLshort green, GLshort blue);',
glSecondaryColor3svEXT = 'void glSecondaryColor3svEXT (const GLshort *v);',
glSecondaryColor3ubEXT = 'void glSecondaryColor3ubEXT (GLubyte red, GLubyte green, GLubyte blue);',
glSecondaryColor3ubvEXT = 'void glSecondaryColor3ubvEXT (const GLubyte *v);',
glSecondaryColor3uiEXT = 'void glSecondaryColor3uiEXT (GLuint red, GLuint green, GLuint blue);',
glSecondaryColor3uivEXT = 'void glSecondaryColor3uivEXT (const GLuint *v);',
glSecondaryColor3usEXT = 'void glSecondaryColor3usEXT (GLushort red, GLushort green, GLushort blue);',
glSecondaryColor3usvEXT = 'void glSecondaryColor3usvEXT (const GLushort *v);',
glSecondaryColorPointerEXT = 'void glSecondaryColorPointerEXT (GLint size, GLenum type, GLsizei stride, const void *pointer);',
glGenSemaphoresEXT = 'void glGenSemaphoresEXT (GLsizei n, GLuint *semaphores);',
glDeleteSemaphoresEXT = 'void glDeleteSemaphoresEXT (GLsizei n, const GLuint *semaphores);',
glIsSemaphoreEXT = 'GLboolean glIsSemaphoreEXT (GLuint semaphore);',
glSemaphoreParameterui64vEXT = 'void glSemaphoreParameterui64vEXT (GLuint semaphore, GLenum pname, const GLuint64 *params);',
glGetSemaphoreParameterui64vEXT = 'void glGetSemaphoreParameterui64vEXT (GLuint semaphore, GLenum pname, GLuint64 *params);',
glWaitSemaphoreEXT = 'void glWaitSemaphoreEXT (GLuint semaphore, GLuint numBufferBarriers, const GLuint *buffers, GLuint numTextureBarriers, const GLuint *textures, const GLenum *srcLayouts);',
glSignalSemaphoreEXT = 'void glSignalSemaphoreEXT (GLuint semaphore, GLuint numBufferBarriers, const GLuint *buffers, GLuint numTextureBarriers, const GLuint *textures, const GLenum *dstLayouts);',
glImportSemaphoreFdEXT = 'void glImportSemaphoreFdEXT (GLuint semaphore, GLenum handleType, GLint fd);',
glImportSemaphoreWin32HandleEXT = 'void glImportSemaphoreWin32HandleEXT (GLuint semaphore, GLenum handleType, void *handle);',
glImportSemaphoreWin32NameEXT = 'void glImportSemaphoreWin32NameEXT (GLuint semaphore, GLenum handleType, const void *name);',
glUseShaderProgramEXT = 'void glUseShaderProgramEXT (GLenum type, GLuint program);',
glActiveProgramEXT = 'void glActiveProgramEXT (GLuint program);',
glCreateShaderProgramEXT = 'GLuint glCreateShaderProgramEXT (GLenum type, const GLchar *string);',
glFramebufferFetchBarrierEXT = 'void glFramebufferFetchBarrierEXT (void);',
glBindImageTextureEXT = 'void glBindImageTextureEXT (GLuint index, GLuint texture, GLint level, GLboolean layered, GLint layer, GLenum access, GLint format);',
glMemoryBarrierEXT = 'void glMemoryBarrierEXT (GLbitfield barriers);',
glStencilClearTagEXT = 'void glStencilClearTagEXT (GLsizei stencilTagBits, GLuint stencilClearTag);',
glActiveStencilFaceEXT = 'void glActiveStencilFaceEXT (GLenum face);',
glTexSubImage1DEXT = 'void glTexSubImage1DEXT (GLenum target, GLint level, GLint xoffset, GLsizei width, GLenum format, GLenum type, const void *pixels);',
glTexSubImage2DEXT = 'void glTexSubImage2DEXT (GLenum target, GLint level, GLint xoffset, GLint yoffset, GLsizei width, GLsizei height, GLenum format, GLenum type, const void *pixels);',
glTexImage3DEXT = 'void glTexImage3DEXT (GLenum target, GLint level, GLenum internalformat, GLsizei width, GLsizei height, GLsizei depth, GLint border, GLenum format, GLenum type, const void *pixels);',
glTexSubImage3DEXT = 'void glTexSubImage3DEXT (GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth, GLenum format, GLenum type, const void *pixels);',
glFramebufferTextureLayerEXT = 'void glFramebufferTextureLayerEXT (GLenum target, GLenum attachment, GLuint texture, GLint level, GLint layer);',
glTexBufferEXT = 'void glTexBufferEXT (GLenum target, GLenum internalformat, GLuint buffer);',
glTexParameterIivEXT = 'void glTexParameterIivEXT (GLenum target, GLenum pname, const GLint *params);',
glTexParameterIuivEXT = 'void glTexParameterIuivEXT (GLenum target, GLenum pname, const GLuint *params);',
glGetTexParameterIivEXT = 'void glGetTexParameterIivEXT (GLenum target, GLenum pname, GLint *params);',
glGetTexParameterIuivEXT = 'void glGetTexParameterIuivEXT (GLenum target, GLenum pname, GLuint *params);',
glClearColorIiEXT = 'void glClearColorIiEXT (GLint red, GLint green, GLint blue, GLint alpha);',
glClearColorIuiEXT = 'void glClearColorIuiEXT (GLuint red, GLuint green, GLuint blue, GLuint alpha);',
glAreTexturesResidentEXT = 'GLboolean glAreTexturesResidentEXT (GLsizei n, const GLuint *textures, GLboolean *residences);',
glBindTextureEXT = 'void glBindTextureEXT (GLenum target, GLuint texture);',
glDeleteTexturesEXT = 'void glDeleteTexturesEXT (GLsizei n, const GLuint *textures);',
glGenTexturesEXT = 'void glGenTexturesEXT (GLsizei n, GLuint *textures);',
glIsTextureEXT = 'GLboolean glIsTextureEXT (GLuint texture);',
glPrioritizeTexturesEXT = 'void glPrioritizeTexturesEXT (GLsizei n, const GLuint *textures, const GLclampf *priorities);',
glTextureNormalEXT = 'void glTextureNormalEXT (GLenum mode);',
glGetQueryObjecti64vEXT = 'void glGetQueryObjecti64vEXT (GLuint id, GLenum pname, GLint64 *params);',
glGetQueryObjectui64vEXT = 'void glGetQueryObjectui64vEXT (GLuint id, GLenum pname, GLuint64 *params);',
glBeginTransformFeedbackEXT = 'void glBeginTransformFeedbackEXT (GLenum primitiveMode);',
glEndTransformFeedbackEXT = 'void glEndTransformFeedbackEXT (void);',
glBindBufferRangeEXT = 'void glBindBufferRangeEXT (GLenum target, GLuint index, GLuint buffer, GLintptr offset, GLsizeiptr size);',
glBindBufferOffsetEXT = 'void glBindBufferOffsetEXT (GLenum target, GLuint index, GLuint buffer, GLintptr offset);',
glBindBufferBaseEXT = 'void glBindBufferBaseEXT (GLenum target, GLuint index, GLuint buffer);',
glTransformFeedbackVaryingsEXT = 'void glTransformFeedbackVaryingsEXT (GLuint program, GLsizei count, const GLchar *const*varyings, GLenum bufferMode);',
glGetTransformFeedbackVaryingEXT = 'void glGetTransformFeedbackVaryingEXT (GLuint program, GLuint index, GLsizei bufSize, GLsizei *length, GLsizei *size, GLenum *type, GLchar *name);',
glVertexAttribL1dEXT = 'void glVertexAttribL1dEXT (GLuint index, GLdouble x);',
glVertexAttribL2dEXT = 'void glVertexAttribL2dEXT (GLuint index, GLdouble x, GLdouble y);',
glVertexAttribL3dEXT = 'void glVertexAttribL3dEXT (GLuint index, GLdouble x, GLdouble y, GLdouble z);',
glVertexAttribL4dEXT = 'void glVertexAttribL4dEXT (GLuint index, GLdouble x, GLdouble y, GLdouble z, GLdouble w);',
glVertexAttribL1dvEXT = 'void glVertexAttribL1dvEXT (GLuint index, const GLdouble *v);',
glVertexAttribL2dvEXT = 'void glVertexAttribL2dvEXT (GLuint index, const GLdouble *v);',
glVertexAttribL3dvEXT = 'void glVertexAttribL3dvEXT (GLuint index, const GLdouble *v);',
glVertexAttribL4dvEXT = 'void glVertexAttribL4dvEXT (GLuint index, const GLdouble *v);',
glVertexAttribLPointerEXT = 'void glVertexAttribLPointerEXT (GLuint index, GLint size, GLenum type, GLsizei stride, const void *pointer);',
glGetVertexAttribLdvEXT = 'void glGetVertexAttribLdvEXT (GLuint index, GLenum pname, GLdouble *params);',
glBeginVertexShaderEXT = 'void glBeginVertexShaderEXT (void);',
glEndVertexShaderEXT = 'void glEndVertexShaderEXT (void);',
glBindVertexShaderEXT = 'void glBindVertexShaderEXT (GLuint id);',
glGenVertexShadersEXT = 'GLuint glGenVertexShadersEXT (GLuint range);',
glDeleteVertexShaderEXT = 'void glDeleteVertexShaderEXT (GLuint id);',
glShaderOp1EXT = 'void glShaderOp1EXT (GLenum op, GLuint res, GLuint arg1);',
glShaderOp2EXT = 'void glShaderOp2EXT (GLenum op, GLuint res, GLuint arg1, GLuint arg2);',
glShaderOp3EXT = 'void glShaderOp3EXT (GLenum op, GLuint res, GLuint arg1, GLuint arg2, GLuint arg3);',
glSwizzleEXT = 'void glSwizzleEXT (GLuint res, GLuint in, GLenum outX, GLenum outY, GLenum outZ, GLenum outW);',
glWriteMaskEXT = 'void glWriteMaskEXT (GLuint res, GLuint in, GLenum outX, GLenum outY, GLenum outZ, GLenum outW);',
glInsertComponentEXT = 'void glInsertComponentEXT (GLuint res, GLuint src, GLuint num);',
glExtractComponentEXT = 'void glExtractComponentEXT (GLuint res, GLuint src, GLuint num);',
glGenSymbolsEXT = 'GLuint glGenSymbolsEXT (GLenum datatype, GLenum storagetype, GLenum range, GLuint components);',
glSetInvariantEXT = 'void glSetInvariantEXT (GLuint id, GLenum type, const void *addr);',
glSetLocalConstantEXT = 'void glSetLocalConstantEXT (GLuint id, GLenum type, const void *addr);',
glVariantbvEXT = 'void glVariantbvEXT (GLuint id, const GLbyte *addr);',
glVariantsvEXT = 'void glVariantsvEXT (GLuint id, const GLshort *addr);',
glVariantivEXT = 'void glVariantivEXT (GLuint id, const GLint *addr);',
glVariantfvEXT = 'void glVariantfvEXT (GLuint id, const GLfloat *addr);',
glVariantdvEXT = 'void glVariantdvEXT (GLuint id, const GLdouble *addr);',
glVariantubvEXT = 'void glVariantubvEXT (GLuint id, const GLubyte *addr);',
glVariantusvEXT = 'void glVariantusvEXT (GLuint id, const GLushort *addr);',
glVariantuivEXT = 'void glVariantuivEXT (GLuint id, const GLuint *addr);',
glVariantPointerEXT = 'void glVariantPointerEXT (GLuint id, GLenum type, GLuint stride, const void *addr);',
glEnableVariantClientStateEXT = 'void glEnableVariantClientStateEXT (GLuint id);',
glDisableVariantClientStateEXT = 'void glDisableVariantClientStateEXT (GLuint id);',
glBindLightParameterEXT = 'GLuint glBindLightParameterEXT (GLenum light, GLenum value);',
glBindMaterialParameterEXT = 'GLuint glBindMaterialParameterEXT (GLenum face, GLenum value);',
glBindTexGenParameterEXT = 'GLuint glBindTexGenParameterEXT (GLenum unit, GLenum coord, GLenum value);',
glBindTextureUnitParameterEXT = 'GLuint glBindTextureUnitParameterEXT (GLenum unit, GLenum value);',
glBindParameterEXT = 'GLuint glBindParameterEXT (GLenum value);',
glIsVariantEnabledEXT = 'GLboolean glIsVariantEnabledEXT (GLuint id, GLenum cap);',
glGetVariantBooleanvEXT = 'void glGetVariantBooleanvEXT (GLuint id, GLenum value, GLboolean *data);',
glGetVariantIntegervEXT = 'void glGetVariantIntegervEXT (GLuint id, GLenum value, GLint *data);',
glGetVariantFloatvEXT = 'void glGetVariantFloatvEXT (GLuint id, GLenum value, GLfloat *data);',
glGetVariantPointervEXT = 'void glGetVariantPointervEXT (GLuint id, GLenum value, void **data);',
glGetInvariantBooleanvEXT = 'void glGetInvariantBooleanvEXT (GLuint id, GLenum value, GLboolean *data);',
glGetInvariantIntegervEXT = 'void glGetInvariantIntegervEXT (GLuint id, GLenum value, GLint *data);',
glGetInvariantFloatvEXT = 'void glGetInvariantFloatvEXT (GLuint id, GLenum value, GLfloat *data);',
glGetLocalConstantBooleanvEXT = 'void glGetLocalConstantBooleanvEXT (GLuint id, GLenum value, GLboolean *data);',
glGetLocalConstantIntegervEXT = 'void glGetLocalConstantIntegervEXT (GLuint id, GLenum value, GLint *data);',
glGetLocalConstantFloatvEXT = 'void glGetLocalConstantFloatvEXT (GLuint id, GLenum value, GLfloat *data);',
glVertexWeightfEXT = 'void glVertexWeightfEXT (GLfloat weight);',
glVertexWeightfvEXT = 'void glVertexWeightfvEXT (const GLfloat *weight);',
glVertexWeightPointerEXT = 'void glVertexWeightPointerEXT (GLint size, GLenum type, GLsizei stride, const void *pointer);',
glAcquireKeyedMutexWin32EXT = 'GLboolean glAcquireKeyedMutexWin32EXT (GLuint memory, GLuint64 key, GLuint timeout);',
glReleaseKeyedMutexWin32EXT = 'GLboolean glReleaseKeyedMutexWin32EXT (GLuint memory, GLuint64 key);',
glWindowRectanglesEXT = 'void glWindowRectanglesEXT (GLenum mode, GLsizei count, const GLint *box);',
glImportSyncEXT = 'GLsync glImportSyncEXT (GLenum external_sync_type, GLintptr external_sync, GLbitfield flags);',
glFrameTerminatorGREMEDY = 'void glFrameTerminatorGREMEDY (void);',
glStringMarkerGREMEDY = 'void glStringMarkerGREMEDY (GLsizei len, const void *string);',
glImageTransformParameteriHP = 'void glImageTransformParameteriHP (GLenum target, GLenum pname, GLint param);',
glImageTransformParameterfHP = 'void glImageTransformParameterfHP (GLenum target, GLenum pname, GLfloat param);',
glImageTransformParameterivHP = 'void glImageTransformParameterivHP (GLenum target, GLenum pname, const GLint *params);',
glImageTransformParameterfvHP = 'void glImageTransformParameterfvHP (GLenum target, GLenum pname, const GLfloat *params);',
glGetImageTransformParameterivHP = 'void glGetImageTransformParameterivHP (GLenum target, GLenum pname, GLint *params);',
glGetImageTransformParameterfvHP = 'void glGetImageTransformParameterfvHP (GLenum target, GLenum pname, GLfloat *params);',
glMultiModeDrawArraysIBM = 'void glMultiModeDrawArraysIBM (const GLenum *mode, const GLint *first, const GLsizei *count, GLsizei primcount, GLint modestride);',
glMultiModeDrawElementsIBM = 'void glMultiModeDrawElementsIBM (const GLenum *mode, const GLsizei *count, GLenum type, const void *const*indices, GLsizei primcount, GLint modestride);',
glFlushStaticDataIBM = 'void glFlushStaticDataIBM (GLenum target);',
glColorPointerListIBM = 'void glColorPointerListIBM (GLint size, GLenum type, GLint stride, const void **pointer, GLint ptrstride);',
glSecondaryColorPointerListIBM = 'void glSecondaryColorPointerListIBM (GLint size, GLenum type, GLint stride, const void **pointer, GLint ptrstride);',
glEdgeFlagPointerListIBM = 'void glEdgeFlagPointerListIBM (GLint stride, const GLboolean **pointer, GLint ptrstride);',
glFogCoordPointerListIBM = 'void glFogCoordPointerListIBM (GLenum type, GLint stride, const void **pointer, GLint ptrstride);',
glIndexPointerListIBM = 'void glIndexPointerListIBM (GLenum type, GLint stride, const void **pointer, GLint ptrstride);',
glNormalPointerListIBM = 'void glNormalPointerListIBM (GLenum type, GLint stride, const void **pointer, GLint ptrstride);',
glTexCoordPointerListIBM = 'void glTexCoordPointerListIBM (GLint size, GLenum type, GLint stride, const void **pointer, GLint ptrstride);',
glVertexPointerListIBM = 'void glVertexPointerListIBM (GLint size, GLenum type, GLint stride, const void **pointer, GLint ptrstride);',
glBlendFuncSeparateINGR = 'void glBlendFuncSeparateINGR (GLenum sfactorRGB, GLenum dfactorRGB, GLenum sfactorAlpha, GLenum dfactorAlpha);',
glApplyFramebufferAttachmentCMAAINTEL = 'void glApplyFramebufferAttachmentCMAAINTEL (void);',
glSyncTextureINTEL = 'void glSyncTextureINTEL (GLuint texture);',
glUnmapTexture2DINTEL = 'void glUnmapTexture2DINTEL (GLuint texture, GLint level);',
glMapTexture2DINTEL = 'void * glMapTexture2DINTEL (GLuint texture, GLint level, GLbitfield access, GLint *stride, GLenum *layout);',
glVertexPointervINTEL = 'void glVertexPointervINTEL (GLint size, GLenum type, const void **pointer);',
glNormalPointervINTEL = 'void glNormalPointervINTEL (GLenum type, const void **pointer);',
glColorPointervINTEL = 'void glColorPointervINTEL (GLint size, GLenum type, const void **pointer);',
glTexCoordPointervINTEL = 'void glTexCoordPointervINTEL (GLint size, GLenum type, const void **pointer);',
glBeginPerfQueryINTEL = 'void glBeginPerfQueryINTEL (GLuint queryHandle);',
glCreatePerfQueryINTEL = 'void glCreatePerfQueryINTEL (GLuint queryId, GLuint *queryHandle);',
glDeletePerfQueryINTEL = 'void glDeletePerfQueryINTEL (GLuint queryHandle);',
glEndPerfQueryINTEL = 'void glEndPerfQueryINTEL (GLuint queryHandle);',
glGetFirstPerfQueryIdINTEL = 'void glGetFirstPerfQueryIdINTEL (GLuint *queryId);',
glGetNextPerfQueryIdINTEL = 'void glGetNextPerfQueryIdINTEL (GLuint queryId, GLuint *nextQueryId);',
glGetPerfCounterInfoINTEL = 'void glGetPerfCounterInfoINTEL (GLuint queryId, GLuint counterId, GLuint counterNameLength, GLchar *counterName, GLuint counterDescLength, GLchar *counterDesc, GLuint *counterOffset, GLuint *counterDataSize, GLuint *counterTypeEnum, GLuint *counterDataTypeEnum, GLuint64 *rawCounterMaxValue);',
glGetPerfQueryDataINTEL = 'void glGetPerfQueryDataINTEL (GLuint queryHandle, GLuint flags, GLsizei dataSize, void *data, GLuint *bytesWritten);',
glGetPerfQueryIdByNameINTEL = 'void glGetPerfQueryIdByNameINTEL (GLchar *queryName, GLuint *queryId);',
glGetPerfQueryInfoINTEL = 'void glGetPerfQueryInfoINTEL (GLuint queryId, GLuint queryNameLength, GLchar *queryName, GLuint *dataSize, GLuint *noCounters, GLuint *noInstances, GLuint *capsMask);',
glFramebufferParameteriMESA = 'void glFramebufferParameteriMESA (GLenum target, GLenum pname, GLint param);',
glGetFramebufferParameterivMESA = 'void glGetFramebufferParameterivMESA (GLenum target, GLenum pname, GLint *params);',
glResizeBuffersMESA = 'void glResizeBuffersMESA (void);',
glWindowPos2dMESA = 'void glWindowPos2dMESA (GLdouble x, GLdouble y);',
glWindowPos2dvMESA = 'void glWindowPos2dvMESA (const GLdouble *v);',
glWindowPos2fMESA = 'void glWindowPos2fMESA (GLfloat x, GLfloat y);',
glWindowPos2fvMESA = 'void glWindowPos2fvMESA (const GLfloat *v);',
glWindowPos2iMESA = 'void glWindowPos2iMESA (GLint x, GLint y);',
glWindowPos2ivMESA = 'void glWindowPos2ivMESA (const GLint *v);',
glWindowPos2sMESA = 'void glWindowPos2sMESA (GLshort x, GLshort y);',
glWindowPos2svMESA = 'void glWindowPos2svMESA (const GLshort *v);',
glWindowPos3dMESA = 'void glWindowPos3dMESA (GLdouble x, GLdouble y, GLdouble z);',
glWindowPos3dvMESA = 'void glWindowPos3dvMESA (const GLdouble *v);',
glWindowPos3fMESA = 'void glWindowPos3fMESA (GLfloat x, GLfloat y, GLfloat z);',
glWindowPos3fvMESA = 'void glWindowPos3fvMESA (const GLfloat *v);',
glWindowPos3iMESA = 'void glWindowPos3iMESA (GLint x, GLint y, GLint z);',
glWindowPos3ivMESA = 'void glWindowPos3ivMESA (const GLint *v);',
glWindowPos3sMESA = 'void glWindowPos3sMESA (GLshort x, GLshort y, GLshort z);',
glWindowPos3svMESA = 'void glWindowPos3svMESA (const GLshort *v);',
glWindowPos4dMESA = 'void glWindowPos4dMESA (GLdouble x, GLdouble y, GLdouble z, GLdouble w);',
glWindowPos4dvMESA = 'void glWindowPos4dvMESA (const GLdouble *v);',
glWindowPos4fMESA = 'void glWindowPos4fMESA (GLfloat x, GLfloat y, GLfloat z, GLfloat w);',
glWindowPos4fvMESA = 'void glWindowPos4fvMESA (const GLfloat *v);',
glWindowPos4iMESA = 'void glWindowPos4iMESA (GLint x, GLint y, GLint z, GLint w);',
glWindowPos4ivMESA = 'void glWindowPos4ivMESA (const GLint *v);',
glWindowPos4sMESA = 'void glWindowPos4sMESA (GLshort x, GLshort y, GLshort z, GLshort w);',
glWindowPos4svMESA = 'void glWindowPos4svMESA (const GLshort *v);',
glBeginConditionalRenderNVX = 'void glBeginConditionalRenderNVX (GLuint id);',
glEndConditionalRenderNVX = 'void glEndConditionalRenderNVX (void);',
glUploadGpuMaskNVX = 'void glUploadGpuMaskNVX (GLbitfield mask);',
glMulticastViewportArrayvNVX = 'void glMulticastViewportArrayvNVX (GLuint gpu, GLuint first, GLsizei count, const GLfloat *v);',
glMulticastViewportPositionWScaleNVX = 'void glMulticastViewportPositionWScaleNVX (GLuint gpu, GLuint index, GLfloat xcoeff, GLfloat ycoeff);',
glMulticastScissorArrayvNVX = 'void glMulticastScissorArrayvNVX (GLuint gpu, GLuint first, GLsizei count, const GLint *v);',
glAsyncCopyBufferSubDataNVX = 'GLuint glAsyncCopyBufferSubDataNVX (GLsizei waitSemaphoreCount, const GLuint *waitSemaphoreArray, const GLuint64 *fenceValueArray, GLuint readGpu, GLbitfield writeGpuMask, GLuint readBuffer, GLuint writeBuffer, GLintptr readOffset, GLintptr writeOffset, GLsizeiptr size, GLsizei signalSemaphoreCount, const GLuint *signalSemaphoreArray, const GLuint64 *signalValueArray);',
glAsyncCopyImageSubDataNVX = 'GLuint glAsyncCopyImageSubDataNVX (GLsizei waitSemaphoreCount, const GLuint *waitSemaphoreArray, const GLuint64 *waitValueArray, GLuint srcGpu, GLbitfield dstGpuMask, GLuint srcName, GLenum srcTarget, GLint srcLevel, GLint srcX, GLint srcY, GLint srcZ, GLuint dstName, GLenum dstTarget, GLint dstLevel, GLint dstX, GLint dstY, GLint dstZ, GLsizei srcWidth, GLsizei srcHeight, GLsizei srcDepth, GLsizei signalSemaphoreCount, const GLuint *signalSemaphoreArray, const GLuint64 *signalValueArray);',
glLGPUNamedBufferSubDataNVX = 'void glLGPUNamedBufferSubDataNVX (GLbitfield gpuMask, GLuint buffer, GLintptr offset, GLsizeiptr size, const void *data);',
glLGPUCopyImageSubDataNVX = 'void glLGPUCopyImageSubDataNVX (GLuint sourceGpu, GLbitfield destinationGpuMask, GLuint srcName, GLenum srcTarget, GLint srcLevel, GLint srcX, GLint srxY, GLint srcZ, GLuint dstName, GLenum dstTarget, GLint dstLevel, GLint dstX, GLint dstY, GLint dstZ, GLsizei width, GLsizei height, GLsizei depth);',
glLGPUInterlockNVX = 'void glLGPUInterlockNVX (void);',
glCreateProgressFenceNVX = 'GLuint glCreateProgressFenceNVX (void);',
glSignalSemaphoreui64NVX = 'void glSignalSemaphoreui64NVX (GLuint signalGpu, GLsizei fenceObjectCount, const GLuint *semaphoreArray, const GLuint64 *fenceValueArray);',
glWaitSemaphoreui64NVX = 'void glWaitSemaphoreui64NVX (GLuint waitGpu, GLsizei fenceObjectCount, const GLuint *semaphoreArray, const GLuint64 *fenceValueArray);',
glClientWaitSemaphoreui64NVX = 'void glClientWaitSemaphoreui64NVX (GLsizei fenceObjectCount, const GLuint *semaphoreArray, const GLuint64 *fenceValueArray);',
glAlphaToCoverageDitherControlNV = 'void glAlphaToCoverageDitherControlNV (GLenum mode);',
glMultiDrawArraysIndirectBindlessNV = 'void glMultiDrawArraysIndirectBindlessNV (GLenum mode, const void *indirect, GLsizei drawCount, GLsizei stride, GLint vertexBufferCount);',
glMultiDrawElementsIndirectBindlessNV = 'void glMultiDrawElementsIndirectBindlessNV (GLenum mode, GLenum type, const void *indirect, GLsizei drawCount, GLsizei stride, GLint vertexBufferCount);',
glMultiDrawArraysIndirectBindlessCountNV = 'void glMultiDrawArraysIndirectBindlessCountNV (GLenum mode, const void *indirect, GLsizei drawCount, GLsizei maxDrawCount, GLsizei stride, GLint vertexBufferCount);',
glMultiDrawElementsIndirectBindlessCountNV = 'void glMultiDrawElementsIndirectBindlessCountNV (GLenum mode, GLenum type, const void *indirect, GLsizei drawCount, GLsizei maxDrawCount, GLsizei stride, GLint vertexBufferCount);',
glGetTextureHandleNV = 'GLuint64 glGetTextureHandleNV (GLuint texture);',
glGetTextureSamplerHandleNV = 'GLuint64 glGetTextureSamplerHandleNV (GLuint texture, GLuint sampler);',
glMakeTextureHandleResidentNV = 'void glMakeTextureHandleResidentNV (GLuint64 handle);',
glMakeTextureHandleNonResidentNV = 'void glMakeTextureHandleNonResidentNV (GLuint64 handle);',
glGetImageHandleNV = 'GLuint64 glGetImageHandleNV (GLuint texture, GLint level, GLboolean layered, GLint layer, GLenum format);',
glMakeImageHandleResidentNV = 'void glMakeImageHandleResidentNV (GLuint64 handle, GLenum access);',
glMakeImageHandleNonResidentNV = 'void glMakeImageHandleNonResidentNV (GLuint64 handle);',
glUniformHandleui64NV = 'void glUniformHandleui64NV (GLint location, GLuint64 value);',
glUniformHandleui64vNV = 'void glUniformHandleui64vNV (GLint location, GLsizei count, const GLuint64 *value);',
glProgramUniformHandleui64NV = 'void glProgramUniformHandleui64NV (GLuint program, GLint location, GLuint64 value);',
glProgramUniformHandleui64vNV = 'void glProgramUniformHandleui64vNV (GLuint program, GLint location, GLsizei count, const GLuint64 *values);',
glIsTextureHandleResidentNV = 'GLboolean glIsTextureHandleResidentNV (GLuint64 handle);',
glIsImageHandleResidentNV = 'GLboolean glIsImageHandleResidentNV (GLuint64 handle);',
glBlendParameteriNV = 'void glBlendParameteriNV (GLenum pname, GLint value);',
glBlendBarrierNV = 'void glBlendBarrierNV (void);',
glViewportPositionWScaleNV = 'void glViewportPositionWScaleNV (GLuint index, GLfloat xcoeff, GLfloat ycoeff);',
glCreateStatesNV = 'void glCreateStatesNV (GLsizei n, GLuint *states);',
glDeleteStatesNV = 'void glDeleteStatesNV (GLsizei n, const GLuint *states);',
glIsStateNV = 'GLboolean glIsStateNV (GLuint state);',
glStateCaptureNV = 'void glStateCaptureNV (GLuint state, GLenum mode);',
glGetCommandHeaderNV = 'GLuint glGetCommandHeaderNV (GLenum tokenID, GLuint size);',
glGetStageIndexNV = 'GLushort glGetStageIndexNV (GLenum shadertype);',
glDrawCommandsNV = 'void glDrawCommandsNV (GLenum primitiveMode, GLuint buffer, const GLintptr *indirects, const GLsizei *sizes, GLuint count);',
glDrawCommandsAddressNV = 'void glDrawCommandsAddressNV (GLenum primitiveMode, const GLuint64 *indirects, const GLsizei *sizes, GLuint count);',
glDrawCommandsStatesNV = 'void glDrawCommandsStatesNV (GLuint buffer, const GLintptr *indirects, const GLsizei *sizes, const GLuint *states, const GLuint *fbos, GLuint count);',
glDrawCommandsStatesAddressNV = 'void glDrawCommandsStatesAddressNV (const GLuint64 *indirects, const GLsizei *sizes, const GLuint *states, const GLuint *fbos, GLuint count);',
glCreateCommandListsNV = 'void glCreateCommandListsNV (GLsizei n, GLuint *lists);',
glDeleteCommandListsNV = 'void glDeleteCommandListsNV (GLsizei n, const GLuint *lists);',
glIsCommandListNV = 'GLboolean glIsCommandListNV (GLuint list);',
glListDrawCommandsStatesClientNV = 'void glListDrawCommandsStatesClientNV (GLuint list, GLuint segment, const void **indirects, const GLsizei *sizes, const GLuint *states, const GLuint *fbos, GLuint count);',
glCommandListSegmentsNV = 'void glCommandListSegmentsNV (GLuint list, GLuint segments);',
glCompileCommandListNV = 'void glCompileCommandListNV (GLuint list);',
glCallCommandListNV = 'void glCallCommandListNV (GLuint list);',
glBeginConditionalRenderNV = 'void glBeginConditionalRenderNV (GLuint id, GLenum mode);',
glEndConditionalRenderNV = 'void glEndConditionalRenderNV (void);',
glSubpixelPrecisionBiasNV = 'void glSubpixelPrecisionBiasNV (GLuint xbits, GLuint ybits);',
glConservativeRasterParameterfNV = 'void glConservativeRasterParameterfNV (GLenum pname, GLfloat value);',
glConservativeRasterParameteriNV = 'void glConservativeRasterParameteriNV (GLenum pname, GLint param);',
glCopyImageSubDataNV = 'void glCopyImageSubDataNV (GLuint srcName, GLenum srcTarget, GLint srcLevel, GLint srcX, GLint srcY, GLint srcZ, GLuint dstName, GLenum dstTarget, GLint dstLevel, GLint dstX, GLint dstY, GLint dstZ, GLsizei width, GLsizei height, GLsizei depth);',
glDepthRangedNV = 'void glDepthRangedNV (GLdouble zNear, GLdouble zFar);',
glClearDepthdNV = 'void glClearDepthdNV (GLdouble depth);',
glDepthBoundsdNV = 'void glDepthBoundsdNV (GLdouble zmin, GLdouble zmax);',
glDrawTextureNV = 'void glDrawTextureNV (GLuint texture, GLuint sampler, GLfloat x0, GLfloat y0, GLfloat x1, GLfloat y1, GLfloat z, GLfloat s0, GLfloat t0, GLfloat s1, GLfloat t1);',
glDrawVkImageNV = 'void glDrawVkImageNV (GLuint64 vkImage, GLuint sampler, GLfloat x0, GLfloat y0, GLfloat x1, GLfloat y1, GLfloat z, GLfloat s0, GLfloat t0, GLfloat s1, GLfloat t1);',
glGetVkProcAddrNV = 'GLVULKANPROCNV glGetVkProcAddrNV (const GLchar *name);',
glWaitVkSemaphoreNV = 'void glWaitVkSemaphoreNV (GLuint64 vkSemaphore);',
glSignalVkSemaphoreNV = 'void glSignalVkSemaphoreNV (GLuint64 vkSemaphore);',
glSignalVkFenceNV = 'void glSignalVkFenceNV (GLuint64 vkFence);',
glMapControlPointsNV = 'void glMapControlPointsNV (GLenum target, GLuint index, GLenum type, GLsizei ustride, GLsizei vstride, GLint uorder, GLint vorder, GLboolean packed, const void *points);',
glMapParameterivNV = 'void glMapParameterivNV (GLenum target, GLenum pname, const GLint *params);',
glMapParameterfvNV = 'void glMapParameterfvNV (GLenum target, GLenum pname, const GLfloat *params);',
glGetMapControlPointsNV = 'void glGetMapControlPointsNV (GLenum target, GLuint index, GLenum type, GLsizei ustride, GLsizei vstride, GLboolean packed, void *points);',
glGetMapParameterivNV = 'void glGetMapParameterivNV (GLenum target, GLenum pname, GLint *params);',
glGetMapParameterfvNV = 'void glGetMapParameterfvNV (GLenum target, GLenum pname, GLfloat *params);',
glGetMapAttribParameterivNV = 'void glGetMapAttribParameterivNV (GLenum target, GLuint index, GLenum pname, GLint *params);',
glGetMapAttribParameterfvNV = 'void glGetMapAttribParameterfvNV (GLenum target, GLuint index, GLenum pname, GLfloat *params);',
glEvalMapsNV = 'void glEvalMapsNV (GLenum target, GLenum mode);',
glGetMultisamplefvNV = 'void glGetMultisamplefvNV (GLenum pname, GLuint index, GLfloat *val);',
glSampleMaskIndexedNV = 'void glSampleMaskIndexedNV (GLuint index, GLbitfield mask);',
glTexRenderbufferNV = 'void glTexRenderbufferNV (GLenum target, GLuint renderbuffer);',
glDeleteFencesNV = 'void glDeleteFencesNV (GLsizei n, const GLuint *fences);',
glGenFencesNV = 'void glGenFencesNV (GLsizei n, GLuint *fences);',
glIsFenceNV = 'GLboolean glIsFenceNV (GLuint fence);',
glTestFenceNV = 'GLboolean glTestFenceNV (GLuint fence);',
glGetFenceivNV = 'void glGetFenceivNV (GLuint fence, GLenum pname, GLint *params);',
glFinishFenceNV = 'void glFinishFenceNV (GLuint fence);',
glSetFenceNV = 'void glSetFenceNV (GLuint fence, GLenum condition);',
glFragmentCoverageColorNV = 'void glFragmentCoverageColorNV (GLuint color);',
glProgramNamedParameter4fNV = 'void glProgramNamedParameter4fNV (GLuint id, GLsizei len, const GLubyte *name, GLfloat x, GLfloat y, GLfloat z, GLfloat w);',
glProgramNamedParameter4fvNV = 'void glProgramNamedParameter4fvNV (GLuint id, GLsizei len, const GLubyte *name, const GLfloat *v);',
glProgramNamedParameter4dNV = 'void glProgramNamedParameter4dNV (GLuint id, GLsizei len, const GLubyte *name, GLdouble x, GLdouble y, GLdouble z, GLdouble w);',
glProgramNamedParameter4dvNV = 'void glProgramNamedParameter4dvNV (GLuint id, GLsizei len, const GLubyte *name, const GLdouble *v);',
glGetProgramNamedParameterfvNV = 'void glGetProgramNamedParameterfvNV (GLuint id, GLsizei len, const GLubyte *name, GLfloat *params);',
glGetProgramNamedParameterdvNV = 'void glGetProgramNamedParameterdvNV (GLuint id, GLsizei len, const GLubyte *name, GLdouble *params);',
glCoverageModulationTableNV = 'void glCoverageModulationTableNV (GLsizei n, const GLfloat *v);',
glGetCoverageModulationTableNV = 'void glGetCoverageModulationTableNV (GLsizei bufSize, GLfloat *v);',
glCoverageModulationNV = 'void glCoverageModulationNV (GLenum components);',
glRenderbufferStorageMultisampleCoverageNV = 'void glRenderbufferStorageMultisampleCoverageNV (GLenum target, GLsizei coverageSamples, GLsizei colorSamples, GLenum internalformat, GLsizei width, GLsizei height);',
glProgramVertexLimitNV = 'void glProgramVertexLimitNV (GLenum target, GLint limit);',
glFramebufferTextureEXT = 'void glFramebufferTextureEXT (GLenum target, GLenum attachment, GLuint texture, GLint level);',
glFramebufferTextureFaceEXT = 'void glFramebufferTextureFaceEXT (GLenum target, GLenum attachment, GLuint texture, GLint level, GLenum face);',
glRenderGpuMaskNV = 'void glRenderGpuMaskNV (GLbitfield mask);',
glMulticastBufferSubDataNV = 'void glMulticastBufferSubDataNV (GLbitfield gpuMask, GLuint buffer, GLintptr offset, GLsizeiptr size, const void *data);',
glMulticastCopyBufferSubDataNV = 'void glMulticastCopyBufferSubDataNV (GLuint readGpu, GLbitfield writeGpuMask, GLuint readBuffer, GLuint writeBuffer, GLintptr readOffset, GLintptr writeOffset, GLsizeiptr size);',
glMulticastCopyImageSubDataNV = 'void glMulticastCopyImageSubDataNV (GLuint srcGpu, GLbitfield dstGpuMask, GLuint srcName, GLenum srcTarget, GLint srcLevel, GLint srcX, GLint srcY, GLint srcZ, GLuint dstName, GLenum dstTarget, GLint dstLevel, GLint dstX, GLint dstY, GLint dstZ, GLsizei srcWidth, GLsizei srcHeight, GLsizei srcDepth);',
glMulticastBlitFramebufferNV = 'void glMulticastBlitFramebufferNV (GLuint srcGpu, GLuint dstGpu, GLint srcX0, GLint srcY0, GLint srcX1, GLint srcY1, GLint dstX0, GLint dstY0, GLint dstX1, GLint dstY1, GLbitfield mask, GLenum filter);',
glMulticastFramebufferSampleLocationsfvNV = 'void glMulticastFramebufferSampleLocationsfvNV (GLuint gpu, GLuint framebuffer, GLuint start, GLsizei count, const GLfloat *v);',
glMulticastBarrierNV = 'void glMulticastBarrierNV (void);',
glMulticastWaitSyncNV = 'void glMulticastWaitSyncNV (GLuint signalGpu, GLbitfield waitGpuMask);',
glMulticastGetQueryObjectivNV = 'void glMulticastGetQueryObjectivNV (GLuint gpu, GLuint id, GLenum pname, GLint *params);',
glMulticastGetQueryObjectuivNV = 'void glMulticastGetQueryObjectuivNV (GLuint gpu, GLuint id, GLenum pname, GLuint *params);',
glMulticastGetQueryObjecti64vNV = 'void glMulticastGetQueryObjecti64vNV (GLuint gpu, GLuint id, GLenum pname, GLint64 *params);',
glMulticastGetQueryObjectui64vNV = 'void glMulticastGetQueryObjectui64vNV (GLuint gpu, GLuint id, GLenum pname, GLuint64 *params);',
glProgramLocalParameterI4iNV = 'void glProgramLocalParameterI4iNV (GLenum target, GLuint index, GLint x, GLint y, GLint z, GLint w);',
glProgramLocalParameterI4ivNV = 'void glProgramLocalParameterI4ivNV (GLenum target, GLuint index, const GLint *params);',
glProgramLocalParametersI4ivNV = 'void glProgramLocalParametersI4ivNV (GLenum target, GLuint index, GLsizei count, const GLint *params);',
glProgramLocalParameterI4uiNV = 'void glProgramLocalParameterI4uiNV (GLenum target, GLuint index, GLuint x, GLuint y, GLuint z, GLuint w);',
glProgramLocalParameterI4uivNV = 'void glProgramLocalParameterI4uivNV (GLenum target, GLuint index, const GLuint *params);',
glProgramLocalParametersI4uivNV = 'void glProgramLocalParametersI4uivNV (GLenum target, GLuint index, GLsizei count, const GLuint *params);',
glProgramEnvParameterI4iNV = 'void glProgramEnvParameterI4iNV (GLenum target, GLuint index, GLint x, GLint y, GLint z, GLint w);',
glProgramEnvParameterI4ivNV = 'void glProgramEnvParameterI4ivNV (GLenum target, GLuint index, const GLint *params);',
glProgramEnvParametersI4ivNV = 'void glProgramEnvParametersI4ivNV (GLenum target, GLuint index, GLsizei count, const GLint *params);',
glProgramEnvParameterI4uiNV = 'void glProgramEnvParameterI4uiNV (GLenum target, GLuint index, GLuint x, GLuint y, GLuint z, GLuint w);',
glProgramEnvParameterI4uivNV = 'void glProgramEnvParameterI4uivNV (GLenum target, GLuint index, const GLuint *params);',
glProgramEnvParametersI4uivNV = 'void glProgramEnvParametersI4uivNV (GLenum target, GLuint index, GLsizei count, const GLuint *params);',
glGetProgramLocalParameterIivNV = 'void glGetProgramLocalParameterIivNV (GLenum target, GLuint index, GLint *params);',
glGetProgramLocalParameterIuivNV = 'void glGetProgramLocalParameterIuivNV (GLenum target, GLuint index, GLuint *params);',
glGetProgramEnvParameterIivNV = 'void glGetProgramEnvParameterIivNV (GLenum target, GLuint index, GLint *params);',
glGetProgramEnvParameterIuivNV = 'void glGetProgramEnvParameterIuivNV (GLenum target, GLuint index, GLuint *params);',
glProgramSubroutineParametersuivNV = 'void glProgramSubroutineParametersuivNV (GLenum target, GLsizei count, const GLuint *params);',
glGetProgramSubroutineParameteruivNV = 'void glGetProgramSubroutineParameteruivNV (GLenum target, GLuint index, GLuint *param);',
glVertex2hNV = 'void glVertex2hNV (GLhalfNV x, GLhalfNV y);',
glVertex2hvNV = 'void glVertex2hvNV (const GLhalfNV *v);',
glVertex3hNV = 'void glVertex3hNV (GLhalfNV x, GLhalfNV y, GLhalfNV z);',
glVertex3hvNV = 'void glVertex3hvNV (const GLhalfNV *v);',
glVertex4hNV = 'void glVertex4hNV (GLhalfNV x, GLhalfNV y, GLhalfNV z, GLhalfNV w);',
glVertex4hvNV = 'void glVertex4hvNV (const GLhalfNV *v);',
glNormal3hNV = 'void glNormal3hNV (GLhalfNV nx, GLhalfNV ny, GLhalfNV nz);',
glNormal3hvNV = 'void glNormal3hvNV (const GLhalfNV *v);',
glColor3hNV = 'void glColor3hNV (GLhalfNV red, GLhalfNV green, GLhalfNV blue);',
glColor3hvNV = 'void glColor3hvNV (const GLhalfNV *v);',
glColor4hNV = 'void glColor4hNV (GLhalfNV red, GLhalfNV green, GLhalfNV blue, GLhalfNV alpha);',
glColor4hvNV = 'void glColor4hvNV (const GLhalfNV *v);',
glTexCoord1hNV = 'void glTexCoord1hNV (GLhalfNV s);',
glTexCoord1hvNV = 'void glTexCoord1hvNV (const GLhalfNV *v);',
glTexCoord2hNV = 'void glTexCoord2hNV (GLhalfNV s, GLhalfNV t);',
glTexCoord2hvNV = 'void glTexCoord2hvNV (const GLhalfNV *v);',
glTexCoord3hNV = 'void glTexCoord3hNV (GLhalfNV s, GLhalfNV t, GLhalfNV r);',
glTexCoord3hvNV = 'void glTexCoord3hvNV (const GLhalfNV *v);',
glTexCoord4hNV = 'void glTexCoord4hNV (GLhalfNV s, GLhalfNV t, GLhalfNV r, GLhalfNV q);',
glTexCoord4hvNV = 'void glTexCoord4hvNV (const GLhalfNV *v);',
glMultiTexCoord1hNV = 'void glMultiTexCoord1hNV (GLenum target, GLhalfNV s);',
glMultiTexCoord1hvNV = 'void glMultiTexCoord1hvNV (GLenum target, const GLhalfNV *v);',
glMultiTexCoord2hNV = 'void glMultiTexCoord2hNV (GLenum target, GLhalfNV s, GLhalfNV t);',
glMultiTexCoord2hvNV = 'void glMultiTexCoord2hvNV (GLenum target, const GLhalfNV *v);',
glMultiTexCoord3hNV = 'void glMultiTexCoord3hNV (GLenum target, GLhalfNV s, GLhalfNV t, GLhalfNV r);',
glMultiTexCoord3hvNV = 'void glMultiTexCoord3hvNV (GLenum target, const GLhalfNV *v);',
glMultiTexCoord4hNV = 'void glMultiTexCoord4hNV (GLenum target, GLhalfNV s, GLhalfNV t, GLhalfNV r, GLhalfNV q);',
glMultiTexCoord4hvNV = 'void glMultiTexCoord4hvNV (GLenum target, const GLhalfNV *v);',
glFogCoordhNV = 'void glFogCoordhNV (GLhalfNV fog);',
glFogCoordhvNV = 'void glFogCoordhvNV (const GLhalfNV *fog);',
glSecondaryColor3hNV = 'void glSecondaryColor3hNV (GLhalfNV red, GLhalfNV green, GLhalfNV blue);',
glSecondaryColor3hvNV = 'void glSecondaryColor3hvNV (const GLhalfNV *v);',
glVertexWeighthNV = 'void glVertexWeighthNV (GLhalfNV weight);',
glVertexWeighthvNV = 'void glVertexWeighthvNV (const GLhalfNV *weight);',
glVertexAttrib1hNV = 'void glVertexAttrib1hNV (GLuint index, GLhalfNV x);',
glVertexAttrib1hvNV = 'void glVertexAttrib1hvNV (GLuint index, const GLhalfNV *v);',
glVertexAttrib2hNV = 'void glVertexAttrib2hNV (GLuint index, GLhalfNV x, GLhalfNV y);',
glVertexAttrib2hvNV = 'void glVertexAttrib2hvNV (GLuint index, const GLhalfNV *v);',
glVertexAttrib3hNV = 'void glVertexAttrib3hNV (GLuint index, GLhalfNV x, GLhalfNV y, GLhalfNV z);',
glVertexAttrib3hvNV = 'void glVertexAttrib3hvNV (GLuint index, const GLhalfNV *v);',
glVertexAttrib4hNV = 'void glVertexAttrib4hNV (GLuint index, GLhalfNV x, GLhalfNV y, GLhalfNV z, GLhalfNV w);',
glVertexAttrib4hvNV = 'void glVertexAttrib4hvNV (GLuint index, const GLhalfNV *v);',
glVertexAttribs1hvNV = 'void glVertexAttribs1hvNV (GLuint index, GLsizei n, const GLhalfNV *v);',
glVertexAttribs2hvNV = 'void glVertexAttribs2hvNV (GLuint index, GLsizei n, const GLhalfNV *v);',
glVertexAttribs3hvNV = 'void glVertexAttribs3hvNV (GLuint index, GLsizei n, const GLhalfNV *v);',
glVertexAttribs4hvNV = 'void glVertexAttribs4hvNV (GLuint index, GLsizei n, const GLhalfNV *v);',
glGetInternalformatSampleivNV = 'void glGetInternalformatSampleivNV (GLenum target, GLenum internalformat, GLsizei samples, GLenum pname, GLsizei count, GLint *params);',
glGetMemoryObjectDetachedResourcesuivNV = 'void glGetMemoryObjectDetachedResourcesuivNV (GLuint memory, GLenum pname, GLint first, GLsizei count, GLuint *params);',
glResetMemoryObjectParameterNV = 'void glResetMemoryObjectParameterNV (GLuint memory, GLenum pname);',
glTexAttachMemoryNV = 'void glTexAttachMemoryNV (GLenum target, GLuint memory, GLuint64 offset);',
glBufferAttachMemoryNV = 'void glBufferAttachMemoryNV (GLenum target, GLuint memory, GLuint64 offset);',
glTextureAttachMemoryNV = 'void glTextureAttachMemoryNV (GLuint texture, GLuint memory, GLuint64 offset);',
glNamedBufferAttachMemoryNV = 'void glNamedBufferAttachMemoryNV (GLuint buffer, GLuint memory, GLuint64 offset);',
glBufferPageCommitmentMemNV = 'void glBufferPageCommitmentMemNV (GLenum target, GLintptr offset, GLsizeiptr size, GLuint memory, GLuint64 memOffset, GLboolean commit);',
glTexPageCommitmentMemNV = 'void glTexPageCommitmentMemNV (GLenum target, GLint layer, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth, GLuint memory, GLuint64 offset, GLboolean commit);',
glNamedBufferPageCommitmentMemNV = 'void glNamedBufferPageCommitmentMemNV (GLuint buffer, GLintptr offset, GLsizeiptr size, GLuint memory, GLuint64 memOffset, GLboolean commit);',
glTexturePageCommitmentMemNV = 'void glTexturePageCommitmentMemNV (GLuint texture, GLint layer, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth, GLuint memory, GLuint64 offset, GLboolean commit);',
glDrawMeshTasksNV = 'void glDrawMeshTasksNV (GLuint first, GLuint count);',
glDrawMeshTasksIndirectNV = 'void glDrawMeshTasksIndirectNV (GLintptr indirect);',
glMultiDrawMeshTasksIndirectNV = 'void glMultiDrawMeshTasksIndirectNV (GLintptr indirect, GLsizei drawcount, GLsizei stride);',
glMultiDrawMeshTasksIndirectCountNV = 'void glMultiDrawMeshTasksIndirectCountNV (GLintptr indirect, GLintptr drawcount, GLsizei maxdrawcount, GLsizei stride);',
glGenOcclusionQueriesNV = 'void glGenOcclusionQueriesNV (GLsizei n, GLuint *ids);',
glDeleteOcclusionQueriesNV = 'void glDeleteOcclusionQueriesNV (GLsizei n, const GLuint *ids);',
glIsOcclusionQueryNV = 'GLboolean glIsOcclusionQueryNV (GLuint id);',
glBeginOcclusionQueryNV = 'void glBeginOcclusionQueryNV (GLuint id);',
glEndOcclusionQueryNV = 'void glEndOcclusionQueryNV (void);',
glGetOcclusionQueryivNV = 'void glGetOcclusionQueryivNV (GLuint id, GLenum pname, GLint *params);',
glGetOcclusionQueryuivNV = 'void glGetOcclusionQueryuivNV (GLuint id, GLenum pname, GLuint *params);',
glProgramBufferParametersfvNV = 'void glProgramBufferParametersfvNV (GLenum target, GLuint bindingIndex, GLuint wordIndex, GLsizei count, const GLfloat *params);',
glProgramBufferParametersIivNV = 'void glProgramBufferParametersIivNV (GLenum target, GLuint bindingIndex, GLuint wordIndex, GLsizei count, const GLint *params);',
glProgramBufferParametersIuivNV = 'void glProgramBufferParametersIuivNV (GLenum target, GLuint bindingIndex, GLuint wordIndex, GLsizei count, const GLuint *params);',
glGenPathsNV = 'GLuint glGenPathsNV (GLsizei range);',
glDeletePathsNV = 'void glDeletePathsNV (GLuint path, GLsizei range);',
glIsPathNV = 'GLboolean glIsPathNV (GLuint path);',
glPathCommandsNV = 'void glPathCommandsNV (GLuint path, GLsizei numCommands, const GLubyte *commands, GLsizei numCoords, GLenum coordType, const void *coords);',
glPathCoordsNV = 'void glPathCoordsNV (GLuint path, GLsizei numCoords, GLenum coordType, const void *coords);',
glPathSubCommandsNV = 'void glPathSubCommandsNV (GLuint path, GLsizei commandStart, GLsizei commandsToDelete, GLsizei numCommands, const GLubyte *commands, GLsizei numCoords, GLenum coordType, const void *coords);',
glPathSubCoordsNV = 'void glPathSubCoordsNV (GLuint path, GLsizei coordStart, GLsizei numCoords, GLenum coordType, const void *coords);',
glPathStringNV = 'void glPathStringNV (GLuint path, GLenum format, GLsizei length, const void *pathString);',
glPathGlyphsNV = 'void glPathGlyphsNV (GLuint firstPathName, GLenum fontTarget, const void *fontName, GLbitfield fontStyle, GLsizei numGlyphs, GLenum type, const void *charcodes, GLenum handleMissingGlyphs, GLuint pathParameterTemplate, GLfloat emScale);',
glPathGlyphRangeNV = 'void glPathGlyphRangeNV (GLuint firstPathName, GLenum fontTarget, const void *fontName, GLbitfield fontStyle, GLuint firstGlyph, GLsizei numGlyphs, GLenum handleMissingGlyphs, GLuint pathParameterTemplate, GLfloat emScale);',
glWeightPathsNV = 'void glWeightPathsNV (GLuint resultPath, GLsizei numPaths, const GLuint *paths, const GLfloat *weights);',
glCopyPathNV = 'void glCopyPathNV (GLuint resultPath, GLuint srcPath);',
glInterpolatePathsNV = 'void glInterpolatePathsNV (GLuint resultPath, GLuint pathA, GLuint pathB, GLfloat weight);',
glTransformPathNV = 'void glTransformPathNV (GLuint resultPath, GLuint srcPath, GLenum transformType, const GLfloat *transformValues);',
glPathParameterivNV = 'void glPathParameterivNV (GLuint path, GLenum pname, const GLint *value);',
glPathParameteriNV = 'void glPathParameteriNV (GLuint path, GLenum pname, GLint value);',
glPathParameterfvNV = 'void glPathParameterfvNV (GLuint path, GLenum pname, const GLfloat *value);',
glPathParameterfNV = 'void glPathParameterfNV (GLuint path, GLenum pname, GLfloat value);',
glPathDashArrayNV = 'void glPathDashArrayNV (GLuint path, GLsizei dashCount, const GLfloat *dashArray);',
glPathStencilFuncNV = 'void glPathStencilFuncNV (GLenum func, GLint ref, GLuint mask);',
glPathStencilDepthOffsetNV = 'void glPathStencilDepthOffsetNV (GLfloat factor, GLfloat units);',
glStencilFillPathNV = 'void glStencilFillPathNV (GLuint path, GLenum fillMode, GLuint mask);',
glStencilStrokePathNV = 'void glStencilStrokePathNV (GLuint path, GLint reference, GLuint mask);',
glStencilFillPathInstancedNV = 'void glStencilFillPathInstancedNV (GLsizei numPaths, GLenum pathNameType, const void *paths, GLuint pathBase, GLenum fillMode, GLuint mask, GLenum transformType, const GLfloat *transformValues);',
glStencilStrokePathInstancedNV = 'void glStencilStrokePathInstancedNV (GLsizei numPaths, GLenum pathNameType, const void *paths, GLuint pathBase, GLint reference, GLuint mask, GLenum transformType, const GLfloat *transformValues);',
glPathCoverDepthFuncNV = 'void glPathCoverDepthFuncNV (GLenum func);',
glCoverFillPathNV = 'void glCoverFillPathNV (GLuint path, GLenum coverMode);',
glCoverStrokePathNV = 'void glCoverStrokePathNV (GLuint path, GLenum coverMode);',
glCoverFillPathInstancedNV = 'void glCoverFillPathInstancedNV (GLsizei numPaths, GLenum pathNameType, const void *paths, GLuint pathBase, GLenum coverMode, GLenum transformType, const GLfloat *transformValues);',
glCoverStrokePathInstancedNV = 'void glCoverStrokePathInstancedNV (GLsizei numPaths, GLenum pathNameType, const void *paths, GLuint pathBase, GLenum coverMode, GLenum transformType, const GLfloat *transformValues);',
glGetPathParameterivNV = 'void glGetPathParameterivNV (GLuint path, GLenum pname, GLint *value);',
glGetPathParameterfvNV = 'void glGetPathParameterfvNV (GLuint path, GLenum pname, GLfloat *value);',
glGetPathCommandsNV = 'void glGetPathCommandsNV (GLuint path, GLubyte *commands);',
glGetPathCoordsNV = 'void glGetPathCoordsNV (GLuint path, GLfloat *coords);',
glGetPathDashArrayNV = 'void glGetPathDashArrayNV (GLuint path, GLfloat *dashArray);',
glGetPathMetricsNV = 'void glGetPathMetricsNV (GLbitfield metricQueryMask, GLsizei numPaths, GLenum pathNameType, const void *paths, GLuint pathBase, GLsizei stride, GLfloat *metrics);',
glGetPathMetricRangeNV = 'void glGetPathMetricRangeNV (GLbitfield metricQueryMask, GLuint firstPathName, GLsizei numPaths, GLsizei stride, GLfloat *metrics);',
glGetPathSpacingNV = 'void glGetPathSpacingNV (GLenum pathListMode, GLsizei numPaths, GLenum pathNameType, const void *paths, GLuint pathBase, GLfloat advanceScale, GLfloat kerningScale, GLenum transformType, GLfloat *returnedSpacing);',
glIsPointInFillPathNV = 'GLboolean glIsPointInFillPathNV (GLuint path, GLuint mask, GLfloat x, GLfloat y);',
glIsPointInStrokePathNV = 'GLboolean glIsPointInStrokePathNV (GLuint path, GLfloat x, GLfloat y);',
glGetPathLengthNV = 'GLfloat glGetPathLengthNV (GLuint path, GLsizei startSegment, GLsizei numSegments);',
glPointAlongPathNV = 'GLboolean glPointAlongPathNV (GLuint path, GLsizei startSegment, GLsizei numSegments, GLfloat distance, GLfloat *x, GLfloat *y, GLfloat *tangentX, GLfloat *tangentY);',
glMatrixLoad3x2fNV = 'void glMatrixLoad3x2fNV (GLenum matrixMode, const GLfloat *m);',
glMatrixLoad3x3fNV = 'void glMatrixLoad3x3fNV (GLenum matrixMode, const GLfloat *m);',
glMatrixLoadTranspose3x3fNV = 'void glMatrixLoadTranspose3x3fNV (GLenum matrixMode, const GLfloat *m);',
glMatrixMult3x2fNV = 'void glMatrixMult3x2fNV (GLenum matrixMode, const GLfloat *m);',
glMatrixMult3x3fNV = 'void glMatrixMult3x3fNV (GLenum matrixMode, const GLfloat *m);',
glMatrixMultTranspose3x3fNV = 'void glMatrixMultTranspose3x3fNV (GLenum matrixMode, const GLfloat *m);',
glStencilThenCoverFillPathNV = 'void glStencilThenCoverFillPathNV (GLuint path, GLenum fillMode, GLuint mask, GLenum coverMode);',
glStencilThenCoverStrokePathNV = 'void glStencilThenCoverStrokePathNV (GLuint path, GLint reference, GLuint mask, GLenum coverMode);',
glStencilThenCoverFillPathInstancedNV = 'void glStencilThenCoverFillPathInstancedNV (GLsizei numPaths, GLenum pathNameType, const void *paths, GLuint pathBase, GLenum fillMode, GLuint mask, GLenum coverMode, GLenum transformType, const GLfloat *transformValues);',
glStencilThenCoverStrokePathInstancedNV = 'void glStencilThenCoverStrokePathInstancedNV (GLsizei numPaths, GLenum pathNameType, const void *paths, GLuint pathBase, GLint reference, GLuint mask, GLenum coverMode, GLenum transformType, const GLfloat *transformValues);',
glPathGlyphIndexRangeNV = 'GLenum glPathGlyphIndexRangeNV (GLenum fontTarget, const void *fontName, GLbitfield fontStyle, GLuint pathParameterTemplate, GLfloat emScale, GLuint baseAndCount[2]);',
glPathGlyphIndexArrayNV = 'GLenum glPathGlyphIndexArrayNV (GLuint firstPathName, GLenum fontTarget, const void *fontName, GLbitfield fontStyle, GLuint firstGlyphIndex, GLsizei numGlyphs, GLuint pathParameterTemplate, GLfloat emScale);',
glPathMemoryGlyphIndexArrayNV = 'GLenum glPathMemoryGlyphIndexArrayNV (GLuint firstPathName, GLenum fontTarget, GLsizeiptr fontSize, const void *fontData, GLsizei faceIndex, GLuint firstGlyphIndex, GLsizei numGlyphs, GLuint pathParameterTemplate, GLfloat emScale);',
glProgramPathFragmentInputGenNV = 'void glProgramPathFragmentInputGenNV (GLuint program, GLint location, GLenum genMode, GLint components, const GLfloat *coeffs);',
glGetProgramResourcefvNV = 'void glGetProgramResourcefvNV (GLuint program, GLenum programInterface, GLuint index, GLsizei propCount, const GLenum *props, GLsizei count, GLsizei *length, GLfloat *params);',
glPathColorGenNV = 'void glPathColorGenNV (GLenum color, GLenum genMode, GLenum colorFormat, const GLfloat *coeffs);',
glPathTexGenNV = 'void glPathTexGenNV (GLenum texCoordSet, GLenum genMode, GLint components, const GLfloat *coeffs);',
glPathFogGenNV = 'void glPathFogGenNV (GLenum genMode);',
glGetPathColorGenivNV = 'void glGetPathColorGenivNV (GLenum color, GLenum pname, GLint *value);',
glGetPathColorGenfvNV = 'void glGetPathColorGenfvNV (GLenum color, GLenum pname, GLfloat *value);',
glGetPathTexGenivNV = 'void glGetPathTexGenivNV (GLenum texCoordSet, GLenum pname, GLint *value);',
glGetPathTexGenfvNV = 'void glGetPathTexGenfvNV (GLenum texCoordSet, GLenum pname, GLfloat *value);',
glPixelDataRangeNV = 'void glPixelDataRangeNV (GLenum target, GLsizei length, const void *pointer);',
glFlushPixelDataRangeNV = 'void glFlushPixelDataRangeNV (GLenum target);',
glPointParameteriNV = 'void glPointParameteriNV (GLenum pname, GLint param);',
glPointParameterivNV = 'void glPointParameterivNV (GLenum pname, const GLint *params);',
glPresentFrameKeyedNV = 'void glPresentFrameKeyedNV (GLuint video_slot, GLuint64EXT minPresentTime, GLuint beginPresentTimeId, GLuint presentDurationId, GLenum type, GLenum target0, GLuint fill0, GLuint key0, GLenum target1, GLuint fill1, GLuint key1);',
glPresentFrameDualFillNV = 'void glPresentFrameDualFillNV (GLuint video_slot, GLuint64EXT minPresentTime, GLuint beginPresentTimeId, GLuint presentDurationId, GLenum type, GLenum target0, GLuint fill0, GLenum target1, GLuint fill1, GLenum target2, GLuint fill2, GLenum target3, GLuint fill3);',
glGetVideoivNV = 'void glGetVideoivNV (GLuint video_slot, GLenum pname, GLint *params);',
glGetVideouivNV = 'void glGetVideouivNV (GLuint video_slot, GLenum pname, GLuint *params);',
glGetVideoi64vNV = 'void glGetVideoi64vNV (GLuint video_slot, GLenum pname, GLint64EXT *params);',
glGetVideoui64vNV = 'void glGetVideoui64vNV (GLuint video_slot, GLenum pname, GLuint64EXT *params);',
glPrimitiveRestartNV = 'void glPrimitiveRestartNV (void);',
glPrimitiveRestartIndexNV = 'void glPrimitiveRestartIndexNV (GLuint index);',
glQueryResourceNV = 'GLint glQueryResourceNV (GLenum queryType, GLint tagId, GLuint count, GLint *buffer);',
glGenQueryResourceTagNV = 'void glGenQueryResourceTagNV (GLsizei n, GLint *tagIds);',
glDeleteQueryResourceTagNV = 'void glDeleteQueryResourceTagNV (GLsizei n, const GLint *tagIds);',
glQueryResourceTagNV = 'void glQueryResourceTagNV (GLint tagId, const GLchar *tagString);',
glCombinerParameterfvNV = 'void glCombinerParameterfvNV (GLenum pname, const GLfloat *params);',
glCombinerParameterfNV = 'void glCombinerParameterfNV (GLenum pname, GLfloat param);',
glCombinerParameterivNV = 'void glCombinerParameterivNV (GLenum pname, const GLint *params);',
glCombinerParameteriNV = 'void glCombinerParameteriNV (GLenum pname, GLint param);',
glCombinerInputNV = 'void glCombinerInputNV (GLenum stage, GLenum portion, GLenum variable, GLenum input, GLenum mapping, GLenum componentUsage);',
glCombinerOutputNV = 'void glCombinerOutputNV (GLenum stage, GLenum portion, GLenum abOutput, GLenum cdOutput, GLenum sumOutput, GLenum scale, GLenum bias, GLboolean abDotProduct, GLboolean cdDotProduct, GLboolean muxSum);',
glFinalCombinerInputNV = 'void glFinalCombinerInputNV (GLenum variable, GLenum input, GLenum mapping, GLenum componentUsage);',
glGetCombinerInputParameterfvNV = 'void glGetCombinerInputParameterfvNV (GLenum stage, GLenum portion, GLenum variable, GLenum pname, GLfloat *params);',
glGetCombinerInputParameterivNV = 'void glGetCombinerInputParameterivNV (GLenum stage, GLenum portion, GLenum variable, GLenum pname, GLint *params);',
glGetCombinerOutputParameterfvNV = 'void glGetCombinerOutputParameterfvNV (GLenum stage, GLenum portion, GLenum pname, GLfloat *params);',
glGetCombinerOutputParameterivNV = 'void glGetCombinerOutputParameterivNV (GLenum stage, GLenum portion, GLenum pname, GLint *params);',
glGetFinalCombinerInputParameterfvNV = 'void glGetFinalCombinerInputParameterfvNV (GLenum variable, GLenum pname, GLfloat *params);',
glGetFinalCombinerInputParameterivNV = 'void glGetFinalCombinerInputParameterivNV (GLenum variable, GLenum pname, GLint *params);',
glCombinerStageParameterfvNV = 'void glCombinerStageParameterfvNV (GLenum stage, GLenum pname, const GLfloat *params);',
glGetCombinerStageParameterfvNV = 'void glGetCombinerStageParameterfvNV (GLenum stage, GLenum pname, GLfloat *params);',
glFramebufferSampleLocationsfvNV = 'void glFramebufferSampleLocationsfvNV (GLenum target, GLuint start, GLsizei count, const GLfloat *v);',
glNamedFramebufferSampleLocationsfvNV = 'void glNamedFramebufferSampleLocationsfvNV (GLuint framebuffer, GLuint start, GLsizei count, const GLfloat *v);',
glResolveDepthValuesNV = 'void glResolveDepthValuesNV (void);',
glScissorExclusiveNV = 'void glScissorExclusiveNV (GLint x, GLint y, GLsizei width, GLsizei height);',
glScissorExclusiveArrayvNV = 'void glScissorExclusiveArrayvNV (GLuint first, GLsizei count, const GLint *v);',
glMakeBufferResidentNV = 'void glMakeBufferResidentNV (GLenum target, GLenum access);',
glMakeBufferNonResidentNV = 'void glMakeBufferNonResidentNV (GLenum target);',
glIsBufferResidentNV = 'GLboolean glIsBufferResidentNV (GLenum target);',
glMakeNamedBufferResidentNV = 'void glMakeNamedBufferResidentNV (GLuint buffer, GLenum access);',
glMakeNamedBufferNonResidentNV = 'void glMakeNamedBufferNonResidentNV (GLuint buffer);',
glIsNamedBufferResidentNV = 'GLboolean glIsNamedBufferResidentNV (GLuint buffer);',
glGetBufferParameterui64vNV = 'void glGetBufferParameterui64vNV (GLenum target, GLenum pname, GLuint64EXT *params);',
glGetNamedBufferParameterui64vNV = 'void glGetNamedBufferParameterui64vNV (GLuint buffer, GLenum pname, GLuint64EXT *params);',
glGetIntegerui64vNV = 'void glGetIntegerui64vNV (GLenum value, GLuint64EXT *result);',
glUniformui64NV = 'void glUniformui64NV (GLint location, GLuint64EXT value);',
glUniformui64vNV = 'void glUniformui64vNV (GLint location, GLsizei count, const GLuint64EXT *value);',
glProgramUniformui64NV = 'void glProgramUniformui64NV (GLuint program, GLint location, GLuint64EXT value);',
glProgramUniformui64vNV = 'void glProgramUniformui64vNV (GLuint program, GLint location, GLsizei count, const GLuint64EXT *value);',
glBindShadingRateImageNV = 'void glBindShadingRateImageNV (GLuint texture);',
glGetShadingRateImagePaletteNV = 'void glGetShadingRateImagePaletteNV (GLuint viewport, GLuint entry, GLenum *rate);',
glGetShadingRateSampleLocationivNV = 'void glGetShadingRateSampleLocationivNV (GLenum rate, GLuint samples, GLuint index, GLint *location);',
glShadingRateImageBarrierNV = 'void glShadingRateImageBarrierNV (GLboolean synchronize);',
glShadingRateImagePaletteNV = 'void glShadingRateImagePaletteNV (GLuint viewport, GLuint first, GLsizei count, const GLenum *rates);',
glShadingRateSampleOrderNV = 'void glShadingRateSampleOrderNV (GLenum order);',
glShadingRateSampleOrderCustomNV = 'void glShadingRateSampleOrderCustomNV (GLenum rate, GLuint samples, const GLint *locations);',
glTextureBarrierNV = 'void glTextureBarrierNV (void);',
glTexImage2DMultisampleCoverageNV = 'void glTexImage2DMultisampleCoverageNV (GLenum target, GLsizei coverageSamples, GLsizei colorSamples, GLint internalFormat, GLsizei width, GLsizei height, GLboolean fixedSampleLocations);',
glTexImage3DMultisampleCoverageNV = 'void glTexImage3DMultisampleCoverageNV (GLenum target, GLsizei coverageSamples, GLsizei colorSamples, GLint internalFormat, GLsizei width, GLsizei height, GLsizei depth, GLboolean fixedSampleLocations);',
glTextureImage2DMultisampleNV = 'void glTextureImage2DMultisampleNV (GLuint texture, GLenum target, GLsizei samples, GLint internalFormat, GLsizei width, GLsizei height, GLboolean fixedSampleLocations);',
glTextureImage3DMultisampleNV = 'void glTextureImage3DMultisampleNV (GLuint texture, GLenum target, GLsizei samples, GLint internalFormat, GLsizei width, GLsizei height, GLsizei depth, GLboolean fixedSampleLocations);',
glTextureImage2DMultisampleCoverageNV = 'void glTextureImage2DMultisampleCoverageNV (GLuint texture, GLenum target, GLsizei coverageSamples, GLsizei colorSamples, GLint internalFormat, GLsizei width, GLsizei height, GLboolean fixedSampleLocations);',
glTextureImage3DMultisampleCoverageNV = 'void glTextureImage3DMultisampleCoverageNV (GLuint texture, GLenum target, GLsizei coverageSamples, GLsizei colorSamples, GLint internalFormat, GLsizei width, GLsizei height, GLsizei depth, GLboolean fixedSampleLocations);',
glCreateSemaphoresNV = 'void glCreateSemaphoresNV (GLsizei n, GLuint *semaphores);',
glSemaphoreParameterivNV = 'void glSemaphoreParameterivNV (GLuint semaphore, GLenum pname, const GLint *params);',
glGetSemaphoreParameterivNV = 'void glGetSemaphoreParameterivNV (GLuint semaphore, GLenum pname, GLint *params);',
glBeginTransformFeedbackNV = 'void glBeginTransformFeedbackNV (GLenum primitiveMode);',
glEndTransformFeedbackNV = 'void glEndTransformFeedbackNV (void);',
glTransformFeedbackAttribsNV = 'void glTransformFeedbackAttribsNV (GLsizei count, const GLint *attribs, GLenum bufferMode);',
glBindBufferRangeNV = 'void glBindBufferRangeNV (GLenum target, GLuint index, GLuint buffer, GLintptr offset, GLsizeiptr size);',
glBindBufferOffsetNV = 'void glBindBufferOffsetNV (GLenum target, GLuint index, GLuint buffer, GLintptr offset);',
glBindBufferBaseNV = 'void glBindBufferBaseNV (GLenum target, GLuint index, GLuint buffer);',
glTransformFeedbackVaryingsNV = 'void glTransformFeedbackVaryingsNV (GLuint program, GLsizei count, const GLint *locations, GLenum bufferMode);',
glActiveVaryingNV = 'void glActiveVaryingNV (GLuint program, const GLchar *name);',
glGetVaryingLocationNV = 'GLint glGetVaryingLocationNV (GLuint program, const GLchar *name);',
glGetActiveVaryingNV = 'void glGetActiveVaryingNV (GLuint program, GLuint index, GLsizei bufSize, GLsizei *length, GLsizei *size, GLenum *type, GLchar *name);',
glGetTransformFeedbackVaryingNV = 'void glGetTransformFeedbackVaryingNV (GLuint program, GLuint index, GLint *location);',
glTransformFeedbackStreamAttribsNV = 'void glTransformFeedbackStreamAttribsNV (GLsizei count, const GLint *attribs, GLsizei nbuffers, const GLint *bufstreams, GLenum bufferMode);',
glBindTransformFeedbackNV = 'void glBindTransformFeedbackNV (GLenum target, GLuint id);',
glDeleteTransformFeedbacksNV = 'void glDeleteTransformFeedbacksNV (GLsizei n, const GLuint *ids);',
glGenTransformFeedbacksNV = 'void glGenTransformFeedbacksNV (GLsizei n, GLuint *ids);',
glIsTransformFeedbackNV = 'GLboolean glIsTransformFeedbackNV (GLuint id);',
glPauseTransformFeedbackNV = 'void glPauseTransformFeedbackNV (void);',
glResumeTransformFeedbackNV = 'void glResumeTransformFeedbackNV (void);',
glDrawTransformFeedbackNV = 'void glDrawTransformFeedbackNV (GLenum mode, GLuint id);',
glVDPAUInitNV = 'void glVDPAUInitNV (const void *vdpDevice, const void *getProcAddress);',
glVDPAUFiniNV = 'void glVDPAUFiniNV (void);',
glVDPAURegisterVideoSurfaceNV = 'GLvdpauSurfaceNV glVDPAURegisterVideoSurfaceNV (const void *vdpSurface, GLenum target, GLsizei numTextureNames, const GLuint *textureNames);',
glVDPAURegisterOutputSurfaceNV = 'GLvdpauSurfaceNV glVDPAURegisterOutputSurfaceNV (const void *vdpSurface, GLenum target, GLsizei numTextureNames, const GLuint *textureNames);',
glVDPAUIsSurfaceNV = 'GLboolean glVDPAUIsSurfaceNV (GLvdpauSurfaceNV surface);',
glVDPAUUnregisterSurfaceNV = 'void glVDPAUUnregisterSurfaceNV (GLvdpauSurfaceNV surface);',
glVDPAUGetSurfaceivNV = 'void glVDPAUGetSurfaceivNV (GLvdpauSurfaceNV surface, GLenum pname, GLsizei count, GLsizei *length, GLint *values);',
glVDPAUSurfaceAccessNV = 'void glVDPAUSurfaceAccessNV (GLvdpauSurfaceNV surface, GLenum access);',
glVDPAUMapSurfacesNV = 'void glVDPAUMapSurfacesNV (GLsizei numSurfaces, const GLvdpauSurfaceNV *surfaces);',
glVDPAUUnmapSurfacesNV = 'void glVDPAUUnmapSurfacesNV (GLsizei numSurface, const GLvdpauSurfaceNV *surfaces);',
glVDPAURegisterVideoSurfaceWithPictureStructureNV = 'GLvdpauSurfaceNV glVDPAURegisterVideoSurfaceWithPictureStructureNV (const void *vdpSurface, GLenum target, GLsizei numTextureNames, const GLuint *textureNames, GLboolean isFrameStructure);',
glFlushVertexArrayRangeNV = 'void glFlushVertexArrayRangeNV (void);',
glVertexArrayRangeNV = 'void glVertexArrayRangeNV (GLsizei length, const void *pointer);',
glVertexAttribL1i64NV = 'void glVertexAttribL1i64NV (GLuint index, GLint64EXT x);',
glVertexAttribL2i64NV = 'void glVertexAttribL2i64NV (GLuint index, GLint64EXT x, GLint64EXT y);',
glVertexAttribL3i64NV = 'void glVertexAttribL3i64NV (GLuint index, GLint64EXT x, GLint64EXT y, GLint64EXT z);',
glVertexAttribL4i64NV = 'void glVertexAttribL4i64NV (GLuint index, GLint64EXT x, GLint64EXT y, GLint64EXT z, GLint64EXT w);',
glVertexAttribL1i64vNV = 'void glVertexAttribL1i64vNV (GLuint index, const GLint64EXT *v);',
glVertexAttribL2i64vNV = 'void glVertexAttribL2i64vNV (GLuint index, const GLint64EXT *v);',
glVertexAttribL3i64vNV = 'void glVertexAttribL3i64vNV (GLuint index, const GLint64EXT *v);',
glVertexAttribL4i64vNV = 'void glVertexAttribL4i64vNV (GLuint index, const GLint64EXT *v);',
glVertexAttribL1ui64NV = 'void glVertexAttribL1ui64NV (GLuint index, GLuint64EXT x);',
glVertexAttribL2ui64NV = 'void glVertexAttribL2ui64NV (GLuint index, GLuint64EXT x, GLuint64EXT y);',
glVertexAttribL3ui64NV = 'void glVertexAttribL3ui64NV (GLuint index, GLuint64EXT x, GLuint64EXT y, GLuint64EXT z);',
glVertexAttribL4ui64NV = 'void glVertexAttribL4ui64NV (GLuint index, GLuint64EXT x, GLuint64EXT y, GLuint64EXT z, GLuint64EXT w);',
glVertexAttribL1ui64vNV = 'void glVertexAttribL1ui64vNV (GLuint index, const GLuint64EXT *v);',
glVertexAttribL2ui64vNV = 'void glVertexAttribL2ui64vNV (GLuint index, const GLuint64EXT *v);',
glVertexAttribL3ui64vNV = 'void glVertexAttribL3ui64vNV (GLuint index, const GLuint64EXT *v);',
glVertexAttribL4ui64vNV = 'void glVertexAttribL4ui64vNV (GLuint index, const GLuint64EXT *v);',
glGetVertexAttribLi64vNV = 'void glGetVertexAttribLi64vNV (GLuint index, GLenum pname, GLint64EXT *params);',
glGetVertexAttribLui64vNV = 'void glGetVertexAttribLui64vNV (GLuint index, GLenum pname, GLuint64EXT *params);',
glVertexAttribLFormatNV = 'void glVertexAttribLFormatNV (GLuint index, GLint size, GLenum type, GLsizei stride);',
glBufferAddressRangeNV = 'void glBufferAddressRangeNV (GLenum pname, GLuint index, GLuint64EXT address, GLsizeiptr length);',
glVertexFormatNV = 'void glVertexFormatNV (GLint size, GLenum type, GLsizei stride);',
glNormalFormatNV = 'void glNormalFormatNV (GLenum type, GLsizei stride);',
glColorFormatNV = 'void glColorFormatNV (GLint size, GLenum type, GLsizei stride);',
glIndexFormatNV = 'void glIndexFormatNV (GLenum type, GLsizei stride);',
glTexCoordFormatNV = 'void glTexCoordFormatNV (GLint size, GLenum type, GLsizei stride);',
glEdgeFlagFormatNV = 'void glEdgeFlagFormatNV (GLsizei stride);',
glSecondaryColorFormatNV = 'void glSecondaryColorFormatNV (GLint size, GLenum type, GLsizei stride);',
glFogCoordFormatNV = 'void glFogCoordFormatNV (GLenum type, GLsizei stride);',
glVertexAttribFormatNV = 'void glVertexAttribFormatNV (GLuint index, GLint size, GLenum type, GLboolean normalized, GLsizei stride);',
glVertexAttribIFormatNV = 'void glVertexAttribIFormatNV (GLuint index, GLint size, GLenum type, GLsizei stride);',
glGetIntegerui64i_vNV = 'void glGetIntegerui64i_vNV (GLenum value, GLuint index, GLuint64EXT *result);',
glAreProgramsResidentNV = 'GLboolean glAreProgramsResidentNV (GLsizei n, const GLuint *programs, GLboolean *residences);',
glBindProgramNV = 'void glBindProgramNV (GLenum target, GLuint id);',
glDeleteProgramsNV = 'void glDeleteProgramsNV (GLsizei n, const GLuint *programs);',
glExecuteProgramNV = 'void glExecuteProgramNV (GLenum target, GLuint id, const GLfloat *params);',
glGenProgramsNV = 'void glGenProgramsNV (GLsizei n, GLuint *programs);',
glGetProgramParameterdvNV = 'void glGetProgramParameterdvNV (GLenum target, GLuint index, GLenum pname, GLdouble *params);',
glGetProgramParameterfvNV = 'void glGetProgramParameterfvNV (GLenum target, GLuint index, GLenum pname, GLfloat *params);',
glGetProgramivNV = 'void glGetProgramivNV (GLuint id, GLenum pname, GLint *params);',
glGetProgramStringNV = 'void glGetProgramStringNV (GLuint id, GLenum pname, GLubyte *program);',
glGetTrackMatrixivNV = 'void glGetTrackMatrixivNV (GLenum target, GLuint address, GLenum pname, GLint *params);',
glGetVertexAttribdvNV = 'void glGetVertexAttribdvNV (GLuint index, GLenum pname, GLdouble *params);',
glGetVertexAttribfvNV = 'void glGetVertexAttribfvNV (GLuint index, GLenum pname, GLfloat *params);',
glGetVertexAttribivNV = 'void glGetVertexAttribivNV (GLuint index, GLenum pname, GLint *params);',
glGetVertexAttribPointervNV = 'void glGetVertexAttribPointervNV (GLuint index, GLenum pname, void **pointer);',
glIsProgramNV = 'GLboolean glIsProgramNV (GLuint id);',
glLoadProgramNV = 'void glLoadProgramNV (GLenum target, GLuint id, GLsizei len, const GLubyte *program);',
glProgramParameter4dNV = 'void glProgramParameter4dNV (GLenum target, GLuint index, GLdouble x, GLdouble y, GLdouble z, GLdouble w);',
glProgramParameter4dvNV = 'void glProgramParameter4dvNV (GLenum target, GLuint index, const GLdouble *v);',
glProgramParameter4fNV = 'void glProgramParameter4fNV (GLenum target, GLuint index, GLfloat x, GLfloat y, GLfloat z, GLfloat w);',
glProgramParameter4fvNV = 'void glProgramParameter4fvNV (GLenum target, GLuint index, const GLfloat *v);',
glProgramParameters4dvNV = 'void glProgramParameters4dvNV (GLenum target, GLuint index, GLsizei count, const GLdouble *v);',
glProgramParameters4fvNV = 'void glProgramParameters4fvNV (GLenum target, GLuint index, GLsizei count, const GLfloat *v);',
glRequestResidentProgramsNV = 'void glRequestResidentProgramsNV (GLsizei n, const GLuint *programs);',
glTrackMatrixNV = 'void glTrackMatrixNV (GLenum target, GLuint address, GLenum matrix, GLenum transform);',
glVertexAttribPointerNV = 'void glVertexAttribPointerNV (GLuint index, GLint fsize, GLenum type, GLsizei stride, const void *pointer);',
glVertexAttrib1dNV = 'void glVertexAttrib1dNV (GLuint index, GLdouble x);',
glVertexAttrib1dvNV = 'void glVertexAttrib1dvNV (GLuint index, const GLdouble *v);',
glVertexAttrib1fNV = 'void glVertexAttrib1fNV (GLuint index, GLfloat x);',
glVertexAttrib1fvNV = 'void glVertexAttrib1fvNV (GLuint index, const GLfloat *v);',
glVertexAttrib1sNV = 'void glVertexAttrib1sNV (GLuint index, GLshort x);',
glVertexAttrib1svNV = 'void glVertexAttrib1svNV (GLuint index, const GLshort *v);',
glVertexAttrib2dNV = 'void glVertexAttrib2dNV (GLuint index, GLdouble x, GLdouble y);',
glVertexAttrib2dvNV = 'void glVertexAttrib2dvNV (GLuint index, const GLdouble *v);',
glVertexAttrib2fNV = 'void glVertexAttrib2fNV (GLuint index, GLfloat x, GLfloat y);',
glVertexAttrib2fvNV = 'void glVertexAttrib2fvNV (GLuint index, const GLfloat *v);',
glVertexAttrib2sNV = 'void glVertexAttrib2sNV (GLuint index, GLshort x, GLshort y);',
glVertexAttrib2svNV = 'void glVertexAttrib2svNV (GLuint index, const GLshort *v);',
glVertexAttrib3dNV = 'void glVertexAttrib3dNV (GLuint index, GLdouble x, GLdouble y, GLdouble z);',
glVertexAttrib3dvNV = 'void glVertexAttrib3dvNV (GLuint index, const GLdouble *v);',
glVertexAttrib3fNV = 'void glVertexAttrib3fNV (GLuint index, GLfloat x, GLfloat y, GLfloat z);',
glVertexAttrib3fvNV = 'void glVertexAttrib3fvNV (GLuint index, const GLfloat *v);',
glVertexAttrib3sNV = 'void glVertexAttrib3sNV (GLuint index, GLshort x, GLshort y, GLshort z);',
glVertexAttrib3svNV = 'void glVertexAttrib3svNV (GLuint index, const GLshort *v);',
glVertexAttrib4dNV = 'void glVertexAttrib4dNV (GLuint index, GLdouble x, GLdouble y, GLdouble z, GLdouble w);',
glVertexAttrib4dvNV = 'void glVertexAttrib4dvNV (GLuint index, const GLdouble *v);',
glVertexAttrib4fNV = 'void glVertexAttrib4fNV (GLuint index, GLfloat x, GLfloat y, GLfloat z, GLfloat w);',
glVertexAttrib4fvNV = 'void glVertexAttrib4fvNV (GLuint index, const GLfloat *v);',
glVertexAttrib4sNV = 'void glVertexAttrib4sNV (GLuint index, GLshort x, GLshort y, GLshort z, GLshort w);',
glVertexAttrib4svNV = 'void glVertexAttrib4svNV (GLuint index, const GLshort *v);',
glVertexAttrib4ubNV = 'void glVertexAttrib4ubNV (GLuint index, GLubyte x, GLubyte y, GLubyte z, GLubyte w);',
glVertexAttrib4ubvNV = 'void glVertexAttrib4ubvNV (GLuint index, const GLubyte *v);',
glVertexAttribs1dvNV = 'void glVertexAttribs1dvNV (GLuint index, GLsizei count, const GLdouble *v);',
glVertexAttribs1fvNV = 'void glVertexAttribs1fvNV (GLuint index, GLsizei count, const GLfloat *v);',
glVertexAttribs1svNV = 'void glVertexAttribs1svNV (GLuint index, GLsizei count, const GLshort *v);',
glVertexAttribs2dvNV = 'void glVertexAttribs2dvNV (GLuint index, GLsizei count, const GLdouble *v);',
glVertexAttribs2fvNV = 'void glVertexAttribs2fvNV (GLuint index, GLsizei count, const GLfloat *v);',
glVertexAttribs2svNV = 'void glVertexAttribs2svNV (GLuint index, GLsizei count, const GLshort *v);',
glVertexAttribs3dvNV = 'void glVertexAttribs3dvNV (GLuint index, GLsizei count, const GLdouble *v);',
glVertexAttribs3fvNV = 'void glVertexAttribs3fvNV (GLuint index, GLsizei count, const GLfloat *v);',
glVertexAttribs3svNV = 'void glVertexAttribs3svNV (GLuint index, GLsizei count, const GLshort *v);',
glVertexAttribs4dvNV = 'void glVertexAttribs4dvNV (GLuint index, GLsizei count, const GLdouble *v);',
glVertexAttribs4fvNV = 'void glVertexAttribs4fvNV (GLuint index, GLsizei count, const GLfloat *v);',
glVertexAttribs4svNV = 'void glVertexAttribs4svNV (GLuint index, GLsizei count, const GLshort *v);',
glVertexAttribs4ubvNV = 'void glVertexAttribs4ubvNV (GLuint index, GLsizei count, const GLubyte *v);',
glVertexAttribI1iEXT = 'void glVertexAttribI1iEXT (GLuint index, GLint x);',
glVertexAttribI2iEXT = 'void glVertexAttribI2iEXT (GLuint index, GLint x, GLint y);',
glVertexAttribI3iEXT = 'void glVertexAttribI3iEXT (GLuint index, GLint x, GLint y, GLint z);',
glVertexAttribI4iEXT = 'void glVertexAttribI4iEXT (GLuint index, GLint x, GLint y, GLint z, GLint w);',
glVertexAttribI1uiEXT = 'void glVertexAttribI1uiEXT (GLuint index, GLuint x);',
glVertexAttribI2uiEXT = 'void glVertexAttribI2uiEXT (GLuint index, GLuint x, GLuint y);',
glVertexAttribI3uiEXT = 'void glVertexAttribI3uiEXT (GLuint index, GLuint x, GLuint y, GLuint z);',
glVertexAttribI4uiEXT = 'void glVertexAttribI4uiEXT (GLuint index, GLuint x, GLuint y, GLuint z, GLuint w);',
glVertexAttribI1ivEXT = 'void glVertexAttribI1ivEXT (GLuint index, const GLint *v);',
glVertexAttribI2ivEXT = 'void glVertexAttribI2ivEXT (GLuint index, const GLint *v);',
glVertexAttribI3ivEXT = 'void glVertexAttribI3ivEXT (GLuint index, const GLint *v);',
glVertexAttribI4ivEXT = 'void glVertexAttribI4ivEXT (GLuint index, const GLint *v);',
glVertexAttribI1uivEXT = 'void glVertexAttribI1uivEXT (GLuint index, const GLuint *v);',
glVertexAttribI2uivEXT = 'void glVertexAttribI2uivEXT (GLuint index, const GLuint *v);',
glVertexAttribI3uivEXT = 'void glVertexAttribI3uivEXT (GLuint index, const GLuint *v);',
glVertexAttribI4uivEXT = 'void glVertexAttribI4uivEXT (GLuint index, const GLuint *v);',
glVertexAttribI4bvEXT = 'void glVertexAttribI4bvEXT (GLuint index, const GLbyte *v);',
glVertexAttribI4svEXT = 'void glVertexAttribI4svEXT (GLuint index, const GLshort *v);',
glVertexAttribI4ubvEXT = 'void glVertexAttribI4ubvEXT (GLuint index, const GLubyte *v);',
glVertexAttribI4usvEXT = 'void glVertexAttribI4usvEXT (GLuint index, const GLushort *v);',
glVertexAttribIPointerEXT = 'void glVertexAttribIPointerEXT (GLuint index, GLint size, GLenum type, GLsizei stride, const void *pointer);',
glGetVertexAttribIivEXT = 'void glGetVertexAttribIivEXT (GLuint index, GLenum pname, GLint *params);',
glGetVertexAttribIuivEXT = 'void glGetVertexAttribIuivEXT (GLuint index, GLenum pname, GLuint *params);',
glBeginVideoCaptureNV = 'void glBeginVideoCaptureNV (GLuint video_capture_slot);',
glBindVideoCaptureStreamBufferNV = 'void glBindVideoCaptureStreamBufferNV (GLuint video_capture_slot, GLuint stream, GLenum frame_region, GLintptrARB offset);',
glBindVideoCaptureStreamTextureNV = 'void glBindVideoCaptureStreamTextureNV (GLuint video_capture_slot, GLuint stream, GLenum frame_region, GLenum target, GLuint texture);',
glEndVideoCaptureNV = 'void glEndVideoCaptureNV (GLuint video_capture_slot);',
glGetVideoCaptureivNV = 'void glGetVideoCaptureivNV (GLuint video_capture_slot, GLenum pname, GLint *params);',
glGetVideoCaptureStreamivNV = 'void glGetVideoCaptureStreamivNV (GLuint video_capture_slot, GLuint stream, GLenum pname, GLint *params);',
glGetVideoCaptureStreamfvNV = 'void glGetVideoCaptureStreamfvNV (GLuint video_capture_slot, GLuint stream, GLenum pname, GLfloat *params);',
glGetVideoCaptureStreamdvNV = 'void glGetVideoCaptureStreamdvNV (GLuint video_capture_slot, GLuint stream, GLenum pname, GLdouble *params);',
glVideoCaptureNV = 'GLenum glVideoCaptureNV (GLuint video_capture_slot, GLuint *sequence_num, GLuint64EXT *capture_time);',
glVideoCaptureStreamParameterivNV = 'void glVideoCaptureStreamParameterivNV (GLuint video_capture_slot, GLuint stream, GLenum pname, const GLint *params);',
glVideoCaptureStreamParameterfvNV = 'void glVideoCaptureStreamParameterfvNV (GLuint video_capture_slot, GLuint stream, GLenum pname, const GLfloat *params);',
glVideoCaptureStreamParameterdvNV = 'void glVideoCaptureStreamParameterdvNV (GLuint video_capture_slot, GLuint stream, GLenum pname, const GLdouble *params);',
glViewportSwizzleNV = 'void glViewportSwizzleNV (GLuint index, GLenum swizzlex, GLenum swizzley, GLenum swizzlez, GLenum swizzlew);',
glFramebufferTextureMultiviewOVR = 'void glFramebufferTextureMultiviewOVR (GLenum target, GLenum attachment, GLuint texture, GLint level, GLint baseViewIndex, GLsizei numViews);',
glHintPGI = 'void glHintPGI (GLenum target, GLint mode);',
glDetailTexFuncSGIS = 'void glDetailTexFuncSGIS (GLenum target, GLsizei n, const GLfloat *points);',
glGetDetailTexFuncSGIS = 'void glGetDetailTexFuncSGIS (GLenum target, GLfloat *points);',
glFogFuncSGIS = 'void glFogFuncSGIS (GLsizei n, const GLfloat *points);',
glGetFogFuncSGIS = 'void glGetFogFuncSGIS (GLfloat *points);',
glSampleMaskSGIS = 'void glSampleMaskSGIS (GLclampf value, GLboolean invert);',
glSamplePatternSGIS = 'void glSamplePatternSGIS (GLenum pattern);',
glPixelTexGenParameteriSGIS = 'void glPixelTexGenParameteriSGIS (GLenum pname, GLint param);',
glPixelTexGenParameterivSGIS = 'void glPixelTexGenParameterivSGIS (GLenum pname, const GLint *params);',
glPixelTexGenParameterfSGIS = 'void glPixelTexGenParameterfSGIS (GLenum pname, GLfloat param);',
glPixelTexGenParameterfvSGIS = 'void glPixelTexGenParameterfvSGIS (GLenum pname, const GLfloat *params);',
glGetPixelTexGenParameterivSGIS = 'void glGetPixelTexGenParameterivSGIS (GLenum pname, GLint *params);',
glGetPixelTexGenParameterfvSGIS = 'void glGetPixelTexGenParameterfvSGIS (GLenum pname, GLfloat *params);',
glPointParameterfSGIS = 'void glPointParameterfSGIS (GLenum pname, GLfloat param);',
glPointParameterfvSGIS = 'void glPointParameterfvSGIS (GLenum pname, const GLfloat *params);',
glSharpenTexFuncSGIS = 'void glSharpenTexFuncSGIS (GLenum target, GLsizei n, const GLfloat *points);',
glGetSharpenTexFuncSGIS = 'void glGetSharpenTexFuncSGIS (GLenum target, GLfloat *points);',
glTexImage4DSGIS = 'void glTexImage4DSGIS (GLenum target, GLint level, GLenum internalformat, GLsizei width, GLsizei height, GLsizei depth, GLsizei size4d, GLint border, GLenum format, GLenum type, const void *pixels);',
glTexSubImage4DSGIS = 'void glTexSubImage4DSGIS (GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLint woffset, GLsizei width, GLsizei height, GLsizei depth, GLsizei size4d, GLenum format, GLenum type, const void *pixels);',
glTextureColorMaskSGIS = 'void glTextureColorMaskSGIS (GLboolean red, GLboolean green, GLboolean blue, GLboolean alpha);',
glGetTexFilterFuncSGIS = 'void glGetTexFilterFuncSGIS (GLenum target, GLenum filter, GLfloat *weights);',
glTexFilterFuncSGIS = 'void glTexFilterFuncSGIS (GLenum target, GLenum filter, GLsizei n, const GLfloat *weights);',
glAsyncMarkerSGIX = 'void glAsyncMarkerSGIX (GLuint marker);',
glFinishAsyncSGIX = 'GLint glFinishAsyncSGIX (GLuint *markerp);',
glPollAsyncSGIX = 'GLint glPollAsyncSGIX (GLuint *markerp);',
glGenAsyncMarkersSGIX = 'GLuint glGenAsyncMarkersSGIX (GLsizei range);',
glDeleteAsyncMarkersSGIX = 'void glDeleteAsyncMarkersSGIX (GLuint marker, GLsizei range);',
glIsAsyncMarkerSGIX = 'GLboolean glIsAsyncMarkerSGIX (GLuint marker);',
glFlushRasterSGIX = 'void glFlushRasterSGIX (void);',
glFragmentColorMaterialSGIX = 'void glFragmentColorMaterialSGIX (GLenum face, GLenum mode);',
glFragmentLightfSGIX = 'void glFragmentLightfSGIX (GLenum light, GLenum pname, GLfloat param);',
glFragmentLightfvSGIX = 'void glFragmentLightfvSGIX (GLenum light, GLenum pname, const GLfloat *params);',
glFragmentLightiSGIX = 'void glFragmentLightiSGIX (GLenum light, GLenum pname, GLint param);',
glFragmentLightivSGIX = 'void glFragmentLightivSGIX (GLenum light, GLenum pname, const GLint *params);',
glFragmentLightModelfSGIX = 'void glFragmentLightModelfSGIX (GLenum pname, GLfloat param);',
glFragmentLightModelfvSGIX = 'void glFragmentLightModelfvSGIX (GLenum pname, const GLfloat *params);',
glFragmentLightModeliSGIX = 'void glFragmentLightModeliSGIX (GLenum pname, GLint param);',
glFragmentLightModelivSGIX = 'void glFragmentLightModelivSGIX (GLenum pname, const GLint *params);',
glFragmentMaterialfSGIX = 'void glFragmentMaterialfSGIX (GLenum face, GLenum pname, GLfloat param);',
glFragmentMaterialfvSGIX = 'void glFragmentMaterialfvSGIX (GLenum face, GLenum pname, const GLfloat *params);',
glFragmentMaterialiSGIX = 'void glFragmentMaterialiSGIX (GLenum face, GLenum pname, GLint param);',
glFragmentMaterialivSGIX = 'void glFragmentMaterialivSGIX (GLenum face, GLenum pname, const GLint *params);',
glGetFragmentLightfvSGIX = 'void glGetFragmentLightfvSGIX (GLenum light, GLenum pname, GLfloat *params);',
glGetFragmentLightivSGIX = 'void glGetFragmentLightivSGIX (GLenum light, GLenum pname, GLint *params);',
glGetFragmentMaterialfvSGIX = 'void glGetFragmentMaterialfvSGIX (GLenum face, GLenum pname, GLfloat *params);',
glGetFragmentMaterialivSGIX = 'void glGetFragmentMaterialivSGIX (GLenum face, GLenum pname, GLint *params);',
glLightEnviSGIX = 'void glLightEnviSGIX (GLenum pname, GLint param);',
glFrameZoomSGIX = 'void glFrameZoomSGIX (GLint factor);',
glIglooInterfaceSGIX = 'void glIglooInterfaceSGIX (GLenum pname, const void *params);',
glGetInstrumentsSGIX = 'GLint glGetInstrumentsSGIX (void);',
glInstrumentsBufferSGIX = 'void glInstrumentsBufferSGIX (GLsizei size, GLint *buffer);',
glPollInstrumentsSGIX = 'GLint glPollInstrumentsSGIX (GLint *marker_p);',
glReadInstrumentsSGIX = 'void glReadInstrumentsSGIX (GLint marker);',
glStartInstrumentsSGIX = 'void glStartInstrumentsSGIX (void);',
glStopInstrumentsSGIX = 'void glStopInstrumentsSGIX (GLint marker);',
glGetListParameterfvSGIX = 'void glGetListParameterfvSGIX (GLuint list, GLenum pname, GLfloat *params);',
glGetListParameterivSGIX = 'void glGetListParameterivSGIX (GLuint list, GLenum pname, GLint *params);',
glListParameterfSGIX = 'void glListParameterfSGIX (GLuint list, GLenum pname, GLfloat param);',
glListParameterfvSGIX = 'void glListParameterfvSGIX (GLuint list, GLenum pname, const GLfloat *params);',
glListParameteriSGIX = 'void glListParameteriSGIX (GLuint list, GLenum pname, GLint param);',
glListParameterivSGIX = 'void glListParameterivSGIX (GLuint list, GLenum pname, const GLint *params);',
glPixelTexGenSGIX = 'void glPixelTexGenSGIX (GLenum mode);',
glDeformationMap3dSGIX = 'void glDeformationMap3dSGIX (GLenum target, GLdouble u1, GLdouble u2, GLint ustride, GLint uorder, GLdouble v1, GLdouble v2, GLint vstride, GLint vorder, GLdouble w1, GLdouble w2, GLint wstride, GLint worder, const GLdouble *points);',
glDeformationMap3fSGIX = 'void glDeformationMap3fSGIX (GLenum target, GLfloat u1, GLfloat u2, GLint ustride, GLint uorder, GLfloat v1, GLfloat v2, GLint vstride, GLint vorder, GLfloat w1, GLfloat w2, GLint wstride, GLint worder, const GLfloat *points);',
glDeformSGIX = 'void glDeformSGIX (GLbitfield mask);',
glLoadIdentityDeformationMapSGIX = 'void glLoadIdentityDeformationMapSGIX (GLbitfield mask);',
glReferencePlaneSGIX = 'void glReferencePlaneSGIX (const GLdouble *equation);',
glSpriteParameterfSGIX = 'void glSpriteParameterfSGIX (GLenum pname, GLfloat param);',
glSpriteParameterfvSGIX = 'void glSpriteParameterfvSGIX (GLenum pname, const GLfloat *params);',
glSpriteParameteriSGIX = 'void glSpriteParameteriSGIX (GLenum pname, GLint param);',
glSpriteParameterivSGIX = 'void glSpriteParameterivSGIX (GLenum pname, const GLint *params);',
glTagSampleBufferSGIX = 'void glTagSampleBufferSGIX (void);',
glColorTableSGI = 'void glColorTableSGI (GLenum target, GLenum internalformat, GLsizei width, GLenum format, GLenum type, const void *table);',
glColorTableParameterfvSGI = 'void glColorTableParameterfvSGI (GLenum target, GLenum pname, const GLfloat *params);',
glColorTableParameterivSGI = 'void glColorTableParameterivSGI (GLenum target, GLenum pname, const GLint *params);',
glCopyColorTableSGI = 'void glCopyColorTableSGI (GLenum target, GLenum internalformat, GLint x, GLint y, GLsizei width);',
glGetColorTableSGI = 'void glGetColorTableSGI (GLenum target, GLenum format, GLenum type, void *table);',
glGetColorTableParameterfvSGI = 'void glGetColorTableParameterfvSGI (GLenum target, GLenum pname, GLfloat *params);',
glGetColorTableParameterivSGI = 'void glGetColorTableParameterivSGI (GLenum target, GLenum pname, GLint *params);',
glFinishTextureSUNX = 'void glFinishTextureSUNX (void);',
glGlobalAlphaFactorbSUN = 'void glGlobalAlphaFactorbSUN (GLbyte factor);',
glGlobalAlphaFactorsSUN = 'void glGlobalAlphaFactorsSUN (GLshort factor);',
glGlobalAlphaFactoriSUN = 'void glGlobalAlphaFactoriSUN (GLint factor);',
glGlobalAlphaFactorfSUN = 'void glGlobalAlphaFactorfSUN (GLfloat factor);',
glGlobalAlphaFactordSUN = 'void glGlobalAlphaFactordSUN (GLdouble factor);',
glGlobalAlphaFactorubSUN = 'void glGlobalAlphaFactorubSUN (GLubyte factor);',
glGlobalAlphaFactorusSUN = 'void glGlobalAlphaFactorusSUN (GLushort factor);',
glGlobalAlphaFactoruiSUN = 'void glGlobalAlphaFactoruiSUN (GLuint factor);',
glDrawMeshArraysSUN = 'void glDrawMeshArraysSUN (GLenum mode, GLint first, GLsizei count, GLsizei width);',
glReplacementCodeuiSUN = 'void glReplacementCodeuiSUN (GLuint code);',
glReplacementCodeusSUN = 'void glReplacementCodeusSUN (GLushort code);',
glReplacementCodeubSUN = 'void glReplacementCodeubSUN (GLubyte code);',
glReplacementCodeuivSUN = 'void glReplacementCodeuivSUN (const GLuint *code);',
glReplacementCodeusvSUN = 'void glReplacementCodeusvSUN (const GLushort *code);',
glReplacementCodeubvSUN = 'void glReplacementCodeubvSUN (const GLubyte *code);',
glReplacementCodePointerSUN = 'void glReplacementCodePointerSUN (GLenum type, GLsizei stride, const void **pointer);',
glColor4ubVertex2fSUN = 'void glColor4ubVertex2fSUN (GLubyte r, GLubyte g, GLubyte b, GLubyte a, GLfloat x, GLfloat y);',
glColor4ubVertex2fvSUN = 'void glColor4ubVertex2fvSUN (const GLubyte *c, const GLfloat *v);',
glColor4ubVertex3fSUN = 'void glColor4ubVertex3fSUN (GLubyte r, GLubyte g, GLubyte b, GLubyte a, GLfloat x, GLfloat y, GLfloat z);',
glColor4ubVertex3fvSUN = 'void glColor4ubVertex3fvSUN (const GLubyte *c, const GLfloat *v);',
glColor3fVertex3fSUN = 'void glColor3fVertex3fSUN (GLfloat r, GLfloat g, GLfloat b, GLfloat x, GLfloat y, GLfloat z);',
glColor3fVertex3fvSUN = 'void glColor3fVertex3fvSUN (const GLfloat *c, const GLfloat *v);',
glNormal3fVertex3fSUN = 'void glNormal3fVertex3fSUN (GLfloat nx, GLfloat ny, GLfloat nz, GLfloat x, GLfloat y, GLfloat z);',
glNormal3fVertex3fvSUN = 'void glNormal3fVertex3fvSUN (const GLfloat *n, const GLfloat *v);',
glColor4fNormal3fVertex3fSUN = 'void glColor4fNormal3fVertex3fSUN (GLfloat r, GLfloat g, GLfloat b, GLfloat a, GLfloat nx, GLfloat ny, GLfloat nz, GLfloat x, GLfloat y, GLfloat z);',
glColor4fNormal3fVertex3fvSUN = 'void glColor4fNormal3fVertex3fvSUN (const GLfloat *c, const GLfloat *n, const GLfloat *v);',
glTexCoord2fVertex3fSUN = 'void glTexCoord2fVertex3fSUN (GLfloat s, GLfloat t, GLfloat x, GLfloat y, GLfloat z);',
glTexCoord2fVertex3fvSUN = 'void glTexCoord2fVertex3fvSUN (const GLfloat *tc, const GLfloat *v);',
glTexCoord4fVertex4fSUN = 'void glTexCoord4fVertex4fSUN (GLfloat s, GLfloat t, GLfloat p, GLfloat q, GLfloat x, GLfloat y, GLfloat z, GLfloat w);',
glTexCoord4fVertex4fvSUN = 'void glTexCoord4fVertex4fvSUN (const GLfloat *tc, const GLfloat *v);',
glTexCoord2fColor4ubVertex3fSUN = 'void glTexCoord2fColor4ubVertex3fSUN (GLfloat s, GLfloat t, GLubyte r, GLubyte g, GLubyte b, GLubyte a, GLfloat x, GLfloat y, GLfloat z);',
glTexCoord2fColor4ubVertex3fvSUN = 'void glTexCoord2fColor4ubVertex3fvSUN (const GLfloat *tc, const GLubyte *c, const GLfloat *v);',
glTexCoord2fColor3fVertex3fSUN = 'void glTexCoord2fColor3fVertex3fSUN (GLfloat s, GLfloat t, GLfloat r, GLfloat g, GLfloat b, GLfloat x, GLfloat y, GLfloat z);',
glTexCoord2fColor3fVertex3fvSUN = 'void glTexCoord2fColor3fVertex3fvSUN (const GLfloat *tc, const GLfloat *c, const GLfloat *v);',
glTexCoord2fNormal3fVertex3fSUN = 'void glTexCoord2fNormal3fVertex3fSUN (GLfloat s, GLfloat t, GLfloat nx, GLfloat ny, GLfloat nz, GLfloat x, GLfloat y, GLfloat z);',
glTexCoord2fNormal3fVertex3fvSUN = 'void glTexCoord2fNormal3fVertex3fvSUN (const GLfloat *tc, const GLfloat *n, const GLfloat *v);',
glTexCoord2fColor4fNormal3fVertex3fSUN = 'void glTexCoord2fColor4fNormal3fVertex3fSUN (GLfloat s, GLfloat t, GLfloat r, GLfloat g, GLfloat b, GLfloat a, GLfloat nx, GLfloat ny, GLfloat nz, GLfloat x, GLfloat y, GLfloat z);',
glTexCoord2fColor4fNormal3fVertex3fvSUN = 'void glTexCoord2fColor4fNormal3fVertex3fvSUN (const GLfloat *tc, const GLfloat *c, const GLfloat *n, const GLfloat *v);',
glTexCoord4fColor4fNormal3fVertex4fSUN = 'void glTexCoord4fColor4fNormal3fVertex4fSUN (GLfloat s, GLfloat t, GLfloat p, GLfloat q, GLfloat r, GLfloat g, GLfloat b, GLfloat a, GLfloat nx, GLfloat ny, GLfloat nz, GLfloat x, GLfloat y, GLfloat z, GLfloat w);',
glTexCoord4fColor4fNormal3fVertex4fvSUN = 'void glTexCoord4fColor4fNormal3fVertex4fvSUN (const GLfloat *tc, const GLfloat *c, const GLfloat *n, const GLfloat *v);',
glReplacementCodeuiVertex3fSUN = 'void glReplacementCodeuiVertex3fSUN (GLuint rc, GLfloat x, GLfloat y, GLfloat z);',
glReplacementCodeuiVertex3fvSUN = 'void glReplacementCodeuiVertex3fvSUN (const GLuint *rc, const GLfloat *v);',
glReplacementCodeuiColor4ubVertex3fSUN = 'void glReplacementCodeuiColor4ubVertex3fSUN (GLuint rc, GLubyte r, GLubyte g, GLubyte b, GLubyte a, GLfloat x, GLfloat y, GLfloat z);',
glReplacementCodeuiColor4ubVertex3fvSUN = 'void glReplacementCodeuiColor4ubVertex3fvSUN (const GLuint *rc, const GLubyte *c, const GLfloat *v);',
glReplacementCodeuiColor3fVertex3fSUN = 'void glReplacementCodeuiColor3fVertex3fSUN (GLuint rc, GLfloat r, GLfloat g, GLfloat b, GLfloat x, GLfloat y, GLfloat z);',
glReplacementCodeuiColor3fVertex3fvSUN = 'void glReplacementCodeuiColor3fVertex3fvSUN (const GLuint *rc, const GLfloat *c, const GLfloat *v);',
glReplacementCodeuiNormal3fVertex3fSUN = 'void glReplacementCodeuiNormal3fVertex3fSUN (GLuint rc, GLfloat nx, GLfloat ny, GLfloat nz, GLfloat x, GLfloat y, GLfloat z);',
glReplacementCodeuiNormal3fVertex3fvSUN = 'void glReplacementCodeuiNormal3fVertex3fvSUN (const GLuint *rc, const GLfloat *n, const GLfloat *v);',
glReplacementCodeuiColor4fNormal3fVertex3fSUN = 'void glReplacementCodeuiColor4fNormal3fVertex3fSUN (GLuint rc, GLfloat r, GLfloat g, GLfloat b, GLfloat a, GLfloat nx, GLfloat ny, GLfloat nz, GLfloat x, GLfloat y, GLfloat z);',
glReplacementCodeuiColor4fNormal3fVertex3fvSUN = 'void glReplacementCodeuiColor4fNormal3fVertex3fvSUN (const GLuint *rc, const GLfloat *c, const GLfloat *n, const GLfloat *v);',
glReplacementCodeuiTexCoord2fVertex3fSUN = 'void glReplacementCodeuiTexCoord2fVertex3fSUN (GLuint rc, GLfloat s, GLfloat t, GLfloat x, GLfloat y, GLfloat z);',
glReplacementCodeuiTexCoord2fVertex3fvSUN = 'void glReplacementCodeuiTexCoord2fVertex3fvSUN (const GLuint *rc, const GLfloat *tc, const GLfloat *v);',
glReplacementCodeuiTexCoord2fNormal3fVertex3fSUN = 'void glReplacementCodeuiTexCoord2fNormal3fVertex3fSUN (GLuint rc, GLfloat s, GLfloat t, GLfloat nx, GLfloat ny, GLfloat nz, GLfloat x, GLfloat y, GLfloat z);',
glReplacementCodeuiTexCoord2fNormal3fVertex3fvSUN = 'void glReplacementCodeuiTexCoord2fNormal3fVertex3fvSUN (const GLuint *rc, const GLfloat *tc, const GLfloat *n, const GLfloat *v);',
glReplacementCodeuiTexCoord2fColor4fNormal3fVertex3fSUN = 'void glReplacementCodeuiTexCoord2fColor4fNormal3fVertex3fSUN (GLuint rc, GLfloat s, GLfloat t, GLfloat r, GLfloat g, GLfloat b, GLfloat a, GLfloat nx, GLfloat ny, GLfloat nz, GLfloat x, GLfloat y, GLfloat z);',
glReplacementCodeuiTexCoord2fColor4fNormal3fVertex3fvSUN = 'void glReplacementCodeuiTexCoord2fColor4fNormal3fVertex3fvSUN (const GLuint *rc, const GLfloat *tc, const GLfloat *c, const GLfloat *n, const GLfloat *v);',
}

-- store enums here to save the effort of copying them from ffi.C back into the wrapper
local wrapper = {
	GL_VERSION_1_1 = 1,
	GL_ACCUM = 256,
	GL_LOAD = 257,
	GL_RETURN = 258,
	GL_MULT = 259,
	GL_ADD = 260,
	GL_NEVER = 512,
	GL_LESS = 513,
	GL_EQUAL = 514,
	GL_LEQUAL = 515,
	GL_GREATER = 516,
	GL_NOTEQUAL = 517,
	GL_GEQUAL = 518,
	GL_ALWAYS = 519,
	GL_CURRENT_BIT = 1,
	GL_POINT_BIT = 2,
	GL_LINE_BIT = 4,
	GL_POLYGON_BIT = 8,
	GL_POLYGON_STIPPLE_BIT = 16,
	GL_PIXEL_MODE_BIT = 32,
	GL_LIGHTING_BIT = 64,
	GL_FOG_BIT = 128,
	GL_DEPTH_BUFFER_BIT = 256,
	GL_ACCUM_BUFFER_BIT = 512,
	GL_STENCIL_BUFFER_BIT = 1024,
	GL_VIEWPORT_BIT = 2048,
	GL_TRANSFORM_BIT = 4096,
	GL_ENABLE_BIT = 8192,
	GL_COLOR_BUFFER_BIT = 16384,
	GL_HINT_BIT = 32768,
	GL_EVAL_BIT = 65536,
	GL_LIST_BIT = 131072,
	GL_TEXTURE_BIT = 262144,
	GL_SCISSOR_BIT = 524288,
	GL_ALL_ATTRIB_BITS = 1048575,
	GL_POINTS = 0,
	GL_LINES = 1,
	GL_LINE_LOOP = 2,
	GL_LINE_STRIP = 3,
	GL_TRIANGLES = 4,
	GL_TRIANGLE_STRIP = 5,
	GL_TRIANGLE_FAN = 6,
	GL_QUADS = 7,
	GL_QUAD_STRIP = 8,
	GL_POLYGON = 9,
	GL_ZERO = 0,
	GL_ONE = 1,
	GL_SRC_COLOR = 768,
	GL_ONE_MINUS_SRC_COLOR = 769,
	GL_SRC_ALPHA = 770,
	GL_ONE_MINUS_SRC_ALPHA = 771,
	GL_DST_ALPHA = 772,
	GL_ONE_MINUS_DST_ALPHA = 773,
	GL_DST_COLOR = 774,
	GL_ONE_MINUS_DST_COLOR = 775,
	GL_SRC_ALPHA_SATURATE = 776,
	GL_TRUE = 1,
	GL_FALSE = 0,
	GL_CLIP_PLANE0 = 12288,
	GL_CLIP_PLANE1 = 12289,
	GL_CLIP_PLANE2 = 12290,
	GL_CLIP_PLANE3 = 12291,
	GL_CLIP_PLANE4 = 12292,
	GL_CLIP_PLANE5 = 12293,
	GL_BYTE = 5120,
	GL_UNSIGNED_BYTE = 5121,
	GL_SHORT = 5122,
	GL_UNSIGNED_SHORT = 5123,
	GL_INT = 5124,
	GL_UNSIGNED_INT = 5125,
	GL_FLOAT = 5126,
	GL_2_BYTES = 5127,
	GL_3_BYTES = 5128,
	GL_4_BYTES = 5129,
	GL_DOUBLE = 5130,
	GL_NONE = 0,
	GL_FRONT_LEFT = 1024,
	GL_FRONT_RIGHT = 1025,
	GL_BACK_LEFT = 1026,
	GL_BACK_RIGHT = 1027,
	GL_FRONT = 1028,
	GL_BACK = 1029,
	GL_LEFT = 1030,
	GL_RIGHT = 1031,
	GL_FRONT_AND_BACK = 1032,
	GL_AUX0 = 1033,
	GL_AUX1 = 1034,
	GL_AUX2 = 1035,
	GL_AUX3 = 1036,
	GL_NO_ERROR = 0,
	GL_INVALID_ENUM = 1280,
	GL_INVALID_VALUE = 1281,
	GL_INVALID_OPERATION = 1282,
	GL_STACK_OVERFLOW = 1283,
	GL_STACK_UNDERFLOW = 1284,
	GL_OUT_OF_MEMORY = 1285,
	GL_2D = 1536,
	GL_3D = 1537,
	GL_3D_COLOR = 1538,
	GL_3D_COLOR_TEXTURE = 1539,
	GL_4D_COLOR_TEXTURE = 1540,
	GL_PASS_THROUGH_TOKEN = 1792,
	GL_POINT_TOKEN = 1793,
	GL_LINE_TOKEN = 1794,
	GL_POLYGON_TOKEN = 1795,
	GL_BITMAP_TOKEN = 1796,
	GL_DRAW_PIXEL_TOKEN = 1797,
	GL_COPY_PIXEL_TOKEN = 1798,
	GL_LINE_RESET_TOKEN = 1799,
	GL_EXP = 2048,
	GL_EXP2 = 2049,
	GL_CW = 2304,
	GL_CCW = 2305,
	GL_COEFF = 2560,
	GL_ORDER = 2561,
	GL_DOMAIN = 2562,
	GL_CURRENT_COLOR = 2816,
	GL_CURRENT_INDEX = 2817,
	GL_CURRENT_NORMAL = 2818,
	GL_CURRENT_TEXTURE_COORDS = 2819,
	GL_CURRENT_RASTER_COLOR = 2820,
	GL_CURRENT_RASTER_INDEX = 2821,
	GL_CURRENT_RASTER_TEXTURE_COORDS = 2822,
	GL_CURRENT_RASTER_POSITION = 2823,
	GL_CURRENT_RASTER_POSITION_VALID = 2824,
	GL_CURRENT_RASTER_DISTANCE = 2825,
	GL_POINT_SMOOTH = 2832,
	GL_POINT_SIZE = 2833,
	GL_POINT_SIZE_RANGE = 2834,
	GL_POINT_SIZE_GRANULARITY = 2835,
	GL_LINE_SMOOTH = 2848,
	GL_LINE_WIDTH = 2849,
	GL_LINE_WIDTH_RANGE = 2850,
	GL_LINE_WIDTH_GRANULARITY = 2851,
	GL_LINE_STIPPLE = 2852,
	GL_LINE_STIPPLE_PATTERN = 2853,
	GL_LINE_STIPPLE_REPEAT = 2854,
	GL_LIST_MODE = 2864,
	GL_MAX_LIST_NESTING = 2865,
	GL_LIST_BASE = 2866,
	GL_LIST_INDEX = 2867,
	GL_POLYGON_MODE = 2880,
	GL_POLYGON_SMOOTH = 2881,
	GL_POLYGON_STIPPLE = 2882,
	GL_EDGE_FLAG = 2883,
	GL_CULL_FACE = 2884,
	GL_CULL_FACE_MODE = 2885,
	GL_FRONT_FACE = 2886,
	GL_LIGHTING = 2896,
	GL_LIGHT_MODEL_LOCAL_VIEWER = 2897,
	GL_LIGHT_MODEL_TWO_SIDE = 2898,
	GL_LIGHT_MODEL_AMBIENT = 2899,
	GL_SHADE_MODEL = 2900,
	GL_COLOR_MATERIAL_FACE = 2901,
	GL_COLOR_MATERIAL_PARAMETER = 2902,
	GL_COLOR_MATERIAL = 2903,
	GL_FOG = 2912,
	GL_FOG_INDEX = 2913,
	GL_FOG_DENSITY = 2914,
	GL_FOG_START = 2915,
	GL_FOG_END = 2916,
	GL_FOG_MODE = 2917,
	GL_FOG_COLOR = 2918,
	GL_DEPTH_RANGE = 2928,
	GL_DEPTH_TEST = 2929,
	GL_DEPTH_WRITEMASK = 2930,
	GL_DEPTH_CLEAR_VALUE = 2931,
	GL_DEPTH_FUNC = 2932,
	GL_ACCUM_CLEAR_VALUE = 2944,
	GL_STENCIL_TEST = 2960,
	GL_STENCIL_CLEAR_VALUE = 2961,
	GL_STENCIL_FUNC = 2962,
	GL_STENCIL_VALUE_MASK = 2963,
	GL_STENCIL_FAIL = 2964,
	GL_STENCIL_PASS_DEPTH_FAIL = 2965,
	GL_STENCIL_PASS_DEPTH_PASS = 2966,
	GL_STENCIL_REF = 2967,
	GL_STENCIL_WRITEMASK = 2968,
	GL_MATRIX_MODE = 2976,
	GL_NORMALIZE = 2977,
	GL_VIEWPORT = 2978,
	GL_MODELVIEW_STACK_DEPTH = 2979,
	GL_PROJECTION_STACK_DEPTH = 2980,
	GL_TEXTURE_STACK_DEPTH = 2981,
	GL_MODELVIEW_MATRIX = 2982,
	GL_PROJECTION_MATRIX = 2983,
	GL_TEXTURE_MATRIX = 2984,
	GL_ATTRIB_STACK_DEPTH = 2992,
	GL_CLIENT_ATTRIB_STACK_DEPTH = 2993,
	GL_ALPHA_TEST = 3008,
	GL_ALPHA_TEST_FUNC = 3009,
	GL_ALPHA_TEST_REF = 3010,
	GL_DITHER = 3024,
	GL_BLEND_DST = 3040,
	GL_BLEND_SRC = 3041,
	GL_BLEND = 3042,
	GL_LOGIC_OP_MODE = 3056,
	GL_INDEX_LOGIC_OP = 3057,
	GL_COLOR_LOGIC_OP = 3058,
	GL_AUX_BUFFERS = 3072,
	GL_DRAW_BUFFER = 3073,
	GL_READ_BUFFER = 3074,
	GL_SCISSOR_BOX = 3088,
	GL_SCISSOR_TEST = 3089,
	GL_INDEX_CLEAR_VALUE = 3104,
	GL_INDEX_WRITEMASK = 3105,
	GL_COLOR_CLEAR_VALUE = 3106,
	GL_COLOR_WRITEMASK = 3107,
	GL_INDEX_MODE = 3120,
	GL_RGBA_MODE = 3121,
	GL_DOUBLEBUFFER = 3122,
	GL_STEREO = 3123,
	GL_RENDER_MODE = 3136,
	GL_PERSPECTIVE_CORRECTION_HINT = 3152,
	GL_POINT_SMOOTH_HINT = 3153,
	GL_LINE_SMOOTH_HINT = 3154,
	GL_POLYGON_SMOOTH_HINT = 3155,
	GL_FOG_HINT = 3156,
	GL_TEXTURE_GEN_S = 3168,
	GL_TEXTURE_GEN_T = 3169,
	GL_TEXTURE_GEN_R = 3170,
	GL_TEXTURE_GEN_Q = 3171,
	GL_PIXEL_MAP_I_TO_I = 3184,
	GL_PIXEL_MAP_S_TO_S = 3185,
	GL_PIXEL_MAP_I_TO_R = 3186,
	GL_PIXEL_MAP_I_TO_G = 3187,
	GL_PIXEL_MAP_I_TO_B = 3188,
	GL_PIXEL_MAP_I_TO_A = 3189,
	GL_PIXEL_MAP_R_TO_R = 3190,
	GL_PIXEL_MAP_G_TO_G = 3191,
	GL_PIXEL_MAP_B_TO_B = 3192,
	GL_PIXEL_MAP_A_TO_A = 3193,
	GL_PIXEL_MAP_I_TO_I_SIZE = 3248,
	GL_PIXEL_MAP_S_TO_S_SIZE = 3249,
	GL_PIXEL_MAP_I_TO_R_SIZE = 3250,
	GL_PIXEL_MAP_I_TO_G_SIZE = 3251,
	GL_PIXEL_MAP_I_TO_B_SIZE = 3252,
	GL_PIXEL_MAP_I_TO_A_SIZE = 3253,
	GL_PIXEL_MAP_R_TO_R_SIZE = 3254,
	GL_PIXEL_MAP_G_TO_G_SIZE = 3255,
	GL_PIXEL_MAP_B_TO_B_SIZE = 3256,
	GL_PIXEL_MAP_A_TO_A_SIZE = 3257,
	GL_UNPACK_SWAP_BYTES = 3312,
	GL_UNPACK_LSB_FIRST = 3313,
	GL_UNPACK_ROW_LENGTH = 3314,
	GL_UNPACK_SKIP_ROWS = 3315,
	GL_UNPACK_SKIP_PIXELS = 3316,
	GL_UNPACK_ALIGNMENT = 3317,
	GL_PACK_SWAP_BYTES = 3328,
	GL_PACK_LSB_FIRST = 3329,
	GL_PACK_ROW_LENGTH = 3330,
	GL_PACK_SKIP_ROWS = 3331,
	GL_PACK_SKIP_PIXELS = 3332,
	GL_PACK_ALIGNMENT = 3333,
	GL_MAP_COLOR = 3344,
	GL_MAP_STENCIL = 3345,
	GL_INDEX_SHIFT = 3346,
	GL_INDEX_OFFSET = 3347,
	GL_RED_SCALE = 3348,
	GL_RED_BIAS = 3349,
	GL_ZOOM_X = 3350,
	GL_ZOOM_Y = 3351,
	GL_GREEN_SCALE = 3352,
	GL_GREEN_BIAS = 3353,
	GL_BLUE_SCALE = 3354,
	GL_BLUE_BIAS = 3355,
	GL_ALPHA_SCALE = 3356,
	GL_ALPHA_BIAS = 3357,
	GL_DEPTH_SCALE = 3358,
	GL_DEPTH_BIAS = 3359,
	GL_MAX_EVAL_ORDER = 3376,
	GL_MAX_LIGHTS = 3377,
	GL_MAX_CLIP_PLANES = 3378,
	GL_MAX_TEXTURE_SIZE = 3379,
	GL_MAX_PIXEL_MAP_TABLE = 3380,
	GL_MAX_ATTRIB_STACK_DEPTH = 3381,
	GL_MAX_MODELVIEW_STACK_DEPTH = 3382,
	GL_MAX_NAME_STACK_DEPTH = 3383,
	GL_MAX_PROJECTION_STACK_DEPTH = 3384,
	GL_MAX_TEXTURE_STACK_DEPTH = 3385,
	GL_MAX_VIEWPORT_DIMS = 3386,
	GL_MAX_CLIENT_ATTRIB_STACK_DEPTH = 3387,
	GL_SUBPIXEL_BITS = 3408,
	GL_INDEX_BITS = 3409,
	GL_RED_BITS = 3410,
	GL_GREEN_BITS = 3411,
	GL_BLUE_BITS = 3412,
	GL_ALPHA_BITS = 3413,
	GL_DEPTH_BITS = 3414,
	GL_STENCIL_BITS = 3415,
	GL_ACCUM_RED_BITS = 3416,
	GL_ACCUM_GREEN_BITS = 3417,
	GL_ACCUM_BLUE_BITS = 3418,
	GL_ACCUM_ALPHA_BITS = 3419,
	GL_NAME_STACK_DEPTH = 3440,
	GL_AUTO_NORMAL = 3456,
	GL_MAP1_COLOR_4 = 3472,
	GL_MAP1_INDEX = 3473,
	GL_MAP1_NORMAL = 3474,
	GL_MAP1_TEXTURE_COORD_1 = 3475,
	GL_MAP1_TEXTURE_COORD_2 = 3476,
	GL_MAP1_TEXTURE_COORD_3 = 3477,
	GL_MAP1_TEXTURE_COORD_4 = 3478,
	GL_MAP1_VERTEX_3 = 3479,
	GL_MAP1_VERTEX_4 = 3480,
	GL_MAP2_COLOR_4 = 3504,
	GL_MAP2_INDEX = 3505,
	GL_MAP2_NORMAL = 3506,
	GL_MAP2_TEXTURE_COORD_1 = 3507,
	GL_MAP2_TEXTURE_COORD_2 = 3508,
	GL_MAP2_TEXTURE_COORD_3 = 3509,
	GL_MAP2_TEXTURE_COORD_4 = 3510,
	GL_MAP2_VERTEX_3 = 3511,
	GL_MAP2_VERTEX_4 = 3512,
	GL_MAP1_GRID_DOMAIN = 3536,
	GL_MAP1_GRID_SEGMENTS = 3537,
	GL_MAP2_GRID_DOMAIN = 3538,
	GL_MAP2_GRID_SEGMENTS = 3539,
	GL_TEXTURE_1D = 3552,
	GL_TEXTURE_2D = 3553,
	GL_FEEDBACK_BUFFER_POINTER = 3568,
	GL_FEEDBACK_BUFFER_SIZE = 3569,
	GL_FEEDBACK_BUFFER_TYPE = 3570,
	GL_SELECTION_BUFFER_POINTER = 3571,
	GL_SELECTION_BUFFER_SIZE = 3572,
	GL_TEXTURE_WIDTH = 4096,
	GL_TEXTURE_HEIGHT = 4097,
	GL_TEXTURE_INTERNAL_FORMAT = 4099,
	GL_TEXTURE_BORDER_COLOR = 4100,
	GL_TEXTURE_BORDER = 4101,
	GL_DONT_CARE = 4352,
	GL_FASTEST = 4353,
	GL_NICEST = 4354,
	GL_LIGHT0 = 16384,
	GL_LIGHT1 = 16385,
	GL_LIGHT2 = 16386,
	GL_LIGHT3 = 16387,
	GL_LIGHT4 = 16388,
	GL_LIGHT5 = 16389,
	GL_LIGHT6 = 16390,
	GL_LIGHT7 = 16391,
	GL_AMBIENT = 4608,
	GL_DIFFUSE = 4609,
	GL_SPECULAR = 4610,
	GL_POSITION = 4611,
	GL_SPOT_DIRECTION = 4612,
	GL_SPOT_EXPONENT = 4613,
	GL_SPOT_CUTOFF = 4614,
	GL_CONSTANT_ATTENUATION = 4615,
	GL_LINEAR_ATTENUATION = 4616,
	GL_QUADRATIC_ATTENUATION = 4617,
	GL_COMPILE = 4864,
	GL_COMPILE_AND_EXECUTE = 4865,
	GL_CLEAR = 5376,
	GL_AND = 5377,
	GL_AND_REVERSE = 5378,
	GL_COPY = 5379,
	GL_AND_INVERTED = 5380,
	GL_NOOP = 5381,
	GL_XOR = 5382,
	GL_OR = 5383,
	GL_NOR = 5384,
	GL_EQUIV = 5385,
	GL_INVERT = 5386,
	GL_OR_REVERSE = 5387,
	GL_COPY_INVERTED = 5388,
	GL_OR_INVERTED = 5389,
	GL_NAND = 5390,
	GL_SET = 5391,
	GL_EMISSION = 5632,
	GL_SHININESS = 5633,
	GL_AMBIENT_AND_DIFFUSE = 5634,
	GL_COLOR_INDEXES = 5635,
	GL_MODELVIEW = 5888,
	GL_PROJECTION = 5889,
	GL_TEXTURE = 5890,
	GL_COLOR = 6144,
	GL_DEPTH = 6145,
	GL_STENCIL = 6146,
	GL_COLOR_INDEX = 6400,
	GL_STENCIL_INDEX = 6401,
	GL_DEPTH_COMPONENT = 6402,
	GL_RED = 6403,
	GL_GREEN = 6404,
	GL_BLUE = 6405,
	GL_ALPHA = 6406,
	GL_RGB = 6407,
	GL_RGBA = 6408,
	GL_LUMINANCE = 6409,
	GL_LUMINANCE_ALPHA = 6410,
	GL_BITMAP = 6656,
	GL_POINT = 6912,
	GL_LINE = 6913,
	GL_FILL = 6914,
	GL_RENDER = 7168,
	GL_FEEDBACK = 7169,
	GL_SELECT = 7170,
	GL_FLAT = 7424,
	GL_SMOOTH = 7425,
	GL_KEEP = 7680,
	GL_REPLACE = 7681,
	GL_INCR = 7682,
	GL_DECR = 7683,
	GL_VENDOR = 7936,
	GL_RENDERER = 7937,
	GL_VERSION = 7938,
	GL_EXTENSIONS = 7939,
	GL_S = 8192,
	GL_T = 8193,
	GL_R = 8194,
	GL_Q = 8195,
	GL_MODULATE = 8448,
	GL_DECAL = 8449,
	GL_TEXTURE_ENV_MODE = 8704,
	GL_TEXTURE_ENV_COLOR = 8705,
	GL_TEXTURE_ENV = 8960,
	GL_EYE_LINEAR = 9216,
	GL_OBJECT_LINEAR = 9217,
	GL_SPHERE_MAP = 9218,
	GL_TEXTURE_GEN_MODE = 9472,
	GL_OBJECT_PLANE = 9473,
	GL_EYE_PLANE = 9474,
	GL_NEAREST = 9728,
	GL_LINEAR = 9729,
	GL_NEAREST_MIPMAP_NEAREST = 9984,
	GL_LINEAR_MIPMAP_NEAREST = 9985,
	GL_NEAREST_MIPMAP_LINEAR = 9986,
	GL_LINEAR_MIPMAP_LINEAR = 9987,
	GL_TEXTURE_MAG_FILTER = 10240,
	GL_TEXTURE_MIN_FILTER = 10241,
	GL_TEXTURE_WRAP_S = 10242,
	GL_TEXTURE_WRAP_T = 10243,
	GL_CLAMP = 10496,
	GL_REPEAT = 10497,
	GL_CLIENT_PIXEL_STORE_BIT = 1,
	GL_CLIENT_VERTEX_ARRAY_BIT = 2,
	GL_CLIENT_ALL_ATTRIB_BITS = 4294967295,
	GL_POLYGON_OFFSET_FACTOR = 32824,
	GL_POLYGON_OFFSET_UNITS = 10752,
	GL_POLYGON_OFFSET_POINT = 10753,
	GL_POLYGON_OFFSET_LINE = 10754,
	GL_POLYGON_OFFSET_FILL = 32823,
	GL_ALPHA4 = 32827,
	GL_ALPHA8 = 32828,
	GL_ALPHA12 = 32829,
	GL_ALPHA16 = 32830,
	GL_LUMINANCE4 = 32831,
	GL_LUMINANCE8 = 32832,
	GL_LUMINANCE12 = 32833,
	GL_LUMINANCE16 = 32834,
	GL_LUMINANCE4_ALPHA4 = 32835,
	GL_LUMINANCE6_ALPHA2 = 32836,
	GL_LUMINANCE8_ALPHA8 = 32837,
	GL_LUMINANCE12_ALPHA4 = 32838,
	GL_LUMINANCE12_ALPHA12 = 32839,
	GL_LUMINANCE16_ALPHA16 = 32840,
	GL_INTENSITY = 32841,
	GL_INTENSITY4 = 32842,
	GL_INTENSITY8 = 32843,
	GL_INTENSITY12 = 32844,
	GL_INTENSITY16 = 32845,
	GL_R3_G3_B2 = 10768,
	GL_RGB4 = 32847,
	GL_RGB5 = 32848,
	GL_RGB8 = 32849,
	GL_RGB10 = 32850,
	GL_RGB12 = 32851,
	GL_RGB16 = 32852,
	GL_RGBA2 = 32853,
	GL_RGBA4 = 32854,
	GL_RGB5_A1 = 32855,
	GL_RGBA8 = 32856,
	GL_RGB10_A2 = 32857,
	GL_RGBA12 = 32858,
	GL_RGBA16 = 32859,
	GL_TEXTURE_RED_SIZE = 32860,
	GL_TEXTURE_GREEN_SIZE = 32861,
	GL_TEXTURE_BLUE_SIZE = 32862,
	GL_TEXTURE_ALPHA_SIZE = 32863,
	GL_TEXTURE_LUMINANCE_SIZE = 32864,
	GL_TEXTURE_INTENSITY_SIZE = 32865,
	GL_PROXY_TEXTURE_1D = 32867,
	GL_PROXY_TEXTURE_2D = 32868,
	GL_TEXTURE_PRIORITY = 32870,
	GL_TEXTURE_RESIDENT = 32871,
	GL_TEXTURE_BINDING_1D = 32872,
	GL_TEXTURE_BINDING_2D = 32873,
	GL_VERTEX_ARRAY = 32884,
	GL_NORMAL_ARRAY = 32885,
	GL_COLOR_ARRAY = 32886,
	GL_INDEX_ARRAY = 32887,
	GL_TEXTURE_COORD_ARRAY = 32888,
	GL_EDGE_FLAG_ARRAY = 32889,
	GL_VERTEX_ARRAY_SIZE = 32890,
	GL_VERTEX_ARRAY_TYPE = 32891,
	GL_VERTEX_ARRAY_STRIDE = 32892,
	GL_NORMAL_ARRAY_TYPE = 32894,
	GL_NORMAL_ARRAY_STRIDE = 32895,
	GL_COLOR_ARRAY_SIZE = 32897,
	GL_COLOR_ARRAY_TYPE = 32898,
	GL_COLOR_ARRAY_STRIDE = 32899,
	GL_INDEX_ARRAY_TYPE = 32901,
	GL_INDEX_ARRAY_STRIDE = 32902,
	GL_TEXTURE_COORD_ARRAY_SIZE = 32904,
	GL_TEXTURE_COORD_ARRAY_TYPE = 32905,
	GL_TEXTURE_COORD_ARRAY_STRIDE = 32906,
	GL_EDGE_FLAG_ARRAY_STRIDE = 32908,
	GL_VERTEX_ARRAY_POINTER = 32910,
	GL_NORMAL_ARRAY_POINTER = 32911,
	GL_COLOR_ARRAY_POINTER = 32912,
	GL_INDEX_ARRAY_POINTER = 32913,
	GL_TEXTURE_COORD_ARRAY_POINTER = 32914,
	GL_EDGE_FLAG_ARRAY_POINTER = 32915,
	GL_V2F = 10784,
	GL_V3F = 10785,
	GL_C4UB_V2F = 10786,
	GL_C4UB_V3F = 10787,
	GL_C3F_V3F = 10788,
	GL_N3F_V3F = 10789,
	GL_C4F_N3F_V3F = 10790,
	GL_T2F_V3F = 10791,
	GL_T4F_V4F = 10792,
	GL_T2F_C4UB_V3F = 10793,
	GL_T2F_C3F_V3F = 10794,
	GL_T2F_N3F_V3F = 10795,
	GL_T2F_C4F_N3F_V3F = 10796,
	GL_T4F_C4F_N3F_V4F = 10797,
	GL_EXT_vertex_array = 1,
	GL_EXT_bgra = 1,
	GL_EXT_paletted_texture = 1,
	GL_WIN_swap_hint = 1,
	GL_WIN_draw_range_elements = 1,
	GL_VERTEX_ARRAY_EXT = 32884,
	GL_NORMAL_ARRAY_EXT = 32885,
	GL_COLOR_ARRAY_EXT = 32886,
	GL_INDEX_ARRAY_EXT = 32887,
	GL_TEXTURE_COORD_ARRAY_EXT = 32888,
	GL_EDGE_FLAG_ARRAY_EXT = 32889,
	GL_VERTEX_ARRAY_SIZE_EXT = 32890,
	GL_VERTEX_ARRAY_TYPE_EXT = 32891,
	GL_VERTEX_ARRAY_STRIDE_EXT = 32892,
	GL_VERTEX_ARRAY_COUNT_EXT = 32893,
	GL_NORMAL_ARRAY_TYPE_EXT = 32894,
	GL_NORMAL_ARRAY_STRIDE_EXT = 32895,
	GL_NORMAL_ARRAY_COUNT_EXT = 32896,
	GL_COLOR_ARRAY_SIZE_EXT = 32897,
	GL_COLOR_ARRAY_TYPE_EXT = 32898,
	GL_COLOR_ARRAY_STRIDE_EXT = 32899,
	GL_COLOR_ARRAY_COUNT_EXT = 32900,
	GL_INDEX_ARRAY_TYPE_EXT = 32901,
	GL_INDEX_ARRAY_STRIDE_EXT = 32902,
	GL_INDEX_ARRAY_COUNT_EXT = 32903,
	GL_TEXTURE_COORD_ARRAY_SIZE_EXT = 32904,
	GL_TEXTURE_COORD_ARRAY_TYPE_EXT = 32905,
	GL_TEXTURE_COORD_ARRAY_STRIDE_EXT = 32906,
	GL_TEXTURE_COORD_ARRAY_COUNT_EXT = 32907,
	GL_EDGE_FLAG_ARRAY_STRIDE_EXT = 32908,
	GL_EDGE_FLAG_ARRAY_COUNT_EXT = 32909,
	GL_VERTEX_ARRAY_POINTER_EXT = 32910,
	GL_NORMAL_ARRAY_POINTER_EXT = 32911,
	GL_COLOR_ARRAY_POINTER_EXT = 32912,
	GL_INDEX_ARRAY_POINTER_EXT = 32913,
	GL_TEXTURE_COORD_ARRAY_POINTER_EXT = 32914,
	GL_EDGE_FLAG_ARRAY_POINTER_EXT = 32915,
	GL_DOUBLE_EXT = 5130,
	GL_BGR_EXT = 32992,
	GL_BGRA_EXT = 32993,
	GL_COLOR_TABLE_FORMAT_EXT = 32984,
	GL_COLOR_TABLE_WIDTH_EXT = 32985,
	GL_COLOR_TABLE_RED_SIZE_EXT = 32986,
	GL_COLOR_TABLE_GREEN_SIZE_EXT = 32987,
	GL_COLOR_TABLE_BLUE_SIZE_EXT = 32988,
	GL_COLOR_TABLE_ALPHA_SIZE_EXT = 32989,
	GL_COLOR_TABLE_LUMINANCE_SIZE_EXT = 32990,
	GL_COLOR_TABLE_INTENSITY_SIZE_EXT = 32991,
	GL_COLOR_INDEX1_EXT = 32994,
	GL_COLOR_INDEX2_EXT = 32995,
	GL_COLOR_INDEX4_EXT = 32996,
	GL_COLOR_INDEX8_EXT = 32997,
	GL_COLOR_INDEX12_EXT = 32998,
	GL_COLOR_INDEX16_EXT = 32999,
	GL_MAX_ELEMENTS_VERTICES_WIN = 33000,
	GL_MAX_ELEMENTS_INDICES_WIN = 33001,
	GL_PHONG_WIN = 33002,
	GL_PHONG_HINT_WIN = 33003,
	GL_FOG_SPECULAR_TEXTURE_WIN = 33004,
	GL_LOGIC_OP = 3057,
	GL_TEXTURE_COMPONENTS = 4099,
	GLAPI = 0,
	GL_GLEXT_VERSION = 20210107,
	GL_VERSION_1_2 = 1,
	GL_UNSIGNED_BYTE_3_3_2 = 32818,
	GL_UNSIGNED_SHORT_4_4_4_4 = 32819,
	GL_UNSIGNED_SHORT_5_5_5_1 = 32820,
	GL_UNSIGNED_INT_8_8_8_8 = 32821,
	GL_UNSIGNED_INT_10_10_10_2 = 32822,
	GL_TEXTURE_BINDING_3D = 32874,
	GL_PACK_SKIP_IMAGES = 32875,
	GL_PACK_IMAGE_HEIGHT = 32876,
	GL_UNPACK_SKIP_IMAGES = 32877,
	GL_UNPACK_IMAGE_HEIGHT = 32878,
	GL_TEXTURE_3D = 32879,
	GL_PROXY_TEXTURE_3D = 32880,
	GL_TEXTURE_DEPTH = 32881,
	GL_TEXTURE_WRAP_R = 32882,
	GL_MAX_3D_TEXTURE_SIZE = 32883,
	GL_UNSIGNED_BYTE_2_3_3_REV = 33634,
	GL_UNSIGNED_SHORT_5_6_5 = 33635,
	GL_UNSIGNED_SHORT_5_6_5_REV = 33636,
	GL_UNSIGNED_SHORT_4_4_4_4_REV = 33637,
	GL_UNSIGNED_SHORT_1_5_5_5_REV = 33638,
	GL_UNSIGNED_INT_8_8_8_8_REV = 33639,
	GL_UNSIGNED_INT_2_10_10_10_REV = 33640,
	GL_BGR = 32992,
	GL_BGRA = 32993,
	GL_MAX_ELEMENTS_VERTICES = 33000,
	GL_MAX_ELEMENTS_INDICES = 33001,
	GL_CLAMP_TO_EDGE = 33071,
	GL_TEXTURE_MIN_LOD = 33082,
	GL_TEXTURE_MAX_LOD = 33083,
	GL_TEXTURE_BASE_LEVEL = 33084,
	GL_TEXTURE_MAX_LEVEL = 33085,
	GL_SMOOTH_POINT_SIZE_RANGE = 2834,
	GL_SMOOTH_POINT_SIZE_GRANULARITY = 2835,
	GL_SMOOTH_LINE_WIDTH_RANGE = 2850,
	GL_SMOOTH_LINE_WIDTH_GRANULARITY = 2851,
	GL_ALIASED_LINE_WIDTH_RANGE = 33902,
	GL_RESCALE_NORMAL = 32826,
	GL_LIGHT_MODEL_COLOR_CONTROL = 33272,
	GL_SINGLE_COLOR = 33273,
	GL_SEPARATE_SPECULAR_COLOR = 33274,
	GL_ALIASED_POINT_SIZE_RANGE = 33901,
	GL_VERSION_1_3 = 1,
	GL_TEXTURE0 = 33984,
	GL_TEXTURE1 = 33985,
	GL_TEXTURE2 = 33986,
	GL_TEXTURE3 = 33987,
	GL_TEXTURE4 = 33988,
	GL_TEXTURE5 = 33989,
	GL_TEXTURE6 = 33990,
	GL_TEXTURE7 = 33991,
	GL_TEXTURE8 = 33992,
	GL_TEXTURE9 = 33993,
	GL_TEXTURE10 = 33994,
	GL_TEXTURE11 = 33995,
	GL_TEXTURE12 = 33996,
	GL_TEXTURE13 = 33997,
	GL_TEXTURE14 = 33998,
	GL_TEXTURE15 = 33999,
	GL_TEXTURE16 = 34000,
	GL_TEXTURE17 = 34001,
	GL_TEXTURE18 = 34002,
	GL_TEXTURE19 = 34003,
	GL_TEXTURE20 = 34004,
	GL_TEXTURE21 = 34005,
	GL_TEXTURE22 = 34006,
	GL_TEXTURE23 = 34007,
	GL_TEXTURE24 = 34008,
	GL_TEXTURE25 = 34009,
	GL_TEXTURE26 = 34010,
	GL_TEXTURE27 = 34011,
	GL_TEXTURE28 = 34012,
	GL_TEXTURE29 = 34013,
	GL_TEXTURE30 = 34014,
	GL_TEXTURE31 = 34015,
	GL_ACTIVE_TEXTURE = 34016,
	GL_MULTISAMPLE = 32925,
	GL_SAMPLE_ALPHA_TO_COVERAGE = 32926,
	GL_SAMPLE_ALPHA_TO_ONE = 32927,
	GL_SAMPLE_COVERAGE = 32928,
	GL_SAMPLE_BUFFERS = 32936,
	GL_SAMPLES = 32937,
	GL_SAMPLE_COVERAGE_VALUE = 32938,
	GL_SAMPLE_COVERAGE_INVERT = 32939,
	GL_TEXTURE_CUBE_MAP = 34067,
	GL_TEXTURE_BINDING_CUBE_MAP = 34068,
	GL_TEXTURE_CUBE_MAP_POSITIVE_X = 34069,
	GL_TEXTURE_CUBE_MAP_NEGATIVE_X = 34070,
	GL_TEXTURE_CUBE_MAP_POSITIVE_Y = 34071,
	GL_TEXTURE_CUBE_MAP_NEGATIVE_Y = 34072,
	GL_TEXTURE_CUBE_MAP_POSITIVE_Z = 34073,
	GL_TEXTURE_CUBE_MAP_NEGATIVE_Z = 34074,
	GL_PROXY_TEXTURE_CUBE_MAP = 34075,
	GL_MAX_CUBE_MAP_TEXTURE_SIZE = 34076,
	GL_COMPRESSED_RGB = 34029,
	GL_COMPRESSED_RGBA = 34030,
	GL_TEXTURE_COMPRESSION_HINT = 34031,
	GL_TEXTURE_COMPRESSED_IMAGE_SIZE = 34464,
	GL_TEXTURE_COMPRESSED = 34465,
	GL_NUM_COMPRESSED_TEXTURE_FORMATS = 34466,
	GL_COMPRESSED_TEXTURE_FORMATS = 34467,
	GL_CLAMP_TO_BORDER = 33069,
	GL_CLIENT_ACTIVE_TEXTURE = 34017,
	GL_MAX_TEXTURE_UNITS = 34018,
	GL_TRANSPOSE_MODELVIEW_MATRIX = 34019,
	GL_TRANSPOSE_PROJECTION_MATRIX = 34020,
	GL_TRANSPOSE_TEXTURE_MATRIX = 34021,
	GL_TRANSPOSE_COLOR_MATRIX = 34022,
	GL_MULTISAMPLE_BIT = 536870912,
	GL_NORMAL_MAP = 34065,
	GL_REFLECTION_MAP = 34066,
	GL_COMPRESSED_ALPHA = 34025,
	GL_COMPRESSED_LUMINANCE = 34026,
	GL_COMPRESSED_LUMINANCE_ALPHA = 34027,
	GL_COMPRESSED_INTENSITY = 34028,
	GL_COMBINE = 34160,
	GL_COMBINE_RGB = 34161,
	GL_COMBINE_ALPHA = 34162,
	GL_SOURCE0_RGB = 34176,
	GL_SOURCE1_RGB = 34177,
	GL_SOURCE2_RGB = 34178,
	GL_SOURCE0_ALPHA = 34184,
	GL_SOURCE1_ALPHA = 34185,
	GL_SOURCE2_ALPHA = 34186,
	GL_OPERAND0_RGB = 34192,
	GL_OPERAND1_RGB = 34193,
	GL_OPERAND2_RGB = 34194,
	GL_OPERAND0_ALPHA = 34200,
	GL_OPERAND1_ALPHA = 34201,
	GL_OPERAND2_ALPHA = 34202,
	GL_RGB_SCALE = 34163,
	GL_ADD_SIGNED = 34164,
	GL_INTERPOLATE = 34165,
	GL_SUBTRACT = 34023,
	GL_CONSTANT = 34166,
	GL_PRIMARY_COLOR = 34167,
	GL_PREVIOUS = 34168,
	GL_DOT3_RGB = 34478,
	GL_DOT3_RGBA = 34479,
	GL_VERSION_1_4 = 1,
	GL_BLEND_DST_RGB = 32968,
	GL_BLEND_SRC_RGB = 32969,
	GL_BLEND_DST_ALPHA = 32970,
	GL_BLEND_SRC_ALPHA = 32971,
	GL_POINT_FADE_THRESHOLD_SIZE = 33064,
	GL_DEPTH_COMPONENT16 = 33189,
	GL_DEPTH_COMPONENT24 = 33190,
	GL_DEPTH_COMPONENT32 = 33191,
	GL_MIRRORED_REPEAT = 33648,
	GL_MAX_TEXTURE_LOD_BIAS = 34045,
	GL_TEXTURE_LOD_BIAS = 34049,
	GL_INCR_WRAP = 34055,
	GL_DECR_WRAP = 34056,
	GL_TEXTURE_DEPTH_SIZE = 34890,
	GL_TEXTURE_COMPARE_MODE = 34892,
	GL_TEXTURE_COMPARE_FUNC = 34893,
	GL_POINT_SIZE_MIN = 33062,
	GL_POINT_SIZE_MAX = 33063,
	GL_POINT_DISTANCE_ATTENUATION = 33065,
	GL_GENERATE_MIPMAP = 33169,
	GL_GENERATE_MIPMAP_HINT = 33170,
	GL_FOG_COORDINATE_SOURCE = 33872,
	GL_FOG_COORDINATE = 33873,
	GL_FRAGMENT_DEPTH = 33874,
	GL_CURRENT_FOG_COORDINATE = 33875,
	GL_FOG_COORDINATE_ARRAY_TYPE = 33876,
	GL_FOG_COORDINATE_ARRAY_STRIDE = 33877,
	GL_FOG_COORDINATE_ARRAY_POINTER = 33878,
	GL_FOG_COORDINATE_ARRAY = 33879,
	GL_COLOR_SUM = 33880,
	GL_CURRENT_SECONDARY_COLOR = 33881,
	GL_SECONDARY_COLOR_ARRAY_SIZE = 33882,
	GL_SECONDARY_COLOR_ARRAY_TYPE = 33883,
	GL_SECONDARY_COLOR_ARRAY_STRIDE = 33884,
	GL_SECONDARY_COLOR_ARRAY_POINTER = 33885,
	GL_SECONDARY_COLOR_ARRAY = 33886,
	GL_TEXTURE_FILTER_CONTROL = 34048,
	GL_DEPTH_TEXTURE_MODE = 34891,
	GL_COMPARE_R_TO_TEXTURE = 34894,
	GL_BLEND_COLOR = 32773,
	GL_BLEND_EQUATION = 32777,
	GL_CONSTANT_COLOR = 32769,
	GL_ONE_MINUS_CONSTANT_COLOR = 32770,
	GL_CONSTANT_ALPHA = 32771,
	GL_ONE_MINUS_CONSTANT_ALPHA = 32772,
	GL_FUNC_ADD = 32774,
	GL_FUNC_REVERSE_SUBTRACT = 32779,
	GL_FUNC_SUBTRACT = 32778,
	GL_MIN = 32775,
	GL_MAX = 32776,
	GL_VERSION_1_5 = 1,
	GL_BUFFER_SIZE = 34660,
	GL_BUFFER_USAGE = 34661,
	GL_QUERY_COUNTER_BITS = 34916,
	GL_CURRENT_QUERY = 34917,
	GL_QUERY_RESULT = 34918,
	GL_QUERY_RESULT_AVAILABLE = 34919,
	GL_ARRAY_BUFFER = 34962,
	GL_ELEMENT_ARRAY_BUFFER = 34963,
	GL_ARRAY_BUFFER_BINDING = 34964,
	GL_ELEMENT_ARRAY_BUFFER_BINDING = 34965,
	GL_VERTEX_ATTRIB_ARRAY_BUFFER_BINDING = 34975,
	GL_READ_ONLY = 35000,
	GL_WRITE_ONLY = 35001,
	GL_READ_WRITE = 35002,
	GL_BUFFER_ACCESS = 35003,
	GL_BUFFER_MAPPED = 35004,
	GL_BUFFER_MAP_POINTER = 35005,
	GL_STREAM_DRAW = 35040,
	GL_STREAM_READ = 35041,
	GL_STREAM_COPY = 35042,
	GL_STATIC_DRAW = 35044,
	GL_STATIC_READ = 35045,
	GL_STATIC_COPY = 35046,
	GL_DYNAMIC_DRAW = 35048,
	GL_DYNAMIC_READ = 35049,
	GL_DYNAMIC_COPY = 35050,
	GL_SAMPLES_PASSED = 35092,
	GL_SRC1_ALPHA = 34185,
	GL_VERTEX_ARRAY_BUFFER_BINDING = 34966,
	GL_NORMAL_ARRAY_BUFFER_BINDING = 34967,
	GL_COLOR_ARRAY_BUFFER_BINDING = 34968,
	GL_INDEX_ARRAY_BUFFER_BINDING = 34969,
	GL_TEXTURE_COORD_ARRAY_BUFFER_BINDING = 34970,
	GL_EDGE_FLAG_ARRAY_BUFFER_BINDING = 34971,
	GL_SECONDARY_COLOR_ARRAY_BUFFER_BINDING = 34972,
	GL_FOG_COORDINATE_ARRAY_BUFFER_BINDING = 34973,
	GL_WEIGHT_ARRAY_BUFFER_BINDING = 34974,
	GL_FOG_COORD_SRC = 33872,
	GL_FOG_COORD = 33873,
	GL_CURRENT_FOG_COORD = 33875,
	GL_FOG_COORD_ARRAY_TYPE = 33876,
	GL_FOG_COORD_ARRAY_STRIDE = 33877,
	GL_FOG_COORD_ARRAY_POINTER = 33878,
	GL_FOG_COORD_ARRAY = 33879,
	GL_FOG_COORD_ARRAY_BUFFER_BINDING = 34973,
	GL_SRC0_RGB = 34176,
	GL_SRC1_RGB = 34177,
	GL_SRC2_RGB = 34178,
	GL_SRC0_ALPHA = 34184,
	GL_SRC2_ALPHA = 34186,
	GL_VERSION_2_0 = 1,
	GL_BLEND_EQUATION_RGB = 32777,
	GL_VERTEX_ATTRIB_ARRAY_ENABLED = 34338,
	GL_VERTEX_ATTRIB_ARRAY_SIZE = 34339,
	GL_VERTEX_ATTRIB_ARRAY_STRIDE = 34340,
	GL_VERTEX_ATTRIB_ARRAY_TYPE = 34341,
	GL_CURRENT_VERTEX_ATTRIB = 34342,
	GL_VERTEX_PROGRAM_POINT_SIZE = 34370,
	GL_VERTEX_ATTRIB_ARRAY_POINTER = 34373,
	GL_STENCIL_BACK_FUNC = 34816,
	GL_STENCIL_BACK_FAIL = 34817,
	GL_STENCIL_BACK_PASS_DEPTH_FAIL = 34818,
	GL_STENCIL_BACK_PASS_DEPTH_PASS = 34819,
	GL_MAX_DRAW_BUFFERS = 34852,
	GL_DRAW_BUFFER0 = 34853,
	GL_DRAW_BUFFER1 = 34854,
	GL_DRAW_BUFFER2 = 34855,
	GL_DRAW_BUFFER3 = 34856,
	GL_DRAW_BUFFER4 = 34857,
	GL_DRAW_BUFFER5 = 34858,
	GL_DRAW_BUFFER6 = 34859,
	GL_DRAW_BUFFER7 = 34860,
	GL_DRAW_BUFFER8 = 34861,
	GL_DRAW_BUFFER9 = 34862,
	GL_DRAW_BUFFER10 = 34863,
	GL_DRAW_BUFFER11 = 34864,
	GL_DRAW_BUFFER12 = 34865,
	GL_DRAW_BUFFER13 = 34866,
	GL_DRAW_BUFFER14 = 34867,
	GL_DRAW_BUFFER15 = 34868,
	GL_BLEND_EQUATION_ALPHA = 34877,
	GL_MAX_VERTEX_ATTRIBS = 34921,
	GL_VERTEX_ATTRIB_ARRAY_NORMALIZED = 34922,
	GL_MAX_TEXTURE_IMAGE_UNITS = 34930,
	GL_FRAGMENT_SHADER = 35632,
	GL_VERTEX_SHADER = 35633,
	GL_MAX_FRAGMENT_UNIFORM_COMPONENTS = 35657,
	GL_MAX_VERTEX_UNIFORM_COMPONENTS = 35658,
	GL_MAX_VARYING_FLOATS = 35659,
	GL_MAX_VERTEX_TEXTURE_IMAGE_UNITS = 35660,
	GL_MAX_COMBINED_TEXTURE_IMAGE_UNITS = 35661,
	GL_SHADER_TYPE = 35663,
	GL_FLOAT_VEC2 = 35664,
	GL_FLOAT_VEC3 = 35665,
	GL_FLOAT_VEC4 = 35666,
	GL_INT_VEC2 = 35667,
	GL_INT_VEC3 = 35668,
	GL_INT_VEC4 = 35669,
	GL_BOOL = 35670,
	GL_BOOL_VEC2 = 35671,
	GL_BOOL_VEC3 = 35672,
	GL_BOOL_VEC4 = 35673,
	GL_FLOAT_MAT2 = 35674,
	GL_FLOAT_MAT3 = 35675,
	GL_FLOAT_MAT4 = 35676,
	GL_SAMPLER_1D = 35677,
	GL_SAMPLER_2D = 35678,
	GL_SAMPLER_3D = 35679,
	GL_SAMPLER_CUBE = 35680,
	GL_SAMPLER_1D_SHADOW = 35681,
	GL_SAMPLER_2D_SHADOW = 35682,
	GL_DELETE_STATUS = 35712,
	GL_COMPILE_STATUS = 35713,
	GL_LINK_STATUS = 35714,
	GL_VALIDATE_STATUS = 35715,
	GL_INFO_LOG_LENGTH = 35716,
	GL_ATTACHED_SHADERS = 35717,
	GL_ACTIVE_UNIFORMS = 35718,
	GL_ACTIVE_UNIFORM_MAX_LENGTH = 35719,
	GL_SHADER_SOURCE_LENGTH = 35720,
	GL_ACTIVE_ATTRIBUTES = 35721,
	GL_ACTIVE_ATTRIBUTE_MAX_LENGTH = 35722,
	GL_FRAGMENT_SHADER_DERIVATIVE_HINT = 35723,
	GL_SHADING_LANGUAGE_VERSION = 35724,
	GL_CURRENT_PROGRAM = 35725,
	GL_POINT_SPRITE_COORD_ORIGIN = 36000,
	GL_LOWER_LEFT = 36001,
	GL_UPPER_LEFT = 36002,
	GL_STENCIL_BACK_REF = 36003,
	GL_STENCIL_BACK_VALUE_MASK = 36004,
	GL_STENCIL_BACK_WRITEMASK = 36005,
	GL_VERTEX_PROGRAM_TWO_SIDE = 34371,
	GL_POINT_SPRITE = 34913,
	GL_COORD_REPLACE = 34914,
	GL_MAX_TEXTURE_COORDS = 34929,
	GL_VERSION_2_1 = 1,
	GL_PIXEL_PACK_BUFFER = 35051,
	GL_PIXEL_UNPACK_BUFFER = 35052,
	GL_PIXEL_PACK_BUFFER_BINDING = 35053,
	GL_PIXEL_UNPACK_BUFFER_BINDING = 35055,
	GL_FLOAT_MAT2x3 = 35685,
	GL_FLOAT_MAT2x4 = 35686,
	GL_FLOAT_MAT3x2 = 35687,
	GL_FLOAT_MAT3x4 = 35688,
	GL_FLOAT_MAT4x2 = 35689,
	GL_FLOAT_MAT4x3 = 35690,
	GL_SRGB = 35904,
	GL_SRGB8 = 35905,
	GL_SRGB_ALPHA = 35906,
	GL_SRGB8_ALPHA8 = 35907,
	GL_COMPRESSED_SRGB = 35912,
	GL_COMPRESSED_SRGB_ALPHA = 35913,
	GL_CURRENT_RASTER_SECONDARY_COLOR = 33887,
	GL_SLUMINANCE_ALPHA = 35908,
	GL_SLUMINANCE8_ALPHA8 = 35909,
	GL_SLUMINANCE = 35910,
	GL_SLUMINANCE8 = 35911,
	GL_COMPRESSED_SLUMINANCE = 35914,
	GL_COMPRESSED_SLUMINANCE_ALPHA = 35915,
	GL_VERSION_3_0 = 1,
	GL_COMPARE_REF_TO_TEXTURE = 34894,
	GL_CLIP_DISTANCE0 = 12288,
	GL_CLIP_DISTANCE1 = 12289,
	GL_CLIP_DISTANCE2 = 12290,
	GL_CLIP_DISTANCE3 = 12291,
	GL_CLIP_DISTANCE4 = 12292,
	GL_CLIP_DISTANCE5 = 12293,
	GL_CLIP_DISTANCE6 = 12294,
	GL_CLIP_DISTANCE7 = 12295,
	GL_MAX_CLIP_DISTANCES = 3378,
	GL_MAJOR_VERSION = 33307,
	GL_MINOR_VERSION = 33308,
	GL_NUM_EXTENSIONS = 33309,
	GL_CONTEXT_FLAGS = 33310,
	GL_COMPRESSED_RED = 33317,
	GL_COMPRESSED_RG = 33318,
	GL_CONTEXT_FLAG_FORWARD_COMPATIBLE_BIT = 1,
	GL_RGBA32F = 34836,
	GL_RGB32F = 34837,
	GL_RGBA16F = 34842,
	GL_RGB16F = 34843,
	GL_VERTEX_ATTRIB_ARRAY_INTEGER = 35069,
	GL_MAX_ARRAY_TEXTURE_LAYERS = 35071,
	GL_MIN_PROGRAM_TEXEL_OFFSET = 35076,
	GL_MAX_PROGRAM_TEXEL_OFFSET = 35077,
	GL_CLAMP_READ_COLOR = 35100,
	GL_FIXED_ONLY = 35101,
	GL_MAX_VARYING_COMPONENTS = 35659,
	GL_TEXTURE_1D_ARRAY = 35864,
	GL_PROXY_TEXTURE_1D_ARRAY = 35865,
	GL_TEXTURE_2D_ARRAY = 35866,
	GL_PROXY_TEXTURE_2D_ARRAY = 35867,
	GL_TEXTURE_BINDING_1D_ARRAY = 35868,
	GL_TEXTURE_BINDING_2D_ARRAY = 35869,
	GL_R11F_G11F_B10F = 35898,
	GL_UNSIGNED_INT_10F_11F_11F_REV = 35899,
	GL_RGB9_E5 = 35901,
	GL_UNSIGNED_INT_5_9_9_9_REV = 35902,
	GL_TEXTURE_SHARED_SIZE = 35903,
	GL_TRANSFORM_FEEDBACK_VARYING_MAX_LENGTH = 35958,
	GL_TRANSFORM_FEEDBACK_BUFFER_MODE = 35967,
	GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_COMPONENTS = 35968,
	GL_TRANSFORM_FEEDBACK_VARYINGS = 35971,
	GL_TRANSFORM_FEEDBACK_BUFFER_START = 35972,
	GL_TRANSFORM_FEEDBACK_BUFFER_SIZE = 35973,
	GL_PRIMITIVES_GENERATED = 35975,
	GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN = 35976,
	GL_RASTERIZER_DISCARD = 35977,
	GL_MAX_TRANSFORM_FEEDBACK_INTERLEAVED_COMPONENTS = 35978,
	GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_ATTRIBS = 35979,
	GL_INTERLEAVED_ATTRIBS = 35980,
	GL_SEPARATE_ATTRIBS = 35981,
	GL_TRANSFORM_FEEDBACK_BUFFER = 35982,
	GL_TRANSFORM_FEEDBACK_BUFFER_BINDING = 35983,
	GL_RGBA32UI = 36208,
	GL_RGB32UI = 36209,
	GL_RGBA16UI = 36214,
	GL_RGB16UI = 36215,
	GL_RGBA8UI = 36220,
	GL_RGB8UI = 36221,
	GL_RGBA32I = 36226,
	GL_RGB32I = 36227,
	GL_RGBA16I = 36232,
	GL_RGB16I = 36233,
	GL_RGBA8I = 36238,
	GL_RGB8I = 36239,
	GL_RED_INTEGER = 36244,
	GL_GREEN_INTEGER = 36245,
	GL_BLUE_INTEGER = 36246,
	GL_RGB_INTEGER = 36248,
	GL_RGBA_INTEGER = 36249,
	GL_BGR_INTEGER = 36250,
	GL_BGRA_INTEGER = 36251,
	GL_SAMPLER_1D_ARRAY = 36288,
	GL_SAMPLER_2D_ARRAY = 36289,
	GL_SAMPLER_1D_ARRAY_SHADOW = 36291,
	GL_SAMPLER_2D_ARRAY_SHADOW = 36292,
	GL_SAMPLER_CUBE_SHADOW = 36293,
	GL_UNSIGNED_INT_VEC2 = 36294,
	GL_UNSIGNED_INT_VEC3 = 36295,
	GL_UNSIGNED_INT_VEC4 = 36296,
	GL_INT_SAMPLER_1D = 36297,
	GL_INT_SAMPLER_2D = 36298,
	GL_INT_SAMPLER_3D = 36299,
	GL_INT_SAMPLER_CUBE = 36300,
	GL_INT_SAMPLER_1D_ARRAY = 36302,
	GL_INT_SAMPLER_2D_ARRAY = 36303,
	GL_UNSIGNED_INT_SAMPLER_1D = 36305,
	GL_UNSIGNED_INT_SAMPLER_2D = 36306,
	GL_UNSIGNED_INT_SAMPLER_3D = 36307,
	GL_UNSIGNED_INT_SAMPLER_CUBE = 36308,
	GL_UNSIGNED_INT_SAMPLER_1D_ARRAY = 36310,
	GL_UNSIGNED_INT_SAMPLER_2D_ARRAY = 36311,
	GL_QUERY_WAIT = 36371,
	GL_QUERY_NO_WAIT = 36372,
	GL_QUERY_BY_REGION_WAIT = 36373,
	GL_QUERY_BY_REGION_NO_WAIT = 36374,
	GL_BUFFER_ACCESS_FLAGS = 37151,
	GL_BUFFER_MAP_LENGTH = 37152,
	GL_BUFFER_MAP_OFFSET = 37153,
	GL_DEPTH_COMPONENT32F = 36012,
	GL_DEPTH32F_STENCIL8 = 36013,
	GL_FLOAT_32_UNSIGNED_INT_24_8_REV = 36269,
	GL_INVALID_FRAMEBUFFER_OPERATION = 1286,
	GL_FRAMEBUFFER_ATTACHMENT_COLOR_ENCODING = 33296,
	GL_FRAMEBUFFER_ATTACHMENT_COMPONENT_TYPE = 33297,
	GL_FRAMEBUFFER_ATTACHMENT_RED_SIZE = 33298,
	GL_FRAMEBUFFER_ATTACHMENT_GREEN_SIZE = 33299,
	GL_FRAMEBUFFER_ATTACHMENT_BLUE_SIZE = 33300,
	GL_FRAMEBUFFER_ATTACHMENT_ALPHA_SIZE = 33301,
	GL_FRAMEBUFFER_ATTACHMENT_DEPTH_SIZE = 33302,
	GL_FRAMEBUFFER_ATTACHMENT_STENCIL_SIZE = 33303,
	GL_FRAMEBUFFER_DEFAULT = 33304,
	GL_FRAMEBUFFER_UNDEFINED = 33305,
	GL_DEPTH_STENCIL_ATTACHMENT = 33306,
	GL_MAX_RENDERBUFFER_SIZE = 34024,
	GL_DEPTH_STENCIL = 34041,
	GL_UNSIGNED_INT_24_8 = 34042,
	GL_DEPTH24_STENCIL8 = 35056,
	GL_TEXTURE_STENCIL_SIZE = 35057,
	GL_TEXTURE_RED_TYPE = 35856,
	GL_TEXTURE_GREEN_TYPE = 35857,
	GL_TEXTURE_BLUE_TYPE = 35858,
	GL_TEXTURE_ALPHA_TYPE = 35859,
	GL_TEXTURE_DEPTH_TYPE = 35862,
	GL_UNSIGNED_NORMALIZED = 35863,
	GL_FRAMEBUFFER_BINDING = 36006,
	GL_DRAW_FRAMEBUFFER_BINDING = 36006,
	GL_RENDERBUFFER_BINDING = 36007,
	GL_READ_FRAMEBUFFER = 36008,
	GL_DRAW_FRAMEBUFFER = 36009,
	GL_READ_FRAMEBUFFER_BINDING = 36010,
	GL_RENDERBUFFER_SAMPLES = 36011,
	GL_FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE = 36048,
	GL_FRAMEBUFFER_ATTACHMENT_OBJECT_NAME = 36049,
	GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LEVEL = 36050,
	GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_CUBE_MAP_FACE = 36051,
	GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LAYER = 36052,
	GL_FRAMEBUFFER_COMPLETE = 36053,
	GL_FRAMEBUFFER_INCOMPLETE_ATTACHMENT = 36054,
	GL_FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT = 36055,
	GL_FRAMEBUFFER_INCOMPLETE_DRAW_BUFFER = 36059,
	GL_FRAMEBUFFER_INCOMPLETE_READ_BUFFER = 36060,
	GL_FRAMEBUFFER_UNSUPPORTED = 36061,
	GL_MAX_COLOR_ATTACHMENTS = 36063,
	GL_COLOR_ATTACHMENT0 = 36064,
	GL_COLOR_ATTACHMENT1 = 36065,
	GL_COLOR_ATTACHMENT2 = 36066,
	GL_COLOR_ATTACHMENT3 = 36067,
	GL_COLOR_ATTACHMENT4 = 36068,
	GL_COLOR_ATTACHMENT5 = 36069,
	GL_COLOR_ATTACHMENT6 = 36070,
	GL_COLOR_ATTACHMENT7 = 36071,
	GL_COLOR_ATTACHMENT8 = 36072,
	GL_COLOR_ATTACHMENT9 = 36073,
	GL_COLOR_ATTACHMENT10 = 36074,
	GL_COLOR_ATTACHMENT11 = 36075,
	GL_COLOR_ATTACHMENT12 = 36076,
	GL_COLOR_ATTACHMENT13 = 36077,
	GL_COLOR_ATTACHMENT14 = 36078,
	GL_COLOR_ATTACHMENT15 = 36079,
	GL_COLOR_ATTACHMENT16 = 36080,
	GL_COLOR_ATTACHMENT17 = 36081,
	GL_COLOR_ATTACHMENT18 = 36082,
	GL_COLOR_ATTACHMENT19 = 36083,
	GL_COLOR_ATTACHMENT20 = 36084,
	GL_COLOR_ATTACHMENT21 = 36085,
	GL_COLOR_ATTACHMENT22 = 36086,
	GL_COLOR_ATTACHMENT23 = 36087,
	GL_COLOR_ATTACHMENT24 = 36088,
	GL_COLOR_ATTACHMENT25 = 36089,
	GL_COLOR_ATTACHMENT26 = 36090,
	GL_COLOR_ATTACHMENT27 = 36091,
	GL_COLOR_ATTACHMENT28 = 36092,
	GL_COLOR_ATTACHMENT29 = 36093,
	GL_COLOR_ATTACHMENT30 = 36094,
	GL_COLOR_ATTACHMENT31 = 36095,
	GL_DEPTH_ATTACHMENT = 36096,
	GL_STENCIL_ATTACHMENT = 36128,
	GL_FRAMEBUFFER = 36160,
	GL_RENDERBUFFER = 36161,
	GL_RENDERBUFFER_WIDTH = 36162,
	GL_RENDERBUFFER_HEIGHT = 36163,
	GL_RENDERBUFFER_INTERNAL_FORMAT = 36164,
	GL_STENCIL_INDEX1 = 36166,
	GL_STENCIL_INDEX4 = 36167,
	GL_STENCIL_INDEX8 = 36168,
	GL_STENCIL_INDEX16 = 36169,
	GL_RENDERBUFFER_RED_SIZE = 36176,
	GL_RENDERBUFFER_GREEN_SIZE = 36177,
	GL_RENDERBUFFER_BLUE_SIZE = 36178,
	GL_RENDERBUFFER_ALPHA_SIZE = 36179,
	GL_RENDERBUFFER_DEPTH_SIZE = 36180,
	GL_RENDERBUFFER_STENCIL_SIZE = 36181,
	GL_FRAMEBUFFER_INCOMPLETE_MULTISAMPLE = 36182,
	GL_MAX_SAMPLES = 36183,
	GL_INDEX = 33314,
	GL_TEXTURE_LUMINANCE_TYPE = 35860,
	GL_TEXTURE_INTENSITY_TYPE = 35861,
	GL_FRAMEBUFFER_SRGB = 36281,
	GL_HALF_FLOAT = 5131,
	GL_MAP_READ_BIT = 1,
	GL_MAP_WRITE_BIT = 2,
	GL_MAP_INVALIDATE_RANGE_BIT = 4,
	GL_MAP_INVALIDATE_BUFFER_BIT = 8,
	GL_MAP_FLUSH_EXPLICIT_BIT = 16,
	GL_MAP_UNSYNCHRONIZED_BIT = 32,
	GL_COMPRESSED_RED_RGTC1 = 36283,
	GL_COMPRESSED_SIGNED_RED_RGTC1 = 36284,
	GL_COMPRESSED_RG_RGTC2 = 36285,
	GL_COMPRESSED_SIGNED_RG_RGTC2 = 36286,
	GL_RG = 33319,
	GL_RG_INTEGER = 33320,
	GL_R8 = 33321,
	GL_R16 = 33322,
	GL_RG8 = 33323,
	GL_RG16 = 33324,
	GL_R16F = 33325,
	GL_R32F = 33326,
	GL_RG16F = 33327,
	GL_RG32F = 33328,
	GL_R8I = 33329,
	GL_R8UI = 33330,
	GL_R16I = 33331,
	GL_R16UI = 33332,
	GL_R32I = 33333,
	GL_R32UI = 33334,
	GL_RG8I = 33335,
	GL_RG8UI = 33336,
	GL_RG16I = 33337,
	GL_RG16UI = 33338,
	GL_RG32I = 33339,
	GL_RG32UI = 33340,
	GL_VERTEX_ARRAY_BINDING = 34229,
	GL_CLAMP_VERTEX_COLOR = 35098,
	GL_CLAMP_FRAGMENT_COLOR = 35099,
	GL_ALPHA_INTEGER = 36247,
	GL_VERSION_3_1 = 1,
	GL_SAMPLER_2D_RECT = 35683,
	GL_SAMPLER_2D_RECT_SHADOW = 35684,
	GL_SAMPLER_BUFFER = 36290,
	GL_INT_SAMPLER_2D_RECT = 36301,
	GL_INT_SAMPLER_BUFFER = 36304,
	GL_UNSIGNED_INT_SAMPLER_2D_RECT = 36309,
	GL_UNSIGNED_INT_SAMPLER_BUFFER = 36312,
	GL_TEXTURE_BUFFER = 35882,
	GL_MAX_TEXTURE_BUFFER_SIZE = 35883,
	GL_TEXTURE_BINDING_BUFFER = 35884,
	GL_TEXTURE_BUFFER_DATA_STORE_BINDING = 35885,
	GL_TEXTURE_RECTANGLE = 34037,
	GL_TEXTURE_BINDING_RECTANGLE = 34038,
	GL_PROXY_TEXTURE_RECTANGLE = 34039,
	GL_MAX_RECTANGLE_TEXTURE_SIZE = 34040,
	GL_R8_SNORM = 36756,
	GL_RG8_SNORM = 36757,
	GL_RGB8_SNORM = 36758,
	GL_RGBA8_SNORM = 36759,
	GL_R16_SNORM = 36760,
	GL_RG16_SNORM = 36761,
	GL_RGB16_SNORM = 36762,
	GL_RGBA16_SNORM = 36763,
	GL_SIGNED_NORMALIZED = 36764,
	GL_PRIMITIVE_RESTART = 36765,
	GL_PRIMITIVE_RESTART_INDEX = 36766,
	GL_COPY_READ_BUFFER = 36662,
	GL_COPY_WRITE_BUFFER = 36663,
	GL_UNIFORM_BUFFER = 35345,
	GL_UNIFORM_BUFFER_BINDING = 35368,
	GL_UNIFORM_BUFFER_START = 35369,
	GL_UNIFORM_BUFFER_SIZE = 35370,
	GL_MAX_VERTEX_UNIFORM_BLOCKS = 35371,
	GL_MAX_GEOMETRY_UNIFORM_BLOCKS = 35372,
	GL_MAX_FRAGMENT_UNIFORM_BLOCKS = 35373,
	GL_MAX_COMBINED_UNIFORM_BLOCKS = 35374,
	GL_MAX_UNIFORM_BUFFER_BINDINGS = 35375,
	GL_MAX_UNIFORM_BLOCK_SIZE = 35376,
	GL_MAX_COMBINED_VERTEX_UNIFORM_COMPONENTS = 35377,
	GL_MAX_COMBINED_GEOMETRY_UNIFORM_COMPONENTS = 35378,
	GL_MAX_COMBINED_FRAGMENT_UNIFORM_COMPONENTS = 35379,
	GL_UNIFORM_BUFFER_OFFSET_ALIGNMENT = 35380,
	GL_ACTIVE_UNIFORM_BLOCK_MAX_NAME_LENGTH = 35381,
	GL_ACTIVE_UNIFORM_BLOCKS = 35382,
	GL_UNIFORM_TYPE = 35383,
	GL_UNIFORM_SIZE = 35384,
	GL_UNIFORM_NAME_LENGTH = 35385,
	GL_UNIFORM_BLOCK_INDEX = 35386,
	GL_UNIFORM_OFFSET = 35387,
	GL_UNIFORM_ARRAY_STRIDE = 35388,
	GL_UNIFORM_MATRIX_STRIDE = 35389,
	GL_UNIFORM_IS_ROW_MAJOR = 35390,
	GL_UNIFORM_BLOCK_BINDING = 35391,
	GL_UNIFORM_BLOCK_DATA_SIZE = 35392,
	GL_UNIFORM_BLOCK_NAME_LENGTH = 35393,
	GL_UNIFORM_BLOCK_ACTIVE_UNIFORMS = 35394,
	GL_UNIFORM_BLOCK_ACTIVE_UNIFORM_INDICES = 35395,
	GL_UNIFORM_BLOCK_REFERENCED_BY_VERTEX_SHADER = 35396,
	GL_UNIFORM_BLOCK_REFERENCED_BY_GEOMETRY_SHADER = 35397,
	GL_UNIFORM_BLOCK_REFERENCED_BY_FRAGMENT_SHADER = 35398,
	GL_INVALID_INDEX = 0xFFFFFFFF,
	GL_VERSION_3_2 = 1,
	GL_CONTEXT_CORE_PROFILE_BIT = 1,
	GL_CONTEXT_COMPATIBILITY_PROFILE_BIT = 2,
	GL_LINES_ADJACENCY = 10,
	GL_LINE_STRIP_ADJACENCY = 11,
	GL_TRIANGLES_ADJACENCY = 12,
	GL_TRIANGLE_STRIP_ADJACENCY = 13,
	GL_PROGRAM_POINT_SIZE = 34370,
	GL_MAX_GEOMETRY_TEXTURE_IMAGE_UNITS = 35881,
	GL_FRAMEBUFFER_ATTACHMENT_LAYERED = 36263,
	GL_FRAMEBUFFER_INCOMPLETE_LAYER_TARGETS = 36264,
	GL_GEOMETRY_SHADER = 36313,
	GL_GEOMETRY_VERTICES_OUT = 35094,
	GL_GEOMETRY_INPUT_TYPE = 35095,
	GL_GEOMETRY_OUTPUT_TYPE = 35096,
	GL_MAX_GEOMETRY_UNIFORM_COMPONENTS = 36319,
	GL_MAX_GEOMETRY_OUTPUT_VERTICES = 36320,
	GL_MAX_GEOMETRY_TOTAL_OUTPUT_COMPONENTS = 36321,
	GL_MAX_VERTEX_OUTPUT_COMPONENTS = 37154,
	GL_MAX_GEOMETRY_INPUT_COMPONENTS = 37155,
	GL_MAX_GEOMETRY_OUTPUT_COMPONENTS = 37156,
	GL_MAX_FRAGMENT_INPUT_COMPONENTS = 37157,
	GL_CONTEXT_PROFILE_MASK = 37158,
	GL_DEPTH_CLAMP = 34383,
	GL_QUADS_FOLLOW_PROVOKING_VERTEX_CONVENTION = 36428,
	GL_FIRST_VERTEX_CONVENTION = 36429,
	GL_LAST_VERTEX_CONVENTION = 36430,
	GL_PROVOKING_VERTEX = 36431,
	GL_TEXTURE_CUBE_MAP_SEAMLESS = 34895,
	GL_MAX_SERVER_WAIT_TIMEOUT = 37137,
	GL_OBJECT_TYPE = 37138,
	GL_SYNC_CONDITION = 37139,
	GL_SYNC_STATUS = 37140,
	GL_SYNC_FLAGS = 37141,
	GL_SYNC_FENCE = 37142,
	GL_SYNC_GPU_COMMANDS_COMPLETE = 37143,
	GL_UNSIGNALED = 37144,
	GL_SIGNALED = 37145,
	GL_ALREADY_SIGNALED = 37146,
	GL_TIMEOUT_EXPIRED = 37147,
	GL_CONDITION_SATISFIED = 37148,
	GL_WAIT_FAILED = 37149,
	GL_SYNC_FLUSH_COMMANDS_BIT = 1,
	GL_SAMPLE_POSITION = 36432,
	GL_SAMPLE_MASK = 36433,
	GL_SAMPLE_MASK_VALUE = 36434,
	GL_MAX_SAMPLE_MASK_WORDS = 36441,
	GL_TEXTURE_2D_MULTISAMPLE = 37120,
	GL_PROXY_TEXTURE_2D_MULTISAMPLE = 37121,
	GL_TEXTURE_2D_MULTISAMPLE_ARRAY = 37122,
	GL_PROXY_TEXTURE_2D_MULTISAMPLE_ARRAY = 37123,
	GL_TEXTURE_BINDING_2D_MULTISAMPLE = 37124,
	GL_TEXTURE_BINDING_2D_MULTISAMPLE_ARRAY = 37125,
	GL_TEXTURE_SAMPLES = 37126,
	GL_TEXTURE_FIXED_SAMPLE_LOCATIONS = 37127,
	GL_SAMPLER_2D_MULTISAMPLE = 37128,
	GL_INT_SAMPLER_2D_MULTISAMPLE = 37129,
	GL_UNSIGNED_INT_SAMPLER_2D_MULTISAMPLE = 37130,
	GL_SAMPLER_2D_MULTISAMPLE_ARRAY = 37131,
	GL_INT_SAMPLER_2D_MULTISAMPLE_ARRAY = 37132,
	GL_UNSIGNED_INT_SAMPLER_2D_MULTISAMPLE_ARRAY = 37133,
	GL_MAX_COLOR_TEXTURE_SAMPLES = 37134,
	GL_MAX_DEPTH_TEXTURE_SAMPLES = 37135,
	GL_MAX_INTEGER_SAMPLES = 37136,
	GL_VERSION_3_3 = 1,
	GL_VERTEX_ATTRIB_ARRAY_DIVISOR = 35070,
	GL_SRC1_COLOR = 35065,
	GL_ONE_MINUS_SRC1_COLOR = 35066,
	GL_ONE_MINUS_SRC1_ALPHA = 35067,
	GL_MAX_DUAL_SOURCE_DRAW_BUFFERS = 35068,
	GL_ANY_SAMPLES_PASSED = 35887,
	GL_SAMPLER_BINDING = 35097,
	GL_RGB10_A2UI = 36975,
	GL_TEXTURE_SWIZZLE_R = 36418,
	GL_TEXTURE_SWIZZLE_G = 36419,
	GL_TEXTURE_SWIZZLE_B = 36420,
	GL_TEXTURE_SWIZZLE_A = 36421,
	GL_TEXTURE_SWIZZLE_RGBA = 36422,
	GL_TIME_ELAPSED = 35007,
	GL_TIMESTAMP = 36392,
	GL_INT_2_10_10_10_REV = 36255,
	GL_VERSION_4_0 = 1,
	GL_SAMPLE_SHADING = 35894,
	GL_MIN_SAMPLE_SHADING_VALUE = 35895,
	GL_MIN_PROGRAM_TEXTURE_GATHER_OFFSET = 36446,
	GL_MAX_PROGRAM_TEXTURE_GATHER_OFFSET = 36447,
	GL_TEXTURE_CUBE_MAP_ARRAY = 36873,
	GL_TEXTURE_BINDING_CUBE_MAP_ARRAY = 36874,
	GL_PROXY_TEXTURE_CUBE_MAP_ARRAY = 36875,
	GL_SAMPLER_CUBE_MAP_ARRAY = 36876,
	GL_SAMPLER_CUBE_MAP_ARRAY_SHADOW = 36877,
	GL_INT_SAMPLER_CUBE_MAP_ARRAY = 36878,
	GL_UNSIGNED_INT_SAMPLER_CUBE_MAP_ARRAY = 36879,
	GL_DRAW_INDIRECT_BUFFER = 36671,
	GL_DRAW_INDIRECT_BUFFER_BINDING = 36675,
	GL_GEOMETRY_SHADER_INVOCATIONS = 34943,
	GL_MAX_GEOMETRY_SHADER_INVOCATIONS = 36442,
	GL_MIN_FRAGMENT_INTERPOLATION_OFFSET = 36443,
	GL_MAX_FRAGMENT_INTERPOLATION_OFFSET = 36444,
	GL_FRAGMENT_INTERPOLATION_OFFSET_BITS = 36445,
	GL_MAX_VERTEX_STREAMS = 36465,
	GL_DOUBLE_VEC2 = 36860,
	GL_DOUBLE_VEC3 = 36861,
	GL_DOUBLE_VEC4 = 36862,
	GL_DOUBLE_MAT2 = 36678,
	GL_DOUBLE_MAT3 = 36679,
	GL_DOUBLE_MAT4 = 36680,
	GL_DOUBLE_MAT2x3 = 36681,
	GL_DOUBLE_MAT2x4 = 36682,
	GL_DOUBLE_MAT3x2 = 36683,
	GL_DOUBLE_MAT3x4 = 36684,
	GL_DOUBLE_MAT4x2 = 36685,
	GL_DOUBLE_MAT4x3 = 36686,
	GL_ACTIVE_SUBROUTINES = 36325,
	GL_ACTIVE_SUBROUTINE_UNIFORMS = 36326,
	GL_ACTIVE_SUBROUTINE_UNIFORM_LOCATIONS = 36423,
	GL_ACTIVE_SUBROUTINE_MAX_LENGTH = 36424,
	GL_ACTIVE_SUBROUTINE_UNIFORM_MAX_LENGTH = 36425,
	GL_MAX_SUBROUTINES = 36327,
	GL_MAX_SUBROUTINE_UNIFORM_LOCATIONS = 36328,
	GL_NUM_COMPATIBLE_SUBROUTINES = 36426,
	GL_COMPATIBLE_SUBROUTINES = 36427,
	GL_PATCHES = 14,
	GL_PATCH_VERTICES = 36466,
	GL_PATCH_DEFAULT_INNER_LEVEL = 36467,
	GL_PATCH_DEFAULT_OUTER_LEVEL = 36468,
	GL_TESS_CONTROL_OUTPUT_VERTICES = 36469,
	GL_TESS_GEN_MODE = 36470,
	GL_TESS_GEN_SPACING = 36471,
	GL_TESS_GEN_VERTEX_ORDER = 36472,
	GL_TESS_GEN_POINT_MODE = 36473,
	GL_ISOLINES = 36474,
	GL_FRACTIONAL_ODD = 36475,
	GL_FRACTIONAL_EVEN = 36476,
	GL_MAX_PATCH_VERTICES = 36477,
	GL_MAX_TESS_GEN_LEVEL = 36478,
	GL_MAX_TESS_CONTROL_UNIFORM_COMPONENTS = 36479,
	GL_MAX_TESS_EVALUATION_UNIFORM_COMPONENTS = 36480,
	GL_MAX_TESS_CONTROL_TEXTURE_IMAGE_UNITS = 36481,
	GL_MAX_TESS_EVALUATION_TEXTURE_IMAGE_UNITS = 36482,
	GL_MAX_TESS_CONTROL_OUTPUT_COMPONENTS = 36483,
	GL_MAX_TESS_PATCH_COMPONENTS = 36484,
	GL_MAX_TESS_CONTROL_TOTAL_OUTPUT_COMPONENTS = 36485,
	GL_MAX_TESS_EVALUATION_OUTPUT_COMPONENTS = 36486,
	GL_MAX_TESS_CONTROL_UNIFORM_BLOCKS = 36489,
	GL_MAX_TESS_EVALUATION_UNIFORM_BLOCKS = 36490,
	GL_MAX_TESS_CONTROL_INPUT_COMPONENTS = 34924,
	GL_MAX_TESS_EVALUATION_INPUT_COMPONENTS = 34925,
	GL_MAX_COMBINED_TESS_CONTROL_UNIFORM_COMPONENTS = 36382,
	GL_MAX_COMBINED_TESS_EVALUATION_UNIFORM_COMPONENTS = 36383,
	GL_UNIFORM_BLOCK_REFERENCED_BY_TESS_CONTROL_SHADER = 34032,
	GL_UNIFORM_BLOCK_REFERENCED_BY_TESS_EVALUATION_SHADER = 34033,
	GL_TESS_EVALUATION_SHADER = 36487,
	GL_TESS_CONTROL_SHADER = 36488,
	GL_TRANSFORM_FEEDBACK = 36386,
	GL_TRANSFORM_FEEDBACK_BUFFER_PAUSED = 36387,
	GL_TRANSFORM_FEEDBACK_BUFFER_ACTIVE = 36388,
	GL_TRANSFORM_FEEDBACK_BINDING = 36389,
	GL_MAX_TRANSFORM_FEEDBACK_BUFFERS = 36464,
	GL_VERSION_4_1 = 1,
	GL_FIXED = 5132,
	GL_IMPLEMENTATION_COLOR_READ_TYPE = 35738,
	GL_IMPLEMENTATION_COLOR_READ_FORMAT = 35739,
	GL_LOW_FLOAT = 36336,
	GL_MEDIUM_FLOAT = 36337,
	GL_HIGH_FLOAT = 36338,
	GL_LOW_INT = 36339,
	GL_MEDIUM_INT = 36340,
	GL_HIGH_INT = 36341,
	GL_SHADER_COMPILER = 36346,
	GL_SHADER_BINARY_FORMATS = 36344,
	GL_NUM_SHADER_BINARY_FORMATS = 36345,
	GL_MAX_VERTEX_UNIFORM_VECTORS = 36347,
	GL_MAX_VARYING_VECTORS = 36348,
	GL_MAX_FRAGMENT_UNIFORM_VECTORS = 36349,
	GL_RGB565 = 36194,
	GL_PROGRAM_BINARY_RETRIEVABLE_HINT = 33367,
	GL_PROGRAM_BINARY_LENGTH = 34625,
	GL_NUM_PROGRAM_BINARY_FORMATS = 34814,
	GL_PROGRAM_BINARY_FORMATS = 34815,
	GL_VERTEX_SHADER_BIT = 1,
	GL_FRAGMENT_SHADER_BIT = 2,
	GL_GEOMETRY_SHADER_BIT = 4,
	GL_TESS_CONTROL_SHADER_BIT = 8,
	GL_TESS_EVALUATION_SHADER_BIT = 16,
	GL_ALL_SHADER_BITS = 4294967295,
	GL_PROGRAM_SEPARABLE = 33368,
	GL_ACTIVE_PROGRAM = 33369,
	GL_PROGRAM_PIPELINE_BINDING = 33370,
	GL_MAX_VIEWPORTS = 33371,
	GL_VIEWPORT_SUBPIXEL_BITS = 33372,
	GL_VIEWPORT_BOUNDS_RANGE = 33373,
	GL_LAYER_PROVOKING_VERTEX = 33374,
	GL_VIEWPORT_INDEX_PROVOKING_VERTEX = 33375,
	GL_UNDEFINED_VERTEX = 33376,
	GL_VERSION_4_2 = 1,
	GL_COPY_READ_BUFFER_BINDING = 36662,
	GL_COPY_WRITE_BUFFER_BINDING = 36663,
	GL_TRANSFORM_FEEDBACK_ACTIVE = 36388,
	GL_TRANSFORM_FEEDBACK_PAUSED = 36387,
	GL_UNPACK_COMPRESSED_BLOCK_WIDTH = 37159,
	GL_UNPACK_COMPRESSED_BLOCK_HEIGHT = 37160,
	GL_UNPACK_COMPRESSED_BLOCK_DEPTH = 37161,
	GL_UNPACK_COMPRESSED_BLOCK_SIZE = 37162,
	GL_PACK_COMPRESSED_BLOCK_WIDTH = 37163,
	GL_PACK_COMPRESSED_BLOCK_HEIGHT = 37164,
	GL_PACK_COMPRESSED_BLOCK_DEPTH = 37165,
	GL_PACK_COMPRESSED_BLOCK_SIZE = 37166,
	GL_NUM_SAMPLE_COUNTS = 37760,
	GL_MIN_MAP_BUFFER_ALIGNMENT = 37052,
	GL_ATOMIC_COUNTER_BUFFER = 37568,
	GL_ATOMIC_COUNTER_BUFFER_BINDING = 37569,
	GL_ATOMIC_COUNTER_BUFFER_START = 37570,
	GL_ATOMIC_COUNTER_BUFFER_SIZE = 37571,
	GL_ATOMIC_COUNTER_BUFFER_DATA_SIZE = 37572,
	GL_ATOMIC_COUNTER_BUFFER_ACTIVE_ATOMIC_COUNTERS = 37573,
	GL_ATOMIC_COUNTER_BUFFER_ACTIVE_ATOMIC_COUNTER_INDICES = 37574,
	GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_VERTEX_SHADER = 37575,
	GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_TESS_CONTROL_SHADER = 37576,
	GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_TESS_EVALUATION_SHADER = 37577,
	GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_GEOMETRY_SHADER = 37578,
	GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_FRAGMENT_SHADER = 37579,
	GL_MAX_VERTEX_ATOMIC_COUNTER_BUFFERS = 37580,
	GL_MAX_TESS_CONTROL_ATOMIC_COUNTER_BUFFERS = 37581,
	GL_MAX_TESS_EVALUATION_ATOMIC_COUNTER_BUFFERS = 37582,
	GL_MAX_GEOMETRY_ATOMIC_COUNTER_BUFFERS = 37583,
	GL_MAX_FRAGMENT_ATOMIC_COUNTER_BUFFERS = 37584,
	GL_MAX_COMBINED_ATOMIC_COUNTER_BUFFERS = 37585,
	GL_MAX_VERTEX_ATOMIC_COUNTERS = 37586,
	GL_MAX_TESS_CONTROL_ATOMIC_COUNTERS = 37587,
	GL_MAX_TESS_EVALUATION_ATOMIC_COUNTERS = 37588,
	GL_MAX_GEOMETRY_ATOMIC_COUNTERS = 37589,
	GL_MAX_FRAGMENT_ATOMIC_COUNTERS = 37590,
	GL_MAX_COMBINED_ATOMIC_COUNTERS = 37591,
	GL_MAX_ATOMIC_COUNTER_BUFFER_SIZE = 37592,
	GL_MAX_ATOMIC_COUNTER_BUFFER_BINDINGS = 37596,
	GL_ACTIVE_ATOMIC_COUNTER_BUFFERS = 37593,
	GL_UNIFORM_ATOMIC_COUNTER_BUFFER_INDEX = 37594,
	GL_UNSIGNED_INT_ATOMIC_COUNTER = 37595,
	GL_VERTEX_ATTRIB_ARRAY_BARRIER_BIT = 1,
	GL_ELEMENT_ARRAY_BARRIER_BIT = 2,
	GL_UNIFORM_BARRIER_BIT = 4,
	GL_TEXTURE_FETCH_BARRIER_BIT = 8,
	GL_SHADER_IMAGE_ACCESS_BARRIER_BIT = 32,
	GL_COMMAND_BARRIER_BIT = 64,
	GL_PIXEL_BUFFER_BARRIER_BIT = 128,
	GL_TEXTURE_UPDATE_BARRIER_BIT = 256,
	GL_BUFFER_UPDATE_BARRIER_BIT = 512,
	GL_FRAMEBUFFER_BARRIER_BIT = 1024,
	GL_TRANSFORM_FEEDBACK_BARRIER_BIT = 2048,
	GL_ATOMIC_COUNTER_BARRIER_BIT = 4096,
	GL_ALL_BARRIER_BITS = 4294967295,
	GL_MAX_IMAGE_UNITS = 36664,
	GL_MAX_COMBINED_IMAGE_UNITS_AND_FRAGMENT_OUTPUTS = 36665,
	GL_IMAGE_BINDING_NAME = 36666,
	GL_IMAGE_BINDING_LEVEL = 36667,
	GL_IMAGE_BINDING_LAYERED = 36668,
	GL_IMAGE_BINDING_LAYER = 36669,
	GL_IMAGE_BINDING_ACCESS = 36670,
	GL_IMAGE_1D = 36940,
	GL_IMAGE_2D = 36941,
	GL_IMAGE_3D = 36942,
	GL_IMAGE_2D_RECT = 36943,
	GL_IMAGE_CUBE = 36944,
	GL_IMAGE_BUFFER = 36945,
	GL_IMAGE_1D_ARRAY = 36946,
	GL_IMAGE_2D_ARRAY = 36947,
	GL_IMAGE_CUBE_MAP_ARRAY = 36948,
	GL_IMAGE_2D_MULTISAMPLE = 36949,
	GL_IMAGE_2D_MULTISAMPLE_ARRAY = 36950,
	GL_INT_IMAGE_1D = 36951,
	GL_INT_IMAGE_2D = 36952,
	GL_INT_IMAGE_3D = 36953,
	GL_INT_IMAGE_2D_RECT = 36954,
	GL_INT_IMAGE_CUBE = 36955,
	GL_INT_IMAGE_BUFFER = 36956,
	GL_INT_IMAGE_1D_ARRAY = 36957,
	GL_INT_IMAGE_2D_ARRAY = 36958,
	GL_INT_IMAGE_CUBE_MAP_ARRAY = 36959,
	GL_INT_IMAGE_2D_MULTISAMPLE = 36960,
	GL_INT_IMAGE_2D_MULTISAMPLE_ARRAY = 36961,
	GL_UNSIGNED_INT_IMAGE_1D = 36962,
	GL_UNSIGNED_INT_IMAGE_2D = 36963,
	GL_UNSIGNED_INT_IMAGE_3D = 36964,
	GL_UNSIGNED_INT_IMAGE_2D_RECT = 36965,
	GL_UNSIGNED_INT_IMAGE_CUBE = 36966,
	GL_UNSIGNED_INT_IMAGE_BUFFER = 36967,
	GL_UNSIGNED_INT_IMAGE_1D_ARRAY = 36968,
	GL_UNSIGNED_INT_IMAGE_2D_ARRAY = 36969,
	GL_UNSIGNED_INT_IMAGE_CUBE_MAP_ARRAY = 36970,
	GL_UNSIGNED_INT_IMAGE_2D_MULTISAMPLE = 36971,
	GL_UNSIGNED_INT_IMAGE_2D_MULTISAMPLE_ARRAY = 36972,
	GL_MAX_IMAGE_SAMPLES = 36973,
	GL_IMAGE_BINDING_FORMAT = 36974,
	GL_IMAGE_FORMAT_COMPATIBILITY_TYPE = 37063,
	GL_IMAGE_FORMAT_COMPATIBILITY_BY_SIZE = 37064,
	GL_IMAGE_FORMAT_COMPATIBILITY_BY_CLASS = 37065,
	GL_MAX_VERTEX_IMAGE_UNIFORMS = 37066,
	GL_MAX_TESS_CONTROL_IMAGE_UNIFORMS = 37067,
	GL_MAX_TESS_EVALUATION_IMAGE_UNIFORMS = 37068,
	GL_MAX_GEOMETRY_IMAGE_UNIFORMS = 37069,
	GL_MAX_FRAGMENT_IMAGE_UNIFORMS = 37070,
	GL_MAX_COMBINED_IMAGE_UNIFORMS = 37071,
	GL_COMPRESSED_RGBA_BPTC_UNORM = 36492,
	GL_COMPRESSED_SRGB_ALPHA_BPTC_UNORM = 36493,
	GL_COMPRESSED_RGB_BPTC_SIGNED_FLOAT = 36494,
	GL_COMPRESSED_RGB_BPTC_UNSIGNED_FLOAT = 36495,
	GL_TEXTURE_IMMUTABLE_FORMAT = 37167,
	GL_VERSION_4_3 = 1,
	GL_NUM_SHADING_LANGUAGE_VERSIONS = 33513,
	GL_VERTEX_ATTRIB_ARRAY_LONG = 34638,
	GL_COMPRESSED_RGB8_ETC2 = 37492,
	GL_COMPRESSED_SRGB8_ETC2 = 37493,
	GL_COMPRESSED_RGB8_PUNCHTHROUGH_ALPHA1_ETC2 = 37494,
	GL_COMPRESSED_SRGB8_PUNCHTHROUGH_ALPHA1_ETC2 = 37495,
	GL_COMPRESSED_RGBA8_ETC2_EAC = 37496,
	GL_COMPRESSED_SRGB8_ALPHA8_ETC2_EAC = 37497,
	GL_COMPRESSED_R11_EAC = 37488,
	GL_COMPRESSED_SIGNED_R11_EAC = 37489,
	GL_COMPRESSED_RG11_EAC = 37490,
	GL_COMPRESSED_SIGNED_RG11_EAC = 37491,
	GL_PRIMITIVE_RESTART_FIXED_INDEX = 36201,
	GL_ANY_SAMPLES_PASSED_CONSERVATIVE = 36202,
	GL_MAX_ELEMENT_INDEX = 36203,
	GL_COMPUTE_SHADER = 37305,
	GL_MAX_COMPUTE_UNIFORM_BLOCKS = 37307,
	GL_MAX_COMPUTE_TEXTURE_IMAGE_UNITS = 37308,
	GL_MAX_COMPUTE_IMAGE_UNIFORMS = 37309,
	GL_MAX_COMPUTE_SHARED_MEMORY_SIZE = 33378,
	GL_MAX_COMPUTE_UNIFORM_COMPONENTS = 33379,
	GL_MAX_COMPUTE_ATOMIC_COUNTER_BUFFERS = 33380,
	GL_MAX_COMPUTE_ATOMIC_COUNTERS = 33381,
	GL_MAX_COMBINED_COMPUTE_UNIFORM_COMPONENTS = 33382,
	GL_MAX_COMPUTE_WORK_GROUP_INVOCATIONS = 37099,
	GL_MAX_COMPUTE_WORK_GROUP_COUNT = 37310,
	GL_MAX_COMPUTE_WORK_GROUP_SIZE = 37311,
	GL_COMPUTE_WORK_GROUP_SIZE = 33383,
	GL_UNIFORM_BLOCK_REFERENCED_BY_COMPUTE_SHADER = 37100,
	GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_COMPUTE_SHADER = 37101,
	GL_DISPATCH_INDIRECT_BUFFER = 37102,
	GL_DISPATCH_INDIRECT_BUFFER_BINDING = 37103,
	GL_COMPUTE_SHADER_BIT = 32,
	GL_DEBUG_OUTPUT_SYNCHRONOUS = 33346,
	GL_DEBUG_NEXT_LOGGED_MESSAGE_LENGTH = 33347,
	GL_DEBUG_CALLBACK_FUNCTION = 33348,
	GL_DEBUG_CALLBACK_USER_PARAM = 33349,
	GL_DEBUG_SOURCE_API = 33350,
	GL_DEBUG_SOURCE_WINDOW_SYSTEM = 33351,
	GL_DEBUG_SOURCE_SHADER_COMPILER = 33352,
	GL_DEBUG_SOURCE_THIRD_PARTY = 33353,
	GL_DEBUG_SOURCE_APPLICATION = 33354,
	GL_DEBUG_SOURCE_OTHER = 33355,
	GL_DEBUG_TYPE_ERROR = 33356,
	GL_DEBUG_TYPE_DEPRECATED_BEHAVIOR = 33357,
	GL_DEBUG_TYPE_UNDEFINED_BEHAVIOR = 33358,
	GL_DEBUG_TYPE_PORTABILITY = 33359,
	GL_DEBUG_TYPE_PERFORMANCE = 33360,
	GL_DEBUG_TYPE_OTHER = 33361,
	GL_MAX_DEBUG_MESSAGE_LENGTH = 37187,
	GL_MAX_DEBUG_LOGGED_MESSAGES = 37188,
	GL_DEBUG_LOGGED_MESSAGES = 37189,
	GL_DEBUG_SEVERITY_HIGH = 37190,
	GL_DEBUG_SEVERITY_MEDIUM = 37191,
	GL_DEBUG_SEVERITY_LOW = 37192,
	GL_DEBUG_TYPE_MARKER = 33384,
	GL_DEBUG_TYPE_PUSH_GROUP = 33385,
	GL_DEBUG_TYPE_POP_GROUP = 33386,
	GL_DEBUG_SEVERITY_NOTIFICATION = 33387,
	GL_MAX_DEBUG_GROUP_STACK_DEPTH = 33388,
	GL_DEBUG_GROUP_STACK_DEPTH = 33389,
	GL_BUFFER = 33504,
	GL_SHADER = 33505,
	GL_PROGRAM = 33506,
	GL_QUERY = 33507,
	GL_PROGRAM_PIPELINE = 33508,
	GL_SAMPLER = 33510,
	GL_MAX_LABEL_LENGTH = 33512,
	GL_DEBUG_OUTPUT = 37600,
	GL_CONTEXT_FLAG_DEBUG_BIT = 2,
	GL_MAX_UNIFORM_LOCATIONS = 33390,
	GL_FRAMEBUFFER_DEFAULT_WIDTH = 37648,
	GL_FRAMEBUFFER_DEFAULT_HEIGHT = 37649,
	GL_FRAMEBUFFER_DEFAULT_LAYERS = 37650,
	GL_FRAMEBUFFER_DEFAULT_SAMPLES = 37651,
	GL_FRAMEBUFFER_DEFAULT_FIXED_SAMPLE_LOCATIONS = 37652,
	GL_MAX_FRAMEBUFFER_WIDTH = 37653,
	GL_MAX_FRAMEBUFFER_HEIGHT = 37654,
	GL_MAX_FRAMEBUFFER_LAYERS = 37655,
	GL_MAX_FRAMEBUFFER_SAMPLES = 37656,
	GL_INTERNALFORMAT_SUPPORTED = 33391,
	GL_INTERNALFORMAT_PREFERRED = 33392,
	GL_INTERNALFORMAT_RED_SIZE = 33393,
	GL_INTERNALFORMAT_GREEN_SIZE = 33394,
	GL_INTERNALFORMAT_BLUE_SIZE = 33395,
	GL_INTERNALFORMAT_ALPHA_SIZE = 33396,
	GL_INTERNALFORMAT_DEPTH_SIZE = 33397,
	GL_INTERNALFORMAT_STENCIL_SIZE = 33398,
	GL_INTERNALFORMAT_SHARED_SIZE = 33399,
	GL_INTERNALFORMAT_RED_TYPE = 33400,
	GL_INTERNALFORMAT_GREEN_TYPE = 33401,
	GL_INTERNALFORMAT_BLUE_TYPE = 33402,
	GL_INTERNALFORMAT_ALPHA_TYPE = 33403,
	GL_INTERNALFORMAT_DEPTH_TYPE = 33404,
	GL_INTERNALFORMAT_STENCIL_TYPE = 33405,
	GL_MAX_WIDTH = 33406,
	GL_MAX_HEIGHT = 33407,
	GL_MAX_DEPTH = 33408,
	GL_MAX_LAYERS = 33409,
	GL_MAX_COMBINED_DIMENSIONS = 33410,
	GL_COLOR_COMPONENTS = 33411,
	GL_DEPTH_COMPONENTS = 33412,
	GL_STENCIL_COMPONENTS = 33413,
	GL_COLOR_RENDERABLE = 33414,
	GL_DEPTH_RENDERABLE = 33415,
	GL_STENCIL_RENDERABLE = 33416,
	GL_FRAMEBUFFER_RENDERABLE = 33417,
	GL_FRAMEBUFFER_RENDERABLE_LAYERED = 33418,
	GL_FRAMEBUFFER_BLEND = 33419,
	GL_READ_PIXELS = 33420,
	GL_READ_PIXELS_FORMAT = 33421,
	GL_READ_PIXELS_TYPE = 33422,
	GL_TEXTURE_IMAGE_FORMAT = 33423,
	GL_TEXTURE_IMAGE_TYPE = 33424,
	GL_GET_TEXTURE_IMAGE_FORMAT = 33425,
	GL_GET_TEXTURE_IMAGE_TYPE = 33426,
	GL_MIPMAP = 33427,
	GL_MANUAL_GENERATE_MIPMAP = 33428,
	GL_AUTO_GENERATE_MIPMAP = 33429,
	GL_COLOR_ENCODING = 33430,
	GL_SRGB_READ = 33431,
	GL_SRGB_WRITE = 33432,
	GL_FILTER = 33434,
	GL_VERTEX_TEXTURE = 33435,
	GL_TESS_CONTROL_TEXTURE = 33436,
	GL_TESS_EVALUATION_TEXTURE = 33437,
	GL_GEOMETRY_TEXTURE = 33438,
	GL_FRAGMENT_TEXTURE = 33439,
	GL_COMPUTE_TEXTURE = 33440,
	GL_TEXTURE_SHADOW = 33441,
	GL_TEXTURE_GATHER = 33442,
	GL_TEXTURE_GATHER_SHADOW = 33443,
	GL_SHADER_IMAGE_LOAD = 33444,
	GL_SHADER_IMAGE_STORE = 33445,
	GL_SHADER_IMAGE_ATOMIC = 33446,
	GL_IMAGE_TEXEL_SIZE = 33447,
	GL_IMAGE_COMPATIBILITY_CLASS = 33448,
	GL_IMAGE_PIXEL_FORMAT = 33449,
	GL_IMAGE_PIXEL_TYPE = 33450,
	GL_SIMULTANEOUS_TEXTURE_AND_DEPTH_TEST = 33452,
	GL_SIMULTANEOUS_TEXTURE_AND_STENCIL_TEST = 33453,
	GL_SIMULTANEOUS_TEXTURE_AND_DEPTH_WRITE = 33454,
	GL_SIMULTANEOUS_TEXTURE_AND_STENCIL_WRITE = 33455,
	GL_TEXTURE_COMPRESSED_BLOCK_WIDTH = 33457,
	GL_TEXTURE_COMPRESSED_BLOCK_HEIGHT = 33458,
	GL_TEXTURE_COMPRESSED_BLOCK_SIZE = 33459,
	GL_CLEAR_BUFFER = 33460,
	GL_TEXTURE_VIEW = 33461,
	GL_VIEW_COMPATIBILITY_CLASS = 33462,
	GL_FULL_SUPPORT = 33463,
	GL_CAVEAT_SUPPORT = 33464,
	GL_IMAGE_CLASS_4_X_32 = 33465,
	GL_IMAGE_CLASS_2_X_32 = 33466,
	GL_IMAGE_CLASS_1_X_32 = 33467,
	GL_IMAGE_CLASS_4_X_16 = 33468,
	GL_IMAGE_CLASS_2_X_16 = 33469,
	GL_IMAGE_CLASS_1_X_16 = 33470,
	GL_IMAGE_CLASS_4_X_8 = 33471,
	GL_IMAGE_CLASS_2_X_8 = 33472,
	GL_IMAGE_CLASS_1_X_8 = 33473,
	GL_IMAGE_CLASS_11_11_10 = 33474,
	GL_IMAGE_CLASS_10_10_10_2 = 33475,
	GL_VIEW_CLASS_128_BITS = 33476,
	GL_VIEW_CLASS_96_BITS = 33477,
	GL_VIEW_CLASS_64_BITS = 33478,
	GL_VIEW_CLASS_48_BITS = 33479,
	GL_VIEW_CLASS_32_BITS = 33480,
	GL_VIEW_CLASS_24_BITS = 33481,
	GL_VIEW_CLASS_16_BITS = 33482,
	GL_VIEW_CLASS_8_BITS = 33483,
	GL_VIEW_CLASS_S3TC_DXT1_RGB = 33484,
	GL_VIEW_CLASS_S3TC_DXT1_RGBA = 33485,
	GL_VIEW_CLASS_S3TC_DXT3_RGBA = 33486,
	GL_VIEW_CLASS_S3TC_DXT5_RGBA = 33487,
	GL_VIEW_CLASS_RGTC1_RED = 33488,
	GL_VIEW_CLASS_RGTC2_RG = 33489,
	GL_VIEW_CLASS_BPTC_UNORM = 33490,
	GL_VIEW_CLASS_BPTC_FLOAT = 33491,
	GL_UNIFORM = 37601,
	GL_UNIFORM_BLOCK = 37602,
	GL_PROGRAM_INPUT = 37603,
	GL_PROGRAM_OUTPUT = 37604,
	GL_BUFFER_VARIABLE = 37605,
	GL_SHADER_STORAGE_BLOCK = 37606,
	GL_VERTEX_SUBROUTINE = 37608,
	GL_TESS_CONTROL_SUBROUTINE = 37609,
	GL_TESS_EVALUATION_SUBROUTINE = 37610,
	GL_GEOMETRY_SUBROUTINE = 37611,
	GL_FRAGMENT_SUBROUTINE = 37612,
	GL_COMPUTE_SUBROUTINE = 37613,
	GL_VERTEX_SUBROUTINE_UNIFORM = 37614,
	GL_TESS_CONTROL_SUBROUTINE_UNIFORM = 37615,
	GL_TESS_EVALUATION_SUBROUTINE_UNIFORM = 37616,
	GL_GEOMETRY_SUBROUTINE_UNIFORM = 37617,
	GL_FRAGMENT_SUBROUTINE_UNIFORM = 37618,
	GL_COMPUTE_SUBROUTINE_UNIFORM = 37619,
	GL_TRANSFORM_FEEDBACK_VARYING = 37620,
	GL_ACTIVE_RESOURCES = 37621,
	GL_MAX_NAME_LENGTH = 37622,
	GL_MAX_NUM_ACTIVE_VARIABLES = 37623,
	GL_MAX_NUM_COMPATIBLE_SUBROUTINES = 37624,
	GL_NAME_LENGTH = 37625,
	GL_TYPE = 37626,
	GL_ARRAY_SIZE = 37627,
	GL_OFFSET = 37628,
	GL_BLOCK_INDEX = 37629,
	GL_ARRAY_STRIDE = 37630,
	GL_MATRIX_STRIDE = 37631,
	GL_IS_ROW_MAJOR = 37632,
	GL_ATOMIC_COUNTER_BUFFER_INDEX = 37633,
	GL_BUFFER_BINDING = 37634,
	GL_BUFFER_DATA_SIZE = 37635,
	GL_NUM_ACTIVE_VARIABLES = 37636,
	GL_ACTIVE_VARIABLES = 37637,
	GL_REFERENCED_BY_VERTEX_SHADER = 37638,
	GL_REFERENCED_BY_TESS_CONTROL_SHADER = 37639,
	GL_REFERENCED_BY_TESS_EVALUATION_SHADER = 37640,
	GL_REFERENCED_BY_GEOMETRY_SHADER = 37641,
	GL_REFERENCED_BY_FRAGMENT_SHADER = 37642,
	GL_REFERENCED_BY_COMPUTE_SHADER = 37643,
	GL_TOP_LEVEL_ARRAY_SIZE = 37644,
	GL_TOP_LEVEL_ARRAY_STRIDE = 37645,
	GL_LOCATION = 37646,
	GL_LOCATION_INDEX = 37647,
	GL_IS_PER_PATCH = 37607,
	GL_SHADER_STORAGE_BUFFER = 37074,
	GL_SHADER_STORAGE_BUFFER_BINDING = 37075,
	GL_SHADER_STORAGE_BUFFER_START = 37076,
	GL_SHADER_STORAGE_BUFFER_SIZE = 37077,
	GL_MAX_VERTEX_SHADER_STORAGE_BLOCKS = 37078,
	GL_MAX_GEOMETRY_SHADER_STORAGE_BLOCKS = 37079,
	GL_MAX_TESS_CONTROL_SHADER_STORAGE_BLOCKS = 37080,
	GL_MAX_TESS_EVALUATION_SHADER_STORAGE_BLOCKS = 37081,
	GL_MAX_FRAGMENT_SHADER_STORAGE_BLOCKS = 37082,
	GL_MAX_COMPUTE_SHADER_STORAGE_BLOCKS = 37083,
	GL_MAX_COMBINED_SHADER_STORAGE_BLOCKS = 37084,
	GL_MAX_SHADER_STORAGE_BUFFER_BINDINGS = 37085,
	GL_MAX_SHADER_STORAGE_BLOCK_SIZE = 37086,
	GL_SHADER_STORAGE_BUFFER_OFFSET_ALIGNMENT = 37087,
	GL_SHADER_STORAGE_BARRIER_BIT = 8192,
	GL_MAX_COMBINED_SHADER_OUTPUT_RESOURCES = 36665,
	GL_DEPTH_STENCIL_TEXTURE_MODE = 37098,
	GL_TEXTURE_BUFFER_OFFSET = 37277,
	GL_TEXTURE_BUFFER_SIZE = 37278,
	GL_TEXTURE_BUFFER_OFFSET_ALIGNMENT = 37279,
	GL_TEXTURE_VIEW_MIN_LEVEL = 33499,
	GL_TEXTURE_VIEW_NUM_LEVELS = 33500,
	GL_TEXTURE_VIEW_MIN_LAYER = 33501,
	GL_TEXTURE_VIEW_NUM_LAYERS = 33502,
	GL_TEXTURE_IMMUTABLE_LEVELS = 33503,
	GL_VERTEX_ATTRIB_BINDING = 33492,
	GL_VERTEX_ATTRIB_RELATIVE_OFFSET = 33493,
	GL_VERTEX_BINDING_DIVISOR = 33494,
	GL_VERTEX_BINDING_OFFSET = 33495,
	GL_VERTEX_BINDING_STRIDE = 33496,
	GL_MAX_VERTEX_ATTRIB_RELATIVE_OFFSET = 33497,
	GL_MAX_VERTEX_ATTRIB_BINDINGS = 33498,
	GL_VERTEX_BINDING_BUFFER = 36687,
	GL_DISPLAY_LIST = 33511,
	GL_VERSION_4_4 = 1,
	GL_MAX_VERTEX_ATTRIB_STRIDE = 33509,
	GL_PRIMITIVE_RESTART_FOR_PATCHES_SUPPORTED = 33313,
	GL_TEXTURE_BUFFER_BINDING = 35882,
	GL_MAP_PERSISTENT_BIT = 64,
	GL_MAP_COHERENT_BIT = 128,
	GL_DYNAMIC_STORAGE_BIT = 256,
	GL_CLIENT_STORAGE_BIT = 512,
	GL_CLIENT_MAPPED_BUFFER_BARRIER_BIT = 16384,
	GL_BUFFER_IMMUTABLE_STORAGE = 33311,
	GL_BUFFER_STORAGE_FLAGS = 33312,
	GL_CLEAR_TEXTURE = 37733,
	GL_LOCATION_COMPONENT = 37706,
	GL_TRANSFORM_FEEDBACK_BUFFER_INDEX = 37707,
	GL_TRANSFORM_FEEDBACK_BUFFER_STRIDE = 37708,
	GL_QUERY_BUFFER = 37266,
	GL_QUERY_BUFFER_BARRIER_BIT = 32768,
	GL_QUERY_BUFFER_BINDING = 37267,
	GL_QUERY_RESULT_NO_WAIT = 37268,
	GL_MIRROR_CLAMP_TO_EDGE = 34627,
	GL_VERSION_4_5 = 1,
	GL_CONTEXT_LOST = 1287,
	GL_NEGATIVE_ONE_TO_ONE = 37726,
	GL_ZERO_TO_ONE = 37727,
	GL_CLIP_ORIGIN = 37724,
	GL_CLIP_DEPTH_MODE = 37725,
	GL_QUERY_WAIT_INVERTED = 36375,
	GL_QUERY_NO_WAIT_INVERTED = 36376,
	GL_QUERY_BY_REGION_WAIT_INVERTED = 36377,
	GL_QUERY_BY_REGION_NO_WAIT_INVERTED = 36378,
	GL_MAX_CULL_DISTANCES = 33529,
	GL_MAX_COMBINED_CLIP_AND_CULL_DISTANCES = 33530,
	GL_TEXTURE_TARGET = 4102,
	GL_QUERY_TARGET = 33514,
	GL_GUILTY_CONTEXT_RESET = 33363,
	GL_INNOCENT_CONTEXT_RESET = 33364,
	GL_UNKNOWN_CONTEXT_RESET = 33365,
	GL_RESET_NOTIFICATION_STRATEGY = 33366,
	GL_LOSE_CONTEXT_ON_RESET = 33362,
	GL_NO_RESET_NOTIFICATION = 33377,
	GL_CONTEXT_FLAG_ROBUST_ACCESS_BIT = 4,
	GL_COLOR_TABLE = 32976,
	GL_POST_CONVOLUTION_COLOR_TABLE = 32977,
	GL_POST_COLOR_MATRIX_COLOR_TABLE = 32978,
	GL_PROXY_COLOR_TABLE = 32979,
	GL_PROXY_POST_CONVOLUTION_COLOR_TABLE = 32980,
	GL_PROXY_POST_COLOR_MATRIX_COLOR_TABLE = 32981,
	GL_CONVOLUTION_1D = 32784,
	GL_CONVOLUTION_2D = 32785,
	GL_SEPARABLE_2D = 32786,
	GL_HISTOGRAM = 32804,
	GL_PROXY_HISTOGRAM = 32805,
	GL_MINMAX = 32814,
	GL_CONTEXT_RELEASE_BEHAVIOR = 33531,
	GL_CONTEXT_RELEASE_BEHAVIOR_FLUSH = 33532,
	GL_VERSION_4_6 = 1,
	GL_SHADER_BINARY_FORMAT_SPIR_V = 38225,
	GL_SPIR_V_BINARY = 38226,
	GL_PARAMETER_BUFFER = 33006,
	GL_PARAMETER_BUFFER_BINDING = 33007,
	GL_CONTEXT_FLAG_NO_ERROR_BIT = 8,
	GL_VERTICES_SUBMITTED = 33518,
	GL_PRIMITIVES_SUBMITTED = 33519,
	GL_VERTEX_SHADER_INVOCATIONS = 33520,
	GL_TESS_CONTROL_SHADER_PATCHES = 33521,
	GL_TESS_EVALUATION_SHADER_INVOCATIONS = 33522,
	GL_GEOMETRY_SHADER_PRIMITIVES_EMITTED = 33523,
	GL_FRAGMENT_SHADER_INVOCATIONS = 33524,
	GL_COMPUTE_SHADER_INVOCATIONS = 33525,
	GL_CLIPPING_INPUT_PRIMITIVES = 33526,
	GL_CLIPPING_OUTPUT_PRIMITIVES = 33527,
	GL_POLYGON_OFFSET_CLAMP = 36379,
	GL_SPIR_V_EXTENSIONS = 38227,
	GL_NUM_SPIR_V_EXTENSIONS = 38228,
	GL_TEXTURE_MAX_ANISOTROPY = 34046,
	GL_MAX_TEXTURE_MAX_ANISOTROPY = 34047,
	GL_TRANSFORM_FEEDBACK_OVERFLOW = 33516,
	GL_TRANSFORM_FEEDBACK_STREAM_OVERFLOW = 33517,
	GL_ARB_ES2_compatibility = 1,
	GL_ARB_ES3_1_compatibility = 1,
	GL_ARB_ES3_2_compatibility = 1,
	GL_PRIMITIVE_BOUNDING_BOX_ARB = 37566,
	GL_MULTISAMPLE_LINE_WIDTH_RANGE_ARB = 37761,
	GL_MULTISAMPLE_LINE_WIDTH_GRANULARITY_ARB = 37762,
	GL_ARB_ES3_compatibility = 1,
	GL_ARB_arrays_of_arrays = 1,
	GL_ARB_base_instance = 1,
	GL_ARB_bindless_texture = 1,
	GL_UNSIGNED_INT64_ARB = 5135,
	GL_ARB_blend_func_extended = 1,
	GL_ARB_buffer_storage = 1,
	GL_ARB_cl_event = 1,
	GL_SYNC_CL_EVENT_ARB = 33344,
	GL_SYNC_CL_EVENT_COMPLETE_ARB = 33345,
	GL_ARB_clear_buffer_object = 1,
	GL_ARB_clear_texture = 1,
	GL_ARB_clip_control = 1,
	GL_ARB_color_buffer_float = 1,
	GL_RGBA_FLOAT_MODE_ARB = 34848,
	GL_CLAMP_VERTEX_COLOR_ARB = 35098,
	GL_CLAMP_FRAGMENT_COLOR_ARB = 35099,
	GL_CLAMP_READ_COLOR_ARB = 35100,
	GL_FIXED_ONLY_ARB = 35101,
	GL_ARB_compatibility = 1,
	GL_ARB_compressed_texture_pixel_storage = 1,
	GL_ARB_compute_shader = 1,
	GL_ARB_compute_variable_group_size = 1,
	GL_MAX_COMPUTE_VARIABLE_GROUP_INVOCATIONS_ARB = 37700,
	GL_MAX_COMPUTE_FIXED_GROUP_INVOCATIONS_ARB = 37099,
	GL_MAX_COMPUTE_VARIABLE_GROUP_SIZE_ARB = 37701,
	GL_MAX_COMPUTE_FIXED_GROUP_SIZE_ARB = 37311,
	GL_ARB_conditional_render_inverted = 1,
	GL_ARB_conservative_depth = 1,
	GL_ARB_copy_buffer = 1,
	GL_ARB_copy_image = 1,
	GL_ARB_cull_distance = 1,
	GL_ARB_debug_output = 1,
	GL_DEBUG_OUTPUT_SYNCHRONOUS_ARB = 33346,
	GL_DEBUG_NEXT_LOGGED_MESSAGE_LENGTH_ARB = 33347,
	GL_DEBUG_CALLBACK_FUNCTION_ARB = 33348,
	GL_DEBUG_CALLBACK_USER_PARAM_ARB = 33349,
	GL_DEBUG_SOURCE_API_ARB = 33350,
	GL_DEBUG_SOURCE_WINDOW_SYSTEM_ARB = 33351,
	GL_DEBUG_SOURCE_SHADER_COMPILER_ARB = 33352,
	GL_DEBUG_SOURCE_THIRD_PARTY_ARB = 33353,
	GL_DEBUG_SOURCE_APPLICATION_ARB = 33354,
	GL_DEBUG_SOURCE_OTHER_ARB = 33355,
	GL_DEBUG_TYPE_ERROR_ARB = 33356,
	GL_DEBUG_TYPE_DEPRECATED_BEHAVIOR_ARB = 33357,
	GL_DEBUG_TYPE_UNDEFINED_BEHAVIOR_ARB = 33358,
	GL_DEBUG_TYPE_PORTABILITY_ARB = 33359,
	GL_DEBUG_TYPE_PERFORMANCE_ARB = 33360,
	GL_DEBUG_TYPE_OTHER_ARB = 33361,
	GL_MAX_DEBUG_MESSAGE_LENGTH_ARB = 37187,
	GL_MAX_DEBUG_LOGGED_MESSAGES_ARB = 37188,
	GL_DEBUG_LOGGED_MESSAGES_ARB = 37189,
	GL_DEBUG_SEVERITY_HIGH_ARB = 37190,
	GL_DEBUG_SEVERITY_MEDIUM_ARB = 37191,
	GL_DEBUG_SEVERITY_LOW_ARB = 37192,
	GL_ARB_depth_buffer_float = 1,
	GL_ARB_depth_clamp = 1,
	GL_ARB_depth_texture = 1,
	GL_DEPTH_COMPONENT16_ARB = 33189,
	GL_DEPTH_COMPONENT24_ARB = 33190,
	GL_DEPTH_COMPONENT32_ARB = 33191,
	GL_TEXTURE_DEPTH_SIZE_ARB = 34890,
	GL_DEPTH_TEXTURE_MODE_ARB = 34891,
	GL_ARB_derivative_control = 1,
	GL_ARB_direct_state_access = 1,
	GL_ARB_draw_buffers = 1,
	GL_MAX_DRAW_BUFFERS_ARB = 34852,
	GL_DRAW_BUFFER0_ARB = 34853,
	GL_DRAW_BUFFER1_ARB = 34854,
	GL_DRAW_BUFFER2_ARB = 34855,
	GL_DRAW_BUFFER3_ARB = 34856,
	GL_DRAW_BUFFER4_ARB = 34857,
	GL_DRAW_BUFFER5_ARB = 34858,
	GL_DRAW_BUFFER6_ARB = 34859,
	GL_DRAW_BUFFER7_ARB = 34860,
	GL_DRAW_BUFFER8_ARB = 34861,
	GL_DRAW_BUFFER9_ARB = 34862,
	GL_DRAW_BUFFER10_ARB = 34863,
	GL_DRAW_BUFFER11_ARB = 34864,
	GL_DRAW_BUFFER12_ARB = 34865,
	GL_DRAW_BUFFER13_ARB = 34866,
	GL_DRAW_BUFFER14_ARB = 34867,
	GL_DRAW_BUFFER15_ARB = 34868,
	GL_ARB_draw_buffers_blend = 1,
	GL_ARB_draw_elements_base_vertex = 1,
	GL_ARB_draw_indirect = 1,
	GL_ARB_draw_instanced = 1,
	GL_ARB_enhanced_layouts = 1,
	GL_ARB_explicit_attrib_location = 1,
	GL_ARB_explicit_uniform_location = 1,
	GL_ARB_fragment_coord_conventions = 1,
	GL_ARB_fragment_layer_viewport = 1,
	GL_ARB_fragment_program = 1,
	GL_FRAGMENT_PROGRAM_ARB = 34820,
	GL_PROGRAM_FORMAT_ASCII_ARB = 34933,
	GL_PROGRAM_LENGTH_ARB = 34343,
	GL_PROGRAM_FORMAT_ARB = 34934,
	GL_PROGRAM_BINDING_ARB = 34423,
	GL_PROGRAM_INSTRUCTIONS_ARB = 34976,
	GL_MAX_PROGRAM_INSTRUCTIONS_ARB = 34977,
	GL_PROGRAM_NATIVE_INSTRUCTIONS_ARB = 34978,
	GL_MAX_PROGRAM_NATIVE_INSTRUCTIONS_ARB = 34979,
	GL_PROGRAM_TEMPORARIES_ARB = 34980,
	GL_MAX_PROGRAM_TEMPORARIES_ARB = 34981,
	GL_PROGRAM_NATIVE_TEMPORARIES_ARB = 34982,
	GL_MAX_PROGRAM_NATIVE_TEMPORARIES_ARB = 34983,
	GL_PROGRAM_PARAMETERS_ARB = 34984,
	GL_MAX_PROGRAM_PARAMETERS_ARB = 34985,
	GL_PROGRAM_NATIVE_PARAMETERS_ARB = 34986,
	GL_MAX_PROGRAM_NATIVE_PARAMETERS_ARB = 34987,
	GL_PROGRAM_ATTRIBS_ARB = 34988,
	GL_MAX_PROGRAM_ATTRIBS_ARB = 34989,
	GL_PROGRAM_NATIVE_ATTRIBS_ARB = 34990,
	GL_MAX_PROGRAM_NATIVE_ATTRIBS_ARB = 34991,
	GL_MAX_PROGRAM_LOCAL_PARAMETERS_ARB = 34996,
	GL_MAX_PROGRAM_ENV_PARAMETERS_ARB = 34997,
	GL_PROGRAM_UNDER_NATIVE_LIMITS_ARB = 34998,
	GL_PROGRAM_ALU_INSTRUCTIONS_ARB = 34821,
	GL_PROGRAM_TEX_INSTRUCTIONS_ARB = 34822,
	GL_PROGRAM_TEX_INDIRECTIONS_ARB = 34823,
	GL_PROGRAM_NATIVE_ALU_INSTRUCTIONS_ARB = 34824,
	GL_PROGRAM_NATIVE_TEX_INSTRUCTIONS_ARB = 34825,
	GL_PROGRAM_NATIVE_TEX_INDIRECTIONS_ARB = 34826,
	GL_MAX_PROGRAM_ALU_INSTRUCTIONS_ARB = 34827,
	GL_MAX_PROGRAM_TEX_INSTRUCTIONS_ARB = 34828,
	GL_MAX_PROGRAM_TEX_INDIRECTIONS_ARB = 34829,
	GL_MAX_PROGRAM_NATIVE_ALU_INSTRUCTIONS_ARB = 34830,
	GL_MAX_PROGRAM_NATIVE_TEX_INSTRUCTIONS_ARB = 34831,
	GL_MAX_PROGRAM_NATIVE_TEX_INDIRECTIONS_ARB = 34832,
	GL_PROGRAM_STRING_ARB = 34344,
	GL_PROGRAM_ERROR_POSITION_ARB = 34379,
	GL_CURRENT_MATRIX_ARB = 34369,
	GL_TRANSPOSE_CURRENT_MATRIX_ARB = 34999,
	GL_CURRENT_MATRIX_STACK_DEPTH_ARB = 34368,
	GL_MAX_PROGRAM_MATRICES_ARB = 34351,
	GL_MAX_PROGRAM_MATRIX_STACK_DEPTH_ARB = 34350,
	GL_MAX_TEXTURE_COORDS_ARB = 34929,
	GL_MAX_TEXTURE_IMAGE_UNITS_ARB = 34930,
	GL_PROGRAM_ERROR_STRING_ARB = 34932,
	GL_MATRIX0_ARB = 35008,
	GL_MATRIX1_ARB = 35009,
	GL_MATRIX2_ARB = 35010,
	GL_MATRIX3_ARB = 35011,
	GL_MATRIX4_ARB = 35012,
	GL_MATRIX5_ARB = 35013,
	GL_MATRIX6_ARB = 35014,
	GL_MATRIX7_ARB = 35015,
	GL_MATRIX8_ARB = 35016,
	GL_MATRIX9_ARB = 35017,
	GL_MATRIX10_ARB = 35018,
	GL_MATRIX11_ARB = 35019,
	GL_MATRIX12_ARB = 35020,
	GL_MATRIX13_ARB = 35021,
	GL_MATRIX14_ARB = 35022,
	GL_MATRIX15_ARB = 35023,
	GL_MATRIX16_ARB = 35024,
	GL_MATRIX17_ARB = 35025,
	GL_MATRIX18_ARB = 35026,
	GL_MATRIX19_ARB = 35027,
	GL_MATRIX20_ARB = 35028,
	GL_MATRIX21_ARB = 35029,
	GL_MATRIX22_ARB = 35030,
	GL_MATRIX23_ARB = 35031,
	GL_MATRIX24_ARB = 35032,
	GL_MATRIX25_ARB = 35033,
	GL_MATRIX26_ARB = 35034,
	GL_MATRIX27_ARB = 35035,
	GL_MATRIX28_ARB = 35036,
	GL_MATRIX29_ARB = 35037,
	GL_MATRIX30_ARB = 35038,
	GL_MATRIX31_ARB = 35039,
	GL_ARB_fragment_program_shadow = 1,
	GL_ARB_fragment_shader = 1,
	GL_FRAGMENT_SHADER_ARB = 35632,
	GL_MAX_FRAGMENT_UNIFORM_COMPONENTS_ARB = 35657,
	GL_FRAGMENT_SHADER_DERIVATIVE_HINT_ARB = 35723,
	GL_ARB_fragment_shader_interlock = 1,
	GL_ARB_framebuffer_no_attachments = 1,
	GL_ARB_framebuffer_object = 1,
	GL_ARB_framebuffer_sRGB = 1,
	GL_ARB_geometry_shader4 = 1,
	GL_LINES_ADJACENCY_ARB = 10,
	GL_LINE_STRIP_ADJACENCY_ARB = 11,
	GL_TRIANGLES_ADJACENCY_ARB = 12,
	GL_TRIANGLE_STRIP_ADJACENCY_ARB = 13,
	GL_PROGRAM_POINT_SIZE_ARB = 34370,
	GL_MAX_GEOMETRY_TEXTURE_IMAGE_UNITS_ARB = 35881,
	GL_FRAMEBUFFER_ATTACHMENT_LAYERED_ARB = 36263,
	GL_FRAMEBUFFER_INCOMPLETE_LAYER_TARGETS_ARB = 36264,
	GL_FRAMEBUFFER_INCOMPLETE_LAYER_COUNT_ARB = 36265,
	GL_GEOMETRY_SHADER_ARB = 36313,
	GL_GEOMETRY_VERTICES_OUT_ARB = 36314,
	GL_GEOMETRY_INPUT_TYPE_ARB = 36315,
	GL_GEOMETRY_OUTPUT_TYPE_ARB = 36316,
	GL_MAX_GEOMETRY_VARYING_COMPONENTS_ARB = 36317,
	GL_MAX_VERTEX_VARYING_COMPONENTS_ARB = 36318,
	GL_MAX_GEOMETRY_UNIFORM_COMPONENTS_ARB = 36319,
	GL_MAX_GEOMETRY_OUTPUT_VERTICES_ARB = 36320,
	GL_MAX_GEOMETRY_TOTAL_OUTPUT_COMPONENTS_ARB = 36321,
	GL_ARB_get_program_binary = 1,
	GL_ARB_get_texture_sub_image = 1,
	GL_ARB_gl_spirv = 1,
	GL_SHADER_BINARY_FORMAT_SPIR_V_ARB = 38225,
	GL_SPIR_V_BINARY_ARB = 38226,
	GL_ARB_gpu_shader5 = 1,
	GL_ARB_gpu_shader_fp64 = 1,
	GL_ARB_gpu_shader_int64 = 1,
	GL_INT64_ARB = 5134,
	GL_INT64_VEC2_ARB = 36841,
	GL_INT64_VEC3_ARB = 36842,
	GL_INT64_VEC4_ARB = 36843,
	GL_UNSIGNED_INT64_VEC2_ARB = 36853,
	GL_UNSIGNED_INT64_VEC3_ARB = 36854,
	GL_UNSIGNED_INT64_VEC4_ARB = 36855,
	GL_ARB_half_float_pixel = 1,
	GL_HALF_FLOAT_ARB = 5131,
	GL_ARB_half_float_vertex = 1,
	GL_ARB_imaging = 1,
	GL_CONVOLUTION_BORDER_MODE = 32787,
	GL_CONVOLUTION_FILTER_SCALE = 32788,
	GL_CONVOLUTION_FILTER_BIAS = 32789,
	GL_REDUCE = 32790,
	GL_CONVOLUTION_FORMAT = 32791,
	GL_CONVOLUTION_WIDTH = 32792,
	GL_CONVOLUTION_HEIGHT = 32793,
	GL_MAX_CONVOLUTION_WIDTH = 32794,
	GL_MAX_CONVOLUTION_HEIGHT = 32795,
	GL_POST_CONVOLUTION_RED_SCALE = 32796,
	GL_POST_CONVOLUTION_GREEN_SCALE = 32797,
	GL_POST_CONVOLUTION_BLUE_SCALE = 32798,
	GL_POST_CONVOLUTION_ALPHA_SCALE = 32799,
	GL_POST_CONVOLUTION_RED_BIAS = 32800,
	GL_POST_CONVOLUTION_GREEN_BIAS = 32801,
	GL_POST_CONVOLUTION_BLUE_BIAS = 32802,
	GL_POST_CONVOLUTION_ALPHA_BIAS = 32803,
	GL_HISTOGRAM_WIDTH = 32806,
	GL_HISTOGRAM_FORMAT = 32807,
	GL_HISTOGRAM_RED_SIZE = 32808,
	GL_HISTOGRAM_GREEN_SIZE = 32809,
	GL_HISTOGRAM_BLUE_SIZE = 32810,
	GL_HISTOGRAM_ALPHA_SIZE = 32811,
	GL_HISTOGRAM_LUMINANCE_SIZE = 32812,
	GL_HISTOGRAM_SINK = 32813,
	GL_MINMAX_FORMAT = 32815,
	GL_MINMAX_SINK = 32816,
	GL_TABLE_TOO_LARGE = 32817,
	GL_COLOR_MATRIX = 32945,
	GL_COLOR_MATRIX_STACK_DEPTH = 32946,
	GL_MAX_COLOR_MATRIX_STACK_DEPTH = 32947,
	GL_POST_COLOR_MATRIX_RED_SCALE = 32948,
	GL_POST_COLOR_MATRIX_GREEN_SCALE = 32949,
	GL_POST_COLOR_MATRIX_BLUE_SCALE = 32950,
	GL_POST_COLOR_MATRIX_ALPHA_SCALE = 32951,
	GL_POST_COLOR_MATRIX_RED_BIAS = 32952,
	GL_POST_COLOR_MATRIX_GREEN_BIAS = 32953,
	GL_POST_COLOR_MATRIX_BLUE_BIAS = 32954,
	GL_POST_COLOR_MATRIX_ALPHA_BIAS = 32955,
	GL_COLOR_TABLE_SCALE = 32982,
	GL_COLOR_TABLE_BIAS = 32983,
	GL_COLOR_TABLE_FORMAT = 32984,
	GL_COLOR_TABLE_WIDTH = 32985,
	GL_COLOR_TABLE_RED_SIZE = 32986,
	GL_COLOR_TABLE_GREEN_SIZE = 32987,
	GL_COLOR_TABLE_BLUE_SIZE = 32988,
	GL_COLOR_TABLE_ALPHA_SIZE = 32989,
	GL_COLOR_TABLE_LUMINANCE_SIZE = 32990,
	GL_COLOR_TABLE_INTENSITY_SIZE = 32991,
	GL_CONSTANT_BORDER = 33105,
	GL_REPLICATE_BORDER = 33107,
	GL_CONVOLUTION_BORDER_COLOR = 33108,
	GL_ARB_indirect_parameters = 1,
	GL_PARAMETER_BUFFER_ARB = 33006,
	GL_PARAMETER_BUFFER_BINDING_ARB = 33007,
	GL_ARB_instanced_arrays = 1,
	GL_VERTEX_ATTRIB_ARRAY_DIVISOR_ARB = 35070,
	GL_ARB_internalformat_query = 1,
	GL_ARB_internalformat_query2 = 1,
	GL_SRGB_DECODE_ARB = 33433,
	GL_VIEW_CLASS_EAC_R11 = 37763,
	GL_VIEW_CLASS_EAC_RG11 = 37764,
	GL_VIEW_CLASS_ETC2_RGB = 37765,
	GL_VIEW_CLASS_ETC2_RGBA = 37766,
	GL_VIEW_CLASS_ETC2_EAC_RGBA = 37767,
	GL_VIEW_CLASS_ASTC_4x4_RGBA = 37768,
	GL_VIEW_CLASS_ASTC_5x4_RGBA = 37769,
	GL_VIEW_CLASS_ASTC_5x5_RGBA = 37770,
	GL_VIEW_CLASS_ASTC_6x5_RGBA = 37771,
	GL_VIEW_CLASS_ASTC_6x6_RGBA = 37772,
	GL_VIEW_CLASS_ASTC_8x5_RGBA = 37773,
	GL_VIEW_CLASS_ASTC_8x6_RGBA = 37774,
	GL_VIEW_CLASS_ASTC_8x8_RGBA = 37775,
	GL_VIEW_CLASS_ASTC_10x5_RGBA = 37776,
	GL_VIEW_CLASS_ASTC_10x6_RGBA = 37777,
	GL_VIEW_CLASS_ASTC_10x8_RGBA = 37778,
	GL_VIEW_CLASS_ASTC_10x10_RGBA = 37779,
	GL_VIEW_CLASS_ASTC_12x10_RGBA = 37780,
	GL_VIEW_CLASS_ASTC_12x12_RGBA = 37781,
	GL_ARB_invalidate_subdata = 1,
	GL_ARB_map_buffer_alignment = 1,
	GL_ARB_map_buffer_range = 1,
	GL_ARB_matrix_palette = 1,
	GL_MATRIX_PALETTE_ARB = 34880,
	GL_MAX_MATRIX_PALETTE_STACK_DEPTH_ARB = 34881,
	GL_MAX_PALETTE_MATRICES_ARB = 34882,
	GL_CURRENT_PALETTE_MATRIX_ARB = 34883,
	GL_MATRIX_INDEX_ARRAY_ARB = 34884,
	GL_CURRENT_MATRIX_INDEX_ARB = 34885,
	GL_MATRIX_INDEX_ARRAY_SIZE_ARB = 34886,
	GL_MATRIX_INDEX_ARRAY_TYPE_ARB = 34887,
	GL_MATRIX_INDEX_ARRAY_STRIDE_ARB = 34888,
	GL_MATRIX_INDEX_ARRAY_POINTER_ARB = 34889,
	GL_ARB_multi_bind = 1,
	GL_ARB_multi_draw_indirect = 1,
	GL_ARB_multisample = 1,
	GL_MULTISAMPLE_ARB = 32925,
	GL_SAMPLE_ALPHA_TO_COVERAGE_ARB = 32926,
	GL_SAMPLE_ALPHA_TO_ONE_ARB = 32927,
	GL_SAMPLE_COVERAGE_ARB = 32928,
	GL_SAMPLE_BUFFERS_ARB = 32936,
	GL_SAMPLES_ARB = 32937,
	GL_SAMPLE_COVERAGE_VALUE_ARB = 32938,
	GL_SAMPLE_COVERAGE_INVERT_ARB = 32939,
	GL_MULTISAMPLE_BIT_ARB = 536870912,
	GL_ARB_multitexture = 1,
	GL_TEXTURE0_ARB = 33984,
	GL_TEXTURE1_ARB = 33985,
	GL_TEXTURE2_ARB = 33986,
	GL_TEXTURE3_ARB = 33987,
	GL_TEXTURE4_ARB = 33988,
	GL_TEXTURE5_ARB = 33989,
	GL_TEXTURE6_ARB = 33990,
	GL_TEXTURE7_ARB = 33991,
	GL_TEXTURE8_ARB = 33992,
	GL_TEXTURE9_ARB = 33993,
	GL_TEXTURE10_ARB = 33994,
	GL_TEXTURE11_ARB = 33995,
	GL_TEXTURE12_ARB = 33996,
	GL_TEXTURE13_ARB = 33997,
	GL_TEXTURE14_ARB = 33998,
	GL_TEXTURE15_ARB = 33999,
	GL_TEXTURE16_ARB = 34000,
	GL_TEXTURE17_ARB = 34001,
	GL_TEXTURE18_ARB = 34002,
	GL_TEXTURE19_ARB = 34003,
	GL_TEXTURE20_ARB = 34004,
	GL_TEXTURE21_ARB = 34005,
	GL_TEXTURE22_ARB = 34006,
	GL_TEXTURE23_ARB = 34007,
	GL_TEXTURE24_ARB = 34008,
	GL_TEXTURE25_ARB = 34009,
	GL_TEXTURE26_ARB = 34010,
	GL_TEXTURE27_ARB = 34011,
	GL_TEXTURE28_ARB = 34012,
	GL_TEXTURE29_ARB = 34013,
	GL_TEXTURE30_ARB = 34014,
	GL_TEXTURE31_ARB = 34015,
	GL_ACTIVE_TEXTURE_ARB = 34016,
	GL_CLIENT_ACTIVE_TEXTURE_ARB = 34017,
	GL_MAX_TEXTURE_UNITS_ARB = 34018,
	GL_ARB_occlusion_query = 1,
	GL_QUERY_COUNTER_BITS_ARB = 34916,
	GL_CURRENT_QUERY_ARB = 34917,
	GL_QUERY_RESULT_ARB = 34918,
	GL_QUERY_RESULT_AVAILABLE_ARB = 34919,
	GL_SAMPLES_PASSED_ARB = 35092,
	GL_ARB_occlusion_query2 = 1,
	GL_ARB_parallel_shader_compile = 1,
	GL_MAX_SHADER_COMPILER_THREADS_ARB = 37296,
	GL_COMPLETION_STATUS_ARB = 37297,
	GL_ARB_pipeline_statistics_query = 1,
	GL_VERTICES_SUBMITTED_ARB = 33518,
	GL_PRIMITIVES_SUBMITTED_ARB = 33519,
	GL_VERTEX_SHADER_INVOCATIONS_ARB = 33520,
	GL_TESS_CONTROL_SHADER_PATCHES_ARB = 33521,
	GL_TESS_EVALUATION_SHADER_INVOCATIONS_ARB = 33522,
	GL_GEOMETRY_SHADER_PRIMITIVES_EMITTED_ARB = 33523,
	GL_FRAGMENT_SHADER_INVOCATIONS_ARB = 33524,
	GL_COMPUTE_SHADER_INVOCATIONS_ARB = 33525,
	GL_CLIPPING_INPUT_PRIMITIVES_ARB = 33526,
	GL_CLIPPING_OUTPUT_PRIMITIVES_ARB = 33527,
	GL_ARB_pixel_buffer_object = 1,
	GL_PIXEL_PACK_BUFFER_ARB = 35051,
	GL_PIXEL_UNPACK_BUFFER_ARB = 35052,
	GL_PIXEL_PACK_BUFFER_BINDING_ARB = 35053,
	GL_PIXEL_UNPACK_BUFFER_BINDING_ARB = 35055,
	GL_ARB_point_parameters = 1,
	GL_POINT_SIZE_MIN_ARB = 33062,
	GL_POINT_SIZE_MAX_ARB = 33063,
	GL_POINT_FADE_THRESHOLD_SIZE_ARB = 33064,
	GL_POINT_DISTANCE_ATTENUATION_ARB = 33065,
	GL_ARB_point_sprite = 1,
	GL_POINT_SPRITE_ARB = 34913,
	GL_COORD_REPLACE_ARB = 34914,
	GL_ARB_polygon_offset_clamp = 1,
	GL_ARB_post_depth_coverage = 1,
	GL_ARB_program_interface_query = 1,
	GL_ARB_provoking_vertex = 1,
	GL_ARB_query_buffer_object = 1,
	GL_ARB_robust_buffer_access_behavior = 1,
	GL_ARB_robustness = 1,
	GL_CONTEXT_FLAG_ROBUST_ACCESS_BIT_ARB = 4,
	GL_LOSE_CONTEXT_ON_RESET_ARB = 33362,
	GL_GUILTY_CONTEXT_RESET_ARB = 33363,
	GL_INNOCENT_CONTEXT_RESET_ARB = 33364,
	GL_UNKNOWN_CONTEXT_RESET_ARB = 33365,
	GL_RESET_NOTIFICATION_STRATEGY_ARB = 33366,
	GL_NO_RESET_NOTIFICATION_ARB = 33377,
	GL_ARB_robustness_isolation = 1,
	GL_ARB_sample_locations = 1,
	GL_SAMPLE_LOCATION_SUBPIXEL_BITS_ARB = 37693,
	GL_SAMPLE_LOCATION_PIXEL_GRID_WIDTH_ARB = 37694,
	GL_SAMPLE_LOCATION_PIXEL_GRID_HEIGHT_ARB = 37695,
	GL_PROGRAMMABLE_SAMPLE_LOCATION_TABLE_SIZE_ARB = 37696,
	GL_SAMPLE_LOCATION_ARB = 36432,
	GL_PROGRAMMABLE_SAMPLE_LOCATION_ARB = 37697,
	GL_FRAMEBUFFER_PROGRAMMABLE_SAMPLE_LOCATIONS_ARB = 37698,
	GL_FRAMEBUFFER_SAMPLE_LOCATION_PIXEL_GRID_ARB = 37699,
	GL_ARB_sample_shading = 1,
	GL_SAMPLE_SHADING_ARB = 35894,
	GL_MIN_SAMPLE_SHADING_VALUE_ARB = 35895,
	GL_ARB_sampler_objects = 1,
	GL_ARB_seamless_cube_map = 1,
	GL_ARB_seamless_cubemap_per_texture = 1,
	GL_ARB_separate_shader_objects = 1,
	GL_ARB_shader_atomic_counter_ops = 1,
	GL_ARB_shader_atomic_counters = 1,
	GL_ARB_shader_ballot = 1,
	GL_ARB_shader_bit_encoding = 1,
	GL_ARB_shader_clock = 1,
	GL_ARB_shader_draw_parameters = 1,
	GL_ARB_shader_group_vote = 1,
	GL_ARB_shader_image_load_store = 1,
	GL_ARB_shader_image_size = 1,
	GL_ARB_shader_objects = 1,
	GL_PROGRAM_OBJECT_ARB = 35648,
	GL_SHADER_OBJECT_ARB = 35656,
	GL_OBJECT_TYPE_ARB = 35662,
	GL_OBJECT_SUBTYPE_ARB = 35663,
	GL_FLOAT_VEC2_ARB = 35664,
	GL_FLOAT_VEC3_ARB = 35665,
	GL_FLOAT_VEC4_ARB = 35666,
	GL_INT_VEC2_ARB = 35667,
	GL_INT_VEC3_ARB = 35668,
	GL_INT_VEC4_ARB = 35669,
	GL_BOOL_ARB = 35670,
	GL_BOOL_VEC2_ARB = 35671,
	GL_BOOL_VEC3_ARB = 35672,
	GL_BOOL_VEC4_ARB = 35673,
	GL_FLOAT_MAT2_ARB = 35674,
	GL_FLOAT_MAT3_ARB = 35675,
	GL_FLOAT_MAT4_ARB = 35676,
	GL_SAMPLER_1D_ARB = 35677,
	GL_SAMPLER_2D_ARB = 35678,
	GL_SAMPLER_3D_ARB = 35679,
	GL_SAMPLER_CUBE_ARB = 35680,
	GL_SAMPLER_1D_SHADOW_ARB = 35681,
	GL_SAMPLER_2D_SHADOW_ARB = 35682,
	GL_SAMPLER_2D_RECT_ARB = 35683,
	GL_SAMPLER_2D_RECT_SHADOW_ARB = 35684,
	GL_OBJECT_DELETE_STATUS_ARB = 35712,
	GL_OBJECT_COMPILE_STATUS_ARB = 35713,
	GL_OBJECT_LINK_STATUS_ARB = 35714,
	GL_OBJECT_VALIDATE_STATUS_ARB = 35715,
	GL_OBJECT_INFO_LOG_LENGTH_ARB = 35716,
	GL_OBJECT_ATTACHED_OBJECTS_ARB = 35717,
	GL_OBJECT_ACTIVE_UNIFORMS_ARB = 35718,
	GL_OBJECT_ACTIVE_UNIFORM_MAX_LENGTH_ARB = 35719,
	GL_OBJECT_SHADER_SOURCE_LENGTH_ARB = 35720,
	GL_ARB_shader_precision = 1,
	GL_ARB_shader_stencil_export = 1,
	GL_ARB_shader_storage_buffer_object = 1,
	GL_ARB_shader_subroutine = 1,
	GL_ARB_shader_texture_image_samples = 1,
	GL_ARB_shader_texture_lod = 1,
	GL_ARB_shader_viewport_layer_array = 1,
	GL_ARB_shading_language_100 = 1,
	GL_SHADING_LANGUAGE_VERSION_ARB = 35724,
	GL_ARB_shading_language_420pack = 1,
	GL_ARB_shading_language_include = 1,
	GL_SHADER_INCLUDE_ARB = 36270,
	GL_NAMED_STRING_LENGTH_ARB = 36329,
	GL_NAMED_STRING_TYPE_ARB = 36330,
	GL_ARB_shading_language_packing = 1,
	GL_ARB_shadow = 1,
	GL_TEXTURE_COMPARE_MODE_ARB = 34892,
	GL_TEXTURE_COMPARE_FUNC_ARB = 34893,
	GL_COMPARE_R_TO_TEXTURE_ARB = 34894,
	GL_ARB_shadow_ambient = 1,
	GL_TEXTURE_COMPARE_FAIL_VALUE_ARB = 32959,
	GL_ARB_sparse_buffer = 1,
	GL_SPARSE_STORAGE_BIT_ARB = 1024,
	GL_SPARSE_BUFFER_PAGE_SIZE_ARB = 33528,
	GL_ARB_sparse_texture = 1,
	GL_TEXTURE_SPARSE_ARB = 37286,
	GL_VIRTUAL_PAGE_SIZE_INDEX_ARB = 37287,
	GL_NUM_SPARSE_LEVELS_ARB = 37290,
	GL_NUM_VIRTUAL_PAGE_SIZES_ARB = 37288,
	GL_VIRTUAL_PAGE_SIZE_X_ARB = 37269,
	GL_VIRTUAL_PAGE_SIZE_Y_ARB = 37270,
	GL_VIRTUAL_PAGE_SIZE_Z_ARB = 37271,
	GL_MAX_SPARSE_TEXTURE_SIZE_ARB = 37272,
	GL_MAX_SPARSE_3D_TEXTURE_SIZE_ARB = 37273,
	GL_MAX_SPARSE_ARRAY_TEXTURE_LAYERS_ARB = 37274,
	GL_SPARSE_TEXTURE_FULL_ARRAY_CUBE_MIPMAPS_ARB = 37289,
	GL_ARB_sparse_texture2 = 1,
	GL_ARB_sparse_texture_clamp = 1,
	GL_ARB_spirv_extensions = 1,
	GL_ARB_stencil_texturing = 1,
	GL_ARB_sync = 1,
	GL_ARB_tessellation_shader = 1,
	GL_ARB_texture_barrier = 1,
	GL_ARB_texture_border_clamp = 1,
	GL_CLAMP_TO_BORDER_ARB = 33069,
	GL_ARB_texture_buffer_object = 1,
	GL_TEXTURE_BUFFER_ARB = 35882,
	GL_MAX_TEXTURE_BUFFER_SIZE_ARB = 35883,
	GL_TEXTURE_BINDING_BUFFER_ARB = 35884,
	GL_TEXTURE_BUFFER_DATA_STORE_BINDING_ARB = 35885,
	GL_TEXTURE_BUFFER_FORMAT_ARB = 35886,
	GL_ARB_texture_buffer_object_rgb32 = 1,
	GL_ARB_texture_buffer_range = 1,
	GL_ARB_texture_compression = 1,
	GL_COMPRESSED_ALPHA_ARB = 34025,
	GL_COMPRESSED_LUMINANCE_ARB = 34026,
	GL_COMPRESSED_LUMINANCE_ALPHA_ARB = 34027,
	GL_COMPRESSED_INTENSITY_ARB = 34028,
	GL_COMPRESSED_RGB_ARB = 34029,
	GL_COMPRESSED_RGBA_ARB = 34030,
	GL_TEXTURE_COMPRESSION_HINT_ARB = 34031,
	GL_TEXTURE_COMPRESSED_IMAGE_SIZE_ARB = 34464,
	GL_TEXTURE_COMPRESSED_ARB = 34465,
	GL_NUM_COMPRESSED_TEXTURE_FORMATS_ARB = 34466,
	GL_COMPRESSED_TEXTURE_FORMATS_ARB = 34467,
	GL_ARB_texture_compression_bptc = 1,
	GL_COMPRESSED_RGBA_BPTC_UNORM_ARB = 36492,
	GL_COMPRESSED_SRGB_ALPHA_BPTC_UNORM_ARB = 36493,
	GL_COMPRESSED_RGB_BPTC_SIGNED_FLOAT_ARB = 36494,
	GL_COMPRESSED_RGB_BPTC_UNSIGNED_FLOAT_ARB = 36495,
	GL_ARB_texture_compression_rgtc = 1,
	GL_ARB_texture_cube_map = 1,
	GL_NORMAL_MAP_ARB = 34065,
	GL_REFLECTION_MAP_ARB = 34066,
	GL_TEXTURE_CUBE_MAP_ARB = 34067,
	GL_TEXTURE_BINDING_CUBE_MAP_ARB = 34068,
	GL_TEXTURE_CUBE_MAP_POSITIVE_X_ARB = 34069,
	GL_TEXTURE_CUBE_MAP_NEGATIVE_X_ARB = 34070,
	GL_TEXTURE_CUBE_MAP_POSITIVE_Y_ARB = 34071,
	GL_TEXTURE_CUBE_MAP_NEGATIVE_Y_ARB = 34072,
	GL_TEXTURE_CUBE_MAP_POSITIVE_Z_ARB = 34073,
	GL_TEXTURE_CUBE_MAP_NEGATIVE_Z_ARB = 34074,
	GL_PROXY_TEXTURE_CUBE_MAP_ARB = 34075,
	GL_MAX_CUBE_MAP_TEXTURE_SIZE_ARB = 34076,
	GL_ARB_texture_cube_map_array = 1,
	GL_TEXTURE_CUBE_MAP_ARRAY_ARB = 36873,
	GL_TEXTURE_BINDING_CUBE_MAP_ARRAY_ARB = 36874,
	GL_PROXY_TEXTURE_CUBE_MAP_ARRAY_ARB = 36875,
	GL_SAMPLER_CUBE_MAP_ARRAY_ARB = 36876,
	GL_SAMPLER_CUBE_MAP_ARRAY_SHADOW_ARB = 36877,
	GL_INT_SAMPLER_CUBE_MAP_ARRAY_ARB = 36878,
	GL_UNSIGNED_INT_SAMPLER_CUBE_MAP_ARRAY_ARB = 36879,
	GL_ARB_texture_env_add = 1,
	GL_ARB_texture_env_combine = 1,
	GL_COMBINE_ARB = 34160,
	GL_COMBINE_RGB_ARB = 34161,
	GL_COMBINE_ALPHA_ARB = 34162,
	GL_SOURCE0_RGB_ARB = 34176,
	GL_SOURCE1_RGB_ARB = 34177,
	GL_SOURCE2_RGB_ARB = 34178,
	GL_SOURCE0_ALPHA_ARB = 34184,
	GL_SOURCE1_ALPHA_ARB = 34185,
	GL_SOURCE2_ALPHA_ARB = 34186,
	GL_OPERAND0_RGB_ARB = 34192,
	GL_OPERAND1_RGB_ARB = 34193,
	GL_OPERAND2_RGB_ARB = 34194,
	GL_OPERAND0_ALPHA_ARB = 34200,
	GL_OPERAND1_ALPHA_ARB = 34201,
	GL_OPERAND2_ALPHA_ARB = 34202,
	GL_RGB_SCALE_ARB = 34163,
	GL_ADD_SIGNED_ARB = 34164,
	GL_INTERPOLATE_ARB = 34165,
	GL_SUBTRACT_ARB = 34023,
	GL_CONSTANT_ARB = 34166,
	GL_PRIMARY_COLOR_ARB = 34167,
	GL_PREVIOUS_ARB = 34168,
	GL_ARB_texture_env_crossbar = 1,
	GL_ARB_texture_env_dot3 = 1,
	GL_DOT3_RGB_ARB = 34478,
	GL_DOT3_RGBA_ARB = 34479,
	GL_ARB_texture_filter_anisotropic = 1,
	GL_ARB_texture_filter_minmax = 1,
	GL_TEXTURE_REDUCTION_MODE_ARB = 37734,
	GL_WEIGHTED_AVERAGE_ARB = 37735,
	GL_ARB_texture_float = 1,
	GL_TEXTURE_RED_TYPE_ARB = 35856,
	GL_TEXTURE_GREEN_TYPE_ARB = 35857,
	GL_TEXTURE_BLUE_TYPE_ARB = 35858,
	GL_TEXTURE_ALPHA_TYPE_ARB = 35859,
	GL_TEXTURE_LUMINANCE_TYPE_ARB = 35860,
	GL_TEXTURE_INTENSITY_TYPE_ARB = 35861,
	GL_TEXTURE_DEPTH_TYPE_ARB = 35862,
	GL_UNSIGNED_NORMALIZED_ARB = 35863,
	GL_RGBA32F_ARB = 34836,
	GL_RGB32F_ARB = 34837,
	GL_ALPHA32F_ARB = 34838,
	GL_INTENSITY32F_ARB = 34839,
	GL_LUMINANCE32F_ARB = 34840,
	GL_LUMINANCE_ALPHA32F_ARB = 34841,
	GL_RGBA16F_ARB = 34842,
	GL_RGB16F_ARB = 34843,
	GL_ALPHA16F_ARB = 34844,
	GL_INTENSITY16F_ARB = 34845,
	GL_LUMINANCE16F_ARB = 34846,
	GL_LUMINANCE_ALPHA16F_ARB = 34847,
	GL_ARB_texture_gather = 1,
	GL_MIN_PROGRAM_TEXTURE_GATHER_OFFSET_ARB = 36446,
	GL_MAX_PROGRAM_TEXTURE_GATHER_OFFSET_ARB = 36447,
	GL_MAX_PROGRAM_TEXTURE_GATHER_COMPONENTS_ARB = 36767,
	GL_ARB_texture_mirror_clamp_to_edge = 1,
	GL_ARB_texture_mirrored_repeat = 1,
	GL_MIRRORED_REPEAT_ARB = 33648,
	GL_ARB_texture_multisample = 1,
	GL_ARB_texture_non_power_of_two = 1,
	GL_ARB_texture_query_levels = 1,
	GL_ARB_texture_query_lod = 1,
	GL_ARB_texture_rectangle = 1,
	GL_TEXTURE_RECTANGLE_ARB = 34037,
	GL_TEXTURE_BINDING_RECTANGLE_ARB = 34038,
	GL_PROXY_TEXTURE_RECTANGLE_ARB = 34039,
	GL_MAX_RECTANGLE_TEXTURE_SIZE_ARB = 34040,
	GL_ARB_texture_rg = 1,
	GL_ARB_texture_rgb10_a2ui = 1,
	GL_ARB_texture_stencil8 = 1,
	GL_ARB_texture_storage = 1,
	GL_ARB_texture_storage_multisample = 1,
	GL_ARB_texture_swizzle = 1,
	GL_ARB_texture_view = 1,
	GL_ARB_timer_query = 1,
	GL_ARB_transform_feedback2 = 1,
	GL_ARB_transform_feedback3 = 1,
	GL_ARB_transform_feedback_instanced = 1,
	GL_ARB_transform_feedback_overflow_query = 1,
	GL_TRANSFORM_FEEDBACK_OVERFLOW_ARB = 33516,
	GL_TRANSFORM_FEEDBACK_STREAM_OVERFLOW_ARB = 33517,
	GL_ARB_transpose_matrix = 1,
	GL_TRANSPOSE_MODELVIEW_MATRIX_ARB = 34019,
	GL_TRANSPOSE_PROJECTION_MATRIX_ARB = 34020,
	GL_TRANSPOSE_TEXTURE_MATRIX_ARB = 34021,
	GL_TRANSPOSE_COLOR_MATRIX_ARB = 34022,
	GL_ARB_uniform_buffer_object = 1,
	GL_ARB_vertex_array_bgra = 1,
	GL_ARB_vertex_array_object = 1,
	GL_ARB_vertex_attrib_64bit = 1,
	GL_ARB_vertex_attrib_binding = 1,
	GL_ARB_vertex_blend = 1,
	GL_MAX_VERTEX_UNITS_ARB = 34468,
	GL_ACTIVE_VERTEX_UNITS_ARB = 34469,
	GL_WEIGHT_SUM_UNITY_ARB = 34470,
	GL_VERTEX_BLEND_ARB = 34471,
	GL_CURRENT_WEIGHT_ARB = 34472,
	GL_WEIGHT_ARRAY_TYPE_ARB = 34473,
	GL_WEIGHT_ARRAY_STRIDE_ARB = 34474,
	GL_WEIGHT_ARRAY_SIZE_ARB = 34475,
	GL_WEIGHT_ARRAY_POINTER_ARB = 34476,
	GL_WEIGHT_ARRAY_ARB = 34477,
	GL_MODELVIEW0_ARB = 5888,
	GL_MODELVIEW1_ARB = 34058,
	GL_MODELVIEW2_ARB = 34594,
	GL_MODELVIEW3_ARB = 34595,
	GL_MODELVIEW4_ARB = 34596,
	GL_MODELVIEW5_ARB = 34597,
	GL_MODELVIEW6_ARB = 34598,
	GL_MODELVIEW7_ARB = 34599,
	GL_MODELVIEW8_ARB = 34600,
	GL_MODELVIEW9_ARB = 34601,
	GL_MODELVIEW10_ARB = 34602,
	GL_MODELVIEW11_ARB = 34603,
	GL_MODELVIEW12_ARB = 34604,
	GL_MODELVIEW13_ARB = 34605,
	GL_MODELVIEW14_ARB = 34606,
	GL_MODELVIEW15_ARB = 34607,
	GL_MODELVIEW16_ARB = 34608,
	GL_MODELVIEW17_ARB = 34609,
	GL_MODELVIEW18_ARB = 34610,
	GL_MODELVIEW19_ARB = 34611,
	GL_MODELVIEW20_ARB = 34612,
	GL_MODELVIEW21_ARB = 34613,
	GL_MODELVIEW22_ARB = 34614,
	GL_MODELVIEW23_ARB = 34615,
	GL_MODELVIEW24_ARB = 34616,
	GL_MODELVIEW25_ARB = 34617,
	GL_MODELVIEW26_ARB = 34618,
	GL_MODELVIEW27_ARB = 34619,
	GL_MODELVIEW28_ARB = 34620,
	GL_MODELVIEW29_ARB = 34621,
	GL_MODELVIEW30_ARB = 34622,
	GL_MODELVIEW31_ARB = 34623,
	GL_ARB_vertex_buffer_object = 1,
	GL_BUFFER_SIZE_ARB = 34660,
	GL_BUFFER_USAGE_ARB = 34661,
	GL_ARRAY_BUFFER_ARB = 34962,
	GL_ELEMENT_ARRAY_BUFFER_ARB = 34963,
	GL_ARRAY_BUFFER_BINDING_ARB = 34964,
	GL_ELEMENT_ARRAY_BUFFER_BINDING_ARB = 34965,
	GL_VERTEX_ARRAY_BUFFER_BINDING_ARB = 34966,
	GL_NORMAL_ARRAY_BUFFER_BINDING_ARB = 34967,
	GL_COLOR_ARRAY_BUFFER_BINDING_ARB = 34968,
	GL_INDEX_ARRAY_BUFFER_BINDING_ARB = 34969,
	GL_TEXTURE_COORD_ARRAY_BUFFER_BINDING_ARB = 34970,
	GL_EDGE_FLAG_ARRAY_BUFFER_BINDING_ARB = 34971,
	GL_SECONDARY_COLOR_ARRAY_BUFFER_BINDING_ARB = 34972,
	GL_FOG_COORDINATE_ARRAY_BUFFER_BINDING_ARB = 34973,
	GL_WEIGHT_ARRAY_BUFFER_BINDING_ARB = 34974,
	GL_VERTEX_ATTRIB_ARRAY_BUFFER_BINDING_ARB = 34975,
	GL_READ_ONLY_ARB = 35000,
	GL_WRITE_ONLY_ARB = 35001,
	GL_READ_WRITE_ARB = 35002,
	GL_BUFFER_ACCESS_ARB = 35003,
	GL_BUFFER_MAPPED_ARB = 35004,
	GL_BUFFER_MAP_POINTER_ARB = 35005,
	GL_STREAM_DRAW_ARB = 35040,
	GL_STREAM_READ_ARB = 35041,
	GL_STREAM_COPY_ARB = 35042,
	GL_STATIC_DRAW_ARB = 35044,
	GL_STATIC_READ_ARB = 35045,
	GL_STATIC_COPY_ARB = 35046,
	GL_DYNAMIC_DRAW_ARB = 35048,
	GL_DYNAMIC_READ_ARB = 35049,
	GL_DYNAMIC_COPY_ARB = 35050,
	GL_ARB_vertex_program = 1,
	GL_COLOR_SUM_ARB = 33880,
	GL_VERTEX_PROGRAM_ARB = 34336,
	GL_VERTEX_ATTRIB_ARRAY_ENABLED_ARB = 34338,
	GL_VERTEX_ATTRIB_ARRAY_SIZE_ARB = 34339,
	GL_VERTEX_ATTRIB_ARRAY_STRIDE_ARB = 34340,
	GL_VERTEX_ATTRIB_ARRAY_TYPE_ARB = 34341,
	GL_CURRENT_VERTEX_ATTRIB_ARB = 34342,
	GL_VERTEX_PROGRAM_POINT_SIZE_ARB = 34370,
	GL_VERTEX_PROGRAM_TWO_SIDE_ARB = 34371,
	GL_VERTEX_ATTRIB_ARRAY_POINTER_ARB = 34373,
	GL_MAX_VERTEX_ATTRIBS_ARB = 34921,
	GL_VERTEX_ATTRIB_ARRAY_NORMALIZED_ARB = 34922,
	GL_PROGRAM_ADDRESS_REGISTERS_ARB = 34992,
	GL_MAX_PROGRAM_ADDRESS_REGISTERS_ARB = 34993,
	GL_PROGRAM_NATIVE_ADDRESS_REGISTERS_ARB = 34994,
	GL_MAX_PROGRAM_NATIVE_ADDRESS_REGISTERS_ARB = 34995,
	GL_ARB_vertex_shader = 1,
	GL_VERTEX_SHADER_ARB = 35633,
	GL_MAX_VERTEX_UNIFORM_COMPONENTS_ARB = 35658,
	GL_MAX_VARYING_FLOATS_ARB = 35659,
	GL_MAX_VERTEX_TEXTURE_IMAGE_UNITS_ARB = 35660,
	GL_MAX_COMBINED_TEXTURE_IMAGE_UNITS_ARB = 35661,
	GL_OBJECT_ACTIVE_ATTRIBUTES_ARB = 35721,
	GL_OBJECT_ACTIVE_ATTRIBUTE_MAX_LENGTH_ARB = 35722,
	GL_ARB_vertex_type_10f_11f_11f_rev = 1,
	GL_ARB_vertex_type_2_10_10_10_rev = 1,
	GL_ARB_viewport_array = 1,
	GL_ARB_window_pos = 1,
	GL_KHR_blend_equation_advanced = 1,
	GL_MULTIPLY_KHR = 37524,
	GL_SCREEN_KHR = 37525,
	GL_OVERLAY_KHR = 37526,
	GL_DARKEN_KHR = 37527,
	GL_LIGHTEN_KHR = 37528,
	GL_COLORDODGE_KHR = 37529,
	GL_COLORBURN_KHR = 37530,
	GL_HARDLIGHT_KHR = 37531,
	GL_SOFTLIGHT_KHR = 37532,
	GL_DIFFERENCE_KHR = 37534,
	GL_EXCLUSION_KHR = 37536,
	GL_HSL_HUE_KHR = 37549,
	GL_HSL_SATURATION_KHR = 37550,
	GL_HSL_COLOR_KHR = 37551,
	GL_HSL_LUMINOSITY_KHR = 37552,
	GL_KHR_blend_equation_advanced_coherent = 1,
	GL_BLEND_ADVANCED_COHERENT_KHR = 37509,
	GL_KHR_context_flush_control = 1,
	GL_KHR_debug = 1,
	GL_KHR_no_error = 1,
	GL_CONTEXT_FLAG_NO_ERROR_BIT_KHR = 8,
	GL_KHR_parallel_shader_compile = 1,
	GL_MAX_SHADER_COMPILER_THREADS_KHR = 37296,
	GL_COMPLETION_STATUS_KHR = 37297,
	GL_KHR_robust_buffer_access_behavior = 1,
	GL_KHR_robustness = 1,
	GL_CONTEXT_ROBUST_ACCESS = 37107,
	GL_KHR_shader_subgroup = 1,
	GL_SUBGROUP_SIZE_KHR = 38194,
	GL_SUBGROUP_SUPPORTED_STAGES_KHR = 38195,
	GL_SUBGROUP_SUPPORTED_FEATURES_KHR = 38196,
	GL_SUBGROUP_QUAD_ALL_STAGES_KHR = 38197,
	GL_SUBGROUP_FEATURE_BASIC_BIT_KHR = 1,
	GL_SUBGROUP_FEATURE_VOTE_BIT_KHR = 2,
	GL_SUBGROUP_FEATURE_ARITHMETIC_BIT_KHR = 4,
	GL_SUBGROUP_FEATURE_BALLOT_BIT_KHR = 8,
	GL_SUBGROUP_FEATURE_SHUFFLE_BIT_KHR = 16,
	GL_SUBGROUP_FEATURE_SHUFFLE_RELATIVE_BIT_KHR = 32,
	GL_SUBGROUP_FEATURE_CLUSTERED_BIT_KHR = 64,
	GL_SUBGROUP_FEATURE_QUAD_BIT_KHR = 128,
	GL_KHR_texture_compression_astc_hdr = 1,
	GL_COMPRESSED_RGBA_ASTC_4x4_KHR = 37808,
	GL_COMPRESSED_RGBA_ASTC_5x4_KHR = 37809,
	GL_COMPRESSED_RGBA_ASTC_5x5_KHR = 37810,
	GL_COMPRESSED_RGBA_ASTC_6x5_KHR = 37811,
	GL_COMPRESSED_RGBA_ASTC_6x6_KHR = 37812,
	GL_COMPRESSED_RGBA_ASTC_8x5_KHR = 37813,
	GL_COMPRESSED_RGBA_ASTC_8x6_KHR = 37814,
	GL_COMPRESSED_RGBA_ASTC_8x8_KHR = 37815,
	GL_COMPRESSED_RGBA_ASTC_10x5_KHR = 37816,
	GL_COMPRESSED_RGBA_ASTC_10x6_KHR = 37817,
	GL_COMPRESSED_RGBA_ASTC_10x8_KHR = 37818,
	GL_COMPRESSED_RGBA_ASTC_10x10_KHR = 37819,
	GL_COMPRESSED_RGBA_ASTC_12x10_KHR = 37820,
	GL_COMPRESSED_RGBA_ASTC_12x12_KHR = 37821,
	GL_COMPRESSED_SRGB8_ALPHA8_ASTC_4x4_KHR = 37840,
	GL_COMPRESSED_SRGB8_ALPHA8_ASTC_5x4_KHR = 37841,
	GL_COMPRESSED_SRGB8_ALPHA8_ASTC_5x5_KHR = 37842,
	GL_COMPRESSED_SRGB8_ALPHA8_ASTC_6x5_KHR = 37843,
	GL_COMPRESSED_SRGB8_ALPHA8_ASTC_6x6_KHR = 37844,
	GL_COMPRESSED_SRGB8_ALPHA8_ASTC_8x5_KHR = 37845,
	GL_COMPRESSED_SRGB8_ALPHA8_ASTC_8x6_KHR = 37846,
	GL_COMPRESSED_SRGB8_ALPHA8_ASTC_8x8_KHR = 37847,
	GL_COMPRESSED_SRGB8_ALPHA8_ASTC_10x5_KHR = 37848,
	GL_COMPRESSED_SRGB8_ALPHA8_ASTC_10x6_KHR = 37849,
	GL_COMPRESSED_SRGB8_ALPHA8_ASTC_10x8_KHR = 37850,
	GL_COMPRESSED_SRGB8_ALPHA8_ASTC_10x10_KHR = 37851,
	GL_COMPRESSED_SRGB8_ALPHA8_ASTC_12x10_KHR = 37852,
	GL_COMPRESSED_SRGB8_ALPHA8_ASTC_12x12_KHR = 37853,
	GL_KHR_texture_compression_astc_ldr = 1,
	GL_KHR_texture_compression_astc_sliced_3d = 1,
	GL_OES_byte_coordinates = 1,
	GL_OES_compressed_paletted_texture = 1,
	GL_PALETTE4_RGB8_OES = 35728,
	GL_PALETTE4_RGBA8_OES = 35729,
	GL_PALETTE4_R5_G6_B5_OES = 35730,
	GL_PALETTE4_RGBA4_OES = 35731,
	GL_PALETTE4_RGB5_A1_OES = 35732,
	GL_PALETTE8_RGB8_OES = 35733,
	GL_PALETTE8_RGBA8_OES = 35734,
	GL_PALETTE8_R5_G6_B5_OES = 35735,
	GL_PALETTE8_RGBA4_OES = 35736,
	GL_PALETTE8_RGB5_A1_OES = 35737,
	GL_OES_fixed_point = 1,
	GL_FIXED_OES = 5132,
	GL_OES_query_matrix = 1,
	GL_OES_read_format = 1,
	GL_IMPLEMENTATION_COLOR_READ_TYPE_OES = 35738,
	GL_IMPLEMENTATION_COLOR_READ_FORMAT_OES = 35739,
	GL_OES_single_precision = 1,
	GL_3DFX_multisample = 1,
	GL_MULTISAMPLE_3DFX = 34482,
	GL_SAMPLE_BUFFERS_3DFX = 34483,
	GL_SAMPLES_3DFX = 34484,
	GL_MULTISAMPLE_BIT_3DFX = 536870912,
	GL_3DFX_tbuffer = 1,
	GL_3DFX_texture_compression_FXT1 = 1,
	GL_COMPRESSED_RGB_FXT1_3DFX = 34480,
	GL_COMPRESSED_RGBA_FXT1_3DFX = 34481,
	GL_AMD_blend_minmax_factor = 1,
	GL_FACTOR_MIN_AMD = 36892,
	GL_FACTOR_MAX_AMD = 36893,
	GL_AMD_conservative_depth = 1,
	GL_AMD_debug_output = 1,
	GL_MAX_DEBUG_MESSAGE_LENGTH_AMD = 37187,
	GL_MAX_DEBUG_LOGGED_MESSAGES_AMD = 37188,
	GL_DEBUG_LOGGED_MESSAGES_AMD = 37189,
	GL_DEBUG_SEVERITY_HIGH_AMD = 37190,
	GL_DEBUG_SEVERITY_MEDIUM_AMD = 37191,
	GL_DEBUG_SEVERITY_LOW_AMD = 37192,
	GL_DEBUG_CATEGORY_API_ERROR_AMD = 37193,
	GL_DEBUG_CATEGORY_WINDOW_SYSTEM_AMD = 37194,
	GL_DEBUG_CATEGORY_DEPRECATION_AMD = 37195,
	GL_DEBUG_CATEGORY_UNDEFINED_BEHAVIOR_AMD = 37196,
	GL_DEBUG_CATEGORY_PERFORMANCE_AMD = 37197,
	GL_DEBUG_CATEGORY_SHADER_COMPILER_AMD = 37198,
	GL_DEBUG_CATEGORY_APPLICATION_AMD = 37199,
	GL_DEBUG_CATEGORY_OTHER_AMD = 37200,
	GL_AMD_depth_clamp_separate = 1,
	GL_DEPTH_CLAMP_NEAR_AMD = 36894,
	GL_DEPTH_CLAMP_FAR_AMD = 36895,
	GL_AMD_draw_buffers_blend = 1,
	GL_AMD_framebuffer_multisample_advanced = 1,
	GL_RENDERBUFFER_STORAGE_SAMPLES_AMD = 37298,
	GL_MAX_COLOR_FRAMEBUFFER_SAMPLES_AMD = 37299,
	GL_MAX_COLOR_FRAMEBUFFER_STORAGE_SAMPLES_AMD = 37300,
	GL_MAX_DEPTH_STENCIL_FRAMEBUFFER_SAMPLES_AMD = 37301,
	GL_NUM_SUPPORTED_MULTISAMPLE_MODES_AMD = 37302,
	GL_SUPPORTED_MULTISAMPLE_MODES_AMD = 37303,
	GL_AMD_framebuffer_sample_positions = 1,
	GL_SUBSAMPLE_DISTANCE_AMD = 34879,
	GL_PIXELS_PER_SAMPLE_PATTERN_X_AMD = 37294,
	GL_PIXELS_PER_SAMPLE_PATTERN_Y_AMD = 37295,
	GL_ALL_PIXELS_AMD = 4294967295,
	GL_AMD_gcn_shader = 1,
	GL_AMD_gpu_shader_half_float = 1,
	GL_FLOAT16_NV = 36856,
	GL_FLOAT16_VEC2_NV = 36857,
	GL_FLOAT16_VEC3_NV = 36858,
	GL_FLOAT16_VEC4_NV = 36859,
	GL_FLOAT16_MAT2_AMD = 37317,
	GL_FLOAT16_MAT3_AMD = 37318,
	GL_FLOAT16_MAT4_AMD = 37319,
	GL_FLOAT16_MAT2x3_AMD = 37320,
	GL_FLOAT16_MAT2x4_AMD = 37321,
	GL_FLOAT16_MAT3x2_AMD = 37322,
	GL_FLOAT16_MAT3x4_AMD = 37323,
	GL_FLOAT16_MAT4x2_AMD = 37324,
	GL_FLOAT16_MAT4x3_AMD = 37325,
	GL_AMD_gpu_shader_int16 = 1,
	GL_AMD_gpu_shader_int64 = 1,
	GL_INT64_NV = 5134,
	GL_UNSIGNED_INT64_NV = 5135,
	GL_INT8_NV = 36832,
	GL_INT8_VEC2_NV = 36833,
	GL_INT8_VEC3_NV = 36834,
	GL_INT8_VEC4_NV = 36835,
	GL_INT16_NV = 36836,
	GL_INT16_VEC2_NV = 36837,
	GL_INT16_VEC3_NV = 36838,
	GL_INT16_VEC4_NV = 36839,
	GL_INT64_VEC2_NV = 36841,
	GL_INT64_VEC3_NV = 36842,
	GL_INT64_VEC4_NV = 36843,
	GL_UNSIGNED_INT8_NV = 36844,
	GL_UNSIGNED_INT8_VEC2_NV = 36845,
	GL_UNSIGNED_INT8_VEC3_NV = 36846,
	GL_UNSIGNED_INT8_VEC4_NV = 36847,
	GL_UNSIGNED_INT16_NV = 36848,
	GL_UNSIGNED_INT16_VEC2_NV = 36849,
	GL_UNSIGNED_INT16_VEC3_NV = 36850,
	GL_UNSIGNED_INT16_VEC4_NV = 36851,
	GL_UNSIGNED_INT64_VEC2_NV = 36853,
	GL_UNSIGNED_INT64_VEC3_NV = 36854,
	GL_UNSIGNED_INT64_VEC4_NV = 36855,
	GL_AMD_interleaved_elements = 1,
	GL_VERTEX_ELEMENT_SWIZZLE_AMD = 37284,
	GL_VERTEX_ID_SWIZZLE_AMD = 37285,
	GL_AMD_multi_draw_indirect = 1,
	GL_AMD_name_gen_delete = 1,
	GL_DATA_BUFFER_AMD = 37201,
	GL_PERFORMANCE_MONITOR_AMD = 37202,
	GL_QUERY_OBJECT_AMD = 37203,
	GL_VERTEX_ARRAY_OBJECT_AMD = 37204,
	GL_SAMPLER_OBJECT_AMD = 37205,
	GL_AMD_occlusion_query_event = 1,
	GL_OCCLUSION_QUERY_EVENT_MASK_AMD = 34639,
	GL_QUERY_DEPTH_PASS_EVENT_BIT_AMD = 1,
	GL_QUERY_DEPTH_FAIL_EVENT_BIT_AMD = 2,
	GL_QUERY_STENCIL_FAIL_EVENT_BIT_AMD = 4,
	GL_QUERY_DEPTH_BOUNDS_FAIL_EVENT_BIT_AMD = 8,
	GL_QUERY_ALL_EVENT_BITS_AMD = 4294967295,
	GL_AMD_performance_monitor = 1,
	GL_COUNTER_TYPE_AMD = 35776,
	GL_COUNTER_RANGE_AMD = 35777,
	GL_UNSIGNED_INT64_AMD = 35778,
	GL_PERCENTAGE_AMD = 35779,
	GL_PERFMON_RESULT_AVAILABLE_AMD = 35780,
	GL_PERFMON_RESULT_SIZE_AMD = 35781,
	GL_PERFMON_RESULT_AMD = 35782,
	GL_AMD_pinned_memory = 1,
	GL_EXTERNAL_VIRTUAL_MEMORY_BUFFER_AMD = 37216,
	GL_AMD_query_buffer_object = 1,
	GL_QUERY_BUFFER_AMD = 37266,
	GL_QUERY_BUFFER_BINDING_AMD = 37267,
	GL_QUERY_RESULT_NO_WAIT_AMD = 37268,
	GL_AMD_sample_positions = 1,
	GL_AMD_seamless_cubemap_per_texture = 1,
	GL_AMD_shader_atomic_counter_ops = 1,
	GL_AMD_shader_ballot = 1,
	GL_AMD_shader_explicit_vertex_parameter = 1,
	GL_AMD_shader_gpu_shader_half_float_fetch = 1,
	GL_AMD_shader_image_load_store_lod = 1,
	GL_AMD_shader_stencil_export = 1,
	GL_AMD_shader_trinary_minmax = 1,
	GL_AMD_sparse_texture = 1,
	GL_VIRTUAL_PAGE_SIZE_X_AMD = 37269,
	GL_VIRTUAL_PAGE_SIZE_Y_AMD = 37270,
	GL_VIRTUAL_PAGE_SIZE_Z_AMD = 37271,
	GL_MAX_SPARSE_TEXTURE_SIZE_AMD = 37272,
	GL_MAX_SPARSE_3D_TEXTURE_SIZE_AMD = 37273,
	GL_MAX_SPARSE_ARRAY_TEXTURE_LAYERS = 37274,
	GL_MIN_SPARSE_LEVEL_AMD = 37275,
	GL_MIN_LOD_WARNING_AMD = 37276,
	GL_TEXTURE_STORAGE_SPARSE_BIT_AMD = 1,
	GL_AMD_stencil_operation_extended = 1,
	GL_SET_AMD = 34634,
	GL_REPLACE_VALUE_AMD = 34635,
	GL_STENCIL_OP_VALUE_AMD = 34636,
	GL_STENCIL_BACK_OP_VALUE_AMD = 34637,
	GL_AMD_texture_gather_bias_lod = 1,
	GL_AMD_texture_texture4 = 1,
	GL_AMD_transform_feedback3_lines_triangles = 1,
	GL_AMD_transform_feedback4 = 1,
	GL_STREAM_RASTERIZATION_AMD = 37280,
	GL_AMD_vertex_shader_layer = 1,
	GL_AMD_vertex_shader_tessellator = 1,
	GL_SAMPLER_BUFFER_AMD = 36865,
	GL_INT_SAMPLER_BUFFER_AMD = 36866,
	GL_UNSIGNED_INT_SAMPLER_BUFFER_AMD = 36867,
	GL_TESSELLATION_MODE_AMD = 36868,
	GL_TESSELLATION_FACTOR_AMD = 36869,
	GL_DISCRETE_AMD = 36870,
	GL_CONTINUOUS_AMD = 36871,
	GL_AMD_vertex_shader_viewport_index = 1,
	GL_APPLE_aux_depth_stencil = 1,
	GL_AUX_DEPTH_STENCIL_APPLE = 35348,
	GL_APPLE_client_storage = 1,
	GL_UNPACK_CLIENT_STORAGE_APPLE = 34226,
	GL_APPLE_element_array = 1,
	GL_ELEMENT_ARRAY_APPLE = 35340,
	GL_ELEMENT_ARRAY_TYPE_APPLE = 35341,
	GL_ELEMENT_ARRAY_POINTER_APPLE = 35342,
	GL_APPLE_fence = 1,
	GL_DRAW_PIXELS_APPLE = 35338,
	GL_FENCE_APPLE = 35339,
	GL_APPLE_float_pixels = 1,
	GL_HALF_APPLE = 5131,
	GL_RGBA_FLOAT32_APPLE = 34836,
	GL_RGB_FLOAT32_APPLE = 34837,
	GL_ALPHA_FLOAT32_APPLE = 34838,
	GL_INTENSITY_FLOAT32_APPLE = 34839,
	GL_LUMINANCE_FLOAT32_APPLE = 34840,
	GL_LUMINANCE_ALPHA_FLOAT32_APPLE = 34841,
	GL_RGBA_FLOAT16_APPLE = 34842,
	GL_RGB_FLOAT16_APPLE = 34843,
	GL_ALPHA_FLOAT16_APPLE = 34844,
	GL_INTENSITY_FLOAT16_APPLE = 34845,
	GL_LUMINANCE_FLOAT16_APPLE = 34846,
	GL_LUMINANCE_ALPHA_FLOAT16_APPLE = 34847,
	GL_COLOR_FLOAT_APPLE = 35343,
	GL_APPLE_flush_buffer_range = 1,
	GL_BUFFER_SERIALIZED_MODIFY_APPLE = 35346,
	GL_BUFFER_FLUSHING_UNMAP_APPLE = 35347,
	GL_APPLE_object_purgeable = 1,
	GL_BUFFER_OBJECT_APPLE = 34227,
	GL_RELEASED_APPLE = 35353,
	GL_VOLATILE_APPLE = 35354,
	GL_RETAINED_APPLE = 35355,
	GL_UNDEFINED_APPLE = 35356,
	GL_PURGEABLE_APPLE = 35357,
	GL_APPLE_rgb_422 = 1,
	GL_RGB_422_APPLE = 35359,
	GL_UNSIGNED_SHORT_8_8_APPLE = 34234,
	GL_UNSIGNED_SHORT_8_8_REV_APPLE = 34235,
	GL_RGB_RAW_422_APPLE = 35409,
	GL_APPLE_row_bytes = 1,
	GL_PACK_ROW_BYTES_APPLE = 35349,
	GL_UNPACK_ROW_BYTES_APPLE = 35350,
	GL_APPLE_specular_vector = 1,
	GL_LIGHT_MODEL_SPECULAR_VECTOR_APPLE = 34224,
	GL_APPLE_texture_range = 1,
	GL_TEXTURE_RANGE_LENGTH_APPLE = 34231,
	GL_TEXTURE_RANGE_POINTER_APPLE = 34232,
	GL_TEXTURE_STORAGE_HINT_APPLE = 34236,
	GL_STORAGE_PRIVATE_APPLE = 34237,
	GL_STORAGE_CACHED_APPLE = 34238,
	GL_STORAGE_SHARED_APPLE = 34239,
	GL_APPLE_transform_hint = 1,
	GL_TRANSFORM_HINT_APPLE = 34225,
	GL_APPLE_vertex_array_object = 1,
	GL_VERTEX_ARRAY_BINDING_APPLE = 34229,
	GL_APPLE_vertex_array_range = 1,
	GL_VERTEX_ARRAY_RANGE_APPLE = 34077,
	GL_VERTEX_ARRAY_RANGE_LENGTH_APPLE = 34078,
	GL_VERTEX_ARRAY_STORAGE_HINT_APPLE = 34079,
	GL_VERTEX_ARRAY_RANGE_POINTER_APPLE = 34081,
	GL_STORAGE_CLIENT_APPLE = 34228,
	GL_APPLE_vertex_program_evaluators = 1,
	GL_VERTEX_ATTRIB_MAP1_APPLE = 35328,
	GL_VERTEX_ATTRIB_MAP2_APPLE = 35329,
	GL_VERTEX_ATTRIB_MAP1_SIZE_APPLE = 35330,
	GL_VERTEX_ATTRIB_MAP1_COEFF_APPLE = 35331,
	GL_VERTEX_ATTRIB_MAP1_ORDER_APPLE = 35332,
	GL_VERTEX_ATTRIB_MAP1_DOMAIN_APPLE = 35333,
	GL_VERTEX_ATTRIB_MAP2_SIZE_APPLE = 35334,
	GL_VERTEX_ATTRIB_MAP2_COEFF_APPLE = 35335,
	GL_VERTEX_ATTRIB_MAP2_ORDER_APPLE = 35336,
	GL_VERTEX_ATTRIB_MAP2_DOMAIN_APPLE = 35337,
	GL_APPLE_ycbcr_422 = 1,
	GL_YCBCR_422_APPLE = 34233,
	GL_ATI_draw_buffers = 1,
	GL_MAX_DRAW_BUFFERS_ATI = 34852,
	GL_DRAW_BUFFER0_ATI = 34853,
	GL_DRAW_BUFFER1_ATI = 34854,
	GL_DRAW_BUFFER2_ATI = 34855,
	GL_DRAW_BUFFER3_ATI = 34856,
	GL_DRAW_BUFFER4_ATI = 34857,
	GL_DRAW_BUFFER5_ATI = 34858,
	GL_DRAW_BUFFER6_ATI = 34859,
	GL_DRAW_BUFFER7_ATI = 34860,
	GL_DRAW_BUFFER8_ATI = 34861,
	GL_DRAW_BUFFER9_ATI = 34862,
	GL_DRAW_BUFFER10_ATI = 34863,
	GL_DRAW_BUFFER11_ATI = 34864,
	GL_DRAW_BUFFER12_ATI = 34865,
	GL_DRAW_BUFFER13_ATI = 34866,
	GL_DRAW_BUFFER14_ATI = 34867,
	GL_DRAW_BUFFER15_ATI = 34868,
	GL_ATI_element_array = 1,
	GL_ELEMENT_ARRAY_ATI = 34664,
	GL_ELEMENT_ARRAY_TYPE_ATI = 34665,
	GL_ELEMENT_ARRAY_POINTER_ATI = 34666,
	GL_ATI_envmap_bumpmap = 1,
	GL_BUMP_ROT_MATRIX_ATI = 34677,
	GL_BUMP_ROT_MATRIX_SIZE_ATI = 34678,
	GL_BUMP_NUM_TEX_UNITS_ATI = 34679,
	GL_BUMP_TEX_UNITS_ATI = 34680,
	GL_DUDV_ATI = 34681,
	GL_DU8DV8_ATI = 34682,
	GL_BUMP_ENVMAP_ATI = 34683,
	GL_BUMP_TARGET_ATI = 34684,
	GL_ATI_fragment_shader = 1,
	GL_FRAGMENT_SHADER_ATI = 35104,
	GL_REG_0_ATI = 35105,
	GL_REG_1_ATI = 35106,
	GL_REG_2_ATI = 35107,
	GL_REG_3_ATI = 35108,
	GL_REG_4_ATI = 35109,
	GL_REG_5_ATI = 35110,
	GL_REG_6_ATI = 35111,
	GL_REG_7_ATI = 35112,
	GL_REG_8_ATI = 35113,
	GL_REG_9_ATI = 35114,
	GL_REG_10_ATI = 35115,
	GL_REG_11_ATI = 35116,
	GL_REG_12_ATI = 35117,
	GL_REG_13_ATI = 35118,
	GL_REG_14_ATI = 35119,
	GL_REG_15_ATI = 35120,
	GL_REG_16_ATI = 35121,
	GL_REG_17_ATI = 35122,
	GL_REG_18_ATI = 35123,
	GL_REG_19_ATI = 35124,
	GL_REG_20_ATI = 35125,
	GL_REG_21_ATI = 35126,
	GL_REG_22_ATI = 35127,
	GL_REG_23_ATI = 35128,
	GL_REG_24_ATI = 35129,
	GL_REG_25_ATI = 35130,
	GL_REG_26_ATI = 35131,
	GL_REG_27_ATI = 35132,
	GL_REG_28_ATI = 35133,
	GL_REG_29_ATI = 35134,
	GL_REG_30_ATI = 35135,
	GL_REG_31_ATI = 35136,
	GL_CON_0_ATI = 35137,
	GL_CON_1_ATI = 35138,
	GL_CON_2_ATI = 35139,
	GL_CON_3_ATI = 35140,
	GL_CON_4_ATI = 35141,
	GL_CON_5_ATI = 35142,
	GL_CON_6_ATI = 35143,
	GL_CON_7_ATI = 35144,
	GL_CON_8_ATI = 35145,
	GL_CON_9_ATI = 35146,
	GL_CON_10_ATI = 35147,
	GL_CON_11_ATI = 35148,
	GL_CON_12_ATI = 35149,
	GL_CON_13_ATI = 35150,
	GL_CON_14_ATI = 35151,
	GL_CON_15_ATI = 35152,
	GL_CON_16_ATI = 35153,
	GL_CON_17_ATI = 35154,
	GL_CON_18_ATI = 35155,
	GL_CON_19_ATI = 35156,
	GL_CON_20_ATI = 35157,
	GL_CON_21_ATI = 35158,
	GL_CON_22_ATI = 35159,
	GL_CON_23_ATI = 35160,
	GL_CON_24_ATI = 35161,
	GL_CON_25_ATI = 35162,
	GL_CON_26_ATI = 35163,
	GL_CON_27_ATI = 35164,
	GL_CON_28_ATI = 35165,
	GL_CON_29_ATI = 35166,
	GL_CON_30_ATI = 35167,
	GL_CON_31_ATI = 35168,
	GL_MOV_ATI = 35169,
	GL_ADD_ATI = 35171,
	GL_MUL_ATI = 35172,
	GL_SUB_ATI = 35173,
	GL_DOT3_ATI = 35174,
	GL_DOT4_ATI = 35175,
	GL_MAD_ATI = 35176,
	GL_LERP_ATI = 35177,
	GL_CND_ATI = 35178,
	GL_CND0_ATI = 35179,
	GL_DOT2_ADD_ATI = 35180,
	GL_SECONDARY_INTERPOLATOR_ATI = 35181,
	GL_NUM_FRAGMENT_REGISTERS_ATI = 35182,
	GL_NUM_FRAGMENT_CONSTANTS_ATI = 35183,
	GL_NUM_PASSES_ATI = 35184,
	GL_NUM_INSTRUCTIONS_PER_PASS_ATI = 35185,
	GL_NUM_INSTRUCTIONS_TOTAL_ATI = 35186,
	GL_NUM_INPUT_INTERPOLATOR_COMPONENTS_ATI = 35187,
	GL_NUM_LOOPBACK_COMPONENTS_ATI = 35188,
	GL_COLOR_ALPHA_PAIRING_ATI = 35189,
	GL_SWIZZLE_STR_ATI = 35190,
	GL_SWIZZLE_STQ_ATI = 35191,
	GL_SWIZZLE_STR_DR_ATI = 35192,
	GL_SWIZZLE_STQ_DQ_ATI = 35193,
	GL_SWIZZLE_STRQ_ATI = 35194,
	GL_SWIZZLE_STRQ_DQ_ATI = 35195,
	GL_RED_BIT_ATI = 1,
	GL_GREEN_BIT_ATI = 2,
	GL_BLUE_BIT_ATI = 4,
	GL_2X_BIT_ATI = 1,
	GL_4X_BIT_ATI = 2,
	GL_8X_BIT_ATI = 4,
	GL_HALF_BIT_ATI = 8,
	GL_QUARTER_BIT_ATI = 16,
	GL_EIGHTH_BIT_ATI = 32,
	GL_SATURATE_BIT_ATI = 64,
	GL_COMP_BIT_ATI = 2,
	GL_NEGATE_BIT_ATI = 4,
	GL_BIAS_BIT_ATI = 8,
	GL_ATI_map_object_buffer = 1,
	GL_ATI_meminfo = 1,
	GL_VBO_FREE_MEMORY_ATI = 34811,
	GL_TEXTURE_FREE_MEMORY_ATI = 34812,
	GL_RENDERBUFFER_FREE_MEMORY_ATI = 34813,
	GL_ATI_pixel_format_float = 1,
	GL_RGBA_FLOAT_MODE_ATI = 34848,
	GL_COLOR_CLEAR_UNCLAMPED_VALUE_ATI = 34869,
	GL_ATI_pn_triangles = 1,
	GL_PN_TRIANGLES_ATI = 34800,
	GL_MAX_PN_TRIANGLES_TESSELATION_LEVEL_ATI = 34801,
	GL_PN_TRIANGLES_POINT_MODE_ATI = 34802,
	GL_PN_TRIANGLES_NORMAL_MODE_ATI = 34803,
	GL_PN_TRIANGLES_TESSELATION_LEVEL_ATI = 34804,
	GL_PN_TRIANGLES_POINT_MODE_LINEAR_ATI = 34805,
	GL_PN_TRIANGLES_POINT_MODE_CUBIC_ATI = 34806,
	GL_PN_TRIANGLES_NORMAL_MODE_LINEAR_ATI = 34807,
	GL_PN_TRIANGLES_NORMAL_MODE_QUADRATIC_ATI = 34808,
	GL_ATI_separate_stencil = 1,
	GL_STENCIL_BACK_FUNC_ATI = 34816,
	GL_STENCIL_BACK_FAIL_ATI = 34817,
	GL_STENCIL_BACK_PASS_DEPTH_FAIL_ATI = 34818,
	GL_STENCIL_BACK_PASS_DEPTH_PASS_ATI = 34819,
	GL_ATI_text_fragment_shader = 1,
	GL_TEXT_FRAGMENT_SHADER_ATI = 33280,
	GL_ATI_texture_env_combine3 = 1,
	GL_MODULATE_ADD_ATI = 34628,
	GL_MODULATE_SIGNED_ADD_ATI = 34629,
	GL_MODULATE_SUBTRACT_ATI = 34630,
	GL_ATI_texture_float = 1,
	GL_RGBA_FLOAT32_ATI = 34836,
	GL_RGB_FLOAT32_ATI = 34837,
	GL_ALPHA_FLOAT32_ATI = 34838,
	GL_INTENSITY_FLOAT32_ATI = 34839,
	GL_LUMINANCE_FLOAT32_ATI = 34840,
	GL_LUMINANCE_ALPHA_FLOAT32_ATI = 34841,
	GL_RGBA_FLOAT16_ATI = 34842,
	GL_RGB_FLOAT16_ATI = 34843,
	GL_ALPHA_FLOAT16_ATI = 34844,
	GL_INTENSITY_FLOAT16_ATI = 34845,
	GL_LUMINANCE_FLOAT16_ATI = 34846,
	GL_LUMINANCE_ALPHA_FLOAT16_ATI = 34847,
	GL_ATI_texture_mirror_once = 1,
	GL_MIRROR_CLAMP_ATI = 34626,
	GL_MIRROR_CLAMP_TO_EDGE_ATI = 34627,
	GL_ATI_vertex_array_object = 1,
	GL_STATIC_ATI = 34656,
	GL_DYNAMIC_ATI = 34657,
	GL_PRESERVE_ATI = 34658,
	GL_DISCARD_ATI = 34659,
	GL_OBJECT_BUFFER_SIZE_ATI = 34660,
	GL_OBJECT_BUFFER_USAGE_ATI = 34661,
	GL_ARRAY_OBJECT_BUFFER_ATI = 34662,
	GL_ARRAY_OBJECT_OFFSET_ATI = 34663,
	GL_ATI_vertex_attrib_array_object = 1,
	GL_ATI_vertex_streams = 1,
	GL_MAX_VERTEX_STREAMS_ATI = 34667,
	GL_VERTEX_STREAM0_ATI = 34668,
	GL_VERTEX_STREAM1_ATI = 34669,
	GL_VERTEX_STREAM2_ATI = 34670,
	GL_VERTEX_STREAM3_ATI = 34671,
	GL_VERTEX_STREAM4_ATI = 34672,
	GL_VERTEX_STREAM5_ATI = 34673,
	GL_VERTEX_STREAM6_ATI = 34674,
	GL_VERTEX_STREAM7_ATI = 34675,
	GL_VERTEX_SOURCE_ATI = 34676,
	GL_EXT_422_pixels = 1,
	GL_422_EXT = 32972,
	GL_422_REV_EXT = 32973,
	GL_422_AVERAGE_EXT = 32974,
	GL_422_REV_AVERAGE_EXT = 32975,
	GL_EXT_EGL_image_storage = 1,
	GL_EXT_EGL_sync = 1,
	GL_EXT_abgr = 1,
	GL_ABGR_EXT = 32768,
	GL_EXT_bindable_uniform = 1,
	GL_MAX_VERTEX_BINDABLE_UNIFORMS_EXT = 36322,
	GL_MAX_FRAGMENT_BINDABLE_UNIFORMS_EXT = 36323,
	GL_MAX_GEOMETRY_BINDABLE_UNIFORMS_EXT = 36324,
	GL_MAX_BINDABLE_UNIFORM_SIZE_EXT = 36333,
	GL_UNIFORM_BUFFER_EXT = 36334,
	GL_UNIFORM_BUFFER_BINDING_EXT = 36335,
	GL_EXT_blend_color = 1,
	GL_CONSTANT_COLOR_EXT = 32769,
	GL_ONE_MINUS_CONSTANT_COLOR_EXT = 32770,
	GL_CONSTANT_ALPHA_EXT = 32771,
	GL_ONE_MINUS_CONSTANT_ALPHA_EXT = 32772,
	GL_BLEND_COLOR_EXT = 32773,
	GL_EXT_blend_equation_separate = 1,
	GL_BLEND_EQUATION_RGB_EXT = 32777,
	GL_BLEND_EQUATION_ALPHA_EXT = 34877,
	GL_EXT_blend_func_separate = 1,
	GL_BLEND_DST_RGB_EXT = 32968,
	GL_BLEND_SRC_RGB_EXT = 32969,
	GL_BLEND_DST_ALPHA_EXT = 32970,
	GL_BLEND_SRC_ALPHA_EXT = 32971,
	GL_EXT_blend_logic_op = 1,
	GL_EXT_blend_minmax = 1,
	GL_MIN_EXT = 32775,
	GL_MAX_EXT = 32776,
	GL_FUNC_ADD_EXT = 32774,
	GL_BLEND_EQUATION_EXT = 32777,
	GL_EXT_blend_subtract = 1,
	GL_FUNC_SUBTRACT_EXT = 32778,
	GL_FUNC_REVERSE_SUBTRACT_EXT = 32779,
	GL_EXT_clip_volume_hint = 1,
	GL_CLIP_VOLUME_CLIPPING_HINT_EXT = 33008,
	GL_EXT_cmyka = 1,
	GL_CMYK_EXT = 32780,
	GL_CMYKA_EXT = 32781,
	GL_PACK_CMYK_HINT_EXT = 32782,
	GL_UNPACK_CMYK_HINT_EXT = 32783,
	GL_EXT_color_subtable = 1,
	GL_EXT_compiled_vertex_array = 1,
	GL_ARRAY_ELEMENT_LOCK_FIRST_EXT = 33192,
	GL_ARRAY_ELEMENT_LOCK_COUNT_EXT = 33193,
	GL_EXT_convolution = 1,
	GL_CONVOLUTION_1D_EXT = 32784,
	GL_CONVOLUTION_2D_EXT = 32785,
	GL_SEPARABLE_2D_EXT = 32786,
	GL_CONVOLUTION_BORDER_MODE_EXT = 32787,
	GL_CONVOLUTION_FILTER_SCALE_EXT = 32788,
	GL_CONVOLUTION_FILTER_BIAS_EXT = 32789,
	GL_REDUCE_EXT = 32790,
	GL_CONVOLUTION_FORMAT_EXT = 32791,
	GL_CONVOLUTION_WIDTH_EXT = 32792,
	GL_CONVOLUTION_HEIGHT_EXT = 32793,
	GL_MAX_CONVOLUTION_WIDTH_EXT = 32794,
	GL_MAX_CONVOLUTION_HEIGHT_EXT = 32795,
	GL_POST_CONVOLUTION_RED_SCALE_EXT = 32796,
	GL_POST_CONVOLUTION_GREEN_SCALE_EXT = 32797,
	GL_POST_CONVOLUTION_BLUE_SCALE_EXT = 32798,
	GL_POST_CONVOLUTION_ALPHA_SCALE_EXT = 32799,
	GL_POST_CONVOLUTION_RED_BIAS_EXT = 32800,
	GL_POST_CONVOLUTION_GREEN_BIAS_EXT = 32801,
	GL_POST_CONVOLUTION_BLUE_BIAS_EXT = 32802,
	GL_POST_CONVOLUTION_ALPHA_BIAS_EXT = 32803,
	GL_EXT_coordinate_frame = 1,
	GL_TANGENT_ARRAY_EXT = 33849,
	GL_BINORMAL_ARRAY_EXT = 33850,
	GL_CURRENT_TANGENT_EXT = 33851,
	GL_CURRENT_BINORMAL_EXT = 33852,
	GL_TANGENT_ARRAY_TYPE_EXT = 33854,
	GL_TANGENT_ARRAY_STRIDE_EXT = 33855,
	GL_BINORMAL_ARRAY_TYPE_EXT = 33856,
	GL_BINORMAL_ARRAY_STRIDE_EXT = 33857,
	GL_TANGENT_ARRAY_POINTER_EXT = 33858,
	GL_BINORMAL_ARRAY_POINTER_EXT = 33859,
	GL_MAP1_TANGENT_EXT = 33860,
	GL_MAP2_TANGENT_EXT = 33861,
	GL_MAP1_BINORMAL_EXT = 33862,
	GL_MAP2_BINORMAL_EXT = 33863,
	GL_EXT_copy_texture = 1,
	GL_EXT_cull_vertex = 1,
	GL_CULL_VERTEX_EXT = 33194,
	GL_CULL_VERTEX_EYE_POSITION_EXT = 33195,
	GL_CULL_VERTEX_OBJECT_POSITION_EXT = 33196,
	GL_EXT_debug_label = 1,
	GL_PROGRAM_PIPELINE_OBJECT_EXT = 35407,
	GL_PROGRAM_OBJECT_EXT = 35648,
	GL_SHADER_OBJECT_EXT = 35656,
	GL_BUFFER_OBJECT_EXT = 37201,
	GL_QUERY_OBJECT_EXT = 37203,
	GL_VERTEX_ARRAY_OBJECT_EXT = 37204,
	GL_EXT_debug_marker = 1,
	GL_EXT_depth_bounds_test = 1,
	GL_DEPTH_BOUNDS_TEST_EXT = 34960,
	GL_DEPTH_BOUNDS_EXT = 34961,
	GL_EXT_direct_state_access = 1,
	GL_PROGRAM_MATRIX_EXT = 36397,
	GL_TRANSPOSE_PROGRAM_MATRIX_EXT = 36398,
	GL_PROGRAM_MATRIX_STACK_DEPTH_EXT = 36399,
	GL_EXT_draw_buffers2 = 1,
	GL_EXT_draw_instanced = 1,
	GL_EXT_draw_range_elements = 1,
	GL_MAX_ELEMENTS_VERTICES_EXT = 33000,
	GL_MAX_ELEMENTS_INDICES_EXT = 33001,
	GL_EXT_external_buffer = 1,
	GL_EXT_fog_coord = 1,
	GL_FOG_COORDINATE_SOURCE_EXT = 33872,
	GL_FOG_COORDINATE_EXT = 33873,
	GL_FRAGMENT_DEPTH_EXT = 33874,
	GL_CURRENT_FOG_COORDINATE_EXT = 33875,
	GL_FOG_COORDINATE_ARRAY_TYPE_EXT = 33876,
	GL_FOG_COORDINATE_ARRAY_STRIDE_EXT = 33877,
	GL_FOG_COORDINATE_ARRAY_POINTER_EXT = 33878,
	GL_FOG_COORDINATE_ARRAY_EXT = 33879,
	GL_EXT_framebuffer_blit = 1,
	GL_READ_FRAMEBUFFER_EXT = 36008,
	GL_DRAW_FRAMEBUFFER_EXT = 36009,
	GL_DRAW_FRAMEBUFFER_BINDING_EXT = 36006,
	GL_READ_FRAMEBUFFER_BINDING_EXT = 36010,
	GL_EXT_framebuffer_multisample = 1,
	GL_RENDERBUFFER_SAMPLES_EXT = 36011,
	GL_FRAMEBUFFER_INCOMPLETE_MULTISAMPLE_EXT = 36182,
	GL_MAX_SAMPLES_EXT = 36183,
	GL_EXT_framebuffer_multisample_blit_scaled = 1,
	GL_SCALED_RESOLVE_FASTEST_EXT = 37050,
	GL_SCALED_RESOLVE_NICEST_EXT = 37051,
	GL_EXT_framebuffer_object = 1,
	GL_INVALID_FRAMEBUFFER_OPERATION_EXT = 1286,
	GL_MAX_RENDERBUFFER_SIZE_EXT = 34024,
	GL_FRAMEBUFFER_BINDING_EXT = 36006,
	GL_RENDERBUFFER_BINDING_EXT = 36007,
	GL_FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE_EXT = 36048,
	GL_FRAMEBUFFER_ATTACHMENT_OBJECT_NAME_EXT = 36049,
	GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LEVEL_EXT = 36050,
	GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_CUBE_MAP_FACE_EXT = 36051,
	GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_3D_ZOFFSET_EXT = 36052,
	GL_FRAMEBUFFER_COMPLETE_EXT = 36053,
	GL_FRAMEBUFFER_INCOMPLETE_ATTACHMENT_EXT = 36054,
	GL_FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT_EXT = 36055,
	GL_FRAMEBUFFER_INCOMPLETE_DIMENSIONS_EXT = 36057,
	GL_FRAMEBUFFER_INCOMPLETE_FORMATS_EXT = 36058,
	GL_FRAMEBUFFER_INCOMPLETE_DRAW_BUFFER_EXT = 36059,
	GL_FRAMEBUFFER_INCOMPLETE_READ_BUFFER_EXT = 36060,
	GL_FRAMEBUFFER_UNSUPPORTED_EXT = 36061,
	GL_MAX_COLOR_ATTACHMENTS_EXT = 36063,
	GL_COLOR_ATTACHMENT0_EXT = 36064,
	GL_COLOR_ATTACHMENT1_EXT = 36065,
	GL_COLOR_ATTACHMENT2_EXT = 36066,
	GL_COLOR_ATTACHMENT3_EXT = 36067,
	GL_COLOR_ATTACHMENT4_EXT = 36068,
	GL_COLOR_ATTACHMENT5_EXT = 36069,
	GL_COLOR_ATTACHMENT6_EXT = 36070,
	GL_COLOR_ATTACHMENT7_EXT = 36071,
	GL_COLOR_ATTACHMENT8_EXT = 36072,
	GL_COLOR_ATTACHMENT9_EXT = 36073,
	GL_COLOR_ATTACHMENT10_EXT = 36074,
	GL_COLOR_ATTACHMENT11_EXT = 36075,
	GL_COLOR_ATTACHMENT12_EXT = 36076,
	GL_COLOR_ATTACHMENT13_EXT = 36077,
	GL_COLOR_ATTACHMENT14_EXT = 36078,
	GL_COLOR_ATTACHMENT15_EXT = 36079,
	GL_DEPTH_ATTACHMENT_EXT = 36096,
	GL_STENCIL_ATTACHMENT_EXT = 36128,
	GL_FRAMEBUFFER_EXT = 36160,
	GL_RENDERBUFFER_EXT = 36161,
	GL_RENDERBUFFER_WIDTH_EXT = 36162,
	GL_RENDERBUFFER_HEIGHT_EXT = 36163,
	GL_RENDERBUFFER_INTERNAL_FORMAT_EXT = 36164,
	GL_STENCIL_INDEX1_EXT = 36166,
	GL_STENCIL_INDEX4_EXT = 36167,
	GL_STENCIL_INDEX8_EXT = 36168,
	GL_STENCIL_INDEX16_EXT = 36169,
	GL_RENDERBUFFER_RED_SIZE_EXT = 36176,
	GL_RENDERBUFFER_GREEN_SIZE_EXT = 36177,
	GL_RENDERBUFFER_BLUE_SIZE_EXT = 36178,
	GL_RENDERBUFFER_ALPHA_SIZE_EXT = 36179,
	GL_RENDERBUFFER_DEPTH_SIZE_EXT = 36180,
	GL_RENDERBUFFER_STENCIL_SIZE_EXT = 36181,
	GL_EXT_framebuffer_sRGB = 1,
	GL_FRAMEBUFFER_SRGB_EXT = 36281,
	GL_FRAMEBUFFER_SRGB_CAPABLE_EXT = 36282,
	GL_EXT_geometry_shader4 = 1,
	GL_GEOMETRY_SHADER_EXT = 36313,
	GL_GEOMETRY_VERTICES_OUT_EXT = 36314,
	GL_GEOMETRY_INPUT_TYPE_EXT = 36315,
	GL_GEOMETRY_OUTPUT_TYPE_EXT = 36316,
	GL_MAX_GEOMETRY_TEXTURE_IMAGE_UNITS_EXT = 35881,
	GL_MAX_GEOMETRY_VARYING_COMPONENTS_EXT = 36317,
	GL_MAX_VERTEX_VARYING_COMPONENTS_EXT = 36318,
	GL_MAX_VARYING_COMPONENTS_EXT = 35659,
	GL_MAX_GEOMETRY_UNIFORM_COMPONENTS_EXT = 36319,
	GL_MAX_GEOMETRY_OUTPUT_VERTICES_EXT = 36320,
	GL_MAX_GEOMETRY_TOTAL_OUTPUT_COMPONENTS_EXT = 36321,
	GL_LINES_ADJACENCY_EXT = 10,
	GL_LINE_STRIP_ADJACENCY_EXT = 11,
	GL_TRIANGLES_ADJACENCY_EXT = 12,
	GL_TRIANGLE_STRIP_ADJACENCY_EXT = 13,
	GL_FRAMEBUFFER_INCOMPLETE_LAYER_TARGETS_EXT = 36264,
	GL_FRAMEBUFFER_INCOMPLETE_LAYER_COUNT_EXT = 36265,
	GL_FRAMEBUFFER_ATTACHMENT_LAYERED_EXT = 36263,
	GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LAYER_EXT = 36052,
	GL_PROGRAM_POINT_SIZE_EXT = 34370,
	GL_EXT_gpu_program_parameters = 1,
	GL_EXT_gpu_shader4 = 1,
	GL_VERTEX_ATTRIB_ARRAY_INTEGER_EXT = 35069,
	GL_SAMPLER_1D_ARRAY_EXT = 36288,
	GL_SAMPLER_2D_ARRAY_EXT = 36289,
	GL_SAMPLER_BUFFER_EXT = 36290,
	GL_SAMPLER_1D_ARRAY_SHADOW_EXT = 36291,
	GL_SAMPLER_2D_ARRAY_SHADOW_EXT = 36292,
	GL_SAMPLER_CUBE_SHADOW_EXT = 36293,
	GL_UNSIGNED_INT_VEC2_EXT = 36294,
	GL_UNSIGNED_INT_VEC3_EXT = 36295,
	GL_UNSIGNED_INT_VEC4_EXT = 36296,
	GL_INT_SAMPLER_1D_EXT = 36297,
	GL_INT_SAMPLER_2D_EXT = 36298,
	GL_INT_SAMPLER_3D_EXT = 36299,
	GL_INT_SAMPLER_CUBE_EXT = 36300,
	GL_INT_SAMPLER_2D_RECT_EXT = 36301,
	GL_INT_SAMPLER_1D_ARRAY_EXT = 36302,
	GL_INT_SAMPLER_2D_ARRAY_EXT = 36303,
	GL_INT_SAMPLER_BUFFER_EXT = 36304,
	GL_UNSIGNED_INT_SAMPLER_1D_EXT = 36305,
	GL_UNSIGNED_INT_SAMPLER_2D_EXT = 36306,
	GL_UNSIGNED_INT_SAMPLER_3D_EXT = 36307,
	GL_UNSIGNED_INT_SAMPLER_CUBE_EXT = 36308,
	GL_UNSIGNED_INT_SAMPLER_2D_RECT_EXT = 36309,
	GL_UNSIGNED_INT_SAMPLER_1D_ARRAY_EXT = 36310,
	GL_UNSIGNED_INT_SAMPLER_2D_ARRAY_EXT = 36311,
	GL_UNSIGNED_INT_SAMPLER_BUFFER_EXT = 36312,
	GL_MIN_PROGRAM_TEXEL_OFFSET_EXT = 35076,
	GL_MAX_PROGRAM_TEXEL_OFFSET_EXT = 35077,
	GL_EXT_histogram = 1,
	GL_HISTOGRAM_EXT = 32804,
	GL_PROXY_HISTOGRAM_EXT = 32805,
	GL_HISTOGRAM_WIDTH_EXT = 32806,
	GL_HISTOGRAM_FORMAT_EXT = 32807,
	GL_HISTOGRAM_RED_SIZE_EXT = 32808,
	GL_HISTOGRAM_GREEN_SIZE_EXT = 32809,
	GL_HISTOGRAM_BLUE_SIZE_EXT = 32810,
	GL_HISTOGRAM_ALPHA_SIZE_EXT = 32811,
	GL_HISTOGRAM_LUMINANCE_SIZE_EXT = 32812,
	GL_HISTOGRAM_SINK_EXT = 32813,
	GL_MINMAX_EXT = 32814,
	GL_MINMAX_FORMAT_EXT = 32815,
	GL_MINMAX_SINK_EXT = 32816,
	GL_TABLE_TOO_LARGE_EXT = 32817,
	GL_EXT_index_array_formats = 1,
	GL_IUI_V2F_EXT = 33197,
	GL_IUI_V3F_EXT = 33198,
	GL_IUI_N3F_V2F_EXT = 33199,
	GL_IUI_N3F_V3F_EXT = 33200,
	GL_T2F_IUI_V2F_EXT = 33201,
	GL_T2F_IUI_V3F_EXT = 33202,
	GL_T2F_IUI_N3F_V2F_EXT = 33203,
	GL_T2F_IUI_N3F_V3F_EXT = 33204,
	GL_EXT_index_func = 1,
	GL_INDEX_TEST_EXT = 33205,
	GL_INDEX_TEST_FUNC_EXT = 33206,
	GL_INDEX_TEST_REF_EXT = 33207,
	GL_EXT_index_material = 1,
	GL_INDEX_MATERIAL_EXT = 33208,
	GL_INDEX_MATERIAL_PARAMETER_EXT = 33209,
	GL_INDEX_MATERIAL_FACE_EXT = 33210,
	GL_EXT_index_texture = 1,
	GL_EXT_light_texture = 1,
	GL_FRAGMENT_MATERIAL_EXT = 33609,
	GL_FRAGMENT_NORMAL_EXT = 33610,
	GL_FRAGMENT_COLOR_EXT = 33612,
	GL_ATTENUATION_EXT = 33613,
	GL_SHADOW_ATTENUATION_EXT = 33614,
	GL_TEXTURE_APPLICATION_MODE_EXT = 33615,
	GL_TEXTURE_LIGHT_EXT = 33616,
	GL_TEXTURE_MATERIAL_FACE_EXT = 33617,
	GL_TEXTURE_MATERIAL_PARAMETER_EXT = 33618,
	GL_EXT_memory_object = 1,
	GL_TEXTURE_TILING_EXT = 38272,
	GL_DEDICATED_MEMORY_OBJECT_EXT = 38273,
	GL_PROTECTED_MEMORY_OBJECT_EXT = 38299,
	GL_NUM_TILING_TYPES_EXT = 38274,
	GL_TILING_TYPES_EXT = 38275,
	GL_OPTIMAL_TILING_EXT = 38276,
	GL_LINEAR_TILING_EXT = 38277,
	GL_NUM_DEVICE_UUIDS_EXT = 38294,
	GL_DEVICE_UUID_EXT = 38295,
	GL_DRIVER_UUID_EXT = 38296,
	GL_UUID_SIZE_EXT = 16,
	GL_EXT_memory_object_fd = 1,
	GL_HANDLE_TYPE_OPAQUE_FD_EXT = 38278,
	GL_EXT_memory_object_win32 = 1,
	GL_HANDLE_TYPE_OPAQUE_WIN32_EXT = 38279,
	GL_HANDLE_TYPE_OPAQUE_WIN32_KMT_EXT = 38280,
	GL_DEVICE_LUID_EXT = 38297,
	GL_DEVICE_NODE_MASK_EXT = 38298,
	GL_LUID_SIZE_EXT = 8,
	GL_HANDLE_TYPE_D3D12_TILEPOOL_EXT = 38281,
	GL_HANDLE_TYPE_D3D12_RESOURCE_EXT = 38282,
	GL_HANDLE_TYPE_D3D11_IMAGE_EXT = 38283,
	GL_HANDLE_TYPE_D3D11_IMAGE_KMT_EXT = 38284,
	GL_EXT_misc_attribute = 1,
	GL_EXT_multi_draw_arrays = 1,
	GL_EXT_multisample = 1,
	GL_MULTISAMPLE_EXT = 32925,
	GL_SAMPLE_ALPHA_TO_MASK_EXT = 32926,
	GL_SAMPLE_ALPHA_TO_ONE_EXT = 32927,
	GL_SAMPLE_MASK_EXT = 32928,
	GL_1PASS_EXT = 32929,
	GL_2PASS_0_EXT = 32930,
	GL_2PASS_1_EXT = 32931,
	GL_4PASS_0_EXT = 32932,
	GL_4PASS_1_EXT = 32933,
	GL_4PASS_2_EXT = 32934,
	GL_4PASS_3_EXT = 32935,
	GL_SAMPLE_BUFFERS_EXT = 32936,
	GL_SAMPLES_EXT = 32937,
	GL_SAMPLE_MASK_VALUE_EXT = 32938,
	GL_SAMPLE_MASK_INVERT_EXT = 32939,
	GL_SAMPLE_PATTERN_EXT = 32940,
	GL_MULTISAMPLE_BIT_EXT = 536870912,
	GL_EXT_multiview_tessellation_geometry_shader = 1,
	GL_EXT_multiview_texture_multisample = 1,
	GL_EXT_multiview_timer_query = 1,
	GL_EXT_packed_depth_stencil = 1,
	GL_DEPTH_STENCIL_EXT = 34041,
	GL_UNSIGNED_INT_24_8_EXT = 34042,
	GL_DEPTH24_STENCIL8_EXT = 35056,
	GL_TEXTURE_STENCIL_SIZE_EXT = 35057,
	GL_EXT_packed_float = 1,
	GL_R11F_G11F_B10F_EXT = 35898,
	GL_UNSIGNED_INT_10F_11F_11F_REV_EXT = 35899,
	GL_RGBA_SIGNED_COMPONENTS_EXT = 35900,
	GL_EXT_packed_pixels = 1,
	GL_UNSIGNED_BYTE_3_3_2_EXT = 32818,
	GL_UNSIGNED_SHORT_4_4_4_4_EXT = 32819,
	GL_UNSIGNED_SHORT_5_5_5_1_EXT = 32820,
	GL_UNSIGNED_INT_8_8_8_8_EXT = 32821,
	GL_UNSIGNED_INT_10_10_10_2_EXT = 32822,
	GL_EXT_pixel_buffer_object = 1,
	GL_PIXEL_PACK_BUFFER_EXT = 35051,
	GL_PIXEL_UNPACK_BUFFER_EXT = 35052,
	GL_PIXEL_PACK_BUFFER_BINDING_EXT = 35053,
	GL_PIXEL_UNPACK_BUFFER_BINDING_EXT = 35055,
	GL_EXT_pixel_transform = 1,
	GL_PIXEL_TRANSFORM_2D_EXT = 33584,
	GL_PIXEL_MAG_FILTER_EXT = 33585,
	GL_PIXEL_MIN_FILTER_EXT = 33586,
	GL_PIXEL_CUBIC_WEIGHT_EXT = 33587,
	GL_CUBIC_EXT = 33588,
	GL_AVERAGE_EXT = 33589,
	GL_PIXEL_TRANSFORM_2D_STACK_DEPTH_EXT = 33590,
	GL_MAX_PIXEL_TRANSFORM_2D_STACK_DEPTH_EXT = 33591,
	GL_PIXEL_TRANSFORM_2D_MATRIX_EXT = 33592,
	GL_EXT_pixel_transform_color_table = 1,
	GL_EXT_point_parameters = 1,
	GL_POINT_SIZE_MIN_EXT = 33062,
	GL_POINT_SIZE_MAX_EXT = 33063,
	GL_POINT_FADE_THRESHOLD_SIZE_EXT = 33064,
	GL_DISTANCE_ATTENUATION_EXT = 33065,
	GL_EXT_polygon_offset = 1,
	GL_POLYGON_OFFSET_EXT = 32823,
	GL_POLYGON_OFFSET_FACTOR_EXT = 32824,
	GL_POLYGON_OFFSET_BIAS_EXT = 32825,
	GL_EXT_polygon_offset_clamp = 1,
	GL_POLYGON_OFFSET_CLAMP_EXT = 36379,
	GL_EXT_post_depth_coverage = 1,
	GL_EXT_provoking_vertex = 1,
	GL_QUADS_FOLLOW_PROVOKING_VERTEX_CONVENTION_EXT = 36428,
	GL_FIRST_VERTEX_CONVENTION_EXT = 36429,
	GL_LAST_VERTEX_CONVENTION_EXT = 36430,
	GL_PROVOKING_VERTEX_EXT = 36431,
	GL_EXT_raster_multisample = 1,
	GL_RASTER_MULTISAMPLE_EXT = 37671,
	GL_RASTER_SAMPLES_EXT = 37672,
	GL_MAX_RASTER_SAMPLES_EXT = 37673,
	GL_RASTER_FIXED_SAMPLE_LOCATIONS_EXT = 37674,
	GL_MULTISAMPLE_RASTERIZATION_ALLOWED_EXT = 37675,
	GL_EFFECTIVE_RASTER_SAMPLES_EXT = 37676,
	GL_EXT_rescale_normal = 1,
	GL_RESCALE_NORMAL_EXT = 32826,
	GL_EXT_secondary_color = 1,
	GL_COLOR_SUM_EXT = 33880,
	GL_CURRENT_SECONDARY_COLOR_EXT = 33881,
	GL_SECONDARY_COLOR_ARRAY_SIZE_EXT = 33882,
	GL_SECONDARY_COLOR_ARRAY_TYPE_EXT = 33883,
	GL_SECONDARY_COLOR_ARRAY_STRIDE_EXT = 33884,
	GL_SECONDARY_COLOR_ARRAY_POINTER_EXT = 33885,
	GL_SECONDARY_COLOR_ARRAY_EXT = 33886,
	GL_EXT_semaphore = 1,
	GL_LAYOUT_GENERAL_EXT = 38285,
	GL_LAYOUT_COLOR_ATTACHMENT_EXT = 38286,
	GL_LAYOUT_DEPTH_STENCIL_ATTACHMENT_EXT = 38287,
	GL_LAYOUT_DEPTH_STENCIL_READ_ONLY_EXT = 38288,
	GL_LAYOUT_SHADER_READ_ONLY_EXT = 38289,
	GL_LAYOUT_TRANSFER_SRC_EXT = 38290,
	GL_LAYOUT_TRANSFER_DST_EXT = 38291,
	GL_LAYOUT_DEPTH_READ_ONLY_STENCIL_ATTACHMENT_EXT = 38192,
	GL_LAYOUT_DEPTH_ATTACHMENT_STENCIL_READ_ONLY_EXT = 38193,
	GL_EXT_semaphore_fd = 1,
	GL_EXT_semaphore_win32 = 1,
	GL_HANDLE_TYPE_D3D12_FENCE_EXT = 38292,
	GL_D3D12_FENCE_VALUE_EXT = 38293,
	GL_EXT_separate_shader_objects = 1,
	GL_ACTIVE_PROGRAM_EXT = 35725,
	GL_EXT_separate_specular_color = 1,
	GL_LIGHT_MODEL_COLOR_CONTROL_EXT = 33272,
	GL_SINGLE_COLOR_EXT = 33273,
	GL_SEPARATE_SPECULAR_COLOR_EXT = 33274,
	GL_EXT_shader_framebuffer_fetch = 1,
	GL_FRAGMENT_SHADER_DISCARDS_SAMPLES_EXT = 35410,
	GL_EXT_shader_framebuffer_fetch_non_coherent = 1,
	GL_EXT_shader_image_load_formatted = 1,
	GL_EXT_shader_image_load_store = 1,
	GL_MAX_IMAGE_UNITS_EXT = 36664,
	GL_MAX_COMBINED_IMAGE_UNITS_AND_FRAGMENT_OUTPUTS_EXT = 36665,
	GL_IMAGE_BINDING_NAME_EXT = 36666,
	GL_IMAGE_BINDING_LEVEL_EXT = 36667,
	GL_IMAGE_BINDING_LAYERED_EXT = 36668,
	GL_IMAGE_BINDING_LAYER_EXT = 36669,
	GL_IMAGE_BINDING_ACCESS_EXT = 36670,
	GL_IMAGE_1D_EXT = 36940,
	GL_IMAGE_2D_EXT = 36941,
	GL_IMAGE_3D_EXT = 36942,
	GL_IMAGE_2D_RECT_EXT = 36943,
	GL_IMAGE_CUBE_EXT = 36944,
	GL_IMAGE_BUFFER_EXT = 36945,
	GL_IMAGE_1D_ARRAY_EXT = 36946,
	GL_IMAGE_2D_ARRAY_EXT = 36947,
	GL_IMAGE_CUBE_MAP_ARRAY_EXT = 36948,
	GL_IMAGE_2D_MULTISAMPLE_EXT = 36949,
	GL_IMAGE_2D_MULTISAMPLE_ARRAY_EXT = 36950,
	GL_INT_IMAGE_1D_EXT = 36951,
	GL_INT_IMAGE_2D_EXT = 36952,
	GL_INT_IMAGE_3D_EXT = 36953,
	GL_INT_IMAGE_2D_RECT_EXT = 36954,
	GL_INT_IMAGE_CUBE_EXT = 36955,
	GL_INT_IMAGE_BUFFER_EXT = 36956,
	GL_INT_IMAGE_1D_ARRAY_EXT = 36957,
	GL_INT_IMAGE_2D_ARRAY_EXT = 36958,
	GL_INT_IMAGE_CUBE_MAP_ARRAY_EXT = 36959,
	GL_INT_IMAGE_2D_MULTISAMPLE_EXT = 36960,
	GL_INT_IMAGE_2D_MULTISAMPLE_ARRAY_EXT = 36961,
	GL_UNSIGNED_INT_IMAGE_1D_EXT = 36962,
	GL_UNSIGNED_INT_IMAGE_2D_EXT = 36963,
	GL_UNSIGNED_INT_IMAGE_3D_EXT = 36964,
	GL_UNSIGNED_INT_IMAGE_2D_RECT_EXT = 36965,
	GL_UNSIGNED_INT_IMAGE_CUBE_EXT = 36966,
	GL_UNSIGNED_INT_IMAGE_BUFFER_EXT = 36967,
	GL_UNSIGNED_INT_IMAGE_1D_ARRAY_EXT = 36968,
	GL_UNSIGNED_INT_IMAGE_2D_ARRAY_EXT = 36969,
	GL_UNSIGNED_INT_IMAGE_CUBE_MAP_ARRAY_EXT = 36970,
	GL_UNSIGNED_INT_IMAGE_2D_MULTISAMPLE_EXT = 36971,
	GL_UNSIGNED_INT_IMAGE_2D_MULTISAMPLE_ARRAY_EXT = 36972,
	GL_MAX_IMAGE_SAMPLES_EXT = 36973,
	GL_IMAGE_BINDING_FORMAT_EXT = 36974,
	GL_VERTEX_ATTRIB_ARRAY_BARRIER_BIT_EXT = 1,
	GL_ELEMENT_ARRAY_BARRIER_BIT_EXT = 2,
	GL_UNIFORM_BARRIER_BIT_EXT = 4,
	GL_TEXTURE_FETCH_BARRIER_BIT_EXT = 8,
	GL_SHADER_IMAGE_ACCESS_BARRIER_BIT_EXT = 32,
	GL_COMMAND_BARRIER_BIT_EXT = 64,
	GL_PIXEL_BUFFER_BARRIER_BIT_EXT = 128,
	GL_TEXTURE_UPDATE_BARRIER_BIT_EXT = 256,
	GL_BUFFER_UPDATE_BARRIER_BIT_EXT = 512,
	GL_FRAMEBUFFER_BARRIER_BIT_EXT = 1024,
	GL_TRANSFORM_FEEDBACK_BARRIER_BIT_EXT = 2048,
	GL_ATOMIC_COUNTER_BARRIER_BIT_EXT = 4096,
	GL_ALL_BARRIER_BITS_EXT = 4294967295,
	GL_EXT_shader_integer_mix = 1,
	GL_EXT_shadow_funcs = 1,
	GL_EXT_shared_texture_palette = 1,
	GL_SHARED_TEXTURE_PALETTE_EXT = 33275,
	GL_EXT_sparse_texture2 = 1,
	GL_EXT_stencil_clear_tag = 1,
	GL_STENCIL_TAG_BITS_EXT = 35058,
	GL_STENCIL_CLEAR_TAG_VALUE_EXT = 35059,
	GL_EXT_stencil_two_side = 1,
	GL_STENCIL_TEST_TWO_SIDE_EXT = 35088,
	GL_ACTIVE_STENCIL_FACE_EXT = 35089,
	GL_EXT_stencil_wrap = 1,
	GL_INCR_WRAP_EXT = 34055,
	GL_DECR_WRAP_EXT = 34056,
	GL_EXT_subtexture = 1,
	GL_EXT_texture = 1,
	GL_ALPHA4_EXT = 32827,
	GL_ALPHA8_EXT = 32828,
	GL_ALPHA12_EXT = 32829,
	GL_ALPHA16_EXT = 32830,
	GL_LUMINANCE4_EXT = 32831,
	GL_LUMINANCE8_EXT = 32832,
	GL_LUMINANCE12_EXT = 32833,
	GL_LUMINANCE16_EXT = 32834,
	GL_LUMINANCE4_ALPHA4_EXT = 32835,
	GL_LUMINANCE6_ALPHA2_EXT = 32836,
	GL_LUMINANCE8_ALPHA8_EXT = 32837,
	GL_LUMINANCE12_ALPHA4_EXT = 32838,
	GL_LUMINANCE12_ALPHA12_EXT = 32839,
	GL_LUMINANCE16_ALPHA16_EXT = 32840,
	GL_INTENSITY_EXT = 32841,
	GL_INTENSITY4_EXT = 32842,
	GL_INTENSITY8_EXT = 32843,
	GL_INTENSITY12_EXT = 32844,
	GL_INTENSITY16_EXT = 32845,
	GL_RGB2_EXT = 32846,
	GL_RGB4_EXT = 32847,
	GL_RGB5_EXT = 32848,
	GL_RGB8_EXT = 32849,
	GL_RGB10_EXT = 32850,
	GL_RGB12_EXT = 32851,
	GL_RGB16_EXT = 32852,
	GL_RGBA2_EXT = 32853,
	GL_RGBA4_EXT = 32854,
	GL_RGB5_A1_EXT = 32855,
	GL_RGBA8_EXT = 32856,
	GL_RGB10_A2_EXT = 32857,
	GL_RGBA12_EXT = 32858,
	GL_RGBA16_EXT = 32859,
	GL_TEXTURE_RED_SIZE_EXT = 32860,
	GL_TEXTURE_GREEN_SIZE_EXT = 32861,
	GL_TEXTURE_BLUE_SIZE_EXT = 32862,
	GL_TEXTURE_ALPHA_SIZE_EXT = 32863,
	GL_TEXTURE_LUMINANCE_SIZE_EXT = 32864,
	GL_TEXTURE_INTENSITY_SIZE_EXT = 32865,
	GL_REPLACE_EXT = 32866,
	GL_PROXY_TEXTURE_1D_EXT = 32867,
	GL_PROXY_TEXTURE_2D_EXT = 32868,
	GL_TEXTURE_TOO_LARGE_EXT = 32869,
	GL_EXT_texture3D = 1,
	GL_PACK_SKIP_IMAGES_EXT = 32875,
	GL_PACK_IMAGE_HEIGHT_EXT = 32876,
	GL_UNPACK_SKIP_IMAGES_EXT = 32877,
	GL_UNPACK_IMAGE_HEIGHT_EXT = 32878,
	GL_TEXTURE_3D_EXT = 32879,
	GL_PROXY_TEXTURE_3D_EXT = 32880,
	GL_TEXTURE_DEPTH_EXT = 32881,
	GL_TEXTURE_WRAP_R_EXT = 32882,
	GL_MAX_3D_TEXTURE_SIZE_EXT = 32883,
	GL_EXT_texture_array = 1,
	GL_TEXTURE_1D_ARRAY_EXT = 35864,
	GL_PROXY_TEXTURE_1D_ARRAY_EXT = 35865,
	GL_TEXTURE_2D_ARRAY_EXT = 35866,
	GL_PROXY_TEXTURE_2D_ARRAY_EXT = 35867,
	GL_TEXTURE_BINDING_1D_ARRAY_EXT = 35868,
	GL_TEXTURE_BINDING_2D_ARRAY_EXT = 35869,
	GL_MAX_ARRAY_TEXTURE_LAYERS_EXT = 35071,
	GL_COMPARE_REF_DEPTH_TO_TEXTURE_EXT = 34894,
	GL_EXT_texture_buffer_object = 1,
	GL_TEXTURE_BUFFER_EXT = 35882,
	GL_MAX_TEXTURE_BUFFER_SIZE_EXT = 35883,
	GL_TEXTURE_BINDING_BUFFER_EXT = 35884,
	GL_TEXTURE_BUFFER_DATA_STORE_BINDING_EXT = 35885,
	GL_TEXTURE_BUFFER_FORMAT_EXT = 35886,
	GL_EXT_texture_compression_latc = 1,
	GL_COMPRESSED_LUMINANCE_LATC1_EXT = 35952,
	GL_COMPRESSED_SIGNED_LUMINANCE_LATC1_EXT = 35953,
	GL_COMPRESSED_LUMINANCE_ALPHA_LATC2_EXT = 35954,
	GL_COMPRESSED_SIGNED_LUMINANCE_ALPHA_LATC2_EXT = 35955,
	GL_EXT_texture_compression_rgtc = 1,
	GL_COMPRESSED_RED_RGTC1_EXT = 36283,
	GL_COMPRESSED_SIGNED_RED_RGTC1_EXT = 36284,
	GL_COMPRESSED_RED_GREEN_RGTC2_EXT = 36285,
	GL_COMPRESSED_SIGNED_RED_GREEN_RGTC2_EXT = 36286,
	GL_EXT_texture_compression_s3tc = 1,
	GL_COMPRESSED_RGB_S3TC_DXT1_EXT = 33776,
	GL_COMPRESSED_RGBA_S3TC_DXT1_EXT = 33777,
	GL_COMPRESSED_RGBA_S3TC_DXT3_EXT = 33778,
	GL_COMPRESSED_RGBA_S3TC_DXT5_EXT = 33779,
	GL_EXT_texture_cube_map = 1,
	GL_NORMAL_MAP_EXT = 34065,
	GL_REFLECTION_MAP_EXT = 34066,
	GL_TEXTURE_CUBE_MAP_EXT = 34067,
	GL_TEXTURE_BINDING_CUBE_MAP_EXT = 34068,
	GL_TEXTURE_CUBE_MAP_POSITIVE_X_EXT = 34069,
	GL_TEXTURE_CUBE_MAP_NEGATIVE_X_EXT = 34070,
	GL_TEXTURE_CUBE_MAP_POSITIVE_Y_EXT = 34071,
	GL_TEXTURE_CUBE_MAP_NEGATIVE_Y_EXT = 34072,
	GL_TEXTURE_CUBE_MAP_POSITIVE_Z_EXT = 34073,
	GL_TEXTURE_CUBE_MAP_NEGATIVE_Z_EXT = 34074,
	GL_PROXY_TEXTURE_CUBE_MAP_EXT = 34075,
	GL_MAX_CUBE_MAP_TEXTURE_SIZE_EXT = 34076,
	GL_EXT_texture_env_add = 1,
	GL_EXT_texture_env_combine = 1,
	GL_COMBINE_EXT = 34160,
	GL_COMBINE_RGB_EXT = 34161,
	GL_COMBINE_ALPHA_EXT = 34162,
	GL_RGB_SCALE_EXT = 34163,
	GL_ADD_SIGNED_EXT = 34164,
	GL_INTERPOLATE_EXT = 34165,
	GL_CONSTANT_EXT = 34166,
	GL_PRIMARY_COLOR_EXT = 34167,
	GL_PREVIOUS_EXT = 34168,
	GL_SOURCE0_RGB_EXT = 34176,
	GL_SOURCE1_RGB_EXT = 34177,
	GL_SOURCE2_RGB_EXT = 34178,
	GL_SOURCE0_ALPHA_EXT = 34184,
	GL_SOURCE1_ALPHA_EXT = 34185,
	GL_SOURCE2_ALPHA_EXT = 34186,
	GL_OPERAND0_RGB_EXT = 34192,
	GL_OPERAND1_RGB_EXT = 34193,
	GL_OPERAND2_RGB_EXT = 34194,
	GL_OPERAND0_ALPHA_EXT = 34200,
	GL_OPERAND1_ALPHA_EXT = 34201,
	GL_OPERAND2_ALPHA_EXT = 34202,
	GL_EXT_texture_env_dot3 = 1,
	GL_DOT3_RGB_EXT = 34624,
	GL_DOT3_RGBA_EXT = 34625,
	GL_EXT_texture_filter_anisotropic = 1,
	GL_TEXTURE_MAX_ANISOTROPY_EXT = 34046,
	GL_MAX_TEXTURE_MAX_ANISOTROPY_EXT = 34047,
	GL_EXT_texture_filter_minmax = 1,
	GL_TEXTURE_REDUCTION_MODE_EXT = 37734,
	GL_WEIGHTED_AVERAGE_EXT = 37735,
	GL_EXT_texture_integer = 1,
	GL_RGBA32UI_EXT = 36208,
	GL_RGB32UI_EXT = 36209,
	GL_ALPHA32UI_EXT = 36210,
	GL_INTENSITY32UI_EXT = 36211,
	GL_LUMINANCE32UI_EXT = 36212,
	GL_LUMINANCE_ALPHA32UI_EXT = 36213,
	GL_RGBA16UI_EXT = 36214,
	GL_RGB16UI_EXT = 36215,
	GL_ALPHA16UI_EXT = 36216,
	GL_INTENSITY16UI_EXT = 36217,
	GL_LUMINANCE16UI_EXT = 36218,
	GL_LUMINANCE_ALPHA16UI_EXT = 36219,
	GL_RGBA8UI_EXT = 36220,
	GL_RGB8UI_EXT = 36221,
	GL_ALPHA8UI_EXT = 36222,
	GL_INTENSITY8UI_EXT = 36223,
	GL_LUMINANCE8UI_EXT = 36224,
	GL_LUMINANCE_ALPHA8UI_EXT = 36225,
	GL_RGBA32I_EXT = 36226,
	GL_RGB32I_EXT = 36227,
	GL_ALPHA32I_EXT = 36228,
	GL_INTENSITY32I_EXT = 36229,
	GL_LUMINANCE32I_EXT = 36230,
	GL_LUMINANCE_ALPHA32I_EXT = 36231,
	GL_RGBA16I_EXT = 36232,
	GL_RGB16I_EXT = 36233,
	GL_ALPHA16I_EXT = 36234,
	GL_INTENSITY16I_EXT = 36235,
	GL_LUMINANCE16I_EXT = 36236,
	GL_LUMINANCE_ALPHA16I_EXT = 36237,
	GL_RGBA8I_EXT = 36238,
	GL_RGB8I_EXT = 36239,
	GL_ALPHA8I_EXT = 36240,
	GL_INTENSITY8I_EXT = 36241,
	GL_LUMINANCE8I_EXT = 36242,
	GL_LUMINANCE_ALPHA8I_EXT = 36243,
	GL_RED_INTEGER_EXT = 36244,
	GL_GREEN_INTEGER_EXT = 36245,
	GL_BLUE_INTEGER_EXT = 36246,
	GL_ALPHA_INTEGER_EXT = 36247,
	GL_RGB_INTEGER_EXT = 36248,
	GL_RGBA_INTEGER_EXT = 36249,
	GL_BGR_INTEGER_EXT = 36250,
	GL_BGRA_INTEGER_EXT = 36251,
	GL_LUMINANCE_INTEGER_EXT = 36252,
	GL_LUMINANCE_ALPHA_INTEGER_EXT = 36253,
	GL_RGBA_INTEGER_MODE_EXT = 36254,
	GL_EXT_texture_lod_bias = 1,
	GL_MAX_TEXTURE_LOD_BIAS_EXT = 34045,
	GL_TEXTURE_FILTER_CONTROL_EXT = 34048,
	GL_TEXTURE_LOD_BIAS_EXT = 34049,
	GL_EXT_texture_mirror_clamp = 1,
	GL_MIRROR_CLAMP_EXT = 34626,
	GL_MIRROR_CLAMP_TO_EDGE_EXT = 34627,
	GL_MIRROR_CLAMP_TO_BORDER_EXT = 35090,
	GL_EXT_texture_object = 1,
	GL_TEXTURE_PRIORITY_EXT = 32870,
	GL_TEXTURE_RESIDENT_EXT = 32871,
	GL_TEXTURE_1D_BINDING_EXT = 32872,
	GL_TEXTURE_2D_BINDING_EXT = 32873,
	GL_TEXTURE_3D_BINDING_EXT = 32874,
	GL_EXT_texture_perturb_normal = 1,
	GL_PERTURB_EXT = 34222,
	GL_TEXTURE_NORMAL_EXT = 34223,
	GL_EXT_texture_sRGB = 1,
	GL_SRGB_EXT = 35904,
	GL_SRGB8_EXT = 35905,
	GL_SRGB_ALPHA_EXT = 35906,
	GL_SRGB8_ALPHA8_EXT = 35907,
	GL_SLUMINANCE_ALPHA_EXT = 35908,
	GL_SLUMINANCE8_ALPHA8_EXT = 35909,
	GL_SLUMINANCE_EXT = 35910,
	GL_SLUMINANCE8_EXT = 35911,
	GL_COMPRESSED_SRGB_EXT = 35912,
	GL_COMPRESSED_SRGB_ALPHA_EXT = 35913,
	GL_COMPRESSED_SLUMINANCE_EXT = 35914,
	GL_COMPRESSED_SLUMINANCE_ALPHA_EXT = 35915,
	GL_COMPRESSED_SRGB_S3TC_DXT1_EXT = 35916,
	GL_COMPRESSED_SRGB_ALPHA_S3TC_DXT1_EXT = 35917,
	GL_COMPRESSED_SRGB_ALPHA_S3TC_DXT3_EXT = 35918,
	GL_COMPRESSED_SRGB_ALPHA_S3TC_DXT5_EXT = 35919,
	GL_EXT_texture_sRGB_R8 = 1,
	GL_SR8_EXT = 36797,
	GL_EXT_texture_sRGB_RG8 = 1,
	GL_SRG8_EXT = 36798,
	GL_EXT_texture_sRGB_decode = 1,
	GL_TEXTURE_SRGB_DECODE_EXT = 35400,
	GL_DECODE_EXT = 35401,
	GL_SKIP_DECODE_EXT = 35402,
	GL_EXT_texture_shadow_lod = 1,
	GL_EXT_texture_shared_exponent = 1,
	GL_RGB9_E5_EXT = 35901,
	GL_UNSIGNED_INT_5_9_9_9_REV_EXT = 35902,
	GL_TEXTURE_SHARED_SIZE_EXT = 35903,
	GL_EXT_texture_snorm = 1,
	GL_ALPHA_SNORM = 36880,
	GL_LUMINANCE_SNORM = 36881,
	GL_LUMINANCE_ALPHA_SNORM = 36882,
	GL_INTENSITY_SNORM = 36883,
	GL_ALPHA8_SNORM = 36884,
	GL_LUMINANCE8_SNORM = 36885,
	GL_LUMINANCE8_ALPHA8_SNORM = 36886,
	GL_INTENSITY8_SNORM = 36887,
	GL_ALPHA16_SNORM = 36888,
	GL_LUMINANCE16_SNORM = 36889,
	GL_LUMINANCE16_ALPHA16_SNORM = 36890,
	GL_INTENSITY16_SNORM = 36891,
	GL_RED_SNORM = 36752,
	GL_RG_SNORM = 36753,
	GL_RGB_SNORM = 36754,
	GL_RGBA_SNORM = 36755,
	GL_EXT_texture_swizzle = 1,
	GL_TEXTURE_SWIZZLE_R_EXT = 36418,
	GL_TEXTURE_SWIZZLE_G_EXT = 36419,
	GL_TEXTURE_SWIZZLE_B_EXT = 36420,
	GL_TEXTURE_SWIZZLE_A_EXT = 36421,
	GL_TEXTURE_SWIZZLE_RGBA_EXT = 36422,
	GL_EXT_timer_query = 1,
	GL_TIME_ELAPSED_EXT = 35007,
	GL_EXT_transform_feedback = 1,
	GL_TRANSFORM_FEEDBACK_BUFFER_EXT = 35982,
	GL_TRANSFORM_FEEDBACK_BUFFER_START_EXT = 35972,
	GL_TRANSFORM_FEEDBACK_BUFFER_SIZE_EXT = 35973,
	GL_TRANSFORM_FEEDBACK_BUFFER_BINDING_EXT = 35983,
	GL_INTERLEAVED_ATTRIBS_EXT = 35980,
	GL_SEPARATE_ATTRIBS_EXT = 35981,
	GL_PRIMITIVES_GENERATED_EXT = 35975,
	GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN_EXT = 35976,
	GL_RASTERIZER_DISCARD_EXT = 35977,
	GL_MAX_TRANSFORM_FEEDBACK_INTERLEAVED_COMPONENTS_EXT = 35978,
	GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_ATTRIBS_EXT = 35979,
	GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_COMPONENTS_EXT = 35968,
	GL_TRANSFORM_FEEDBACK_VARYINGS_EXT = 35971,
	GL_TRANSFORM_FEEDBACK_BUFFER_MODE_EXT = 35967,
	GL_TRANSFORM_FEEDBACK_VARYING_MAX_LENGTH_EXT = 35958,
	GL_EXT_vertex_array_bgra = 1,
	GL_EXT_vertex_attrib_64bit = 1,
	GL_DOUBLE_VEC2_EXT = 36860,
	GL_DOUBLE_VEC3_EXT = 36861,
	GL_DOUBLE_VEC4_EXT = 36862,
	GL_DOUBLE_MAT2_EXT = 36678,
	GL_DOUBLE_MAT3_EXT = 36679,
	GL_DOUBLE_MAT4_EXT = 36680,
	GL_DOUBLE_MAT2x3_EXT = 36681,
	GL_DOUBLE_MAT2x4_EXT = 36682,
	GL_DOUBLE_MAT3x2_EXT = 36683,
	GL_DOUBLE_MAT3x4_EXT = 36684,
	GL_DOUBLE_MAT4x2_EXT = 36685,
	GL_DOUBLE_MAT4x3_EXT = 36686,
	GL_EXT_vertex_shader = 1,
	GL_VERTEX_SHADER_EXT = 34688,
	GL_VERTEX_SHADER_BINDING_EXT = 34689,
	GL_OP_INDEX_EXT = 34690,
	GL_OP_NEGATE_EXT = 34691,
	GL_OP_DOT3_EXT = 34692,
	GL_OP_DOT4_EXT = 34693,
	GL_OP_MUL_EXT = 34694,
	GL_OP_ADD_EXT = 34695,
	GL_OP_MADD_EXT = 34696,
	GL_OP_FRAC_EXT = 34697,
	GL_OP_MAX_EXT = 34698,
	GL_OP_MIN_EXT = 34699,
	GL_OP_SET_GE_EXT = 34700,
	GL_OP_SET_LT_EXT = 34701,
	GL_OP_CLAMP_EXT = 34702,
	GL_OP_FLOOR_EXT = 34703,
	GL_OP_ROUND_EXT = 34704,
	GL_OP_EXP_BASE_2_EXT = 34705,
	GL_OP_LOG_BASE_2_EXT = 34706,
	GL_OP_POWER_EXT = 34707,
	GL_OP_RECIP_EXT = 34708,
	GL_OP_RECIP_SQRT_EXT = 34709,
	GL_OP_SUB_EXT = 34710,
	GL_OP_CROSS_PRODUCT_EXT = 34711,
	GL_OP_MULTIPLY_MATRIX_EXT = 34712,
	GL_OP_MOV_EXT = 34713,
	GL_OUTPUT_VERTEX_EXT = 34714,
	GL_OUTPUT_COLOR0_EXT = 34715,
	GL_OUTPUT_COLOR1_EXT = 34716,
	GL_OUTPUT_TEXTURE_COORD0_EXT = 34717,
	GL_OUTPUT_TEXTURE_COORD1_EXT = 34718,
	GL_OUTPUT_TEXTURE_COORD2_EXT = 34719,
	GL_OUTPUT_TEXTURE_COORD3_EXT = 34720,
	GL_OUTPUT_TEXTURE_COORD4_EXT = 34721,
	GL_OUTPUT_TEXTURE_COORD5_EXT = 34722,
	GL_OUTPUT_TEXTURE_COORD6_EXT = 34723,
	GL_OUTPUT_TEXTURE_COORD7_EXT = 34724,
	GL_OUTPUT_TEXTURE_COORD8_EXT = 34725,
	GL_OUTPUT_TEXTURE_COORD9_EXT = 34726,
	GL_OUTPUT_TEXTURE_COORD10_EXT = 34727,
	GL_OUTPUT_TEXTURE_COORD11_EXT = 34728,
	GL_OUTPUT_TEXTURE_COORD12_EXT = 34729,
	GL_OUTPUT_TEXTURE_COORD13_EXT = 34730,
	GL_OUTPUT_TEXTURE_COORD14_EXT = 34731,
	GL_OUTPUT_TEXTURE_COORD15_EXT = 34732,
	GL_OUTPUT_TEXTURE_COORD16_EXT = 34733,
	GL_OUTPUT_TEXTURE_COORD17_EXT = 34734,
	GL_OUTPUT_TEXTURE_COORD18_EXT = 34735,
	GL_OUTPUT_TEXTURE_COORD19_EXT = 34736,
	GL_OUTPUT_TEXTURE_COORD20_EXT = 34737,
	GL_OUTPUT_TEXTURE_COORD21_EXT = 34738,
	GL_OUTPUT_TEXTURE_COORD22_EXT = 34739,
	GL_OUTPUT_TEXTURE_COORD23_EXT = 34740,
	GL_OUTPUT_TEXTURE_COORD24_EXT = 34741,
	GL_OUTPUT_TEXTURE_COORD25_EXT = 34742,
	GL_OUTPUT_TEXTURE_COORD26_EXT = 34743,
	GL_OUTPUT_TEXTURE_COORD27_EXT = 34744,
	GL_OUTPUT_TEXTURE_COORD28_EXT = 34745,
	GL_OUTPUT_TEXTURE_COORD29_EXT = 34746,
	GL_OUTPUT_TEXTURE_COORD30_EXT = 34747,
	GL_OUTPUT_TEXTURE_COORD31_EXT = 34748,
	GL_OUTPUT_FOG_EXT = 34749,
	GL_SCALAR_EXT = 34750,
	GL_VECTOR_EXT = 34751,
	GL_MATRIX_EXT = 34752,
	GL_VARIANT_EXT = 34753,
	GL_INVARIANT_EXT = 34754,
	GL_LOCAL_CONSTANT_EXT = 34755,
	GL_LOCAL_EXT = 34756,
	GL_MAX_VERTEX_SHADER_INSTRUCTIONS_EXT = 34757,
	GL_MAX_VERTEX_SHADER_VARIANTS_EXT = 34758,
	GL_MAX_VERTEX_SHADER_INVARIANTS_EXT = 34759,
	GL_MAX_VERTEX_SHADER_LOCAL_CONSTANTS_EXT = 34760,
	GL_MAX_VERTEX_SHADER_LOCALS_EXT = 34761,
	GL_MAX_OPTIMIZED_VERTEX_SHADER_INSTRUCTIONS_EXT = 34762,
	GL_MAX_OPTIMIZED_VERTEX_SHADER_VARIANTS_EXT = 34763,
	GL_MAX_OPTIMIZED_VERTEX_SHADER_LOCAL_CONSTANTS_EXT = 34764,
	GL_MAX_OPTIMIZED_VERTEX_SHADER_INVARIANTS_EXT = 34765,
	GL_MAX_OPTIMIZED_VERTEX_SHADER_LOCALS_EXT = 34766,
	GL_VERTEX_SHADER_INSTRUCTIONS_EXT = 34767,
	GL_VERTEX_SHADER_VARIANTS_EXT = 34768,
	GL_VERTEX_SHADER_INVARIANTS_EXT = 34769,
	GL_VERTEX_SHADER_LOCAL_CONSTANTS_EXT = 34770,
	GL_VERTEX_SHADER_LOCALS_EXT = 34771,
	GL_VERTEX_SHADER_OPTIMIZED_EXT = 34772,
	GL_X_EXT = 34773,
	GL_Y_EXT = 34774,
	GL_Z_EXT = 34775,
	GL_W_EXT = 34776,
	GL_NEGATIVE_X_EXT = 34777,
	GL_NEGATIVE_Y_EXT = 34778,
	GL_NEGATIVE_Z_EXT = 34779,
	GL_NEGATIVE_W_EXT = 34780,
	GL_ZERO_EXT = 34781,
	GL_ONE_EXT = 34782,
	GL_NEGATIVE_ONE_EXT = 34783,
	GL_NORMALIZED_RANGE_EXT = 34784,
	GL_FULL_RANGE_EXT = 34785,
	GL_CURRENT_VERTEX_EXT = 34786,
	GL_MVP_MATRIX_EXT = 34787,
	GL_VARIANT_VALUE_EXT = 34788,
	GL_VARIANT_DATATYPE_EXT = 34789,
	GL_VARIANT_ARRAY_STRIDE_EXT = 34790,
	GL_VARIANT_ARRAY_TYPE_EXT = 34791,
	GL_VARIANT_ARRAY_EXT = 34792,
	GL_VARIANT_ARRAY_POINTER_EXT = 34793,
	GL_INVARIANT_VALUE_EXT = 34794,
	GL_INVARIANT_DATATYPE_EXT = 34795,
	GL_LOCAL_CONSTANT_VALUE_EXT = 34796,
	GL_LOCAL_CONSTANT_DATATYPE_EXT = 34797,
	GL_EXT_vertex_weighting = 1,
	GL_MODELVIEW0_STACK_DEPTH_EXT = 2979,
	GL_MODELVIEW1_STACK_DEPTH_EXT = 34050,
	GL_MODELVIEW0_MATRIX_EXT = 2982,
	GL_MODELVIEW1_MATRIX_EXT = 34054,
	GL_VERTEX_WEIGHTING_EXT = 34057,
	GL_MODELVIEW0_EXT = 5888,
	GL_MODELVIEW1_EXT = 34058,
	GL_CURRENT_VERTEX_WEIGHT_EXT = 34059,
	GL_VERTEX_WEIGHT_ARRAY_EXT = 34060,
	GL_VERTEX_WEIGHT_ARRAY_SIZE_EXT = 34061,
	GL_VERTEX_WEIGHT_ARRAY_TYPE_EXT = 34062,
	GL_VERTEX_WEIGHT_ARRAY_STRIDE_EXT = 34063,
	GL_VERTEX_WEIGHT_ARRAY_POINTER_EXT = 34064,
	GL_EXT_win32_keyed_mutex = 1,
	GL_EXT_window_rectangles = 1,
	GL_INCLUSIVE_EXT = 36624,
	GL_EXCLUSIVE_EXT = 36625,
	GL_WINDOW_RECTANGLE_EXT = 36626,
	GL_WINDOW_RECTANGLE_MODE_EXT = 36627,
	GL_MAX_WINDOW_RECTANGLES_EXT = 36628,
	GL_NUM_WINDOW_RECTANGLES_EXT = 36629,
	GL_EXT_x11_sync_object = 1,
	GL_SYNC_X11_FENCE_EXT = 37089,
	GL_GREMEDY_frame_terminator = 1,
	GL_GREMEDY_string_marker = 1,
	GL_HP_convolution_border_modes = 1,
	GL_IGNORE_BORDER_HP = 33104,
	GL_CONSTANT_BORDER_HP = 33105,
	GL_REPLICATE_BORDER_HP = 33107,
	GL_CONVOLUTION_BORDER_COLOR_HP = 33108,
	GL_HP_image_transform = 1,
	GL_IMAGE_SCALE_X_HP = 33109,
	GL_IMAGE_SCALE_Y_HP = 33110,
	GL_IMAGE_TRANSLATE_X_HP = 33111,
	GL_IMAGE_TRANSLATE_Y_HP = 33112,
	GL_IMAGE_ROTATE_ANGLE_HP = 33113,
	GL_IMAGE_ROTATE_ORIGIN_X_HP = 33114,
	GL_IMAGE_ROTATE_ORIGIN_Y_HP = 33115,
	GL_IMAGE_MAG_FILTER_HP = 33116,
	GL_IMAGE_MIN_FILTER_HP = 33117,
	GL_IMAGE_CUBIC_WEIGHT_HP = 33118,
	GL_CUBIC_HP = 33119,
	GL_AVERAGE_HP = 33120,
	GL_IMAGE_TRANSFORM_2D_HP = 33121,
	GL_POST_IMAGE_TRANSFORM_COLOR_TABLE_HP = 33122,
	GL_PROXY_POST_IMAGE_TRANSFORM_COLOR_TABLE_HP = 33123,
	GL_HP_occlusion_test = 1,
	GL_OCCLUSION_TEST_HP = 33125,
	GL_OCCLUSION_TEST_RESULT_HP = 33126,
	GL_HP_texture_lighting = 1,
	GL_TEXTURE_LIGHTING_MODE_HP = 33127,
	GL_TEXTURE_POST_SPECULAR_HP = 33128,
	GL_TEXTURE_PRE_SPECULAR_HP = 33129,
	GL_IBM_cull_vertex = 1,
	GL_CULL_VERTEX_IBM = 103050,
	GL_IBM_multimode_draw_arrays = 1,
	GL_IBM_rasterpos_clip = 1,
	GL_RASTER_POSITION_UNCLIPPED_IBM = 103010,
	GL_IBM_static_data = 1,
	GL_ALL_STATIC_DATA_IBM = 103060,
	GL_STATIC_VERTEX_ARRAY_IBM = 103061,
	GL_IBM_texture_mirrored_repeat = 1,
	GL_MIRRORED_REPEAT_IBM = 33648,
	GL_IBM_vertex_array_lists = 1,
	GL_VERTEX_ARRAY_LIST_IBM = 103070,
	GL_NORMAL_ARRAY_LIST_IBM = 103071,
	GL_COLOR_ARRAY_LIST_IBM = 103072,
	GL_INDEX_ARRAY_LIST_IBM = 103073,
	GL_TEXTURE_COORD_ARRAY_LIST_IBM = 103074,
	GL_EDGE_FLAG_ARRAY_LIST_IBM = 103075,
	GL_FOG_COORDINATE_ARRAY_LIST_IBM = 103076,
	GL_SECONDARY_COLOR_ARRAY_LIST_IBM = 103077,
	GL_VERTEX_ARRAY_LIST_STRIDE_IBM = 103080,
	GL_NORMAL_ARRAY_LIST_STRIDE_IBM = 103081,
	GL_COLOR_ARRAY_LIST_STRIDE_IBM = 103082,
	GL_INDEX_ARRAY_LIST_STRIDE_IBM = 103083,
	GL_TEXTURE_COORD_ARRAY_LIST_STRIDE_IBM = 103084,
	GL_EDGE_FLAG_ARRAY_LIST_STRIDE_IBM = 103085,
	GL_FOG_COORDINATE_ARRAY_LIST_STRIDE_IBM = 103086,
	GL_SECONDARY_COLOR_ARRAY_LIST_STRIDE_IBM = 103087,
	GL_INGR_blend_func_separate = 1,
	GL_INGR_color_clamp = 1,
	GL_RED_MIN_CLAMP_INGR = 34144,
	GL_GREEN_MIN_CLAMP_INGR = 34145,
	GL_BLUE_MIN_CLAMP_INGR = 34146,
	GL_ALPHA_MIN_CLAMP_INGR = 34147,
	GL_RED_MAX_CLAMP_INGR = 34148,
	GL_GREEN_MAX_CLAMP_INGR = 34149,
	GL_BLUE_MAX_CLAMP_INGR = 34150,
	GL_ALPHA_MAX_CLAMP_INGR = 34151,
	GL_INGR_interlace_read = 1,
	GL_INTERLACE_READ_INGR = 34152,
	GL_INTEL_blackhole_render = 1,
	GL_BLACKHOLE_RENDER_INTEL = 33788,
	GL_INTEL_conservative_rasterization = 1,
	GL_CONSERVATIVE_RASTERIZATION_INTEL = 33790,
	GL_INTEL_fragment_shader_ordering = 1,
	GL_INTEL_framebuffer_CMAA = 1,
	GL_INTEL_map_texture = 1,
	GL_TEXTURE_MEMORY_LAYOUT_INTEL = 33791,
	GL_LAYOUT_DEFAULT_INTEL = 0,
	GL_LAYOUT_LINEAR_INTEL = 1,
	GL_LAYOUT_LINEAR_CPU_CACHED_INTEL = 2,
	GL_INTEL_parallel_arrays = 1,
	GL_PARALLEL_ARRAYS_INTEL = 33780,
	GL_VERTEX_ARRAY_PARALLEL_POINTERS_INTEL = 33781,
	GL_NORMAL_ARRAY_PARALLEL_POINTERS_INTEL = 33782,
	GL_COLOR_ARRAY_PARALLEL_POINTERS_INTEL = 33783,
	GL_TEXTURE_COORD_ARRAY_PARALLEL_POINTERS_INTEL = 33784,
	GL_INTEL_performance_query = 1,
	GL_PERFQUERY_SINGLE_CONTEXT_INTEL = 0,
	GL_PERFQUERY_GLOBAL_CONTEXT_INTEL = 1,
	GL_PERFQUERY_WAIT_INTEL = 33787,
	GL_PERFQUERY_FLUSH_INTEL = 33786,
	GL_PERFQUERY_DONOT_FLUSH_INTEL = 33785,
	GL_PERFQUERY_COUNTER_EVENT_INTEL = 38128,
	GL_PERFQUERY_COUNTER_DURATION_NORM_INTEL = 38129,
	GL_PERFQUERY_COUNTER_DURATION_RAW_INTEL = 38130,
	GL_PERFQUERY_COUNTER_THROUGHPUT_INTEL = 38131,
	GL_PERFQUERY_COUNTER_RAW_INTEL = 38132,
	GL_PERFQUERY_COUNTER_TIMESTAMP_INTEL = 38133,
	GL_PERFQUERY_COUNTER_DATA_UINT32_INTEL = 38136,
	GL_PERFQUERY_COUNTER_DATA_UINT64_INTEL = 38137,
	GL_PERFQUERY_COUNTER_DATA_FLOAT_INTEL = 38138,
	GL_PERFQUERY_COUNTER_DATA_DOUBLE_INTEL = 38139,
	GL_PERFQUERY_COUNTER_DATA_BOOL32_INTEL = 38140,
	GL_PERFQUERY_QUERY_NAME_LENGTH_MAX_INTEL = 38141,
	GL_PERFQUERY_COUNTER_NAME_LENGTH_MAX_INTEL = 38142,
	GL_PERFQUERY_COUNTER_DESC_LENGTH_MAX_INTEL = 38143,
	GL_PERFQUERY_GPA_EXTENDED_COUNTERS_INTEL = 38144,
	GL_MESAX_texture_stack = 1,
	GL_TEXTURE_1D_STACK_MESAX = 34649,
	GL_TEXTURE_2D_STACK_MESAX = 34650,
	GL_PROXY_TEXTURE_1D_STACK_MESAX = 34651,
	GL_PROXY_TEXTURE_2D_STACK_MESAX = 34652,
	GL_TEXTURE_1D_STACK_BINDING_MESAX = 34653,
	GL_TEXTURE_2D_STACK_BINDING_MESAX = 34654,
	GL_MESA_framebuffer_flip_x = 1,
	GL_FRAMEBUFFER_FLIP_X_MESA = 35772,
	GL_MESA_framebuffer_flip_y = 1,
	GL_FRAMEBUFFER_FLIP_Y_MESA = 35771,
	GL_MESA_framebuffer_swap_xy = 1,
	GL_FRAMEBUFFER_SWAP_XY_MESA = 35773,
	GL_MESA_pack_invert = 1,
	GL_PACK_INVERT_MESA = 34648,
	GL_MESA_program_binary_formats = 1,
	GL_PROGRAM_BINARY_FORMAT_MESA = 34655,
	GL_MESA_resize_buffers = 1,
	GL_MESA_shader_integer_functions = 1,
	GL_MESA_tile_raster_order = 1,
	GL_TILE_RASTER_ORDER_FIXED_MESA = 35768,
	GL_TILE_RASTER_ORDER_INCREASING_X_MESA = 35769,
	GL_TILE_RASTER_ORDER_INCREASING_Y_MESA = 35770,
	GL_MESA_window_pos = 1,
	GL_MESA_ycbcr_texture = 1,
	GL_UNSIGNED_SHORT_8_8_MESA = 34234,
	GL_UNSIGNED_SHORT_8_8_REV_MESA = 34235,
	GL_YCBCR_MESA = 34647,
	GL_NVX_blend_equation_advanced_multi_draw_buffers = 1,
	GL_NVX_conditional_render = 1,
	GL_NVX_gpu_memory_info = 1,
	GL_GPU_MEMORY_INFO_DEDICATED_VIDMEM_NVX = 36935,
	GL_GPU_MEMORY_INFO_TOTAL_AVAILABLE_MEMORY_NVX = 36936,
	GL_GPU_MEMORY_INFO_CURRENT_AVAILABLE_VIDMEM_NVX = 36937,
	GL_GPU_MEMORY_INFO_EVICTION_COUNT_NVX = 36938,
	GL_GPU_MEMORY_INFO_EVICTED_MEMORY_NVX = 36939,
	GL_NVX_gpu_multicast2 = 1,
	GL_UPLOAD_GPU_MASK_NVX = 38218,
	GL_NVX_linked_gpu_multicast = 1,
	GL_LGPU_SEPARATE_STORAGE_BIT_NVX = 2048,
	GL_MAX_LGPU_GPUS_NVX = 37562,
	GL_NVX_progress_fence = 1,
	GL_NV_alpha_to_coverage_dither_control = 1,
	GL_ALPHA_TO_COVERAGE_DITHER_DEFAULT_NV = 37709,
	GL_ALPHA_TO_COVERAGE_DITHER_ENABLE_NV = 37710,
	GL_ALPHA_TO_COVERAGE_DITHER_DISABLE_NV = 37711,
	GL_ALPHA_TO_COVERAGE_DITHER_MODE_NV = 37567,
	GL_NV_bindless_multi_draw_indirect = 1,
	GL_NV_bindless_multi_draw_indirect_count = 1,
	GL_NV_bindless_texture = 1,
	GL_NV_blend_equation_advanced = 1,
	GL_BLEND_OVERLAP_NV = 37505,
	GL_BLEND_PREMULTIPLIED_SRC_NV = 37504,
	GL_BLUE_NV = 6405,
	GL_COLORBURN_NV = 37530,
	GL_COLORDODGE_NV = 37529,
	GL_CONJOINT_NV = 37508,
	GL_CONTRAST_NV = 37537,
	GL_DARKEN_NV = 37527,
	GL_DIFFERENCE_NV = 37534,
	GL_DISJOINT_NV = 37507,
	GL_DST_ATOP_NV = 37519,
	GL_DST_IN_NV = 37515,
	GL_DST_NV = 37511,
	GL_DST_OUT_NV = 37517,
	GL_DST_OVER_NV = 37513,
	GL_EXCLUSION_NV = 37536,
	GL_GREEN_NV = 6404,
	GL_HARDLIGHT_NV = 37531,
	GL_HARDMIX_NV = 37545,
	GL_HSL_COLOR_NV = 37551,
	GL_HSL_HUE_NV = 37549,
	GL_HSL_LUMINOSITY_NV = 37552,
	GL_HSL_SATURATION_NV = 37550,
	GL_INVERT_OVG_NV = 37556,
	GL_INVERT_RGB_NV = 37539,
	GL_LIGHTEN_NV = 37528,
	GL_LINEARBURN_NV = 37541,
	GL_LINEARDODGE_NV = 37540,
	GL_LINEARLIGHT_NV = 37543,
	GL_MINUS_CLAMPED_NV = 37555,
	GL_MINUS_NV = 37535,
	GL_MULTIPLY_NV = 37524,
	GL_OVERLAY_NV = 37526,
	GL_PINLIGHT_NV = 37544,
	GL_PLUS_CLAMPED_ALPHA_NV = 37554,
	GL_PLUS_CLAMPED_NV = 37553,
	GL_PLUS_DARKER_NV = 37522,
	GL_PLUS_NV = 37521,
	GL_RED_NV = 6403,
	GL_SCREEN_NV = 37525,
	GL_SOFTLIGHT_NV = 37532,
	GL_SRC_ATOP_NV = 37518,
	GL_SRC_IN_NV = 37514,
	GL_SRC_NV = 37510,
	GL_SRC_OUT_NV = 37516,
	GL_SRC_OVER_NV = 37512,
	GL_UNCORRELATED_NV = 37506,
	GL_VIVIDLIGHT_NV = 37542,
	GL_XOR_NV = 5382,
	GL_NV_blend_equation_advanced_coherent = 1,
	GL_BLEND_ADVANCED_COHERENT_NV = 37509,
	GL_NV_blend_minmax_factor = 1,
	GL_NV_blend_square = 1,
	GL_NV_clip_space_w_scaling = 1,
	GL_VIEWPORT_POSITION_W_SCALE_NV = 37756,
	GL_VIEWPORT_POSITION_W_SCALE_X_COEFF_NV = 37757,
	GL_VIEWPORT_POSITION_W_SCALE_Y_COEFF_NV = 37758,
	GL_NV_command_list = 1,
	GL_TERMINATE_SEQUENCE_COMMAND_NV = 0,
	GL_NOP_COMMAND_NV = 1,
	GL_DRAW_ELEMENTS_COMMAND_NV = 2,
	GL_DRAW_ARRAYS_COMMAND_NV = 3,
	GL_DRAW_ELEMENTS_STRIP_COMMAND_NV = 4,
	GL_DRAW_ARRAYS_STRIP_COMMAND_NV = 5,
	GL_DRAW_ELEMENTS_INSTANCED_COMMAND_NV = 6,
	GL_DRAW_ARRAYS_INSTANCED_COMMAND_NV = 7,
	GL_ELEMENT_ADDRESS_COMMAND_NV = 8,
	GL_ATTRIBUTE_ADDRESS_COMMAND_NV = 9,
	GL_UNIFORM_ADDRESS_COMMAND_NV = 10,
	GL_BLEND_COLOR_COMMAND_NV = 11,
	GL_STENCIL_REF_COMMAND_NV = 12,
	GL_LINE_WIDTH_COMMAND_NV = 13,
	GL_POLYGON_OFFSET_COMMAND_NV = 14,
	GL_ALPHA_REF_COMMAND_NV = 15,
	GL_VIEWPORT_COMMAND_NV = 16,
	GL_SCISSOR_COMMAND_NV = 17,
	GL_FRONT_FACE_COMMAND_NV = 18,
	GL_NV_compute_program5 = 1,
	GL_COMPUTE_PROGRAM_NV = 37115,
	GL_COMPUTE_PROGRAM_PARAMETER_BUFFER_NV = 37116,
	GL_NV_compute_shader_derivatives = 1,
	GL_NV_conditional_render = 1,
	GL_QUERY_WAIT_NV = 36371,
	GL_QUERY_NO_WAIT_NV = 36372,
	GL_QUERY_BY_REGION_WAIT_NV = 36373,
	GL_QUERY_BY_REGION_NO_WAIT_NV = 36374,
	GL_NV_conservative_raster = 1,
	GL_CONSERVATIVE_RASTERIZATION_NV = 37702,
	GL_SUBPIXEL_PRECISION_BIAS_X_BITS_NV = 37703,
	GL_SUBPIXEL_PRECISION_BIAS_Y_BITS_NV = 37704,
	GL_MAX_SUBPIXEL_PRECISION_BIAS_BITS_NV = 37705,
	GL_NV_conservative_raster_dilate = 1,
	GL_CONSERVATIVE_RASTER_DILATE_NV = 37753,
	GL_CONSERVATIVE_RASTER_DILATE_RANGE_NV = 37754,
	GL_CONSERVATIVE_RASTER_DILATE_GRANULARITY_NV = 37755,
	GL_NV_conservative_raster_pre_snap = 1,
	GL_CONSERVATIVE_RASTER_MODE_PRE_SNAP_NV = 38224,
	GL_NV_conservative_raster_pre_snap_triangles = 1,
	GL_CONSERVATIVE_RASTER_MODE_NV = 38221,
	GL_CONSERVATIVE_RASTER_MODE_POST_SNAP_NV = 38222,
	GL_CONSERVATIVE_RASTER_MODE_PRE_SNAP_TRIANGLES_NV = 38223,
	GL_NV_conservative_raster_underestimation = 1,
	GL_NV_copy_depth_to_color = 1,
	GL_DEPTH_STENCIL_TO_RGBA_NV = 34926,
	GL_DEPTH_STENCIL_TO_BGRA_NV = 34927,
	GL_NV_copy_image = 1,
	GL_NV_deep_texture3D = 1,
	GL_MAX_DEEP_3D_TEXTURE_WIDTH_HEIGHT_NV = 37072,
	GL_MAX_DEEP_3D_TEXTURE_DEPTH_NV = 37073,
	GL_NV_depth_buffer_float = 1,
	GL_DEPTH_COMPONENT32F_NV = 36267,
	GL_DEPTH32F_STENCIL8_NV = 36268,
	GL_FLOAT_32_UNSIGNED_INT_24_8_REV_NV = 36269,
	GL_DEPTH_BUFFER_FLOAT_MODE_NV = 36271,
	GL_NV_depth_clamp = 1,
	GL_DEPTH_CLAMP_NV = 34383,
	GL_NV_draw_texture = 1,
	GL_NV_draw_vulkan_image = 1,
	GL_NV_evaluators = 1,
	GL_EVAL_2D_NV = 34496,
	GL_EVAL_TRIANGULAR_2D_NV = 34497,
	GL_MAP_TESSELLATION_NV = 34498,
	GL_MAP_ATTRIB_U_ORDER_NV = 34499,
	GL_MAP_ATTRIB_V_ORDER_NV = 34500,
	GL_EVAL_FRACTIONAL_TESSELLATION_NV = 34501,
	GL_EVAL_VERTEX_ATTRIB0_NV = 34502,
	GL_EVAL_VERTEX_ATTRIB1_NV = 34503,
	GL_EVAL_VERTEX_ATTRIB2_NV = 34504,
	GL_EVAL_VERTEX_ATTRIB3_NV = 34505,
	GL_EVAL_VERTEX_ATTRIB4_NV = 34506,
	GL_EVAL_VERTEX_ATTRIB5_NV = 34507,
	GL_EVAL_VERTEX_ATTRIB6_NV = 34508,
	GL_EVAL_VERTEX_ATTRIB7_NV = 34509,
	GL_EVAL_VERTEX_ATTRIB8_NV = 34510,
	GL_EVAL_VERTEX_ATTRIB9_NV = 34511,
	GL_EVAL_VERTEX_ATTRIB10_NV = 34512,
	GL_EVAL_VERTEX_ATTRIB11_NV = 34513,
	GL_EVAL_VERTEX_ATTRIB12_NV = 34514,
	GL_EVAL_VERTEX_ATTRIB13_NV = 34515,
	GL_EVAL_VERTEX_ATTRIB14_NV = 34516,
	GL_EVAL_VERTEX_ATTRIB15_NV = 34517,
	GL_MAX_MAP_TESSELLATION_NV = 34518,
	GL_MAX_RATIONAL_EVAL_ORDER_NV = 34519,
	GL_NV_explicit_multisample = 1,
	GL_SAMPLE_POSITION_NV = 36432,
	GL_SAMPLE_MASK_NV = 36433,
	GL_SAMPLE_MASK_VALUE_NV = 36434,
	GL_TEXTURE_BINDING_RENDERBUFFER_NV = 36435,
	GL_TEXTURE_RENDERBUFFER_DATA_STORE_BINDING_NV = 36436,
	GL_TEXTURE_RENDERBUFFER_NV = 36437,
	GL_SAMPLER_RENDERBUFFER_NV = 36438,
	GL_INT_SAMPLER_RENDERBUFFER_NV = 36439,
	GL_UNSIGNED_INT_SAMPLER_RENDERBUFFER_NV = 36440,
	GL_MAX_SAMPLE_MASK_WORDS_NV = 36441,
	GL_NV_fence = 1,
	GL_ALL_COMPLETED_NV = 34034,
	GL_FENCE_STATUS_NV = 34035,
	GL_FENCE_CONDITION_NV = 34036,
	GL_NV_fill_rectangle = 1,
	GL_FILL_RECTANGLE_NV = 37692,
	GL_NV_float_buffer = 1,
	GL_FLOAT_R_NV = 34944,
	GL_FLOAT_RG_NV = 34945,
	GL_FLOAT_RGB_NV = 34946,
	GL_FLOAT_RGBA_NV = 34947,
	GL_FLOAT_R16_NV = 34948,
	GL_FLOAT_R32_NV = 34949,
	GL_FLOAT_RG16_NV = 34950,
	GL_FLOAT_RG32_NV = 34951,
	GL_FLOAT_RGB16_NV = 34952,
	GL_FLOAT_RGB32_NV = 34953,
	GL_FLOAT_RGBA16_NV = 34954,
	GL_FLOAT_RGBA32_NV = 34955,
	GL_TEXTURE_FLOAT_COMPONENTS_NV = 34956,
	GL_FLOAT_CLEAR_COLOR_VALUE_NV = 34957,
	GL_FLOAT_RGBA_MODE_NV = 34958,
	GL_NV_fog_distance = 1,
	GL_FOG_DISTANCE_MODE_NV = 34138,
	GL_EYE_RADIAL_NV = 34139,
	GL_EYE_PLANE_ABSOLUTE_NV = 34140,
	GL_NV_fragment_coverage_to_color = 1,
	GL_FRAGMENT_COVERAGE_TO_COLOR_NV = 37597,
	GL_FRAGMENT_COVERAGE_COLOR_NV = 37598,
	GL_NV_fragment_program = 1,
	GL_MAX_FRAGMENT_PROGRAM_LOCAL_PARAMETERS_NV = 34920,
	GL_FRAGMENT_PROGRAM_NV = 34928,
	GL_MAX_TEXTURE_COORDS_NV = 34929,
	GL_MAX_TEXTURE_IMAGE_UNITS_NV = 34930,
	GL_FRAGMENT_PROGRAM_BINDING_NV = 34931,
	GL_PROGRAM_ERROR_STRING_NV = 34932,
	GL_NV_fragment_program2 = 1,
	GL_MAX_PROGRAM_EXEC_INSTRUCTIONS_NV = 35060,
	GL_MAX_PROGRAM_CALL_DEPTH_NV = 35061,
	GL_MAX_PROGRAM_IF_DEPTH_NV = 35062,
	GL_MAX_PROGRAM_LOOP_DEPTH_NV = 35063,
	GL_MAX_PROGRAM_LOOP_COUNT_NV = 35064,
	GL_NV_fragment_program4 = 1,
	GL_NV_fragment_program_option = 1,
	GL_NV_fragment_shader_barycentric = 1,
	GL_NV_fragment_shader_interlock = 1,
	GL_NV_framebuffer_mixed_samples = 1,
	GL_COVERAGE_MODULATION_TABLE_NV = 37681,
	GL_COLOR_SAMPLES_NV = 36384,
	GL_DEPTH_SAMPLES_NV = 37677,
	GL_STENCIL_SAMPLES_NV = 37678,
	GL_MIXED_DEPTH_SAMPLES_SUPPORTED_NV = 37679,
	GL_MIXED_STENCIL_SAMPLES_SUPPORTED_NV = 37680,
	GL_COVERAGE_MODULATION_NV = 37682,
	GL_COVERAGE_MODULATION_TABLE_SIZE_NV = 37683,
	GL_NV_framebuffer_multisample_coverage = 1,
	GL_RENDERBUFFER_COVERAGE_SAMPLES_NV = 36011,
	GL_RENDERBUFFER_COLOR_SAMPLES_NV = 36368,
	GL_MAX_MULTISAMPLE_COVERAGE_MODES_NV = 36369,
	GL_MULTISAMPLE_COVERAGE_MODES_NV = 36370,
	GL_NV_geometry_program4 = 1,
	GL_GEOMETRY_PROGRAM_NV = 35878,
	GL_MAX_PROGRAM_OUTPUT_VERTICES_NV = 35879,
	GL_MAX_PROGRAM_TOTAL_OUTPUT_COMPONENTS_NV = 35880,
	GL_NV_geometry_shader4 = 1,
	GL_NV_geometry_shader_passthrough = 1,
	GL_NV_gpu_multicast = 1,
	GL_PER_GPU_STORAGE_BIT_NV = 2048,
	GL_MULTICAST_GPUS_NV = 37562,
	GL_RENDER_GPU_MASK_NV = 38232,
	GL_PER_GPU_STORAGE_NV = 38216,
	GL_MULTICAST_PROGRAMMABLE_SAMPLE_LOCATION_NV = 38217,
	GL_NV_gpu_program4 = 1,
	GL_MIN_PROGRAM_TEXEL_OFFSET_NV = 35076,
	GL_MAX_PROGRAM_TEXEL_OFFSET_NV = 35077,
	GL_PROGRAM_ATTRIB_COMPONENTS_NV = 35078,
	GL_PROGRAM_RESULT_COMPONENTS_NV = 35079,
	GL_MAX_PROGRAM_ATTRIB_COMPONENTS_NV = 35080,
	GL_MAX_PROGRAM_RESULT_COMPONENTS_NV = 35081,
	GL_MAX_PROGRAM_GENERIC_ATTRIBS_NV = 36261,
	GL_MAX_PROGRAM_GENERIC_RESULTS_NV = 36262,
	GL_NV_gpu_program5 = 1,
	GL_MAX_GEOMETRY_PROGRAM_INVOCATIONS_NV = 36442,
	GL_MIN_FRAGMENT_INTERPOLATION_OFFSET_NV = 36443,
	GL_MAX_FRAGMENT_INTERPOLATION_OFFSET_NV = 36444,
	GL_FRAGMENT_PROGRAM_INTERPOLATION_OFFSET_BITS_NV = 36445,
	GL_MIN_PROGRAM_TEXTURE_GATHER_OFFSET_NV = 36446,
	GL_MAX_PROGRAM_TEXTURE_GATHER_OFFSET_NV = 36447,
	GL_MAX_PROGRAM_SUBROUTINE_PARAMETERS_NV = 36676,
	GL_MAX_PROGRAM_SUBROUTINE_NUM_NV = 36677,
	GL_NV_gpu_program5_mem_extended = 1,
	GL_NV_gpu_shader5 = 1,
	GL_NV_half_float = 1,
	GL_HALF_FLOAT_NV = 5131,
	GL_NV_internalformat_sample_query = 1,
	GL_MULTISAMPLES_NV = 37745,
	GL_SUPERSAMPLE_SCALE_X_NV = 37746,
	GL_SUPERSAMPLE_SCALE_Y_NV = 37747,
	GL_CONFORMANT_NV = 37748,
	GL_NV_light_max_exponent = 1,
	GL_MAX_SHININESS_NV = 34052,
	GL_MAX_SPOT_EXPONENT_NV = 34053,
	GL_NV_memory_attachment = 1,
	GL_ATTACHED_MEMORY_OBJECT_NV = 38308,
	GL_ATTACHED_MEMORY_OFFSET_NV = 38309,
	GL_MEMORY_ATTACHABLE_ALIGNMENT_NV = 38310,
	GL_MEMORY_ATTACHABLE_SIZE_NV = 38311,
	GL_MEMORY_ATTACHABLE_NV = 38312,
	GL_DETACHED_MEMORY_INCARNATION_NV = 38313,
	GL_DETACHED_TEXTURES_NV = 38314,
	GL_DETACHED_BUFFERS_NV = 38315,
	GL_MAX_DETACHED_TEXTURES_NV = 38316,
	GL_MAX_DETACHED_BUFFERS_NV = 38317,
	GL_NV_memory_object_sparse = 1,
	GL_NV_mesh_shader = 1,
	GL_MESH_SHADER_NV = 38233,
	GL_TASK_SHADER_NV = 38234,
	GL_MAX_MESH_UNIFORM_BLOCKS_NV = 36448,
	GL_MAX_MESH_TEXTURE_IMAGE_UNITS_NV = 36449,
	GL_MAX_MESH_IMAGE_UNIFORMS_NV = 36450,
	GL_MAX_MESH_UNIFORM_COMPONENTS_NV = 36451,
	GL_MAX_MESH_ATOMIC_COUNTER_BUFFERS_NV = 36452,
	GL_MAX_MESH_ATOMIC_COUNTERS_NV = 36453,
	GL_MAX_MESH_SHADER_STORAGE_BLOCKS_NV = 36454,
	GL_MAX_COMBINED_MESH_UNIFORM_COMPONENTS_NV = 36455,
	GL_MAX_TASK_UNIFORM_BLOCKS_NV = 36456,
	GL_MAX_TASK_TEXTURE_IMAGE_UNITS_NV = 36457,
	GL_MAX_TASK_IMAGE_UNIFORMS_NV = 36458,
	GL_MAX_TASK_UNIFORM_COMPONENTS_NV = 36459,
	GL_MAX_TASK_ATOMIC_COUNTER_BUFFERS_NV = 36460,
	GL_MAX_TASK_ATOMIC_COUNTERS_NV = 36461,
	GL_MAX_TASK_SHADER_STORAGE_BLOCKS_NV = 36462,
	GL_MAX_COMBINED_TASK_UNIFORM_COMPONENTS_NV = 36463,
	GL_MAX_MESH_WORK_GROUP_INVOCATIONS_NV = 38306,
	GL_MAX_TASK_WORK_GROUP_INVOCATIONS_NV = 38307,
	GL_MAX_MESH_TOTAL_MEMORY_SIZE_NV = 38198,
	GL_MAX_TASK_TOTAL_MEMORY_SIZE_NV = 38199,
	GL_MAX_MESH_OUTPUT_VERTICES_NV = 38200,
	GL_MAX_MESH_OUTPUT_PRIMITIVES_NV = 38201,
	GL_MAX_TASK_OUTPUT_COUNT_NV = 38202,
	GL_MAX_DRAW_MESH_TASKS_COUNT_NV = 38205,
	GL_MAX_MESH_VIEWS_NV = 38231,
	GL_MESH_OUTPUT_PER_VERTEX_GRANULARITY_NV = 37599,
	GL_MESH_OUTPUT_PER_PRIMITIVE_GRANULARITY_NV = 38211,
	GL_MAX_MESH_WORK_GROUP_SIZE_NV = 38203,
	GL_MAX_TASK_WORK_GROUP_SIZE_NV = 38204,
	GL_MESH_WORK_GROUP_SIZE_NV = 38206,
	GL_TASK_WORK_GROUP_SIZE_NV = 38207,
	GL_MESH_VERTICES_OUT_NV = 38265,
	GL_MESH_PRIMITIVES_OUT_NV = 38266,
	GL_MESH_OUTPUT_TYPE_NV = 38267,
	GL_UNIFORM_BLOCK_REFERENCED_BY_MESH_SHADER_NV = 38300,
	GL_UNIFORM_BLOCK_REFERENCED_BY_TASK_SHADER_NV = 38301,
	GL_REFERENCED_BY_MESH_SHADER_NV = 38304,
	GL_REFERENCED_BY_TASK_SHADER_NV = 38305,
	GL_MESH_SHADER_BIT_NV = 64,
	GL_TASK_SHADER_BIT_NV = 128,
	GL_MESH_SUBROUTINE_NV = 38268,
	GL_TASK_SUBROUTINE_NV = 38269,
	GL_MESH_SUBROUTINE_UNIFORM_NV = 38270,
	GL_TASK_SUBROUTINE_UNIFORM_NV = 38271,
	GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_MESH_SHADER_NV = 38302,
	GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_TASK_SHADER_NV = 38303,
	GL_NV_multisample_coverage = 1,
	GL_NV_multisample_filter_hint = 1,
	GL_MULTISAMPLE_FILTER_HINT_NV = 34100,
	GL_NV_occlusion_query = 1,
	GL_PIXEL_COUNTER_BITS_NV = 34916,
	GL_CURRENT_OCCLUSION_QUERY_ID_NV = 34917,
	GL_PIXEL_COUNT_NV = 34918,
	GL_PIXEL_COUNT_AVAILABLE_NV = 34919,
	GL_NV_packed_depth_stencil = 1,
	GL_DEPTH_STENCIL_NV = 34041,
	GL_UNSIGNED_INT_24_8_NV = 34042,
	GL_NV_parameter_buffer_object = 1,
	GL_MAX_PROGRAM_PARAMETER_BUFFER_BINDINGS_NV = 36256,
	GL_MAX_PROGRAM_PARAMETER_BUFFER_SIZE_NV = 36257,
	GL_VERTEX_PROGRAM_PARAMETER_BUFFER_NV = 36258,
	GL_GEOMETRY_PROGRAM_PARAMETER_BUFFER_NV = 36259,
	GL_FRAGMENT_PROGRAM_PARAMETER_BUFFER_NV = 36260,
	GL_NV_parameter_buffer_object2 = 1,
	GL_NV_path_rendering = 1,
	GL_PATH_FORMAT_SVG_NV = 36976,
	GL_PATH_FORMAT_PS_NV = 36977,
	GL_STANDARD_FONT_NAME_NV = 36978,
	GL_SYSTEM_FONT_NAME_NV = 36979,
	GL_FILE_NAME_NV = 36980,
	GL_PATH_STROKE_WIDTH_NV = 36981,
	GL_PATH_END_CAPS_NV = 36982,
	GL_PATH_INITIAL_END_CAP_NV = 36983,
	GL_PATH_TERMINAL_END_CAP_NV = 36984,
	GL_PATH_JOIN_STYLE_NV = 36985,
	GL_PATH_MITER_LIMIT_NV = 36986,
	GL_PATH_DASH_CAPS_NV = 36987,
	GL_PATH_INITIAL_DASH_CAP_NV = 36988,
	GL_PATH_TERMINAL_DASH_CAP_NV = 36989,
	GL_PATH_DASH_OFFSET_NV = 36990,
	GL_PATH_CLIENT_LENGTH_NV = 36991,
	GL_PATH_FILL_MODE_NV = 36992,
	GL_PATH_FILL_MASK_NV = 36993,
	GL_PATH_FILL_COVER_MODE_NV = 36994,
	GL_PATH_STROKE_COVER_MODE_NV = 36995,
	GL_PATH_STROKE_MASK_NV = 36996,
	GL_COUNT_UP_NV = 37000,
	GL_COUNT_DOWN_NV = 37001,
	GL_PATH_OBJECT_BOUNDING_BOX_NV = 37002,
	GL_CONVEX_HULL_NV = 37003,
	GL_BOUNDING_BOX_NV = 37005,
	GL_TRANSLATE_X_NV = 37006,
	GL_TRANSLATE_Y_NV = 37007,
	GL_TRANSLATE_2D_NV = 37008,
	GL_TRANSLATE_3D_NV = 37009,
	GL_AFFINE_2D_NV = 37010,
	GL_AFFINE_3D_NV = 37012,
	GL_TRANSPOSE_AFFINE_2D_NV = 37014,
	GL_TRANSPOSE_AFFINE_3D_NV = 37016,
	GL_UTF8_NV = 37018,
	GL_UTF16_NV = 37019,
	GL_BOUNDING_BOX_OF_BOUNDING_BOXES_NV = 37020,
	GL_PATH_COMMAND_COUNT_NV = 37021,
	GL_PATH_COORD_COUNT_NV = 37022,
	GL_PATH_DASH_ARRAY_COUNT_NV = 37023,
	GL_PATH_COMPUTED_LENGTH_NV = 37024,
	GL_PATH_FILL_BOUNDING_BOX_NV = 37025,
	GL_PATH_STROKE_BOUNDING_BOX_NV = 37026,
	GL_SQUARE_NV = 37027,
	GL_ROUND_NV = 37028,
	GL_TRIANGULAR_NV = 37029,
	GL_BEVEL_NV = 37030,
	GL_MITER_REVERT_NV = 37031,
	GL_MITER_TRUNCATE_NV = 37032,
	GL_SKIP_MISSING_GLYPH_NV = 37033,
	GL_USE_MISSING_GLYPH_NV = 37034,
	GL_PATH_ERROR_POSITION_NV = 37035,
	GL_ACCUM_ADJACENT_PAIRS_NV = 37037,
	GL_ADJACENT_PAIRS_NV = 37038,
	GL_FIRST_TO_REST_NV = 37039,
	GL_PATH_GEN_MODE_NV = 37040,
	GL_PATH_GEN_COEFF_NV = 37041,
	GL_PATH_GEN_COMPONENTS_NV = 37043,
	GL_PATH_STENCIL_FUNC_NV = 37047,
	GL_PATH_STENCIL_REF_NV = 37048,
	GL_PATH_STENCIL_VALUE_MASK_NV = 37049,
	GL_PATH_STENCIL_DEPTH_OFFSET_FACTOR_NV = 37053,
	GL_PATH_STENCIL_DEPTH_OFFSET_UNITS_NV = 37054,
	GL_PATH_COVER_DEPTH_FUNC_NV = 37055,
	GL_PATH_DASH_OFFSET_RESET_NV = 37044,
	GL_MOVE_TO_RESETS_NV = 37045,
	GL_MOVE_TO_CONTINUES_NV = 37046,
	GL_CLOSE_PATH_NV = 0,
	GL_MOVE_TO_NV = 2,
	GL_RELATIVE_MOVE_TO_NV = 3,
	GL_LINE_TO_NV = 4,
	GL_RELATIVE_LINE_TO_NV = 5,
	GL_HORIZONTAL_LINE_TO_NV = 6,
	GL_RELATIVE_HORIZONTAL_LINE_TO_NV = 7,
	GL_VERTICAL_LINE_TO_NV = 8,
	GL_RELATIVE_VERTICAL_LINE_TO_NV = 9,
	GL_QUADRATIC_CURVE_TO_NV = 10,
	GL_RELATIVE_QUADRATIC_CURVE_TO_NV = 11,
	GL_CUBIC_CURVE_TO_NV = 12,
	GL_RELATIVE_CUBIC_CURVE_TO_NV = 13,
	GL_SMOOTH_QUADRATIC_CURVE_TO_NV = 14,
	GL_RELATIVE_SMOOTH_QUADRATIC_CURVE_TO_NV = 15,
	GL_SMOOTH_CUBIC_CURVE_TO_NV = 16,
	GL_RELATIVE_SMOOTH_CUBIC_CURVE_TO_NV = 17,
	GL_SMALL_CCW_ARC_TO_NV = 18,
	GL_RELATIVE_SMALL_CCW_ARC_TO_NV = 19,
	GL_SMALL_CW_ARC_TO_NV = 20,
	GL_RELATIVE_SMALL_CW_ARC_TO_NV = 21,
	GL_LARGE_CCW_ARC_TO_NV = 22,
	GL_RELATIVE_LARGE_CCW_ARC_TO_NV = 23,
	GL_LARGE_CW_ARC_TO_NV = 24,
	GL_RELATIVE_LARGE_CW_ARC_TO_NV = 25,
	GL_RESTART_PATH_NV = 240,
	GL_DUP_FIRST_CUBIC_CURVE_TO_NV = 242,
	GL_DUP_LAST_CUBIC_CURVE_TO_NV = 244,
	GL_RECT_NV = 246,
	GL_CIRCULAR_CCW_ARC_TO_NV = 248,
	GL_CIRCULAR_CW_ARC_TO_NV = 250,
	GL_CIRCULAR_TANGENT_ARC_TO_NV = 252,
	GL_ARC_TO_NV = 254,
	GL_RELATIVE_ARC_TO_NV = 255,
	GL_BOLD_BIT_NV = 1,
	GL_ITALIC_BIT_NV = 2,
	GL_GLYPH_WIDTH_BIT_NV = 1,
	GL_GLYPH_HEIGHT_BIT_NV = 2,
	GL_GLYPH_HORIZONTAL_BEARING_X_BIT_NV = 4,
	GL_GLYPH_HORIZONTAL_BEARING_Y_BIT_NV = 8,
	GL_GLYPH_HORIZONTAL_BEARING_ADVANCE_BIT_NV = 16,
	GL_GLYPH_VERTICAL_BEARING_X_BIT_NV = 32,
	GL_GLYPH_VERTICAL_BEARING_Y_BIT_NV = 64,
	GL_GLYPH_VERTICAL_BEARING_ADVANCE_BIT_NV = 128,
	GL_GLYPH_HAS_KERNING_BIT_NV = 256,
	GL_FONT_X_MIN_BOUNDS_BIT_NV = 65536,
	GL_FONT_Y_MIN_BOUNDS_BIT_NV = 131072,
	GL_FONT_X_MAX_BOUNDS_BIT_NV = 262144,
	GL_FONT_Y_MAX_BOUNDS_BIT_NV = 524288,
	GL_FONT_UNITS_PER_EM_BIT_NV = 1048576,
	GL_FONT_ASCENDER_BIT_NV = 2097152,
	GL_FONT_DESCENDER_BIT_NV = 4194304,
	GL_FONT_HEIGHT_BIT_NV = 8388608,
	GL_FONT_MAX_ADVANCE_WIDTH_BIT_NV = 16777216,
	GL_FONT_MAX_ADVANCE_HEIGHT_BIT_NV = 33554432,
	GL_FONT_UNDERLINE_POSITION_BIT_NV = 67108864,
	GL_FONT_UNDERLINE_THICKNESS_BIT_NV = 134217728,
	GL_FONT_HAS_KERNING_BIT_NV = 268435456,
	GL_ROUNDED_RECT_NV = 232,
	GL_RELATIVE_ROUNDED_RECT_NV = 233,
	GL_ROUNDED_RECT2_NV = 234,
	GL_RELATIVE_ROUNDED_RECT2_NV = 235,
	GL_ROUNDED_RECT4_NV = 236,
	GL_RELATIVE_ROUNDED_RECT4_NV = 237,
	GL_ROUNDED_RECT8_NV = 238,
	GL_RELATIVE_ROUNDED_RECT8_NV = 239,
	GL_RELATIVE_RECT_NV = 247,
	GL_FONT_GLYPHS_AVAILABLE_NV = 37736,
	GL_FONT_TARGET_UNAVAILABLE_NV = 37737,
	GL_FONT_UNAVAILABLE_NV = 37738,
	GL_FONT_UNINTELLIGIBLE_NV = 37739,
	GL_CONIC_CURVE_TO_NV = 26,
	GL_RELATIVE_CONIC_CURVE_TO_NV = 27,
	GL_FONT_NUM_GLYPH_INDICES_BIT_NV = 536870912,
	GL_STANDARD_FONT_FORMAT_NV = 37740,
	GL_2_BYTES_NV = 5127,
	GL_3_BYTES_NV = 5128,
	GL_4_BYTES_NV = 5129,
	GL_EYE_LINEAR_NV = 9216,
	GL_OBJECT_LINEAR_NV = 9217,
	GL_CONSTANT_NV = 34166,
	GL_PATH_FOG_GEN_MODE_NV = 37036,
	GL_PRIMARY_COLOR_NV = 34092,
	GL_SECONDARY_COLOR_NV = 34093,
	GL_PATH_GEN_COLOR_FORMAT_NV = 37042,
	GL_PATH_PROJECTION_NV = 5889,
	GL_PATH_MODELVIEW_NV = 5888,
	GL_PATH_MODELVIEW_STACK_DEPTH_NV = 2979,
	GL_PATH_MODELVIEW_MATRIX_NV = 2982,
	GL_PATH_MAX_MODELVIEW_STACK_DEPTH_NV = 3382,
	GL_PATH_TRANSPOSE_MODELVIEW_MATRIX_NV = 34019,
	GL_PATH_PROJECTION_STACK_DEPTH_NV = 2980,
	GL_PATH_PROJECTION_MATRIX_NV = 2983,
	GL_PATH_MAX_PROJECTION_STACK_DEPTH_NV = 3384,
	GL_PATH_TRANSPOSE_PROJECTION_MATRIX_NV = 34020,
	GL_FRAGMENT_INPUT_NV = 37741,
	GL_NV_path_rendering_shared_edge = 1,
	GL_SHARED_EDGE_NV = 192,
	GL_NV_pixel_data_range = 1,
	GL_WRITE_PIXEL_DATA_RANGE_NV = 34936,
	GL_READ_PIXEL_DATA_RANGE_NV = 34937,
	GL_WRITE_PIXEL_DATA_RANGE_LENGTH_NV = 34938,
	GL_READ_PIXEL_DATA_RANGE_LENGTH_NV = 34939,
	GL_WRITE_PIXEL_DATA_RANGE_POINTER_NV = 34940,
	GL_READ_PIXEL_DATA_RANGE_POINTER_NV = 34941,
	GL_NV_point_sprite = 1,
	GL_POINT_SPRITE_NV = 34913,
	GL_COORD_REPLACE_NV = 34914,
	GL_POINT_SPRITE_R_MODE_NV = 34915,
	GL_NV_present_video = 1,
	GL_FRAME_NV = 36390,
	GL_FIELDS_NV = 36391,
	GL_CURRENT_TIME_NV = 36392,
	GL_NUM_FILL_STREAMS_NV = 36393,
	GL_PRESENT_TIME_NV = 36394,
	GL_PRESENT_DURATION_NV = 36395,
	GL_NV_primitive_restart = 1,
	GL_PRIMITIVE_RESTART_NV = 34136,
	GL_PRIMITIVE_RESTART_INDEX_NV = 34137,
	GL_NV_primitive_shading_rate = 1,
	GL_SHADING_RATE_IMAGE_PER_PRIMITIVE_NV = 38321,
	GL_SHADING_RATE_IMAGE_PALETTE_COUNT_NV = 38322,
	GL_NV_query_resource = 1,
	GL_QUERY_RESOURCE_TYPE_VIDMEM_ALLOC_NV = 38208,
	GL_QUERY_RESOURCE_MEMTYPE_VIDMEM_NV = 38210,
	GL_QUERY_RESOURCE_SYS_RESERVED_NV = 38212,
	GL_QUERY_RESOURCE_TEXTURE_NV = 38213,
	GL_QUERY_RESOURCE_RENDERBUFFER_NV = 38214,
	GL_QUERY_RESOURCE_BUFFEROBJECT_NV = 38215,
	GL_NV_query_resource_tag = 1,
	GL_NV_register_combiners = 1,
	GL_REGISTER_COMBINERS_NV = 34082,
	GL_VARIABLE_A_NV = 34083,
	GL_VARIABLE_B_NV = 34084,
	GL_VARIABLE_C_NV = 34085,
	GL_VARIABLE_D_NV = 34086,
	GL_VARIABLE_E_NV = 34087,
	GL_VARIABLE_F_NV = 34088,
	GL_VARIABLE_G_NV = 34089,
	GL_CONSTANT_COLOR0_NV = 34090,
	GL_CONSTANT_COLOR1_NV = 34091,
	GL_SPARE0_NV = 34094,
	GL_SPARE1_NV = 34095,
	GL_DISCARD_NV = 34096,
	GL_E_TIMES_F_NV = 34097,
	GL_SPARE0_PLUS_SECONDARY_COLOR_NV = 34098,
	GL_UNSIGNED_IDENTITY_NV = 34102,
	GL_UNSIGNED_INVERT_NV = 34103,
	GL_EXPAND_NORMAL_NV = 34104,
	GL_EXPAND_NEGATE_NV = 34105,
	GL_HALF_BIAS_NORMAL_NV = 34106,
	GL_HALF_BIAS_NEGATE_NV = 34107,
	GL_SIGNED_IDENTITY_NV = 34108,
	GL_SIGNED_NEGATE_NV = 34109,
	GL_SCALE_BY_TWO_NV = 34110,
	GL_SCALE_BY_FOUR_NV = 34111,
	GL_SCALE_BY_ONE_HALF_NV = 34112,
	GL_BIAS_BY_NEGATIVE_ONE_HALF_NV = 34113,
	GL_COMBINER_INPUT_NV = 34114,
	GL_COMBINER_MAPPING_NV = 34115,
	GL_COMBINER_COMPONENT_USAGE_NV = 34116,
	GL_COMBINER_AB_DOT_PRODUCT_NV = 34117,
	GL_COMBINER_CD_DOT_PRODUCT_NV = 34118,
	GL_COMBINER_MUX_SUM_NV = 34119,
	GL_COMBINER_SCALE_NV = 34120,
	GL_COMBINER_BIAS_NV = 34121,
	GL_COMBINER_AB_OUTPUT_NV = 34122,
	GL_COMBINER_CD_OUTPUT_NV = 34123,
	GL_COMBINER_SUM_OUTPUT_NV = 34124,
	GL_MAX_GENERAL_COMBINERS_NV = 34125,
	GL_NUM_GENERAL_COMBINERS_NV = 34126,
	GL_COLOR_SUM_CLAMP_NV = 34127,
	GL_COMBINER0_NV = 34128,
	GL_COMBINER1_NV = 34129,
	GL_COMBINER2_NV = 34130,
	GL_COMBINER3_NV = 34131,
	GL_COMBINER4_NV = 34132,
	GL_COMBINER5_NV = 34133,
	GL_COMBINER6_NV = 34134,
	GL_COMBINER7_NV = 34135,
	GL_NV_register_combiners2 = 1,
	GL_PER_STAGE_CONSTANTS_NV = 34101,
	GL_NV_representative_fragment_test = 1,
	GL_REPRESENTATIVE_FRAGMENT_TEST_NV = 37759,
	GL_NV_robustness_video_memory_purge = 1,
	GL_PURGED_CONTEXT_RESET_NV = 37563,
	GL_NV_sample_locations = 1,
	GL_SAMPLE_LOCATION_SUBPIXEL_BITS_NV = 37693,
	GL_SAMPLE_LOCATION_PIXEL_GRID_WIDTH_NV = 37694,
	GL_SAMPLE_LOCATION_PIXEL_GRID_HEIGHT_NV = 37695,
	GL_PROGRAMMABLE_SAMPLE_LOCATION_TABLE_SIZE_NV = 37696,
	GL_SAMPLE_LOCATION_NV = 36432,
	GL_PROGRAMMABLE_SAMPLE_LOCATION_NV = 37697,
	GL_FRAMEBUFFER_PROGRAMMABLE_SAMPLE_LOCATIONS_NV = 37698,
	GL_FRAMEBUFFER_SAMPLE_LOCATION_PIXEL_GRID_NV = 37699,
	GL_NV_sample_mask_override_coverage = 1,
	GL_NV_scissor_exclusive = 1,
	GL_SCISSOR_TEST_EXCLUSIVE_NV = 38229,
	GL_SCISSOR_BOX_EXCLUSIVE_NV = 38230,
	GL_NV_shader_atomic_counters = 1,
	GL_NV_shader_atomic_float = 1,
	GL_NV_shader_atomic_float64 = 1,
	GL_NV_shader_atomic_fp16_vector = 1,
	GL_NV_shader_atomic_int64 = 1,
	GL_NV_shader_buffer_load = 1,
	GL_BUFFER_GPU_ADDRESS_NV = 36637,
	GL_GPU_ADDRESS_NV = 36660,
	GL_MAX_SHADER_BUFFER_ADDRESS_NV = 36661,
	GL_NV_shader_buffer_store = 1,
	GL_SHADER_GLOBAL_ACCESS_BARRIER_BIT_NV = 16,
	GL_NV_shader_storage_buffer_object = 1,
	GL_NV_shader_subgroup_partitioned = 1,
	GL_SUBGROUP_FEATURE_PARTITIONED_BIT_NV = 256,
	GL_NV_shader_texture_footprint = 1,
	GL_NV_shader_thread_group = 1,
	GL_WARP_SIZE_NV = 37689,
	GL_WARPS_PER_SM_NV = 37690,
	GL_SM_COUNT_NV = 37691,
	GL_NV_shader_thread_shuffle = 1,
	GL_NV_shading_rate_image = 1,
	GL_SHADING_RATE_IMAGE_NV = 38243,
	GL_SHADING_RATE_NO_INVOCATIONS_NV = 38244,
	GL_SHADING_RATE_1_INVOCATION_PER_PIXEL_NV = 38245,
	GL_SHADING_RATE_1_INVOCATION_PER_1X2_PIXELS_NV = 38246,
	GL_SHADING_RATE_1_INVOCATION_PER_2X1_PIXELS_NV = 38247,
	GL_SHADING_RATE_1_INVOCATION_PER_2X2_PIXELS_NV = 38248,
	GL_SHADING_RATE_1_INVOCATION_PER_2X4_PIXELS_NV = 38249,
	GL_SHADING_RATE_1_INVOCATION_PER_4X2_PIXELS_NV = 38250,
	GL_SHADING_RATE_1_INVOCATION_PER_4X4_PIXELS_NV = 38251,
	GL_SHADING_RATE_2_INVOCATIONS_PER_PIXEL_NV = 38252,
	GL_SHADING_RATE_4_INVOCATIONS_PER_PIXEL_NV = 38253,
	GL_SHADING_RATE_8_INVOCATIONS_PER_PIXEL_NV = 38254,
	GL_SHADING_RATE_16_INVOCATIONS_PER_PIXEL_NV = 38255,
	GL_SHADING_RATE_IMAGE_BINDING_NV = 38235,
	GL_SHADING_RATE_IMAGE_TEXEL_WIDTH_NV = 38236,
	GL_SHADING_RATE_IMAGE_TEXEL_HEIGHT_NV = 38237,
	GL_SHADING_RATE_IMAGE_PALETTE_SIZE_NV = 38238,
	GL_MAX_COARSE_FRAGMENT_SAMPLES_NV = 38239,
	GL_SHADING_RATE_SAMPLE_ORDER_DEFAULT_NV = 38318,
	GL_SHADING_RATE_SAMPLE_ORDER_PIXEL_MAJOR_NV = 38319,
	GL_SHADING_RATE_SAMPLE_ORDER_SAMPLE_MAJOR_NV = 38320,
	GL_NV_stereo_view_rendering = 1,
	GL_NV_tessellation_program5 = 1,
	GL_MAX_PROGRAM_PATCH_ATTRIBS_NV = 34520,
	GL_TESS_CONTROL_PROGRAM_NV = 35102,
	GL_TESS_EVALUATION_PROGRAM_NV = 35103,
	GL_TESS_CONTROL_PROGRAM_PARAMETER_BUFFER_NV = 35956,
	GL_TESS_EVALUATION_PROGRAM_PARAMETER_BUFFER_NV = 35957,
	GL_NV_texgen_emboss = 1,
	GL_EMBOSS_LIGHT_NV = 34141,
	GL_EMBOSS_CONSTANT_NV = 34142,
	GL_EMBOSS_MAP_NV = 34143,
	GL_NV_texgen_reflection = 1,
	GL_NORMAL_MAP_NV = 34065,
	GL_REFLECTION_MAP_NV = 34066,
	GL_NV_texture_barrier = 1,
	GL_NV_texture_compression_vtc = 1,
	GL_NV_texture_env_combine4 = 1,
	GL_COMBINE4_NV = 34051,
	GL_SOURCE3_RGB_NV = 34179,
	GL_SOURCE3_ALPHA_NV = 34187,
	GL_OPERAND3_RGB_NV = 34195,
	GL_OPERAND3_ALPHA_NV = 34203,
	GL_NV_texture_expand_normal = 1,
	GL_TEXTURE_UNSIGNED_REMAP_MODE_NV = 34959,
	GL_NV_texture_multisample = 1,
	GL_TEXTURE_COVERAGE_SAMPLES_NV = 36933,
	GL_TEXTURE_COLOR_SAMPLES_NV = 36934,
	GL_NV_texture_rectangle = 1,
	GL_TEXTURE_RECTANGLE_NV = 34037,
	GL_TEXTURE_BINDING_RECTANGLE_NV = 34038,
	GL_PROXY_TEXTURE_RECTANGLE_NV = 34039,
	GL_MAX_RECTANGLE_TEXTURE_SIZE_NV = 34040,
	GL_NV_texture_rectangle_compressed = 1,
	GL_NV_texture_shader = 1,
	GL_OFFSET_TEXTURE_RECTANGLE_NV = 34380,
	GL_OFFSET_TEXTURE_RECTANGLE_SCALE_NV = 34381,
	GL_DOT_PRODUCT_TEXTURE_RECTANGLE_NV = 34382,
	GL_RGBA_UNSIGNED_DOT_PRODUCT_MAPPING_NV = 34521,
	GL_UNSIGNED_INT_S8_S8_8_8_NV = 34522,
	GL_UNSIGNED_INT_8_8_S8_S8_REV_NV = 34523,
	GL_DSDT_MAG_INTENSITY_NV = 34524,
	GL_SHADER_CONSISTENT_NV = 34525,
	GL_TEXTURE_SHADER_NV = 34526,
	GL_SHADER_OPERATION_NV = 34527,
	GL_CULL_MODES_NV = 34528,
	GL_OFFSET_TEXTURE_MATRIX_NV = 34529,
	GL_OFFSET_TEXTURE_SCALE_NV = 34530,
	GL_OFFSET_TEXTURE_BIAS_NV = 34531,
	GL_OFFSET_TEXTURE_2D_MATRIX_NV = 34529,
	GL_OFFSET_TEXTURE_2D_SCALE_NV = 34530,
	GL_OFFSET_TEXTURE_2D_BIAS_NV = 34531,
	GL_PREVIOUS_TEXTURE_INPUT_NV = 34532,
	GL_CONST_EYE_NV = 34533,
	GL_PASS_THROUGH_NV = 34534,
	GL_CULL_FRAGMENT_NV = 34535,
	GL_OFFSET_TEXTURE_2D_NV = 34536,
	GL_DEPENDENT_AR_TEXTURE_2D_NV = 34537,
	GL_DEPENDENT_GB_TEXTURE_2D_NV = 34538,
	GL_DOT_PRODUCT_NV = 34540,
	GL_DOT_PRODUCT_DEPTH_REPLACE_NV = 34541,
	GL_DOT_PRODUCT_TEXTURE_2D_NV = 34542,
	GL_DOT_PRODUCT_TEXTURE_CUBE_MAP_NV = 34544,
	GL_DOT_PRODUCT_DIFFUSE_CUBE_MAP_NV = 34545,
	GL_DOT_PRODUCT_REFLECT_CUBE_MAP_NV = 34546,
	GL_DOT_PRODUCT_CONST_EYE_REFLECT_CUBE_MAP_NV = 34547,
	GL_HILO_NV = 34548,
	GL_DSDT_NV = 34549,
	GL_DSDT_MAG_NV = 34550,
	GL_DSDT_MAG_VIB_NV = 34551,
	GL_HILO16_NV = 34552,
	GL_SIGNED_HILO_NV = 34553,
	GL_SIGNED_HILO16_NV = 34554,
	GL_SIGNED_RGBA_NV = 34555,
	GL_SIGNED_RGBA8_NV = 34556,
	GL_SIGNED_RGB_NV = 34558,
	GL_SIGNED_RGB8_NV = 34559,
	GL_SIGNED_LUMINANCE_NV = 34561,
	GL_SIGNED_LUMINANCE8_NV = 34562,
	GL_SIGNED_LUMINANCE_ALPHA_NV = 34563,
	GL_SIGNED_LUMINANCE8_ALPHA8_NV = 34564,
	GL_SIGNED_ALPHA_NV = 34565,
	GL_SIGNED_ALPHA8_NV = 34566,
	GL_SIGNED_INTENSITY_NV = 34567,
	GL_SIGNED_INTENSITY8_NV = 34568,
	GL_DSDT8_NV = 34569,
	GL_DSDT8_MAG8_NV = 34570,
	GL_DSDT8_MAG8_INTENSITY8_NV = 34571,
	GL_SIGNED_RGB_UNSIGNED_ALPHA_NV = 34572,
	GL_SIGNED_RGB8_UNSIGNED_ALPHA8_NV = 34573,
	GL_HI_SCALE_NV = 34574,
	GL_LO_SCALE_NV = 34575,
	GL_DS_SCALE_NV = 34576,
	GL_DT_SCALE_NV = 34577,
	GL_MAGNITUDE_SCALE_NV = 34578,
	GL_VIBRANCE_SCALE_NV = 34579,
	GL_HI_BIAS_NV = 34580,
	GL_LO_BIAS_NV = 34581,
	GL_DS_BIAS_NV = 34582,
	GL_DT_BIAS_NV = 34583,
	GL_MAGNITUDE_BIAS_NV = 34584,
	GL_VIBRANCE_BIAS_NV = 34585,
	GL_TEXTURE_BORDER_VALUES_NV = 34586,
	GL_TEXTURE_HI_SIZE_NV = 34587,
	GL_TEXTURE_LO_SIZE_NV = 34588,
	GL_TEXTURE_DS_SIZE_NV = 34589,
	GL_TEXTURE_DT_SIZE_NV = 34590,
	GL_TEXTURE_MAG_SIZE_NV = 34591,
	GL_NV_texture_shader2 = 1,
	GL_DOT_PRODUCT_TEXTURE_3D_NV = 34543,
	GL_NV_texture_shader3 = 1,
	GL_OFFSET_PROJECTIVE_TEXTURE_2D_NV = 34896,
	GL_OFFSET_PROJECTIVE_TEXTURE_2D_SCALE_NV = 34897,
	GL_OFFSET_PROJECTIVE_TEXTURE_RECTANGLE_NV = 34898,
	GL_OFFSET_PROJECTIVE_TEXTURE_RECTANGLE_SCALE_NV = 34899,
	GL_OFFSET_HILO_TEXTURE_2D_NV = 34900,
	GL_OFFSET_HILO_TEXTURE_RECTANGLE_NV = 34901,
	GL_OFFSET_HILO_PROJECTIVE_TEXTURE_2D_NV = 34902,
	GL_OFFSET_HILO_PROJECTIVE_TEXTURE_RECTANGLE_NV = 34903,
	GL_DEPENDENT_HILO_TEXTURE_2D_NV = 34904,
	GL_DEPENDENT_RGB_TEXTURE_3D_NV = 34905,
	GL_DEPENDENT_RGB_TEXTURE_CUBE_MAP_NV = 34906,
	GL_DOT_PRODUCT_PASS_THROUGH_NV = 34907,
	GL_DOT_PRODUCT_TEXTURE_1D_NV = 34908,
	GL_DOT_PRODUCT_AFFINE_DEPTH_REPLACE_NV = 34909,
	GL_HILO8_NV = 34910,
	GL_SIGNED_HILO8_NV = 34911,
	GL_FORCE_BLUE_TO_ONE_NV = 34912,
	GL_NV_timeline_semaphore = 1,
	GL_TIMELINE_SEMAPHORE_VALUE_NV = 38293,
	GL_SEMAPHORE_TYPE_NV = 38323,
	GL_SEMAPHORE_TYPE_BINARY_NV = 38324,
	GL_SEMAPHORE_TYPE_TIMELINE_NV = 38325,
	GL_MAX_TIMELINE_SEMAPHORE_VALUE_DIFFERENCE_NV = 38326,
	GL_NV_transform_feedback = 1,
	GL_BACK_PRIMARY_COLOR_NV = 35959,
	GL_BACK_SECONDARY_COLOR_NV = 35960,
	GL_TEXTURE_COORD_NV = 35961,
	GL_CLIP_DISTANCE_NV = 35962,
	GL_VERTEX_ID_NV = 35963,
	GL_PRIMITIVE_ID_NV = 35964,
	GL_GENERIC_ATTRIB_NV = 35965,
	GL_TRANSFORM_FEEDBACK_ATTRIBS_NV = 35966,
	GL_TRANSFORM_FEEDBACK_BUFFER_MODE_NV = 35967,
	GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_COMPONENTS_NV = 35968,
	GL_ACTIVE_VARYINGS_NV = 35969,
	GL_ACTIVE_VARYING_MAX_LENGTH_NV = 35970,
	GL_TRANSFORM_FEEDBACK_VARYINGS_NV = 35971,
	GL_TRANSFORM_FEEDBACK_BUFFER_START_NV = 35972,
	GL_TRANSFORM_FEEDBACK_BUFFER_SIZE_NV = 35973,
	GL_TRANSFORM_FEEDBACK_RECORD_NV = 35974,
	GL_PRIMITIVES_GENERATED_NV = 35975,
	GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN_NV = 35976,
	GL_RASTERIZER_DISCARD_NV = 35977,
	GL_MAX_TRANSFORM_FEEDBACK_INTERLEAVED_COMPONENTS_NV = 35978,
	GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_ATTRIBS_NV = 35979,
	GL_INTERLEAVED_ATTRIBS_NV = 35980,
	GL_SEPARATE_ATTRIBS_NV = 35981,
	GL_TRANSFORM_FEEDBACK_BUFFER_NV = 35982,
	GL_TRANSFORM_FEEDBACK_BUFFER_BINDING_NV = 35983,
	GL_LAYER_NV = 36266,
	GL_NEXT_BUFFER_NV = -2,
	GL_SKIP_COMPONENTS4_NV = -3,
	GL_SKIP_COMPONENTS3_NV = -4,
	GL_SKIP_COMPONENTS2_NV = -5,
	GL_SKIP_COMPONENTS1_NV = -6,
	GL_NV_transform_feedback2 = 1,
	GL_TRANSFORM_FEEDBACK_NV = 36386,
	GL_TRANSFORM_FEEDBACK_BUFFER_PAUSED_NV = 36387,
	GL_TRANSFORM_FEEDBACK_BUFFER_ACTIVE_NV = 36388,
	GL_TRANSFORM_FEEDBACK_BINDING_NV = 36389,
	GL_NV_uniform_buffer_unified_memory = 1,
	GL_UNIFORM_BUFFER_UNIFIED_NV = 37742,
	GL_UNIFORM_BUFFER_ADDRESS_NV = 37743,
	GL_UNIFORM_BUFFER_LENGTH_NV = 37744,
	GL_NV_vdpau_interop = 1,
	GL_SURFACE_STATE_NV = 34539,
	GL_SURFACE_REGISTERED_NV = 34557,
	GL_SURFACE_MAPPED_NV = 34560,
	GL_WRITE_DISCARD_NV = 35006,
	GL_NV_vdpau_interop2 = 1,
	GL_NV_vertex_array_range = 1,
	GL_VERTEX_ARRAY_RANGE_NV = 34077,
	GL_VERTEX_ARRAY_RANGE_LENGTH_NV = 34078,
	GL_VERTEX_ARRAY_RANGE_VALID_NV = 34079,
	GL_MAX_VERTEX_ARRAY_RANGE_ELEMENT_NV = 34080,
	GL_VERTEX_ARRAY_RANGE_POINTER_NV = 34081,
	GL_NV_vertex_array_range2 = 1,
	GL_VERTEX_ARRAY_RANGE_WITHOUT_FLUSH_NV = 34099,
	GL_NV_vertex_attrib_integer_64bit = 1,
	GL_NV_vertex_buffer_unified_memory = 1,
	GL_VERTEX_ATTRIB_ARRAY_UNIFIED_NV = 36638,
	GL_ELEMENT_ARRAY_UNIFIED_NV = 36639,
	GL_VERTEX_ATTRIB_ARRAY_ADDRESS_NV = 36640,
	GL_VERTEX_ARRAY_ADDRESS_NV = 36641,
	GL_NORMAL_ARRAY_ADDRESS_NV = 36642,
	GL_COLOR_ARRAY_ADDRESS_NV = 36643,
	GL_INDEX_ARRAY_ADDRESS_NV = 36644,
	GL_TEXTURE_COORD_ARRAY_ADDRESS_NV = 36645,
	GL_EDGE_FLAG_ARRAY_ADDRESS_NV = 36646,
	GL_SECONDARY_COLOR_ARRAY_ADDRESS_NV = 36647,
	GL_FOG_COORD_ARRAY_ADDRESS_NV = 36648,
	GL_ELEMENT_ARRAY_ADDRESS_NV = 36649,
	GL_VERTEX_ATTRIB_ARRAY_LENGTH_NV = 36650,
	GL_VERTEX_ARRAY_LENGTH_NV = 36651,
	GL_NORMAL_ARRAY_LENGTH_NV = 36652,
	GL_COLOR_ARRAY_LENGTH_NV = 36653,
	GL_INDEX_ARRAY_LENGTH_NV = 36654,
	GL_TEXTURE_COORD_ARRAY_LENGTH_NV = 36655,
	GL_EDGE_FLAG_ARRAY_LENGTH_NV = 36656,
	GL_SECONDARY_COLOR_ARRAY_LENGTH_NV = 36657,
	GL_FOG_COORD_ARRAY_LENGTH_NV = 36658,
	GL_ELEMENT_ARRAY_LENGTH_NV = 36659,
	GL_DRAW_INDIRECT_UNIFIED_NV = 36672,
	GL_DRAW_INDIRECT_ADDRESS_NV = 36673,
	GL_DRAW_INDIRECT_LENGTH_NV = 36674,
	GL_NV_vertex_program = 1,
	GL_VERTEX_PROGRAM_NV = 34336,
	GL_VERTEX_STATE_PROGRAM_NV = 34337,
	GL_ATTRIB_ARRAY_SIZE_NV = 34339,
	GL_ATTRIB_ARRAY_STRIDE_NV = 34340,
	GL_ATTRIB_ARRAY_TYPE_NV = 34341,
	GL_CURRENT_ATTRIB_NV = 34342,
	GL_PROGRAM_LENGTH_NV = 34343,
	GL_PROGRAM_STRING_NV = 34344,
	GL_MODELVIEW_PROJECTION_NV = 34345,
	GL_IDENTITY_NV = 34346,
	GL_INVERSE_NV = 34347,
	GL_TRANSPOSE_NV = 34348,
	GL_INVERSE_TRANSPOSE_NV = 34349,
	GL_MAX_TRACK_MATRIX_STACK_DEPTH_NV = 34350,
	GL_MAX_TRACK_MATRICES_NV = 34351,
	GL_MATRIX0_NV = 34352,
	GL_MATRIX1_NV = 34353,
	GL_MATRIX2_NV = 34354,
	GL_MATRIX3_NV = 34355,
	GL_MATRIX4_NV = 34356,
	GL_MATRIX5_NV = 34357,
	GL_MATRIX6_NV = 34358,
	GL_MATRIX7_NV = 34359,
	GL_CURRENT_MATRIX_STACK_DEPTH_NV = 34368,
	GL_CURRENT_MATRIX_NV = 34369,
	GL_VERTEX_PROGRAM_POINT_SIZE_NV = 34370,
	GL_VERTEX_PROGRAM_TWO_SIDE_NV = 34371,
	GL_PROGRAM_PARAMETER_NV = 34372,
	GL_ATTRIB_ARRAY_POINTER_NV = 34373,
	GL_PROGRAM_TARGET_NV = 34374,
	GL_PROGRAM_RESIDENT_NV = 34375,
	GL_TRACK_MATRIX_NV = 34376,
	GL_TRACK_MATRIX_TRANSFORM_NV = 34377,
	GL_VERTEX_PROGRAM_BINDING_NV = 34378,
	GL_PROGRAM_ERROR_POSITION_NV = 34379,
	GL_VERTEX_ATTRIB_ARRAY0_NV = 34384,
	GL_VERTEX_ATTRIB_ARRAY1_NV = 34385,
	GL_VERTEX_ATTRIB_ARRAY2_NV = 34386,
	GL_VERTEX_ATTRIB_ARRAY3_NV = 34387,
	GL_VERTEX_ATTRIB_ARRAY4_NV = 34388,
	GL_VERTEX_ATTRIB_ARRAY5_NV = 34389,
	GL_VERTEX_ATTRIB_ARRAY6_NV = 34390,
	GL_VERTEX_ATTRIB_ARRAY7_NV = 34391,
	GL_VERTEX_ATTRIB_ARRAY8_NV = 34392,
	GL_VERTEX_ATTRIB_ARRAY9_NV = 34393,
	GL_VERTEX_ATTRIB_ARRAY10_NV = 34394,
	GL_VERTEX_ATTRIB_ARRAY11_NV = 34395,
	GL_VERTEX_ATTRIB_ARRAY12_NV = 34396,
	GL_VERTEX_ATTRIB_ARRAY13_NV = 34397,
	GL_VERTEX_ATTRIB_ARRAY14_NV = 34398,
	GL_VERTEX_ATTRIB_ARRAY15_NV = 34399,
	GL_MAP1_VERTEX_ATTRIB0_4_NV = 34400,
	GL_MAP1_VERTEX_ATTRIB1_4_NV = 34401,
	GL_MAP1_VERTEX_ATTRIB2_4_NV = 34402,
	GL_MAP1_VERTEX_ATTRIB3_4_NV = 34403,
	GL_MAP1_VERTEX_ATTRIB4_4_NV = 34404,
	GL_MAP1_VERTEX_ATTRIB5_4_NV = 34405,
	GL_MAP1_VERTEX_ATTRIB6_4_NV = 34406,
	GL_MAP1_VERTEX_ATTRIB7_4_NV = 34407,
	GL_MAP1_VERTEX_ATTRIB8_4_NV = 34408,
	GL_MAP1_VERTEX_ATTRIB9_4_NV = 34409,
	GL_MAP1_VERTEX_ATTRIB10_4_NV = 34410,
	GL_MAP1_VERTEX_ATTRIB11_4_NV = 34411,
	GL_MAP1_VERTEX_ATTRIB12_4_NV = 34412,
	GL_MAP1_VERTEX_ATTRIB13_4_NV = 34413,
	GL_MAP1_VERTEX_ATTRIB14_4_NV = 34414,
	GL_MAP1_VERTEX_ATTRIB15_4_NV = 34415,
	GL_MAP2_VERTEX_ATTRIB0_4_NV = 34416,
	GL_MAP2_VERTEX_ATTRIB1_4_NV = 34417,
	GL_MAP2_VERTEX_ATTRIB2_4_NV = 34418,
	GL_MAP2_VERTEX_ATTRIB3_4_NV = 34419,
	GL_MAP2_VERTEX_ATTRIB4_4_NV = 34420,
	GL_MAP2_VERTEX_ATTRIB5_4_NV = 34421,
	GL_MAP2_VERTEX_ATTRIB6_4_NV = 34422,
	GL_MAP2_VERTEX_ATTRIB7_4_NV = 34423,
	GL_MAP2_VERTEX_ATTRIB8_4_NV = 34424,
	GL_MAP2_VERTEX_ATTRIB9_4_NV = 34425,
	GL_MAP2_VERTEX_ATTRIB10_4_NV = 34426,
	GL_MAP2_VERTEX_ATTRIB11_4_NV = 34427,
	GL_MAP2_VERTEX_ATTRIB12_4_NV = 34428,
	GL_MAP2_VERTEX_ATTRIB13_4_NV = 34429,
	GL_MAP2_VERTEX_ATTRIB14_4_NV = 34430,
	GL_MAP2_VERTEX_ATTRIB15_4_NV = 34431,
	GL_NV_vertex_program1_1 = 1,
	GL_NV_vertex_program2 = 1,
	GL_NV_vertex_program2_option = 1,
	GL_NV_vertex_program3 = 1,
	GL_NV_vertex_program4 = 1,
	GL_VERTEX_ATTRIB_ARRAY_INTEGER_NV = 35069,
	GL_NV_video_capture = 1,
	GL_VIDEO_BUFFER_NV = 36896,
	GL_VIDEO_BUFFER_BINDING_NV = 36897,
	GL_FIELD_UPPER_NV = 36898,
	GL_FIELD_LOWER_NV = 36899,
	GL_NUM_VIDEO_CAPTURE_STREAMS_NV = 36900,
	GL_NEXT_VIDEO_CAPTURE_BUFFER_STATUS_NV = 36901,
	GL_VIDEO_CAPTURE_TO_422_SUPPORTED_NV = 36902,
	GL_LAST_VIDEO_CAPTURE_STATUS_NV = 36903,
	GL_VIDEO_BUFFER_PITCH_NV = 36904,
	GL_VIDEO_COLOR_CONVERSION_MATRIX_NV = 36905,
	GL_VIDEO_COLOR_CONVERSION_MAX_NV = 36906,
	GL_VIDEO_COLOR_CONVERSION_MIN_NV = 36907,
	GL_VIDEO_COLOR_CONVERSION_OFFSET_NV = 36908,
	GL_VIDEO_BUFFER_INTERNAL_FORMAT_NV = 36909,
	GL_PARTIAL_SUCCESS_NV = 36910,
	GL_SUCCESS_NV = 36911,
	GL_FAILURE_NV = 36912,
	GL_YCBYCR8_422_NV = 36913,
	GL_YCBAYCR8A_4224_NV = 36914,
	GL_Z6Y10Z6CB10Z6Y10Z6CR10_422_NV = 36915,
	GL_Z6Y10Z6CB10Z6A10Z6Y10Z6CR10Z6A10_4224_NV = 36916,
	GL_Z4Y12Z4CB12Z4Y12Z4CR12_422_NV = 36917,
	GL_Z4Y12Z4CB12Z4A12Z4Y12Z4CR12Z4A12_4224_NV = 36918,
	GL_Z4Y12Z4CB12Z4CR12_444_NV = 36919,
	GL_VIDEO_CAPTURE_FRAME_WIDTH_NV = 36920,
	GL_VIDEO_CAPTURE_FRAME_HEIGHT_NV = 36921,
	GL_VIDEO_CAPTURE_FIELD_UPPER_HEIGHT_NV = 36922,
	GL_VIDEO_CAPTURE_FIELD_LOWER_HEIGHT_NV = 36923,
	GL_VIDEO_CAPTURE_SURFACE_ORIGIN_NV = 36924,
	GL_NV_viewport_array2 = 1,
	GL_NV_viewport_swizzle = 1,
	GL_VIEWPORT_SWIZZLE_POSITIVE_X_NV = 37712,
	GL_VIEWPORT_SWIZZLE_NEGATIVE_X_NV = 37713,
	GL_VIEWPORT_SWIZZLE_POSITIVE_Y_NV = 37714,
	GL_VIEWPORT_SWIZZLE_NEGATIVE_Y_NV = 37715,
	GL_VIEWPORT_SWIZZLE_POSITIVE_Z_NV = 37716,
	GL_VIEWPORT_SWIZZLE_NEGATIVE_Z_NV = 37717,
	GL_VIEWPORT_SWIZZLE_POSITIVE_W_NV = 37718,
	GL_VIEWPORT_SWIZZLE_NEGATIVE_W_NV = 37719,
	GL_VIEWPORT_SWIZZLE_X_NV = 37720,
	GL_VIEWPORT_SWIZZLE_Y_NV = 37721,
	GL_VIEWPORT_SWIZZLE_Z_NV = 37722,
	GL_VIEWPORT_SWIZZLE_W_NV = 37723,
	GL_OML_interlace = 1,
	GL_INTERLACE_OML = 35200,
	GL_INTERLACE_READ_OML = 35201,
	GL_OML_resample = 1,
	GL_PACK_RESAMPLE_OML = 35204,
	GL_UNPACK_RESAMPLE_OML = 35205,
	GL_RESAMPLE_REPLICATE_OML = 35206,
	GL_RESAMPLE_ZERO_FILL_OML = 35207,
	GL_RESAMPLE_AVERAGE_OML = 35208,
	GL_RESAMPLE_DECIMATE_OML = 35209,
	GL_OML_subsample = 1,
	GL_FORMAT_SUBSAMPLE_24_24_OML = 35202,
	GL_FORMAT_SUBSAMPLE_244_244_OML = 35203,
	GL_OVR_multiview = 1,
	GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_NUM_VIEWS_OVR = 38448,
	GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_BASE_VIEW_INDEX_OVR = 38450,
	GL_MAX_VIEWS_OVR = 38449,
	GL_FRAMEBUFFER_INCOMPLETE_VIEW_TARGETS_OVR = 38451,
	GL_OVR_multiview2 = 1,
	GL_PGI_misc_hints = 1,
	GL_PREFER_DOUBLEBUFFER_HINT_PGI = 107000,
	GL_CONSERVE_MEMORY_HINT_PGI = 107005,
	GL_RECLAIM_MEMORY_HINT_PGI = 107006,
	GL_NATIVE_GRAPHICS_HANDLE_PGI = 107010,
	GL_NATIVE_GRAPHICS_BEGIN_HINT_PGI = 107011,
	GL_NATIVE_GRAPHICS_END_HINT_PGI = 107012,
	GL_ALWAYS_FAST_HINT_PGI = 107020,
	GL_ALWAYS_SOFT_HINT_PGI = 107021,
	GL_ALLOW_DRAW_OBJ_HINT_PGI = 107022,
	GL_ALLOW_DRAW_WIN_HINT_PGI = 107023,
	GL_ALLOW_DRAW_FRG_HINT_PGI = 107024,
	GL_ALLOW_DRAW_MEM_HINT_PGI = 107025,
	GL_STRICT_DEPTHFUNC_HINT_PGI = 107030,
	GL_STRICT_LIGHTING_HINT_PGI = 107031,
	GL_STRICT_SCISSOR_HINT_PGI = 107032,
	GL_FULL_STIPPLE_HINT_PGI = 107033,
	GL_CLIP_NEAR_HINT_PGI = 107040,
	GL_CLIP_FAR_HINT_PGI = 107041,
	GL_WIDE_LINE_HINT_PGI = 107042,
	GL_BACK_NORMALS_HINT_PGI = 107043,
	GL_PGI_vertex_hints = 1,
	GL_VERTEX_DATA_HINT_PGI = 107050,
	GL_VERTEX_CONSISTENT_HINT_PGI = 107051,
	GL_MATERIAL_SIDE_HINT_PGI = 107052,
	GL_MAX_VERTEX_HINT_PGI = 107053,
	GL_COLOR3_BIT_PGI = 65536,
	GL_COLOR4_BIT_PGI = 131072,
	GL_EDGEFLAG_BIT_PGI = 262144,
	GL_INDEX_BIT_PGI = 524288,
	GL_MAT_AMBIENT_BIT_PGI = 1048576,
	GL_MAT_AMBIENT_AND_DIFFUSE_BIT_PGI = 2097152,
	GL_MAT_DIFFUSE_BIT_PGI = 4194304,
	GL_MAT_EMISSION_BIT_PGI = 8388608,
	GL_MAT_COLOR_INDEXES_BIT_PGI = 16777216,
	GL_MAT_SHININESS_BIT_PGI = 33554432,
	GL_MAT_SPECULAR_BIT_PGI = 67108864,
	GL_NORMAL_BIT_PGI = 134217728,
	GL_TEXCOORD1_BIT_PGI = 268435456,
	GL_TEXCOORD2_BIT_PGI = 536870912,
	GL_TEXCOORD3_BIT_PGI = 1073741824,
	GL_TEXCOORD4_BIT_PGI = 2147483648,
	GL_VERTEX23_BIT_PGI = 4,
	GL_VERTEX4_BIT_PGI = 8,
	GL_REND_screen_coordinates = 1,
	GL_SCREEN_COORDINATES_REND = 33936,
	GL_INVERTED_SCREEN_W_REND = 33937,
	GL_S3_s3tc = 1,
	GL_RGB_S3TC = 33696,
	GL_RGB4_S3TC = 33697,
	GL_RGBA_S3TC = 33698,
	GL_RGBA4_S3TC = 33699,
	GL_RGBA_DXT5_S3TC = 33700,
	GL_RGBA4_DXT5_S3TC = 33701,
	GL_SGIS_detail_texture = 1,
	GL_DETAIL_TEXTURE_2D_SGIS = 32917,
	GL_DETAIL_TEXTURE_2D_BINDING_SGIS = 32918,
	GL_LINEAR_DETAIL_SGIS = 32919,
	GL_LINEAR_DETAIL_ALPHA_SGIS = 32920,
	GL_LINEAR_DETAIL_COLOR_SGIS = 32921,
	GL_DETAIL_TEXTURE_LEVEL_SGIS = 32922,
	GL_DETAIL_TEXTURE_MODE_SGIS = 32923,
	GL_DETAIL_TEXTURE_FUNC_POINTS_SGIS = 32924,
	GL_SGIS_fog_function = 1,
	GL_FOG_FUNC_SGIS = 33066,
	GL_FOG_FUNC_POINTS_SGIS = 33067,
	GL_MAX_FOG_FUNC_POINTS_SGIS = 33068,
	GL_SGIS_generate_mipmap = 1,
	GL_GENERATE_MIPMAP_SGIS = 33169,
	GL_GENERATE_MIPMAP_HINT_SGIS = 33170,
	GL_SGIS_multisample = 1,
	GL_MULTISAMPLE_SGIS = 32925,
	GL_SAMPLE_ALPHA_TO_MASK_SGIS = 32926,
	GL_SAMPLE_ALPHA_TO_ONE_SGIS = 32927,
	GL_SAMPLE_MASK_SGIS = 32928,
	GL_1PASS_SGIS = 32929,
	GL_2PASS_0_SGIS = 32930,
	GL_2PASS_1_SGIS = 32931,
	GL_4PASS_0_SGIS = 32932,
	GL_4PASS_1_SGIS = 32933,
	GL_4PASS_2_SGIS = 32934,
	GL_4PASS_3_SGIS = 32935,
	GL_SAMPLE_BUFFERS_SGIS = 32936,
	GL_SAMPLES_SGIS = 32937,
	GL_SAMPLE_MASK_VALUE_SGIS = 32938,
	GL_SAMPLE_MASK_INVERT_SGIS = 32939,
	GL_SAMPLE_PATTERN_SGIS = 32940,
	GL_SGIS_pixel_texture = 1,
	GL_PIXEL_TEXTURE_SGIS = 33619,
	GL_PIXEL_FRAGMENT_RGB_SOURCE_SGIS = 33620,
	GL_PIXEL_FRAGMENT_ALPHA_SOURCE_SGIS = 33621,
	GL_PIXEL_GROUP_COLOR_SGIS = 33622,
	GL_SGIS_point_line_texgen = 1,
	GL_EYE_DISTANCE_TO_POINT_SGIS = 33264,
	GL_OBJECT_DISTANCE_TO_POINT_SGIS = 33265,
	GL_EYE_DISTANCE_TO_LINE_SGIS = 33266,
	GL_OBJECT_DISTANCE_TO_LINE_SGIS = 33267,
	GL_EYE_POINT_SGIS = 33268,
	GL_OBJECT_POINT_SGIS = 33269,
	GL_EYE_LINE_SGIS = 33270,
	GL_OBJECT_LINE_SGIS = 33271,
	GL_SGIS_point_parameters = 1,
	GL_POINT_SIZE_MIN_SGIS = 33062,
	GL_POINT_SIZE_MAX_SGIS = 33063,
	GL_POINT_FADE_THRESHOLD_SIZE_SGIS = 33064,
	GL_DISTANCE_ATTENUATION_SGIS = 33065,
	GL_SGIS_sharpen_texture = 1,
	GL_LINEAR_SHARPEN_SGIS = 32941,
	GL_LINEAR_SHARPEN_ALPHA_SGIS = 32942,
	GL_LINEAR_SHARPEN_COLOR_SGIS = 32943,
	GL_SHARPEN_TEXTURE_FUNC_POINTS_SGIS = 32944,
	GL_SGIS_texture4D = 1,
	GL_PACK_SKIP_VOLUMES_SGIS = 33072,
	GL_PACK_IMAGE_DEPTH_SGIS = 33073,
	GL_UNPACK_SKIP_VOLUMES_SGIS = 33074,
	GL_UNPACK_IMAGE_DEPTH_SGIS = 33075,
	GL_TEXTURE_4D_SGIS = 33076,
	GL_PROXY_TEXTURE_4D_SGIS = 33077,
	GL_TEXTURE_4DSIZE_SGIS = 33078,
	GL_TEXTURE_WRAP_Q_SGIS = 33079,
	GL_MAX_4D_TEXTURE_SIZE_SGIS = 33080,
	GL_TEXTURE_4D_BINDING_SGIS = 33103,
	GL_SGIS_texture_border_clamp = 1,
	GL_CLAMP_TO_BORDER_SGIS = 33069,
	GL_SGIS_texture_color_mask = 1,
	GL_TEXTURE_COLOR_WRITEMASK_SGIS = 33263,
	GL_SGIS_texture_edge_clamp = 1,
	GL_CLAMP_TO_EDGE_SGIS = 33071,
	GL_SGIS_texture_filter4 = 1,
	GL_FILTER4_SGIS = 33094,
	GL_TEXTURE_FILTER4_SIZE_SGIS = 33095,
	GL_SGIS_texture_lod = 1,
	GL_TEXTURE_MIN_LOD_SGIS = 33082,
	GL_TEXTURE_MAX_LOD_SGIS = 33083,
	GL_TEXTURE_BASE_LEVEL_SGIS = 33084,
	GL_TEXTURE_MAX_LEVEL_SGIS = 33085,
	GL_SGIS_texture_select = 1,
	GL_DUAL_ALPHA4_SGIS = 33040,
	GL_DUAL_ALPHA8_SGIS = 33041,
	GL_DUAL_ALPHA12_SGIS = 33042,
	GL_DUAL_ALPHA16_SGIS = 33043,
	GL_DUAL_LUMINANCE4_SGIS = 33044,
	GL_DUAL_LUMINANCE8_SGIS = 33045,
	GL_DUAL_LUMINANCE12_SGIS = 33046,
	GL_DUAL_LUMINANCE16_SGIS = 33047,
	GL_DUAL_INTENSITY4_SGIS = 33048,
	GL_DUAL_INTENSITY8_SGIS = 33049,
	GL_DUAL_INTENSITY12_SGIS = 33050,
	GL_DUAL_INTENSITY16_SGIS = 33051,
	GL_DUAL_LUMINANCE_ALPHA4_SGIS = 33052,
	GL_DUAL_LUMINANCE_ALPHA8_SGIS = 33053,
	GL_QUAD_ALPHA4_SGIS = 33054,
	GL_QUAD_ALPHA8_SGIS = 33055,
	GL_QUAD_LUMINANCE4_SGIS = 33056,
	GL_QUAD_LUMINANCE8_SGIS = 33057,
	GL_QUAD_INTENSITY4_SGIS = 33058,
	GL_QUAD_INTENSITY8_SGIS = 33059,
	GL_DUAL_TEXTURE_SELECT_SGIS = 33060,
	GL_QUAD_TEXTURE_SELECT_SGIS = 33061,
	GL_SGIX_async = 1,
	GL_ASYNC_MARKER_SGIX = 33577,
	GL_SGIX_async_histogram = 1,
	GL_ASYNC_HISTOGRAM_SGIX = 33580,
	GL_MAX_ASYNC_HISTOGRAM_SGIX = 33581,
	GL_SGIX_async_pixel = 1,
	GL_ASYNC_TEX_IMAGE_SGIX = 33628,
	GL_ASYNC_DRAW_PIXELS_SGIX = 33629,
	GL_ASYNC_READ_PIXELS_SGIX = 33630,
	GL_MAX_ASYNC_TEX_IMAGE_SGIX = 33631,
	GL_MAX_ASYNC_DRAW_PIXELS_SGIX = 33632,
	GL_MAX_ASYNC_READ_PIXELS_SGIX = 33633,
	GL_SGIX_blend_alpha_minmax = 1,
	GL_ALPHA_MIN_SGIX = 33568,
	GL_ALPHA_MAX_SGIX = 33569,
	GL_SGIX_calligraphic_fragment = 1,
	GL_CALLIGRAPHIC_FRAGMENT_SGIX = 33155,
	GL_SGIX_clipmap = 1,
	GL_LINEAR_CLIPMAP_LINEAR_SGIX = 33136,
	GL_TEXTURE_CLIPMAP_CENTER_SGIX = 33137,
	GL_TEXTURE_CLIPMAP_FRAME_SGIX = 33138,
	GL_TEXTURE_CLIPMAP_OFFSET_SGIX = 33139,
	GL_TEXTURE_CLIPMAP_VIRTUAL_DEPTH_SGIX = 33140,
	GL_TEXTURE_CLIPMAP_LOD_OFFSET_SGIX = 33141,
	GL_TEXTURE_CLIPMAP_DEPTH_SGIX = 33142,
	GL_MAX_CLIPMAP_DEPTH_SGIX = 33143,
	GL_MAX_CLIPMAP_VIRTUAL_DEPTH_SGIX = 33144,
	GL_NEAREST_CLIPMAP_NEAREST_SGIX = 33869,
	GL_NEAREST_CLIPMAP_LINEAR_SGIX = 33870,
	GL_LINEAR_CLIPMAP_NEAREST_SGIX = 33871,
	GL_SGIX_convolution_accuracy = 1,
	GL_CONVOLUTION_HINT_SGIX = 33558,
	GL_SGIX_depth_pass_instrument = 1,
	GL_SGIX_depth_texture = 1,
	GL_DEPTH_COMPONENT16_SGIX = 33189,
	GL_DEPTH_COMPONENT24_SGIX = 33190,
	GL_DEPTH_COMPONENT32_SGIX = 33191,
	GL_SGIX_flush_raster = 1,
	GL_SGIX_fog_offset = 1,
	GL_FOG_OFFSET_SGIX = 33176,
	GL_FOG_OFFSET_VALUE_SGIX = 33177,
	GL_SGIX_fragment_lighting = 1,
	GL_FRAGMENT_LIGHTING_SGIX = 33792,
	GL_FRAGMENT_COLOR_MATERIAL_SGIX = 33793,
	GL_FRAGMENT_COLOR_MATERIAL_FACE_SGIX = 33794,
	GL_FRAGMENT_COLOR_MATERIAL_PARAMETER_SGIX = 33795,
	GL_MAX_FRAGMENT_LIGHTS_SGIX = 33796,
	GL_MAX_ACTIVE_LIGHTS_SGIX = 33797,
	GL_CURRENT_RASTER_NORMAL_SGIX = 33798,
	GL_LIGHT_ENV_MODE_SGIX = 33799,
	GL_FRAGMENT_LIGHT_MODEL_LOCAL_VIEWER_SGIX = 33800,
	GL_FRAGMENT_LIGHT_MODEL_TWO_SIDE_SGIX = 33801,
	GL_FRAGMENT_LIGHT_MODEL_AMBIENT_SGIX = 33802,
	GL_FRAGMENT_LIGHT_MODEL_NORMAL_INTERPOLATION_SGIX = 33803,
	GL_FRAGMENT_LIGHT0_SGIX = 33804,
	GL_FRAGMENT_LIGHT1_SGIX = 33805,
	GL_FRAGMENT_LIGHT2_SGIX = 33806,
	GL_FRAGMENT_LIGHT3_SGIX = 33807,
	GL_FRAGMENT_LIGHT4_SGIX = 33808,
	GL_FRAGMENT_LIGHT5_SGIX = 33809,
	GL_FRAGMENT_LIGHT6_SGIX = 33810,
	GL_FRAGMENT_LIGHT7_SGIX = 33811,
	GL_SGIX_framezoom = 1,
	GL_FRAMEZOOM_SGIX = 33163,
	GL_FRAMEZOOM_FACTOR_SGIX = 33164,
	GL_MAX_FRAMEZOOM_FACTOR_SGIX = 33165,
	GL_SGIX_igloo_interface = 1,
	GL_SGIX_instruments = 1,
	GL_INSTRUMENT_BUFFER_POINTER_SGIX = 33152,
	GL_INSTRUMENT_MEASUREMENTS_SGIX = 33153,
	GL_SGIX_interlace = 1,
	GL_INTERLACE_SGIX = 32916,
	GL_SGIX_ir_instrument1 = 1,
	GL_IR_INSTRUMENT1_SGIX = 33151,
	GL_SGIX_list_priority = 1,
	GL_LIST_PRIORITY_SGIX = 33154,
	GL_SGIX_pixel_texture = 1,
	GL_PIXEL_TEX_GEN_SGIX = 33081,
	GL_PIXEL_TEX_GEN_MODE_SGIX = 33579,
	GL_SGIX_pixel_tiles = 1,
	GL_PIXEL_TILE_BEST_ALIGNMENT_SGIX = 33086,
	GL_PIXEL_TILE_CACHE_INCREMENT_SGIX = 33087,
	GL_PIXEL_TILE_WIDTH_SGIX = 33088,
	GL_PIXEL_TILE_HEIGHT_SGIX = 33089,
	GL_PIXEL_TILE_GRID_WIDTH_SGIX = 33090,
	GL_PIXEL_TILE_GRID_HEIGHT_SGIX = 33091,
	GL_PIXEL_TILE_GRID_DEPTH_SGIX = 33092,
	GL_PIXEL_TILE_CACHE_SIZE_SGIX = 33093,
	GL_SGIX_polynomial_ffd = 1,
	GL_TEXTURE_DEFORMATION_BIT_SGIX = 1,
	GL_GEOMETRY_DEFORMATION_BIT_SGIX = 2,
	GL_GEOMETRY_DEFORMATION_SGIX = 33172,
	GL_TEXTURE_DEFORMATION_SGIX = 33173,
	GL_DEFORMATIONS_MASK_SGIX = 33174,
	GL_MAX_DEFORMATION_ORDER_SGIX = 33175,
	GL_SGIX_reference_plane = 1,
	GL_REFERENCE_PLANE_SGIX = 33149,
	GL_REFERENCE_PLANE_EQUATION_SGIX = 33150,
	GL_SGIX_resample = 1,
	GL_PACK_RESAMPLE_SGIX = 33838,
	GL_UNPACK_RESAMPLE_SGIX = 33839,
	GL_RESAMPLE_REPLICATE_SGIX = 33843,
	GL_RESAMPLE_ZERO_FILL_SGIX = 33844,
	GL_RESAMPLE_DECIMATE_SGIX = 33840,
	GL_SGIX_scalebias_hint = 1,
	GL_SCALEBIAS_HINT_SGIX = 33570,
	GL_SGIX_shadow = 1,
	GL_TEXTURE_COMPARE_SGIX = 33178,
	GL_TEXTURE_COMPARE_OPERATOR_SGIX = 33179,
	GL_TEXTURE_LEQUAL_R_SGIX = 33180,
	GL_TEXTURE_GEQUAL_R_SGIX = 33181,
	GL_SGIX_shadow_ambient = 1,
	GL_SHADOW_AMBIENT_SGIX = 32959,
	GL_SGIX_sprite = 1,
	GL_SPRITE_SGIX = 33096,
	GL_SPRITE_MODE_SGIX = 33097,
	GL_SPRITE_AXIS_SGIX = 33098,
	GL_SPRITE_TRANSLATION_SGIX = 33099,
	GL_SPRITE_AXIAL_SGIX = 33100,
	GL_SPRITE_OBJECT_ALIGNED_SGIX = 33101,
	GL_SPRITE_EYE_ALIGNED_SGIX = 33102,
	GL_SGIX_subsample = 1,
	GL_PACK_SUBSAMPLE_RATE_SGIX = 34208,
	GL_UNPACK_SUBSAMPLE_RATE_SGIX = 34209,
	GL_PIXEL_SUBSAMPLE_4444_SGIX = 34210,
	GL_PIXEL_SUBSAMPLE_2424_SGIX = 34211,
	GL_PIXEL_SUBSAMPLE_4242_SGIX = 34212,
	GL_SGIX_tag_sample_buffer = 1,
	GL_SGIX_texture_add_env = 1,
	GL_TEXTURE_ENV_BIAS_SGIX = 32958,
	GL_SGIX_texture_coordinate_clamp = 1,
	GL_TEXTURE_MAX_CLAMP_S_SGIX = 33641,
	GL_TEXTURE_MAX_CLAMP_T_SGIX = 33642,
	GL_TEXTURE_MAX_CLAMP_R_SGIX = 33643,
	GL_SGIX_texture_lod_bias = 1,
	GL_TEXTURE_LOD_BIAS_S_SGIX = 33166,
	GL_TEXTURE_LOD_BIAS_T_SGIX = 33167,
	GL_TEXTURE_LOD_BIAS_R_SGIX = 33168,
	GL_SGIX_texture_multi_buffer = 1,
	GL_TEXTURE_MULTI_BUFFER_HINT_SGIX = 33070,
	GL_SGIX_texture_scale_bias = 1,
	GL_POST_TEXTURE_FILTER_BIAS_SGIX = 33145,
	GL_POST_TEXTURE_FILTER_SCALE_SGIX = 33146,
	GL_POST_TEXTURE_FILTER_BIAS_RANGE_SGIX = 33147,
	GL_POST_TEXTURE_FILTER_SCALE_RANGE_SGIX = 33148,
	GL_SGIX_vertex_preclip = 1,
	GL_VERTEX_PRECLIP_SGIX = 33774,
	GL_VERTEX_PRECLIP_HINT_SGIX = 33775,
	GL_SGIX_ycrcb = 1,
	GL_YCRCB_422_SGIX = 33211,
	GL_YCRCB_444_SGIX = 33212,
	GL_SGIX_ycrcb_subsample = 1,
	GL_SGIX_ycrcba = 1,
	GL_YCRCB_SGIX = 33560,
	GL_YCRCBA_SGIX = 33561,
	GL_SGI_color_matrix = 1,
	GL_COLOR_MATRIX_SGI = 32945,
	GL_COLOR_MATRIX_STACK_DEPTH_SGI = 32946,
	GL_MAX_COLOR_MATRIX_STACK_DEPTH_SGI = 32947,
	GL_POST_COLOR_MATRIX_RED_SCALE_SGI = 32948,
	GL_POST_COLOR_MATRIX_GREEN_SCALE_SGI = 32949,
	GL_POST_COLOR_MATRIX_BLUE_SCALE_SGI = 32950,
	GL_POST_COLOR_MATRIX_ALPHA_SCALE_SGI = 32951,
	GL_POST_COLOR_MATRIX_RED_BIAS_SGI = 32952,
	GL_POST_COLOR_MATRIX_GREEN_BIAS_SGI = 32953,
	GL_POST_COLOR_MATRIX_BLUE_BIAS_SGI = 32954,
	GL_POST_COLOR_MATRIX_ALPHA_BIAS_SGI = 32955,
	GL_SGI_color_table = 1,
	GL_COLOR_TABLE_SGI = 32976,
	GL_POST_CONVOLUTION_COLOR_TABLE_SGI = 32977,
	GL_POST_COLOR_MATRIX_COLOR_TABLE_SGI = 32978,
	GL_PROXY_COLOR_TABLE_SGI = 32979,
	GL_PROXY_POST_CONVOLUTION_COLOR_TABLE_SGI = 32980,
	GL_PROXY_POST_COLOR_MATRIX_COLOR_TABLE_SGI = 32981,
	GL_COLOR_TABLE_SCALE_SGI = 32982,
	GL_COLOR_TABLE_BIAS_SGI = 32983,
	GL_COLOR_TABLE_FORMAT_SGI = 32984,
	GL_COLOR_TABLE_WIDTH_SGI = 32985,
	GL_COLOR_TABLE_RED_SIZE_SGI = 32986,
	GL_COLOR_TABLE_GREEN_SIZE_SGI = 32987,
	GL_COLOR_TABLE_BLUE_SIZE_SGI = 32988,
	GL_COLOR_TABLE_ALPHA_SIZE_SGI = 32989,
	GL_COLOR_TABLE_LUMINANCE_SIZE_SGI = 32990,
	GL_COLOR_TABLE_INTENSITY_SIZE_SGI = 32991,
	GL_SGI_texture_color_table = 1,
	GL_TEXTURE_COLOR_TABLE_SGI = 32956,
	GL_PROXY_TEXTURE_COLOR_TABLE_SGI = 32957,
	GL_SUNX_constant_data = 1,
	GL_UNPACK_CONSTANT_DATA_SUNX = 33237,
	GL_TEXTURE_CONSTANT_DATA_SUNX = 33238,
	GL_SUN_convolution_border_modes = 1,
	GL_WRAP_BORDER_SUN = 33236,
	GL_SUN_global_alpha = 1,
	GL_GLOBAL_ALPHA_SUN = 33241,
	GL_GLOBAL_ALPHA_FACTOR_SUN = 33242,
	GL_SUN_mesh_array = 1,
	GL_QUAD_MESH_SUN = 34324,
	GL_TRIANGLE_MESH_SUN = 34325,
	GL_SUN_slice_accum = 1,
	GL_SLICE_ACCUM_SUN = 34252,
	GL_SUN_triangle_list = 1,
	GL_RESTART_SUN = 1,
	GL_REPLACE_MIDDLE_SUN = 2,
	GL_REPLACE_OLDEST_SUN = 3,
	GL_TRIANGLE_LIST_SUN = 33239,
	GL_REPLACEMENT_CODE_SUN = 33240,
	GL_REPLACEMENT_CODE_ARRAY_SUN = 34240,
	GL_REPLACEMENT_CODE_ARRAY_TYPE_SUN = 34241,
	GL_REPLACEMENT_CODE_ARRAY_STRIDE_SUN = 34242,
	GL_REPLACEMENT_CODE_ARRAY_POINTER_SUN = 34243,
	GL_R1UI_V3F_SUN = 34244,
	GL_R1UI_C4UB_V3F_SUN = 34245,
	GL_R1UI_C3F_V3F_SUN = 34246,
	GL_R1UI_N3F_V3F_SUN = 34247,
	GL_R1UI_C4F_N3F_V3F_SUN = 34248,
	GL_R1UI_T2F_V3F_SUN = 34249,
	GL_R1UI_T2F_N3F_V3F_SUN = 34250,
	GL_R1UI_T2F_C4F_N3F_V3F_SUN = 34251,
	GL_SUN_vertex = 1,
	GL_WIN_phong_shading = 1,
	GL_WIN_specular_fog = 1,
}

local cbs = {}

-- this is a copy of ffi/libwrapper.lua
-- except with an extra step to get the function using wglGetProcAddress
local lib = require 'ffi.load' 'GL'

setmetatable(wrapper, {
	__index = function(wrapper, k)
		if k == nil then return nil end	-- who is doing this?

--DEBUG:print('gl libwrapper requesting', k)
		-- here we are asking for a function that's not in our wrapper

		-- if there's a function in the lib then use it
		-- enums will be here
		-- gl1 calls should be here too
		do
			local inlib = op.safeindex(lib, k)
			if inlib ~= nil then
--DEBUG:print('found in lib, returning')
				-- store so it doesn't call this a second time
				wrapper[k] = inlib
				return inlib
			end
		end

		-- look in the loader code
		local funcDef = defs[k]
		if funcDef == nil then
			error("can't find definition for "..tostring(k))
		end

		-- see if the funciton is in the GL library ... cdef it then look it up
		do
			ffi.cdef(funcDef)
			local inLibAfterDef = op.safeindex(lib, k)
			if inLibAfterDef ~= nil then
--DEBUG:print('found in lib after cdefing function, returning')
				wrapper[k] = inLibAfterDef
				return inLibAfterDef
			end
		end

		-- try wglGetProcAddress
		local proc = lib.wglGetProcAddress(k)
		if proc == nil then
			-- match error of cdata __index unknown field?
			-- "missing declaration for symbol '...'"
			error("failed to find function "..tostring(k))
		end
--DEBUG:print('found in wglGetProcAddress, returning')
		local castproc = ffi.cast('PFN'..k:upper()..'PROC', proc)
		if castproc then
			cbs[k] = {proc = proc, castproc = castproc}
		end
		wrapper[k] = castproc
		return castproc
	end,
	__gc = function()
		-- "Error in finalizer" ???
		if cbs then
			for k,v in pairs(cbs) do
				v.castproc:free()	-- "bad callback" how ?
				rawset(wrapper, k, nil)
			end
			lib = nil
		end
		cbs = nil
	end,
})
return wrapper
