
;;; *************  Prodigy/Analogy in Prodigy 4.0 *************
;;; Manuela Veloso - 1994 - from NoLimit to Prodigy4.0
;;; Thanks to Karen Haigh, Vera Kettnaker, and Vincent Poinot
;;; for help in different parts of the implementation.
;;; ***********************************************************
;;; I STILL NEED TO ADDRESS, REPRESENT, AND TEST NEGATED GOALS.
;;; ***********************************************************
;;;
;;; History:
;;; 
;;; 12sep97 Changed init-guiding by adding the optional parameter. This allows
;;; the caller (e.g., the UI), to pass a ordering to be used during serial
;;; merging. [cox]
;;;

(setf *print-case* :downcase)
(setf p4::*always-ignore-bad-goals* t) ;; should not be needed
(setf p4::*use-new-matcher* nil) ;; can't remember why and whether still needed

;;; Commented variable out because it is defined in comforts.lisp (Prodigy 4.0
;;; file) [cox 14jun98]
;(defvar *analogical-replay* nil)  ;; general flag for analogical replay

(defvar *guiding-case* nil)  ;; [added 7apr 97 cox] 

(defvar *talk-case-p* nil)
(defvar *debug-case-p* nil)
(defvar	*backtracking* t)
(defvar	*backtracking-flag* nil)

;;; *UI* now defined in Prodigy's loader.lisp. [15jun98 cox]
;;;
;(defvar *ui* nil)  ;;to run analogy from prodigy-UI *ui* must be t

(defvar	*mark-node* nil) ;; to have the control rule fire just once.

;;; Several different merging modes: user, serial, random, smart, saba
;;; At each step, Prodigy/Analogy decides on which case to follow,
;;;   user: by asking the user
;;;   serial: in a pre-defined serial order
;;;   random: randomly
;;;   smart: by using a *set-of-interacting-goals*
;;;   saba: sub-goal always before applying, and apply in right order
;;;   saba-cr: saba and lets other control rules apply to goal choices

(defvar *merge-mode* 'saba)

;;; List of all the groups of interacting goals for a problem 
;;; for example : (((at hammer locb) (at apollo locb))
;;; ((at robot locb) (at apollo locb))) for a problem in the
;;; rocket domain in which a hammer and a rocket have to be
;;; moved from loca to locb.
;;; The groups can be written in any order, but the goals in a
;;; group have to be ordered: the first goal has to be achieved
;;; before the second, third, etc ; the second one before the 
;;; third, etc ; and so on.
;;; NOTE : in the current implementation, only pairs of goals 
;;; are considered (see function check-case-to-follow)
(defvar *set-of-interacting-goals* nil)

;;; This is added by Jim to track the number of nodes found by analogy
(defvar *nodes-followed* 0
  "Incremented when analogy follows a node")

;;; When the cases are loaded in a list *case-cache*
;;; *guiding-cases* is initially set to *case-cache*
;;; but, while replaying, cases completely used are
;;; removed from *guiding-cases*.
(setf *guiding-cases* *case-cache*)

;;; Used to implement skipping unncessary parts of the case
(setf *unusable-binding-nodes-names* nil)
(setf *link* nil)
(setf *previous-link* nil)

;;; Additional goals and applicable ops that may arise new
(setf *unguided-goals* nil
      *unguided-applicable-ops* nil
      *chosen-goal* nil
      *chosen-applicable-op* nil)

;;; ***********************************************************
;;; Initialization - choice of merging mode and set up of *guiding-case*
;;; ***********************************************************

;;;
;;; Added optional parameter [11sep 97 cox]
;;;
(defun init-guiding (&optional serial-order)
  (fresh-start-vars)
  (fresh-clean-begin-cases)
  (format t "~%List of available cases :")
  (let ((counter 0))
    (dolist (case *guiding-cases*)
      (format t "~% ~s: ~s" counter (guiding-case-name case))
      (incf counter)))
  (format t "~% Current *merge-mode* is ~S" *merge-mode*)
  (case *merge-mode*
    (user
     (cond
      ((eq 1 (length *guiding-cases*))
       (setf *guiding-case* (car *guiding-cases*)))
      (t
       (format t "~% Enter number of first case to follow: ")
       (setf *guiding-case* (nth (read) *guiding-cases*)))))
    (serial
     (when (> (length *guiding-cases*) 1)
       (let ((order nil)
	     (temp *guiding-cases*))
	 (cond
	  ;; Serial order can be passed thru optional argument.  This is done
	  ;; from the UI, with option of randomized order if s-order = (random)
	  ((and serial-order
		(listp serial-order)
		(not (eq (first serial-order) 'random)))
	   (setf order serial-order))
	  (*ui*
	   (dotimes (i (length *guiding-cases*))
	     (setf order (cons i order)))
	   (setf order (shuffle order)))
	  (t
	   (format t "~% Enter number of cases in the order to follow, e.g. (1 0 2): ")
	   (setf order (read))))
	 (setf *guiding-cases* (map 'list #'(lambda(x) (nth x temp)) order))))
     (setf *guiding-case* (car *guiding-cases*)))
    (t (setf *guiding-case* (car *guiding-cases*)))))


(defun chop-case (case from to)
  ;; as node numbers
  (fresh-clean-begin-cases)
  (setf (guiding-case-additional-bindings case) nil)
  (clean-plist-case case (guiding-case-case-root case))
  (begin-case case)
  ;; cases point to first goal
  (setf (guiding-case-aux-ptr case)
	(guiding-case-ptr case))
  (setf (guiding-case-ptr case)
	(find-node-in-case case from))
  (setf (guiding-case-case-root case)
	(find-node-in-case case from))
  (let ((end-ptr (find-node-in-case case to)))
    (if (not (null end-ptr))
	(setf (p4::nexus-children (get-case-parent-node end-ptr))
	      nil))))

(defun restart-all-cases-ui ()
  (dolist (case *guiding-cases*)
    (send-to-tcl "Clean-case")
    (send-to-tcl (guiding-case-name case))
    (send-to-tcl "Mark-first")
    (send-to-tcl (guiding-case-name case))
    (send-to-tcl 1)
    (send-to-tcl "  ")))

(defun find-node-in-case (case nodenum)
  (if (null (guiding-case-aux-ptr case))
      nil
    (if (eq (p4::nexus-name (guiding-case-aux-ptr case)) nodenum)
	(guiding-case-aux-ptr case)
      (progn
	(advance-aux-ptr case)
	(find-node-in-case case nodenum)))))

;;; *talk-case-p* needs to be set separately
(defun fresh-start-vars ()
  (setf *analogical-replay* t
	*guiding-cases* *case-cache*
	*unguided-goals* nil
	*unguided-applicable-ops* nil
	*chosen-goal* nil
	*chosen-applicable-op* nil
	*unusable-binding-nodes-names* nil
	*new-bindings* nil
	*backtracking-flag* nil
	*link* nil
	*previous-link* nil))

(defun fresh-clean-begin-cases ()
  (setf *new-unguided-search* t)
  (dolist (case *guiding-cases*)
    (fresh-clean-begin-case case))
  (if *ui* (restart-all-cases-ui)))

(defun fresh-clean-begin-case (case)
  (setf (guiding-case-additional-bindings case) nil)
  (clean-plist-case case (guiding-case-case-root case))
  (cond
   (*ui* (setf *ui* nil)
	 (begin-case case)
	 (setf *ui* t)
	 (number-nodes-plist case (guiding-case-ptr case)))
   (t
    (begin-case case))))

(defun number-nodes-plist (case first-node-to-number)
  (setf (guiding-case-aux-ptr case) first-node-to-number)
  (recursive-number case 1))
  
(defun recursive-number (case ui-node-number)
  (when (guiding-case-aux-ptr case)
    (setf (getf (p4::nexus-plist (guiding-case-aux-ptr case))
		:ui-node-number) ui-node-number)
    (advance-aux-ptr case)
    (recursive-number case (1+ ui-node-number))))

;;; ***********************************************************
;;; Functions to move pointers in the cases and other case traversals
;;; ***********************************************************

;;; Sets the pointer ptr of the case the first goal
;;; (The defstruct of a case is in load-cases.lisp)

(defun begin-case (case)
  (setf (guiding-case-ptr case)
	(guiding-case-case-root case))
  (when (eq (p4::nexus-name (guiding-case-case-root case)) 1)
    (advance-case case)
    (advance-case case)
    (advance-case case)
    (advance-case case)))


;;; The two following functions traverse a case from the first 
;;; node to the last, printing for each node the associated plist

(defun traverse-ptr-case (case)
  (fresh-clean-begin-case case)
  (recursive-traverse case))

(defun recursive-traverse (case)
  (unless (null (guiding-case-ptr case))
    (if *talk-case-p* (format t "~% ~s" (guiding-case-ptr case)))
    (if *talk-case-p*
	(format t "~%    plist ~s" (p4::nexus-plist (guiding-case-ptr case))))
    (advance-ptr case)
    (recursive-traverse case)))

;;; Sets :unusable? in the plist to nil so we could have done instead 
;;; (setf (getf (p4::nexus-plist (guiding-case-ptr case)) :unusable?) nil)

(defun clean-plist-case (case first-node-to-clean)
  (setf (guiding-case-aux-ptr case) first-node-to-clean)
  (recursive-clean case))

(defun recursive-clean (case)
  (unless (null (guiding-case-aux-ptr case))
    (setf (getf (p4::nexus-plist (guiding-case-aux-ptr case)) :unusable?) nil)
    (setf (getf (p4::nexus-plist (guiding-case-aux-ptr case)) :ui-node-number) 0)
    (advance-aux-ptr case)
    (recursive-clean case)))

;;; ***********************************************************
;;; Functions called by the analogy control rules
;;; ***********************************************************

;;; In Prodigy4.0, the order by which the control rules are called,
;;; at the end of a search cycle is the following (see refine-or-expand,
;;; expand-binding, and expand-binding-or-applied-op in search.lisp):
;;; 1. computes applicable ops -- several different ways,
;;; permute-application-order, saba, etc -- no control rules here.
;;; 2. select, 3. reject, 4. prefer goal control rules.
;;; 5. calls the control rules to decide to apply or subgoal;
;;; apply is not a select choice even if enforced by a control rule.
;;; sub-goal is a select choice (i.e. if there are applicable ops,
;;; these are not left as a backtracking choice).

;;; We overrid this slightly -- redefined expand-binding-or-applied-op
;;; below and enforced apply to be a select if enforced by a control rule.

;;; ***********************************************************
;;; Function called by the select goal control rule.
;;; ***********************************************************

;;; Decides which case is to be followed next: if the current goal to 
;;; subgoal on either entails a goal loop or is already true: in both
;;; cases, the part of the case that achieves the goal is skipped.
;;; check-case-to-follow does all the reasoning on which case to follow
;;; and sets *guiding-case* to what should be done next.

(defun analogy-get-guidance-goal (goal)
  (when (and *analogical-replay* (not (eq *mark-node* *current-node*)))
    (setf *mark-node* *current-node*)
    (if *debug-case-p*
	(format t "~%In analogy-get-guidance-goal: *guiding-case* ~S"
		(if (eq *guiding-case* 'no-case)
		    'no-case (guiding-case-name *guiding-case*))))
    ;;(break)
    (when *guiding-case*
      (check-case-to-follow)
      (cond
	((eq *guiding-case* 'no-case)
	 (setf *previous-link* *link*
	       *link* nil)
	 (cond
	   (*chosen-goal*
	    (cond
	     ((eq *merge-mode* 'saba-cr)
	      (if *talk-case-p*
		  (format t "~%Following any of the possible unguided goals ~S" 
			*unguided-goals*))
	      (mapcar #'(lambda (x) (list (cons goal x))) *unguided-goals*))
	     (t
	      (if *talk-case-p*
		  (format t "~%Following unguided goal ~S" 
			*chosen-goal*))
	      (list (list (cons goal *chosen-goal*))))))
	   (t nil)))
	((case-goal-p (guiding-case-ptr *guiding-case*))
	 (let* ((proposed-goal (get-case-new-visible-goal
				(guiding-case-ptr *guiding-case*)
				*guiding-case*)))
	   (incf *nodes-followed*)
	   (if *talk-case-p*
	       (format t "~%Following case ~S ~S -- goal ~A ~S" 
		       (guiding-case-name *guiding-case*)
		       (get-case-node-name (guiding-case-ptr *guiding-case*))
		       (if (negated-case-goal-p (guiding-case-ptr *guiding-case*))
			   "~" "")
		       proposed-goal))
	   (setf *previous-link* *link*
		 *link*
		 (cons 'goal
		       (list (guiding-case-name *guiding-case*)
			     (get-case-node-name (guiding-case-ptr *guiding-case*)))))
	   (advance-case *guiding-case*)
	   (list (list (cons goal proposed-goal)))))
	(t nil)))))


(defun negated-case-goal-p (case-goal)
  (p4::literal-neg-goal-p (p4::goal-node-goal case-goal)))

;;; ***********************************************************
;;; Function called by the select operator control rule.
;;; ***********************************************************

(defun analogy-get-guidance-operator (operator)
  (when (and *analogical-replay* (not (eq *mark-node* *current-node*)))
    (setf *mark-node* *current-node*)
    (if *debug-case-p*
	(format t "~%In analogy-get-guidance-operator: *guiding-case* ~S"
		(if (eq *guiding-case* 'no-case)
		    'no-case (guiding-case-name *guiding-case*))))
    (unless (eq *guiding-case* 'no-case)
      ;;At this time, the pointer in the *guiding-case*
      ;;is pointing exactly to the operator used in the
      ;;past to solve the goal that we are working for.
      (cond 
       ((case-operator-p (guiding-case-ptr *guiding-case*))
	(let ((proposed-op (get-case-visible-operator
			    (guiding-case-ptr *guiding-case*))))
	  (cond
	   ((valid-justification-op-p proposed-op)
	    (incf *nodes-followed*)
	    (if *talk-case-p*
		(format t "~%Following case ~S ~S -- operator ~S"
			(guiding-case-name *guiding-case*)
			(get-case-node-name (guiding-case-ptr *guiding-case*))
			proposed-op))
	    (setf *previous-link* *link*
		  *link*
		  (cons 'op
			(list (guiding-case-name *guiding-case*)
			      (get-case-node-name (guiding-case-ptr *guiding-case*)))))
	    (advance-case *guiding-case*)
	    (list (list (cons operator proposed-op))))
	   (t 
	    (when *talk-case-p*
	      (format t "~%Operator ~S not validated for goal ~S"
			proposed-op *current-goal*))
	    (advance-case *guiding-case*)
	    (advance-case *guiding-case*)
	    (smart-advance *guiding-case*)
	    nil))))
       (t nil)))))

;;; It calls the function get-all-ops to make sure that this
;;; operator is still the right operator for the current goal.
;;; It also gets the current goal to pass it to get-all-ops.
;;; This is like having another meta-predicate called before
;;; in the control rule... could change.

(defun valid-justification-op-p (proposed-op)
  (let* ((cur-goal (p4::goal-node-goal
		    (give-me-node-of-type 'p4::goal-node *current-node*)))
	 (all-ops (p4::get-all-ops cur-goal *current-node*)))
    (setf *current-goal* cur-goal)
    (if *debug-case-p*
	(format t "~% proposed-op ~S all-ops ~S" proposed-op all-ops))
    (member proposed-op all-ops
	    :test #'(lambda (x y) (equal x (p4::operator-name y))))))

;;; ***********************************************************
;;; Function called by the select bindings control rule.
;;; ***********************************************************

(defun analogy-get-guidance-bindings (bindings)
  (when (and *analogical-replay* (not (eq *mark-node* *current-node*)))
    (setf *mark-node* *current-node*)
    (if *debug-case-p*
	(format t "~%In analogy-get-guidance-bindings: *guiding-case* ~S"
		(if (eq *guiding-case* 'no-case)
		    'no-case (guiding-case-name *guiding-case*))))
    (unless (eq *guiding-case* 'no-case)
      ;;At this time, the pointer in the *guiding-case*
      ;;is pointing exactly to the bindings used in the
      ;;past to instantiate the operator we are working for.
      ;;There again, not always true; see guidance-operator.
      (cond 
       ((case-bindings-p (guiding-case-ptr *guiding-case*))
	(let* ((case-vars-named-bindings
		(get-case-new-visible-bindings
		 (guiding-case-ptr *guiding-case*)
		 *guiding-case*))
	       (case-op-vars (car case-vars-named-bindings))
	       (case-op-vals-names (nth 1 case-vars-named-bindings))
	       (current-op-vals
		(mapcar #'(lambda (x)
			    (if (numberp x)
				x
			        (or (p4::object-name-to-object x *current-problem-space*)
				    x)))
			case-op-vals-names))
	       (proposed-bindings
		(mapcar #'cons case-op-vars current-op-vals)))
	  (when *debug-case-p*
	    (format t "~% Bindings from case ~S" case-vars-named-bindings)
	    (format t "~% Type-ified Bindings ~S" proposed-bindings))
	  ;;proposed-bindings is a list ((var . prodigy-object)*)
	  (cond
	   (proposed-bindings
	    (cond
	     ((valid-justification-bindings-p proposed-bindings)
	      (setf proposed-bindings
		    (map 'list #'(lambda (x)
				   (if (or (numberp (cdr x))
					   (p4::prodigy-object-p (cdr x)))
				       x
				       (cons (car x)
					     (p4::object-name-to-object
					      (cdr x) *current-problem-space*))))
			 (apply-case-substitutions proposed-bindings *guiding-case*)))
	      (incf *nodes-followed*)
	      (if *talk-case-p*
		  (format t "~%Following case ~S ~S -- bindings ~S"
			  (guiding-case-name *guiding-case*)
			  (get-case-node-name (guiding-case-ptr *guiding-case*))
			  proposed-bindings))
	      (setf *previous-link* *link*
		    *link*
		    (cons 'bindings
			  (list (guiding-case-name *guiding-case*)
				(get-case-node-name
				 (guiding-case-ptr *guiding-case*)))))
	      (advance-case *guiding-case*)
	      (smart-advance *guiding-case*)
	      (list (list (cons bindings proposed-bindings))))
	     (t 
	      (if *talk-case-p*
		  (format t "~%Bindings ~S not validated" proposed-bindings))
	      (advance-case *guiding-case*)
	      (smart-advance *guiding-case*)
	      nil)))
	   (t
	    (if *talk-case-p*
		(format t "~%Null bindings -- ok case"))
	    (setf *previous-link* *link*
		  *link*
		  (cons 'bindings
			(list (guiding-case-name *guiding-case*)
			      (get-case-node-name
			       (guiding-case-ptr *guiding-case*)))))
	    (advance-case *guiding-case*)
	    (smart-advance *guiding-case*)
	    nil))))
       (t nil)))))

#|
(defun valid-justification-bindings-p (proposed-bindings)
  (let ((all-bindings 
	 (p4::form-bindings-from-goal *current-node* *current-goal*
				      (p4::operator-node-operator *current-node*))))
    (when *debug-case-p*
      (format t "~% proposed-bindings ~S" proposed-bindings)
      (format t "~% all-bindings ~S" all-bindings))
    (setf *new-bindings* nil)
    (cond
     ((find proposed-bindings all-bindings
	    :test #'(lambda (x y) (exact-bindings-p x y)))
      t)
     ((find proposed-bindings all-bindings
	    :test #'(lambda (x y) (partially-matched-bindings-p x y)))
      (when *new-bindings*
	(setf (guiding-case-additional-bindings *guiding-case*)
	      (append *new-bindings*
		      (guiding-case-additional-bindings *guiding-case*)))
	(all-guided-goals-cases))
      t)
     (t nil))))
|#

(defun valid-justification-bindings-p (proposed-bindings)
  ;;(break)
  (cond
    ((not (some #'(lambda (x) (p4::strong-is-var-p (cdr x)))
		proposed-bindings))
     (and (p4::runtime-type-check proposed-bindings
				  (p4::operator-node-operator *current-node*))
	  (every #'(lambda (x)
		     (p4::check-functions-for-var
		      x proposed-bindings (p4::operator-node-operator *current-node*)))
		 (map 'list #'car proposed-bindings))))
    (t ;;will fix further after
     (let ((all-bindings 
	    (p4::form-bindings-from-goal *current-node* *current-goal*
					 (p4::operator-node-operator *current-node*))))
       (when *debug-case-p*
	 (format t "~% proposed-bindings ~S" proposed-bindings)
	 (format t "~% all-bindings ~S" all-bindings))
       (setf *new-bindings* nil)
       (cond
	 ((find proposed-bindings all-bindings
		:test #'(lambda (x y) (exact-bindings-p x y)))
	  t)
	 ((find proposed-bindings all-bindings
		:test #'(lambda (x y) (partially-matched-bindings-p x y)))
	  (when *new-bindings*
	    (setf (guiding-case-additional-bindings *guiding-case*)
		  (append *new-bindings*
			  (guiding-case-additional-bindings *guiding-case*)))
	    (all-guided-goals-cases))
	  t)
	 (t nil))))))

;;; bind-x is the proposed bindings from the case
;;; bind-x may be not fully instantiated, e.g. 
;;; ((<plane> . #<P-O: TRP transport-aircraft>)
;;;  (<loading-place> . #<P-O: LDP loading-place>)
;;;  (<strip> . <S>))
;;; where TRP, and LDP are object names
;;; but <S> is a variable in the case -- partial match.
;;; bind-y is a possible binding in the current problem.
;;; ((<plane> . #<P-O: TRP transport-aircraft>)
;;;  (<loading-place> . #<P-O: LDP loading-place>)
;;;  (<strip> . #<P-O: S strip>))) -- fully instantiated
;;; As a side effect, the function partially-matched-bindings-p
;;; sets a global variable *new-bindings*, e.g. '((<S> . S))
;;; As these are bindings for the same operator it assumes,
;;; that the order of the pairs is the same in bind-x and bind-y.

(defun partially-matched-bindings-p (bind-x bind-y)
  (cond
    ((null bind-x) *new-bindings*)
    ((and (p4::prodigy-object-p (cdar bind-x))
	  (equal (p4::prodigy-object-name (cdar bind-x))
		 (p4::prodigy-object-name (cdar bind-y))))
     (partially-matched-bindings-p (cdr bind-x) (cdr bind-y)))
    ((and (p4::strong-is-var-p (cdar bind-x))
	  (eq (get-class-of (cdar bind-x))
	      (p4::type-name (p4::prodigy-object-type (cdar bind-y)))))
     (push (cons (cdar bind-x) (p4::prodigy-object-name (cdar bind-y)))
	   *new-bindings*)
     (partially-matched-bindings-p (cdr bind-x) (cdr bind-y)))
    ((equal (cdar bind-x)
	    (cdar bind-y))
     (partially-matched-bindings-p (cdr bind-x) (cdr bind-y)))
    (t nil)))

;;; bind-x is the proposed bindings from the case
;;; In exact-bindings-p, bind-x is fully instantiated, e.g. 
;;; ((<plane> . #<P-O: TRP transport-aircraft>)
;;;  (<loading-place> . #<P-O: LDP loading-place>)
;;;  (<strip> . #<P-O: S strip>))).
;;; Note that TRP, LDP, and S are instantiations.
;;; bind-y is a possible binding in the current problem.
;;; ((<plane> . #<P-O: TRP transport-aircraft>)
;;;  (<loading-place> . #<P-O: LDP loading-place>)
;;;  (<strip> . #<P-O: S strip>))) -- fully instantiated.
;;; As these are bindings for the same operator it assumes,
;;; that the order of the pairs is the same in bind-x and bind-y.

(defun exact-bindings-p (bind-x bind-y)
  (cond
    ((null bind-x) t)
    ((and (p4::prodigy-object-p (cdar bind-x))
	  (equal (p4::prodigy-object-name (cdar bind-x))
		 (p4::prodigy-object-name (cdar bind-y))))
     (exact-bindings-p (cdr bind-x) (cdr bind-y)))
    ((equal (cdar bind-x)
	    (cdar bind-y))
     (exact-bindings-p (cdr bind-x) (cdr bind-y)))
    (t nil)))

;;; ***********************************************************
;;; Function called by the decide apply control rule
;;; ***********************************************************

;;; This function is not called by Prodigy if there are
;;; no subgoals.

(defun analogy-decide-apply ()
  (when *analogical-replay* 
    (if *debug-case-p*
	(format t "~%In analogy-decide-apply: *guiding-case* ~S"
		(if (eq *guiding-case* 'no-case)
		    'no-case (guiding-case-name *guiding-case*))))
    (cond
     ((and (eq *guiding-case* 'no-case)
	   *chosen-applicable-op*)
      (if *talk-case-p*
	  (format t "~% Decided to apply unguided."))
      (set-backtracking-alts
       *guiding-cases*
       (remove *chosen-applicable-op* *unguided-applicable-ops*)
       *unguided-goals*)
      t)
     ((and (not (eq *guiding-case* 'no-case))
	   (case-applied-op-p (guiding-case-ptr *guiding-case*)))
      (if *talk-case-p*
	  (format t "~% Decided to apply guided."))
      (set-backtracking-alts
       (remove *guiding-case* *guiding-cases*)
       *unguided-applicable-ops*
       *unguided-goals*)
      t)
     (t nil))))

(defun set-backtracking-alts (cases applicable-inst-ops goal-literals)
  (cond
   (*backtracking*
    (setf (p4::a-or-b-node-goals-left *current-node*)
	  (union
	   (map 'list
		#'(lambda (x) (p4::instantiate-consed-literal
			       (get-case-new-visible-goal
				(guiding-case-ptr x) x)))
		(cases-stopped-at-goals cases))
	   goal-literals))
    (setf (p4::a-or-b-node-applicable-ops-left *current-node*)
	  (union
	   (map 'list
		#'(lambda (x) (get-current-applicable-inst-op
			       (get-case-new-visible-inst-op
				(guiding-case-ptr x) x)))
		(cases-stopped-at-applicable-ops cases))
	   applicable-inst-ops)))
   (t 
    (setf (p4::a-or-b-node-applicable-ops-left *current-node*) nil)
    (setf (p4::a-or-b-node-goals-left *current-node*) nil))))

;;; ***********************************************************
;;; Function called by the decide subgoal control rule
;;; ***********************************************************

;;; This function is not called by Prodigy if there are
;;; no applicable ops.

(defun analogy-decide-subgoal ()
  (when *analogical-replay*
    (if *debug-case-p*
	(format t "~%In analogy-decide-subgoal: *guiding-case* ~S"
		(if (eq *guiding-case* 'no-case)
		    'no-case (guiding-case-name *guiding-case*))))
    (cond
     ((eq *guiding-case* 'no-case)
      ;;(break)
      (cond
       (*chosen-goal*
	(if *talk-case-p*
	    (format t "~% Decided to subgoal."))
	;;Also made here a select rule -- not sure it should be as new planning
	(setf (p4::a-or-b-node-goals-left *current-node*) nil)
	(setf (p4::a-or-b-node-applicable-ops-left *current-node*) nil)
	t)
       (t nil)))
     ((case-applied-op-p (guiding-case-ptr *guiding-case*))
      nil)
     (t
      (if *talk-case-p*
	  (format t "~% Decided to subgoal."))
      (setf (p4::a-or-b-node-goals-left *current-node*) nil)
      (setf (p4::a-or-b-node-applicable-ops-left *current-node*) nil)
      t))))

;;; ***********************************************************
;;; All the reasoning happens at this level on which case to
;;; follow.
;;; ***********************************************************

(defun check-case-to-follow ()
  (setf *chosen-goal* nil *chosen-applicable-op* nil
	*unusable-binding-nodes-names* nil)
  (gather-current-information)
  (setf *chosen-goal* nil
	*chosen-applicable-op* nil)
  (if *debug-case-p*
      (format t "~% In check-case-to-follow ~S" *guiding-case*))
  (let ((guiding-cases *guiding-cases*)
	(unguided-goals *unguided-goals*)
	(unguided-applicable-ops *unguided-applicable-ops*))
    (when (or (eq *merge-mode* 'user) *debug-case-p*)
      (format t "~% ~% Pointer to each case:")
      (dolist (case *guiding-cases*)
	(format t "~%  ~S ~S" (guiding-case-name case) (guiding-case-ptr case)))
      (format t "~% *backtracking-flag* ~S" *backtracking-flag*))
    (when *backtracking-flag*
      (let ((cases-and-unguided (process-after-backtrack)))
	(setf guiding-cases (car cases-and-unguided))
	(setf unguided-goals (nth 1 cases-and-unguided))
	(setf unguided-applicable-ops (nth 2 cases-and-unguided))))
    (case *merge-mode*
      (user
       (format t "~% Guiding case is ~S" (if (eq *guiding-case* 'no-case)
					     "no-case"
					     (guiding-case-name *guiding-case*)))
       (format t "~% Pending goals are: ~S" *current-pending-goals*)
       (format t "~% Applicable operators: ~S" *current-applicable-ops*)
       (format t "~% Unguided goals: ~S" *unguided-goals*)
       (format t "~% Unguided applicable ops: ~S" *unguided-applicable-ops*)
       (user-selected-case-to-follow
	guiding-cases unguided-goals unguided-applicable-ops))
      (serial
       (process-serial-merge
	guiding-cases unguided-goals unguided-applicable-ops))
      (sequential
       (process-sequential-merge
	guiding-cases unguided-goals unguided-applicable-ops))
      (eager-apply
       (process-eager-apply-merge
	guiding-cases unguided-goals unguided-applicable-ops))
      (saba
       (process-saba-merge
	guiding-cases unguided-goals unguided-applicable-ops))
      (saba-cr
       (process-saba-merge
	guiding-cases unguided-goals unguided-applicable-ops))
      (smart
       (process-known-interactions
	guiding-cases unguided-goals unguided-applicable-ops))
      (random
       (process-random-merge
	guiding-cases unguided-goals unguided-applicable-ops)))
    (skip-if-goal-true-or-loop)))

;;; ***********************************************************
;;; Merge-mode 'user
;;; Prompts the user for a new case to follow.
;;; ***********************************************************

(defun user-selected-case-to-follow (guiding-cases unguided-goals unguided-applicable-ops)
  (cond
    ((or unguided-goals unguided-applicable-ops)
     (format t "~% Change guidance to another case or unguided? y/n ")
     (case (read)
       (y
	(format t "Another case? y/n ")
	(case (read)
	  (y
	   (enter-new-case-to-follow guiding-cases))
	  (n
	   (enter-unguided-step-to-follow
	    unguided-goals unguided-applicable-ops))))
       (n
	(if (eq *guiding-case* 'no-case)
	    (enter-unguided-step-to-follow
	     	    unguided-goals unguided-applicable-ops)))))
    (t	  
     (format t "~% Change guidance to another case? y/n ")
     (case (read)
       (y
	(enter-new-case-to-follow guiding-cases))
       (n nil))))
  (if (and (not (eq *guiding-case* 'no-case))
	   (case-applied-op-p (guiding-case-ptr *guiding-case*)))  
      (let ((case-visible-inst-op
	     (get-case-new-visible-inst-op
	      (guiding-case-ptr *guiding-case*)
	      *guiding-case*)))
	(when (not (visible-inst-op-applicable-p case-visible-inst-op))
	  (format t "~% Note that you cannot select a case step that is not applicable.")
	  (format t "~% Redo your choice.")
	  (user-selected-case-to-follow
	   guiding-cases unguided-goals unguided-applicable-ops)))))
	  
(defun enter-new-case-to-follow (guiding-cases)
  (format t "~% List of cases and case steps:")
  (let ((counter 0))
    (dolist (case guiding-cases)
      (format t "~% ~S: ~S ~S"
	      counter (guiding-case-name case) (guiding-case-ptr case))
      (incf counter))
    (let ((step-number (1- counter)))
      (unless (zerop step-number)
	(format t "~% Enter number of case to follow next (no error checking): ")
	(setf step-number (read)))
      (setf *guiding-case* (nth step-number guiding-cases)))))

(defun enter-unguided-step-to-follow (unguided-goals unguided-applicable-ops)
  (format t "~% List of unguided steps:")
  (let ((counter 0))
    (when unguided-goals
      (format t "~% Unguided goals:")
      (dolist (goal unguided-goals)
	(format t "~% ~S: ~S" counter goal)
	(incf counter)))
    (when unguided-applicable-ops
      (format t "~% Unguided applicable Ops:")
      (dolist (applicable-op unguided-applicable-ops)
	(format t "~% ~S: ~S" counter applicable-op)
	(incf counter)))
    (let ((step-number (1- counter)))
      (unless (zerop step-number)
	(format t "~% Enter number of step to follow next (no error checking): ")
	(setf step-number (read)))
      (if (< step-number (length unguided-goals))
	  (setf *chosen-goal* (nth step-number unguided-goals))
	  (setf *chosen-applicable-op* (nth (- step-number (length unguided-goals))
					    unguided-applicable-ops))))
    (setf *guiding-case* 'no-case)))

;;; ***********************************************************
;;; Merge-mode 'sequential
;;; Difference with serial mode is that a case is stopped at
;;; a goal node (rather than only at applicable ops nodes)
;;; ***********************************************************

(defun process-sequential-merge (guiding-cases unguided-goals unguided-applicable-ops)
  (if *debug-case-p*
      (format t "~% In process-sequential-merge ~S" *guiding-case*))
  (if (not (eq *guiding-case* 'no-case))
      (setf *new-unguided-search* t))
  (cond
   ((and (guiding-case-p *guiding-case*)
	 (case-goal-p (guiding-case-ptr *guiding-case*)))
    nil) ;go on with the same *guiding-case*;skip-if-goal-true-or-loop will apply now
   ((and (guiding-case-p *guiding-case*)
	 (case-applied-op-p (guiding-case-ptr *guiding-case*))
	 (visible-inst-op-applicable-p
	  (get-case-new-visible-inst-op
	   (guiding-case-ptr *guiding-case*) *guiding-case*)))
    (saba-applicable-op (cases-stopped-at-applicable-ops guiding-cases)
			unguided-applicable-ops))
   ;;either *guiding-case* 'no-case or *guiding-case* stopped at applied op not applicable
   (unguided-applicable-ops
    (saba-applicable-op (cases-stopped-at-applicable-ops guiding-cases)
			unguided-applicable-ops))
   (unguided-goals
    (setf *guiding-case* 'no-case)
    (when *new-unguided-search* 
      (set-init-x-y-as-node *current-node*)
      (if *guiding-cases*
	  (set-goal-x-y-as-segment
	   (nth 2 (get-case-new-visible-goal (guiding-case-ptr (car *guiding-cases*))
					     (car *guiding-cases*))))
	(set-goal-x-y-as-segment (cdr (assoc '<goal> (car (known `(at-segment <p> <goal>)))))))
      (setf *new-unguided-search* nil))
    (setf *chosen-goal* (car unguided-goals)))
   (guiding-cases
     (setf *guiding-case* (car guiding-cases))
     (process-sequential-merge guiding-cases unguided-goals
			   unguided-applicable-ops))
   (t nil)))

;;; ***********************************************************
;;; Merge-mode 'serial
;;; Continues following current guiding case
;;; ***********************************************************

;;; Assumes that *guiding-case* is set to the guiding case that should
;;; be serially continued to be followed.
;;; guiding-cases are the cases that can be followed.
;;; when returning from backtracking, *guiding-case* is set to be the
;;; guiding case for the first applicable op left.

;;; This is an "intelligent" serial mode -- if all the cases are stopped
;;; at applied op nodes, then it uses saba... to have the real serial mode
;;; is rather stupid, but it should be there in some old version of the
;;; replay code. I may bring it back again, but I don't think it is a good
;;; idea.

(defun process-serial-merge (guiding-cases unguided-goals unguided-applicable-ops)
  (cond
    ((and (guiding-case-p *guiding-case*)
	  (case-goal-p (guiding-case-ptr *guiding-case*)))
     nil) ;go on with the same *guiding-case*;skip-if-goal-true-or-loop will apply now
    ((and (guiding-case-p *guiding-case*)
	  (case-applied-op-p (guiding-case-ptr *guiding-case*))
	  (visible-inst-op-applicable-p
	   (get-case-new-visible-inst-op
	    (guiding-case-ptr *guiding-case*) *guiding-case*)))
     (saba-applicable-op (cases-stopped-at-applicable-ops guiding-cases)
			 unguided-applicable-ops))
    ;either *guiding-case* 'no-case or *guiding-case* stopped at applied op not applicable
    (unguided-applicable-ops
     (saba-applicable-op (cases-stopped-at-applicable-ops guiding-cases)
			 unguided-applicable-ops))
    (unguided-goals
     (setf *guiding-case* 'no-case)
     (setf *chosen-goal* (car unguided-goals)))
    (guiding-cases
     (setf *guiding-case* (car guiding-cases))
     (process-serial-merge guiding-cases unguided-goals
			   unguided-applicable-ops))
    (t nil)))

(defun process-eager-apply-merge (guiding-cases unguided-goals unguided-applicable-ops)
  (let ((all-case-applicable-ops (cases-stopped-at-applicable-ops guiding-cases)))
    (cond
     ((and (null all-case-applicable-ops) (null unguided-applicable-ops))
      (process-serial-merge guiding-cases unguided-goals
			   unguided-applicable-ops))
     (t
      (saba-applicable-op (cases-stopped-at-applicable-ops guiding-cases)
			  unguided-applicable-ops)))))

(defun process-after-backtrack ()
  (when *debug-case-p*
    (format t "~% current-node ~S" *current-node*)
    (format t "~% guiding-cases ~S" *guiding-cases*))
  (setf *backtracking-flag* nil)
  (cond
    ((or (and (p4::goal-node-p *current-node*)
	      (not (eq (p4::goal-node-goals-left *current-node*) :not-computed))
	      (not (eq (p4::goal-node-applicable-ops-left *current-node*) :not-computed)))
	 (and (p4::a-or-b-node-p *current-node*)
	      (not (eq (p4::a-or-b-node-goals-left *current-node*) :not-computed))
	      (not (eq (p4::a-or-b-node-applicable-ops-left *current-node*) :not-computed))))
     (let ((cases-and-unguided
	    (if (p4::goal-node-p *current-node*)
		(get-cases-and-unguided
		 (p4::goal-node-goals-left *current-node*)
		 (p4::goal-node-applicable-ops-left *current-node*))
		(get-cases-and-unguided
		 (p4::a-or-b-node-goals-left *current-node*)
		 (p4::a-or-b-node-applicable-ops-left *current-node*)))))
       (if (car cases-and-unguided)
	   (setf *guiding-case* (caar cases-and-unguided)) ;;first goal left
	   (setf *guiding-case* 'no-case))
       cases-and-unguided))
    (t
     ;;if it backtracks to an op, then it is doing it
     ;; on its own, as op from case is a select rule
     (setf *guiding-case* 'no-case)
     (list nil *unguided-goals* *unguided-applicable-ops*))))

(defun get-cases-and-unguided (goals applicable-ops)
  (let ((guiding-cases nil)
	(unguided-goals nil)
	(unguided-applicable-ops nil))
    (dolist (goal goals)
      (let ((case (case-stopped-at-goal goal)))
	(if case
	    (push case guiding-cases)
	    (push goal unguided-goals))))
    (dolist (applicable-op applicable-ops)
      (let ((case (case-stopped-at-inst-op applicable-op)))
	(if case
	    (push case guiding-cases)
	    (push applicable-op unguided-applicable-ops))))
    (list (reverse guiding-cases)
	  (reverse unguided-goals)
	  (reverse unguided-applicable-ops))))

(defun case-stopped-at-goal (goal)
  (find-if #'(lambda (x)
	       (and (case-goal-p (guiding-case-ptr x))
		    (equal (get-case-new-visible-goal (guiding-case-ptr x) x)
			   (goal-from-literal goal))))
	   *guiding-cases*))

;;; ***********************************************************
;;; Merge-mode 'random
;;; Picks something to do randomly. Note that it can recursively
;;; call itself until a viable choice is made.
;;; ***********************************************************

(defun process-random-merge (guiding-cases-left unguided-goals-left
						unguided-applicable-ops-left)
  ;;randomly selects from the set of *guiding-cases*,
  ;;*unguided-goals* and *unguided-applicable-ops*,
  ;;as computed in gather-current-information.
  (unless (and (null guiding-cases-left)
	       (null unguided-goals-left)
	       (null unguided-applicable-ops-left))
    (let* ((choices (append guiding-cases-left
			    unguided-goals-left
			    unguided-applicable-ops-left))
	   (choice-pos (random (length choices)))
	   (choice (nth choice-pos choices)))
      (when *debug-case-p*
	(format t "~%choices ~S" choices)
	(format t "~% Random choice - ~S" choice))
      (cond
	((guiding-case-p choice)
	 (setf *guiding-case* choice)
	 (if (case-applied-op-p (guiding-case-ptr *guiding-case*))
	     (let ((case-visible-inst-op
		    (get-case-new-visible-inst-op
		     (guiding-case-ptr *guiding-case*)
		     *guiding-case*)))
	       (if (visible-inst-op-applicable-p case-visible-inst-op)
		   nil;;fine random choice
		   (process-random-merge (remove choice guiding-cases-left)
					 unguided-goals-left
					 unguided-applicable-ops-left)))))
	((p4::literal-p choice)
	 (setf *guiding-case* 'no-case)
	 (setf *chosen-goal* choice))
	(t
	 (setf *guiding-case* 'no-case)
	 (setf *chosen-applicable-op* choice))))))

;;; ***********************************************************
;;; Merge-mode 'smart
;;; Uses the known *set-of-interacting-goals*
;;; ***********************************************************

;;; Checks out whether the goal pointed to in the current case can be
;;; subgoaled on, or instead should be put off because of some interaction
;;; with another goal.

(defun process-known-interactions (guiding-cases unguided-goals unguided-applicable-ops)
  (let ((current-goal nil))
    ;; determines if there is interaction between current goal and other ones
    (cond
      ((eq *guiding-case* 'no-case)
       (setq *chosen-goal* (car unguided-goals))
       (setf current-goal (goal-from-literal *chosen-goal*)))
      ((case-goal-p (guiding-case-ptr *guiding-case*))
       (setq current-goal (get-case-new-visible-goal
			   (guiding-case-ptr *guiding-case*)
			   *guiding-case*))))
    (when current-goal
      (let* ((involved-goals (goal-interaction current-goal *case-goals*)))
	;; +--- here, I assume that involved-goals is a pair : I only look
	;; |    at the first goal, assuming that there is only one other goal
	;; |    which is the rejected (put-off) previous "current goal"
	(if *talk-case-p* 
	    (format t "~%Involded goals: ~S" involved-goals))
	(when involved-goals
	  ;; jump to a new case
	  (if *talk-case-p*
	      (format t "~% jumping to a new case --> ~S" 
		      (car (assoc (car involved-goals) *case-goals* :test #'equal))))
	  (setf *guiding-case*
		(cdr (assoc (car involved-goals) *case-goals* :test #'equal)))
	  (if (eq *guiding-case* 'no-case)
	      (setf *chosen-goal* (car involved-goals))))))))

;;; Tests whether the current goal interacts with any of the other
;;; goals, that is whether the pair it constitutes with an other goal 
;;; is a subset of any group of interacting goals.
;;; If this is the case, then the group of interacting goals defined
;;; in *set-of-interacting-goals* (well ordered) is returned.

(defun goal-interaction (goal case-goals)
  (let ((nb-goals (length case-goals)))
    (do ((found nil)
	 (count 0 (+ count 1)))
	((or found (= count nb-goals)) found)
      (unless (equal goal (car (nth count case-goals)))
	(setq found (find (list goal (car (nth count case-goals)))
			  *set-of-interacting-goals*
			  :test #'(lambda (x y) (subsetp x y :test #'equal))))))))


;;; ***********************************************************
;;; Merge-mode 'saba
;;; Subgoals always before applying.
;;; If there are only applicable ops, then choose-applicable-op
;;; will do the saba reasoning to pick the right one.
;;; ***********************************************************

(defun process-saba-merge (guiding-cases unguided-goals unguided-applicable-ops)
  (case *guiding-case*
    (no-case
     (cond
       ((null unguided-goals)
	(cond
	  (guiding-cases
	   (setf *guiding-case* (car *guiding-cases*))
	   (process-saba-merge
	    guiding-cases unguided-goals unguided-applicable-ops))
	  (unguided-applicable-ops
	   (saba-applicable-op nil unguided-applicable-ops))
	  (t nil)))
       (t
	(setf *chosen-goal* (car unguided-goals)))))
    (otherwise
     (cond
       ((case-goal-p (guiding-case-ptr *guiding-case*))
	nil) ;go on with this goal
       (t
	(let ((case-stopped-at-goal
	       (some-case-stopped-at-goal guiding-cases)))
	  (if case-stopped-at-goal
	      (setf *guiding-case* case-stopped-at-goal)
	      (cond 
		(unguided-goals
		 (setf *guiding-case* 'no-case)
		 (setf *chosen-goal* (car unguided-goals)))
		(t
		 (saba-applicable-op (cases-stopped-at-applicable-ops guiding-cases)
				     unguided-applicable-ops))))))))))


(defun process-saba-cr-merge (guiding-cases unguided-goals unguided-applicable-ops)
  (case *guiding-case*
    (no-case
     (cond
       ((null unguided-goals)
	(cond
	  (guiding-cases
	   (setf *guiding-case* (car *guiding-cases*))
	   (process-saba-merge
	    guiding-cases unguided-goals unguided-applicable-ops))
	  (unguided-applicable-ops
	   (saba-applicable-op nil unguided-applicable-ops))
	  (t nil)))
       (t
	(setf *chosen-goal* (car unguided-goals)))))
    (otherwise
     (cond
       ((case-goal-p (guiding-case-ptr *guiding-case*))
	nil) ;go on with this goal
       (t
	(let ((case-stopped-at-goal
	       (some-case-stopped-at-goal guiding-cases)))
	  (if case-stopped-at-goal
	      (setf *guiding-case* case-stopped-at-goal)
	      (cond 
		(unguided-goals
		 (setf *guiding-case* 'no-case)
		 (setf *chosen-goal* (car unguided-goals)))
		(t
		 (saba-applicable-op (cases-stopped-at-applicable-ops guiding-cases)
				     unguided-applicable-ops))))))))))

;;; ***********************************************************

(defun cases-stopped-at-applicable-ops (cases)
  (let ((res nil))
    (dolist (case cases)
      (if (and (case-applied-op-p (guiding-case-ptr case))
	       (visible-inst-op-applicable-p
		(get-case-new-visible-inst-op (guiding-case-ptr case) case)))
	  (push case res)))
    res))

(defun cases-stopped-at-goals (cases)
  (let ((res nil))
    (dolist (case cases)
      (if (case-goal-p (guiding-case-ptr case))
	  (push case res)))
    res))

(defun some-case-stopped-at-goal (cases)
  (find-if #'(lambda (x) 
	       (case-goal-p (guiding-case-ptr x)))
	   *guiding-cases*))

;;; If this function is called, there are no subgoals to
;;; subgoal on and it needs to decide which operator to apply.
;;; If this function is called from process-saba-merge, then
;;; all or none of the *guiding-cases* is stopped at applicable ops.
;;; This is the case because otherwise there would be some goal
;;; pending and saba would have selected subgoaling on it.
;;; Now simple... could be saba-reactive.

(defun saba-applicable-op (cases-applicable unguided-applicable-ops)
  (let ((chosen-inst-op nil))
    (cond
      (cases-applicable
       (setf chosen-inst-op
	     (car (p4::decide-which-one-to-apply
		   (append (map 'list #'(lambda (x)
					  (get-current-applicable-inst-op
					   (get-case-new-visible-inst-op
					    (guiding-case-ptr x) x)))
				cases-applicable)
			   unguided-applicable-ops)))))
      (unguided-applicable-ops
       (setf chosen-inst-op
	     (car (p4::decide-which-one-to-apply
		   unguided-applicable-ops))))
      (t nil))
    (if *debug-case-p*
	(format t "~% In saba-applicable-op: chosen-inst-op ~S" chosen-inst-op))
    (if chosen-inst-op
	(cond
	  ((some #'(lambda (x) (equal-instantiated-ops-p x chosen-inst-op))
		 unguided-applicable-ops)
	   (setf *guiding-case* 'no-case)
	   (setf *chosen-applicable-op* chosen-inst-op))
	  (t
	   (setf *guiding-case* (case-stopped-at-inst-op chosen-inst-op)))))))

(defun case-stopped-at-inst-op (inst-op)
  (find-if #'(lambda (x)
	       (and (case-applied-op-p (guiding-case-ptr x))
		    (equal (get-case-new-visible-inst-op (guiding-case-ptr x) x)
			   (get-visible-inst-op inst-op))))
	   *guiding-cases*))
  
;;; ***********************************************************
;;; Advances cases stopped at the current applicable op
;;; ***********************************************************

(defun advance-cases-stopped-at-same-applied (inst-op)
  (dolist (case *guiding-cases*)
    (when (and (case-applied-op-p (guiding-case-ptr case))
	       (equal (get-case-new-visible-inst-op (guiding-case-ptr case) case)
		      inst-op))
      (advance-case case)
      (smart-advance case))))
	
;;; ***********************************************************
;;; Skips goal loops and goals now true in state
;;; ***********************************************************

(defun skip-if-goal-true-or-loop ()
  ;;(break "In skip")
  (when (and (not (eq *guiding-case* 'no-case))
	     (case-goal-p (guiding-case-ptr *guiding-case*)))
    (let* ((case-visible-goal
	    (get-case-new-visible-goal
	     (guiding-case-ptr *guiding-case*)
	     *guiding-case*))
	   (case-goal-literal
	    (p4::instantiate-consed-literal case-visible-goal)))
      (when *debug-case-p*
	(format t "~% Current pending goals: ~S" *current-pending-goals*)
	(format t "~% Case visible goal: ~S" case-visible-goal))
      ;;it will skip the goal in the case only it is a goal loop or the goal
      ;;is currently true in the state.
      (cond
       ((or (p4::goal-loop-p *current-node* case-goal-literal)
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


(defun skip-goal-loop-or-true-in-state (goal &optional (neg nil))
  (when *talk-case-p*
    (if neg
	(format t "~% Goal ~~ ~S:" goal)
	(format t "~% Goal ~S:" goal))
    (format t "~% Goal causes a goal loop or is true in state.")
    (format t "~% Marking all dependent steps to be skipped. Advancing case."))
  ;; Jim Jan 96: took this skip clause out of the conditional.
  (skip *guiding-case*))

;;; Marks all the nodes achieving the goal pointed to by the pointer
;;; ptr as unusable, that is unusable (or useless) for the problem
;;; being solved.

(defun skip (case)
  (mark-unusable (guiding-case-ptr case))
  (advance-case case)   ; operator
  (mark-unusable (guiding-case-ptr case))
  (advance-case case)   ; bindings
  (pushnew (get-case-node-name (guiding-case-ptr case))
	   *unusable-binding-nodes-names*)
  (mark-unusable (guiding-case-ptr case))
  (advance-case case)   ; goal or applied-op
  (setf (guiding-case-aux-ptr case)
	(guiding-case-ptr case))
  (mark-all-dependent-steps-from-goal (guiding-case-aux-ptr case) case)
  (smart-advance case))

;;; ***********************************************************
;;; Advances the pointer ptr of case one node further:
;;; if the end of case is reached, *guiding-case* is set to another case.
;;; ***********************************************************

(defun advance-case (case)
  (when *debug-case-p*
    (format t "~% In advance case: ~s" (guiding-case-ptr case))
    (format t "~% Showing plist ~S" (p4::nexus-plist (guiding-case-ptr case))))
  (let ((msg (if (getf (p4::nexus-plist (guiding-case-ptr case)) :unusable?)
		 "  " "**")))
    (advance-ptr case)    
    (when (and *ui* (not (null (guiding-case-ptr case))))
      (when (getf (p4::nexus-plist (guiding-case-ptr case)) :ui-node-number)
	(update-ui-node (guiding-case-name case)
			(getf (p4::nexus-plist (guiding-case-ptr case)) :ui-node-number)
			msg))))
  (when (null (guiding-case-ptr case))
    (if *talk-case-p* (format t "~% End of current guiding case."))

    ;; then this case is now useless
    (setf *guiding-cases* (remove case *guiding-cases*))

    (cond
     ((null *guiding-cases*)           ; if no more cases, prodigy has to plan on
      (if *a-star-search* (setf *analogical-replay* nil)) ;this disables the analogy control rules
      (setf *guiding-case* 'no-case)  ; its own: see prob-takeoff for an example
      (if *weaver-search* (restart-case-for-weaver)))
     ((eq (length *guiding-cases*) 1)
      (if *talk-case-p* (format t "~% Switching to the last available case."))
      (setf *guiding-case* (car *guiding-cases*)))
     (t
      (if (eq *merge-mode* 'user)
	  (enter-new-case-to-follow)  ; manual selection of a new case to follow
	  (select-new-case))))))      ; automatic selection 


;;; When Prodigy/Analogy reaches the end of a case, it has to decide what to do:
;;; this is what this function does by selecting arbitrarily the first 
;;; available case and handing it over to check-case-to-follow

(defun select-new-case ()
  (case *merge-mode*
    (serial
     (setf *guiding-case* (car *guiding-cases*)))
    (otherwise
     (setf *guiding-case*
	   (nth (random (length *guiding-cases*)) *guiding-cases*))))
  (check-case-to-follow))

;;; Moves ptr back up; not used -- debugging tool

(defun set-back-case (case)
  (if *debug-case-p* 
      (format t "~% ~s" (guiding-case-ptr case)))
  (setf (guiding-case-ptr case)
	(get-case-parent-node (guiding-case-ptr case))))

(defun mark-all-dependent-steps-from-goal (case-node case)
  (cond
    ((null case-node) 
     (when *debug-case-p*
       (format t "~% End of marking unusable nodes in case ~S"
	       (guiding-case-name case))
       (format t "~% unusable binding nodes were : ~S"
	       *unusable-binding-nodes-names*))
     (setf *unusable-binding-nodes-names* nil))
    ((case-goal-p case-node)
     (cond
       ((subsetp (get-case-node-names-goal-introducing-operators
		  ;; used to be guiding-case-ptr. Same for pushnew
		  ;; below (Jim, Jan 96)
		  (guiding-case-aux-ptr case))
		 *unusable-binding-nodes-names*)
	(mark-unusable case-node)           ; goal
	(advance-aux-ptr case)    ; operator
	(mark-unusable (guiding-case-aux-ptr case))
	(advance-aux-ptr case)    ; bindings
	(mark-unusable (guiding-case-aux-ptr case))
	(pushnew (get-case-node-name (guiding-case-aux-ptr case))
		 *unusable-binding-nodes-names*)
	(advance-aux-ptr case)    ; applied-op or goal
	(mark-all-dependent-steps-from-goal (guiding-case-aux-ptr case) case))
       (t
	(advance-aux-ptr case)    ; operator
	(advance-aux-ptr case)    ; bindings
	(advance-aux-ptr case)    ; applied-op or goal
	(mark-all-dependent-steps-from-goal (guiding-case-aux-ptr case) case))))
    ((case-applied-op-p case-node)
     (if (member (get-case-node-name-introducing-binding-node
		  (guiding-case-aux-ptr case))
		 *unusable-binding-nodes-names*)
	 (mark-unusable (guiding-case-aux-ptr case)))
     (advance-aux-ptr case)       ; applied-op or goal
     (mark-all-dependent-steps-from-goal (guiding-case-aux-ptr case) case))))

(defun mark-unusable (case-node)
  (setf (getf (p4::nexus-plist case-node) :unusable?) t))

;;; Advances the pointer ptr to the next unmarked node

(defun smart-advance (case)
  (when (and (not (eq case 'no-case))
	     (not (null (guiding-case-ptr case))))
    (cond
      ((getf (p4::nexus-plist (guiding-case-ptr case)) :unusable?)
       (advance-case case)
       (smart-advance case))
      (t nil))))

(defun advance-aux-ptr (case)
  (setf (guiding-case-aux-ptr case)
	(car (get-case-children-nodes (guiding-case-aux-ptr case)))))

(defun advance-ptr (case)
  (setf (guiding-case-ptr case)
	(car (get-case-children-nodes (guiding-case-ptr case)))))
	   
;; case-name is a string, e.g. "case-prob1-robot"
(defun active-case-by-name-p (case-name)
  (some #'(lambda (x) 
	    (string= case-name (guiding-case-name x)))
	*guiding-cases*))

(defun guided-literal-p (literal)
  (let ((goal-case-pair 
	 (assoc literal *goals-to-guiding-cases*
		:test #'equal-literal-goal-p)))
    (and (not (null goal-case-pair))
	 (active-case-by-name-p (cdr goal-case-pair)))))

(defun get-case-from-case-name (case-name list-of-cases)
  (find case-name list-of-cases
	:test #'(lambda (x y)
		  (string= x (guiding-case-name y)))))

(defun goal-step-still-open-p (literal case-name)
  (and (active-case-by-name-p case-name)
       (case-goal-left-to-do-p
	literal (get-case-from-case-name case-name *guiding-cases*))))

(defun case-goal-left-to-do-p (literal case)
  (setf (guiding-case-aux-ptr case)
	(guiding-case-ptr case))
  (do ()
      ((null (guiding-case-aux-ptr case)) nil)
    (if (and (not (getf (p4::nexus-plist (guiding-case-aux-ptr case)) :unusable?))
	     (case-goal-p (guiding-case-aux-ptr case))
	     (equal (goal-from-literal literal)
		    (get-case-new-visible-goal (guiding-case-aux-ptr case) case)))
	(return t)
	(advance-aux-ptr case))))

;;; ***********************************************************
;;; Gets all the information in advance to make it possible
;;; about which case to follow at select goal time
;;; ***********************************************************

(defun gather-current-information ()
  (setf *current-pending-goals* ;list of literal
	;; Jim 8/97: changed from delete-if. It should not
	;; alter *pending-goals*.
	(remove-if
	 #'(lambda (goal)
	     (p4::goal-loop-p *current-node* goal))
	 (if p4::*incremental-pending-goals*
	     (cdr p4::*pending-goals*)
	   (p4::give-me-all-pending-goals *current-node*)))
	*current-applicable-ops* ;list of instantiated-op 
	(p4::a-or-b-node-applicable-ops-left *current-node*) 
	*case-goals* (compute-case-goals-in-cases))
  (setf *unguided-goals* nil
	*unguided-applicable-ops* nil)

  ;; goals and applicable-ops are only selected as "unguided" 
  ;; if their top-level goals are not covered,
  ;; or, if these are covered, then the case is not
  ;; active anymore (for some weird reason),
  ;; or the step is not in what is left to do in the case
  ;; first test just simple equality to some current case steps
  ;;(break "before unguided set")
  (dolist (pending-goal *current-pending-goals*)
    (if (or (find pending-goal *guiding-cases*
		  :test #'(lambda (x y)
			    (when
			     (and (case-goal-p (guiding-case-ptr y))
				  (equal (goal-from-literal x)
					 (get-case-new-visible-goal
					  (guiding-case-ptr y) y)))
			     (when (eq *guiding-case* 'no-case) 
			       (setf *guiding-case* y)
			       ;;(break)
			       )
			     t)))
	    (some #'(lambda (x)
		      (goal-step-still-open-p pending-goal x))
		  (gethash (goal-from-literal pending-goal)
			   *all-goals-cases-hash*))) ;;set by load-cases
	nil
	(push pending-goal *unguided-goals*)))
  ;;(break "after unguided set")
  (dolist (applicable-op *current-applicable-ops*)
    (if (or (find applicable-op *guiding-cases*
		  :test #'(lambda (x y)
			    (and (case-applied-op-p (guiding-case-ptr y))
				 (equal (get-visible-inst-op x)
					(get-case-new-visible-inst-op
					 (guiding-case-ptr y) y)))))
	    (let* ((binding-node-in-case
		    (member :guided
			    (p4::nexus-plist
			     (p4::instantiated-op-binding-node-back-pointer
			      applicable-op))))
		   (binding-node-case
		    (if binding-node-in-case
			(car (second binding-node-in-case)) ;name of case 
			nil)))
	      (and binding-node-case
		   (active-case-by-name-p binding-node-case))))
	;;(some #'guided-literal-p
	;;(inst-op-to-top-level-goals applicable-op)))
	nil
	(push applicable-op *unguided-applicable-ops*)))

  (when *debug-case-p*
    (format t "~% Current pending goals ~S" *current-pending-goals*)
    (format t "~% Current applicable ops ~S" *current-applicable-ops*)
    (format t "~% Potential case goals:")
    (dolist (goal-case *case-goals*)
      (format t "~%   goal ~S at case ~S"
	      (car goal-case) (guiding-case-name (cdr goal-case))))
    (format t "~% Unguided goals ~S" *unguided-goals*)
    (format t "~% Unguided applicable ops ~S" *unguided-applicable-ops*))
  t)

(defun compute-case-goals-in-cases ()
  ;; constructs the list of all available goals associated with their
  ;; cases : list of the form (((pred1 arg11 ... arg1n) . case1)
  ;; ((pred2 arg21 ... arg2m) . case2) ... )
  (let ((case-goals nil))
    ;; the current node is not necessarily a goal node if a previous applied-op
    ;; couldn't be applied because of failed preconditions. In this case, the current
    ;; node is this applied-op node and should not be taken into account in the
    ;; contstruction of case-goals
    (dolist (case *guiding-cases*)
      (when (case-goal-p (guiding-case-ptr case))
	(setq case-goals (acons (get-case-new-visible-goal (guiding-case-ptr case) case)
				case case-goals))))
    case-goals))

;;;***********************************************************
;;; Links Prodigy nodes back to cases 
;;;***********************************************************

(defun link-new-node-to-case ()
  (unless (null *previous-link*)
    (when (or (and (p4::goal-node-p *current-node*)
		   (eq (car *previous-link*) 'goal))
	      (and (p4::operator-node-p *current-node*)
		   (eq (car *previous-link*) 'op))
	      (and (p4::binding-node-p *current-node*)
		   (eq (car *previous-link*) 'bindings))
	      (and (p4::applied-op-node-p *current-node*)
		   (eq (car *previous-link*) 'applied)))
      (setf (getf (p4::nexus-plist *current-node*) :guided)
	    (cdr *previous-link*))
      (when *new-bindings*
	  (setf (getf (p4::nexus-plist *current-node*) :new-bindings)
		*new-bindings*)
	  (setf *new-bindings* nil))
      (setf *previous-link* nil))))

;;;***********************************************************
;;; After backtracking, resets links to cases
;;;***********************************************************

(defun backtrack-on-all-cases (path)
  (fresh-start-vars)
  (fresh-clean-begin-cases)
  (do ((this-path path (cdr this-path)))
      ((null this-path))
    (let ((case-guidance (getf (p4::nexus-plist (car this-path))
			       :guided)))
      (when case-guidance
	(backtrack-on-case case-guidance
			   (getf (p4::nexus-plist (car this-path))
				 :new-bindings)))))
  (setf *backtracking-flag* t)
  (all-guided-goals-cases))
  
;; case-guidance is the value of the property :guided
;; e.g. case-guidance is ("case-prob1-hammer" 5)
;; called by p4::maintain-state-and-goals

(defun backtrack-on-case (case-guidance new-bindings)
  (let ((case (get-case-from-case-name (car case-guidance) *guiding-cases*)))
    (set-case-pointer case (cdr case-guidance))
    (setf (guiding-case-additional-bindings case)
	  (append new-bindings
		  (guiding-case-additional-bindings case)))
    (if (null (guiding-case-ptr case))
	(remove case *guiding-cases*))))

(defun set-case-pointer (case case-node-name)
  (cond
    ((eq (p4::nexus-name (guiding-case-ptr case)) (car case-node-name))
     (advance-ptr case)
     nil)
    ((case-goal-p (guiding-case-ptr case))
     (skip case))
    (t
     (format t "~% Something wrong -- where is node ~S" (car case-node-name)))))

;;;***********************************************************
;;; Changes to prodigy4.0
;;;***********************************************************

(in-package "PRODIGY4")

;;; Jim: adding this option to cache in macros.lisp, covered by the
;;; flag *cache-applicables-and-subgoals*, so commenting out the
;;; change here.

#|
(defmacro cache-analogy (slot obj expr)
  `(if (eq (,slot ,obj) :not-computed)
       (setf (,slot ,obj) ,expr)
       (if ,user::*analogical-replay*
	   ,expr
	   (,slot ,obj))))

(defun expand-binding-or-applied-op (node)
  "Expand a binding node"
  (declare (type a-or-b-node node))

  (let* ((next (compute-next-thing node))
	 (applicables (cache-analogy a-or-b-node-applicable-ops-left node
			     (abs-generate-applicable-ops node next)))
	 (subgoals (cache-analogy a-or-b-node-goals-left node
			  (setf (a-or-b-node-pending-goals node)
				(if *incremental-pending-goals*
				    (abs-generate-goals node next)
				    (delete-if #'(lambda (goal)
						   (goal-loop-p node goal))
					       (abs-generate-goals node next)))))))
    (if (and (null applicables) (null subgoals))
	(close-node node :no-choices)
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
	    (otherwise what-next))))))
|#

(setf *smart-apply-p* nil)

(defun choose-applicable-op (node ops)
  (declare (ignore node))
  ;;This assumes somewhere else *guiding-case* was already set
  ;;to be pointing exactly to the right operator to apply.
  ;;Also assumes that the guiding-case node eventually already
  ;;had any additional bindings already filled in.
  (cond
    ((and user::*analogical-replay*
	  (eq user::*guiding-case* 'user::no-case))
     (cond
       (user::*chosen-applicable-op*
	(user::advance-cases-stopped-at-same-applied user::*chosen-applicable-op*)
	user::*chosen-applicable-op*)
       (t nil)))
    ((and user::*analogical-replay*
	  (not (eq user::*guiding-case* 'user::no-case)))
     (cond
       ((user::case-applied-op-p (user::guiding-case-ptr user::*guiding-case*))
	(let* ((case-visible-inst-op (user::get-case-new-visible-inst-op
				      (user::guiding-case-ptr user::*guiding-case*)
				      user::*guiding-case*))
	       (current-inst-op
		(find-if
		 #'(lambda (x)
		     (equal case-visible-inst-op
			    (user::get-visible-inst-op x)))
		 ops)))
	  (incf user::*nodes-followed*)
	  (when user::*talk-case-p*
	    (format t "~% ~S" current-inst-op)
	    (format t "~%Following case ~S ~S -- apply"
		    (user::guiding-case-name user::*guiding-case*)
		    (nexus-name (user::guiding-case-ptr user::*guiding-case*))))
	  (setf user::*previous-link* user::*link*
		user::*link*
		(cons 'user::applied
		      (list (user::guiding-case-name user::*guiding-case*)
			    (user::get-case-node-name
			     (user::guiding-case-ptr user::*guiding-case*)))))
	  (user::advance-case user::*guiding-case*)
	  (user::advance-cases-stopped-at-same-applied current-inst-op)
	  (user::smart-advance user::*guiding-case*)
	  current-inst-op))
       (t
	(format t "~% Weird situation: applicable op selected from case not applicable")
	nil)))
    ((and *smart-apply-p* (eq *running-mode* 'saba))
     (car (decide-which-one-to-apply ops)))
    (t
     (car ops))))

;;; Only change is using this-path to reset the pointers to the cases

;;; Jim - added to vanilla and conditional prodigy and commented this
;;; out. 

#|
(defun maintain-state-and-goals (last-node this-node)
  (declare (type nexus last-node this-node))
  "Maintain state and goal field of literals"

  ;; the common parent is the last node in the two lists that is the
  ;; same. So walk through the two lists while they are the same.  To
  ;; speed things up, only mention applied operator or binding nodes
  ;; in the path.
  (multiple-value-bind (this-node-path this-depth)
      (path-from-root this-node)

    ;;analogical replay - reset pointers to cases when backtracking occurs
    ;;no harm to the rest of the function
    (when (and user::*analogical-replay* (not user::*a-star-search*))
      (user::backtrack-on-all-cases p4::this-node-path))
    ;;end of change for analogical replay
    
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
	   (when (a-or-b-node-p node)
	     (if *incremental-pending-goals*
		 (reverse-pending-goals node))
	     (dolist (application (a-or-b-node-applied node))
	       (do-state application nil) ; that means "undo" state
	       (let ((instop (op-application-instantiated-op application)))
		 (if (instantiated-op-binding-node-back-pointer instop)
		     (set-goals instop)))))
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
	       
	     (when (a-or-b-node-p node)
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
		   (set-goals (binding-node-instantiated-op node))))))
	 
	 ;; added by Mei, march 14
	 ;; compute expanded-goals of the node.
	 (compute-expanded-goals this-node)

         ;; Return the depth of this-node
	 this-depth))))
|#

;;; Very silly bug? -- function in modify-feb6-93.lisp -- why cdr?
;;; This function is called from load-domain and returns the operators
;;; that need to have set the select-bindings-crs  field
;;; for example see with (showop 'move-rocket) after load-domain.

(if (or (not (boundp '*overload-find-current-ops*))
	(not *overload-find-current-ops*))
    (defun find-current-ops (list-structure)
      (let ((found-ops (find-current-ops-2 list-structure)))
	(or found-ops
	    (mapcar #'rule-name
		    ;; Need to get the inference rules too - Jim.
		    (append
		     (problem-space-operators *current-problem-space*)
		     (problem-space-eager-inference-rules *current-problem-space*)
		     (problem-space-lazy-inference-rules *current-problem-space*))
		    ))))
  )
			
(in-package "USER")

;;; ***********************************************************

(defun update-ui-node (case-name pos message)
  (send-to-tcl "Update-case")
  (send-to-tcl case-name)
  (send-to-tcl pos)
  (send-to-tcl message))

;;; ***********************************************************

(defun shuffle (l)
  (let ((res l))
    (dotimes (i (length l))
      (let ((nelt (random (length l))))
	(setf res (cons (nth nelt res)
			(remove (nth nelt res) res)))))
    res))

;;; ***********************************************************
