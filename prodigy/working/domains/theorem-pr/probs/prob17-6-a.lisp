;;;June 3 1994
;;; 
;;This is the 17.6.3 (a) example, with backward and forward reasoning
;;  now changed to a simpler problem with 2 goals: goal1 is auxiliary
;;  (because each cycle allows only one consecutive application of
;;  inference rules)
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

(create-formula '((forallf P)(equivf (leftcon (P)) ((forallf x1)((forallf x2)(implf
							      (andf (El(f Fset)) (Elpair (x1 x2 P))) (Elpair ((mult(f x1)) (mult(f x2)) P))))))) 'leftcondef)
;;;;;;;;;;;;;;;;;
(create-formula '(leftcon (rho)) 'ass1)

;;;;;;;;;;;;;;;;;;
(create-formula '((forallf u) ((forallf v) (equivf (El(u (sigma(v)))) (Elpair(u v rho))))) 'sigmadef)

;;;;;;;;;;;;;;;;;;
(create-formula '((forallf x3) ((forallf M) ((forallf N) (equivf (El(x3 (inter(M N)))) (andf
								(El(x3 N)) (El(x3 M))))))) 'interdef)

;;;;;;;;;;;;;;;;;;
(create-formula '((forallf Set )(equivf (nonempty (Set)) ((existsf x)(El(x Set))))) 'nonemptydef)

;;;;;;;;;;;;;;;;

(create-formula '((forallf C)(equivf (compat(rho C)) ((forallf w)(implf (nonempty((inter((sigma(w)) C)))) (subset ((sigma(w)) C)))))) 'compatibledef)

;;;;;;;;;;;;;;;;;;
 (create-formula '(compat(rho E)) 'ass2)

;;;;;;;;;;;;;;;;
(create-formula '((forallf M1)((forallf N1) (implf (subset (M1 N1))((forallf y) (implf (El(y M1))(El(y N1))))))) 'subsetdef)

;;;;;;;;;;;;;;;;;
(create-formula '(equivrel (rho)) 'ass3)

;;;;;;;;;;;;;;;;;
#|
(create-formula '((forallf R)(equivf (equivrel(R)) ((forallf s) ((forallf t) (andf (Elpair(s s R)) (andf (Formel)(implf (Elpair(s t R)) (Elpair(t s R))))))))) 'equivreldef)
|#
;;;;;;;;;;;;;;;;;;;;;

(create-formula '((forallf R)(equivf (equivrel(R)) (andf ((forallf x3) (Elpair(x3 x3 R))) (andf ((forallf s) ((forallf t) (implf (Elpair(s t R)) (Elpair(t s R)))))  (Formel))))) 'equivreldef)

;;;;;;;;;;;;;;;;
(create-formula '(Elpair(a b rho)) 'ass4)

;;;;;;;;;;;;;
(create-formula '(El(f Fset)) 'ass5)

;;;;;;;;;;;;;;;
(create-formula '(El( (mult(f a)) E)) 'ass6)

;;;;;;;;;;;;;;;;;

(create-formula '(El( (mult(f b)) E)) 'goal)
;;;;;;;;;;;;;;;;;;;;;;;;;;

(create-formula '(implf (El ((mult(f b)) (sigma ((mult (f b)))))) (El ((mult(f b)) E))) 'goal1)
;;;;;;;;;;;;;;;;; 

(setf (current-problem)
      (create-problem
       (name prob19)
       (objects
        ())
       (state
        (and
	 (nothing)
	 (is-definition leftcondef)
	 (is-definition sigmadef);later just as an equivalence
	 (is-definition interdef)
	 (is-definition nonemptydef)
	 (is-definition compatibledef)
	 (follows emptyset ass1)
	 (follows emptyset ass2)
	 (follows emptyset ass3)	 
	 (is-definition subsetdef)
	 (is-definition equivreldef)
	 (follows emptyset ass4)
	 (follows emptyset ass5)
	 (follows emptyset ass6)	 
	 ))
       (goal
	(and (follows emptyset goal1)
        (follows emptyset goal)))))
