(in-package 'user)

(defun first-pending-subgoal-in-subtree (goal inst-ops)
  "Tests whether <goals> are currently a pending goal and a subgoal of
only one (or several) of <inst-ops>. Can be used as a generator for <goal>.
<goal> has to be a variable or a literal.
<inst-ops> has to be bound to a list of instantiated-ops."
  (declare (special *current-node*))
  (if (p4::strong-is-var-p inst-ops)
      (error "Error: ~A has to be instantiated." inst-ops)
      (let ((first-pending-goal
	     (dolist (g (p4::give-me-all-pending-goals *current-node*))
	       (if (some #'(lambda (intro-op)
			 (in-subtree-below-p inst-ops intro-op))
		     ;;ops that introduced g
		     (or (and (p4::literal-state-p g)
			      (p4::literal-neg-goal-p g))
			 (and (not (p4::literal-state-p g))
			      (p4::literal-goal-p g))))
	       (return g)))))
	(cond
	  ((p4::strong-is-var-p goal)
	   (list (list (cons goal first-pending-goal))))
	  ((p4::literal-p goal)
	   (eq goal first-pending-goal))
	  (t (error "Error: first argument of ~
              first-pending-subgoal-in-subtree has to be a variable ~
              or a literal."))))))

#|
(defun first-pending-subgoal-in-subtree (goal inst-ops)
  "Tests whether <goals> are currently a pending goal and a subgoal of
only one (or several) of <inst-ops>. Can only be used as a generator for <goal>.
<goal> is always a variable and <inst-ops> has to be bound to a list
of instantiated-ops."
  (declare (special *current-node*))
  (if (p4::strong-is-var-p goal)
      (dolist (g (p4::give-me-all-pending-goals *current-node*))
	   (if (some #'(lambda (intro-op)
			 (in-subtree-below-p inst-ops intro-op))
		     ;;ops that introduced g
		     (or (and (p4::literal-state-p g)
			      (p4::literal-neg-goal-p g))
			 (and (not (p4::literal-state-p g))
			      (p4::literal-goal-p g))))
	       (return (list (list (cons goal g))))))
      (error "error: <goal> has to be a variable")))
|#


;;oct 13, tst7-3
;; is-subgoal-of-ops is inconsistent:
;; - if called with <goal> bound, it binds <ops> to a list of ops for
;; which goal is a subgoal
;; - if called with <goal> bound and <ops> bound, it checks whether
;; <goal> is a subgoal of *ANY* of <ops> instead of *ALL* of <ops>

;; I am not sure if the correct behavior will fail in other problems
;; that's why for now I define a new metapredicate 

(defun is-subgoal-of-all-ops (goal inst-ops)
  "Tests whether <goal> is a subgoal of one of <inst-ops> that is
marked as a goal. Can be used as generator for both <goal> and
<inst-ops> (binding them respectively to a literal and a list of
instantiated-ops). If <goal> is bound, it is bound to a list or to a
literal, and it has to be completely instantiated. If only <inst-ops>
is bound, it has to be bound to a list of instantiated-ops. If both
are bound, <inst-ops> is bound to a list of instantiated operators or
to a list of lists. In the latter case the car of each element, the
op-name, has to be bound, but its arguments don't need to."
  (cond
    ((p4::strong-is-var-p goal)
     (mapcan #'(lambda (prec)
		 ;;I assume that prec is a literal or (~ literal).
		 ;;return only those preconds which are actually  as goals.
		 (if (p4::literal-p prec)
		     (and (p4::literal-goal-p prec)
			  (not (p4::literal-state-p prec))
			  (list (list (cons goal prec))))
		     (and (p4::negated-goal-p (second prec))
			  (list (list (cons goal (second prec)))))))
	     (remove-duplicates
	      (apply #'append
		     (mapcar #'(lambda (inst-op)
				 ;;will give problems if next line is not a
				 ;;conjunction 
				 (cdr (p4::instantiated-op-precond inst-op)))
			     inst-ops)))))
    ((p4::strong-is-var-p inst-ops)
     ;;instantiated operators that have goal as a subgoal
     (let ((ios (p4::literal-goal-p
		 (if (p4::literal-p goal) goal
		     (p4::instantiate-consed-literal goal)))))
       (if ios (list (list (cons inst-ops ios))))))
    (t ;;both goal and inst-ops are bound
     (let* ((goal-literal
	     (if (p4::literal-p goal) goal
		 (p4::instantiate-consed-literal goal)))
	    new-bindings
	    (result
	     (some
	      #'(lambda (io)
		  ;;this may be inefficient
		  (every 
		   #'(lambda (inst-op)
		       ;;this may be inefficient as for each inst-op
		       ;;expressed as a list we are getting the name
		       ;;and args of io. But for now I have't used
		       ;;is-subgoal-of-ops specifying the ops as
		       ;;lists. 
		       (if (p4::instantiated-op-p inst-op)
			   (eq inst-op io)
			   (and
			    ;;check op name
			    (eq (p4::operator-name (p4::instantiated-op-op io))
				(car inst-op))
			    ;;check the arguments
			    (every
			     #'(lambda (arg-obj arg-name)
				 ;;allow arg-name to be a variable
				 (cond ((p4::strong-is-var-p arg-name)
					(push (cons arg-name arg-obj) new-bindings))
				       (t (equal arg-obj arg-name))))
			     (p4::instantiated-op-values io)
			     (cdr inst-op)))))
		   inst-ops))
	      ;;instantiated operators that have goal as a subgoal
	      (if (p4::negated-goal-p goal-literal)
		  (p4::literal-neg-goal-p goal-literal)
		  (p4::literal-goal-p goal-literal)))))
       (if new-bindings (list new-bindings) result)))))


;;; ******************************************************************

(defun is-goal-achieved-by-ops (goal ops)
  "Binds <goal> to a goal for which one of <ops> was chosen. <ops> has
to be bound to a list of instantiated-ops."
  (cond
    ((p4::strong-is-var-p ops)
     (error "~A has to be bound." ops))
    ((not (p4::strong-is-var-p goal))
     (error "First arg of is-goal-achieved-by-ops has to be a variable."))
    (t (mapcar
	#'(lambda (io)
	    (list
	     (cons goal
		   (p4::goal-node-goal
		    (p4::nexus-parent
		     (p4::nexus-parent
		      (p4::instantiated-op-binding-node-back-pointer io)))))))
	ops))))