# ttf-alpha-mask
make glyph alpha mask from truetype font.

## Usage
For example, NotoMono-Regular
```lisp
(zpb-ttf:with-font-loader (loader {font-path})
  (ttf-alpha-mask:make-alpha-mask loader #\a 14))

=> #2A((0 0 0 0 0 0 0 0 0)
    (0 0 0 0 0 0 0 0 0)
    (0 0 0 0 0 0 0 0 0)
    (0 0 0 0 0 0 0 0 0)
    (0 0 0 0 0 0 0 0 0)
    (0 16 103 156 162 118 14 0 0)
    (0 78 179 112 107 215 183 0 0)
    (0 0 0 0 0 70 251 1 0)
    (0 0 44 103 125 159 255 4 0)
    (0 138 232 132 97 122 255 4 0)
    (10 253 76 0 0 71 255 4 0)
    (6 248 99 0 18 191 255 4 0)
    (0 111 248 229 230 85 245 3 0)
    (0 0 10 28 3 0 0 0 0)
    (0 0 0 0 0 0 0 0 0)
    (0 0 0 0 0 0 0 0 0)
    (0 0 0 0 0 0 0 0 0))
```
