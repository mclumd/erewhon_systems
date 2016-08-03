;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;			    X-ANALOGY-SUPPORT.LISP
;;;
;;; The main two functions are auto-use-case and use-cases.
;;;
;;; 
;;; History:
;;;
;;; 29dec96 Michael Cox. File has functions that replace and augment code in
;;; Anthony Francis' x-analogy extension. E.g., functions simple-retrieval and
;;; simple-select-replay-cases. Function assemble-replay-cases has been
;;; replaced by function find-replay-cases.
;;;
;;; 4sep97 Changed default of goal-num in auto-use-cases to number of goals in
;;; the current problem instead of 2. Also added predicate
;;; higher-match-number-p to make sure that if there exists two ties in the
;;; largest cover-set, we take the one with the larger match percentage. Also
;;; modified function adjust-bind-list so that it removed entries that
;;; duplicated solving the goals of the current largest cover set. Among other
;;; modifications to do this, I created function collect-goal-ptrs. [cox]
;;;
;;; 3jun98 Fixed some bugs in case replay. [cox]
;;;

(in-package "USER")

;;;
;;; This is a copy of a function from ~mcox/prodigy/Interleave/sensing.lisp. Is
;;; called in function replay-body of x-replay.lisp.
;;;
;;; Generic function for installing interrupt handlers. Checks to make sure the
;;; handler is not already installed before adding it.
;;;
(defun add-handler (&optional
		    (handler 'sense-world)
		    (signal :always)
		    &aux
		    (handler-function (symbol-function handler)))
  (unless (member handler-function
		  (cdr (assoc signal p4::*prodigy-handlers*)))
    (define-prod-handler signal handler-function)))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; AUTO-USE-CASES
;;;
;;;
;;; The difference between automatic and manual use of cases is that under
;;; automatic mode the algorithm will search through all cases in the default
;;; directory, whereas under manual mode, the user can restrict search to a
;;; subset of the cases in the default directory.
;;;
(defun auto-use-cases (&optional 
		       (goal-num 
			(length (get-lits-no-and 
				 (p4::problem-goal (current-problem)))))
		       (threshold 0.6))
  (simple-retrieval :max-goals 
		    goal-num
		    :match-threshold
		    threshold
		    :case-list
		    (return-file-strings
		     (concatenate 'string 
				  *problem-path* 
				  "probs/cases/headers/")))
  (load-cases)
  )


;;;
;;; An overwrite of Anthony's code in x-retrieval.lisp. The difference here is
;;; that we add the parameter append2replay-cases and pass it to
;;; simple-select-replay-cases without the verbose parameter being passed.
;;;
(defun simple-retrieval (&key (prob            (current-problem))
			      (case-list       *case-retrieval-list*)
			      (match-threshold 0.6)
			      (max-goals       2)
			      (current-match   0)
			      (verbose *verbose*)
			      append2replay-cases)

  (when case-list
	(apply #'load-case-headers case-list)
	(p4::load-problem  prob nil)
	(evaluate-similarities :prob            prob
			       :match-threshold match-threshold
			       :max-goals       max-goals
			       :current-match   current-match)
	(simple-select-replay-cases append2replay-cases)
	)
  )



;;;
;;; Overwritten code from Anthony's function in x-retrieval.lisp. It no longer
;;; calls function assemble-replay-cases; rather, it uses function
;;; find-replay-cases. If flag append2replay-cases non-nil, append newly found
;;; cases to current *replay-cases*, otherwise replace with new cases. Return
;;; set of cases to be replayed (side-effect is to assign this value to
;;; *replay-cases*.
;;;
(defun simple-select-replay-cases (&optional append2replay-cases)
  ;; Establishes *x-goal-list*, *x-case-list*, and *x-bind-list* from
  ;; *cover-matches*.
  (analyze-matches :verbose *verbose*)
  (setf *x-case-table* nil)
  (setf *x-goal-table* nil)
  ;; Put newly found cases on *x-goal-table*.
;  (break)
  (find-replay-cases 
   (setf *x-current-goals* 
	 (get-lits-no-and 
	  (p4::problem-goal 
	   (current-problem))))
    *verbose*)
  (setf *replay-cases* 
	(if append2replay-cases
	    (append *replay-cases* 
		    *x-goal-table*)
	  *x-goal-table*))
  ;; Added [cox 19may98]
  (make-open-var-substitutions)
  *replay-cases*
  )

;;; Not really predicate. Returns a list of open variable arguments (instances)
;;; and associated types.
;;;
(defun has-open-vars-p (case
			case-header
			&aux 
			(case-name
			 (case-header-name
			  case-header))
			(subst-map 
			 (fourth 
			  case))
			(inst-map 
			 (case-header-insts-to-vars
			  case-header))
			(objects
			 (case-header-objects
			  case-header))
			open-vars)
  (declare (type CONS case)
	   (type CASE-HEADER case-header)
	   (inline get-object-type-from-header)
	   (optimize speed (safety 0)))
;;;  (print case-name)
;;;  (terpri)
;;;  (print subst-map)
;;;  (terpri)
;;;  (print inst-map)
;;;  (terpri)
;;;  (break)
  (dolist (each-goal (case-header-goal case-header))
	  (dolist (each-arg (rest each-goal))
		  (if (not
		       (assoc
			(rest
			 (assoc 
			  each-arg
			  inst-map))
			subst-map))
		      (setf open-vars
			    (cons
			     (list (rest
				    (assoc 
				     each-arg
				     inst-map))
				   (get-object-type-from-header
				    objects
				    each-arg))
			     open-vars))
		    )))
  (remove-duplicates open-vars
		     :test #'equal)
  )


(defun get-object-type-from-header (objects 
				    instance
				    &aux
				    (object-id
				     (first 
				      (member instance 
					      objects
					      :test
					      #'member))))
  (first (last object-id))
  )


(defun make-open-var-substitutions (&aux
				    open-vars)
  (declare 
   (inline has-open-vars-p get-instance-from-current-context)
   (optimize speed (safety 0)))
    (dolist (each-case *replay-cases*)
	  (when (setf
		 open-vars
		 (has-open-vars-p 
		  each-case
		  (first
		   (member (first each-case)
			   *case-headers*
			   :test
			   #'(lambda (x y)
			       (equal x 
				      (case-header-name 
				       y)))))))
		(format t 
			"~%Case ~s has open variables ~s.~%"
			(first each-case)
			open-vars)
		(dolist (each-open-var open-vars)
			(setf (fourth each-case)
			      (cons 
			       (cons (first each-open-var)
				     (get-instance-from-current-context
				      (first (rest each-open-var))))
			       (fourth each-case)))
			)
		))
  )



(defun get-instance-from-current-context (type-id
					  &aux
					  (prodigy-type
					   (is-type-p 
					    type-id
					    *current-problem-space*)))
  (p4::prodigy-object-name
   (first 
    (p4::type-instances 
     prodigy-type)))
  )





;;;
;;; Function find-replay-cases is a recursive function to find the best cases 
;;; to replay. Is the heir to Anthony Francis' assemble-replay-cases function. 
;;; The procedure is to find the past case that covers the largest number of 
;;; current goals by calling find-largest-cover-set. Remove the goals just
;;; covered from current-goals and the case from the previously analyzed 
;;; bindings list, and push the case onto the global *x-goal-table* variable 
;;; (this will be transferred to *replay-cases* after finished). Then 
;;; recursively look for another case to cover the next largest number of 
;;; current goals. 
;;;
(defun find-replay-cases (current-goals 
			  &optional 
			  (verbose *verbose*)
			  recursive-call ;Added [cox 20may98]
			  )
  (when (eq *x-bind-list* nil)
;	(format t "~%ERROR: *x-bind-list* is nil~%")
	(return-from find-replay-cases))
  (if *UI* 
      (ping))
  (cond ((null current-goals)
	 nil)
	(t
	 (let* ((largest (find-largest-cover-set))
		(bindings (first largest))
		(index-list (rest largest))
		(goal-covered-list 
		 (remove-duplicates ;;[cox 2jun98]
		  (mapcar #'(lambda (index)
			     (get-goal-name index))
			 index-list)
		  :test #'equal))
		;;Case is case name returned by the predicate.
		(case (same-case-matches-p index-list)))
	   (when verbose
		 (format t (if recursive-call
			       "~%Next largest cover set: ~S~%"
			     "~%Largest cover set: ~S~%")
			 largest)
		 (format t "~%Goal-covered-list: ~S~%"
			 goal-covered-list)
		 (format t "~%Case: ~S~%"
			 case)
		 (format t "~%Current Goals: ~S~%"
			 current-goals))
	   (cond (case
		  (adjust-bind-list largest case goal-covered-list) 
		  ;; The commented out push call below creates a list for
		  ;; *replay-cases* that is in reverse order of goal
		  ;; coverage. [cox 1jun98]
		  (setf *x-goal-table*
			(cons (list case 
				    (rename-case case)
				    goal-covered-list
				    bindings)
			      *x-goal-table*))
;		  (push (list case 
;			      (rename-case case)
;			      goal-covered-list
;			      bindings) 
;			*x-goal-table*) 
		  (find-replay-cases
		   (set-difference 
		    current-goals 
		    goal-covered-list)
		   verbose
		   t))
		 (t 
		  (break 
		   "ERROR: Index-list ~S refers to more than one case."
		   index-list) 
		  nil
		  )))))
  )



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; USE-CASES
;;;
;;;
;;; Use-cases implements the manual case retrieval function. The user should
;;; use a default goal-num of (length (get-lits-no-and (p4::problem-goal
;;; (current-problem))))
;;;
(defun use-cases (goal-num threshold &rest cases) 
  "Manual case retrieval function"
  (setf *replay-cases* nil)
;  (setf *replay-cases*
;  (dolist (each-case cases)
  (my-ret cases goal-num threshold)
	 ;)
;	 (format t "~S ~S ~S~%" each-case goal-num threshold)
;	)
  (load-cases)
  )


;;;
;;; Function my-ret(rieval)
;;;
(defun my-ret (case-list goal-num threshold)
  (format t "~%case list: ~S~%" case-list)
  (simple-retrieval :max-goals 
		    goal-num
		    :match-threshold
		    threshold
		    :case-list
		    (assemble-name-list case-list)
;		     (concatenate 'string 
;				  *problem-path* 
;				  "probs/cases/headers/"
;				  case-root)
;		     case-root
		    )
;		    :append2replay-cases t)
;    (break)
;    (list case-root
;	  (rename-case case-root) 
;	  nil 
;	  nil)
;    )
  )


;;;
;;; Function assemble-name-list takes a list of case names and returns a list 
;;; of strings with the ".lisp" extensions stripped off. 
;;;
(defun assemble-name-list (case-names)
  (cond ((null case-names)
	 nil)
	(t
	 (let* ((case-string (string-downcase
			      (string (first case-names))))
		(extension-position 
		 (search ".lisp" case-string))
		(case-root
		 (if extension-position
		     (subseq case-string 0 extension-position)
		   case-string)))
	   (cons case-root (assemble-name-list (rest case-names))))))
  )







;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Start support code for finding *replay-cases*.
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun get-case-name (index)
  "Given an index into *cover-matches*, return the case name."
  (second
   (nth index 
	*cover-matches*))
  )


(defun get-goal-name (index)
  "Given an index into *cover-matches*, return the goal literal."
  (first
   (nth index 
	*cover-matches*))
  )

;;;
;;; Predicate same-case-matches-p returns non-nil, iff every entry in 
;;; *cover-matches* indexed by index-list refers to the same case. If so it 
;;; returns the name of the case, otherwise nil. The predicate assumes that
;;; index-list is not nil.
;;;
(defun same-case-matches-p (index-list)
  (scm-p (rest index-list)
	 (get-case-name 
	  (first index-list)))
  )

;;;
;;; Predicate scm-p is the recursive function for predicate 
;;; same-case-matches-p. scm=same-case-matches
;;;
(defun scm-p (index-list case-name)
  "Recursive function for predicate same-case-matches-p."
  (cond ((null index-list) case-name) ; Return case name if reached end of list
	(t
	 (and (eq case-name           ; Check for equal names and 
		  (get-case-name 
		   (first index-list)))
	      (scm-p (rest index-list); recurse
		     case-name))))
  )



;;;
;;; Function find-largest-cover-set returns the entry from *x-bind-list* that
;;; contains a binding-list that covers the largest number of goals in the new
;;; problem. Because each entry in *x-bind-list* is a list whose head is a
;;; binding list and whose tail is a list of indexes into *cover-matches*, the
;;; function recursively traverses *x-bind-list* looking for the entry with the
;;; longest tail. This procedure assumes that each entry in *cover-matches*
;;; represents a match on a single goal.
;;;
(defun find-largest-cover-set (&optional 
			       (bind-list *x-bind-list*)
			       (max 0)
			       (max-position -1) 
			       (current-position 0)
			       )
  (cond ((null bind-list)
	 (nth max-position *x-bind-list*))
	((let ((current-len
		(length (rest (first bind-list)))))
	   ;; Replace max with current if current is larger
	   (if (or (> current-len max)
		   ;; or if they are equal and current has a higher percentage
		   ;; of the initial state matched.
		   (and (= current-len max)
			(higher-match-number-p
			 (nth current-position *x-bind-list*)
			 (nth max-position *x-bind-list*))))
	       (find-largest-cover-set
		(rest bind-list)
		current-len
		current-position
		(+ 1 current-position))
	     )))
	(t
	 (find-largest-cover-set
	  (rest bind-list)
	  max
	  max-position
	  (+ 1 current-position))))
  )


;;;
;;; Predicate higher-match-number-p takes as input two elements from
;;; *x-bind-list* that represent equally large cover sets, and returns t iff
;;; the index of the element that points into *cover-matches*, points to a
;;; match that has a higher percentage-initial-state-matched than the
;;; corresponding one pointed to by the previousl element.
;;;
(defun higher-match-number-p (current-elt previous-elt)
  (if (> (first (last 
		 (nth (first (last current-elt)) 
		      *cover-matches*)))
	 (first (last 
		 (nth (first (last previous-elt)) 
		      *cover-matches*))))
      t)
  )


;;;
;;; Function adjust-bind-list removes the case that covered the most number of
;;; current goals from the global binding list structure *x-bind-list* which
;;; was established earlier by the function analyze-matches. *x-bind-list* has
;;; form ((<b-list1> i11 .. i1x) (<b-list2> i21 .. i2y) .. (<b-listn> i31
;;; .. i3z)) where each <blist> is a binding list and each i is an index into
;;; the list *cover-matches*. Because function find-largest-cover-set has just
;;; found the entry with the largest number of indexes (i.e., (max x y .. z)),
;;; adjust-bind-list needs to remove the entry from the list. However, it also
;;; must adjust the remaining entries in *x-bind-list* by removing any indexes
;;; they share with the one just selected. For example, if largest = (<b-list2>
;;; i21 .. i2y) and i11=i21, then i11 must be removed from the first entry in
;;; *x-bind-list*.  Thus the same case will not selected twice (i.e., the case
;;; referred to by the i11 entry in *cover-matches*. Additionally, the function
;;; must remove pointers to the selected cases in *x-bind-list*. This is the
;;; reason for the call of union when setting the initial value of the
;;; auxiliary variable index-list. Finally, the function must remove pointers
;;; to any other entries in *Cover-matches* that also solve the goals in the
;;; cover-set just selected.
;;;
;;; NOTE that because we use acons below, we may get a bug when adding a new
;;; adjustnemt and then deleting it later which leaves the earlier (obsolete) 
;;; assoc item.
;;;
(defun adjust-bind-list (largest 
			 case-name 
			 goal-list
			 &aux 
			 (index-list 
			  (union 
			   (collect-goal-ptrs
			    goal-list)
			   (union 
			    (rest (assoc case-name *x-case-list* :test #'equal))
			    (rest largest)))
			  ))
  (declare 
   (type largest cons)
   (type case-name string)
   (type goal-list cons)
   (inline collect-goal-ptrs)
   (optimize speed (safety 0)))
  (setf *x-bind-list* 
	(remove largest *x-bind-list* :test #'equal))
  (dolist (each-entry *x-bind-list*)
	  (if (intersection (rest each-entry)
			    index-list)
	      (let ((diff (set-difference (rest each-entry)
					  index-list)))
		(if (eq (length diff) 0) ;instead of 0, was (length index-list)
		    (setf *x-bind-list* 
			  (remove  each-entry *x-bind-list* :test #'equal))
		  (setf *x-bind-list* 
			(acons (first each-entry)
			       diff
			       *x-bind-list*))))))
  )



;;;
;;; Mapcar was not possible, because we have to collect lists, rather than
;;; elements, so function collect-goal-ptrs returns a recursively appended list
;;; of all of the corresponding pointers into *cover-matches* for each goal in
;;; the g-list.
;;;
(defun collect-goal-ptrs (g-list)
  (declare 
   (optimize speed (safety 0)))
  (cond ((null g-list)
	 nil)
	(t (append 
	    ;; This returns a list of pointers into *cover-matches* that are
	    ;; associated with the first goal in the g-list.
	    (rest (assoc (first g-list) *x-goal-list* :test #'equal))
	    (collect-goal-ptrs (rest g-list)))))
  )



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Changes to case replay. 
;;;

;;;  Predicate has-no-var-args-p returns t iff the goal (in list form) has no
;;; arguments that are variables (e.g., <x>). Called below.
;;;
(defun has-no-var-args-p (case-visible-goal)
  (notany #'(lambda (arg)
	       (p4::strong-is-var-p arg))
	   (rest case-visible-goal))
  )

;;; ***********************************************************
;;; Skips goal loops and goals now true in state
;;; ***********************************************************
;;;
;;; This is an overload of function by same name in newest-replay.lisp.
;;;
(defun skip-if-goal-true-or-loop ()
  ;;(break "In skip")
  (when (and (not (eq *guiding-case* 'no-case))
	     (case-goal-p (guiding-case-ptr *guiding-case*)))
    (let* ((case-visible-goal
	    (get-case-new-visible-goal
	     (guiding-case-ptr *guiding-case*)
	     *guiding-case*))
	   (case-goal-literal
	    (and (has-no-var-args-p case-visible-goal) ;; Added so will not try
						       ;; to call
						       ;; instantiate-consed-literal
						       ;; and thus crash. [cox
						       ;; 3jun98]
		 (p4::instantiate-consed-literal case-visible-goal))))
      (when *debug-case-p*
	(format t "~% Current pending goals: ~S" *current-pending-goals*)
	(format t "~% Case visible goal: ~S" case-visible-goal))
      ;;it will skip the goal in the case only it is a goal loop or the goal
      ;;is currently true in the state.
      (cond
       ((or (null case-goal-literal) ;; Added condition [cox 3jun98]
	    (p4::goal-loop-p *current-node* case-goal-literal)
	    (and (p4::literal-state-p case-goal-literal)
		 (not (p4::literal-neg-goal-p case-goal-literal))))
	;;(format t "~% true in state1")
	(skip-goal-loop-or-true-in-state case-visible-goal)
	(check-case-to-follow)) ;case goal is not negated and literal is true in state
       ((or (p4::goal-loop-p *current-node* case-goal-literal)
	    (and (not (p4::literal-state-p case-goal-literal))
		 (p4::literal-neg-goal-p case-goal-literal)))
	;;(format t "~% true in state2")
	(skip-goal-loop-or-true-in-state case-visible-goal t)
	(check-case-to-follow)) ;case goal is negated and literal is not true in state
       ((not (member case-visible-goal *current-pending-goals*
		     :test #'(lambda (x y) (equal x (goal-from-literal y)))))
	;;to make sure that the case goal is not followed. Prodigy accepts
	;;happily a goal, returned by a control rule, which is not
	;;a pending goal. (why? don't know)
	;;(setf *guiding-case* 'no-case)
	;;(format t "~% looping")
	;;(check-case-to-follow))
	;; actually this is not possible - jade test2, rocket 3 guiding 2 examples
	(skip-goal-loop-or-true-in-state case-visible-goal
					 (p4::literal-neg-goal-p case-goal-literal))
	(check-case-to-follow))
       (t 
	nil)))))


