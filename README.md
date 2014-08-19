# Multimethods for Common Lisp

Basically, clojure has this notion of multimethods, where the
dispatching function is determined by the user at definition time.

Common Lisp's generic methods from CLOS are similar, but dispatch
solely on the types of the arguments.

# API
defmulti *name* *test* *args* *dispatch*

Create a new multimethod *name*, and define a dispatching function for
it. Every instance of this mulitmethod must take the arguments in
*args*. The code in *dispatch* should return a value based on the
arguments in *args*, and return a value. That value will be compared
(via test function *test*) to the instance's dispatch value. If *test*
is non-nil, that instance's method will be invoked.


defmultimethod *name* *dispatch-value* *args* *body*

Create an instance of the multimethod. *name* must be defined with
**defmulti** previously. Executes code in *body* with arguments *args*
if the *dispatch-value* satisfies the test of the dispatching function
defined with **defmulti**, above.


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
