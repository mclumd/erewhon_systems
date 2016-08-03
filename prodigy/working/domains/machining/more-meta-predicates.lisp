;;; aperez
;;; This is a collection of domain-independent  meta-predicates that I
;;; wrote as I needed them for the logistics and machining domains.
;;; Please send bugs to aperez@cs


(in-package 'user)

(defun is-subgoal-of-p (goal-exp inst-op-exp)
  ;;adapted from open-load-truck-p
  ;;goal-exp and inst-op-exp have to be bound to lists
  ;;goal-exp has to be completely instantiated (from other meta-preds)
  ;;The car of inst-op-exp, (the op-name) has to be bound, but its 
  ;;arguments don't need to be bound
  (let* (new-bindings
	 (result
	  (some
	   #'(lambda (inst-op)
	       (and
		;;check op name
		(eq (p4::operator-name (p4::instantiated-op-op inst-op))
		    (car inst-op-exp))
		;;check the arguments
		(every
		 #'(lambda (arg-obj arg-name)
		     ;;allow arg-name to be a variable
		     (cond ((p4::strong-is-var-p arg-name)
			    (push (cons arg-name arg-obj) new-bindings))
			   (t (equal arg-obj arg-name))))
		 (p4::instantiated-op-values inst-op)
		 (cdr inst-op-exp))))
	   ;;instantiated operators that have goal-exp as a subgoal
;	   (p4::literal-goal-p (goal-obj goal-exp))
	   (p4::literal-goal-p (p4::instantiate-consed-literal goal-exp)))))
    (if  new-bindings (list new-bindings) result)))

#| This works, but it does the same as p4::instantiate-consed-literal
(defun goal-obj (goal-exp)
  ;;hash for the predicate (then look for args)
  (gethash
   ;;here the args of goal-exp have to be prodigy-objects
   (cdr goal-exp)
   ;;hash table for the predicate
   (gethash
    (car goal-exp)
    (p4::problem-space-assertion-hash *current-problem-space*))))
|#



;;this is different from meta-predicates.lisp. Mei fixed it. I will
;;keep this just in case...
(defun find-inst-op-node (node goal-exp grand-child)
  (declare (ignore grand-child))
  ;;path is (goal op bindings apply-op*)
  ;;this is a mess......... It will break if node does not have enough
  ;;ancestrors 
  (let ((next-goal-and-bind-nodes
	 (case
	  (type-of node)
	  (p4::goal-node
	   (next-goal (p4::nexus-parent node) node nil))
	  (p4::operator-node
	   (next-goal
	    (p4::nexus-parent (p4::nexus-parent node))
	    (p4::nexus-parent node)
	    node))
	  (p4::binding-node
	   (next-goal
	    (p4::nexus-parent (p4::nexus-parent (p4::nexus-parent node)))
	    (p4::nexus-parent (p4::nexus-parent node))
	    (p4::nexus-parent node)))
	  (p4::applied-op-node
	   (next-goal (p4::nexus-parent node) node nil)))))
    (if next-goal-and-bind-nodes
	(find-inst-op-node-rec (car next-goal-and-bind-nodes)
			       goal-exp
			       (cdr next-goal-and-bind-nodes)))))

;;; ******************************************************************
;;; Using (~ (expanded-goal ...)) gives an error if there are unbound
;;; vars:  "NEGATED-PRED-MATCH: there are unbound vars in expr"

(defun not-expanded-goal (goal)
  (not (expanded-goal goal)))

(defun not-expanded-operator (op-exp)
  (not (expanded-operator op-exp)))

(defun not-candidate-goal (goal)
  (not (candidate-goal goal)))

;;; ******************************************************************
;;;

(defun number-of-matches (number exp)
  (cond
    ((p4::strong-is-var-p number)
     (list (list (cons number (length (eval exp))))))
    (t (equal number (length (eval exp))))))

;;; ******************************************************************
;;;

(defun forall-metapred (generator exp)
  "Tests whether exp is true for all the bindings that satisfy
the generator. Equivalent to a forall x s.t P(x) -> Q(x)"
  (declare (special *current-node*))
  (every #'(lambda (binding)
	     (p4::descend-match exp *current-node* binding))
	 (p4::descend-match generator *current-node* nil)))


;;; ****************************************************************
;;;

(defun last-expanded-goal (goal)
  "Tests whether <goal> is the last expanded goal in the current path."
  (declare (special *current-problem-space*))
  (test-match-goals
   goal
   (list (car (p4::problem-space-expanded-goals *current-problem-space*)))))



;;; ****************************************************************
;;; Returns bindings that match any of the clauses
;;; The reason I wrote it is to find an object location
;;; (or-metapred (at-object <o> <l>)
;;;              (and (inside-airplane <o> <pl>)
;;;                   (at-airplane <pl> <l>)))


(defun or-metapred (&rest exp)
  (all-matches exp))

(defun all-matches (exp)
  (declare (special *current-node*))
  (cond
    ((null exp) nil)
    (t (append (p4::descend-match (car exp) *current-node* nil)
	       (all-matches (cdr exp))))))

;;; ****************************************************************
;;;

(defun not-metapred (exp)
  (declare (special *current-node*))
  (not (p4::descend-match exp *current-node* nil)))

;;; ****************************************************************
;;;I am introducing an inefficiency here because the all the goasl are
;;;generated and then the select rules applied.

(defun candidate-goal-to-sel (goal)
  (declare (special *current-node*))
  (test-match-goals
   goal
   (remove-if
    #'(lambda (x)(p4::goal-loop-p *current-node* x))
    (p4::give-me-all-pending-goals *current-node*))))

;;; ****************************************************************
;;; Assign a value to the rule preference (used only to break
;;; preference cycles)

;;this whole thing would be more efficient if the value is only
;;assigned in case there actually is a preference cycle

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

(defun preference-value-for-goal (value goal)
  (declare (special *current-node*))
  (let ((goal-lit
	 (p4::instantiate-consed-literal 
	  (if (member (car goal) '(~ not))
	      (second goal) goal))))
    (setf (getf (p4::literal-plist goal-lit) :pref-rule-value)
	  (eval value))
    t))
		

;;; ************************************************************
;;; From here on I wrote them for the machining domain

(defun current-goal-first-arg (object)
  "Tests whether <object> is the first argument of the current goal.
Can be used as a generator."
  (declare (special *current-node*))
  (let ((first-arg
	 (elt (p4::literal-arguments
	       (p4::goal-node-goal (give-me-goal-node *current-node*)))
	      0)))
    (or
     (and (p4::strong-is-var-p object)
	  (bind-up object first-arg))
     (equal object (p4::prodigy-object-name first-arg)))))





