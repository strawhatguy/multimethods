;;;; -*-Lisp-*-
(in-package :common-lisp-user)

(defpackage #:multimethods
  (:use #:cl #:alexandria)
  (:export 
   :defmulti
   :defmultimethod))

