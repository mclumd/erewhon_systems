;;; Code for adding protection to goals, needed for completeness with
;;; conditional effects (See Pednault 86).
(in-package "PRODIGY4")

;;; This determines if we can add a protection node at this point in
;;; the search tree. It is currently hard-wired to be one of the last
;;; things that can be done, since it checks that we already tried to
;;; apply the operator in question at this node.
;;; We check if any of the operators already applied here deleted a
;;; goal which was satisfied (perhaps in the initial state) through a
;;; conditional effect which was not necessary. If so, we can add
;;; protection to that goal at this point, by adding the preconditions
;;; to negate that conditional effect.
(defun generate-protection-nodes (node)
  (declare (type a-or-b-node node))
  (mapcan #'(lambda (child)
	      (let ((cands (if (applied-op-node-p child)
			       (goals-to-protect-from child))))
		(if cands (list (cons child cands)))))
	  (a-or-b-node-children node)))

;;; An application of an operator could use protection if it undid a
;;; goal by an unnecessary conditional effect.  In this version I
;;; ignore inference rules that are applied at this node. Note that
;;; this includes pending goals, goals with goal nodes whose operators
;;; haven't been applied and goals whose operators have been applied.

;;; Jim 5/94: The robot recharging problem of Feldman and Morris
;;; (shown me by Soutter) shows that an operator can also use
;;; "protection" if it introduces a goal and makes some subgoal of that
;;; goal unachievable. Anything in the subgoal tree might be
;;; protected, and it also doesn't have to be undone by the operator.
;;; This might be stretching the original notion of protection a bit,
;;; though.

(defun goals-to-protect-from (node)
  (declare (type applied-op-node node))
  ;; Find the application for this node
  (let ((appl (find (applied-op-node-instantiated-op node)
		    (applied-op-node-applied node)
		    :key #'op-application-instantiated-op)))
    (nconc
     (mapcan
      #'(lambda (lit)
	  (if (literal-goal-p lit)
	      (let* ((goal-node-sibling (goal-node-sibling lit node))
		     (subgoals (if goal-node-sibling
				   (descend-find-protectable
				    goal-node-sibling))))
		;; look for a sibling that already does this.
		(if (and (not (already-protected lit node))
			 (changed-by-unnecessary-conditional-effect
			  lit node nil))
		    (cons lit subgoals)
		  subgoals))))
      (op-application-delta-dels appl))
     (mapcan
      #'(lambda (lit)
	  (if (and (literal-neg-goal-p lit)
		   (not (already-protected lit node))
		   (changed-by-unnecessary-conditional-effect
		    lit node t))
	      (list lit)))
     (op-application-delta-adds appl)))))

(defun already-protected (lit node)
  (find lit (nexus-children (nexus-parent node))
	:test
	#'(lambda (literal child)
	    (and (protection-node-p child)
		 (eq (protection-node-goal child) literal)))))


;;; A literal is added by an unnecessary conditional effect at an
;;; applied-op-node if every effect that could have changed the
;;; literal is unnecessary. Since the literal is definitely changed by
;;; something, we only have to check that it isn't changed by the necessary
;;; conditional, or by the null conditional. This is slightly
;;; complicated by universal effects, however. For them we have to
;;; treat each instantiation of the quantified variables as a separate
;;; effect, and check the unwanted effect still lives in a different
;;; "conditional" from the goal. Pednault's briefcase domain is an
;;; example of this.

;;; Finally, as long as we don't miss chances when we could add
;;; completion, we won't destroy the correctness of the planner. If we
;;; protect when it's useless, we'll just add a lot of redundant
;;; searching, but the planner won't add an incorrect plan. So after
;;; some cursory checks, this algorithm errs on the side of caution by
;;; saying yes too often (it's hard to always get it right).

(defun changed-by-unnecessary-conditional-effect (lit node addedp)
  (let* ((instop (applied-op-node-instantiated-op node))
	 (needed-effect (instantiated-op-conditional instop))
	 ;; These effect signatures are created in process-list-for-one
	 (effect-map (getf (p4::nexus-plist node)
			   (if addedp :effect-adds :effect-dels))))
    (cond ((and (not (member lit (cdr (assoc nil effect-map))))
		(not (member lit (cdr (assoc needed-effect
					     effect-map)))))
	   ;; If the literals can be split ignoring universal effects,
	   ;; (living in different conditional parts) we're done.
	   t)
	  ;; Otherwise check if universals apply, and the literal and
	  ;; the required goal could come from different instantiations. If
	  ;; the shared effect branch is a forall, we may be able to
	  ;; split.
	  ;; It's inefficient to work out the preconds to protect the
	  ;; literal twice, but I need to check it here and will get
	  ;; to the efficiency part later.
	  ((eq (car needed-effect) 'user::forall)
	   (if (preconds-to-protect node instop lit)
	       t))
	  ;; Otherwise if there are universally quantified variables
	  ;; showing up in the conditional, go for it.
	  ((and (second (rule-effects (instantiated-op-op instop)))
		(find-var-conditional
		 needed-effect
		 (second (rule-effects (instantiated-op-op instop)))))
	   ;; as noted above, more checks here would be better.
	   t))))

;;; Checks if any of the variables in the var-map show up in the expression.
(defun find-var-conditional (expression var-map)
  (cond ((and (strong-is-var-p expression)
	      (assoc expression var-map))
	 t)
	((null expression) nil)
	((listp expression)
	 (or (find-var-conditional (car expression) var-map)
	     (find-var-conditional (cdr expression) var-map)))))
		

(defun goal-node-sibling (goal node))

;;; Find all children of this node which might be protectable. Need to
;;; clamber down the goal tree for this.
(defun descend-find-protectable (node))


;;; Create a protection node, protecting a goal from an application of the
;;; child applied-op-node.
;;; The protection node marks the change to the preconditions, and to
;;; the disjunction path of the binding node and instantiated op, and
;;; adds itself to the goal-p or neg-goal-p field of the literals which
;;; are used to protect the goal being protected.
;;; NOTE 1: Won't work with incremental pending goals right now.
;;; NOTE 2: We really want to add the disjunction of the negations,
;;; but then we already have a disjunction path for the binding node,
;;; so either (1) we only return one literal at a time here, and all
;;; the protection nodes together embody the disjunction or (2) we
;;; have a more complex arrangement where we have many disjunction
;;; paths for a protection node. I don't like (2), so (1) is what I'll
;;; do. This increases the inefficiency of this code since I'll
;;; calculate the same expression a number of times and choose one
;;; disjunctive path in general, but that's life. This is therefore a
;;; wonderful opportunity for *you* to write more efficient code!
(defun do-protect (node goals-to-protect
			&optional preconds-new
			(make-current t))
  (let* ((goal-and-application (choose-protection goals-to-protect))
	 (applied-op (first goal-and-application))
	 (goal (second goal-and-application))
	 (instop (applied-op-node-instantiated-op applied-op))
	 (op (instantiated-op-op instop))
	 (bin-node (instantiated-op-binding-node-back-pointer instop))
	 (old-preconds (or (instantiated-op-precond instop)
			   (binding-node-instantiated-preconds bin-node)))
	 (preconds-new
	  (or preconds-new
	      (preconds-to-protect applied-op instop goal)))
	 (new-delta-disjunction 
	  (next-protect-disjunct node goal instop (second preconds-new)))
	 (pr
	  (if new-delta-disjunction
	      (make-protection-node
	       :parent node
	       :goal goal
	       :instantiated-op instop
	       :old-preconds old-preconds
	       :old-disjunction-path
	       (binding-node-disjunction-path bin-node)
	       :new-preconds
	       (list 'user::and old-preconds (second preconds-new))
	       :new-delta-disjunction new-delta-disjunction))))
    (unless pr (return-from do-protect nil))
    ;; This works on the assumption that the new bit is at the end (as
    ;; done in create-precond-expr) and just glued together with "and".
    (setf (protection-node-new-disjunction-path pr)
	  (list (protection-node-old-disjunction-path pr)
		(protection-node-new-delta-disjunction pr)))
    (if (last-disjunct-p (protection-node-new-delta-disjunction pr)
			 (second preconds-new))
	(delete-protect-point node goal-and-application goals-to-protect))
    ;; Keeping the preconds of the instantiated-op current will be the
    ;; job of the backtracking stuff.
    (do-book-keeping pr node)
    ;; Extract the literals that become goals at this node from the
    ;; new-bit and the disjunction-path. CURRENTLY THIS IS A HACK THAT
    ;; WILL ONLY WORK WHEN JUST ONE GOAL IS ADDED.
    (setf (protection-node-new-goals pr)
	  (extract-goals (second preconds-new)
			 (protection-node-new-delta-disjunction pr)))
    ;; In keeping with the other functions, do-subgoal and
    ;; do-apply-op, we make the effects of this node take place here
    ;; and now. If it's not chosen, we'll have to "backtrack".  ;; I
    ;; only want goals added explicitly when this node is added in ;;
    ;; the planner itself, not when it's added from outside, for ;;
    ;; example by Weaver, because then maintain-state-and-goals is ;;
    ;; called to bring goals up to date. Hence the optional value
    (when make-current
      (setf (instantiated-op-precond instop)
	    (protection-node-new-preconds pr))
      (setf (binding-node-instantiated-preconds
	     (instantiated-op-binding-node-back-pointer instop))
	    (protection-node-new-preconds pr))
      (setf (binding-node-disjunction-path bin-node)
	    (protection-node-new-disjunction-path pr))
      ;; each element is either a literal or the list (~ lit)
      (dolist (new-goal (protection-node-new-goals pr))
	(if (literal-p new-goal)
	    (push instop (literal-goal-p new-goal))
	  (push instop (literal-neg-goal-p (second new-goal))))))
    pr))

;;; This is a point for potential search control, as yet there is
;;; none. goals-to-protect is produced by generate-protection-nodes,
;;; and consists of lists beginning with an applied-op-node and
;;; following with the goals that can be protected during that
;;; application. 

(defun choose-protection (goals-to-protect)
  (list (caar goals-to-protect) (second (car goals-to-protect))))

;;; Take the list gtp = (applied-op-node goal), find it in the list
;;; goals-to-protect and delete it.
(defun delete-protect-point (node gtp goals-to-protect)
  (let ((app-list (assoc (car gtp) goals-to-protect)))
    (setf (cdr app-list) (delete (second gtp) (cdr app-list)))
    (if (null (cdr app-list))
	(setf goals-to-protect (delete app-list goals-to-protect)))
    (setf (a-or-b-node-protections-left node)
	  goals-to-protect)))

;;; Calculate the new instantiated preconds for the instantiated op so that
;;; when it is applied it won't undo the protected goal.
;;; This function returns nil if there are no such preconds possible,
;;; and otherwise returns the list (preconds new-bit).
;;; Need to do something analogous to expand-operator, which
;;; sets the insntantiated-preconds to
;;;	(build-instantiated-precond chosen-binding *abslevel*))
;;; This function adds the conditional to the normal preconditions.
;;; Here we want to add, in addition, the negation of each of the
;;; conditional effects that would change the goal.

(defun preconds-to-protect (applied-op instop goal)
  (let* ((op (instantiated-op-op instop))
	 (precond (getf (rule-plist op) :annotated-preconds))
	 (annotated-effects
	  (getf (rule-plist op) :annotated-conditional-effects))
	 (intended-conditional
	  (cdr (assoc (instantiated-op-conditional instop)
		      annotated-effects)))
	 (conditionals-to-negate
	  (mapcan #'(lambda (cond)
		      (if (and (member goal (cdr cond))
			       (assoc (car cond) annotated-effects))
			  (list (all-instantiations-to-negate
				 (car cond) goal op nil
				 (second (rule-effects op))))))
		  (getf (nexus-plist applied-op)
			(if (literal-state-p goal)
			    :effect-dels
			  :effect-adds)))))
    ;; If in fact you can't protect the goal, conditionals-to-negate
    ;; will be nil.
    (if conditionals-to-negate
	(let ((new-and-whole
	       (create-precond-expr precond intended-conditional
				    conditionals-to-negate)))
	  (list
	   (build-instantiated-rec
	    (second new-and-whole)
	    (instantiated-op-values instop)
	    (rule-vars op)
	    (list (second (rule-precond-exp op))) t
	    (nexus-abs-level applied-op))
	   (build-instantiated-rec
	    (first new-and-whole)
	    (instantiated-op-values instop)
	    (rule-vars op)
	    (list (second (rule-precond-exp op))) t
	    (nexus-abs-level applied-op)))))))


;;; Finds all the instantiations of the conditional effect which will
;;; lead to the goal being disachieved. This is the equivalent of
;;; "peeling" in UCPOP. Walks through the expression building up
;;; conditional preconditions. When it meets one that unifies with the
;;; goal, it applies the substitution to the preconditions.
(defun all-instantiations-to-negate (effects goal op preconds vars)
  (cond ((eq (car effects) 'user::forall)
	 (all-instantiations-to-negate
	  (fourth effects) goal op
	  (cons (cdr (assoc effects
			    (getf (rule-plist op)
				  :annotated-conditional-effects)))
		preconds)
	  (append (second effects) vars)))
	((eq (car effects) 'user::if)
	 (all-instantiations-to-negate
	  (third effects) goal op
	  (cons (cdr (assoc effects
			    (getf (rule-plist op)
				  :annotated-conditional-effects)))
		preconds)
	  vars))
	((or (eq (car effects) 'user::del)
	     (eq (car effects) 'user::add))
	 ;; do this if the effect might reverse the goal
	 (if (eq (literal-state-p goal) (eq (car effects) 'user::del))
	     (let ((substitution
		    (effect-unify goal (second effects) vars)))
	       (if substitution
		   (if (> (length preconds) 1)
		       `(,(apply #'max (mapcar #'car preconds))
			 user::and
			 ,@(sublis substitution preconds))
		     (sublis substitution (car preconds)))))))
	;; default case is a list of effects
	(effects
	 (nconc (all-instantiations-to-negate
		 (car effects) goal op preconds vars)
		(all-instantiations-to-negate
		 (cdr effects) goal op preconds vars)))))


;;; If the effect matches the goal, return the substitution that makes
;;; it so.
(defun effect-unify (goal effect vars)
  (if (and (eq (literal-name goal) (car effect))
	   (= (length (literal-arguments goal)) (length (cdr effect))))
      (let ((bindings nil))
	(dotimes (i (length (literal-arguments goal)))
	  (let ((effect-arg (elt (cdr effect) i))
		(goal-arg (elt (literal-arguments goal) i)))
	    (cond ((not (strong-is-var-p effect-arg))
		   (unless (or (equal goal-arg effect-arg)
			       (equal (prodigy-object-name goal-arg)
				      effect-arg))
		     (return-from effect-unify nil)))
		  ((not (assoc effect-arg bindings))
		   (push (cons effect-arg goal-arg) bindings))
		  ((not (eq (cdr (assoc effect-arg bindings))
			    goal-arg))
		   (return-from effect-unify nil)))))
	(or bindings (list nil)))))
		
	
;;; Creates the precond expression with abstraction level annotations
;;; in the front, so that build-instantiated-rec will build the right
;;; instantiated precond expression for the current abstraction level.
;;; Retuns a list of the new bit and the whole bit.
(defun create-precond-expr (precond intended-conditional
				    conditionals-to-negate)
  (let ((new-bit (mapcar #'push-in-nots conditionals-to-negate)))
    (list
     (if (= (length new-bit) 1)
	 (car new-bit)
       `(,(apply #'max (mapcar #'car new-bit)) user::and
	 ,@new-bit))
     (if intended-conditional
	 `(,(max (car precond) (car intended-conditional)
		 (apply #'max (mapcar #'car conditionals-to-negate)))
	   user::and ,precond ,intended-conditional ,@new-bit)
       `(,(max (car precond)
	       (apply #'max (mapcar #'car conditionals-to-negate)))
	 user::and ,precond ,@new-bit)))))

;;; Takes an expression to be negated, and makes sure that only
;;; literals are negated, as the syntax of PDL requires. The
;;; expression is in annotated form, with the abstraction levels at
;;; the front.
(defun push-in-nots (expr)
  (cond ((eq (second expr) 'user::and)
	 `(,(car expr) user::or
	   ,@(mapcar #'push-in-nots (cddr expr))))
	((eq (second expr) 'user::or)
	 `(,(car expr) user::and
	   ,@(mapcar #'push-in-nots (cddr expr))))
	;; assumes nots already pushed in, so a negation will have a
	;; predicate as its argument.
	((eq (second expr) 'user::~)
	 `(,(car expr) ,@(cdr (third expr))))
	((eq (second expr) 'user::exists)
	 (list (first expr) 'user::forall (third expr)
	       (push-in-nots (fourth expr))))
	((eq (second expr) 'user::forall)
	 (list (first expr) 'user::exists (third expr)
	       (push-in-nots (fourth expr))))
	(t (list (car expr) 'user::~ expr))))



;;; This is modelled on next-disjunct in search.lisp, used by
;;; expand-operator. Note that we only want to cycle through the
;;; choices for the new part of the preconds.

;;; New bit: if the preconds implied by this disjunction-path include the
;;; negation of the goal we're trying to protect, reject the
;;; disjunction-path and go on to the next one. This is like burying a
;;; goal-loop test deep down..

(defun next-protect-disjunct (node goal instop new-preconds &optional last)
  (let* ((last-disjunct
	  (or last
	      (dolist (child (nexus-children node) nil)
		(if (and (protection-node-p child)
			 (eq (protection-node-goal child) goal)
			 (eq (protection-node-instantiated-op child) instop))
		    (return (protection-node-new-delta-disjunction child))))))
	 (next-disjunct
	  (if last-disjunct
	      (next-disjunct-r new-preconds last-disjunct t)
	    (or (first-path new-preconds t) (list nil))))
	 (disjunct-goals
	  (if next-disjunct (extract-goals new-preconds next-disjunct))))
    (if (and next-disjunct
	     (find-if #'(lambda (x)
			  (and (listp x) (eq 'user::~ (car x))
			       (eq (second x) goal)))
		      disjunct-goals))
	(next-protect-disjunct node goal instop new-preconds next-disjunct)
      next-disjunct)))


(defun extract-goals (expr disjunction-path)
  (cond ((or (literal-p expr) (eq (car expr) 'user::~))
	 (list expr))
	((eq (car expr) 'user::and)
	 (mapcan #'(lambda (sub disj) (extract-goals sub disj))
		 expr disjunction-path))
	((eq (car expr) 'user::or)
	 (extract-goals (elt expr (car disjunction-path))
			(cdr disjunction-path)))))

