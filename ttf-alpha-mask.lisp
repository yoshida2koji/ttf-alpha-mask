(defpackage :ttf-alpha-mask
  (:use :cl)
  (:export :make-alpha-mask))

(in-package :ttf-alpha-mask)

(defun set-alpha-function (buffer)
  (let ((right (1- (array-dimension buffer 1)))
        (bottom (1- (array-dimension buffer 0))))
    (declare (type fixnum right bottom))
    (lambda (x y a)
      (when (and (<= 0 x right)
                 (<= 0 y bottom))
        (setf (aref buffer y x) (min 255 (abs a)))))))

(defun align-pad-length (e)
  (mod (- 4 (mod e 4)) 4))

(defun aligned-length (len)
  (+ (align-pad-length len) len))

(defun make-alpha-mask (font-loader ch size &key aligned-line-p)
  (let* ((glyph (zpb-ttf:find-glyph ch font-loader))
         (scale (/ size (zpb-ttf:units/em font-loader)))
         (baseline (* scale (zpb-ttf:ascender font-loader)))
         (height (ceiling (- baseline (* scale (zpb-ttf:descender font-loader)))))
         (width (ceiling (* scale (zpb-ttf:advance-width glyph))))
         (line (if aligned-line-p (aligned-length width) width))
         (mask (make-array (list height line) :element-type '(unsigned-byte 8) :initial-element 0))
         (paths (paths-ttf:paths-from-glyph glyph :offset (paths:make-point 0 baseline)
                                                  :scale-x scale
                                                  :scale-y (- scale)))
         (state (aa:make-state)))
    (vectors:update-state state paths)
    (aa:cells-sweep state (set-alpha-function mask))
    (values mask width)))


