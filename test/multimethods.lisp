;;;; -*-Lisp-*-
(in-package :multimethods-test)

(def-suite multimethods-dispatching
    :description "Tests of multimethod dispatch mechanism")
(in-suite multimethods-dispatching)

;;;; example the clojure folks use
(defmulti encounter (:test #'equalp) (x y)
  (list (gethash :species x) (gethash :species y)))
(defmultimethod encounter (list :bunny :lion)  (x y) (declare (ignorable x y)) :run-away)
(defmultimethod encounter (list :lion :bunny)  (x y) (declare (ignorable x y)) :eat)
(defmultimethod encounter (list :lion :lion)   (x y) (declare (ignorable x y)) :fight)
(defmultimethod encounter (list :bunny :bunny) (x y) (declare (ignorable x y)) :mate)

(test should-dispatch-correctly
  (let ((b1 (alexandria:plist-hash-table '(:species :bunny)))
        (b2 (alexandria:plist-hash-table '(:species :bunny)))
        (l1 (alexandria:plist-hash-table '(:species :lion)))
        (l2 (alexandria:plist-hash-table '(:species :lion))))
    (is (eq :run-away (encounter b1 l1)))
    (is (eq :eat      (encounter l1 b1)))
    (is (eq :fight    (encounter l1 l2)))
    (is (eq :mate     (encounter b1 b2)))))

