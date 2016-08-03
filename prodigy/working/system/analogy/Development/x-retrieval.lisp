;;**************************************************************;;
;;--------------------------------------------------------------;;
;; Program:	X-ANALOGY: Experimental Extensions For		;;
;;			PRODIGY/ANALOGY				;;
;; Author:	Anthony G. Francis, Jr.				;;
;; Class:	CS8503: Guided Research				;;
;; Assignment:	Thesis Research Implementation			;;
;; Due:		Not Specified					;;
;;--------------------------------------------------------------;;
;; Module:	Experimental Analogy Retrieval Extensions	;;
;; File:	"x-retrieval.lisp"				;;
;;--------------------------------------------------------------;;

;; Notes:	This contains extra functions for analogy.	;;
;;--------------------------------------------------------------;;
;; File Contents:						;;
;; 1. Base Loader and Verbosity Flags				;;
;; 2. Data-Structure Analysis Functions				;;
;; 3. Retrieval and Postprocessing Functions			;;
;; 4. Helper Functions						;;
;;--------------------------------------------------------------;;
;; History:	23may98 Michael Cox changed call of pcons to  	;;
;;              add-2-bind-list in function analyze-matches and ;;
;;              wrote the function add-2-bind-list to implement ;;
;;              the change. This makes the creation of          ;;
;;              *x-bind-list* smarter.                          ;;
;;                                                              ;;
;;**************************************************************;;
(in-package "USER")

;;**************************************************************;;
;; 1. Base Loader and Verbosity Flags				;;
;;**************************************************************;;
;;--------------------------------------------------------------;;
;; UTILITY *load-trace*					;;
;;--------------------------------------------------------------;;
;; NOTES: 							;;
;;--------------------------------------------------------------;;
(unless (boundp *load-trace*)
	(load "loadtrace"))

;;--------------------------------------------------------------;;
;; VARIABLE *verbose*					;;
;;--------------------------------------------------------------;;
;; NOTES: 							;;
;;--------------------------------------------------------------;;
(loadtrace "~%   Defining variable *verbose* ...")
(defvar *verbose* t)

;;**************************************************************;;
;; 2. Data-Structure Analysis Functions				;;
;;**************************************************************;;
;;--------------------------------------------------------------;;
;; VARIABLE *x-goal-list*					;;
;;--------------------------------------------------------------;;
;; NOTES: 							;;
;;--------------------------------------------------------------;;
(loadtrace 
	"~%   Defining variable *x-goal-list* ...")
(defvar *x-goal-list* nil)

;;--------------------------------------------------------------;;
;; VARIABLE *x-case-list*					;;
;;--------------------------------------------------------------;;
;; NOTES: 							;;
;;--------------------------------------------------------------;;
(loadtrace 
	"~%   Defining variable *x-case-list* ...")
(defvar *x-case-list* nil)

;;--------------------------------------------------------------;;
;; VARIABLE *x-bind-list*					;;
;;--------------------------------------------------------------;;
;; NOTES: 							;;
;;--------------------------------------------------------------;;
(loadtrace 
	"~%   Defining variable *x-bind-list* ...")
(defvar *x-bind-list* nil)

;;--------------------------------------------------------------;;
;; FUNCTION analyze-matches					;;
;;--------------------------------------------------------------;;
;; NOTES: Analyzes the *cover-matches* data structure built by	;;
;;	(evaluate-similarities). Produces 3 data structures:	;;
;;		*x-goal-list*					;;
;;		*x-case-list*					;;
;;		*x-bind-list*					;;
;;	Each of these is an a-list indexed by the unique goals,	;;
;;	case names or bindings found in *cover-matches*. The 	;;
;;	contents of the a-list cells tell us which matches 	;;
;;	(as extracted by (nth NUM *cover-matches*)) contain 	;;
;;	these unique index items.				;;
;;--------------------------------------------------------------;;
(loadtrace "~%   Defining function analyze-matches ...")
(defun analyze-matches (&key (cover-matches *cover-matches*)
			     (verbose       *verbose*))
  ;;--------------------------------------------------------
  ;; Clear the data structures used to store the analyzed
  ;; match data. 
  ;;--------------------------------------------------------
  (setf *x-goal-list* nil)
  (setf *x-case-list* nil)
  (setf *x-bind-list* nil)

  ;;--------------------------------------------------------
  ;; If called from the command line, print some useful info.
  ;;--------------------------------------------------------
  (when verbose
	(format t "~%---Analyzing cover-matches ...")
	(format t "~%   Number of matches: ~s" (length cover-matches))
	)

  ;;--------------------------------------------------------
  ;; Loop through every match, collecting data on what goals
  ;; were matched, what cases were used, and what binding
  ;; lists were used to make the match.
  ;;--------------------------------------------------------
  (loop for match in cover-matches 
	for count = 0 then (1+ count) 
	for goal  = (first  match)
	for case  = (second match)
	for bind  = (third  match)
	do

	;;--------------------------------------------------------
	;; Print brags for each case if *verbose*
	;;--------------------------------------------------------
	(if *UI*
	    (ping))
	(when verbose
	      ;;Replaced next two lines with subsequent 3. [cox 26may98]
;	      (format t "~%   Match #~s: ~s state literals at ~s efficiency" 
;		      count (fourth match) (fifth match))
	      (format t "~%   Match #~s" count)
	      (format t "~%      Length-intersection-initial-state:    ~s" (fourth match))
	      (format t "~%      Percentage-initial-state-matched:    ~s" (fifth match))
	      (format t "~%      Goal:    ~s" goal)
	      (format t "~%      Case:    ~s" case)
	      (format t "~%      Bindings:  ")
	      (loop for binding in bind do
		    (format t "~%         ~s" binding)))

	;;--------------------------------------------------------
	;; Update the analysis data structures
	;;--------------------------------------------------------
	;;WARNING: MAY NEED TO MAKE THE TEST FOR EQUALITY FOR
	;;BINDING LISTS MORE POWERFUL --- ARE WE GUARANTEED
	;;ALL BINDING LISTS ARE ORDERED THE SAME?
	;;--------------------------------------------------------
	(setf *x-goal-list* (pcons goal count *x-goal-list*))
	(setf *x-case-list* (pcons case count *x-case-list*))
	;; [cox 23may98]
	(setf *x-bind-list* (add-2-bind-list bind count *x-bind-list*))
;	(setf *x-bind-list* (pcons bind count *x-bind-list*))
	)

  ;;--------------------------------------------------------
  ;; End Analysis. Run minor clean-down, if any, here.
  ;;--------------------------------------------------------
  )

;;**************************************************************;;
;; 3. Retrieval Functions					;;
;;**************************************************************;;
;;--------------------------------------------------------------;;
;; VARIABLE *x-current-goals*					;;
;;--------------------------------------------------------------;;
;; NOTES: 							;;
;;--------------------------------------------------------------;;
(loadtrace 
	"~%   Defining variable *x-current-goals* ...")
(defvar *x-current-goals* nil)

;;--------------------------------------------------------------;;
;; VARIABLE *x-case-table*					;;
;;--------------------------------------------------------------;;
;; NOTES: 							;;
;;--------------------------------------------------------------;;
(loadtrace 
	"~%   Defining variable *x-case-table* ...")
(defvar *x-case-table* nil)

;;--------------------------------------------------------------;;
;; VARIABLE *x-goal-table*					;;
;;--------------------------------------------------------------;;
;; NOTES: 							;;
;;--------------------------------------------------------------;;
(loadtrace 
	"~%   Defining variable *x-goal-table* ...")
(defvar *x-goal-table* nil)

;;--------------------------------------------------------------;;
;; FUNCTION assemble-replay-cases				;;
;;--------------------------------------------------------------;;
;; NOTES: A function which takes the data structures produced	;;
;;	by (evaluate-similarities) and (analyze-matches) and	;;
;;	produces a *replay-cases* list (as is produced by	;;
;;	(manual-retrieval). Not guaranteed to give the optimal	;;
;;	*replay-cases* list right now; this is just for 	;;
;;	starters.						;;
;;                                                              ;;
;;      Mike Cox has replaced calls to this function with a     ;;
;;      more relable function (find-replay-cases) in file       ;;
;;      x-analogy-support.                                      ;;
;;--------------------------------------------------------------;;
(loadtrace 
	"~%   Defining function assemble-replay-cases ...")
(defun assemble-replay-cases (&key (cover-matches *cover-matches*)
				   (verbose       *verbose*)
				   )
  ;;--------------------------------------------------------
  ;; Let's start off by being naughty and using global variables...
  ;; I must have fallen in with a bad crowd to be doing this... ;-]
  ;;--------------------------------------------------------
  ;; 	*x-current-goals* lists the current problem goals.
  ;;	*x-case-table* is a hierarchical a-list of cases,
  ;;		bindings and safe case names.
  ;; 	*x-goal-table* is a list of goals, case names, safe 
  ;;		case names, and binding lists.
  ;;--------------------------------------------------------
  (setf *x-current-goals* (get-lits-no-and 
			   (p4::problem-goal (current-problem))))
  (setf *x-case-table* nil)
  (setf *x-goal-table* nil)

  ;;--------------------------------------------------------
  ;; When called from the command line, inform the user
  ;;--------------------------------------------------------
  (when verbose
	(format t "~%---Assembling replay cases---")
	)
  ;;--------------------------------------------------------
  ;; Loop through the current goals, looking for useful stuff.
  ;;--------------------------------------------------------
  (loop for goal in *x-current-goals*
	for count = 0 then (1+ count)
	for relevant-matches = (sort (rest (assoc goal *x-goal-list* 
						  :test #'equal))
				     #'(lambda (x y)
					 (> 
					  (fifth (nth x cover-matches))
					  (fifth (nth y cover-matches)))))
	do

	;;--------------------------------------------------------
	;; Let the user know if we found any relevant matches.
	;;--------------------------------------------------------
	(when verbose
	      (format t "~%   Finding relevant cases for goal #~s: ~s"
		      count goal)
	      (format t "~%   Relevant Matches (Sorted by Match Value): ~s" relevant-matches)
	      )

	;;--------------------------------------------------------
	;; When relevant match numbers are found, install
	;; them into the case table.
	;;--------------------------------------------------------
	(when relevant-matches
	      ;;--------------------------------------------------------
	      ;; Again, inform user...
	      ;;--------------------------------------------------------
	      (when verbose
		    (format t "~%      Matches found; analyzing case..."))

	      ;;--------------------------------------------------------
	      ;; Build up a database on whether we've seen this before
	      ;;--------------------------------------------------------
	      (let* ((match (nth (first relevant-matches) 
				 cover-matches))
		     (case  (second match))
		     (bind  (third  match))

		     ;; An assoc list of bindings and safe case names
		     (case-info (rest (assoc case *x-case-table* 
					      :test #'equal)))

		     ;; The safe case name for this binding, if any.
		     (safe-name  (rest (assoc bind case-info 
					      :test #'equal)))
		     )

		;;--------------------------------------------------------
		;; COND: Check out the case name and binding and 
		;; add a new binding and/or case entry if necessary.
		;;--------------------------------------------------------
		(cond 
		 ;;--------------------------------------------------------
		 ;; If there is no listing of bindings for this case...
		 ((null case-info)
		  (when verbose
			(format t "~%         Case name does not exist; adding it to the case table.")
			)
		  ;; Make a new name for this case...
		  (setf safe-name (rename-case case))

		  ;; Add this case and binding to the case table.
		  (setf *x-case-table* 
			(acons case (acons bind safe-name nil)
			       *x-case-table*))

		  )

		 ;;--------------------------------------------------------
		 ;; If there is case info but no binding info ...
		 ((null safe-name)
		  (when verbose
			(format t "~%         Binding does not exist; adding new entry...")
			)
		  
		  ;; Make a new name for this case...
		  (setf safe-name (rename-case case))

		  ;; Add this case and binding to the case table.
		  (setf case-info
			(acons bind safe-name case-info))

		  (setf *x-case-table* 
			(pcons case case-info
			       *x-case-table*))
		  )
		      
		 ;;--------------------------------------------------------
		 ;; If there is case info and binding info ...
		 (t
		  (when verbose
			(format t "~%         Case name and binding exist.")
			)
		  )
		 )
		;;--------------------------------------------------------
		;; END COND
		;;--------------------------------------------------------

		;;--------------------------------------------------------
		;; Now, install the goal, case name, safe name, and
		;; binding into the goal table
		;;--------------------------------------------------------
		(push (list case 
			    safe-name 
			    (list goal)
			    bind) 
		      *x-goal-table*)
		)
	      )
	)
  *x-goal-table*
  )

;;--------------------------------------------------------------;;
;; FUNCTION simple-select-replay-cases				;;
;;--------------------------------------------------------------;;
;; NOTES: This function has been overwritten by M. Cox in file	;;
;;        x-analogy-support.lisp.				;;
;;--------------------------------------------------------------;;
;(loadtrace "~%   Defining function simple-select-replay-cases ...")
#+original
(defun simple-select-replay-cases (&key (verbose *verbose*))
  (analyze-matches       :verbose verbose)
  (assemble-replay-cases :verbose verbose)
  (setf *replay-cases* *x-goal-table*)
  )

;;--------------------------------------------------------------;;
;; VARIABLE *case-retrieval-list*				;;
;;--------------------------------------------------------------;;
;; NOTES: 							;;
;;--------------------------------------------------------------;;
(loadtrace 
	"~%   Defining variable *case-retrieval-list* ...")
(defvar *case-retrieval-list* nil)

;;--------------------------------------------------------------;;
;; FUNCTION simple-retrieval					;;
;;--------------------------------------------------------------;;
;; NOTES: This function has been overwritten by M. Cox in file	;;
;;        x-analogy-support.lisp.				;;
;;--------------------------------------------------------------;;
;(loadtrace "~%   Defining function simple-retrieval ...")
#+original.
(defun simple-retrieval (&key (prob            (current-problem))
			      (case-list       *case-retrieval-list*)
			      (match-threshold 0.6)
			      (max-goals       2)
			      (current-match   0)
			      (verbose *verbose*))

  (when case-list
	(apply #'load-case-headers case-list)
	(p4::load-problem  prob nil)
	(evaluate-similarities :prob            prob
			       :match-threshold match-threshold
			       :max-goals       max-goals
			       :current-match   current-match)
	(simple-select-replay-cases :verbose verbose)
	)
  )

;;**************************************************************;;
;; 4. Helper Functions						;;
;;**************************************************************;;
;;--------------------------------------------------------------;;
;; FUNCTION rename-case						;;
;;--------------------------------------------------------------;;
;; NOTES: Makes a safe name based on a case name (a string).	;;
;;--------------------------------------------------------------;;
(loadtrace "~%   Defining function rename-case ...")
(defun rename-case (case)
  (symbol-name (gensym (concatenate 'string (string-upcase case) ".")))) 

;;--------------------------------------------------------------;;
;; FUNCTION pcons						;;
;;--------------------------------------------------------------;;
;; NOTES: A function similar to the built-in ACONS function in	;;
;;	Common Lisp. Given an object, a value, and an a-list,	;;
;;	if the object is not present it adds a new a-list cell	;;
;;	containing the object and the value wrapped in a list.	;;
;;	If it is present, it pushes the value into the existing	;;
;;	a-list cell's list of values, if the item is new.	;;
;;								;;
;;	This is a non-destructive function.			;;
;; 
;;      [cox 26may98]
;;      Now destructive because it doesn't work on a-list copy. ;;
;;--------------------------------------------------------------;;
(loadtrace "~%   Defining function pcons ...")
(defun pcons (object value a-list &optional (test #'equal))
  (let (
	;;Removed for efficiency [cox 26may98]
;	(a-list (copy-alist a-list))
	(current-assoc (assoc object a-list :test test)))
    (cond (current-assoc
;	   (dolist (each-assoc a-list)
;		   (if (funcall test object (first each-assoc))
;		       (pushnew value (cdr each-assoc))))
	   (pushnew value (cdr (assoc object a-list :test test)))
	   a-list)
	  (t 
	   (acons object (list value) a-list))
	  )
    )
  )

;;; [cox 23may98]
;;; Many gyrations here to avoid duplicating computations.
;;;
(defun add-2-bind-list (bindings 
			value 
			a-list 
			&optional 
			(test #'equal) 
			&aux 
			old-case-name 
			(new-case-name (second (nth value *cover-matches*)))
			old-bindings
			old-bindings-subset-of-new-p
			old-minus-new
			old-minus-new-set-p
			new-minus-old
			new-minus-old-set-p
			intersection-set)
  (dolist (each-assoc a-list)
	  (setf old-case-name 
		(second 
		 (nth (first (rest each-assoc))
		      *cover-matches*)))
	  (setf old-bindings (first each-assoc))
	  (setf old-minus-new-set-p nil 
		new-minus-old-set-p nil
		intersection-set-p nil)
	  (if (equal new-case-name old-case-name)
	      (if ;; New bindings are a subset of old.
		  (and
		   (setf intersection-set                    ;Setf guaranteed
			 (intersection old-bindings bindings :test #'equal))
		   (setf old-minus-new-set-p t)              ;Setf only if previous setf non-nil
		   (setf old-minus-new 
			  (set-difference old-bindings bindings :test #'equal))
		   (setf new-minus-old-set-p t)             ;Setf only if previous setf non-nil
		   (not (setf new-minus-old 
			       (set-difference bindings old-bindings :test #'equal)))
		   )
		  (pushnew value (cdr each-assoc))
		;; Old bindings are a subset of new.
		(if (and intersection-set
			 (or (and new-minus-old-set-p
				  new-minus-old)
			     (set-difference bindings old-bindings :test #'equal))
			 (or (and old-minus-new-set-p
				  (not old-minus-new))
			     (not (set-difference old-bindings bindings :test #'equal)))
			 )
		    (and		; "And" only used to evaluate both forms
					; within the if clause.
		     (setf old-bindings-subset-of-new-p t)
		     (setf a-list 
			   (acons bindings (cons value (rest each-assoc)) a-list)))
		  ;; Bindings can be merged because no conflict exists. A
		  ;; conflict exists when one variable has different
		  ;; substitutions.
		  (if (not (intersection bindings
					 old-bindings
					 :test
					 #'(lambda (new-binding old-binding)
					     (and
					      (eq (first new-binding)
						  (first old-binding))
					      (not (equal new-binding old-binding))))))
		      (setf a-list
			    (pcons (union bindings old-bindings :test #'equal) value a-list)))))))
  (if (not old-bindings-subset-of-new-p)
      (pcons bindings value a-list)
    a-list)
  )


