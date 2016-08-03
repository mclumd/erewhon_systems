(in-package "USER")

(defun diff (x y) (not (eq x y)))

(defun break-p ()
  (break)
  t)


;;; If the Prodigy front end to the JADE TIE was not loaded, load it. Some of
;;; the functions here will use this code.  E.g., the fe::isa-p function. [cox
;;; 21jul98]
;;;
(when (or (not (boundp '*load-prodigy-front-end*))
	  (null *load-prodigy-front-end*))
      (load (concatenate 
	     'string 
	     *system-directory* 
	     "jade/loader.lisp")))
(if (not FE::*load-format-immediately*)
    (load-jade-source))

;;;
;;; Mike Cox's Meta-Predicates and support.

;;;
;;; Predicate goal-match-p returns true iff 
;;;  1. both superordinate and subordinate share the same predicate and 
;;;  2. all arguments of superordinate is equal to or more abstract than the 
;;;     corresponding arguments of subordinate.
;;;
;;; Modified to check matches of negative goals. [cox 5mar98]
;;;
(defun goal-match-p (subordinate superordinate)
  (cond  ((and (eq (first subordinate)
		   '~)
	       (eq (first superordinate)
		   '~))
	  ;; If both are negative goals, then match on the goal forms.
	  (goal-match-p (rest subordinate)
			(rest superordinate)))
	 ((or (and (eq (first subordinate)
		       '~)
		   (not (eq (first superordinate)
			    '~)))
	      (and (eq (first superordinate)
		       '~)
		   (not (eq (first subordinate)
			    '~))))
	  ;; If one is a negative goal and the other is a positive goal, then
	  ;; they do not match.
	  nil)
	 (t
	  (and
	   (eq (first superordinate)
	       (first subordinate))
	   ;;Probably shound use equal rather than not-mismatch
	   (not 
	    (mismatch (rest superordinate)
		      (rest subordinate)
		      :test #'fe::isa-p)))))
  )



;;;
;;; Predicate is-ancestor-op-of-p returns t if op2 is an ancestor of op1. This 
;;; condition occurs when the primary effect of op2 is a more general goal than
;;; that of op1.
;;;
(defun is-ancestor-op-of-p (op1
			    op2 
			    &aux
			    (goal1 (fe::return-goal op1))
			    (goal2 (fe::return-goal op2)))
  (is-ancestor-of-p goal1 goal2)
  )



;;;
;;; In function match-constraining-goals the matching-goal is a variable
;;; identifier (e.g., the symbol '<G>) as passed to the functionm in the
;;; control rule Prefer-Bindings-Opportunistically. For each precondition of
;;; the current-operator, the function makes a binding list for the
;;; goal-variable that matches any candidate goal unifying with the
;;; precondition. The function then returns a list of these lists.
;;;
(defun match-constraining-goals (matching-goal 
				 current-operator)
  (let* ((possible-goals (candidate-goals))
	 (results
	  (and possible-goals ;results are nil if no candidate goals exist.
	       (mapcan
		#'(lambda (each-precondition)
		    (find-constraining-goal 
		     each-precondition
		     (mapcar #'(lambda (each-prodigy-goal)
				 (cons (translate-to-list-form 
					each-prodigy-goal)
				       each-prodigy-goal))
			     possible-goals)
		     matching-goal))
		(rest (fe::get-preconditions current-operator))))))
    (if results (list results)))
  )



;;;
;;; Function find-constraining-goal takes three parameters. The precondition
;;; argument is a form such as (IS-DEPLOYED POLICE-FORCE-MODULE LOCATION). 
;;; Parameter goal-tuples is a list of pairs 
;;; (<list-form-of-goal>.<prodigy-goal-form>) such as 
;;; ((IS-DEPLOYED SECURITY-POLICE-A BOSNIA-AND-HERZEGOVINA)
;;; . #<IS-DEPLOYED SECURITY-POLICE-A BOSNIA-AND-HERZEGOVINA>)). 
;;; The goal-variable parameter is a symbol such as '<G>. 
;;;
;;; For each tuple in the input list whose first form matches the precondition 
;;; using predicate is-ancestor-of-p, a tuple is returned with the goal variable
;;; and the prodigy-goal that corresponds to the match. If the function was 
;;; passed the example parameters above, then it would return the singleton 
;;; list 
;;; ((<G> . #<IS-DEPLOYED SECURITY-POLICE-A BOSNIA-AND-HERZEGOVINA>))
;;;
(defun find-constraining-goal (precondition goal-tuples goal-variable)
  (mapcan
   #'(lambda (each-tuple)
       (if (is-ancestor-of-p
	    (first each-tuple)
	    precondition)
	   (list 
	    (cons goal-variable (rest each-tuple)))))
   goal-tuples)
  )



;;;
;;; Function build-list takes as input prodigy-bindings, an ordered list of
;;; prodigy-objects that represent the values prodigy wants to assign as the 
;;; value of each operator variable, and op the operator. The function outputs
;;; a binding list of tuples, (op-variable-name . value). The first parameter 
;;; may look like this (#<P-O: KOREA-SOUTH country> #<P-O: AIRPORT4 airport>
;;; #<P-O: POLICE-A police-force-module> #<P-O: HAWKA hawk-battalion>
;;; #<P-O: INFANTRY-BATTALION-A infantry-battalion>) for op #<OP: SECURE>. The
;;; output would then look like this: 
;;; ((<LOC> . KOREA-SOUTH) (<AIRPORT> . AIRPORT4) 
;;; (<INTERNAL-SECURITY-FORCE> . POLICE-A) (<EXTERNAL-SECURITY-FORCE1> . HAWKA)
;;; (<EXTERNAL-SECURITY-FORCE2> . INFANTRY-BATTALION-A))
;;;
(defun build-list (prodigy-bindings op)
  (mapcar 
   #'cons 
   (p4::operator-precond-vars op) ;extracts ordered list of variable names in op
   (mapcar 
    #'p4::prodigy-object-name     ;extracts like ordered list of value names
    prodigy-bindings))
  )



;;;
;;; The function identify-worse-bindings looks at the candidate bindings that
;;; prodigy has proposed (the candidate-bindings argument) and the bindings 
;;; that the control rule Prefer-Bindings-Opportunistically has proposed (the 
;;; my-bindings argument), and returns a list of prodigy candidates to be 
;;; rejected as opposed to the corresponding ones that will be identified by 
;;; the sister function identify-better-bindings below.
;;;
(defun identify-worse-bindings (candidate-bindings 
				my-bindings 
				worse-bindings 
				current-op
				&aux
				(candidate-b-list 
				 (build-list candidate-bindings current-op)))
;  (break "identify-worse-bindings")
  (let (;match-list will be a list of pairs of bindings like
	;((<X> . prodigy-val)(<X> . my-val))
	(match-list
	 (mapcar
	  #'(lambda (each-binding)
	      ;; Probably could use assoc below
	      (list (find (first each-binding)
			  candidate-b-list
			  :key #'first)
		    each-binding))
	  my-bindings))
	(rejected-list))
;    (break "match-list: ~s" match-list)
    (dolist (each-match match-list)
	    (when (and
		   ;;the bindings differ
		   (not
		    (or (null (first each-match))
			(equal (first each-match)
			       (second each-match))))
		   ;;and either 
		   (or 
		    ;;the values are siblings
		    (fe::siblings-p
		     (rest (first each-match))
		     (rest (second  each-match)))
		    ;;or prodigy's value is an ancestor of my value
		    (fe::isa-p (rest (first each-match))
			   (rest (second each-match)))
		    (not (equal (rest (first each-match))
			   (rest (second each-match))))))
		  ;;then add the candidate binding to the reject list
		  (setf rejected-list
			(cons (first each-match)
			      rejected-list))))
    (if (not (null rejected-list))
	(list 
	 (list 
	  (cons worse-bindings rejected-list)))))
  )



;;;
;;; Note that functions identify-better-bindings and identify-worse-bindings 
;;; used to be the same. It was easier to separate them for the time being.
;;; See above function for comments.
;;;
(defun identify-better-bindings (candidate-bindings 
				my-bindings 
				better-bindings 
				current-op
				&aux
				(candidate-b-list 
				 (build-list candidate-bindings current-op)))
  (let ((match-list
	 (mapcar
	  #'(lambda (each-binding)
	      (list (find (first each-binding)
			  candidate-b-list
			  :key #'first)
		    each-binding))
	  my-bindings))
	(preferred-list)
	)
    (dolist (each-match match-list)
	    (when (and
		   (not
		    (or (null (first each-match))
			(equal (first each-match)
			       (second each-match))))
		   (or 
		    (fe::siblings-p
		     (rest (first each-match))
		     (rest (second  each-match)))
		    (fe::isa-p (rest (first each-match))
			   (rest (second each-match)))
		    (not (equal (rest (first each-match))
			   (rest (second each-match))))))
		  (setf preferred-list
			(cons (second each-match)
			      preferred-list))
))
    (if (not (null preferred-list))
	(list 
	 (list 
	  (cons better-bindings preferred-list))
	 )))
  )




;;;
;;; Function return-order returns the number corresponding to the position of
;;; the precondition that matches goal using the predicate is-ancestor-of-p.
;;; Probably should have used the call 
;;; (position goal preconditions :test #'is-ancestor-of-p)
;;;
(defun return-order (preconditions goal &optional (order-num 0))
  (cond ((null preconditions)
	 (break "No match in return-order function"))
	((is-ancestor-of-p 
	  goal 
	  (first preconditions))
	 order-num)
	(t
	 (return-order
	  (rest preconditions)
	  goal 
	  (+ 1 order-num))))
  )



;;;
;;; p4::operator-precond-exp returns a form as (PRECONDS <B-LIST> <EXPR>)
;;; where <EXPR> is the variablized form of the preconditions. The function 
;;; get-preconditions returns the same object, but in abstract form where the 
;;; variable have the type substituted in their place. For example, the 
;;; correspondence would be as between (PRECONDS ((<X> BOY)(<Y> PERSON)) 
;;;                                               (AND (ISA <X> <Y>))) and 
;;; (ISA BOY PERSON). The call of nth finds the corresponding variablized form.
;;; Therefore the results local variable will be a list of tuples representing 
;;; the successive arguments of the constraining goal in the form of 
;;; (<var> . <type>). Finally, the result of the function will be of the form
;;; '(((<B> (<X> BOY)(<Y> PERSON)))) corresponding to the correct precondition
;;; that matches constraining-goal.
;;;
(defun generate-new-bindings (binding-variable
			      constraining-goal
			      current-op
			      &aux
			      (c-goal
			       (translate-to-list-form 
				constraining-goal)))
  (let ((results
	 (mapcar
	  #'cons
	  (rest (nth 
		 (return-order
		  (rest                              ;strip 'and
		   (fe::get-preconditions current-op))
		  c-goal)
		 (rest                               ;strip 'and
		  (third 
		   (p4::operator-precond-exp 
		    current-op)))))
	  (rest c-goal))))
    (if results (list (list (cons binding-variable results)))))
  )


;;;
;;; Note that the function returns nil if given goals that are not strictly 
;;; related in one direction in the abstraction hierarchy. E.g., 
;;; (is-deployed troops saudi-arabia)  and
;;; (is-deployed division-ready-brigade location)
;;;
(defun is-ancestor-of-p (descendant-goal 
			 ancestor-goal 
			 &aux
			 (d-goal (if (p4::literal-p descendant-goal)
				     (tranlate-to-list-form descendant-goal)
				   descendant-goal))
			 (a-goal (if (p4::literal-p ancestor-goal)
				     (tranlate-to-list-form ancestor-goal)
				   ancestor-goal)))
  (and (not (equal d-goal a-goal))
       (goal-match-p d-goal a-goal))
  )


;;;
;;; Would like to use the filter function here but imbedding the goal argument 
;;; in the lambda function is still problematic.
;;;
(defun get-ops-achieving (goal)
  (mapcan
   #'(lambda (each-op)
       (if (goal-match-p 
	    goal
	    (fe::return-goal each-op (eq (first goal) 'USER::~)))
	   (list each-op)
	 nil))
   (fe::get-prodigy-ops))
  )


;;;
;;; Function is-precondition-of returns non-nil is there exists some 
;;; precondition of the operator parameter that unifies with the given state.
;;; They unify if the state is equal to or a descendent of the precondition in
;;; the abstraction hierarchy. 
;;;
(defun is-precondition-of (operator state)
  (member state 
	  (rest                           ;Skip the 'and
	   (fe::get-preconditions operator))
	  :test #'goal-match-p)
  )


;;;
;;; Function solves-precondition-of returns non-nil if some operator exists
;;; whose primary effect matches the supergoal and has as one of its 
;;; preconditions the subgoal argument, or if recursively, one of the 
;;; preconditions of the operator is a supergoal of the subgoal in like 
;;; fashion.
;;;
(defun solves-precondition-of (supergoal 
			       subgoal 
			       &optional 
			       provide-feedback)
  (let* ((G2 (fe::get-preconditions nil subgoal))
	 (some-results
	  (some #'(lambda (op)
		    (or (is-precondition-of op G2)
			(some #'(lambda (each-precond)
				  (solves-precondition-of
				   each-precond
				   subgoal
				   provide-feedback))
			      (let ((preconds (fe::get-preconditions op)))
				(if (eq 'and (first preconds))
				    (rest preconds)
				  preconds)))))
		(get-ops-achieving 
		 (fe::get-preconditions nil 
				    supergoal)))))
    (when some-results
	  (if provide-feedback
	      (format 
	       t 
	       "~%~s is a subgoal for ~s." 
	       subgoal 
	       supergoal))
	  (list subgoal supergoal))
    )
  )


;;;
;;; Take a prodigy-goal such as #<IS-DEPLOYED HAWKA SAUDI-ARABIA> and translate
;;; it to list form such as (IS-DEPLOYED HAWKA SAUDI-ARABIA).
;;;
(defun translate-to-list-form (prodigy-goal)
;  (break "translate-to-list-form: prodigy-goal -- ~s" prodigy-goal)
  (cons (P4::literal-name prodigy-goal)
	(mapcar
	 #'P4::prodigy-object-name
	 (coerce (P4::literal-arguments prodigy-goal)
		 'list)))
  )


;;;
;;; This is the actual meta-predicate used by control rule Select-Top-Most-Goal
;;;
(defun solves-precondition-of-p (supergoal subgoal)
  (if (solves-precondition-of 
       (translate-to-list-form supergoal)
       (translate-to-list-form subgoal)
;       t
       )
      t
    nil)
  )



;;;----------------------------------------------------------------------------

;;; Support for binding control rule. I am not sure that this is actually used.
;;;
(defun get-matching-pending-goal (precond 
				  &optional 
				  (pending-goals 
				   (p4::give-me-all-pending-goals 
				    *current-node*)))
  (cond ((null pending-goals) 
	 nil)
	(t
	 (or (if (goal-match-p 
		  precond 
		  (first pending-goals))
		 (list (precond (first pending-goals))))
	     (get-matching-pending-goal 
	      precond 
	      (rest pending-goals)))))
  )


;;; The following will return either nil or the first precondition/pending-goal
;;; pair that matches.
;(some #'get-matching-pending-goal
;      (rest (fe::get-preconditions current-op)))


;;; For use with deploy-one
;;;
(defun less-by (n num)
  (list (- num n)))

(defun gen-2 () (list 2))
(defun gen-3 () (list 3))

;;;Comment out when compiling this file. Uncomment when done compiling.
(load
 (concatenate
  'string
  *world-path*
  "/jade/functions.fasl"))
