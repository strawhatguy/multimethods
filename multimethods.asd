;;;; -*-Lisp-*- 
(in-package :cl-user)

(asdf:defsystem #:multimethods
  :depends-on (#:alexandria)
  :components 
   ((:module "src" 
             :serial t
             :components 
              ((:file "package")
               (:file "multimethods")))))

(asdf:defsystem #:multimethods-test
  ;; external dependencies go here
  :depends-on (#:multimethods #:alexandria #:fiveam)
  :components 
   ((:module "test" 
             :serial t
             :components 
              ((:file "package")
               (:file "multimethods")))))
