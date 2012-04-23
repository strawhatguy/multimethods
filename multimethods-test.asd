;;;; -*-Lisp-*- 
(in-package :cl-user)

(defpackage :multimethods-test-system (:use :cl))
(in-package :multimethods-test-system)

(asdf:defsystem :multimethods-test
  ;; external dependencies go here
  :depends-on (:multimethods :alexandria :lisp-unit)
  :components 
   ((:module "test" 
             :serial t
             :components 
              ((:file "package")
               (:file "multimethods")))))

