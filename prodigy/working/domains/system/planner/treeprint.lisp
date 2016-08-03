;;; $Revision: 1.6 $
;;; $Date: 1995/11/12 22:04:40 $
;;; $Author: jblythe $
;;;
;;; REVISION HISTORY
;;;
;;;  $Log: treeprint.lisp,v $
;;; Revision 1.6  1995/11/12  22:04:40  jblythe
;;; Since some external code (analogy and hamlet) calls process-list-for-one
;;; with an application rather than the applied-op-node, this function now works
;;; with either. In treeprint.lisp, brief-print-inst-op checks there is a
;;; binding-node for the instantiated op when *analogical-replay* is true: this
;;; is needed when there are eager inference rules.
;;;
;;; Revision 1.5  1995/10/12  14:23:13  jblythe
;;; Added protection nodes as a node type and search strategy, turned on with
;;; the variable *use-protection* (off by default). Also added the "event"
;;; macro which accepts similar syntax to operators. The new file "protect.lisp"
;;; has the protection code.
;;;
;;; Revision 1.4  1995/10/03  11:04:49  jblythe
;;; Commiting files that were inadvertently edited in the working version
;;; release - two formatting edits by khaigh and a change to printing
;;; instantiated ops when a case is being used for guidance by mmv.
;;;
;;; Revision 1.3  1994/05/30  20:56:34  jblythe
;;; Added Tony Maida's patches to have Prodigy run with CMU Lisp 16 and 17.
;;;
;;; Revision 1.2  1994/05/30  20:30:46  jblythe
;;; Added CVS headers so the revision history and descriptions are included in
;;; each changed file.
;;;


;;;
;;; Contains routines for printing out the search tree, and some
;;; rudimentary interface routines
;;;

(in-package "PRODIGY4")

(defvar *last-node-printed* nil
  "The last node to be printed by the system, for internal use only.")

(defvar *last-goal-node-printed* nil
  "The last goal node printed by the system, for internal use only.")

(defvar *print-search-depth-p* t
  "If not nil, a number specifying the search depth in the tree is printed.")

(export '(treeprint *print-search-depth-p*))

;;; This prints nodes out in a way that looks a bit like Prodigy 2.0
;;; (A bit more like 2.0 after chatting with Manuela)
(defun announce-node (node last-node-created current-depth)
  (declare (fixnum current-depth))
  (let ((*print-case* :downcase)
	(plevel (or (problem-space-property :*output-level*)
		    2)))		; default value.
    (cond ((problem-space-property :print-old-way)
	   (output 2 t "~%~A ~S (depth ~S, parent ~S).~%"
		   (if (eq node last-node-created)
		       "Expanding"
		       "Backtracking to")
		   node current-depth
		   (if (and (typep node 'nexus) (nexus-parent node))
		       (nexus-name (nexus-parent node)))))
	  ((or (not (numberp plevel)) (< plevel 2)))
	  (t (new-style-node-print node last-node-created current-depth)))))

(defun new-style-node-print (node last-node current-depth)
  (declare (fixnum current-depth)
	   (special *current-problem-space* *last-node-printed*))

  (if (eq node *last-node-printed*) (return-from new-style-node-print nil))
  (cond ((and (typep node 'goal-node)
	      ;; Since I don't always print operator-nodes, I want to
	      ;; avoid appearing to repeat myself.
	      (not (eq node *last-goal-node-printed*)))
	 (let ((goal (goal-node-goal node))
	       (alts (if (nexus-parent node)
			 (a-or-b-node-goals-left (nexus-parent node)))))
	   (begin-node-line node last-node current-depth)
	   (treeprint-goal goal)
	   (cond ((and alts (problem-space-property :print-alts))
		  (print-alts node alts))
		 (alts
		  (princ " [")
		  (princ (length alts))
		  (princ "]")))
	   (setf *last-goal-node-printed* node)))
	((typep node 'protection-node)
	 (begin-node-line node last-node current-depth)
	 (format t "Protect ")
	 (treeprint-goal (protection-node-goal node))
	 (format t " from ")
	 (brief-print-inst-op (protection-node-instantiated-op node))
	 (format t " at n~S"
		 (nexus-name
		  (instantiated-op-binding-node-back-pointer
		    (protection-node-instantiated-op node)))))
	((typep node 'a-or-b-node)
	 ;; BUG: alts currently does not include applied ops - same is
	 ;; true for goal nodes.
	 (let ((alts (if (binding-node-p node)
			 (if (nexus-parent node)
			     (operator-node-bindings-left (nexus-parent node)))
			 (if (nexus-parent node)
			     (a-or-b-node-goals-left (nexus-parent node))))))
			     
	   ;; Deal with the line break for backtracking here so as not
	   ;; to do it each time in the list of applications.
	   (unless (eq node last-node) (terpri))
	   (when (binding-node-p node)
	     (begin-node-line node node current-depth)
	     (brief-print-inst-op (a-or-b-node-instantiated-op node)))
	   (print-all-subgoaled-applications node node current-depth)
	   (if (applied-op-node-p node)
	       (check-if-achieved-goal node))
	   (cond ((and alts (problem-space-property :print-alts))
		  (print-alts node alts))
		 (alts
		  (princ " [")
		  (princ (length alts))
		  (princ "]")))))
	;; Only print an operator node if we backtrack to it, from
	;; somewhere other than its own child.
	((and (typep node 'operator-node)
	      (not (eq node last-node))
	      (not (eq (nexus-parent last-node) node)))
	 (announce-operator-node node current-depth last-node))
	)
  (unless (typep node 'operator-node)
    (setf *last-node-printed* node)))

;;; Prints out a goal as it appears in a trace of the problem solving.
(defun treeprint-goal (goal)
  (if (and (literal-state-p goal) (literal-neg-goal-p goal))
      (princ "not "))
  (princ "(") (princ (literal-name goal))
  (dotimes (argnum (length (literal-arguments goal)))
    (let ((arg (elt (literal-arguments goal) argnum)))
      (princ #\Space)
      (print-literal-arg arg)))
  (princ ")"))
	
(defun begin-node-line (node last-node depth)
  (declare (type nexus node)
	   (fixnum depth indent))
  ;; Leave a blank line when we backtrack.
  (unless (eq node last-node) (terpri))
  (terpri)
  (when *print-search-depth-p*
    (format t "~3D" depth)
    (princ #\Space))
  (indent node)
  (princ #\n)
  (unless (and (abs-level) (zerop (abs-level)))
    (princ (nexus-abs-level node))
    (princ #\-))
  (princ (nexus-name node)) (princ #\Space))

(defun indent (node)
  (declare (type nexus node))
  (let ((depth (1- (depth-by-intro-ops node))))
    (dotimes (y depth)
      (princ #\Space) (princ #\Space))))

(defun depth-by-intro-ops (node)
  (cond ((null node) 0)
	((typep node 'goal-node)
	 (+ 1
	    (depth-by-intro-ops (car (goal-node-introducing-operators node)))))
	((typep node 'applied-op-node)
	 (depth-by-intro-ops
	  (instantiated-op-binding-node-back-pointer
	   (applied-op-node-instantiated-op node))))
	(t (depth-by-intro-ops (nexus-parent node)))))

(defun brief-print-inst-op (inst-op)
  (declare (type instantiated-op inst-op))

  (let* ((op (instantiated-op-op inst-op))
	 (vars (rule-vars op))
	 (values (instantiated-op-values inst-op)))
    (princ "<")
    (princ (operator-name op))
    (dolist (argument (cdr (rule-params op)))
      (let ((position (position argument vars)))
	(if (>= position (length values))
	    (error "Trying to print a parameter that is not in the
bindings for operator ~S - perhaps some of the parameters are not in
the preconditions?" op))
	(let ((value (elt values position)))
	  (princ #\Space)
	  (if (listp value) (princ argument)
	      (print-literal-arg value)))))
      (princ ">"))
  (when (and user::*analogical-replay*
	     (p4::instantiated-op-binding-node-back-pointer inst-op))
    (let ((guidance (getf (p4::nexus-plist
			   (p4::instantiated-op-binding-node-back-pointer inst-op))
			  :guided)))
      (if guidance (format t " ~S" guidance)))))


(defun print-literal-arg (x)
  (princ
   (if (prodigy-object-p x) (prodigy-object-name x) x)))

(defun print-all-subgoaled-applications (node last-node current-depth)
  (declare (type a-or-b-node node)
	   (ignore last-node)
	   (fixnum indentation))
  (let ((*print-case* :upcase))
    (do* ((applist (reverse (a-or-b-node-applied node)) (cdr applist))
	  (applop (if applist (op-application-instantiated-op (car applist)))
		  (if applist (op-application-instantiated-op (car applist)))))
	 ((null applist) nil)
      ;; It's subgoals iff it has a binding node back pointer
      (when (instantiated-op-binding-node-back-pointer applop)
	(begin-node-line node node current-depth)
	(brief-print-inst-op applop)))))

(defun print-alts (node alts)
  "Print the alternatives out nicely."
  (terpri)
  (dotimes (i 6) (princ #\Space))
  (indent node)
  (princ "(")
  (treeprint-alt (car alts))
  (dolist (goal (cdr alts))
    (princ #\Space) (treeprint-alt goal))
  (princ ")"))

(defun treeprint-alt (object)
  (if (typep object 'literal)
      (treeprint-goal object)
      (brief-print-inst-op object)))

;;; This function is used to print the final solution out to the user.
;;; The plan is a list of instantiated-operators.
(defun announce-plan (plan)
  (declare (list plan))

  (let ((plevel (or (problem-space-property :*output-level*) 2)))
    (when (> plevel 0)
      (cond ((and (consp (car plan)) (consp (caar plan))
		  (eq (caaar plan) :partial-achieve))
	     (format t "~%I didn't completely solve the problem,")
	     (if (eq (second (car (second (car plan)))) :resource-bound)
		 (format t "~%because I exceeded a resource bound, ~S,"
			 (third (car (second (car plan))))))
	     (format t "~%but I solved ~S of the top-level goals with this plan:~%~%"
		     (length (third (caar plan)))))
	    (t
	     (format t "~%~%Solution:~%")))
      (let ((*print-case* :downcase))
	(dolist (op (cdr plan))
	  (princ #\Tab)
	  (brief-print-inst-op op)
	  (terpri)))
      (terpri))))

(defun announce-failure (failure node depth-bound current-depth)
  (declare (fixnum depth-bound))

  (let* ((plevel-raw (problem-space-property :*output-level*))
	 (plevel (if (and plevel-raw (numberp plevel-raw))
		     plevel-raw
		     2))
	 (old-way? (problem-space-property :print-old-way)))
    (if old-way?
	(announce-failure-old failure node depth-bound)
	(announce-failure-new failure node depth-bound plevel current-depth))))

(defun announce-failure-old (failure node depth-bound)
  (case failure
    (:state-loop (output 1 t "~&Hit state loop at ~S.~%" node))
    (:depth-exceeded (output 1 t "~&Hit depth bound (~S) at ~S.~%"
			     depth-bound node))
    (:no-op (output 1 t "~&No relevant operators~%"))
    (:not-refineable (output 1 t "~&Couldn't refine the plan."))))

(defun announce-failure-new (failure node depth-bound plevel current-depth)
  (if (> plevel 1)
      (case failure
	(:state-loop (princ " ...applying leads to state loop."))
	((:no-binding-choices :no-good-bindings)
	 (announce-operator-node node current-depth)
	 (princ " ...no choices for bindings")
	 (if (eq failure :no-binding-choices)
	     (princ " (I tried)")))
	(:depth-exceeded
	 (princ  " ...hit depth bound (")
	 (princ depth-bound) (princ ")"))
	;;(:causes-goal-loop (princ " ...causes a goal loop."))
	(:no-choices (princ " ...no pending goals."))
	(:no-op (princ " ...no relevant operators."))
	(:not-refineable
	 (princ " ...couldn't refine at level ")
	 (princ (1- (nexus-abs-level node))))
	(:uses-unsolvable-goal
	 (princ " ...requires an unsolvable precondition."))
	(t (cond ((and (consp failure) (eq (car failure) :causes-goal-loop))
		  (when (operator-node-p node)
		    (announce-operator-node node current-depth))
		  (princ " ...goal loop with node ")
		  (princ (nexus-name (second failure))))
		 (t
		  (terpri) (indent node) (princ failure)))))))

(defun announce-operator-node (node depth &optional (last-node node))
  (declare (type operator-node node))
  (begin-node-line node last-node depth)
  (let ((*print-case* :downcase))
    (princ (rule-name (operator-node-operator node)))))

(defun announce-solution (node depth)
  (let ((plevel (or (problem-space-property :*output-level*) 2)))
    (when (> plevel 1)
      (announce-node node node depth)
      (terpri)
      (princ "Achieved top-level goals.")
      (unless (zerop (nexus-abs-level node))
	(princ " (Abstraction level ")
	(princ (nexus-abs-level node))
	(princ ") ")))))
  

;;; function: treeprint
;;; Author: Jim
;;; Date: 17 Mar 91
;;; Arguments: node to use as root (defaults to the root of
;;;            *current-problem-space*)
;;;          : indentation between children (defaults to 2 spaces).
;;;          : stream to print to (defaults to t)
;;;          : terse means whether to print just number or whole thing
;;;          : (defaults to nil, meaning whole node)

(defun oldtreeprint
    (&key (node (getf (problem-space-plist *current-problem-space*)
		      :root))
	  (indent 2)
	  (stream t)
	  (terse nil))
		     
  (declare (type nexus node)
	   (fixnum indent))
  (treepr-r node indent stream terse ""))

(defun treepr-r (node indent stream terse prefix)
  (declare (type nexus node)
	   (fixnum indent)
	   (string prefix))
  (format stream "~A~S~%" prefix (if terse (nexus-name node) node))
  (if (nexus-children node)
      (let ((newprefix (concatenate 'string prefix " |")))
	(dolist (child (nexus-children node))
	  (treepr-r child indent stream terse newprefix)))))



;;====================================
;; Utilities
;;====================================

(defun output-level (n)
  "Set the amount of output while searching - an integer between 0 and 2
0 - say nothing
1 - only mention operator applications, state loops, depth bounds and
    load-domain errors.
2 - print every node
3 - print control rule firings.
   Defaults to 2"

  (cond ((not (and (boundp '*current-problem-space*)
		   (typep *current-problem-space* 'problem-space)))
	 (format t "There is no current problem space.~%"))

	(t
	 (do ((value n (read)))
	     ((and (integerp value) (>= value 0) (<= value 3))
	      (setf (problem-space-property :*output-level*)
		    value))
	   (format t "~%I read ~S~%Please type an integer 0 - 3 > " value)))))

(defun output (level stream fmt-string &rest args)
  (declare (integer level)
	   (type (or stream symbol) stream)
	   (string fmt-string))

  (let ((pspace-level (problem-space-property :*output-level*)))
    (if (and pspace-level (>= pspace-level level))
	(apply #'format `(,stream ,fmt-string ,@args)))))


;;; ******************************************************************
;;; Functions from Prodigy2 interface.lisp

(defun read-atoms ()
  "return the input line as a single list of atoms."
  (let ((ins ""))
    (loop 
     (setq ins (concatenate 'string ins " " (read-line)))
     (and (evenp (double-quote-count ins))
	  (<= (paren-count ins) 0)
	  (return (string-intern ins))))))


(defun double-quote-count (s)
  "counts the number of double quote characters in a string."
  (let ((c 0))
    (dotimes (i (length s) c)
      (cond ((char-equal #\" (aref s i)) (incf c))))))


(defun paren-count (s)
  "counts the levels of open parentheses in a string, making sure
 to ignore any parentheses inside a string literal (double quote)."
  (let ((c 0) (lit nil))
    (dotimes (i (length s) c)
      (if lit 
	  (cond ((char-equal #\" (aref s i)) (setq lit nil)))
	  (cond ((char-equal #\" (aref s i)) (setq lit t))
		((char-equal #\( (aref s i)) (incf c))
		((and (char-equal #\) (aref s i)) (> c 0))
		 (setq c (1- c))))))))



(defun string-intern (s)
  "given a string {s}, this routine will return a list containing 
the objects within  the string."
  (cond ((null-string s) nil)
	((null-string (cdr-string s)) (values (list (car-string s))))
	(t (append (list (car-string s)) 
		   (string-intern (cdr-string s))))))

(defun null-string (s)
  "this tests for an empty string."
  (and (stringp s) 
       (setq s (string-trim '(#\space #\tab #\newline) s))
       (= 0 (length s))
       s))

(defun car-string (s)
  "given a string {s}, this function returns the first list or 
 word as a lisp object (atom or list)."
  (let ((obj nil) (len 0))
    (unless (null-string s)
      (setq s (string-trim '(#\space #\tab #\newline #\\ #\|) s))
      (multiple-value-setq (obj len)
	(read-from-string s nil "")))
    (values obj s len)))

(defun cdr-string (s)
  "given an input string {s}, it removes the first word/list
 and returns the remainder of the string."

  (and (stringp s)
       (let ((c nil)(lc nil))
	 (multiple-value-setq (c s lc)
	   (car-string s))
	 (subseq s lc))))


;;; Check if the application actually achieved the desired goal - this
;;; doesn't always happen because of functions used as generators in
;;; the effects.
(defun check-if-achieved-goal (node)
  (declare (type applied-op-node node))
  (let* ((instop (applied-op-node-instantiated-op node))
	 (binding-node (instantiated-op-binding-node-back-pointer instop))
	 (goal-node  (nexus-parent (nexus-parent binding-node)))
	 (goal (goal-node-goal goal-node))
	 (intro-op-nodes (goal-node-introducing-operators goal-node))
	 (intro-op (if intro-op-nodes
		       (binding-node-instantiated-op
			(car intro-op-nodes)))))
    ;; If intro-op can't be found, assume its goal was achieved
    ;; fortuitously. Jim 9/93. Or that it was (done) which has no
    ;; intro-ops. (Jim 3/94).
    (if (and intro-op
	     (or (and (member intro-op (literal-goal-p goal))
		      (not (literal-state-p goal)))
		 (and (member intro-op (literal-neg-goal-p goal))
		      (literal-state-p goal))))
	(output 2 t " warning: desired goal was not achieved"))))
