# Multimethods for Common Lisp

Basically, clojure has this notion of multimethods, where the
dispatching function is determined by the user at definition time.

Common Lisp's generic methods from CLOS are similar, but dispatch
solely on the types of the arguments.

# Example 
From the clojure website, see: http://clojure.org/runtime_polymorphism     

```
(defmulti encounter (:test #'equalp) (x y)
  (list (gethash :species x) (gethash :species y)))

(defmultimethod encounter (list :bunny :lion)  (x y) 
  :run-away)
(defmultimethod encounter (list :lion :bunny)  (x y)
  :eat)
(defmultimethod encounter (list :lion :lion)   (x y)
  :fight)
(defmultimethod encounter (list :bunny :bunny) (x y)
  :mate)

(let ((b1 (alexandria:plist-hash-table '(:species :bunny)))
      (b2 (alexandria:plist-hash-table '(:species :bunny)))
      (l1 (alexandria:plist-hash-table '(:species :lion)))
      (l2 (alexandria:plist-hash-table '(:species :lion))))
  (assert-equal :run-away (encounter b1 l1))
  (assert-equal :eat      (encounter l1 b1))
  (assert-equal :fight    (encounter l1 l2))
  (assert-equal :mate     (encounter b1 b2))))
```