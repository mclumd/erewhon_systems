;;; History:
;;; Added get-default-case-name and get-default-case-dir-name functions. 
;;;   Mike Cox 12mar97
;;;

;;;****************************
;;; To make things easier to store a case
;;; At end, trace.
;;;****************************

;;; Calls the function write-to-file from save-case.lisp
;;; Example: if the name of the problem is p8 in the blocksworld,
;;; after (run) call (store-case) and the case is stored in
;;; blocksworld/probs/cases/case-p8.lisp
;;; a call to (store-case :case-name "bla") will make the case be stored in
;;; blocksworld/probs/cases/bla.lisp
;;; and the header in blocksworld/probs/cases/headers/bla.lisp
;;; a call to (store-case :case-name "bla" :case-dir "/usr/mmv/other-cases/")
;;; will make the case be stored in /usr/mmv/other-cases/bla.lisp
;;; and the header in /usr/mmv/other-cases/headers/bla.lisp
;;; (The directory /usr/mmv/other-cases/headers/ would have to be there...)

(defun store-case (&key (case-name (get-default-case-name))
			(case-dir (get-default-case-dir-name)))
  (let ((objects (get-non-static-objects (current-problem)))
	(failed (or (eq (prodigy-result-interrupt *prodigy-result*)
			:fail)
		    (eq (car (prodigy-result-interrupt *prodigy-result*))
			:stop))))
    (write-to-file *prodigy-result* objects case-name case-dir failed)))

;;;
;;; This function was simply the cancat call and embedded in the parameter
;;; list of function store-case above. Now it can be called separately by 
;;; tcl code in the UI. [cox 12mar97]
;;;
(defun get-default-case-name () 
  (concatenate 'string 
	       "case-"
	       (string-downcase
		(symbol-name
		 (p4::problem-name
		  (current-problem)))))
  )

;;;
;;; This function was likewise embedded in the parameter list of function 
;;; store-case above. Now it also can be called separately by tcl code in 
;;; the UI. [cox 12mar97]
;;;
(defun get-default-case-dir-name ()
  (concatenate 'string 
	       *problem-path* 
	       "probs/cases/")
  )



;;; Call (go-through-case *old-case-root*) or
;;; (go-through-case (guiding-case-ptr *guiding-case*)) or
;;; (go-through-case (guiding-case-ptr (nth 2 *case-cache*)))

(defun get-non-static-objects (problem)
  (p4::problem-objects problem))

(defun go-through-case (ptr)
  (cond
    ((null ptr) nil)
    (t
     (format t "~% ~S" ptr)
     (go-through-case (car (p4::nexus-children ptr))))))

#|

USER(75): (load "storage/save-case.lisp")
; Loading /usr/mmv/p-analogy/storage/save-case.lisp.
;   Loading /usr/mmv/p-analogy/storage/footprint.lisp.
;     Loading /usr/mmv/p-analogy/storage/print-rules.lisp.
;     Loading /usr/mmv/p-analogy/storage/preconds.lisp.
T
(run)
USER(96): (write-case-to-file (cdr (prodigy-result-interrupt
					      *prodigy-result*))
		    (p4::problem-objects (current-problem)))
		    
 Storing case in file "/usr/mmv/prodigy4.0/domains/blocksworld/probs/cases/case-p8.lisp" ...

Done with storing case.
nil

USER(102): (p4::path-from-root (cdr (prodigy-result-interrupt *prodigy-result*)))
(#<APPLIED-OP-NODE 1 nil> #<GOAL-NODE 2 #<done>> #<OPERATOR-NODE 3 #<OP: *finish*>>
 #<BINDING-NODE 4 #<*finish*>> #<GOAL-NODE 5 #<holding c>>
 #<OPERATOR-NODE 18 #<OP: unstack>> #<BINDING-NODE 19 #<unstack [<ob> c] [<underob> a]>>
 #<GOAL-NODE 20 #<clear c>> #<OPERATOR-NODE 23 #<OP: unstack>>
 #<BINDING-NODE 24 #<unstack [<ob> b] [<underob> c]>> ...)
12
USER(103): USER(103): (write-to-screen (p4::path-from-root (cdr (prodigy-result-interrupt *prodigy-result*))))
 (p4::top-nodes 0) 
(setf (p4::nexus-children (find-node 3))
  (list
    (p4::make-binding-node 
        :name 4 
        :parent (find-node 3)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(holding c))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 4))
      (p4::make-instantiated-op
          :op (p4::get-operator prodigy4::*finish*)
          :binding-node-back-pointer (find-node 4)
          :precond 
            (p4::instantiate-consed-literal '(holding c))))
 
(setf (p4::nexus-children (find-node 4))
  (list
    (p4::make-goal-node 
        :name 5 
        :parent (find-node 4) 
        :goal 
            (p4::instantiate-consed-literal '(holding c)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 5))
  (list
    (p4::make-operator-node 
        :name 18 
        :parent (find-node 5) 
        :operator (p4::get-operator unstack))))
 
(setf (p4::nexus-children (find-node 18))
  (list
    (p4::make-binding-node 
        :name 19 
        :parent (find-node 18)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(on c a))
              (p4::instantiate-consed-literal '(clear c))
              (p4::instantiate-consed-literal '(arm-empty)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 19))
      (p4::make-instantiated-op
          :op (p4::get-operator unstack)
          :binding-node-back-pointer (find-node 19)
          :values (list 
                    (p4::object-name-to-object 'c *current-problem-space*)
                    (p4::object-name-to-object 'a *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(on c a))
              (p4::instantiate-consed-literal '(clear c))
              (p4::instantiate-consed-literal '(arm-empty)))))
 
(setf (p4::nexus-children (find-node 19))
  (list
    (p4::make-goal-node 
        :name 20 
        :parent (find-node 19) 
        :goal 
            (p4::instantiate-consed-literal '(clear c)) 
        :introducing-operators (list (find-node 19) )))) 
 
(setf (p4::nexus-children (find-node 20))
  (list
    (p4::make-operator-node 
        :name 23 
        :parent (find-node 20) 
        :operator (p4::get-operator unstack))))
 
(setf (p4::nexus-children (find-node 23))
  (list
    (p4::make-binding-node 
        :name 24 
        :parent (find-node 23)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(on b c))
              (p4::instantiate-consed-literal '(clear b))
              (p4::instantiate-consed-literal '(arm-empty)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 24))
      (p4::make-instantiated-op
          :op (p4::get-operator unstack)
          :binding-node-back-pointer (find-node 24)
          :values (list 
                    (p4::object-name-to-object 'b *current-problem-space*)
                    (p4::object-name-to-object 'c *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(on b c))
              (p4::instantiate-consed-literal '(clear b))
              (p4::instantiate-consed-literal '(arm-empty)))))
 
(setf (p4::nexus-children (find-node 24))
  (list
    (p4::make-applied-op-node 
        :name 25 
        :parent (find-node 24)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 25))
      (p4::make-instantiated-op
          :op (p4::get-operator unstack)
          :binding-node-back-pointer (find-node 24)
          :values (list 
                    (p4::object-name-to-object 'b *current-problem-space*)
                    (p4::object-name-to-object 'c *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(on b c))
              (p4::instantiate-consed-literal '(clear b))
              (p4::instantiate-consed-literal '(arm-empty)))))
 
(setf (p4::nexus-children (find-node 25))
  (list
    (p4::make-applied-op-node 
        :name 26 
        :parent (find-node 25)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 26))
      (p4::make-instantiated-op
          :op (p4::get-operator unstack)
          :binding-node-back-pointer (find-node 19)
          :values (list 
                    (p4::object-name-to-object 'c *current-problem-space*)
                    (p4::object-name-to-object 'a *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(on c a))
              (p4::instantiate-consed-literal '(clear c))
              (p4::instantiate-consed-literal '(arm-empty)))))
nil
USER(104): USER(104): 
|#
