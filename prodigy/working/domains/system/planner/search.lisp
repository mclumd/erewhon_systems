;;;
;;; Search control for 4.0 (based on NoLimit) 
;;;
;;; Authors: Jim Blythe, Dan Kahn, Mei Wang
;;; File Created: Feb 3 91
;;; Last Modified: October 91
;;;
;;; Notes:
;;; 
;;;

;;; $Revision: 1.11 $
;;; $Date: 1995/11/13 11:56:06 $
;;; $Author: jblythe $
;;;
;;; REVISION HISTORY
;;;
;;;  $Log: search.lisp,v $
;;; Revision 1.11  1995/11/13  11:56:06  jblythe
;;; Removed an error generated when a goal is expanded twice - that's not an error.
;;; Changed the pattern of add and deletes stored for incremental pending goals -
;;; see update-pending-goals.
;;;
;;; Revision 1.10  1995/11/12  22:08:25  jblythe
;;; Main change is to fix some parts of apply and instantiate-op that assumed all
;;; infinite type objects were numbers. Now other sorts of objects can be used.
;;; Also removed some dead code for a general clean-up.
;;;
;;; Revision 1.9  1995/10/12  14:23:10  jblythe
;;; Added protection nodes as a node type and search strategy, turned on with
;;; the variable *use-protection* (off by default). Also added the "event"
;;; macro which accepts similar syntax to operators. The new file "protect.lisp"
;;; has the protection code.
;;;
;;; Revision 1.8  1995/04/20  20:11:04  khaigh
;;; Added code to allow objects to stay the same between runs.
;;; Based on Alicia's run-same-objects2
;;;
;;; Revision 1.7  1995/04/05  16:39:38  jblythe
;;; Included some layers of changes to dealing with forall and exists
;;; goals that had been languishing in a separate file. Also added code to
;;; allow arbitrary slots of operators, that are added to the property
;;; list, and fixed a problem with optionally compiling the matching
;;; functions.
;;;
;;; Revision 1.6  1995/03/14  17:18:04  khaigh
;;; Integrated SABA into main version of prodigy.
;;; Call (set-running-mode 'saba) and
;;;      (set-running-mode 'savta)
;;;
;;; Also integrated apply-op control rules:
;;; ;;    (control-rule RULE
;;; ;;         (if...)
;;; ;;         (then select/reject applied-op <a>))
;;; ;; OR:
;;; ;;    (control-rule RULE
;;; ;;         (if (and (candidate-applicable-op (NAME <v1> <v2>...) )
;;; ;;                  (candidate-applicable-op (NAME <v1-prime> <v2-prime>...) )
;;; ;;                  (somehow-better <v1> <v1-prime>)))
;;; ;;         (then select/reject applied-op (NAME <v1> <v2> ...)))
;;; (candidate-applicable-op is in meta-predicates.lisp)
;;;
;;; Revision 1.5  1994/05/31  14:59:46  wxm
;;; the bindings for static inference rules should be computed before
;;; (top-nodes abstraction-level) is called.
;;;
;;; Revision 1.4  1994/05/30  20:56:30  jblythe
;;; Added Tony Maida's patches to have Prodigy run with CMU Lisp 16 and 17.
;;;
;;; Revision 1.3  1994/05/30  20:30:42  jblythe
;;; Added CVS headers so the revision history and descriptions are included in
;;; each changed file.
;;;


(in-package "PRODIGY4")

;;; User-callable functions are exported:

(export 'output-level)			; Sets how much to print out
(export 'run)				; Begins a run
(export '*incremental-pending-goals*)
(export '*use-protection*)

(defvar *incremental-pending-goals* nil
  "If t, pending goals are calculated incrementally, which is slightly
faster")

(defvar *running-mode* 'savta)
(defvar *apply-order-p* t
  "If non-nil, can only apply the operators in the reverse order they
were thought of.")

(defvar *use-protection* nil
  "If non-nil, we will consider protecting already-achieved goals as a
branch to the search.")

;;; Almost all the "global variables" are stored in the property list
;;; of the problem space, so look there as well.
(defvar *node-counter*)
(proclaim '(fixnum *node-counter*))

;;; See do-subgoal
(defvar *always-ignore-bad-goals* nil
  "If nil, you get a continuable error if a goal is chosen that has no
introducing operator")

;;; Later on, multiple solutions may be stored in "solution buckets",
;;; which are sets of plans that use the same operators. For this
;;; reason, please use the function abstractions given here for
;;; multiple solutions.

(defvar *all-solutions* nil
  "List of solutions when more than one is requested using the
multiple-sols flag in (run)")

(defvar *dont-ask-and-find-all* nil
  "When this is true (in the multiple-sols mode) the planner continues
searching for morw solutions without asking each time.")

(defvar *last-result-obtained* nil ; RDS 93/12/11
  "Store the last result found by the planner.  This is useful when both
:shortest is set, because the result returned is not the last result
encountered.")

(defvar *incrementally-create-objects* nil)

(defun store-solution (sol) (push sol *all-solutions*))

(defun repeated-solution-p (plan)
  (member plan *all-solutions* :test #'same-sol-p))

;;; run
;;; Description: Top level function, initializes and calls main-search.
;;; Arguments: -
;;; Returns: -
;;; Author: Jim
;;; Notes:
;;; The somewhat low default depth bound is for debugging on the
;;; blocks world - should be changed at some stage.

(defun run
  (&key (current-problem (current-problem))
	search-default
	depth-bound
	max-nodes
	time-bound
	output-level
	(permute-application-order :not-set)
	abstraction-level
	(compute-abstractions
	 (problem-space-property :compute-abstractions))
	(shortest (problem-space-property :shortest))
	(multiple-sols (problem-space-property :multiple-sols))
	same-objects)
  "This function solves the problem! (Yeah, right.)
It initialises for problem solving and then calls main-search, which
manages everything."
  (declare (special *current-problem-space* *last-result-obtained* ))

  (setf *dont-ask-and-find-all* nil);;alicia

  (setf *last-result-obtained* nil)	; RDS 93/12/11

  (setf *incrementally-create-objects* same-objects)

  ;; First check that load-domain has been called, and a problem loaded.
  (unless (problem-space-property :domain-loaded)
    (cerror "Optionally call load-domain and continue"
	    "It doesn't seem as though you called load-domain")
    (setf same-objects nil)
    (if (y-or-n-p "Call load-domain? ")
	(load-domain)
      (format t "If this breaks call (load-domain) and start again")))
  (unless current-problem
    (setf same-objects nil)
    (cerror "Load a problem and continue" "There is no specified problem.")
    (format t "Specify a file to load: (complete path please) ~%")
    (load (read-line)))

  ;; Set the value for the output level for this run.
  (if (or (and (integerp output-level)
	       (>= output-level 0)
	       (<= output-level 3))
	  (and (null (problem-space-property :*output-level*))
	       (or output-level (setf output-level 2))))
      (setf (problem-space-property :*output-level*) output-level))

  ;; Ok, we carried on, so load the new problem
  ;; (also resetting the problem space)
  (if same-objects
      (load-problem-same-objects current-problem (not compute-abstractions))
    (load-problem current-problem (not compute-abstractions)))

  ;; Now we annotate preconditions with their abstraction levels
  ;; so as to make planning at different levels faster.
  (add-abstraction-levels-to-operators *current-problem-space*)
  ;; Possible bindings are useful for events, which in many ways are
  ;; similar to eager inference rules.
  (dolist (event (problem-space-property :events))
    (setf (getf (rule-plist event) :possible-bindings)
	  (get-possible-bindings event)))
  (cond ((numberp abstraction-level))
	((numberp (abs-level))
	 (setf abstraction-level (abs-level)))
	(t;; otherwise set to highest interesting level
	 (setf abstraction-level
	       (max-abs
		(getf (rule-plist
		       (rule-name-to-rule '*finish* *current-problem-space*))
		      :annotated-preconds)))))

  (let ((done-goal (instantiate-consed-literal (list 'done))))
    
    ;; Make "done" be the top level goal
    (setf (literal-goal-p done-goal) (list :top-level-goal))

    ;; We'll set the goal node by hand (see function top-nodes).
    (setf (problem-space-expanded-goals *current-problem-space*)
	  (list done-goal)))

  ;; If there are no control rules for nodes, or if a search-method
  ;; has been explicitly requested, set up here to miss out the usual
  ;; search control and go for a (hopefully) faster version.
  (if (and (null search-default)
	   (null (problem-space-select-nodes *current-problem-space*))
	   (null (problem-space-reject-nodes *current-problem-space*))
	   (null (problem-space-prefer-nodes *current-problem-space*)))
      (setf search-default :depth-first))
  (setf (problem-space-property :search-default) search-default)

  ;; Daniel. It was not set before
  (setf (problem-space-property :multiple-sols) multiple-sols)

  ;; Jim. Changed to only set the flag if this key is used in the call.
  (unless (eq permute-application-order :not-set)
    (setf (problem-space-property :permute-application-order)
	  permute-application-order))

  ;; Use the depth-bound installed in the problem space, or default to
  ;; 100 if none.
  (if (null depth-bound)
      (setf depth-bound
	    (or (problem-space-property :depth-bound) 100)))
  
  (setf *all-solutions* nil);;it may have some from previous runs

  ;; Compute the static part of the information for eager inference
  ;; rules. Has to be computed after function top-nodes is called,
  ;; because it may need the predicates added/deleted by static-eager
  ;; inference rules. 
  ;; This should be called before (top-nodes abstraction-level) is
  ;; called. 
  (dolist (rule (problem-space-eager-inference-rules *current-problem-space*))
    (unless (static-inference-rule-p rule)
      (setf (getf (rule-plist rule) :possible-bindings)
	    (get-possible-bindings rule))))

  ;; Install the first two nodes in the path, which are the operator
  ;; and null bindings for *finish*. Then run the recursive search
  ;; the binding node as the most recently selected for attention.
  (let* ((*node-counter* 0)
	 (start-node (top-nodes abstraction-level))
	 (initial-time (get-internal-run-time)))
    (declare (special *node-counter* *prodigy-handlers*)
	     (type nexus start-node))

    (add-handlers max-nodes depth-bound time-bound)
    ;; (setf (problem-space-property :next-thing) nil)

    ;; initialise the pending goals list
    (setf *pending-goals* (list :pending-goals-head))

    ;; This signal provides a way for users to add code that gets
    ;; called at the start of any run. No data passed as yet.
    (prod-signal :start-run)
    
    ;; Ok, go for it.
    (let* ((intermediate
	    (cond ((and shortest multiple-sols)
		   ;; RDS 93/08/18.  User wants to search for shortest plan.
		   (run-shortest-multiple start-node depth-bound))
		  (shortest
		   (run-shortest start-node depth-bound))
		  (multiple-sols
		   (run-multiple-sols start-node depth-bound))
		  (t
		   (let* ((result (main-search
				   start-node start-node 2 depth-bound))
			  (plan (prepare-plan result)))
		     ;; Print the plan nicely
		     (if plan (announce-plan plan))
		     (or plan result)))))
	   (time (float (/ (- (get-internal-run-time) initial-time)
			   internal-time-units-per-second)))
	   (solutionp (solutionp intermediate *all-solutions*))
	   (solutions (if solutionp
			  (get-solutions intermediate *all-solutions*)))
	   (number-solutions (length solutions)))

      ;; Set the fields of the result structure
      (setf (user::prodigy-result-problem *prodigy-result*) current-problem)
      (setf (user::prodigy-result-time *prodigy-result*) time)
      (setf (user::prodigy-result-nodes *prodigy-result*) *node-counter*)
      (setf (user::prodigy-result-solutionp *prodigy-result*) solutionp)
      (setf (user::prodigy-result-solution *prodigy-result*)
	    (car (last solutions)))

      ;; Jim 2/94: keep the old result around so I can re-enter
      ;; planning using call-main-search
      (setf (getf (user::prodigy-result-plist *prodigy-result*)
		  :old-result)
	    intermediate)

      ;; They are reversed so that they are stored in the order in which
      ;; they were achieved
      (setf (user::prodigy-result-solutions *prodigy-result*)
	    (reverse solutions))
      (setf (user::prodigy-result-number-solutions *prodigy-result*)
	    number-solutions)
      (setf (user::prodigy-result-interrupt *prodigy-result*)
	    (car intermediate))
      (setf (user::prodigy-result-whole-tree-expanded-p *prodigy-result*)

					; Changed the following so that it works with :shortest as well.
					; RDS 93/12/11
	    ;;            (cond ((problem-space-property :multiple-sols)
	    ;;                   (not *user-aborted-search*))
	    ;;                  ((problem-space-property :shortest))))
	    (whole-tree-expanded-p
             (if shortest *last-result-obtained* intermediate)))

      ;; Cumulative data
      (incf (user::prodigy-result-acc-runs *prodigy-result*))
      (incf (user::prodigy-result-acc-time *prodigy-result*) time)
      (incf (user::prodigy-result-acc-nodes *prodigy-result*) *node-counter*)
      (incf (user::prodigy-result-acc-solutions *prodigy-result*)
	    number-solutions)
      *prodigy-result*)))

#|
;;; old version: will disappear (even from the source file) soon..
(defun run (&key (current-problem (current-problem))
	         search-default
		 depth-bound
		 max-nodes
		 time-bound
		 output-level
		 permute-application-order
		 abstraction-level
		 (compute-abstractions
		  (problem-space-property :compute-abstractions))
                 (shortest (problem-space-property :shortest))
		 (multiple-sols (problem-space-property :multiple-sols)))
  "This function solves the problem! (Yeah, right.)
It initialises for problem solving and then calls main-search, which
manages everything."
  (declare (special *current-problem-space*))

  (setf *dont-ask-and-find-all* nil) ;;alicia

  ;; First check that load-domain has been called, and a problem loaded.
  (unless (problem-space-property :domain-loaded)
    (cerror "Optionally call load-domain and continue"
	    "It doesn't seem as though you called load-domain")
    (if (y-or-n-p "Call load-domain? ")
	(load-domain)
	(format t "If this breaks call (load-domain) and start again")))
  (unless current-problem
    (cerror "Load a problem and continue" "There is no specified problem.")
    (format t "Specify a file to load:~%")
    (load (read-line)))

  ;; Set the value for the output level for this run.
  (if (or (and (integerp output-level)
	       (>= output-level 0)
	       (<= output-level 3))
	  (and (null (problem-space-property :*output-level*))
	       (or output-level (setf output-level 2))))
      (setf (problem-space-property :*output-level*) output-level))

  ;; Ok, we carried on, so load the new problem
  ;; (also resetting the problem space)
  (load-problem current-problem (not compute-abstractions))

  ;; Now we annotate preconditions with their abstraction levels
  ;; so as to make planning at different levels faster.
  (add-abstraction-levels-to-operators *current-problem-space*)
  (cond ((numberp abstraction-level))
	((numberp (abs-level))
	 (setf abstraction-level (abs-level)))
	(t;; otherwise set to highest interesting level
	 (setf abstraction-level
	       (max-abs
		(getf (rule-plist
		       (rule-name-to-rule '*finish* *current-problem-space*))
		      :annotated-preconds)))))

  (let ((done-goal (instantiate-consed-literal (list 'done))))
    
    ;; Make "done" be the top level goal
    (setf (literal-goal-p done-goal) (list :top-level-goal))

    ;; We'll set the goal node by hand (see function top-nodes).
    (setf (problem-space-expanded-goals *current-problem-space*)
	  (list done-goal)))

  ;; If there are no control rules for nodes, or if a search-method
  ;; has been explicitly requested, set up here to miss out the usual
  ;; search control and go for a (hopefully) faster version.
  (if (and (null search-default)
	   (null (problem-space-select-nodes *current-problem-space*))
	   (null (problem-space-reject-nodes *current-problem-space*))
	   (null (problem-space-prefer-nodes *current-problem-space*)))
      (setf search-default :depth-first))
  (setf (problem-space-property :search-default) search-default)

  (setf (problem-space-property :permute-application-order)
	permute-application-order)

  ;; Use the depth-bound installed in the problem space, or default to
  ;; 30 if none.
  (if (null depth-bound)
      (setf depth-bound
	    (or (problem-space-property :depth-bound) 30)))
  
  (setf *all-solutions* nil) ;;it may have some from previous runs

  ;; Install the first two nodes in the path, which are the operator
  ;; and null bindings for *finish*. Then run the recursive search
  ;; the binding node as the most recently selected for attention.
  (let* ((*node-counter* 0)
	 (start-node (top-nodes abstraction-level)))
    (declare (special *node-counter* *prodigy-handlers*)
	     (type nexus start-node))
    
  ;; Compute the static part of the information for eager inference
  ;; rules. Has to be computed after function top-nodes is called,
  ;; because it may need the predicates added/deleted by static-eager
  ;; inference rules. 
  (dolist (rule (problem-space-eager-inference-rules *current-problem-space*))
    (unless (static-inference-rule-p rule)
      (setf (getf (rule-plist rule) :possible-bindings)
	    (get-possible-bindings rule))))
>>>>>>> 1.5

    (add-handlers max-nodes depth-bound time-bound)
    ;; (setf (problem-space-property :next-thing) nil)

    ;; This signal provides a way for users to add code that gets
    ;; called at the start of any run. No data passed as yet.
    (prod-signal :start-run)
    
    ;; Ok, go for it.
    (if shortest ; RDS 93/08/18.  User wants to search for shortest plan.
        (if multiple-sols
            (run-shortest-multiple start-node depth-bound)
          (run-shortest start-node depth-bound))
      (if multiple-sols
          (run-multiple-sols start-node depth-bound)
	(let* ((result (main-search start-node start-node 2 depth-bound))
	       (plan (prepare-plan result)))
	  ;; Print the plan nicely
	  (if plan (announce-plan plan))
	  (or plan result))))))
|#

;;; Find (one of) the shortest plans.  To do this, repeatedly find plans
;;; shorter than the shortest plan found so far.  Upon eventual failure,
;;; report the shortest plan found so far, if any.
(defun run-shortest (start-node depth-bound)
  (declare (special *last-result-obtained*))
  (do* ((result (main-search start-node start-node 2 depth-bound))
        (plan (prepare-plan result) (prepare-plan result))
        (least-length nil)
        shortest-plan
        shortest-result)
       (nil)
       (setf *last-result-obtained* result)
       (cond
        ((null plan) ;Failure: was any plan found?
         (when least-length
               (format t "~%No shorter solutions found.~%")
               (announce-plan shortest-plan)
               (return (or shortest-plan shortest-result)))
         (format t "~%No solution found ~A.~%" result)
         (return result))

        (t ;Some plan found.  Save it, then try to find a shorter plan.
         (setf least-length (length (cdr plan)))
         (setf shortest-plan plan)
         (setf shortest-result result)
         (output 1 t "~%Plan found of length ~A.~%" least-length)
         (setf result (call-main-search plan :strict-shorter depth-bound))))))

;;; Called when both :shortest and :multiple-sols is set.  The user is
;;; expected to guide Prodigy towards finding the shortest plan.  Prodigy
;;; eventually returns in *all-solutions* all plans found whose lengths were
;;; minimal, discarding longer plans that were found.
(defun run-shortest-multiple (start-node depth-bound)
  (declare (special *last-result-obtained*))
  (do* ((result (main-search start-node start-node 2 depth-bound))
        (plan (prepare-plan result) (prepare-plan result))
        (least-length nil)
        answer)
       (nil)
       (setf *last-result-obtained* result)
       (cond
        ((and plan
              (or (eq answer :different)
                  (eq answer :shorter-and-diff))
              (repeated-solution-p plan))
         (setf result (call-main-search plan answer depth-bound)))

        ((null plan)
         (format t "~%No solution found ~A.~%" result)
         (store-solution result)
         (return result))

        (t
         (when (or (not least-length)
                   (< (length (cdr plan)) least-length))
    ; A plan shorter than all previous plans has been found.  Reset
    ; least-length, and lose all previous plans, as we're no longer interested
    ; in them.
               (output 1 t "~%Shorter plan of length ~A found.~%"
                       (length (cdr plan)))
               (setf *all-solutions* nil)
               (setf least-length (length (cdr plan))))
         (announce-plan plan)
         (store-solution plan)
         (setf answer (ask-for-more-solutions-shortest))
         (cond
          (answer
           (setf result (call-main-search plan answer depth-bound))
           (if (not result)
               (return)))
          (t
           (return plan)))))))

;;; Ask user how to proceed.  This is similar to ask-for-more-solutions(), but
;;; the choices won't allow longer plans to be found.
(defun ask-for-more-solutions-shortest ()
  (cond
   (*dont-ask-and-find-all*)
   (t
    (format t
            "~% Do you want to search for another solution:~%  ~
           0. No more solutions.~%  ~
           1. Only equal length or shorter solutions.~%  ~
           2. Only different solutions of shorter or eq length.~%  ~
           3. Only strictly shorter solutions.~%  ~
           4. Continue searching for all non-longer solutions without asking.~%  ~
           5. Continue searching for non-longer diff solutions without asking.~%~
           >> ")
    (let ((answer (car (read-atoms))))
      (case answer
            (0 (format t  "~% BYE, BYE!!"))
            (1 :shorter)
            (2 :shorter-and-diff)
            (3 :strict-shorter)
            (4 (setf *dont-ask-and-find-all*  :shorter))
            (5 (setf *dont-ask-and-find-all*  :shorter-and-diff))
            (t (break "set answer by hand")))))))

(defun run-multiple-sols (start-node depth-bound)
  (do* ((result (main-search start-node start-node 2 depth-bound))
	(plan (prepare-plan result)
	      (prepare-plan result))
	answer)
       (nil)
       (cond
        ((and plan			;only new solutions wanted
              (and (or (eq answer :different)
                       (eq answer :shorter-and-diff))
                   (repeated-solution-p plan)))
         (setf result (call-main-search plan answer depth-bound)))

        ;;if plan is null it means that no sol was found 
        ((null plan) 
         (format t "~%No solution found ~A.~%" result)
         (store-solution result)
         (return result))			;terminate	   

        (t ; Print the plan nicely and store it
         (announce-plan plan)
         (store-solution plan)
         ;;and search some more if required
         (setf answer (ask-for-more-solutions))
         (cond
          (answer
           (setf result (call-main-search plan answer depth-bound))
           (if (null result)
               ;;found all solutions: note that :termination-reason
               ;;will be the termination-reason of the last path, which
               ;;is a failure even when other solutions have been
               ;;found. (You can distinguish that case by checking
               ;;*all-solutions*) Is this the behaviour we want?
               (return)))
          (t ;;problem was solved, but no more solutions are needed
           (return plan)))))))		;terminate

;; call again (main-search node last-node ...) where
;;;node: node to which backtrack  (Jim says: "the node most
;;       recently selected for attention.")
;;;last-node-created: the last-node as returned by prev call to
;;;      main-search
;;;current-depth: get it from node or last-node-created (or is there
;;;     a global var for it?)
;;;depth-bound:I guess this is the initial value :depth-bound, but I
;;;can reset it here as Manuela does so the next solution is shorter 

(defun call-main-search (plan answer current-depth-bound)
  (let* ((last-node-created (cdar plan))
	 restart-node current-depth
	 ;; I don't know why but *current-depth* is 1 less
	 ;; than the depth that appears to the left of last node
	 ;; (new-depth-bound (1+ *current-depth*))
	 (new-depth-bound (1+ (compute-depth last-node-created))))
    (close-node last-node-created)
    ;;from Jim's comments in search.lisp, restart-node is
    ;;either a binding or applied-op node. Thus the decision
    ;;between subgoal or apply has to be made
    (setf restart-node
	  (choose-node last-node-created
		       (generate-nodes last-node-created)))
    (cond
      (restart-node
       (setf current-depth
	     (maintain-state-and-goals last-node-created restart-node))
       (main-search
	restart-node last-node-created current-depth
	;;set the new depth-bound (but better solutions
	;;could be longer!) so new solutions are of the
	;;same or smaller length
	(cond ((or (eq answer :shorter)
		   (eq answer :shorter-and-diff))
	       (format t "Setting new depth bound: ~A.~%"
		       new-depth-bound)
	       new-depth-bound)
	      ((eq answer :strict-shorter)
	       (format t "Setting new depth bound: ~A.~%"
		       (- new-depth-bound 3))
	       (- new-depth-bound 3))
	      (t current-depth-bound))))
      (t (format t "~%There are no more solutions.~%")))))

(defun prepare-plan (result)
  (cond ((and (consp result) (consp (car result))
	      (eq (cdar result) :achieve))
	 (cons result
	       (mapcan #'(lambda (node)
			   (nreverse
			    (mapcar #'op-application-instantiated-op
				    (a-or-b-node-applied node))))
		       (cdr (path-from-root (cdr result)
					    #'a-or-b-node-p)))))
	;; If a resource bound was exceeded, let's see if we have
	;; achieved some of the top-level conjunction. The function
	;; "prepare-partial-plan" is loaded in from /contrib
	((and (consp result) (listp (car result))
	      (eq (second (car result)) :resource-bound))
	 (if (fboundp 'prepare-partial-plan)
	     (prepare-partial-plan result)))
	 ))

(defun compute-depth (node)
  (declare (type nexus node))
  (if (nexus-parent node)
      (1+ (compute-depth (nexus-parent node)))
      1))

(defun same-sol-p (plan1 plan2)
  (every #'same-op-p (cdr plan1) (cdr plan2)))

(defun same-op-p (op1 op2)
  (declare (type instantiated-op op1 op2))
  (and (or				; test to see if ops are the same
	(eq (instantiated-op-op op1)
	    (instantiated-op-op op2))
	(eq (operator-name (instantiated-op-op op1))
	    (operator-name (instantiated-op-op op2))))
       (or				; test to see if objects are the same
	(equal (instantiated-op-values op1)
	       (instantiated-op-values op2))
	;;we need this test so the args are considered equal over diff
	;;problem runs (the objects themselves are different)
	(every #'(lambda (arg1 arg2)
		   (if (or (numberp arg1)(numberp arg2))
		       (equal arg1 arg2) ;for infinite types
		       (equal (prodigy-object-name arg1)
			      (prodigy-object-name arg2))))
	       (instantiated-op-values op1)
	       (instantiated-op-values op2)))))

;;; The next two functions (like many others) came originally from NoLimit

(defun ask-for-more-solutions ()
  (cond
    (*dont-ask-and-find-all*)
    (t
  (format t
	  "~% Do you want to search for another solution:~%  ~
           0. No more solutions.~%  ~
           1. Any other solution.~%  ~
           2. Only different solutions.~%  ~
           3. Only equal length or shorter solutions.~%  ~
           4. Only different solutions of shorter or eq length.~%  ~
           5. Only strictly shorter solutions.~%  ~
           6. Continue searching for all solutions without asking.~%  ~
           7. Continue searching for diff solutions without asking.~%~
           >> ")
  (let ((answer (car (read-atoms))))
    (case answer
      (0 (format t  "~% BYE, BYE!!"))
      (1 :any-other)
      (2 :different)
      (3 :shorter)
      (4 :shorter-and-diff)
      (5 :strict-shorter)
      (6 (setf *dont-ask-and-find-all*  :any-other))
      (7 (setf *dont-ask-and-find-all*  :different))
      (t (break "set answer by hand")))))))


;;; HANDLERS
;;;

(defun max-check (sig) (declare (ignore sig)))
(defun depth-check (sig) (declare (ignore sig)))
(defun time-check (sig) (declare (ignore sig)))

(defun add-handlers (max-nodes depth-bound time-bound)
  "Set up handlers to check termination criteria"
  (declare (ignore depth-bound)
	   (special *partial-satisfaction* *closest-to-goal*))

  (remove-prod-handler :achieve #'handle-solution)
  (define-prod-handler :achieve #'handle-solution)

  ;; This function is bound if we have loaded the code to salvage
  ;; partial plans on hitting resource bounds. This code is in
  ;; /contrib/partial-satisfaction.
  (when (and (fboundp 'maintain-best-plan))
    (remove-prod-handler :achieve-one-goal #'maintain-best-plan)
    (setf *closest-to-goal* nil)
    (when (and *partial-satisfaction*
	       (goal-is-conjunction-of-literals))
      (define-prod-handler :achieve-one-goal #'maintain-best-plan)))
    
  (remove-prod-handler :always #'max-check)
  (when (and max-nodes (numberp max-nodes))
    (eval `(defun max-check (sig)
	    (declare (ignore sig) (special *node-counter*))
	    (when (>= *node-counter* ,max-nodes)
	      (setf (problem-space-property :termination-reason)
		    :too-many-nodes)
	      (output 1 t "~%Hit node limit (~S)~%" ,max-nodes)
	      '(:stop :resource-bound :node))))
    (compile 'max-check)
    (define-prod-handler :always #'max-check))

  (remove-prod-handler :always #'time-check)
  (when (and time-bound (numberp time-bound))
    (let* ((now (get-internal-run-time))
	   (stop-time (+ now (* time-bound internal-time-units-per-second))))
      (eval `(defun time-check (sig)
	      (declare (ignore sig))
	      (let ((time (get-internal-run-time)))
		(when (>= time ,stop-time)
		  (setf (problem-space-property :termination-reason)
			:out-of-time)
		  (output 1 t "~%Out of time after ~S seconds~%"
			  (/ (- time ,now) internal-time-units-per-second))
		  '(:stop :resource-bound :time))))))
    (compile 'time-check)
    (define-prod-handler :always #'time-check)))
      

;;; top-nodes
;;; Arguments: -
;;; Returns: Binding node for *finish*
;;; Side effects: creates two new nodes.
;;; Author: Jim

(defun top-nodes (abslevel)
  (declare (special *current-problem-space*))

  ;; Let's make the first three nodes by hand to avoid firing all
  ;; those control rules on the "done" goal and *finish* operator..
  (let* ((finishvec (make-sequence 'vector (1+ abslevel)))
	 (root (make-applied-op-node
		:abs-level abslevel
		:goals-left nil
		:applied (fire-static-eager-inference-rules)))
	 (goal (make-goal-node
		:abs-level abslevel
		:goal (instantiate-consed-literal (list 'done))
		:parent root
		:introducing-operators nil
		:ops-left nil))
	 (finish-op (get-operator *finish*))
	 (finish-op-node (make-operator-node
			  :abs-level abslevel
			  :operator finish-op
			  :parent goal)))

    ;; Also fire some non-static eager inference rules.
    (fire-eager-inference-rules root)
    
    ;; Messy stuff.
    (set-node-name root)
    (setf (problem-space-property :root) root)
    (set-node-name goal)
    (set-node-name finish-op-node)
    (setf (nexus-children root) (list goal))
    (setf (nexus-children goal) (list finish-op-node))
    (initialize-expandable-nodes *current-problem-space* finish-op-node)
    (setf (problem-space-property :expandable-nodes) (list finish-op-node))
    
    ;; Store the finish operator node. We check termination by seeing
    ;; if any of these becomes applicable.
    (setf (elt finishvec abslevel) finish-op-node)
    (setf (problem-space-property :*finish-binding*) finishvec)

    ;; This vector stores pointers into the abstract plan we're
    ;; following to help backtracking between abstraction levels.
    (setf (problem-space-property :deepest-point)
	  (make-sequence 'vector (1+ abslevel)))

    ;;; Return the operator node as the one to expand next.
    (announce-node goal goal 2)
    finish-op-node))

(defun max-abs (annotated-preconds)
  "Return the highest abstraction level at which these preconditions
are interesting."
  (case (second annotated-preconds)
    ((user::and user::or)
     (apply #'max (mapcar #'max-abs (cddr annotated-preconds))))
    ((user::forall user::exists)
     (apply #'max (mapcar #'max-abs (fourth annotated-preconds))))
    (user::~
     (max-abs (caddr annotated-preconds)))
    (otherwise (car annotated-preconds))))

;;; main-search
;;; Arguments:
;;;   Node: the node most recently selected for attention.
;;; Returns:
;;; Author: Jim
;;; Comments: Directly based on Manuela's NoLimit version
;;;  The assumption is made here that the node is either a binding or
;;;  applied op node. Thus the decision whether to subgoal or apply
;;;  has to be made. Since choosing a subgoal and a new operator and
;;;  bindings is done in one call in this function, the assumption holds.

;;; Keep the last node we created and generate a path between that
;;; node and the new node in order to keep the state correct for the
;;; node we're currently at..

(defun main-search (node last-node-created current-depth depth-bound)
  "This function is the top level of the search routine."
  (declare (type nexus last-node-created)
	   (number current-depth))

  ;; I made this a simple loop because I couldn't figure out how to
  ;; force lucid to compile out the tail recursion. -- Jim
  (do ((new-node-or-failure-message node))
      (nil nil)

    ;; Expanding the node either returns a new node or some kind of
    ;; failure symbol.  First, we maintain the state.
    (cond ((and (nexus-p new-node-or-failure-message)
		(eq last-node-created node))
	   (incf current-depth))
	  ((not (eq last-node-created node))
	   (setf current-depth
		 (maintain-state-and-goals last-node-created node))))
    ;; Print out a line if required for tracing.
    (announce-node node last-node-created current-depth)

    ;; This variable is for use in control rules.
    (let ((user::*current-node* node)
	  (*current-depth* current-depth)) ; and this in printing routines
      (declare (special user::*current-node* *current-depth*))
      (setf new-node-or-failure-message
	    ;; I'd like to have this condition handled as an interrupt,
	    ;; but I can't quite see how - because it terminates this
	    ;; search node, not the whole thing.
	    (if (and depth-bound
		     (too-deep-p node current-depth depth-bound))
		(close-node node :depth-exceeded)
	      (refine-or-expand node)))

      ;; If the node has not been expanded, we try to record the
      ;; reason on the property list of the node, and comment.
      (if (typep new-node-or-failure-message 'nexus)
	  ;; Update the conspiracy numbers based on the new node.
	  (update-conspiracies-up-to-root new-node-or-failure-message)
	;; Otherwise mention failure.
	(announce-failure new-node-or-failure-message
			  node depth-bound current-depth))

      ;; Look for interrupts once per node.
      (let ((interrupt (attend-to-signals)))
	(if (eq (car interrupt) :stop)
	    (return-from main-search
	      (cons interrupt new-node-or-failure-message))

	  ;; otherwise choose the next node to expand from the list
	  ;; of possible nodes and go for it.
	  (let ((next-node
		 (choose-node
		  node
		  (generate-nodes (if (consp new-node-or-failure-message)
				      (cdr new-node-or-failure-message)
				    new-node-or-failure-message)))))

	    ;;aperez:
	    (setf (problem-space-property :expanded-operators) nil)

	    (if (typep next-node 'nexus)
		;; Set up the values for the next iteration.
		(let ((tmp node))
		  (setf node next-node
			last-node-created
			(if (nexus-p new-node-or-failure-message)
			    new-node-or-failure-message
			  tmp)))
	      (return-from main-search
		(list :fail *node-counter* next-node)))))))))

;;; I assume we are only interested in finding the solution in
;;; the depth bound given, so that if this is a goal-node I
;;; can reduce the depth bound by three, since I would need that
;;; depth to apply any operator. This ugly hack shaves a
;;; little extra fuzz out of the search tree.

(defun too-deep-p (node current-depth depth-bound)
  (declare (type nexus node)
	   (integer current-depth depth-bound))
  (> current-depth
     (- depth-bound
	(typecase node
	  (goal-node 3)
	  (operator-node 2)
	  (binding-node 1)
	  (t 0)))))

(defun refine-or-expand (node)
  (declare (type nexus node))

  (let ((choice (choose-refine-or-expand node)))
    (if (eq choice :refine)
	(refine-node node)
	(etypecase node
	  (goal-node        (expand-goal node))
	  (operator-node    (expand-operator node))
	  (binding-node     (expand-binding node))
	  (protection-node  (expand-binding-or-applied-op node))
	  (applied-op-node  (expand-binding-or-applied-op node))))))

(defun refine-node (node)
  (declare (type nexus node))

  ;; Yow! Assertions!
  (assert (> (nexus-abs-level node) 0))

  (setf (elt (problem-space-property :deepest-point)
	     (nexus-abs-level node))
	nil)
  (typecase node
    (goal-node
     ;; This is ugly - doesn't deal with the problem of a parent at
     ;; this abstraction level properly.
     (let ((subnode (make-goal-node
		     :goal (goal-node-goal node)
		     :abs-parent node
		     :abs-level (1- (nexus-abs-level node)))))
       (if (eq node (problem-space-property :next-thing))
	   (setf (problem-space-property :next-thing)
		 (nexus-winner (nexus-winner (nexus-winner node)))))
       ;; This doesn't sort out who the parent should be. 
       (set-abs-parent subnode nil node)
       subnode))
    (applied-op-node
     (let ((was-winner (nexus-winner node)))
       (cond ((eq was-winner :solution)
	      ;; If we backtrack here, then the attempt to refine the
	      ;; plan failed.
	      (close-node node :not-refineable)
	      (setf (nexus-winner node) nil)
	      (mark-up-solution node nil)
	      :not-refineable)
	     (t (error "Refining an applied op node in the middle of a
solved abstraction level - I can't deal!")))))
    (t (error "The refine stuff is still very skimpy."))))

;;; This function gets called by the interrupt handler on solving a level.
(defun handle-solution (signal)
  (declare (cons signal)
	   (special *current-depth* *choose-this-node*))

  (let ((solution-node (cdr signal)))
    (declare (type nexus solution-node))
    (announce-solution solution-node *current-depth*)
    ;; If this is the ground (zero) level we're done.
    (cond ((zerop (nexus-abs-level solution-node))
	   (cons :stop :achieve))
	  ;; Otherwise we mark up the solution path at this
	  ;; abstraction level with the "winning-child" property.
	  (t (setf (nexus-winner solution-node) :solution)
	     (let* ((first-new-node (mark-up-solution solution-node t))
		    (last-old-node
		     (if first-new-node
			 (car (nexus-abs-children
			       (nexus-parent first-new-node))))))
	       ;; Force recomputing the children of this node, and set
	       ;; it up for being chosen. This code is ugly.
	       (when last-old-node
		 (setf (a-or-b-node-goals-left last-old-node) :not-computed)
		 (setf (a-or-b-node-applicable-ops-left last-old-node)
		       :not-computed)
		 (delete-node-link last-old-node *current-problem-space*)
		 (push-previous last-old-node *current-problem-space*))
	       (setf *choose-this-node* last-old-node)
	       (unless (problem-space-property :forget-abstract-order)
		 (setf (problem-space-property :next-thing)
		       first-new-node)))))))

;;; Marks or removes the solution path, depending on the value of the
;;; UP variable, and returns the highest node along the path that does
;;; not already have an abs-child. Why? Because this is the node to
;;; start expanding at the next level.
(defun mark-up-solution (node up)
  (declare (type nexus node))
  (let ((parent (nexus-parent node)))
    (when parent
      (setf (nexus-winner parent)
	    (if up node nil))
      (or (mark-up-solution parent up)
	  (unless (nexus-abs-children node) node)))))

(defun print-true-literals ()
  (print-literals-satisfying
   #'(lambda (x) (literal-state-p x))))

(defun print-impossible-goals ()
  (format t "These are impossible to make true:~%")
  (print-literals-satisfying
   #'(lambda (x) (and (not (literal-state-p x))
		      (getf (literal-plist x) :unsolvable-true))))
  (format t "These are impossible to make false:~%")
  (print-literals-satisfying
   #'(lambda (x) (and (literal-state-p x)
		      (get (literal-plist x) :unsolvable-false)))))

(defun print-literals-satisfying (test)
  (declare (special *current-problem-space*))

  (maphash #'(lambda (key1 value1)
	       (declare (ignore key1))
	       (if (hash-table-p value1)
		   (maphash #'(lambda (key2 assertion)
				(declare (ignore key2))
				(if (funcall test assertion)
				    (print assertion)))
			    value1)
		   (dolist (assertion value1)
		     (if (funcall test assertion)
			 (print assertion)))))
	   (problem-space-assertion-hash *current-problem-space*)))


;;; compute expanded-goals of a node.
;;; author Mei, March 14
(defun compute-expanded-goals (node)
  (declare (type nexus node)
	   (special *current-problem-space*))
  (setf (problem-space-expanded-goals *current-problem-space*) nil)
  (dolist (temp-node (path-from-root
		      node #'(lambda (n) (not (operator-node-p n)))))
    ;; this test was slightly bogus - the same goal may be expanded
    ;; more than once, I really need to test for goal-loops, but I
    ;; already remove them.
    (typecase temp-node
      (goal-node 
       (if (goal-node-goal temp-node)
	   (unless (member (goal-node-goal temp-node)
			   (problem-space-expanded-goals *current-problem-space*))
	     (push (goal-node-goal temp-node)
		   (problem-space-expanded-goals *current-problem-space*)))))
      (a-or-b-node
       (dolist (application (a-or-b-node-applied temp-node))
	 (close-goals (op-application-delta-adds application))
	 (close-goals (op-application-delta-dels application))))
      (t))))

(defun close-goals (literals)
  (declare (list literals)
	   (special *current-problem-space*))
  (dolist (literal literals)
    (setf (problem-space-expanded-goals *current-problem-space*)
	  (delete literal (problem-space-expanded-goals
			   *current-problem-space*)))))

(defun maintain-state-and-goals (last-node this-node)
  (declare (type nexus last-node this-node))
  "Maintain state and goal field of literals"

  ;; the common parent is the last node in the two lists that is the
  ;; same. So walk through the two lists while they are the same.  To
  ;; speed things up, only mention applied operator or binding nodes
  ;; in the path.
  (multiple-value-bind (this-node-path this-depth)
      (path-from-root this-node)
    (do ((last-path (path-from-root last-node) (cdr last-path))
	 (this-path this-node-path (cdr this-path)))

	((or (null last-path)
	     (not (eq (car last-path) (car this-path))))

         ;; Unzip backwards from what's left in the path for the last node.
	 (dolist (node (reverse last-path))

	   ;; If it's a goal or applied op node we might change the
	   ;; pointer into the more abstract plan.
	   (if (and (problem-space-property :next-thing)
		    (or (applied-op-node-p node) (goal-node-p node))
		    (nexus-abs-parent node))
	       (setf (problem-space-property :next-thing)
		     (nexus-abs-parent node)))

	   ;; We must undo the state and also
	   ;; re-set the goals that this node undid.
	   (cond ((protection-node-p node)
		  (let* ((instop (protection-node-instantiated-op
				  node))
			 (bnode
			  (instantiated-op-binding-node-back-pointer
			   instop)))
		    (setf (instantiated-op-precond instop)
			  (protection-node-old-preconds node))
		    (setf (binding-node-instantiated-preconds bnode)
			  (protection-node-old-preconds node))
		    (setf (binding-node-disjunction-path bnode)
			  (protection-node-old-disjunction-path node))
		    (dolist (added-goal (protection-node-new-goals
					 node))
		      (if (literal-p added-goal)
			  (setf (literal-goal-p added-goal)
				(delete instop (literal-goal-p
						added-goal)))
			(setf (literal-neg-goal-p (second added-goal))
			      (delete instop (literal-neg-goal-p
					      (second added-goal))))))))
		 ((a-or-b-node-p node)
		  (if *incremental-pending-goals*
		      (reverse-pending-goals node))
		  (dolist (application (a-or-b-node-applied node))
		    (do-state application nil) ; that means "undo" state
		    (let ((instop (op-application-instantiated-op
				   application)))
		      (if (instantiated-op-binding-node-back-pointer instop)
			  (set-goals instop))))))
	   (if (binding-node-p node)
	       (delete-instantiated-op-from-literals
		(binding-node-instantiated-op node))))

         ;; Then maintain state and goals for all the ones in the path to this
	 ;; node.
	 (dolist (node this-path)
	   (let ((next (problem-space-property :next-thing)))
	     (if (and next
		      (goal-node-p node)
		      (eq (nexus-abs-parent node) next))
		 (setf (problem-space-property :next-thing)
		       (nexus-winner (nexus-winner (nexus-winner next)))))
	       
	     (cond ((protection-node-p node)
		    (let* ((instop (protection-node-instantiated-op
				  node))
			 (bnode
			  (instantiated-op-binding-node-back-pointer
			   instop)))
		    (setf (instantiated-op-precond instop)
			  (protection-node-new-preconds node))
		    (setf (binding-node-instantiated-preconds bnode)
			  (protection-node-new-preconds node))
		    (setf (binding-node-disjunction-path bnode)
			  (protection-node-new-disjunction-path node))
		    (dolist (added-goal (protection-node-new-goals
					 node))
		      (if (literal-p added-goal)
			  (push instop (literal-goal-p added-goal))
			(push instop (literal-neg-goal-p
				      (second added-goal)))))))
		   ((a-or-b-node-p node)
		    (dolist (application (a-or-b-node-applied node))
		      (do-state application t))
		    (if *incremental-pending-goals*
			(redo-delta-pending-goals node))
		    (if (and next (applied-op-node-p node)
			     (eq (nexus-abs-parent node) next))
			(setf (problem-space-property :next-thing)
			      (nexus-winner next)))
		    ;; Do up the goals for binding nodes
		    (if (binding-node-p node)
			(set-goals (binding-node-instantiated-op node)))))))
	 
	 ;; added by Mei, march 14
	 ;; compute expanded-goals of the node.
	 (compute-expanded-goals this-node)

         ;; Return the depth of this-node
	 this-depth))))

(defun set-goals (instop)
  (declare (type instantiated-op instop))
  "Set up the goals from the preconditions of this operator."

  (let* ((binding-node (instantiated-op-binding-node-back-pointer instop))
	 (inst-precond-exp
	 (binding-node-instantiated-preconds binding-node))
	 (disjunction-path (binding-node-disjunction-path binding-node))
	 (operator (instantiated-op-op instop))
	(precond-exp (third (rule-precond-exp operator)))
	(values (instantiated-op-values instop))
	(vars (rule-vars operator)))

    ;; Use the instantiated preconds if they're there, otherwise preconds.
    (cond (inst-precond-exp
	   (set-goals-inst
	    inst-precond-exp disjunction-path t instop operator
	    (mapcar #'(lambda (var val) (cons var val))
		    vars values)))
	  (precond-exp
	   (set-goals-exp precond-exp values vars t instop)))))

(defun set-goals-inst (exp disjunction-path parity instop operator bindings)
  (cond ((typep exp 'literal)
	 (if parity
	     (push-goal exp instop)
	     (push-neg-goal exp instop)))
	((eq (car exp) 'user::and)
	 ;;aperez
	 ;;if disj is nil, set-goals-inst is not called at all. It should
	 ;;have as many elements as (cdr exp) (same as in penders-rec
         ;;of matcher-interface.lisp)
	 (if (null disjunction-path)
	     (mapc #'(lambda (bit)
		       (set-goals-inst bit disjunction-path parity
				       instop operator bindings)) 
		   (cdr exp))
	     (mapc #'(lambda (bit disj)
		       (set-goals-inst bit disj parity instop operator bindings))
		   (cdr exp) disjunction-path)))
	((eq (car exp) 'user::or)
	 (set-goals-inst (elt exp (car disjunction-path))
			 (cdr disjunction-path)
			 parity instop operator bindings))
	((eq (car exp) 'user::~)
	 (set-goals-inst (second exp) disjunction-path (not parity) instop
			 operator bindings))
	((eq (car exp) (if parity 'user::forall 'user::exists))
	 (set-goals-forall exp disjunction-path parity instop operator  bindings))
	((member (car exp) '(user::exists user::forall))
	 (set-goals-inst (third exp) disjunction-path parity instop
			 operator bindings))
	(t
	 (let ((lit (instantiate-consed-literal (sublis bindings exp))))
	   (if parity
	       (push-goal lit instop)
	       (push-neg-goal lit instop))))))
#|
(defun set-goals-forall (exp disj parity instop operator bindings)
  (do* ((test (cdr (assoc (second exp)
		     (getf (rule-plist operator) :quantifier-generators))))
	(data (if test (funcall test nil)))
	(choice (make-list (length data) :initial-element 0)
		(increment-choice choice data)))
       ((null choice))
    (set-goals-inst (third exp) disj parity instop operator
		    (nconc (choice-bindings exp data choice)
			   bindings))))
|#


;; adding a hack so that it is much faster in a forall case such as:
;; (forall ((<x> path) (<b> path)) (~ (pred <a> <b>))) (Mei)
(defun set-goals-forall (exp disj parity instop operator bindings)
  (let ((expr (third exp)))
    ;; The first clause is the hack added by Mei.
    (if (or (and parity (eq (car expr) 'user::~) (eq (car exp) 'user::forall))
	    (and (not parity) (not (eq (car expr) 'user::~))
		 (eq (car exp) 'user::exists)))
	(let* ((real-expr (if parity (second expr) expr))
	       (forall-bindings (descend-match real-expr nil bindings))
	       (res nil))
	  (dolist (bind forall-bindings res)
	    (when (runtime-check-type-and-function-forall bind exp)
              ;; my change is here - nil was (not parity) - Jim Apr 5 95
; 	      (set-goals-inst real-expr disj (not parity) instop
;			      operator bind)
	      (set-goals-inst real-expr disj nil instop
			      operator bind))))

	(do* ((test (cdr (assoc (second exp)
				(getf (rule-plist operator)
				      :quantifier-generators))))
	      (vars (mapcar #'car (second exp)))
	      (static-data (if test (funcall test nil)))
	      (running-data
	       (first-valid-choice static-data vars bindings (second exp))
	       (next-valid-choice static-data
				  (first running-data)
				  (second running-data) 0
				  vars bindings (second exp)))
	      (choice (first running-data)
		      (first running-data))
	      ;;alicia: use true-bindings-p because calc-choices only
	      ;;checks the fns of infinite types, and not the ones foe
	      ;;other vars (similar to old-check-applicable-forall)
	      ;;ask Jim: it may be more efficient to add this into
	      ;;calc-choices (Inf type fns are probably called again here)
	      ;;(fcs (get-all-functions-forall exp))
	      (data (second running-data) (second running-data))
	      ;;(valid-bnds-p
	      ;;(true-bindings-p exp data choice bindings fcs)
	      ;;(true-bindings-p exp data choice bindings fcs))
	      )
	     ((null choice))
	    (set-goals-inst (third exp) disj parity instop operator
			    (nconc (choice-bindings
				    exp (second running-data)
				    choice)
				   bindings))))))
  
(defun runtime-check-type-and-function-forall (bindings precond)
  (let ((specs (second precond)))
    (or (eq bindings t)
	(dolist (var bindings t)
	  (let* ((spec (assoc (car var) specs))
		 (candidate-types (candidate-types (second spec))))
	    (unless ;;aperez
		    ;;here I should avoid to have candidate-types =
		    ;(nil) because nil is a function, but it does not
		    ;work here. That happens when one of the bindings
		    ;is not a variable in the precond param list
#| old code:		
		(if (functionp (car candidate-types))
		    (some #'(lambda (f) (apply f (list (cdr var))))
			  candidate-types)
		  (or (member (prodigy-object-type (cdr var)) candidate-types)
		      (some-child-type-p (prodigy-object-type (cdr var))
					 candidate-types)))
|#
                (cond
		 ((null (car candidate-types))) ;the check fails
		 ((functionp (car candidate-types))
		  (some #'(lambda (f) (apply f (list (cdr var))))
			candidate-types))
		 ((or (member (prodigy-object-type (cdr var)) candidate-types)
		      (some-child-type-p (prodigy-object-type (cdr var))
					 candidate-types))))
	      (return-from runtime-check-type-and-function-forall nil)))))))
  

(defun set-goals-exp (exp values vars parity instop)
  (cond ((null exp))
	((eq (car exp) 'user::and)
	 (dolist (subexp (cdr exp))
		  (set-goals-exp subexp values vars parity instop)))
	((eq (car exp) 'user::~)
	 (if (listp (second exp))
	     (set-goals-exp (second exp) values vars (not parity) instop)
	     (set-goals-literal (second exp) values vars (not parity) instop)))
	((member (car exp) '(user::or user::exists user::forall))
	 (error "~%Precondition expression too complicated."))
	(t
	 (set-goals-literal exp values vars parity instop))))

(defun set-goals-literal (exp values vars parity instop)
  (let ((literal
	 (instantiate-literal (car exp)
			      (dans-substitute-bindings (cdr exp)
							vars values))))
    (if parity
	(push-goal literal instop)
	(push-neg-goal literal instop))))

;;; running-data contains the actual possibilities for some of the
;;; infinite types, since they depend on the current choices for
;;; previous variables in the forall list. running-data is a list
;;; whose first element is the choice, as a list of indices into the
;;; lists, and whose second element is the list of possibilities. This
;;; function gives the next choice if there is one, updating the list
;;; of possibilities for infinite types if it backtracks over the
;;; previous choices that led to the current list.
;;; i is the index of the variable currently being considered.
(defun first-valid-choice (static-data vars bindings val-specs)
  (next-valid-choice
   static-data (make-list (length static-data) :initial-element -1)
   (make-list (length static-data)) 0 vars bindings val-specs))

(defun next-valid-choice (static-data choice dynamic-data i vars bindings
				      val-specs)
  (if (>= i (length choice))
      (return-from next-valid-choice nil))
  (let (tail-data
	(this-var (elt vars i))
	(the-end (= i (1- (length choice)))))
    ;; If this choice is -1, check there are valid possibilities here,
    ;; otherwise backtrack.
    (cond ((eq (elt choice i) -1)
	   (let ((choices-here
		  (calc-choices static-data dynamic-data choice i
				bindings val-specs))) 
	     (setf (elt dynamic-data i) choices-here)
	     (if choices-here
		 (do* ((new-choice 0 (1+ new-choice))
		       (new-data
			(next-valid-choice
			 static-data choice dynamic-data (1+ i) vars
			 (cons (cons this-var (elt choices-here new-choice))
			       bindings) val-specs)
			(next-valid-choice
			 static-data choice dynamic-data (1+ i) vars
			 (cons (cons this-var (elt choices-here new-choice))
			       bindings) val-specs)))
		      ((or new-data the-end
			   (= new-choice (1- (length choices-here))))
		       (if (or new-data the-end)
			   (list (cons 0 (first new-data))
				 dynamic-data)))))))
	  ;; try to increment the later elements first.
	  ((setf tail-data
		 (next-valid-choice
		  static-data choice dynamic-data (1+ i) vars
		  (cons (cons this-var (elt (elt dynamic-data i)
					    (elt choice i)))
			bindings) val-specs))
	   
	   (list (cons (elt choice i) (first tail-data))
		 ;;aperez May 28 94
		 ;(cons (car choice) (first tail-data))
		 dynamic-data))
	  ;; If that doesn't work, increment this choice and reset the
	  ;; remaining choices and data. You might have to increment
	  ;; by more than one to get consistent choices for the rest.
	  
	  (;(< (car choice) (1- (length (elt dynamic-data i))))
	   ;;aperez: above check doesn't make sense (not checking
	   ;; choice element with corresponding data)
	   (< (elt choice i) (1- (length (elt dynamic-data i))))
	   (do* ((new-choice (1+ (elt choice i)) (1+ new-choice))
		 (new-data
		  (next-valid-choice
		   static-data (reset-choice choice i)
		   dynamic-data (1+ i) vars
		   (cons (cons this-var (elt (elt dynamic-data i)
					     new-choice))
			 bindings) val-specs)
		  (next-valid-choice
		   static-data (reset-choice choice i)
		   dynamic-data (1+ i) vars
		   (cons (cons this-var (elt (elt dynamic-data i)
					     new-choice))
			 bindings) val-specs)))
		((or new-data the-end
		     (= new-choice (1- (length (elt dynamic-data i)))))
		 (if (or new-data the-end)
		     (list (cons new-choice (first new-data))
			   dynamic-data))))))))

;;; Take a list of choices and an index. Increment the index and set
;;; all subsequent choices to -1 (meaning re-evaluate the data if nec).
;;; This is destructive on the choice list (that's ok).
(defun reset-choice (choice i)
  (incf (elt choice i))
  (dotimes (j (- (length choice) i 1))
    (setf (elt choice (+ i j 1)) -1))
  choice)

;;; Based on the choices for the previous variables, apply the
;;; generator functions to get the values for the variables of
;;; infinite types. For finite types, filter the values from the
;;; static-data through the functions in the val-specs list, if any.
;;; An infinite val-spec has the form
;;; (:inf <var> (and TYPE GENERATOR1 GEN2 ..) list-of-other-vars)
;;; This function will make unnecessary recalculations, since it isn't
;;; smart about dependencies. Such is life.
(defun calc-choices (static-data dynamic-data choice i bindings val-specs)
  (let ((spec (elt static-data i))
	(var (first (elt val-specs i))))
    (if (eq (car spec) :inf)
	(let* ((first-gen (third (third spec)))
	       (other-gens (cdddr (third spec)))
	       (candidates (apply (car first-gen)
				  (sublis bindings (cdr first-gen)))))
	  (dolist (func other-gens)
	    (setf candidates
		  (mapcan
		   #'(lambda (cand)
		       (if (apply (car func)
				  (sublis (cons (cons var cand) bindings)
					  (cdr func)))
			   (list cand)))
		   candidates)))
	  candidates)
	(let ((type-spec (second (elt val-specs i))))
	  ;; If it's a list, assume it's of type (and TYPE f1 f2..)
	  (if (listp type-spec)
	      (dolist (func (cddr type-spec) spec)
		(setf spec
		      (mapcan
		       #'(lambda (cand)
			   ;;only cares whether function returns true
			   ;;or nil (can't be a generator)
			   (if (apply (car func)
				      ;;bindings: other vars in op (not in
				      ;;forall) + forall vars upto i
				      (sublis (cons (cons var cand) bindings)
					      (cdr func)))
			       (list cand)))
		       spec)))
	      spec)))))



;;; Made a multiple-value function in order to keep track of depth as
;;; well as state. Returns the path consisting of just those nodes
;;; that pass test-lambda, and the depth of all the nodes.
(defun path-from-root (node &optional (test-expr t))
  (declare (type nexus node))
  "Find the path from the root to this node in nodes that satisfy the
optional lambda expression (defaults to all nodes)."

  (do ((nd node (nexus-parent nd))
       (depth 0 (1+ depth))
       (result nil))
      ((null nd) (values result depth))
    (if (or (eq test-expr t) (funcall test-expr nd))
	(push nd result))))

;;;===========================================
;;; Functions for expanding search nodes
;;;===========================================

(defun expand-goal (node)
  "Expand a goal node in the search tree to produce an operator node."

  (let* ((goal (goal-node-goal node))
	 (poss-ops (cache goal-node-ops-left node
			  (generate-operators node goal)))
	 chosen-op op-node)
    
    (cond ((eq poss-ops :big-lose)
	   ;; This goal can never be solved - there are no operators.
	   ;; Mark the goal as unsolvable, close off all the nodes that
	   ;; require it.
	   (setf (getf (literal-plist goal)
		       (if (negated-goal-p goal)
			   :unsolvable-false
			   :unsolvable-true))
		 t)
	   (close-node node :no-op))
	  
	  ;; If it's still empty, close the node. Else proceed.
	  ((null poss-ops) (close-node node :no-op))

	  ;; If there's no chosen operator, we fail at this node,
	  ((null (setf chosen-op (choose-operator node poss-ops)))
	   :no-op)

	  ;; If there's a chosen operator, make the node for it and
	  ;; forward test for goal loops (see below).
	  (t
	   (setf op-node
		 (make-operator-node
		  :operator chosen-op
		  :parent   node
		  :abs-level (nexus-abs-level node)))
	   ;; Delete this choice from the parent of the new node
	   (setf (goal-node-ops-left node)
		 (delete chosen-op (goal-node-ops-left node)))
	   (if (null (goal-node-ops-left node))
	       (close-node node :exhausted))

	   ;; Mark in abstraction parentage if relevant. See the
	   ;; comment in get-all-ops about fudging the operator.
	   (let* ((abs (nexus-abs-parent node))
		  (winner (if abs (nexus-winner abs))))
	     (if (and winner (eq chosen-op
				 (operator-node-operator winner)))
		 (set-abs-parent op-node node winner)
		 (do-book-keeping op-node node)
		 )

	     (when (eq (operator-name chosen-op) '*finish*)
	       (setf (elt (problem-space-property :*finish-binding*)
			  (nexus-abs-level node))
		     op-node)))
		 
	   op-node))))

(defun operator-causes-goal-loop (preconds node)
  (and preconds
       (catch 'not-a-loop
	 (mapcan #'(lambda (expr)
		     (or (expr-causes-goal-loop expr (nexus-parent node))
			 (throw 'not-a-loop nil)))
		 preconds))))

(defun expr-causes-goal-loop (expr node)
  (let ((goal-to-solve (goal-node-goal node)))
    (cond ((operator-goal-will-loop-p goal-to-solve expr t)
	   (list node))
	  ((goal-node-introducing-operators node)
	   (catch 'not-a-loop
	     (mapcan #'(lambda (bn)
			 (or (expr-causes-goal-loop
			      expr (nexus-parent (nexus-parent bn)))
			     (throw 'not-a-loop nil)))
		     (goal-node-introducing-operators node)))))))

(defun operator-goal-will-loop-p (goal expr parity)
  (cond ((null expr) nil)
	((eq goal expr)
	 (if (negated-goal-p goal) (not parity) parity))
	((typep expr 'literal) nil)
	((eq (car expr) (if parity 'user::and 'user::or))
	 (some #'(lambda (x)
		   (operator-goal-will-loop-p goal x parity))
	       (cdr expr)))
	((eq (car expr) 'user::~)
	 (operator-goal-will-loop-p goal (second expr) (not parity)))))

;;; Unify the preconditions with the goal. Used for early goal loop
;;; checking with the operator. This uses the same code as
;;; get-all-bindings to generate, and as is compiled in the
;;; load-domain stage to type-check.
(defun regress-preconds (op goal)
  (declare (type literal goal)
	   (type rule op))
  (let ((res nil))
    (dolist (postcond (if (negated-goal-p goal)
			  (rule-del-list op)
			  (rule-add-list op)))
      (dolist (effect postcond)
	;; For a first try, I'm ignoring conditions of conditional effects.
	(let* ((bindings (car (find-rhs-bindings effect goal)))
	       (regressed (if (and bindings (runtime-type-check bindings op))
			      (sublis (if (eq bindings t) nil bindings)
				      (copy-tree
				       (third (rule-precond-exp op)))))))
	  ;; Dontcha hate nested if's?
	  (when regressed
	    (if (listp regressed)
		(if (member (car regressed)
			    '(user::and user::or user::~ user::forall user::exists))
		    (deep-replace-literals regressed)
		    (if (catch 'not-a-literal
			  (dotimes (index (length (cdr regressed)) t)
			    (or
			     (and (not (strong-is-var-p
					(elt (cdr regressed) index)))
				  (setf (elt (cdr regressed) index)
					(make-real-object
					 (elt (cdr regressed) index)
					 *current-problem-space*)))
			     (throw 'not-a-literal nil))))
			(setf regressed
			      (instantiate-literal
			       (car regressed) (cdr regressed))))))
	    (push regressed res)))))
    res))

;;; History: I (Jim) changed this to check infinite types
;;; on Jan 23 92. It assumes that if the first "candidate type"
;;; is a function, that they all will be and that one should return
;;; true on the object. Thus it ignores the generator and so is over-general.
;;; You have been warned (well, only if you read comments).
(defun runtime-type-check (bindings op)
  (or (eq bindings t)
      (dolist (var bindings t)
	(let* ((spec (or (assoc (car var) (second (rule-precond-exp op)))
			 (assoc (car var) (second (rule-effects op)))
			 (some #'(lambda (effect)
				   (and (eq (car effect) 'user::forall)
					(assoc (car var) (second effect))))
			       (third (rule-effects op)))))
	       (candidate-types (candidate-types (second spec))))
	  (unless
	      (if (functionp (car candidate-types))
		  (some #'(lambda (f) (apply f (list (cdr var))))
			candidate-types)
		  (or (member (prodigy-object-type (cdr var)) candidate-types)
		      (some-child-type-p (prodigy-object-type (cdr var))
					 candidate-types)))
	    (return-from runtime-type-check nil))))))

;;; Assumes argument is a list whose first element is one of the 5
;;; logical expressions.
(defun deep-replace-literals (expr)
  (do ((i (if (member (car expr) '(user::and user::or user::~)) 1 2) (1+ i)))
      ((= i (length expr)))
    (let ((subexp (elt expr i)))
      (cond ((member (car subexp)
		     '(user::and user::or user::~ user::forall user::exists))
	     (deep-replace-literals subexp))
	    ((catch 'not-a-literal
	       (dotimes (index (length (cdr subexp)) t)
		 (or
		  (and (not (strong-is-var-p
			     (elt (cdr subexp) index)))
		       (setf (elt (cdr subexp) index)
			     (make-real-object
			      (elt (cdr subexp) index)
			      *current-problem-space*)))
		  (throw 'not-a-literal nil))))
	     (setf (elt expr i)
		   (instantiate-literal
		    (car subexp) (cdr subexp))))))))
      
(defun expand-operator (node)
  (declare (type operator-node node))
  "Expand a chosen operator node, ie with bindings."

  (let ((goal (goal-node-goal (nexus-parent node)))
	(op (operator-node-operator node))
	regressed loop-top)

    ;; If this is the first time at this node, we check the old goal
    ;; loop thing.
    (cond ((and (eq (operator-node-bindings-left node) :not-computed)
		;; Calculate the regressed goal expressions - made by
		;; unifying the goal with the relevant effects of the
		;; operator. There may be more than one relevant effect.
		;; This is the first step to passing not-fully-instantiated
		;; goals around, and allows one obvious optimisation -
		;; checking for goal loops before doing the bindings in
		;; full. So we go for it.
		(null (setf (getf (nexus-plist node) :regressed-preconds)
			    (setf regressed (regress-preconds op goal))))
		(not (zerop (length (literal-arguments goal)))))
	   (close-node node :no-good-bindings))

	  ;; Well ok, we wait and check there are decent choices first.
	  ((and (eq (operator-node-bindings-left node) :not-computed)
		(setf loop-top
		      (operator-causes-goal-loop regressed node)))
	   (close-node node (cons :causes-goal-loop loop-top)))

	  ;; This is to keep me sane.
	  (t (really-expand-operator node)))))

(defun really-expand-operator (node)
  (declare (type operator-node node))

  (let ((poss-bindings
	 (cache operator-node-bindings-left node
		(generate-bindings node
				   (goal-node-goal (operator-node-parent node))
				   (operator-node-operator node))))
	chosen-binding
	(*abslevel* (nexus-abs-level node)))
    (declare (special *abslevel*))
    
    (cond ((null poss-bindings)
	   (close-node node :no-binding-choices))

	  ;; If there is a chosen binding, wallop the node in for the
	  ;; next available disjunct choice.
	  ;; next-disjunct is the function that sets the
	  ;; goal-p or neg-goal-p field of the literals.
	  ((setf chosen-binding (choose-binding node poss-bindings))
	   (let* ((inst-prec (or (instantiated-op-precond chosen-binding)
				 (build-instantiated-precond
				  chosen-binding *abslevel*)))
		  (binding-node
		   (make-binding-node
		    :parent node
		    :abs-level *abslevel*
		    :instantiated-op chosen-binding
		    :instantiated-preconds inst-prec
		    :disjunction-path
		    (next-disjunct node inst-prec chosen-binding))))
	     (setf (instantiated-op-binding-node-back-pointer chosen-binding)
		   binding-node)
	     (set-goals chosen-binding)
	     (when *incremental-pending-goals*
	       (get-delta-pending-goals binding-node)
	       (setf (binding-node-pending-goals binding-node)
		     (copy-list (cdr *pending-goals*))))
	     (if (last-disjunct-p (binding-node-disjunction-path binding-node)
				  inst-prec)
		 (setf (operator-node-bindings-left node)
		       (delete chosen-binding
			       (operator-node-bindings-left node))))
	     (if (null (operator-node-bindings-left node))
		 (close-node node :exhausted))
	     (let* ((abs (nexus-abs-parent node))
		    (winner (if abs (nexus-winner abs)))
		    (winner-binding (if winner
					(binding-node-instantiated-op winner))))
	       (if (and winner
			(eq (instantiated-op-op chosen-binding)
			    (instantiated-op-op winner-binding))
			(eq (instantiated-op-values chosen-binding)
			    (instantiated-op-values winner-binding)))
		   (set-abs-parent binding-node node winner)
		   (do-book-keeping binding-node node)
		   ))
	     ;; We have different conspiracy number information for
	     ;; these nodes.
	     (setf (nexus-conspiracy-number binding-node)
		   (instantiated-op-conspiracy chosen-binding))
	     binding-node))

	  (t :no-chosen-binding))))

(defun last-disjunct-p (choice inst-preconds)
  (declare (list choice))
  (last-choice-r choice inst-preconds t))

(defun last-choice-r (choice expr parity)
  (cond
    ((not (listp expr)) t)
    ((eq (car expr) (if parity 'user::and 'user::or))
     (every #'(lambda (sub-choice sub-expr)
		(last-choice-r sub-choice sub-expr parity))
	    choice (cdr expr)))
    ((eq (car expr) (if parity 'user::or 'user::and))
     (and (= (car choice) (length (cdr expr)))
	  (last-choice-r (cdr choice) (car (last expr)) parity)))
    ((eq (car expr) 'user::~)
     (last-choice-r choice (second expr) (not parity)))
    (t t)))

;;; Bugs: doesn't really deal with nested disjuncts where the inner
;;; ones are included in existentials: eg (or a (forall (X) (or b
;;; c))). Here you should be able to take a different branch with each
;;; element that matches the forall type. I treat all existentials as
;;; atomic.
(defun next-disjunct (node inst-preconds binding)
  "Return the next disjunct of an operator for this binding."
  (declare (type operator-node node)
	   (type instantiated-op binding))
  (let ((last-disjunct (find binding (nexus-children node)
			     :key #'binding-node-instantiated-op)))
    ;; The most recent node is assumed to be the last. No other
    ;; function should permute the order of the children.
    ;; We generate the next path by finding the last possible choice
    ;; point we could increment.
    (if last-disjunct
	(next-disjunct-r inst-preconds
			 (binding-node-disjunction-path last-disjunct) t)
	(first-path inst-preconds t))))

(defun first-path (expr parity)
  "The disjunct path taking the first branch down every \"or\""
  (cond
    ((not (listp expr)) nil)
    ((eq (car expr) (if parity 'user::or 'user::and))
     (cons 1 (first-path (second expr) parity)))
    ((eq (car expr) (if parity 'user::and 'user::or))
     (mapcar #'(lambda (conjunct) (first-path conjunct parity))
	     (cdr expr)))
    ((eq (car expr) 'user::~)
     (first-path (second expr) (not parity)))
    (t nil)))

(defun next-disjunct-r (expr last-disjunct parity)
  "Return the next choice point for the disjunct."
  (declare (special last-disjunct))

  ;; Strategy: we try to stay on the same path and increment a later
  ;; decision, if that fails, we increment this one (taking the first
  ;; choice at all subsequent choice points) and if that fails
  ;; we fail. I assume that this is not that last possible disjunct
  ;; (that was tested the last time this disjunct was expanded).
  (cond
    ((not (listp expr)) nil)
    ((member (car expr) '(user::forall user::exists)) nil)
    ((not last-disjunct)
     (if (and (eq (car expr) (if parity 'user::or 'user::and))
	      (< (car last-disjunct) (1- (length expr))))
	 (cons (1+ (car last-disjunct))
	       (first-path (elt expr (1+ (car last-disjunct))) parity))))
    ((eq (car expr) 'user::~)
     (next-disjunct-r (second expr) last-disjunct (not parity)))
    ((eq (car expr) (if parity 'user::or 'user::and))
     (let ((incremented-tail
	    (next-disjunct-r (elt expr (car last-disjunct))
			     (cdr last-disjunct) parity)))
       (if incremented-tail
	   (cons (car last-disjunct) incremented-tail)
	   (if (not (last-choice-r last-disjunct expr parity))
	       (cons (1+ (car last-disjunct)) (cdr last-disjunct))))))
    ((eq (car expr) (if parity 'user::and 'user::or))
     (do* ((conjunct (1- (length expr)) (1- conjunct))
	   (incremented-conjunct
	    (next-disjunct-r (elt expr conjunct)
			     (elt last-disjunct (1- conjunct))
			     parity)
	    (next-disjunct-r (elt expr conjunct)
			     (elt last-disjunct (1- conjunct))
			     parity)))
	  ((or incremented-conjunct (= conjunct 1))
	   (if incremented-conjunct
	       (do* ((conj (length last-disjunct) (1- conj))
		     (res (list (if (= conj conjunct)
				    incremented-conjunct
				    (first-path (elt expr conj) parity)))
			  (cons (cond ((< conj conjunct)
				       (elt last-disjunct (1- conj)))
				      ((= conjunct conj)
				       incremented-conjunct)
				      ((> conj conjunct)
				       (first-path (elt expr conj) parity)))
				res)))
		    ((= conj 1) res))))))
    (t nil)))

				  

(defun binding-node-goal-loop-p (node inst-preconds disjunction-path values)
  (declare (type binding-node node))
  "True iff the node introduces a goal it is trying to solve. This is
true if this goal can be found on every goal path back to \"done\"."

  ;; I did this just to make sure the profiling stats weren't getting
  ;; messed up by how recursive this is..
  (binding-node-goal-loop-r node inst-preconds disjunction-path values))

(defun binding-node-goal-loop-r (node inst-preconds disjunction-path values)
  (declare (type binding-node node))
  (let* ((next-goal-node (nexus-parent (nexus-parent node)))
	 (goal-to-solve (goal-node-goal next-goal-node)))
    (cond
      ;; If this is one of the new goals added, it's a loop
      ((goal-will-loop-p goal-to-solve inst-preconds t values disjunction-path)
       (list next-goal-node))

      ;; Otherwise, there must be more operators, and they must all be
      ;; loops for this to be a loop.
      ((goal-node-introducing-operators next-goal-node)
       (catch 'not-a-loop
	 (mapcan #'(lambda (bn)
		     (or (binding-node-goal-loop-r
			  bn inst-preconds disjunction-path values)
			 (throw 'not-a-loop nil)))
		 (goal-node-introducing-operators next-goal-node)))))))

(defun goal-will-loop-p (goal-to-solve expr parity values disj)
  (cond ((null expr) nil)
	((eq goal-to-solve expr)
	 (if (negated-goal-p goal-to-solve) (not parity) parity))
	((typep expr 'literal) nil)
	((eq (car expr) (if parity 'user::and 'user::or))
	 (some #'(lambda (x d) (goal-will-loop-p goal-to-solve x
						 parity values d))
	       (cdr expr) disj))
	((eq (car expr) (if parity 'user::or 'user::and))
	 (goal-will-loop-p goal-to-solve (elt expr (car disj)) parity
			   values (cdr disj)))
	((eq (car expr) 'user::~)
	 (goal-will-loop-p goal-to-solve (second expr) (not parity)
			   values disj))))

(defun needs-unsolvable-goal-p (expr disj values parity)
  (cond ((null expr) nil)
	((typep expr 'literal)
         ;; A goal is unsolvable if we'd like it to be true 
	 ;; (or false), but it is false (or true) in the state, and
	 ;; we have no operator to make it true (or false).
	 (if parity
	     (and (getf (literal-plist expr) :unsolvable-true)
		  (not (literal-state-p expr)))
	     (and (getf (literal-plist expr) :unsolvable-false)
		  (literal-state-p expr))))
	((eq (car expr) (if parity 'user::and 'user::or))
	 (some #'(lambda (x d) (needs-unsolvable-goal-p x d values parity))
	       (cdr expr) disj))
	((eq (car expr) (if parity 'user::or 'user::and))
	 (needs-unsolvable-goal-p (elt expr (car disj)) (cdr disj) values parity))
	((eq (car expr) 'user::~)
	 (needs-unsolvable-goal-p (second expr) disj values (not parity)))
	((eq (car expr) 'user::exists)
	 (needs-unsolvable-goal-p (third expr) disj values parity))))

(defun expand-binding (node)
  (declare (type binding-node node))
  "Expand a binding node."

  ;; First check whether this node makes a goal loop inevitable, in
  ;; which case forget it. Maybe this should be learnable with a
  ;; control rule, but it's so general I figure not.
  (let ((inst-precs (binding-node-instantiated-preconds node))
	(disj-path  (binding-node-disjunction-path node))
	(values (instantiated-op-values
		 (binding-node-instantiated-op node)))
	loop-top)
    (cond ((needs-unsolvable-goal-p inst-precs disj-path values t)
	   (close-node node :uses-unsolvable-goal))
	  ((setf loop-top
		 (binding-node-goal-loop-p node inst-precs disj-path values))
	   (close-node node (cons :causes-goal-loop loop-top)))
	  (t
	   ;; Otherwise we're ok to expand, but first check if this is an
	   ;; inference rule which can be applied straight away.
	   (if (and (inference-rule-a-or-b-node-p node)
		    (not (binding-node-applied node))
		    (applicable-op-p node)
		    (apply-and-check node (binding-node-instantiated-op node)))
	       (progn (prod-signal :achieve node) node)
	       (expand-binding-or-applied-op node))))))

(defun expand-binding-or-applied-op (node)
  "Expand a binding, applied-op or protection node"
  (declare (type a-or-b-node node))

  (let* ((next (compute-next-thing node))
	 (applicables (cache a-or-b-node-applicable-ops-left node
			     (abs-generate-applicable-ops node next)))
	 (subgoals (cache
		    a-or-b-node-goals-left node
		    (setf (a-or-b-node-pending-goals node)
			  (if *incremental-pending-goals*
			      (abs-generate-goals node next)
			    (delete-if #'(lambda (goal)
					   (goal-loop-p node goal))
				       (abs-generate-goals node
							   next)))))))
    (if (and (null applicables) (null subgoals)
	     *use-protection*)
	;; Jim (1/94) see notes on fixing the briefcase domain
	(let ((goals-to-protect
	       (cache a-or-b-node-protections-left node
		      (generate-protection-nodes node))))
	  (if goals-to-protect
	      (do-protect node goals-to-protect)
	    (close-node node :no-choices)))
      (let ((what-next (choose-apply-or-subgoal node applicables subgoals)))
	(case what-next
	  (:apply
	   (if applicables
	       (do-apply-op node applicables next)
	     (close-node node :no-choices)))
	  (:sub-goal
	   (if subgoals
	       (do-subgoal node subgoals next)
	     (close-node node :no-choices)))
	  (:protect
	   (let ((goals-to-protect
		  (cache a-or-b-node-protections-left node
			 (generate-protection-nodes node))))
	     (if goals-to-protect
		 (do-protect node goals-to-protect)
	       (close-node node :no-choices))))
	  (otherwise what-next))))))

(defun compute-next-thing (node)
  (declare (type a-or-b-node node))
  (let ((absparent (nexus-abs-parent node)))
    (cond ((problem-space-property :forget-abstract-order) nil)
	  (absparent
	   ;; Compute the next thing from the abstract parent.
	   (let ((result (if (binding-node-p node)
			     (nexus-winner absparent)
			     (next-goal-or-application-child absparent))))
	     (if (and (nexus-p result) (deepest-point result))
		 (setf (elt (problem-space-property :deepest-point)
			    (nexus-abs-level node))
		       result))
	     result))
	  (t
	   ;; Inherit the next thing from the parent at this level.
	   (let ((next-parent (next-a-or-b-parent node)))
	     (if next-parent (compute-next-thing next-parent)))))))

;;; Find out if this is the furthest we have gotten in the abstract
;;; plan yet.
(defun deepest-point (node)
  (declare (type nexus node))
  (let ((pointvec (problem-space-property :deepest-point))
	(index (1- (nexus-abs-level node))))
    (or (null (elt pointvec index))
	(ancestor (elt pointvec index) node))))

(defun ancestor (ancestor child)
  (declare (type nexus ancestor child))
  (cond ((null child) nil)
	((eq ancestor child) t)
	(t (ancestor ancestor (nexus-parent child)))))
    

(defun next-goal-or-application-child (node)
  (declare (type nexus node))
  (let ((child (nexus-winner node)))
    (cond ((not (nexus-p child)) nil)
	  ((and child (or (goal-node-p child) (applied-op-node-p child)))
	   child)
	  (child (next-goal-or-application-child child)))))

(defun next-a-or-b-parent (node)
  (let ((parent (nexus-parent node)))
    (cond ((and parent (a-or-b-node-p parent)) parent)
	  (parent (next-a-or-b-parent parent)))))

;;; If we are trying to follow the exact order of the more abstract
;;; plan, maintain the constraint that only one subgoal or
;;; applicable op of higher abstraction level than this one will be
;;; considered: the "next" one. An applicable op is of higher
;;; abstraction level if its binding-node has an abs-parent.

;;; This seems to be a stronger condition than imposed on Craig's
;;; original hierarchical problem solving work, since it forces the
;;; lower level to follow the order of applied-ops as well as
;;; subgoals, but I think that's consistent, and that Craig's proofs
;;; of completeness can be extended no trouble.

(defun abs-generate-applicable-ops (node next)
  ;; "next" is the next step in the more abstract space.
  (declare (type a-or-b-node node))
  (if next
      (let ((next-appop-binder
	     (if (typep next 'applied-op-node)
		 (instantiated-op-binding-node-back-pointer
		  (applied-op-node-instantiated-op next)))))
	;; If the applicable op is from a higher abstraction level,
	;; ignore it unless it is the one indicated in the "next" node.
	(delete-if
	 #'(lambda (appop)
	     (let ((binder-parent
		    (nexus-abs-parent
		     (instantiated-op-binding-node-back-pointer
		      appop))))
	       (and binder-parent
		    (not (eq binder-parent next-appop-binder)))))
	 (generate-applicable-ops node)))
      (generate-applicable-ops node)))


(defun abs-generate-goals (node next)
  ;; "next" is the next step in the more abstract space
  (declare (type a-or-b-node node))
  (if next
      (delete-if
       #'(lambda (goal)
	   ;; delete only if it comes from a higher
	   ;; abstraction space, but is not the next step in
	   ;; the plan, (see comments above).
	   (and (> (compute-abstraction-level goal *current-problem-space*)
		   (nexus-abs-level node))
		(or (not (goal-node-p next))
		    (not (eq goal (goal-node-goal next))))))
       (generate-goals node))
      (generate-goals node)))


;;; This produces the list of goals to be addressed along this path to
;;; the solution, if it already exists.
(defun gather-future-goals (node)
  (cond ((eq node :solution) nil)
	(t
	 (or (getf (nexus-plist node) :future-plan-goals)
	     (let ((winning-child (nexus-winner node)))
	       (setf (getf (nexus-plist node) :future-plan-goals)
		     (unless (eq winning-child :solution)
		       (if (typep node 'goal-node)
			   (cons (goal-node-goal node)
				 (gather-future-goals winning-child))
			   (gather-future-goals winning-child)))))))))

;;; Things that must be done when we apply an operator:
;;; 1. recalculate the pending goals
;;; 2. see if any pending inference rules are now applicable
;;; 3. see if we've reached the goal
(defun do-apply-op (node applicable-ops next-thing)

  (let ((chosen-op (choose-applicable-op node applicable-ops))
	a-op-node)
    (declare (special a-op-node))	; used in state daemons.

    (cond (chosen-op
	   (setf a-op-node
		 (make-applied-op-node
		  :parent node
		  :abs-level (nexus-abs-level node)
		  :instantiated-op chosen-op))
	   (setf (a-or-b-node-applicable-ops-left node)
		 (delete chosen-op (a-or-b-node-applicable-ops-left node)))
	   (if (and (null (a-or-b-node-applicable-ops-left node))
		    (null (a-or-b-node-goals-left node))
		    (or (not *use-protection*)
			(null (a-or-b-node-protections-left node))))
	       (close-node node :exhausted))
	   (if (and next-thing
		    (applied-op-node-p next-thing)
		    (eq (nexus-abs-parent
			 (instantiated-op-binding-node-back-pointer chosen-op))
			(instantiated-op-binding-node-back-pointer
			 (applied-op-node-instantiated-op next-thing))))
	       (set-abs-parent a-op-node node next-thing)
	       (do-book-keeping a-op-node node))

	   (cond ((apply-and-check a-op-node chosen-op)
		  ;; If finish is applicable we're done.
		  (setf (getf (nexus-plist a-op-node) :termination-reason)
			:achieve)
		  (prod-signal :achieve a-op-node)
		  a-op-node)
		 
		 ;; If there is a state loop, close this new node, retract
		 ;; the state, reset the goals and fail.
	         ((state-loop-p a-op-node)
		  (dolist (application (applied-op-node-applied a-op-node))
		    (do-state application nil)
		    (let ((instop (op-application-instantiated-op application)))
		      (if (instantiated-op-binding-node-back-pointer instop)
			  (set-goals instop))))
		  (close-node a-op-node :state-loop)
		  (compute-expanded-goals node)
		  :state-loop)
		 
	         ;;; Otherwise recalculate the pending goals
		 (*incremental-pending-goals*		  
		  (setf (a-or-b-node-pending-goals a-op-node)
			(copy-list (get-delta-pending-goals a-op-node)))
		  a-op-node)
		 (t
		  (setf (a-or-b-node-pending-goals a-op-node)
			(give-me-all-pending-goals a-op-node))
		  a-op-node)))

	  (t :no-ap-op))))

(defun do-subgoal (node poss-subgoals next-thing)
  (declare (special *always-ignore-bad-goals*))

  (let ((chosen-goal (choose-goal node poss-subgoals)))

    (cond (chosen-goal
	   (let* ((binding-nodes
		   (mapcar #'instantiated-op-binding-node-back-pointer
			   ;;aperez: just add a comment here. This
                           ;;function broke because it may happen that:
			   ;;literal-state-p may be true and
			   ;;literal-neg-goal-p false with
			   ;;literal-goal-p true 
   			   ;; (this happened to me due to a bug
                           ;;somewhere else related with undoing when
                           ;;backtracking and the justifications of
                           ;;the inference rules)
			   (if (literal-state-p chosen-goal)
			       (literal-neg-goal-p chosen-goal)
			       (literal-goal-p chosen-goal))))
		  (goal-node
		   (make-goal-node
		    :parent node
		    :abs-level (nexus-abs-level node)
		    :goal chosen-goal
		    :introducing-operators binding-nodes
		    :goals-left
		    (if (and (eq *running-mode* 'saba)
			     *smart-apply-p*)
			nil
			(remove chosen-goal (a-or-b-node-pending-goals node)))
		    ;; assume the goal is for a good reason!
		    :positive? (not (literal-state-p chosen-goal))))
		  ;; (next-thing (problem-space-property :next-thing))
		  )
	     ;; Test if the code has broken in the way Alicia
	     ;; mentioned above. If it has, cause a continuable error,
	     ;; to warn the user, because now this code will not
	     ;; break, but something else might.
	     (when (and (null binding-nodes)
			(not *always-ignore-bad-goals*))
		 (cerror "Just carry on"
			 "The chosen goal, ~S, is not marked as a goal"
			 chosen-goal)
		 (format t "~%Ignore this error from now on? [no] ")
		 (let ((answer (read-line)))
		   (if (and (> (length answer) 0)
			    (char= (elt answer 0) #\y))
		       (setf *always-ignore-bad-goals* t))))
	     ;; Add the goals to the list of expanded goals on this path.
	     (push chosen-goal
		   (problem-space-expanded-goals *current-problem-space*))
	     (setf (a-or-b-node-goals-left node)
		   (if (and (eq *running-mode* 'saba) *smart-apply-p*)
		       nil
		     (delete chosen-goal (a-or-b-node-goals-left node))))
	     (if (and (or (not *use-protection*)
			  (null (a-or-b-node-protections-left node)))
		      (null (a-or-b-node-goals-left node))
		      (null (a-or-b-node-applicable-ops-left node)))
		 (close-node node :exhausted))
	     ;; Add this node to the goal nodes property of the
	     ;; relevant binding nodes.
	     (dolist (bn binding-nodes)
	       (push goal-node (getf (nexus-plist bn) 'goal-nodes)))
	     (let* ((abs (if (car binding-nodes) ; Yuck!!
			     (nexus-abs-parent (car binding-nodes))))
		    (true-parent	; this can be hard to find!
		     (cond ((and (goal-node-p next-thing)
				 (eq (goal-node-goal next-thing) chosen-goal))
			    next-thing)
			   (abs
			    (find-if #'(lambda (bn)
					 (eq (goal-node-goal bn) chosen-goal))
				     (getf (nexus-plist abs) 'goal-nodes)
				     ;; We want the earliest one (maybe).
				     :from-end t)))))
	       (if true-parent
		   (set-abs-parent goal-node node true-parent)
		   (do-book-keeping goal-node node)))
;;;		 (if (eq true-parent next-thing)
		   ;; Next goal or applicable-op node.
;;;		     (setf (problem-space-property :next-thing)
;;;			   (nexus-winner (nexus-winner
;;;					  (nexus-winner next-thing)))))

	     goal-node))

	  (t :no-goal))))

(defun maintain-goals (node)

  (cond ((not (nexus-p node)) nil)
	((and (binding-node-p node)
	      (binding-node-instantiated-op node))
	 (delete-instantiated-op-from-literals
	  (binding-node-instantiated-op node))
	 (maintain-goals (nexus-parent node)))
	((binding-node-p node)
	 (maintain-goals (nexus-parent node)))
	((not (nexus-open-node-link node))
	 (maintain-goals (nexus-parent node)))))


;;; This function also sets the name of the new node to be the same as
;;; the name of its parent, so it shouldn't be called as well as
;;; do-book-keeping.
(defun set-abs-parent (child parent abs-parent)
  (declare (type nexus child abs-parent))

  ;; This stuff is like do-book-keeping
  (push-previous child *current-problem-space*)
  (push child (problem-space-property :expandable-nodes))
  (setf (nexus-parent child) parent)
  (if parent (push child (nexus-children parent)))
  (setf (nexus-conspiracy-number child) 1)

  ;; This is extra
  (setf (nexus-abs-parent child) abs-parent)
  (push child (nexus-abs-children abs-parent))
  (setf (nexus-name child) (nexus-name abs-parent)))

;;; CONSPIRACY SEARCH STUFF

;;; Update the conspiracy number of a node. I assume here that the
;;; number of children is always small enough that going through all
;;; the children each time will not cause too much trouble. This
;;; function should be called along a path moving UPWARDS, because it
;;; assumes the values below are up to date.

(defun update-conspiracies-up-to-root (node)
  (update-conspiracy-number node)
  (if (nexus-parent node)
      (update-conspiracies-up-to-root (nexus-parent node))))


(defun update-conspiracy-number (node)
  (declare (type nexus node))

  ;; In the search tree, every node is an or-node because it
  ;; represents a decision that has been taken. The conspiracy is
  ;; carried around in the pending-goals list, so I make use of that.
  ;; This means that if a node is a leaf node, its conspiracy number
  ;; is the length of its pending-goals if it is a bindings or
  ;; applied-op node, and is the length of its parent binding node
  ;; parent-goals otherwise. See my AQ paper for a justification of
  ;; this. (Jim).

  (if (nexus-children node)             ; not a leaf node
      (let* ((children (nexus-children node))
             (result (nexus-conspiracy-number (car children))))
        (dolist (child children)
          (if (< (nexus-conspiracy-number child) result)
              (setf result (nexus-conspiracy-number child))))
        (setf (nexus-conspiracy-number node) result))
      ;; Otherwise use pending goals
      (let* ((top (elt (problem-space-property :*finish-binding*)
                       (nexus-abs-level node)))
             (parent-binding-node
              (do ((par (if (and (binding-node-p node)
                                 (not (eq (nexus-parent node) top)))
                            (nexus-parent node)
                            node)
                        (nexus-parent par)))
                  ((or (null par) (binding-node-p par)) par))))
        (setf (nexus-conspiracy-number node)
          (if parent-binding-node
              (length (a-or-b-node-pending-goals parent-binding-node))
            ;; If there was no parent binding node, this is one of the top level
            ;; nodes like (done) or <*finish*>, which have a number of 1, I guess.
            1)))))
