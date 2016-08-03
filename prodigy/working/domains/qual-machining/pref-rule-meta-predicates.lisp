(in-package 'user)

;;; ****************************************************************
;;; Assign a value to the rule preference (used only to break
;;; preference cycles)

;;this whole thing would be more efficient if the value is only
;;assigned in case there actually is a preference cycle


;;this is the version used in logistics-cap/rules/rules-distance.lisp.
;;ex: 	   (preference-value <d-origs> <object> <pl> <dest> <x> <y>)

(defun preference-value (value &rest bindings)
 ;;only for bindings
 (declare (special *current-node*))
  (let ((alt (find-if
	      #'(lambda (alt)
		  (equal bindings (p4::instantiated-op-values alt)))
	      (p4::operator-node-bindings-left *current-node*))))
    (cond
      (alt
       (setf (getf (p4::instantiated-op-plist alt) :pref-rule-value)
	     (eval value))
       t)
      (t nil))))


;;Another version, that can be used with partial bindings. Ex
;;(preference-value <n> ((<MACHINE> . <MACHINE-378>)
;;                       (<HOLDING-DEVICE> . <HOLDING-DEVICE-379>)
;;                       (<SIDE-PAIR> . <SIDE-PAIR-380>)))

(defun preference-value-for-bindings (value bindings-exp)
  (declare (special *current-node*))
  ;;bindings-exp is a binding list and we need to get a member of the
  ;;candidates, which are instantiated-operators.
  (let ((alt
	 (car
	  (p4::find-binding
	   bindings-exp
	   (p4::operator-node-bindings-left *current-node*)
	   (p4::operator-vars (p4::operator-node-operator *current-node*))))))
    (cond
      (alt
       (setf (getf (p4::instantiated-op-plist alt) :pref-rule-value)
	     (eval value))
       t)
      (t nil))))


(defun preference-value-for-goal (value goal)
  (declare (special *current-node*))
  (setf (getf (p4::literal-plist
	       (or (and (p4::literal-p goal) goal)
		   (p4::instantiate-consed-literal 
		    (if (member (car goal) '(~ not))
			(second goal) goal))))
	      :pref-rule-value)
	(eval value))
  t)

(defun preference-value-for-op (value op)
  (declare (special *current-node*))
  (setf (getf (p4::operator-plist
	       (or (and (p4::operator-p op) op)
		   (p4::rule-name-to-rule op *current-problem-space*)))
	      :pref-rule-value)
	(eval value))
  t)

#|
(let ((goal-lit
	 (p4::instantiate-consed-literal 
	  (if (member (car goal) '(~ not))
	      (second goal) goal))))
    (setf (getf (p4::literal-plist goal-lit) :pref-rule-value)
	  (eval value))
    t))
|#

(defun pending-goal-distance (value goal)
  (declare (special *current-node*))
  ;;return (list (list (cons value number)))
  (let* ((neg-p (and (listp goal)(member (car goal) '(~ not))))
	 (goal-lit (if neg-p
		       (p4::instantiate-consed-literal (second goal))
		       (p4::instantiate-consed-literal goal))))
    (list
     (list
      (cons value
	    (compute-pending-goal-distance goal-lit neg-p *current-node*))))))

(defun compute-pending-goal-distance (goal neg-p node)
  (declare (type p4::nexus node)
	   (type p4::literal goal))
  ;;we get to the top node if goal is pending for other top level
  ;;goal. Then give it the max value (depth of the tree at *current-node*)
  (cond
    ((null node) 0)
    ((and (p4::binding-node-p node)
	  (member (p4::binding-node-instantiated-op node)
		  (if neg-p
		      (p4::literal-neg-goal-p goal)
		      (p4::literal-goal-p goal))))
     0)
    (t (1+ (compute-pending-goal-distance
	    goal neg-p (p4::nexus-parent node))))))