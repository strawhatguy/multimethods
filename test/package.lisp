;;;; -*-Lisp-*-
(in-package :common-lisp-user)

(defpackage #:multimethods-test
  (:use #:cl #:fiveam #:multimethods)
  (:export
   #:multimethods-dispatching))

