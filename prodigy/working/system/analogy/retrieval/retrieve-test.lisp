;;;*****************************************************************
;;; Retrieval - organized by modules - Manuela Veloso
;;; From Analogy in NoLimit to Prodigy/Analogy in 4.0
;;;*****************************************************************
;;; MODIFIED BY: Anthony Francis (code: CENTAUR)
;;; NOTES: To search for modifications by an author, search for the
;;; 	string "===CODENAME==="
;;;*****************************************************************

;;;*****************************************************************
;;; Top-level module
;;; EVALUATE-SIMILARITIES takes a new problem and a list of case headers
;;; as input (could be a single one at a time). It goes through the list 
;;; and evaluates the specified similarity metric, *similarity-metric*,
;;; between the new problem and each of the past cases.
;;; It returns a list of *cover-matches* of a similar same format as
;;; *best-cover-matches* -- see ~/smart/retrieve-analogs.lisp.
;;; and *case-coverage* (which may have some useful temp information)
;;; The list of past cases is given as a list of case headers.
;;; So cases need to be a pointer to a list of structures of type
;;; case-header -- see loading/load-case-headers.lisp.
;;; The function load-case-headers sets the global variable *case-headers*.
;;; The case headers need to have been loaded.
;;; prob needs to be a problem structure as returned by (current-problem)
;;; Ex: (problem 'p3) loads the problem and sets (current-problem)
;;; THE PROBLEM NEEDS TO BE LOADED, SO ITS OBJECTS ARE CREATED,
;;; SO CALL (p4::load-problem (current-problem) nil) before calling
;;; evaluate-similarities.
;;;*****************************************************************

(defvar *similarity-metric* 'footprint)
(defvar *cover-matches* nil)
(defvar *case-coverage* nil)

(defun evaluate-similarities (&key (prob (current-problem))
				   (case-headers *case-headers*)
				   (match-threshold 0.6)
				   (max-goals 2)
				   (current-match 0))
  (let ((new-goals (get-lits-no-and (p4::problem-goal prob)))
	(new-state (get-lits-no-and (p4::problem-state prob)))
	(new-objs (p4::problem-objects prob))
	(case-goal-coverage nil)
	(stop nil))
    (setf *cover-matches* nil *case-coverage* nil)
    (dolist (case case-headers)
      (let* ((case-subst (case-header-insts-to-vars case))
	     (old-goals (sublis case-subst (case-header-goal case)))
	     (old-footprint-by-goal (sublis case-subst (case-header-footprint case)))
	     (goal-substs nil))
	(format t "~% case-name ~S ~% case-subst ~S ~% old-goals ~S
                   ~% old-footprint-by-goal ~S"
		(case-header-name case) case-subst old-goals old-footprint-by-goal)
	(when (<= (length old-goals) max-goals)
	  (case *similarity-metric*
	    (interacting-footprint;;this is not tested 
	     (setf goal-substs (unify-equal-preds new-goals old-goals nil)))
	    (footprint
	     ;;no complete coverage of goals
	     (setf goal-substs (unification-matches new-goals old-goals))))
	  (cond
	   ((null goal-substs)
	    (process-if-no-argument-goals (case-header-name case)
					  match-threshold new-goals old-goals
					  new-state old-footprint-by-goal))
	   (t
	    (dolist (goal-subst goal-substs)
	      (setf case-goal-coverage nil)
	      (dolist (goal new-goals)
		(let* ((old-footprint-goal
			(cdr (assoc (rsubstitute-bindings goal goal-subst)
				    old-footprint-by-goal :test #'equal))))
		  (cond
		   (old-footprint-goal
		    ;; This goal was also solved in the past
		    (let* ((old-subst-footprint-state
			    (sublis goal-subst old-footprint-goal))
			   (match (car (initial-state-matches
					(list goal-subst)
					old-subst-footprint-state new-state)))
			   (length-intersection-initial-state
			    (length (intersection
				     (sublis match old-subst-footprint-state)
				     new-state :test #'equal)))
			   (percentage-initial-state-matched
			    (/ (* 1.0  length-intersection-initial-state)
			       (length old-subst-footprint-state))))
		      (push (cons goal (list (case-header-name case)
					     match
					     length-intersection-initial-state
					     percentage-initial-state-matched))
			    *cover-matches*)
		      (push (cons goal (list length-intersection-initial-state
					     percentage-initial-state-matched))
			    case-goal-coverage)))
		   (t (push (cons goal '(0 0)) case-goal-coverage) nil))))
	      (push (list (case-header-name case) goal-subst case-goal-coverage)
		    *case-coverage*)
	      (let ((case-goodness 0) (percentage 0))
		(dolist (goal-matches case-goal-coverage)
		  (setf case-goodness (+ case-goodness (nth 1 goal-matches)))
		  (setf percentage (+ percentage (nth 2 goal-matches))))
		(when (>= (/ percentage (length case-goal-coverage)) match-threshold)
		  (format t "~% match threshold reached - stopping")
		  (setf stop t)
		  (return))))
	    (if stop (return))))))))
  *cover-matches*)

;;;*****************************************************************
;;; UNIFICATION module for goals with no arguments 
;;; Manuela - July 97
;;;*****************************************************************

(defun process-if-no-argument-goals
  (case-name match-threshold new-goals old-goals new-state old-footprint-by-goal)
  (let ((matched-goals (match-no-argument-goals new-goals old-goals)))
    (cond
     ((null matched-goals) nil)
     (t
      (let ((case-goal-coverage nil)
	    (goal-subst nil))
	(dolist (goal matched-goals)
	  (let* ((old-footprint-goal
		    (cdr (assoc goal old-footprint-by-goal :test #'equal))))
	    (cond
	     (old-footprint-goal
	      ;; This goal was also solved in the past
	      (let* ((old-subst-footprint-state
		      (sublis goal-subst old-footprint-goal))
		     (match (car (initial-state-matches
				  (list goal-subst)
				  old-subst-footprint-state new-state)))
		     (length-intersection-initial-state
		      (length (intersection
			       (sublis match old-subst-footprint-state)
			       new-state :test #'equal)))
		     (percentage-initial-state-matched
		      (/ (* 1.0  length-intersection-initial-state)
			 (length old-subst-footprint-state))))
		(format t "~%old-footprint-goal: ~S" old-footprint-goal)
		(format t "~%goal-subst: ~S" goal-subst)
		(format t "~%old-subst-footprint-state: ~S" old-subst-footprint-state)
		(format t "~%Initial state match: ~S" match)
		(format t "~%New state: ~S" new-state)
		(format t "~%sublis match old-subst-fooprint-state ~S"
			(sublis match old-subst-footprint-state))
		(format t "~%length-intersection-initial-state: ~S"
			length-intersection-initial-state)
		(push (cons goal (list case-name 
				       match
				       length-intersection-initial-state
				       percentage-initial-state-matched))
		      *cover-matches*)
		(push (cons goal (list length-intersection-initial-state
				       percentage-initial-state-matched))
		      case-goal-coverage)))
	     (t
	      (push (cons goal '(0 0)) case-goal-coverage)
	      nil)))
	  (push (list case-name goal-subst case-goal-coverage)
		*case-coverage*)
	  (let ((case-goodness 0) (percentage 0))
	    (dolist (goal-matches case-goal-coverage)
	      (setf case-goodness (+ case-goodness (nth 1 goal-matches)))
	      (setf percentage (+ percentage (nth 2 goal-matches))))
	    (format t "~% percentage ~S match-threshold ~S" percentage match-threshold)
	    (when (>= (/ percentage (length case-goal-coverage)) match-threshold)
	      (format t "~% Match threshold reached.")
	      (return))))))))
  *cover-matches*)
       
(defun match-no-argument-goals (new-goals old-goals)
  (intersection new-goals old-goals :test #'equal))

  
;;;*****************************************************************
;;; UNIFICATION module
;;;*****************************************************************
;;; This set of functions computes the matches between two lists
;;; of literals, goals. It takes into account the type, class, of the
;;; variables and constants, as defined in function get-class-of, below.
;;; This set of functions is self-contained.
;;; The following examples runs show the functionality of the
;;; unification procedure (all vars and constants were set to be 
;;; of the same type, class):
;;; (unification-matches '((at a b)) '((at <x> <y>)))
;;; (((<y> . b) (<x> . a)))
;;; (unification-matches '((at a b)) '((at c <y>)))
;;; nil
;;; (unification-matches '((at <a> b)) '((at <x> <y>)))
;;; nil
;;; (unification-matches '((at a b)) '((at <x> <y>) (at <z> <w>)))
;;; (((<w> . b) (<z> . a)) ((<y> . b) (<x> . a)))
;;; (unification-matches '((at a b) (in c d)) '((in <x> <y>) (at <z> <w>)))
;;; (((<y> . d) (<x> . c) (<w> . b) (<z> . a)))
;;; (unification-matches '((at a b) (in c d)) '((in <x> <y>) (at <z> <w>) (on <p> <q>)))
;;; (((<y> . d) (<x> . c) (<w> . b) (<z> . a)))
;;;*****************************************************************

(defun unification-matches (new-goals old-goals)
  (setf old-goals
	(remove-if-not #'(lambda (x) 
			       (has-variables-p x)) old-goals))
  ;;(format t "~% old-goals ~S" old-goals)
  (let ((substitutions nil))
    (if old-goals
	(dolist (goal new-goals)
	  (let* ((other-goals (remove goal new-goals :test #'equal))
		 (compare-old-new
		  (remove-if-not #'(lambda (x) (eq (car x) (car goal)))
				 old-goals))
		 (goal-substs
		  (if compare-old-new
		      (cond
		       ((have-variables-p compare-old-new)
			(unify-one-goal (cdr goal) 
					(map 'list #'cdr compare-old-new) nil))
		       (t nil))))
		 (goal-result nil))
	    (dolist (goal-subst goal-substs)
	      ;;(break "~% In goal-subst loop")
	      (setf goal-result goal-subst)
	      (setf goal-result
		    (merge-substitutions
		     (unification-matches other-goals
					  (substitute-bindings old-goals goal-subst))
		     (list goal-result)))
	      (setf substitutions
		    (append goal-result substitutions))))))
    (remove-duplicates substitutions
		       :test #'(lambda (x y) (and (subsetp x y :test #'equal)
						  (subsetp y x :test #'equal))))
    (remove-duplicates substitutions 
		       :test #'(lambda (x y) (subsetp (sublis x old-goals)
						      (sublis y old-goals)
						      :test #'equal)))))



;;;*****************************************************************

(defun unify-one-goal (new-goal old-goals substitutions)
  (if (null old-goals) 
      substitutions
      (let ((subst (unify-bind-pairs new-goal (car old-goals))))
	(unify-one-goal new-goal (cdr old-goals)
			(if subst
			    (append substitutions (list subst))
			    substitutions)))))

(defun unify-bind-pairs (goal effect)
  (do* ((elements1 goal (cdr elements1))
	(elements2 effect (cdr elements2))
	(e1 (car elements1) (car elements1))
	(e2 (car elements2) (car elements2))
	(bindings nil))
      ((or (not (type-unifyp e1 e2))
	   (null elements1)
	   (null elements2))
       (if (null (or elements1 elements2))
	   bindings))
    (let ((bind-pair (cons e2 e1)))
      (if (not (eq e1 e2))
	  (push bind-pair bindings))
      (setq elements1 (substitute-bindings elements1 (list bind-pair))))))

;;;******************************************************************

;; Assumes l1 and l2 are of the same length.

(defun all-type-unifyp (l1 l2)
  (cond
    ((null l1) t)
    ((type-unifyp (car l1) (car l2))
     (all-type-unifyp (cdr l1) (cdr l2)))
    (t nil)))

(defun type-unifyp (e1 e2)
  (cond
    ((and (null e1) (null e2))
     t)
    ((and (not (p4::strong-is-var-p e1))
	  (not (p4::strong-is-var-p e2)))
     (equal e1 e2))
    ((not (and (p4::strong-is-var-p e1)
	       (p4::strong-is-var-p e2)))
     (equal (get-class-of e1)
	    (get-class-of e2)))
    (t nil)))


(defun substitute-bindings (expression bindings)
  (cond ((null bindings) expression)
	((null expression) nil)
	((atom expression)
	 (let ((value (cdr (assoc expression bindings))))
	   (if value value expression)))
	((and (atom (car expression))
	      (p4::functionp (car expression)))
	 (sublis (mapcar #'(lambda (binding)
			     (let ((value (cdr binding)))
			       (cons (car binding)
				     (list 'QUOTE value))))
			 bindings)
		 expression))
	(t (cons (substitute-bindings (car expression) bindings)
		 (substitute-bindings (cdr expression) bindings)))))


(defun merge-substitutions (bindings1 bindings2)
  (cond
   ((null bindings1) bindings2)
   ((null bindings2) bindings1)
   (t
    (let ((res nil))
      (dolist (binds1 bindings1)
	(dolist (binds2 bindings2)
	  (cond
	    ((subsetp binds1 binds2 :key #'car)
	     (setf res (insert-bindings binds2 res)))
	    ((subsetp binds2 binds1 :key #'car)
	     (setf res (insert-bindings binds1 res)))
	    ((intersection binds1 binds2 :test #'(lambda (x y)
					      (or (eq (car x) (car y))
						  (eq (cdr x) (cdr y)))))
	     (setf res (insert-bindings binds1 res))
	     (setf res (insert-bindings binds2 res)))
	    (t
	     (setf res (insert-bindings (append binds1 binds2) res))))))
      res))))

(defun insert-bindings (binds res)
  (pushnew binds res
	   :test #'(lambda (x y) (and (subsetp x y :test #'equal)
				      (subsetp y x :test #'equal)))))

;;;*****************************************************************

(defun has-variables-p (literal)
  (some #'(lambda (x) (p4::strong-is-var-p x))
	literal))

(defun have-variables-p (literals)
  (cond
    ((null literals) nil)
    ((has-variables-p (car literals)) 
     t)
    (t
     (have-variables-p (cdr literals)))))

;;--------------------------------------------------------------;;
;; FUNCTION get-class-of					;;
;;--------------------------------------------------------------;;
;; MODIFIED BY: Anthony Francis (CENTAUR)			;;	
;;--------------------------------------------------------------;;
;; NOTES: This function needs to return the class of both a 
;;	variable and an instance. There has to be some 
;;	convention on names of variables to more easily extract
;; 	the type of the variable from its name.
;;
;;	Therefore: variables should be of the format:
;;		<var>      ::= "<" <var-body> <var-tail> ">"
;;		<var-body> ::= (<alphas> | <punc> )*
;;		<alphas>   ::= "A" | "B" ...
;;		<punc>     ::= "-" | "=" | "." ...
;;		<var-tail> ::= (<numbers>)+
;;		<numbers>  ::= "0" | "1" | "2" ...
;;
;;	Thus the following are legal (for GET-CLASS-OF):
;;		<PERSON1> --> yields type PERSON
;;		<HOME-BASE5> --> yields type HOME-BASE
;;
;;	The following will not be resolved correctly:
;;		<A<B9> --> yields type AB, wrong if 
;;				original type was A<B
;;		<PERSON.9> --> yields type |PERSON.|, 
;;				wrong if type was PERSON
;;		<K9001> --> yields type K, wrong if
;;				type was K9
;;
;; From ~/smart/store-problem.lisp:
;; 	var is assumed to be a variable <.> an instance.
;; 	It is assumed also that there is an assoc list
;; 		called *class-short-names* with the correspondence
;; 		between the class name and the short name of the
;; 		variables.
;;	If *class-short-names* does not exist, the code attempts
;;	to extract the type name from the variable by stripping
;;	off the "<"'s and ">"' of the end of the type name and
;;	then eliminating any uniquifying numbers off the end.
;;
;; Example ((OBJECT . obj) (LOCATION . loc))
;; 	if *class-short-names* is ((object . b)) for blocksworld
;; 	and a is a real instance of class object, then:
;;
;; 	(get-class-of '<b56>) returns object
;; 	(get-class-of 'b56) returns nil, 
;;				because there is no real instance b56.
;; 	(get-class-of 'z34) returns nil  
;;				-- does not make sense
;; 	(get-class-of 'a), a real instance, returns object
;;--------------------------------------------------------------;;

(defun get-class-of (var)
  (cond
    ((p4::strong-is-var-p var)
     (let ((str (symbol-name var)))
       ;;; search for dot.
       (or (car (rassoc (read-from-string
			 (subseq str 1 (position-if #'digit-char-p str)))
			*CLASS-SHORT-NAMES*))
	   ;;-------------------------------------------------------------
	   ;; Modified by: ===CENTAUR===
	   ;; If *CLASS-SHORT-NAMES* is nil, try to strip the code name
	   ;; out by trimming all "<"'s and ">"'s, and then trimming
	   ;; all of the numbers on the right. 
	   ;;-------------------------------------------------------------
	   ;; Added the trim of the dot [cox 17jul97]
	   (read-from-string
	    (string-right-trim "."
			       (string-right-trim "0123456789"
						  (string-trim "<>" str)))))))
    ((p4::object-name-to-object var *current-problem-space*)  ;it is an existing instance
     (get-type-of-object var))
    (t nil)))

;;;*****************************************************************
;;; End of UNIFICATION module
;;;*****************************************************************

;;;*****************************************************************
;;; Footprint similarity metric
;;;*****************************************************************

;;; (foot-print-state-match-value '((at a b) (on c d)) '((g s))
;;;                               '(((on c d) (g s)) ((in x y) (bla z))))
;;; 1
;;; (foot-print-state-match-value '((at a b) (on c d)) '((g s))
;;;                               '(((on c d) (g s)) ((in x y) (g s))))
;;; 1
;;; (foot-print-state-match-value '((at a b) (on c d)) '((g s))
;;;                               '(((on c d) (g s)) ((at a b) (g s))))
;;; 2
;;; (foot-print-state-match-value '((at a b) (on c d)) '((g s))
;;;    				  '(((on c d) (g q)) ((at a b) (g q))))
;;; 0
;;; (foot-print-state-match-value '((at a b) (on c d)) '((g s) (g q))
;;; 				  '(((on c d) (g q)) ((at a b) (g s))))
;;; 2
;;; (foot-print-state-match-value '((at a b) (on c d)) '((g s) (g q))
;;; 				  '(((on c d) (g q)) ((in <x> <y>) (g s))))
;;; 1

(defun foot-print-state-match-value (new-state new-goals old-state-goal)
  (count-if #'(lambda (x) (and (not (null (cdr x)))
			       (member (car x) new-state :test #'equal)
			       (intersection new-goals (cdr x) :test #'equal)))
	    old-state-goal))

;;;*****************************************************************
;;; MATCHING GOALS MODULE
;;; This module takes a set of new goals and a set of old variablized goals.
;;; It returns a substitution if there is a perfect match
;;; between the two sets of goals.
;;; (It is up to some external module to call this function with the
;;; correct subsets of goals to achieve partial coverage.)
;;;*****************************************************************

(defun unify-equal-preds (goals var-goals substs)
  (cond
    ((null goals) substs)
    ((equal (car goals) (car var-goals))
     (unify-equal-preds (cdr goals) (cdr var-goals) substs))
    (t
     (let ((subst (unify-bind-pairs (cdar goals) (cdar var-goals))))
       (if subst 
	   (unify-equal-preds (cdr goals) (sublis subst (cdr var-goals))
			      (append subst substs))
	   (unify-equal-preds nil nil nil))))))

;;;*****************************************************************

(defun initial-state-matches (goal-matches old-state new-state)
  (cond
    ((null goal-matches) nil)
    (t
     (let* ((partial-inst-old-state
	     (sort (sublis (car (copy-list goal-matches)) (copy-list old-state))
		   #'(lambda (lit1 lit2)
		       (< (count-if #'(lambda (elt) (p4::strong-is-var-p elt)) lit1)
			  (count-if #'(lambda (elt) (p4::strong-is-var-p elt)) lit2)))))
	    (reduced-new-state 
	     (remove-if-not #'(lambda (x)
				(some #'(lambda (y)
					  (all-type-unifyp x y))
				      partial-inst-old-state))
			    new-state)))
      (format t "~%sorted initial state ~S" partial-inst-old-state)
       (append (merge-substitutions
		(list (car goal-matches))
		(reject-inconsistent (car goal-matches)
				     (unify-initial-states
				      partial-inst-old-state
				      reduced-new-state)))
	       (initial-state-matches (cdr goal-matches) old-state new-state))))))

;; Such a stupid problem... due to test-5-6...
;; Two trucks at the same post-office when matching against case-test-7-2...

(defun reject-inconsistent (previous-match new-matches)
  (remove-if #'(lambda (x) (some #'(lambda (y)
				     (some #'(lambda (z)
					       (and (eq (cdr z) (cdr y))
						    (not (eq (car z) (car y)))))
					   x))
				 previous-match))
	     new-matches))

(defun unify-initial-states (old-state new-state)
  ;;(break "~% Entering unify-initial-states")
  (cond
    ((null old-state) nil)
    ((not (some #'(lambda (x) (not (p4::strong-is-var-p x)))
		(cdar old-state)))    ;unconstrained matches at replay time
     (unify-initial-states (cdr old-state) new-state))
    (t
     (let ((matches (unification-matches
		     (remove-if-not
		      #'(lambda (x)
			  (and (eq (car x) (caar old-state))
			       (all-type-unifyp (cdr x) (cdar old-state))))
		      new-state)
		     (list (car old-state)))))
       (cond
	 (matches
	  ;;(break "~% I have matches")
	  (let ((result nil))
	    (dolist (match matches)
	      (setf result
		    (append
		     (merge-substitutions
		      (list match)
		      (unify-initial-states
		       (substitute-bindings (cdr old-state) match)
		       new-state))
		     result)))
	    result))
	 (t
	  (unify-initial-states (cdr old-state) new-state)))))))

;;;*****************************************************************

;; Bindings is given as ((<ap0> . a9) (<a0> . pl4))
;; Function expects expression with instantiated things
;; for which variables will be substituted.
;; (rsubstitute-bindings
;;      '((at-obj ob12 a9) (at-airplane pl4 a9) (same-city po9 a9))
;;      '((<ap0> . a9) (<a0> . pl4) (<ap1> . a5) (<p0> . ob12) (<po0> . po9)))
;; ((at-obj <p0> <ap0>) (at-airplane <a0> <ap0>) (same-city <po0> <ap0>))

(defun rsubstitute-bindings (expression bindings)
  (cond ((null bindings) expression)
	((null expression) nil)
	((atom expression)
	 (let ((value (car (rassoc expression bindings))))
	   (if value value expression)))
	(t (cons (rsubstitute-bindings (car expression) bindings)
		 (rsubstitute-bindings (cdr expression) bindings)))))

;;*********************************************************

#|
;;; This function looks at the *case-coverage* returned by 
;;; evaluate-similarities and selects a set of cases to be
;;; loaded, by constructing the variable *replay-cases*
;;; (*replay-cases* is the same variable returned by
;;; manual-retrieval)
;;; THIS FUNCTION IS UNDER CONSTRUCTION

;;; *replay-cases*
;;; (("case-prob2objs" "case-prob2objs" ((at obj1 locb) (at obj2 locb))
;;;  ((<r22> . r1) (<o66> . obj2) (<o29> . obj1) (<l86> . locb) (<l9> . loca))))
;;; *cover-matches*
;;; (((at obj2 locb) "case-prob2objs"
;;;   ((<o66> . obj2) (<l86> . locb) (<o29> . obj1) (<l9> . loca) (<r22> . r1)) 2 1.0)
;;;  ((at obj1 locb) "case-prob2objs"
;;;   ((<o66> . obj2) (<l86> . locb) (<o29> . obj1) (<l9> . loca) (<r22> . r1)) 2 1.0))
;;; *case-coverage*
;;; (("case-prob2objs" ((<o66> . obj2) (<l86> . locb) (<o29> . obj1))
;;;  (((at obj2 locb) 2 1.0) ((at obj1 locb) 2 1.0))))

(defun select-replay-cases ()
  (setf *replay-cases* nil)
  (let* ((case-name (read))
	 (case-info (list case-name)))
    (load-case-header case-name)
    (let ((case-header (get-case-header-from-case-name case-name)))
      (format t "~%~% Enter new name for case. If same, then enter nil: ")
	   (let ((new-case-name (or (read) case-name)))
	     (push new-case-name case-info)
	     (format t "~% Case goal: ~S" (case-header-goal case-header))
	     (format t "~% Case footprint state: ~S" (case-header-footprint case-header))
	     (format t "~% Case instances to variables: ~S~%"
		     (case-header-insts-to-vars case-header))
	     (format t "~% Enter goals from the current problem covered by this case:")
	     (format t "~% (e.g. ((on a b) (clear c)))~%  ")
	     (push (read) case-info)
	     (let ((bindings nil))
	       (format t "~% Enter substitution, for each case variable.")
	       (format t "~% If a case variable, does not have a binding, enter nil.~%")
	       (dolist (inst-to-var (case-header-insts-to-vars
				     (get-case-header-from-case-name case-name)))
		 (format t " ~S " (cdr inst-to-var))
		 (let* ((obj (read))
			(binding-pair
			 (cons (cdr inst-to-var) (or obj (cdr inst-to-var)))))
		   (push binding-pair bindings)))
	       (if *debug-case-p*
		   (format t "~% These are the bindings entered ~S" bindings))
	       (push bindings case-info))))
	 (push (reverse case-info) *replay-cases*)))))
  *replay-cases*)
|#
;;;*****************************************************************

  
