;;; aperez
;;; This is a collection of domain-independent  meta-predicates that I
;;; wrote as I needed them for the logistics and machining domains.
;;; Please send bugs to aperez@cs


(in-package 'user)

(defun is-subgoal-of-ops (goal inst-ops)
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
		  (member
		   io inst-ops
		   :test
		   #'(lambda (io inst-op)
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
			     (cdr inst-op)))))))
	      ;;instantiated operators that have goal as a subgoal
	      (if (p4::negated-goal-p goal-literal)
		  (p4::literal-neg-goal-p goal-literal)
		  (p4::literal-goal-p goal-literal)))))
       (cond
	 (new-bindings (list new-bindings))
	 (result t)
	 (t nil))))))


(defun is-subgoal-of-p (goal inst-op)
  "Tests whether <goal> is a subgoal of <inst-op> that is marked as a
goal. Can be used as generator for both <goal> and <inst-op> (binding
them respectively to a literal and an instantiated-op). If <goal> is
bound, it is bound to a list or to a literal, and it has to be
completely instantiated. If only <inst-op> is bound, it has to be
bound to an instantiated-op. If both are bound, <inst-op> is bound to
an instantiated operator or to a list. In the latter case the  car of
<inst-op>, (the op-name) has to be bound, but its arguments don't need
to."
  ;;adapted from open-load-truck-p
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
	     ;;will give problems if next line is not a conjunction
	     (cdr (p4::instantiated-op-precond inst-op))))
    ((p4::strong-is-var-p inst-op)
     (mapcar #'(lambda (io) (list (cons inst-op io)))
	     ;;instantiated operators that have goal as a subgoal
	     (p4::literal-goal-p
	      (if (p4::literal-p goal) goal
		  (p4::instantiate-consed-literal goal)))))
    (t ;;both goal and inst-op are bound
     (let* ((goal-literal
	     (if (p4::literal-p goal) goal
		 (p4::instantiate-consed-literal goal)))
	    new-bindings
	    (result
	     (some
	      #'(lambda (io)
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
	      ;;instantiated operators that have goal as a subgoal
	       (if (p4::negated-goal-p goal-literal)
		   (p4::literal-neg-goal-p goal-literal)
		   (p4::literal-goal-p goal-literal)))))
       (if new-bindings (list new-bindings) result)))))


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

(defun is-pending-subgoal-only-below-ops (goal inst-ops)
  "Tests whether <goal> is currently a pending goal and a subgoal of
only one (or several) of <inst-ops>. Can only be used as a generator for <goal>.
<goal> is always a variable and <inst-ops> has to be bound to a list
of instantiated-ops."
  (declare (special *current-node*))
  (if (p4::strong-is-var-p goal)
      (mapcan
       #'(lambda (g)
	   (if (every #'(lambda (io)
			  (member io inst-ops))
		      (or (and (p4::literal-state-p g)
			       (p4::literal-neg-goal-p g))
			  (and (not (p4::literal-state-p g))
			       (p4::literal-goal-p g))))
	       (list (list (cons goal g)))))
       (p4::give-me-all-pending-goals *current-node*))
      (error "error: <goal> has to be a variable")))

;;oct 13, tst7-3
;; The following definition of is-pending-subgoal-in-subtree is
;; inconsistent: 
;; - if called with <goal> bound, it binds <ops> to a list of ops for
;; which goal is a subgoal
;; - if called with <goal> bound and <ops> bound, it checks whether
;; <goal> is a subgoal of *ANY* of <ops> instead of *ALL* of <ops>
;; See fixed definition below.

;; I am not sure if the corrected behavior will casue trouble in other
;; problems 

#|    
(defun is-pending-subgoal-in-subtree (goal inst-ops)
  "Tests whether <goal> is a currently pending goal that is a subgoal
in the subgoal tree below one of <inst-ops>. Can be used as a
generator for <goal>. <goal> then is a variable and <inst-ops> has to be
bound to a list of instantiated-ops."
  (declare (special *current-node*))
  (cond
    ((p4::strong-is-var-p inst-ops)
     (error "error: ~A has to be bound" inst-ops))     
    ((p4::strong-is-var-p goal)
      (mapcan
       #'(lambda (g)
	   (if (some #'(lambda (intro-op)
			 (in-subtree-below-p inst-ops intro-op))
		     ;;ops that introduced g
		     (or (and (p4::literal-state-p g)
			      (p4::literal-neg-goal-p g))
			 (and (not (p4::literal-state-p g))
			      (p4::literal-goal-p g))))
	       (list (list (cons goal g)))))
       (p4::give-me-all-pending-goals *current-node*)))
    ((p4::literal-p goal)
     (some #'(lambda (intro-op)
	       (in-subtree-below-p inst-ops intro-op))
	   ;;ops that introduced goal
	   (or (and (p4::literal-state-p goal)
		    (p4::literal-neg-goal-p goal))
	       (and (not (p4::literal-state-p goal))
		    (p4::literal-goal-p goal)))))
    (t (error "error: ~A value not allowed" goal))))
|#



(defun is-pending-subgoal-in-subtree (goal inst-ops)
  "Tests whether <goal> is a currently pending goal that is a subgoal
in the subgoal tree below one of <inst-ops>. Can be used as a
generator for <goal>. <goal> then is a variable and <inst-ops> has to be
bound to a list of instantiated-ops."
  (declare (special *current-node*))
  (cond
    ((p4::strong-is-var-p inst-ops)
     (error "error: ~A has to be bound" inst-ops))     
    ((p4::strong-is-var-p goal)
      (mapcan
       #'(lambda (g)
	   (if (some #'(lambda (intro-op)
			 (in-subtree-below-p inst-ops intro-op))
		     ;;ops that introduced g
		     (or (and (p4::literal-state-p g)
			      (p4::literal-neg-goal-p g))
			 (and (not (p4::literal-state-p g))
			      (p4::literal-goal-p g))))
	       (list (list (cons goal g)))))
       (p4::give-me-all-pending-goals *current-node*)))
    ((p4::literal-p goal)
     (some #'(lambda (intro-op)
	       ;;(in-subtree-below-p inst-ops intro-op)
	       (in-subtree-below-all-p inst-ops intro-op))	       
	   ;;ops that introduced goal
	   (or (and (p4::literal-state-p goal)
		    (p4::literal-neg-goal-p goal))
	       (and (not (p4::literal-state-p goal))
		    (p4::literal-goal-p goal)))))
    (t (error "error: ~A value not allowed" goal))))



(defun in-subtree-below-all-p (instops intro-op)
  ;;check whether intro-op is in the subgoal tree below *all* of
  ;;instops 
  (declare (type p4::instantiated-op intro-op)
	   (list instops))
  (every
   #'(lambda (instop)
       (or (eq instop intro-op)
	   (some #'(lambda (parent-io)
		     (in-subtree-below-all-p instops parent-io))
		 (parent-ops-of intro-op))))
   instops))


(defun in-subtree-below-p (instops intro-op)
  ;;check whether intro-op is in the subgoal tree below *one* of
  ;;instops 
  (declare (type p4::instantiated-op intro-op)
	   (list instops))
  (cond
    ((null intro-op) nil)
    ((member intro-op instops) t)
    (t (some #'(lambda (parent-io)
		 (in-subtree-below-p instops parent-io))
	     (parent-ops-of intro-op)))))

(defun parent-ops-of (io)
  ;;for each of the preconds of io, find the instantiated-op that has
  ;;been chosen to achieve it (if any)
  (declare (type p4::instantiated-op io))
  (let ((goal-node
	 (p4::nexus-parent
	  (p4::nexus-parent
	   (p4::instantiated-op-binding-node-back-pointer io)))))
    (if (not (eq (p4::nexus-name goal-node) 2)) ;(done) node
	(mapcar #'p4::binding-node-instantiated-op
		(p4::goal-node-introducing-operators goal-node)))))

;;; ******************************************************************
;;; Using (~ (expanded-goal ...)) gives an error if there are unbound
;;; vars:  "NEGATED-PRED-MATCH: there are unbound vars in expr"

(defun not-expanded-goal (goal)
  (not (expanded-goal goal)))

(defun not-expanded-operator (op-exp)
  (not (expanded-operator op-exp)))

(defun not-candidate-goal (goal)
  (not (candidate-goal goal)))

(defun not-metapred (exp)
  (declare (special *current-node*))
  (not (p4::descend-match exp *current-node* nil)))

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
  "Tests whether <goal> is the last expanded goal, not achieved yet, in
the current path. Can be used as a generator."
  (declare (special *current-problem-space*))
  (test-match-goals
   goal
   (list (car (p4::problem-space-expanded-goals *current-problem-space*)))))

(defun last-achieved-goal (goal)
  "Tests whether <goal> is the last achieved goal (i.e. the goal for
which the last applied operator was chosen). Can be used as a
generator."
  (declare (special *current-node*))
  (let ((applied-op-node
	 (give-me-applied-op-node *current-node*)))
    (if (eq (p4::nexus-name applied-op-node) 1)
	nil
	(test-match-goals
	 goal
	 (list (goal-achieved-by-applied-node applied-op-node))))))

(defun goal-achieved-by-applied-node (node)
  ;;returns the goal for which the applied-op was chosen
  (declare (type p4::applied-op-node node))
  (p4::goal-node-goal
   (p4::nexus-parent
    (p4::nexus-parent
     (p4::instantiated-op-binding-node-back-pointer
      (p4::applied-op-node-instantiated-op node))))))
  

(defun last-goal-worked-on (goal)
  "Tests whether <goal> is the last goal we worked on, and possibly
achieved. Can be used as a generator."
  (declare (special *current-node*))
  (test-match-goals
   goal
   (list (p4::goal-node-goal
	  ;;find the last goal node (not including current one)
	  (car (next-goal
		(p4::nexus-parent *current-node*) *current-node* nil))))
   ))

;;; ****************************************************************
;;; Returns bindings that match any of the clauses
;;; The reason I wrote it is to find an object location
;;; (or-metapred (at-object <o> <l>)
;;;              (and (inside-airplane <o> <pl>)
;;;                   (at-airplane <pl> <l>)))


(defun or-metapred (&rest exp)
;  (all-matches exp)
  (declare (special *current-node*))
  (mapcan #'(lambda (e)
	      (p4::descend-match e *current-node* nil))
	  exp))

;; Returns bindings that match one of the clauses (stop when one
;; found) 

(defun or-metapred-first (&rest exp)
  (declare (special *current-node*))
  (let (res)
    (find-if #'(lambda (e)
		 (setf res (p4::descend-match e *current-node* nil)))
	     exp)
    res))

#|
(defun all-matches (exp)
  (declare (special *current-node*))
  (cond
    ((null exp) nil)
    (t (append (p4::descend-match (car exp) *current-node* nil)
	       (all-matches (cdr exp))))))
|#
(defun all-matches (exp)
  (declare (special *current-node*))
  (mapcar #'(lambda (e)
	      (p4::descend-match e *current-node* nil))
	  exp))

;;; ****************************************************************
;;;I am introducing an inefficiency here because the all the goals are
;;;generated and then the select rules applied.

(defun candidate-goal-to-sel (goal)
  (declare (special *current-node*))
  (test-match-goals
   goal
   (remove-if
    #'(lambda (x)(p4::goal-loop-p *current-node* x))
    (p4::give-me-all-pending-goals *current-node*))))

(defun pending-goal (goal)
  "Tests whether <goal> is a goal pending to be achieved, even if it
has already been expanded (which is the difference with
candidate-goal or candidate-goal-to-sel). Can be used as a generator."
  (declare (special *current-node*))
  (test-match-goals
   goal
   (p4::give-me-all-pending-goals *current-node*)))


;;this is only intented for efficiency purposes. Would not recommend
;;using it as the goal order may change by using preference rules.

(defun first-candidate-goal (goal)
  (let ((cands (candidate-goals)))
    (if cands (test-match-goals goal (list (car cands))))))

;;; ****************************************************************

(defun goal-instance-of (goal &rest pred-list)
  "Tests whether goal is an instance of a predicate in one list.
<goal> has to be bound to a literal. Not a generator."
  (or (p4::literal-p goal) (break "~A has to be a literal" goal))
  (if (member (p4::literal-name goal) pred-list) t))
  
;;; ****************************************************************

(defun relevant-op-for-goal (op goal)
  "Tests whether <op> may achieve <goal> by checking <op>'s right-hand
side only, including matching effect constants. Mya be used as a
generator for <op>."
  ;;it has to retrun <op> bound to op names, not to op objects.
  (declare (special *current-node*))
  (if (p4::strong-is-var-p goal)
      (error "~A has to be bound." goal))
  (or (p4::literal-p goal)
      (setf goal (p4::instantiate-literal (car goal)(cdr goal))))
  (let ((rel-ops (p4::prune-get-all-ops goal *current-node*)))
    (cond
      ((p4::strong-is-var-p op)
       (mapcar #'(lambda (o) (list (cons op (p4::operator-name o))))
	       rel-ops))
      ((member op rel-ops
	       :test #'(lambda (o op-obj)
			 (or (eq o op-obj)
			     (equal o (p4::operator-name op-obj)))))
       t)
      (t nil))))
       

;;; ************************************************************
;;; From here on I wrote them for the machining domain

(defun current-goal-first-arg (object)
  "Tests whether <object> is the first argument of the current goal.
Can be used as a generator."
  (declare (special *current-node*))
  (let ((args (p4::literal-arguments
	       (p4::goal-node-goal
		(give-me-node-of-type 'p4::goal-node *current-node*)))))
    (cond
      ((zerop (array-dimension args 0)) nil)
      ((p4::strong-is-var-p object)
       (bind-up object (elt args 0)))
      ((equal object (p4::prodigy-object-name (elt args 0)))))))

(defun goal-first-arg (goal object)
  "Tests whether <object> is the first argument of <goal>.
<goal> has to be bound to a literal. Can be used as a generator for
<object>." 
  (declare (special *current-node*)
	   (type p4::literal goal))
  (let ((args (p4::literal-arguments goal)))
    (cond
      ((zerop (array-dimension args 0)) nil)
      ((p4::strong-is-var-p object)
       (bind-up object (elt args 0)))
      ((equal object (elt args 0))))))

;;; ************************************************************

(defun one-of-metapred (x list)
  (cond
   ((not (listp list))
    (error "list has to be a list~%"))
   ((p4::strong-is-var-p x)
    (mapcar  #'(lambda (cand) (list (cons x cand))) list))
   ((typep x 'symbol)
    (member x list :test #'equal))
   ( ;;(p4::prodigy-object-p x) or (typep x 'operator)
    (member x list :test #'(lambda (a b)
			     (equal
			      (p4::prodigy-object-name a) b)))
    t)
   (t nil)))

(defun same-metapred (x y)
  (cond
    ((and (p4::strong-is-var-p x)
	  (p4::strong-is-var-p y))
     (error "one of ~A or ~A has to be bound.~%" x y))
    ((p4::strong-is-var-p x)
     (list (list (cons x y))))
    ((p4::strong-is-var-p y)
     (list (list (cons y x))))
    (t (equal x y))))

;;; ******************************************************************

(defun type-of-object-metapred (obj type)
  (cond
    ((or (symbolp type)(typep type 'type))
     (if (p4::strong-is-var-p obj)
	 (type-of-object-gen obj type)
	 (type-of-object obj type)))
    ((and (listp type)
	  (p4::strong-is-var-p obj))
     (mapcan #'(lambda (val)(list (list (cons obj val))))
	     (mapcan #'p4::type-instances 
		     (p4::make-type-list type))))
    ((listp type)
     (some #'(lambda (tp) (type-of-object obj tp))
	   (p4::make-type-list type)))
    (t (break "case not considered"))))

;;; ************************************************************
(load "/afs/cs/project/prodigy/version4.0/domains/machining/read-atoms")

(defun user-given-operator (op)
  (declare (special *candidate-operators* *current-node*))
  (let ((candidates (if (boundp '*candidate-operators*)
			*candidate-operators*
			(p4::goal-node-ops-left
			 (give-me-goal-node *current-node*))))
	user-ops (i 0))
    (if (eq candidates :not-computed)
	(break "Candidate operators not computed yet."))
    (format t "~%The candidates are:~%")
    (dolist (cand candidates (format t "Enter one or more: "))
      (format t "~A. ~A~%" (incf i) (p4::rule-name cand)))
    (setf user-ops   (mapcar #'(lambda (n) (nth (1- n) candidates))
			     (read-atoms)))
    (cond ((p4::strong-is-var-p op)
	   (mapcar #'(lambda (cand) (list (cons op cand))) user-ops))
	  (t (break t "Case not considered yet")))))

(defun user-given-bindings (bindings)
  (declare (special *candidate-operators* *current-node*))
  (let ((candidates (if (boundp '*candidate-bindings*)
			*candidate-bindings*
			(p4::operator-node-bindings-left
			 *current-node*)))
	user-instops (i 0))
    (if (eq candidates :not-computed)
	(break "Candidate bindings not computed yet."))
    (format t "~%The candidates are:~%")
    (dolist (cand candidates (format t "Enter one or more: "))
      (format t "~A. ~A~%~%~%" (incf i) cand))
    (setf user-instops   (mapcar #'(lambda (n) (nth (1- n) candidates))
			     (read-atoms)))
    (cond ((p4::strong-is-var-p bindings)
	   (mapcar #'(lambda (cand) (list (cons bindings cand)))
		   user-instops))
	  (t (break t "Case not considered yet")))))

#|
(defun at-node (n)
  (setf n (eval n))
  (if (numberp n) (eq n (p4::nexus-name *current-node*))
      (eq n  (p4::nexus-name *current-node*))))
|#

(defvar *ask-node* nil
  "node or list of (goal) nodes where to stop, possibly to ask for an
operator") 

(defun at-node (&optional n)
  (declare (special *current-node*))
  (let ((nodes
	 (cond
	   (n
	    (list 
	     (cond
	       ((numberp n) n)
	       ((p4::nexus-p n)
		(p4::nexus-name n))
	       ((eval n)))))
	   ((listp *ask-node*) *ask-node*)
	   ((list *ask-node*)))))
    (if (member (p4::nexus-name *current-node*) nodes)
	t)))

(defvar *called* nil)

(defun only-once ()
  "Call the rule only once per node"
  (if *called* (setf *called* nil)
      (setf *called* t)))



