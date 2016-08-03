;;; Peter Stone  5/28/94

;;; Action A-i can only be used to achieve one goal

(defvar *number-a-ops* 5
  "Size parameter for the synthetic domain art-dm-s2-star")

(defun make-sym (prefix number)
  (let ((*print-case* :upcase))
    (intern (format nil "~S~D" prefix number))))

#|
;; Example i=3

(OPERATOR A3
  (params <goal>)
  (preconds
   ((<goal> GOAL))
   (i3))
  (effects
   ()
   ((add (done <goal>))
    (del (i3)))))
|#

(create-problem-space 'art-wait-state :current t)

(ptype-of GOAL :top-type)

(dotimes (i *number-a-ops*)
  (eval
   `(operator ,(make-sym 'A (1+ i))
	      (params <goal>)
	      (preconds ((<goal> GOAL)) 
			(,(make-sym 'I (1+ i))))
	      (effects ()
		       ((add (done <goal>))
			(del (,(make-sym 'I (1+ i)))))))))





