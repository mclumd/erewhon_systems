;;;May 7 1994
;;; 
;;This is the symmetric example, for backward and forward reasoning
;; 


(setf *set-table* nil)
(setf *formula-table* nil)
(setf *term-table* nil)
(setf *subst-table* nil)

;special assertion set 
(add-to-set-table 'emptyset nil)
(setf emptyset 'emptyset)
;;First create the formulas and then the sets because the old
;;formula-names are not replaced in the set-table
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(create-formula '((forallf P)(equivf (symm (P)) ((forallf x1) ((forallf x2)(implf (El (x1 x2 P)) (El (x2 x1 P))))))) 'symmdef)

(create-formula '(implf (andf (symm (R)) (symm(S))) (symm ((inter(R S))))) 'goal)

(create-formula '((forallf x1) ((forallf x2) ((forallf P) ((forallf Q)
						       (equivf (El(x2 x1 (inter(P Q))))
							       (andf (El(x2 x1 Q)) (El(x2 x1 P)) )))))) 'interdef)


(setf (current-problem)
      (create-problem
       (name prob-symm)
       (objects
        ())
       (state
        (and
	 (nothing)
	 (is-definition interdef)
	 (is-definition symmdef)))
       (goal
        (follows emptyset goal))))

