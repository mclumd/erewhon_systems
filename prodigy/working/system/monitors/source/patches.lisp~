(in-package p4)

(export '(FIND-NODE))


;;; This file contains rewritten code from the planner.

;;; This function appears to be the function that removes embedded existentials
;;; from forall clauses during load-domain.
;;;
;(defun check-quantified-exp (exp parity)
;  (declare (special *defined-vars* *checked-op* *checked-part*))
;  (cond ((< (length exp) 3)
;	 (error "Quantified expression ~S too short in rule ~S.~%"
;		exp (car *checked-op*)))
;	((> (length exp) 3)
;	 (error "Quantified expression ~S too long in rule ~S.~%"
;		exp (car *checked-op*))))
;  (let ((*defined-vars* (check-variable-generators (second exp) *defined-vars*)))
;    (declare (special *defined-vars*))
;    ;; Stick the generator expression from a "true exists" on the list
;    ;; for the precond expression.
;    (if (eq (car exp) (if parity 'user::exists 'user::forall))
;	(setf (second *checked-part*)
;	      (append (second exp) (second *checked-part*))))
;    (check-expression (third exp) parity)))


(in-package user)

;;; The following two functions are from meta-predicates.lisp

(defun candidate-node (node)
  "Tests whether a node is among the candidate set of nodes in the
tree. Can be used as a generator."
  (declare (special *current-problem-space* *candidate-nodes*))
  ;; Used to check to see if *candidate-nodes* is bound, and if so, set
  ;; candidates to that, even if nil. [22nov97 cox]
  (let ((candidates (or (and (boundp '*candidate-nodes*) *candidate-nodes*)
			(p4::problem-space-property :expandable-nodes))))
    (cond ((p4::strong-is-var-p node)
	   (mapcar #'(lambda (cand) (list (cons node cand)))
		   candidates))
	  ((typep node 'p4::nexus)
	   (if (member node candidates) t))
	  ((typep node 'fixnum)
	   (if (member (find-node node) candidates) t)))))

;;; Same kind of changes as above.
(defun candidate-goals ()
  (declare (special *candidate-goals* *current-node*))
  (remove-if #'(lambda (x)(p4::goal-loop-p *current-node* x))
	     (or (and (boundp '*candidate-goals*)
		 *candidate-goals*)
	       (p4::a-or-b-node-pending-goals
		(give-me-a-or-b-node *current-node*)))))


(in-package p4)

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
		 ((and (a-or-b-node-p node)
		       ;; Do not undo if previously executed [cox]
		       (not (has-been-executed? node)))
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
		   ((and (a-or-b-node-p node)
			 ;; Do not redo if previously executed [cox]
			  (not (has-been-executed? node)))
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


;;; Changed the function that undoes and redoes applied operations when
;;; backtracking or otherwise moving within the search tree. Because new
;;; information can asynchronously be sensed in the environment, we do not want
;;; the function to undo a change that was sensed even though an applied
;;; operator had also made the change. Instead, the function should skip this
;;; change, leaving it in place. 
;;;
;;; One problem with this formulation is thgat it is a one-shot protection. If
;;; the system should have to backtrack over two applications that change the
;;; literal in question, the second one will alter it.
;;;
;;; Make sure that there are no exceptions that occur such that the state should
;;; be changed.
;;;
(defun do-state (application forwardsp)
  (declare (type op-application application))
  "Apply the state changes made by this applied operator. If forwardsp
is t, the application is done, if it is nil, the application is reversed."
  (let* ((adds (op-application-delta-adds application))
	 (dels (op-application-delta-dels application)))
    ;; If forwards, delete the deletes then add the adds. If
    ;; backwards, delete the adds then add the deletes.
    (dolist (deleted (if forwardsp dels adds))
	    ;; Added protection [24nov97 cox]
	    (if (user::is-protected-p deleted)
		(user::reset-protection deleted)
	      (set-state-p deleted nil)))
    (dolist (added (if forwardsp adds dels))
	    ;; Added protection [24nov97 cox]
	    (if (user::is-protected-p added)
		(user::reset-protection added)
	      (set-state-p added t))))
  )



;;;
;;; Modify to print leading part of plan that was already executed. [13oct97
;;; cox]
;;;
(defun prepare-plan (result)
  (cond ((and (consp result) (consp (car result))
	      (eq (cdar result) :achieve))
	 (cons result
	       (mapcan #'(lambda (node)
			   (nreverse
			    (mapcar #'op-application-instantiated-op
				    (a-or-b-node-applied node))))
		       ;; Added [cox]. Watch out for removing duplicates that
		       ;; you did not intend to remove.
		       (remove-duplicates 
			(append *execution-queue*
				(cdr (path-from-root (cdr result)
						     #'a-or-b-node-p)))
			:test #'equal))))
	;; If a resource bound was exceeded, let's see if we have
	;; achieved some of the top-level conjunction. The function
	;; "prepare-partial-plan" is loaded in from /contrib
	((and (consp result) (listp (car result))
	      (eq (second (car result)) :resource-bound))
	 (if (fboundp 'prepare-partial-plan)
	     (prepare-partial-plan result)))
	))


;;;
;;; Note that this is going to override the code in overload.lisp that handles
;;; the saving of control rule justifications.
;;;
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
	     ;; This was change from overload.lisp [cox 25feb97]
	     (when (and (boundp user::*load-patches*)
			user::*load-patches*
			*my-crl-name*)
		   (setf (getf (p4::nexus-plist binding-node) :why-chosen)
			 (if (getf (p4::nexus-plist binding-node) :why-chosen) 
			     (cons *my-crl-name* (getf (p4::nexus-plist binding-node) :why-chosen))
			   *my-crl-name*))
;		   (break)
		   (setf *my-crl-name* nil))
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
	     ;; Create monitor when forall in precondition [13oct97 cox]
	     ;; Also monitor for all other preconditions [17nov97 cox]
	     (when user::*use-monitors-p*
		   (user::try-2-create-forall-handler binding-node)
		   (user::create-precond-handlers binding-node))
	     binding-node))

	  (t :no-chosen-binding))))


;;; close-node is called when we find there are no more children to
;;; expand at a node. Delete the node from the list of expandable
;;; nodes in the problem space, and then maybe propagate the failure
;;; back up to do some dependency-directed backtracking type stuff.
;;; Returns the failure.

;;; This isn't perfect - for example if closing a node because it
;;; can't be refined is enough to tell us we could kill off a goal
;;; loop, we'll miss that. But hey, it's a start.

(defun close-node (node &optional failure)
  (declare (type nexus node)
	   (special *current-problem-space*))
  "Delete the node from the list of nodes."

  ;; this test stops infinite recursion.
  (when (not (getf (nexus-plist node) :under-deletion))
    (setf (getf (nexus-plist node) :under-deletion) t)

    ;;Mark so monitor can tell if previously closed node needs to be
    ;;reopened. [14oct97 cox]
    (setf (getf (nexus-plist node) :closed) t)

    ;; This bit removes this node.
    (delete-node-link node *current-problem-space*)
    (setf (problem-space-property :expandable-nodes)
	  (delete node (problem-space-property :expandable-nodes)))

    ;; Record the reason to close the node if we know it.
    ;; Daniel. Added the test to whether it is a solution node, so
    ;; that when finding multiple-sols, it will not change the label
    ;; of a solution leaf node

    (if (and failure
	     (not (eq :achieve (getf (nexus-plist node)
				     :termination-reason))))
	(setf (getf (nexus-plist node) :termination-reason)
	      failure))

    ;; Propagate the node closing if we can.
    ;; refine failures are propagated regardless of the node type.
    (if (eq failure :not-refineable)
	(let* ((deepest (elt (problem-space-property :deepest-point)
			     (1- (nexus-abs-level node))))
	       (ancestor (and deepest (not (eq deepest node))
			      (ancestor deepest node))))
	  (if ancestor
	      (close-node (nexus-parent node) :not-refineable)))

      (unless (problem-space-property :chronological-backtracking)
	(typecase node
	  (operator-node
	   (check-term-goal-node (nexus-parent node) node failure))
	  (binding-node
	   (check-term-operator-node (nexus-parent node) node failure))
	  (goal-node
	   (check-term-intro-nodes (goal-node-introducing-operators node)
				   node failure)))))
    (setf (getf (nexus-plist node) :under-deletion) nil))
  failure)




;;;=====================
;;; Book Keeping
;;;
(defun do-book-keeping-to-reopen-node (node &optional parent)
  (declare (type nexus node)
	   (special *current-problem-space*))
  "Maintain names and list of nodes.."

  ;; Probably should insert node into the list between the open node above and
  ;; below it in the search tree, rather than pushing it onto the list. And
  ;; what does depth-first or breadth first search mean when nodes can reopen
  ;; anyhow? [14oct97 cox].
  (push-previous node *current-problem-space*)
  (push node (problem-space-property :expandable-nodes))
  (set-node-name node)
  (setf (nexus-conspiracy-number node) 1)
  #| 
  (format t "~%Forwards: ")
  (print-previous-list (return-next *current-problem-space*))
  (format t "~%Backwards: ")
  (print-node-list (return-previous *current-problem-space*))
|#
  ;;Added the next assignment. [14oct97 cox]
  (setf (getf (p4::nexus-plist bnode) :closed) nil)
  ;; Is this next step OK? Yes, because parent not passed. But should it be?
  ;; [cox]
  (if parent (push node (nexus-children parent))))



(defun find-node (name &optional (abstraction-level 0))
  (declare (fixnum abstraction-level))
  ;; Added this escape. [15oct97 cox]
  (if (null (problem-space-property :root))
      (return-from find-node))
  ;; First find the root at the right level.
  (let* ((root (problem-space-property :root))
	 (top-goal (first (nexus-children root)))
	 (toplevel (nexus-abs-level root)))

    ;; If the user asks for the node numbered 1, it can only be found at
    ;; the top abstraction level.
    (cond ((or (zerop name) (= name 1))
	   (return-from find-node root))
	  ((> abstraction-level toplevel)
	   (format
	    t "~%There are no nodes at abstraction level ~S (highest is ~S)~%"
	    abstraction-level toplevel)
	   nil)
	  (t
	   (dotimes (iters (- toplevel abstraction-level))
	     (if top-goal
		 (setf top-goal (first (nexus-abs-children top-goal)))
		 (return-from find-node nil)))
	   ;; Then search from there.
	   (if top-goal
	       (find-node-at-level name top-goal)))))
  )

;;; The following code is UI-specific.


;;; This constant and the predicate below also are defined in the .clinit.cl
;;; file so that other loader files can use the functions.
;;;
(defconstant *Pushkin* "id: #x-7f836c05"
  "The string returned by a call of machine-instance when lisp runs on Pushkin.")

;;;
;;; This predicate depends on global constant *Pushkin* above. Knowing whether
;;; the code runs on pushkin is important because Pushkin runs Solaris (not
;;; SunOS) and Allegro 4.3 (not 4.2) from local disks (not afs). The predicate
;;; is used to set path names in gobal program parameters.
;;;
(defun running-on-pushkin-p ()
  "Predicate returns t iff the code runs on the Sparc called pushkin.prodigy.cs.cmu.edu."
  (equal (machine-instance)
      *Pushkin*)
  )


;;; Commented out this next cond clause (used to be in init-execute.lisp; i.e.,
;;; what was the loader file) and instead modify prod-ui below to load tcl code
;;; for monitors [20dec97 cox]

;(cond ((boundp '*shell-stream*)       
;       (send-shell (concatenate 'string 
;				"source "
;				*monitor-directory*
;				"monitor.tcl"))
;       (send-shell (concatenate 'string 
;				"source "
;				*monitor-directory*
;				"overload.tcl"))
;       )
;      (t 
;       (format t "~%UI not running. Remember to call (tcl-exec) after starting UI.~%")
;       (defun tcl-exec ()
;	 (when (boundp '*shell-stream*)
;	       (send-shell (concatenate 'string 
;					"source "
;					*monitor-directory*
;					"monitor.tcl"))
;	       (send-shell (concatenate 'string 
;					"source "
;					*monitor-directory*
;					"overload.tcl"))
;	       )
;	 )))


#+original
(defun prod-ui (&optional manual-ui)
  (when (not (boundp '*TCL-HOME*))
	(load (concatenate 'string *system-directory* "ui/ui.lisp"))
	;;Redefine prod-ui, because ui.lisp redefines it without the loading of
	;;the monitor tcl code.
	(defun prod-ui (&optional manual-ui)
	  (let ((tcl-lib (concatenate 'string *tcl-home* 
				      "lib"
				      ))
		(tcl-bin (concatenate 'string *tcl-home*
				      (if (running-on-pushkin-p)
					  "bin"
					"tk4.2/unix")
				      )))
	    ;; Create dummy problem-space if none already exists. [cox 28may97]
	    (if (not (boundp 
		      '*current-problem-space*))
		(setf *current-problem-space* 
		      (p4::make-problem-space :name 'dummy)))
	    (format t "~%Restarting tcl server..")
	    (kill-tcl-server :silent t)
	    (start-tcl-server t)	; tcl7.5 only supports tcp sockets
	    (init-shell)
	    (unless (probe-file 
		     (concatenate 
		      'string 
		      tcl-bin 
		      ;;NOTE that if Tcl/Tk has been installed the binary file is
		      ;;called wish4.2. Thus, the person installing PRODIGY should set
		      ;;a symbolic link from it to the name "wish".
		      "/wish"))
		    (setf tcl-lib  *tcl-home*)
		    (setf tcl-bin  *tcl-home*))
	    (send-shell (format nil "setenv TCL_LIBRARY \"~A~A\""
				(if (running-on-pushkin-p)
				    tcl-lib
				  *tcl-home*)
				(if (running-on-pushkin-p)
				    "tcl7.6"
				  "tcl7.6/library")
				))
	    (send-shell (format nil "setenv TK_LIBRARY \"~A~A\""
				tcl-lib
				(if (running-on-pushkin-p)
				    "tk4.2"
				  "tk4.2/library")
				))    
	    (unless manual-ui
		    (send-shell (format nil "~A~A -geometry 1x1+0+0" 
					tcl-bin
					"/wish"
					))
		    (sleep 5)
		    (send-shell (format nil 
					"source ~A/ui-start.tcl" 
					*prod-ui-home*
					))
		    (sleep 1)
		    (if *tcl-customizations*
			(send-shell (format nil "source ~A" *tcl-customizations*)))
		    (sleep 1)
		    (send-shell (format nil 
					"source ~A/ui-comm.tcl" 
					*prod-ui-home*)) ;[cox 15dec96]
		    (if *post-tcl-customizations*
			(send-shell (format nil "source ~A" *post-tcl-customizations*)))
		    ;; The following is the sole modification to prod-ui for use with
		    ;; monitors. [20dec97 cox]
		    (when *use-monitors-p* ;Flag in parameters.lisp
			  (send-shell (concatenate 'string 
						   "source "
						   *monitor-directory*
						   "monitor.tcl"))
			  (send-shell (concatenate 'string 
						   "source "
						   *monitor-directory*
						   "overload.tcl"))
			  )
		    )
	    ;; UI begins in generative mode.
	    (setf *analogical-replay* nil) ;[cox 26jan97]
	    )))
  (let ((tcl-lib (concatenate 'string *tcl-home* 
			      "lib"
			      ))
	(tcl-bin (concatenate 'string *tcl-home*
			      (if (running-on-pushkin-p)
				  "bin"
				"tk4.2/unix")
			      )))
    ;; Create dummy problem-space if none already exists. [cox 28may97]
    (if (not (boundp 
	      '*current-problem-space*))
	(setf *current-problem-space* 
	      (p4::make-problem-space :name 'dummy)))
    (format t "~%Restarting tcl server..")
    (kill-tcl-server :silent t)
    (start-tcl-server t)		; tcl7.5 only supports tcp sockets
    (unless *shell-stream*
	    (setf *shell-stream*
		  (excl:run-shell-command "csh" :wait nil :input :stream)))
    (unless (probe-file (concatenate 'string tcl-bin
				     "/wish"))
	    (setf tcl-lib  *tcl-home*)
	    (setf tcl-bin  *tcl-home*))
    (send-shell (format nil "setenv TCL_LIBRARY \"~A~A\"" 
			(if (running-on-pushkin-p)
			    tcl-lib
			  *tcl-home*)
			(if (running-on-pushkin-p)
			    "tcl7.6"
			  "tcl7.6/library")
			))
    (send-shell (format nil "setenv TK_LIBRARY \"~A~A\"" 
			tcl-lib
			(if (running-on-pushkin-p)
			    "tk4.2"
			  "tk4.2/library")
			))    
    (unless manual-ui
	    (send-shell (format nil "~A~A -geometry 1x1+0+0" 
				tcl-bin
				"/wish"
				))
	    (sleep 5)
	    (send-shell (format nil 
				"source ~A/ui-start.tcl" 
				*prod-ui-home*
				))
	    (sleep 1)
	    (if *tcl-customizations*
		(send-shell (format nil "source ~A" *tcl-customizations*)))
	    (sleep 1)
	    (send-shell (format nil 
				"source ~A/ui-comm.tcl" 
				*prod-ui-home*)) ;[cox 15dec96]
	    (if *post-tcl-customizations*
		(send-shell (format nil "source ~A" *post-tcl-customizations*)))
	    ;; The following is the sole modification to prod-ui for use with
	    ;; monitors. [20dec97 cox]
	    (when *use-monitors-p*	;Flag in parameters.lisp
		  (send-shell (concatenate 'string 
					   "source "
					   *monitor-directory*
					   "monitor.tcl"))
		  (send-shell (concatenate 'string 
					   "source "
					   *monitor-directory*
					   "overload.tcl"))
		  )
	    )
    ;; UI begins in generative mode.
    (setf *analogical-replay* nil)	;[cox 26jan97]
    ))



;;; Not using -f so that tcl code can be run before the main ui, which
;;; is necessary under the current scheme for adding to the menu windows.
;;;
;;; Added manual-ui switch to allow loading of tcl code from a separate
;;; tcl window if desired (just pass non-nil arg). If so then prod-ui 
;;; will not source the tcl code. [cox 5may97]
;;;
(defun prod-ui (&optional manual-ui)
  (when (not (boundp '*TCL-HOME*))
	(load (concatenate 'string *system-directory* "ui/ui.lisp"))
	;;Redefine prod-ui, because ui.lisp redefines it without the loading of
	;;the monitor tcl code.
	(defun prod-ui (&optional manual-ui)
	  (let ((tcl-bin (concatenate 'string *tcl-home*
				      (if (probe-file
					   (concatenate 'string 
							*tcl-home*
							"bin/wish"))
					  "bin"
					"tk4.2/unix")
				      )))
	    ;; Create dummy problem-space if none already exists. [cox 28may97]
	    (if (not (boundp 
		      '*current-problem-space*))
		(setf *current-problem-space* 
		      (p4::make-problem-space :name 'dummy)))
	    (format t "~%Restarting tcl server..")
	    (kill-tcl-server :silent t)
	    (start-tcl-server t)	; tcl7.5 only supports tcp sockets
	    (init-shell)
	    (unless manual-ui
		    (send-shell (format nil "~A~A -geometry 1x1+0+0" 
					tcl-bin
					"/wish"
					))
		    (sleep 5)
		    (send-shell (format nil 
					"source ~A/ui-start.tcl" 
					*prod-ui-home*
					))
		    (sleep 1)
		    (if *tcl-customizations*
			(send-shell (format nil "source ~A" *tcl-customizations*)))
		    (sleep 1)
		    (send-shell (format nil 
					"source ~A/ui-comm.tcl" 
					*prod-ui-home*)) ;[cox 15dec96]
		    (if *post-tcl-customizations*
			(send-shell (format nil "source ~A" *post-tcl-customizations*)))
		    ;; The following is the sole modification to prod-ui for use with
		    ;; monitors. [20dec97 cox]
		    (when *use-monitors-p* ;Flag in parameters.lisp
			  (send-shell (concatenate 'string 
						   "source "
						   *monitor-directory*
						   "monitor.tcl"))
			  (send-shell (concatenate 'string 
						   "source "
						   *monitor-directory*
						   "overload.tcl"))
			  )
		    )
	    ;; UI begins in generative mode.
	    (setf *analogical-replay* nil) ;[cox 26jan97]
	    )))
  (let ((tcl-bin (concatenate 'string *tcl-home*
			      (if (probe-file
				   (concatenate 'string 
						*tcl-home*
						"bin/wish"))
				  "bin"
				"tk4.2/unix")
			      )))
    ;; Create dummy problem-space if none already exists. [cox 28may97]
    (if (not (boundp 
	      '*current-problem-space*))
	(setf *current-problem-space* 
	      (p4::make-problem-space :name 'dummy)))
    (format t "~%Restarting tcl server..")
    (kill-tcl-server :silent t)
    (start-tcl-server t)		; tcl7.5 only supports tcp sockets
    (unless *shell-stream*
	    (setf *shell-stream*
		  (excl:run-shell-command "csh" :wait nil :input :stream)))
    (unless manual-ui
	    (send-shell (format nil "~A~A -geometry 1x1+0+0" 
				tcl-bin
				"/wish"
				))
	    (sleep 5)
	    (send-shell (format nil 
				"source ~A/ui-start.tcl" 
				*prod-ui-home*
				))
	    (sleep 1)
	    (if *tcl-customizations*
		(send-shell (format nil "source ~A" *tcl-customizations*)))
	    (sleep 1)
	    (send-shell (format nil 
				"source ~A/ui-comm.tcl" 
				*prod-ui-home*)) ;[cox 15dec96]
	    (if *post-tcl-customizations*
		(send-shell (format nil "source ~A" *post-tcl-customizations*)))
	    ;; The following is the sole modification to prod-ui for use with
	    ;; monitors. [20dec97 cox]
	    (when *use-monitors-p*	;Flag in parameters.lisp
		  (send-shell (concatenate 'string 
					   "source "
					   *monitor-directory*
					   "monitor.tcl"))
		  (send-shell (concatenate 'string 
					   "source "
					   *monitor-directory*
					   "overload.tcl"))
		  )
	    )
    ;; UI begins in generative mode.
    (setf *analogical-replay* nil)	;[cox 26jan97]
    ))



