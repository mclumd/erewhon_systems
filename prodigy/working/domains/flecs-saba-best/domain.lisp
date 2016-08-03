;;; Manuela Veloso 8/93

;;;From:
;;;@TechReport(Weld91, Author="A. Barrett and S. Soderland and Dan Weld",
;;;	Title="The Effect of Step-Order Representations on Planning",
;;;	Institution="Department of Computer Science and Engineering,
;;;	University of Washington",
;;;     Year="1991",Type="Technical Report", Number="91-05-06")

;;; Action A-i deletes all the preconditions for actions A-j , j<i

(defvar *number-a-ops* 5
  "Size parameter for the synthetic domain art-repeat")

(defun make-sym (prefix number)
  (let ((*print-case* :upcase))
    (intern (format nil "~S~D" prefix number))))

#|
;; Example i=3

(OPERATOR A3
  (params)
  (preconds
   ()
   (i3))
  (effects
   ()
   ((add (g3))
    (del (i1))
    (del (i2)))))

(OPERATOR A2
  (params)
  (preconds
   ()
   (i2))
  (effects
   ()
   ((add (g2))
    (del (i1)))))
|#

(create-problem-space 'art-md :current t)

(dotimes (i *number-a-ops*)
  (eval
   `(operator ,(make-sym 'A (1+ i))
	      (params)
	      (preconds () (,(make-sym 'I (1+ i))))
	      (effects ()
	       ,(let ((all-effects `((add (,(make-sym 'G (1+ i)))))))
		  (dotimes (j i)
		    (push (cons 'del `((,(make-sym 'I (1+ j))))) all-effects))
		  all-effects)))))


;(CONTROL-RULE MAX-SUBGOAL
;  (if (candidate-goal <g>))
;  (then sub-goal))



