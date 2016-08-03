;;; Veloso -- 11/97
;;; Cox -- 3/99

;;; This is the second artificial domain to test rationale-based monitors.  The
;;; domain is similar to the last except that it adds alternative operators as
;;; well as alternative bindings to the choices for the
;;; alternative-based-usability monitor. See problem p3. This problem is the
;;; same as p2 except that it does not have (static b2) in the initial
;;; state. So if (static b1) is deleted during planning, alternative bindings
;;; will not help the matter. The series of operators represented by
;;; alt-op<num> are relevant in the place of a<num>.

(defvar *n-binding-alts* 2
  "Number of alternative bindings for each operator")

(defvar *n-ops* 3
  "Length of the solution")

(create-problem-space 'rationale-monitor-alts :current t)

#|
;;; Example *n-binding-alts*=2, *n-ops*=3

(ptype-of BIND :top-type)
(pinstance-of b1 b2 BIND)

;;; (alt b1) is true in the state
;;; and all the other (alt bs) are not.
;;; if all (alt bs) and some g become true,
;;; it should jump to that place on the tree.

(operator A0
  (params <b>)
  (preconds
   ((<b> BIND))
   (and (alt <b>)
	(g1)))
  (effects
   ()
   ((add (g0)))))

(operator A1
  (params <b>)
  (preconds
   ((<b> BIND))
   (and (alt <b>)
	(g2)))
  (effects
   ()
   ((add (g1)))))

(operator A2
  (params <b>)
  (preconds
   ((<b> BIND))
   (and))
  (effects
   ()
   ((add (g2)))))
|#

;; Integers i such that  1<=i<=x
(defun gen-lte (x)
  (if (<= x 0) 
      nil
    (if (= x 1) (list x) (cons x (gen-lte (- x 1))))))

(defun make-sym (letter num)
  (intern (string-upcase (format nil "~s~s" letter num)))
  )


(ptype-of BIND :top-type)

(eval (cons 'pinstance-of
	    (append (mapcar '(lambda (x) (make-sym 'B x)) (gen-lte *n-binding-alts*))
		    '(BIND))))


	      
(dotimes (i (1- *n-ops*))
  (eval
   `(operator ,(make-sym 'A i)
	      (params <b>)
	      (preconds ((<b> BIND))
			(and (alt <b>)
			     ,@(if (eq  *test-condition* 
					'alternative-based-usability)
				   '((static <b>)))
			     (,(make-sym 'G (1+ i)))))
	      (effects ()
		((add (,(make-sym 'G i))))))))

(dotimes (i (1- *n-ops*))
  (eval
   `(operator ,(make-sym 'Alt-op i)
	      (params <b>)
	      (preconds ((<b> BIND))
			(and (alt <b>)
			     (,(make-sym 'G (1+ i)))))
	      (effects ()
		((add (,(make-sym 'G i))))))))

(eval
 `(operator ,(make-sym 'A (1- *n-ops*))
	    (params <b>)
	    (preconds ((<b> BIND))
		      ,(if (eq  *test-condition* 'alternative-based-subgoal)
			   '(and)
			 (if (eq  *test-condition* 'alternative-based-usability)
			     '(static <b>))))
	    (effects ()
		     ((add (,(make-sym 'G (1- *n-ops*))))))))

(eval
 `(operator ,(make-sym 'Alt-op (1- *n-ops*))
	    (params <b>)
	    (preconds ((<b> BIND))
		      (and))
	    (effects ()
		     ((add (,(make-sym 'G (1- *n-ops*))))))))

;;; makes alt not a static predicate.
(operator dummy
  (params <b>)
  (preconds
   ((<b> BIND))
   (and))
  (effects
   ()
   ((add (alt <b>)))))



 
