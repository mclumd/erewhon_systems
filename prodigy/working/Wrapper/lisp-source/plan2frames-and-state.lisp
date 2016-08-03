(in-package "P4")


;;; 
;;; When PRODIGY is successful, this is set to the last node in the soln
;;; (search tree?).  We save this node so that we can extract the applied-op
;;; nodes of the plan (the applied-op node is where we store Boris' state info
;;; on the :my-current-state field of the node's plist) by doing a
;;; path-from-root call.
;;; .
(defvar *last-node-in-soln* nil)


;;; 
;;; This function came from monitors/source/patches.lisp
;;; mcox added setf of *last-node-in-soln*
;;; 
(defun prepare-plan (result)
  ;; Added 19oct00
  (setf user::*last-node-in-soln*
    (rest result))
  (cond ((and (consp result) (consp (car result))
	      (eq (cdar result) :achieve))
	 (cons result
	       (mapcan #'(lambda (node)
			   (nreverse
			    (mapcar #'op-application-instantiated-op
				    (a-or-b-node-applied node))))
		       ;; Added [cox]. Watch out for removing duplicates that
		       ;; you did not intend to remove.
			(append *execution-queue*
				(cdr (path-from-root (cdr result)
						     #'a-or-b-node-p)))
		       )))
	;; If a resource bound was exceeded, let's see if we have
	;; achieved some of the top-level conjunction. The function
	;; "prepare-partial-plan" is loaded in from /contrib
	((and (consp result) (listp (car result))
	      (eq (second (car result)) :resource-bound))
	 (if (fboundp 'prepare-partial-plan)
	     (prepare-partial-plan result)))
	))

;;; Things that must be done when we apply an operator:
;;; 1. recalculate the pending goals
;;; 2. see if any pending inference rules are now applicable
;;; 3. see if we've reached the goal
(defun do-apply-op (node applicable-ops next-thing excise-state-loops?)
  ;;This function actually applies the op, then returns either the node applied
  ;;or :no-ap-op.

  ;;next-thing is just here for bookkeeping
  
  ;;Peter 7/8/94:  Changed to include new argument that determines whether
  ;;or not loops should be discarded from the search space.  In general
  ;;they should be, but on occasion, the variable *ex* is set to nil to allow
  ;;a state loop to be expanded.

  (let ((chosen-op (choose-applicable-op node applicable-ops))
	a-op-node)
    (declare (special a-op-node))	; used in state daemons.

    (cond (chosen-op
	   (setf a-op-node
		 (make-applied-op-node
		  :parent node
		  :abs-level (nexus-abs-level node)
		  :instantiated-op chosen-op))
;;;	   (break)
	   ;; Here is where we store the state. mcox
	   (setf (getf (p4::nexus-plist a-op-node) :my-current-state)
	     (user::show-state))
	   ;; This was change from overload.lisp [cox 25feb97]
	   (when (and (boundp user::*load-patches*)
		      user::*load-patches*
		      *my-crl-name*)
		 (setf (getf (p4::nexus-plist a-op-node) :why-chosen)
			 (if (getf (p4::nexus-plist a-op-node) :why-chosen) 
			     (cons *my-crl-name* (getf (p4::nexus-plist a-op-node) :why-chosen))
			   *my-crl-name*))
;		 (break)
		 (setf *my-crl-name* nil))
	   (setf (a-or-b-node-applicable-ops-left node)
		 (delete chosen-op (a-or-b-node-applicable-ops-left node)))
	   (if (null (a-or-b-node-applicable-ops-left node))
	       (if (null (a-or-b-node-goals-left node))
		   (close-node node :exhausted)))
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
		  ;; feb 13 96, need to do an execution step here 
		  (let ((exec-op (get-executable a-op-node)))
		    (when (and *automatic*
			       exec-op
			       (automatically-decide-to-execute exec-op))
			  ;; Moved format statement into when form. [17oct97 cox]
			  (format t "~%EXECUTE ~S HERE" a-op-node )
			  (do-execute-op a-op-node exec-op :ignored)
			  (format t "~%CHECK THAT ~S WORKED HERE" a-op-node )
			  ))

		  (setf (getf (nexus-plist a-op-node) :termination-reason)
			:achieve)
		  (prod-signal :achieve a-op-node)
		  a-op-node)
		 
		 ;; If there is a state loop, close this new node, retract
		 ;; the state, reset the goals and fail.
		 ;;Peter 7/8/94:  only if excise-state-loops? is t.
	         ((and excise-state-loops? 
		       (state-loop-p a-op-node))
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
		  a-op-node))
		  )

	  (t :no-ap-op))))



(defun literal-print (lit stream z)
  (declare (ignore z)
	   (type literal lit)
	   (stream stream))
  (princ "(" stream)
  (princ (literal-name lit) stream)
  (cond (*debug-assertion-print*
	 (if (literal-state-p lit)
	     (princ " T" stream)
	     (princ " F" stream))
	 (if (literal-goal-p lit)
	     (princ " G" stream)
	     (princ " F" stream))
	 (if (literal-neg-goal-p lit)
	     (princ " N" stream)
	     (princ " F" stream))
	 (map nil #'(lambda (x) (princ " " stream) (princ x stream))
	      (literal-arguments lit)))
	(t
	 (map nil
	      #'(lambda (x) (princ " " stream)
			(princ (if (prodigy-object-p x)
				   (prodigy-object-name x)
				   x)
			       stream))
	      (literal-arguments lit))))
  (princ ")" stream))



#|

;;; 
;;; Use the following commented out code instead of code above if monitor
;;; subsystem not loaded.
;;; 
;;;


;;; 
;;; This function came from planner/search.lisp
;;; mcox added setf of *last-node-in-soln*
;;; 
(defun prepare-plan (result)
  ;; Added 19oct00
  (setf user::*last-node-in-soln*
    (rest result))
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
	       (set-abs-parent a-op-node node next-thin g)
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
		  a-op-node))
;;;	   (break)
		  ;; Here is where we store the state. mcox
	   (setf (p4::nexus-plist node) 
	     (append (p4::nexus-plist node) 
		     (list :my-current-state (user::show-state))))
;;;	   (setf (get a-op-node 'current-state) (show-state))
		  )

	  (t :no-ap-op))))


|#





(in-package "USER")






;;;
;;; Function normalize-and-write-step changes an instantiated PRODIGY operator
;;; (plan step) into a normalized form. The normal form is represented by a
;;; standard Frame structure. The value of "frame" is called the head. This is
;;; followed by an arbitrary number of roles. Roles are attribute value pairs.
;;;
;;; (frame 
;;;  (attribute1 val1)
;;;  (attribute2 val2)
;;;  (attribute3 val3)
;;;   ... )
;;;
;;; The current implementation does not allow facets or recursive frame values.
;;;
;;; The function writes the frame to a file (or any stream object) as
;;; determined by the argument "stream."
;;;

(defun normalize-and-write-step (op applied-op stream) 
  (declare (type p4::instantiated-op op)
	   (stream stream))
  (with-open-file 
      (out stream
       :direction :output
       :if-exists :append
       :if-does-not-exist :create
       )
    (let ((plan-step 
	   (p4::instantiated-op-op op)))
      (format out "~A" *default-data-line*)
      (format 
       out 
       "~S" 
       (list				; Added 17oct00 cox
	(cons 
	 (p4::operator-name 
	  plan-step)
	 (mapcar 
	  #'(lambda (x y)
	      (list  
	       x 
	       (cond ((typep y 
			     'p4::prodigy-object)
		      (p4::prodigy-object-name y))
		     ((null y) 
		      nil)
		     ((listp y) 
		      '("et cetera"))
		     (t  
		      y))
	       ))
	  (p4::operator-vars plan-step)
	  (p4::instantiated-op-values op)
	  )
	 )
;	(break)
	;; Added 17,18oct00 cox	
	(getf (p4::nexus-plist 
		  applied-op)
	      :MY-CURRENT-STATE))
       )
      (format out ")~%")
      
      )
    )
  )





;;;
;;; Traverses the steps in the plan, calling normalize-and-write-step to
;;; convert and save result to *Normalized-plan-file*.
;;;
(defun save-normalized-plan (stream)
  (let* ((current-plan 
	  (or (rest (first p4::*all-solutions*)) ;Added [20jun00 cox]
	      (user::prodigy-result-solution *prodigy-result*)))
	 (plan-length (length current-plan))
	 (plan-applied-op-nodes 
	  (rest (p4::path-from-root *last-node-in-soln* #'p4::applied-op-node-p))
	  )
	 )
    (mapcar #'normalize-and-write-step
	    current-plan 
	    plan-applied-op-nodes 
	    (make-list 
	     plan-length 
	     :initial-element 
	     stream)))
  )


  
  
(defun process-input (alist stream &optional current-style)
  (let* ((first-item (first alist))
	 (identifier  (first first-item))
	 (remainder 
;	  (first			; Added 17oct00 mcox
	   (rest first-item))
;	  )				; Added 17oct00 mcox
	 (done (null alist)))
;    (format t "~%list ~S first ~S id ~S rem ~S done ~s~%" alist first-item identifier remainder done)
    (cond ((null alist)
	   nil)
	  ((eq identifier :data)
	   (if (atom (first remainder))
	       (process-frame (first (second remainder)) (second (second remainder)) (first remainder) stream)
	     (process-frame (first (first remainder)) (second (first remainder))current-style stream))
	  ;; Added 17oct00
;	   (format stream "~%~s" 
;		   ;;Boris' state info
;		   (second (if (atom (first remainder)) 
;			       (second remainder) 
;			     (first remainder)))
;		   )
	   )
	  ((eq identifier :style)
	   (process-style (first remainder)))
	  )
    (if (not done)
	(process-input (rest alist) stream current-style))
	  )
    )


(defun process-frame (frame state current-style stream &optional head-printed)
  (cond ((null frame)
	 (apply (get current-style 'done)
		(list stream))
	 (format stream "~%~s~%" state)
	 )
	(head-printed 
	 (apply (get current-style 'role-print)
		(list (first frame) stream))
	 (process-frame (rest frame) state current-style stream t))
	(t 
	 (apply (get current-style 'start)
		(list stream))
	 (apply (get current-style 'head-print)
		(list (first frame) stream))
	  (process-frame (rest frame) state current-style stream t))
	)
  )


