[![Donate via Stripe](https://img.shields.io/badge/Donate-Stripe-green.svg)](https://buy.stripe.com/00gbJZ0OdcNs9zi288)<br>

### LuaJIT OpenGL Classes

## Usage:
``` lua
local gl = require 'gl'
```

Make sure to use `require 'gl'` instead of `require 'ffi.req' 'OpenGL'` so prototype references can be handled properly.

## To use this with GLES2, use the following global to override the FFI file:
``` lua
local gl = require 'gl.setup' 'OpenGLES2'
```
... and then all subsequent `require 'gl'` will return the correctly-loaded library.

Behavior rule of thumb:

Creating an object will bind() it, and requires an unbind() / useNone().

This is true for `gl.tex` and subclasses
- But not for `gl.program`
- And not for `gl.fbo`
- And idk even about vertex attributes / array objects

Setting any parameters will require a manual bind() called beforehand.

### Dependencies:

- LuaJIT
- https://github.com/thenumbernine/lua-ext
- https://github.com/thenumbernine/lua-ffi-bindings
- https://github.com/thenumbernine/lua-template for showcode for GLShader
- https://github.com/thenumbernine/lua-image for image loading / resizing in Tex2D
