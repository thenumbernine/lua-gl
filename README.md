[![paypal](https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=KYWUWS86GSFGL)

### OOP Wrappers for OpenGL calls in LuaJIT.

## Usage:
```
require 'gl'
```

Make sure to use `require 'gl'` instead of `require 'ffi.OpenGL'` so prototype references can be handled properly.

## To use this with GLES2, use the following global to override the FFI file:
```
ffi_OpenGL = 'ffi.OpenGLES2'
require 'gl'
```


### Dependencies:

- LuaJIT
- https://github.com/thenumbernine/lua-ext
- https://github.com/malkia/ufo and/or https://github.com/thenumbernine/lua-ffi-bindings
- https://github.com/thenumbernine/lua-template for showcode for GLShader
- https://github.com/thenumbernine/lua-image for image loading / resizing in Tex2D
