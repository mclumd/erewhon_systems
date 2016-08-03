;;; Veloso & Cox -- 11/97

;;; This is the first artificial domain to test rationale-based monitors.

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

;;; makes alt not a static predicate.
(operator dummy
  (params <b>)
  (preconds
   ((<b> BIND))
   (and))
  (effects
   ()
   ((add (alt <b>)))))
 
