;;;; -*-Lisp-*- 
(in-package :cl-user)

(defpackage :multimethods-system (:use :cl))
(in-package :multimethods-system)

(asdf:defsystem :multimethods
  ;; external dependencies go here
  :depends-on (:alexandria)
  :components 
   ((:module "src" 
             :serial t
             :components 
              ((:file "package")
               (:file "multimethods")))))

