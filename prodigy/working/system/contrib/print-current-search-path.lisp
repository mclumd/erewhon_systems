;;; ********************************************************
;;; Purpose:
;;; Code to print the current complete search path
;;; being explored, when backtracking occurs.
;;; In order NOT to get this behavior, just
;;; set *print-search-path-p* to nil.

;;; ********************************************************
;;; Author: Manuela Veloso - November 1992
;;; Send bugs and suggestions to mmv@cs.cmu.edu
;;; Change Log:
;;; Alicia Feb 13, 1992:
;;; modified to update changes to main-search.lisp 
;;; *******************************************************

(in-package "P4")

(defvar *print-search-path-p* t)

;;; This redefines the function main-search
;;; Just one line added - right at the end
;;; of the function - just one extra call
;;; to a printing function if there was
;;; a failure and backtracking occurred.

(defun main-search (node last-node-created current-depth depth-bound)
  "This function is the top level of the search routine."
  (declare (type nexus last-node-created)
	   (number current-depth))

  ;; I made this a simple loop because I couldn't figure out how to
  ;; force lucid to compile out the tail recursion. -- Jim
  (do ()
      (nil nil)

    ;; Expanding the node either returns a new node or some kind of
    ;; failure symbol.  First, we maintain the state.
    (if (eq last-node-created node)
	(incf current-depth)
      (setf current-depth
	    (maintain-state-and-goals last-node-created node)))
    ;; Print out a line if required for tracing.
    (announce-node node last-node-created current-depth)

    ;; This variable is for use in control rules.
    (let ((user::*current-node* node)
	  (*current-depth* current-depth)) ; and this in printing routines
      (declare (special user::*current-node* *current-depth*))
      (let ((new-node-or-failure-message
	     ;; I'd like to have this condition handled as an interrupt,
	     ;; but I can't quite see how - because it terminates this
	     ;; search node, not the whole thing.
	     (if (and depth-bound
		      (too-deep-p node current-depth depth-bound))
		 (close-node node :depth-exceeded)
		 (refine-or-expand node))))

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
			    tmp))
		    ;; **********************************
		    ;; New code
	    	    ;; **********************************
		    (if (and (not (nexus-p new-node-or-failure-message))
			     *print-search-path-p*)
			(print-current-search-path node)))
  	    	    ;; **********************************
  	    	    ;; End of new code
 	    	    ;; **********************************
		  (return-from main-search
		    (list
		     :fail *node-counter* next-node))))))))))

;;; Removed extra terpri

(defun begin-node-line (node last-node depth)
  (declare (type nexus node)
	   (fixnum depth indent))
  ;; Leave a blank line when we backtrack.
  ;; Removed line, because it was not set consistently
  ;;(unless (eq node last-node) (terpri))
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

;;; **********************************
;;; New functions
;;; **********************************

;; This allows repeating the successful path when
;; backtracking occurs

(defun print-current-search-path (node)
  (when (and (problem-space-property :*output-level*)
	     (>= (problem-space-property :*output-level*) 2))
    (format t "~%~% ******** Starting a new path ***********")
    (let ((past-nodes (cdr (get-successful-path node nil))))
      (dolist (past-node past-nodes)
	(announce-node past-node past-node
		       (compute-depth past-node))))
    (format t "~% ***")))
    
(defun get-successful-path (node parents)
  (cond
    ((null node) parents)
    (t
     (get-successful-path (p4::nexus-parent node)
			  (cons node parents)))))

;;; **********************************
;;; End of new functions
;;; **********************************

(in-package common-lisp-user)
