;;; This is mostly a copy of the logistics functions, with some local
;;; modifications. Stuff that is purely for events is in events.lisp
;;; in this directory

(in-package "USER")

;;; If the Prodigy front end to the JADE TIE was not loaded, load it. Some of
;;; the functions here will use this code.  E.g., get-preconditions
;;; function. [cox 16feb97]
;;;
(when (or (not (boundp '*load-prodigy-front-end*))
	  (null *load-prodigy-front-end*))
      (load (concatenate 
	     'string 
	     *system-directory* 
	     "jade/loader.lisp")))
(if (not FE::*load-format-immediately*)
    (load-jade-source))


(setf *generator-functions*
      '((in-truck-city-p 2)))

(defun diff (x y) (not (eq x y)))
(defun varp (x) (p4::strong-is-var-p x))

;;; returns true if the truck is in the same city as the loc.
(defun in-truck-city-p (truck loc)
  (cond ((varp loc)
	 (if (varp truck)
	     (error "Can't have both truck and location variable in in-truck-city-p"))
	 ;; inefficient, but still a win to generate rather than test.
	 (let* ((city (get-city-of-truck truck))
		(ht  (gethash 'loc-at
			      (p4::problem-space-assertion-hash
			       *current-problem-space*)))
		(lits (get-relevant-lits-in-hash-table city ht 1)))
	   (mapcar #'(lambda (lit) (elt (p4::literal-arguments lit) 0))
		   lits)))
	(t
	 (eq (get-city-of-truck truck)
	     (get-city-of-loc loc)))))


;;; returns the name of the city where the truck is at.
(defun get-city-of-truck (truck)
  (declare (special *current-problem-space*))
  (let ((part-hash (gethash 'part-of
			    (p4::problem-space-assertion-hash
			     *current-problem-space*)))
	(result nil))
    (if part-hash
     ;;; I should really be testing if (hash-table-p ..)
     ;;; but because of the implementation, I know this always hold
     ;;; provided that part-hash is not empty.
	(maphash #'(lambda (key val)
		     (if (and (p4::literal-state-p val)
			      (eq (elt key 0) truck))
			 (setf result val)))
		 part-hash))
    (if result
	(elt (p4::literal-arguments result) 1)
	(error "~% CITY-OF-TRUCK: no entry for part-of ~A in the state."
	       truck))))


;;; get the name of the airport where the plane is.
(defun get-city-of-airplane (airplane)
  (declare (special *current-problem-space*))
  (let ((at-airplane-hash (gethash 'at-airplane
			    (p4::problem-space-assertion-hash
			     *current-problem-space*)))
	(result nil))
    (if at-airplane-hash
	(maphash #'(lambda (key val)
		     (if (and (p4::literal-state-p val)
			      (eq (elt key 0) airplane))
			 (setf result val)))
		 at-airplane-hash))
    (elt (p4::literal-arguments result) 1)))

;;; get the name of the city where loc (airport/post-office) is.
(defun get-city-of-loc (loc)
  (declare (special *current-problem-space*))
  (let ((loc-hash (gethash 'loc-at
			    (p4::problem-space-assertion-hash
			     *current-problem-space*)))
	(result nil))
    (if loc-hash
	(maphash #'(lambda (key val)
		     (if (and (p4::literal-state-p val)
			      (eq (elt key 0) loc))
			 (setf result val)))
		 loc-hash))
    (if result
	(elt (p4::literal-arguments result) 1)
	(error "~% CITY-OF-LOC: no entry for loc-at ~A in the state." loc))))


;;; returns T is obj is in the same city where the loc is.
(defun in-obj-city-p (obj loc)
  (let ((obj-city (get-city-of-obj obj))
	(airport-city (get-city-of-loc loc)))
    (eq airport-city obj-city)))


;;; returns the name of the city where obj is.  Since the object
;;; can be in-truck, in-airplane, or at-obj, I need the "or".
(defun get-city-of-obj (obj)
  (or (at-po-or-airport obj)
      (in-truck obj)
      (in-airplane obj)))

;;; if the obj is at post-office or at an airport, returns the name of
;;; the city where the obj is.
(defun at-po-or-airport (obj)
  (declare (special *current-problem-space*))
  (let* ((at-obj-hash (gethash 'at-obj
			       (p4::problem-space-assertion-hash
				*current-problem-space*)))
	 (result (get-relevant-literal-in-hash-table obj at-obj-hash)))
    (if result
	(get-city-of-loc (elt (p4::literal-arguments result) 1)))))


;;; if the obj is inside-truck, find the truck, and returns the city where
;;; the truck is part-of.
(defun in-truck (obj)
  (declare (special *current-problem-space*))
  (let* ((inside-truck-hash (gethash 'inside-truck
				     (p4::problem-space-assertion-hash
				      *current-problem-space*)))
	 (result (get-relevant-literal-in-hash-table obj inside-truck-hash)))
    (if result
	(get-city-of-truck (elt (p4::literal-arguments result) 1)))))


;;; if the obj is inside-airplane, returns the city where the
;;; airplane is at now.
(defun in-airplane (obj)
  (declare (special *current-problem-space*))
  (let* ((inside-airplane-hash
	  (gethash 'inside-airplane
		   (p4::problem-space-assertion-hash *current-problem-space*)))
	 (result (get-relevant-literal-in-hash-table obj inside-airplane-hash)))
    (get-city-of-airplane (elt (p4::literal-arguments result) 1))))

(defun get-relevant-literal-in-hash-table (obj hash-table)
  (maphash #'(lambda (key val)
	       (if (and (p4::literal-state-p val)
			(eq (elt key 0) obj))
		   (return-from get-relevant-literal-in-hash-table val)))
	   hash-table)
  nil)

;;; Allows the position to vary and more than one hit
(defun get-relevant-lits-in-hash-table (obj hash-table &optional (pos 0))
  (let ((res nil))
    (maphash #'(lambda (key val)
		 (if (and (p4::literal-state-p val)
			  (eq (elt key pos) obj))
		     (push val res)))
	     hash-table)
    res))





;;;
;;; Mike Cox's Meta-Predicates and support.

;;; Next 2 fns for control-rule SUBGOAL-IF-ALL-APPLICABLE-OPS-NOT-EXECUTABLE
;;;
(defun all-applicable-ops-not-executable (&optional 
					  (current-node
					   *current-node*)
					  (candidate-list 
					   (p4::cache p4::a-or-b-node-applicable-ops-left 
						      current-node
						      (p4::abs-generate-applicable-ops 
						       current-node 
						       (p4::compute-next-thing current-node)))))
  (format t "~%CANDIDATE LIST: ~s~%" candidate-list)
  (cond ((null candidate-list)
	 t)
	((p4::deployment-op-p (first candidate-list))
	 nil)
	(t
	 (all-applicable-ops-not-executable current-node
	  (rest candidate-list ))))
  )

(defun exists-pending-goals-p ()
  (if (candidate-goals)
      t)
  )



;;; For control-rule SELECT-EXECUTABLE-OP-TO-APPLY
;;;
(defun is-not-executable-p (applied-op-node)
  (not (p4::deployment-op-p applied-op-node))
  )


;;;
;;; Predicate goal-match-p returns true iff 
;;;  1. both superordinate and subordinate share the same predicate and 
;;;  2. all arguments of superordinate is equal to or more abstract than the 
;;;     corresponding arguments of subordinate.
;;;
(defun goal-match-p (subordinate superordinate)
  (and
   (eq (first superordinate)
       (first subordinate))
   ;Probably shound use equal rather than not-mismatch
   (not 
    (mismatch (rest superordinate)
	      (rest subordinate)
	      :test #'isa-p)))
  )



;;;
;;; Predicate is-ancestor-op-of-p returns t if op2 is an ancestor of op1. This 
;;; condition occurs when the primary effect of op2 is a more general goal than
;;; that of op1.
;;;
(defun is-ancestor-op-of-p (op1
			    op2 
			    &aux
			    (goal1 (return-goal op1))
			    (goal2 (return-goal op2)))
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
		(rest (get-preconditions current-operator))))))
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
		    (siblings-p
		     (rest (first each-match))
		     (rest (second  each-match)))
		    ;;or prodigy's value is an ancestor of my value
		    (isa-p (rest (first each-match))
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
		    (siblings-p
		     (rest (first each-match))
		     (rest (second  each-match)))
		    (isa-p (rest (first each-match))
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
		   (get-preconditions current-op))
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
	    (return-goal each-op))
	   (list each-op)
	 nil))
   (get-prodigy-ops))
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
	   (get-preconditions operator))
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
  (let* ((G2 (get-preconditions nil subgoal))
	 (some-results
	  (some #'(lambda (op)
		    (or (is-precondition-of op G2)
			(some #'(lambda (each-precond)
				  (solves-precondition-of
				   each-precond
				   subgoal
				   provide-feedback))
			      (let ((preconds (get-preconditions op)))
				(if (eq 'and (first preconds))
				    (rest preconds)
				  preconds)))))
		(get-ops-achieving 
		 (get-preconditions nil 
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
;      (rest (get-preconditions current-op)))


;;; For use with deploy-one
;;;
(defun less-by (n num)
  (list (- num n)))

(defun gen-2 () (list 2))
(defun gen-3 () (list 3))
