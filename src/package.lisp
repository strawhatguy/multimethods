;;;; -*-Lisp-*-
(in-package :common-lisp-user)

(defpackage :multimethods
  ;; insert other packages below
  (:use :cl :alexandria)
  ;; export symbols here
  (:export 
   :defmulti
   :defmultimethod))

