;;; Stone, Veloso, Blythe -- 8/93

;;;From:
;;;@TechReport(Weld91, Author="A. Barrett and S. Soderland and Dan Weld",
;;;	Title="The Effect of Step-Order Representations on Planning",
;;;	Institution="Department of Computer Science and Engineering,
;;;	University of Washington",
;;;     Year="1991",Type="Technical Report", Number="91-05-06")

;;; Full interleaving needed - after an operator of type A2
;;; no operator of type A1 can be applied, because A2 deletes
;;; all literals i-0,i-1,...
;;; (Needs choice apply or subgoal otherwise interleaving is missed
;;; when A2-i operators apply in a chain after A1-i operators)

#|
;; Example: i=3

(OPERATOR A1-3
  (params)
  (preconds
   ()
   (i3))
  (effects 
      () 
      ((add (p3))
       (del (i1))
       (del (i2)))))

(OPERATOR A2-3
  (params)
  (preconds
   ()
   (p3))
  (effects
   ()
   ((add (g3))
    (del (i1))
    (del (i2))
    (del (i3))
    (del (p1))
    (del (p2)))))
|#

(defvar *number-a-ops* 15
  "Size parameter for the synthetic domain art-repeat")

(setf *number-a-ops* 15)

(create-problem-space 'art-md-ns :current t)
(setf *class-short-names* nil)

(dotimes (i *number-a-ops*)
  (eval
   `(operator ,(make-sym 'A1- (1+ i))
	      (params)
	      (preconds () 
	       (,(make-sym 'I (1+ i))))
	      (effects ()
	       ,(if (zerop i)
		    `((add (,(make-sym 'P (1+ i)))))
		    (let ((all-effects `((add (,(make-sym 'P (1+ i)))))))
		      (dotimes (j i)
			(push (cons 'del `((,(make-sym 'I (1+ j))))) all-effects))
		      all-effects))))))

(dotimes (i *number-a-ops*)
  (eval
   `(operator ,(make-sym 'A2- (1+ i))
	      (params)
	      (preconds () 
	       (,(make-sym 'P (1+ i))))
	      (effects ()
	       ,(let ((all-effects `((add (,(make-sym 'G (1+ i)))))))
		  (dotimes (j *number-a-ops*)
		    (push (cons 'del `((,(make-sym 'I (1+ j))))) all-effects))
		  (dotimes (j i)
		    (push (cons 'del `((,(make-sym 'P (1+ j))))) all-effects))
		  all-effects)))))



