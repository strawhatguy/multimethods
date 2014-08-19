;;;; -*-Lisp-*-
(in-package :multimethods)

(defvar *multimethods* (make-hash-table :test #'eq)
  "Stores all the properties of multimethods")

(defstruct multimethod
  dispatcher methods)

(defun get-multimethod (name)
  (gethash name *multimethods*))
 
(defun (setf get-multimethod) (mm name)
  (setf (gethash name *multimethods*) mm))

(defun assert-multimethod (multimethod)
  (when (or (null multimethod)
            (not (multimethod-p multimethod)))
    (error "Multimethod ~S function is undefined" multimethod)))

(defun get-dispatcher-value (multimethod &rest args)
  (assert-multimethod multimethod)
  (apply (multimethod-dispatcher multimethod) args))

(defun get-multimethod-method (multimethod dispatch-value)
  (gethash dispatch-value (multimethod-methods multimethod)))

(defun (setf get-multimethod-method) (method multimethod dispatch-value)
  (setf (gethash dispatch-value (multimethod-methods multimethod)) method))

(defmacro defmulti (name test (&rest args) &body body)
  (with-gensyms (multimethod)
  `(progn
     (setf (get-multimethod ',name) 
           (make-multimethod :dispatcher (lambda ,args ,@body)
                             :methods (make-hash-table :test ,test)))
     (defun ,name ,args
       (let ((,multimethod (get-multimethod ',name)))
         (funcall (get-multimethod-method ,multimethod
                                          (get-dispatcher-value ,multimethod ,@args))
                ,@args))))))

(defmacro defmultimethod (name dispatch-value (&rest args) &body body)
  `(setf (get-multimethod-method (get-multimethod ',name) ,dispatch-value) 
         (lambda ,args ,@body)))
