(defun link-to-case-prodigy-node (signal)
  (when *analogical-replay* 
    (when *debug-case-p*
      (format t "~% current node: ~S" *current-node*)
      (format t "~% previous-link ~S link ~S" *previous-link* *link*))
    (link-new-node-to-case)
    ;;(my-show-alts)
    (if *debug-case-p* 
	(format t "~% property :guided ~S"
		(getf (p4::nexus-plist *current-node*) :guided)))))

(clear-prod-handlers) ;;not sure what is the effect of this in other handlers.
(define-prod-handler :always #'link-to-case-prodigy-node)

#|
;;; Not very good because it is called before the node is printed.
(defun my-show-alts ()
  (format t "~%  This is the current node ~S" *current-node*)
  (cond
    ((p4::goal-node-p *current-node*)
     (format t "~%   goals-left ~S"
	     (p4::goal-node-goals-left *current-node*))
     (format t "~%   applicable-ops-left ~S"
	     (p4::goal-node-applicable-ops-left *current-node*)))
    ((p4::operator-node-p *current-node*)
     (format t "~%   ops-left ~S"
	     (p4::operator-node-ops-left *current-node*)))
    ((p4::applied-op-node-p *current-node*)
     (format t "~%   goals-left ~S"
	     (p4::a-or-b-node-goals-left *current-node*))
     (format t "~%   applicable-ops-left ~S"
	     (p4::a-or-b-node-applicable-ops-left *current-node*)))
    (t nil)))
|#

(in-package "P4")

(defun new-style-node-print (node last-node current-depth)
  (declare (fixnum current-depth)
	   (special *current-problem-space* *last-node-printed*))
  (cond ((and (typep node 'goal-node)
	      ;; Since I don't always print operator-nodes, I want to
	      ;; avoid appearing to repeat myself.
	      (not (eq node *last-goal-node-printed*)))
	 (let ((goal (goal-node-goal node))
	       (alts (if (nexus-parent node)
			 (a-or-b-node-goals-left (nexus-parent node))))
	       (alts-applicable-ops
		(if (nexus-parent node)
		    (a-or-b-node-applicable-ops-left (nexus-parent node)))))
	   (if (eq alts-applicable-ops :not-computed)
	       (setf alts-applicable-ops nil))
	   (begin-node-line node last-node current-depth)
	   (treeprint-goal goal)
	   (cond ((problem-space-property :print-alts)
		  (if alts
		      (print-alts node alts))
		  (if alts-applicable-ops
		      (print-alts node alts-applicable-ops)))
		 (t
		  (when alts 
		    (princ " [g:")
		    (princ (length alts))
		    (princ "]"))
		  (when alts-applicable-ops
		    (princ " [a:")
		    (princ (length alts-applicable-ops))
		    (princ "]"))))
	   (setf *last-goal-node-printed* node)))
	((typep node 'a-or-b-node)
	 ;; BUG: alts currently does not include applied ops - same is
	 ;; true for goal nodes;;; mmv -- FIXED BUG.
	 (let ((alts (if (binding-node-p node)
			 (if (nexus-parent node)
			     (operator-node-bindings-left (nexus-parent node)))
			 (if (nexus-parent node)
			     (a-or-b-node-goals-left (nexus-parent node)))))
	       (alts-applicable-ops
		(if (binding-node-p node)
		    nil
		    (if (nexus-parent node)
			(a-or-b-node-applicable-ops-left (nexus-parent node))))))
	   (if (eq alts-applicable-ops :not-computed)
	       (setf alts-applicable-ops nil))
	   ;; Deal with the line break for backtracking here so as not
	   ;; to do it each time in the list of applications.
	   (unless (eq node last-node) (terpri))
	   (when (binding-node-p node)
	     (begin-node-line node node current-depth)
	     (brief-print-inst-op (a-or-b-node-instantiated-op node)))
	   (print-all-subgoaled-applications node node current-depth)
	   (if (applied-op-node-p node)
	       (check-if-achieved-goal node))
	   (cond
	    ((binding-node-p node)
	     (cond ((and alts (problem-space-property :print-alts))
		    (print-alts node alts))
		   (alts
		    (princ " [")
		    (princ (length alts))
		    (princ "]"))))
	    (t
	     (cond ((problem-space-property :print-alts)
		    (when alts
		      (format t "~%      goals-left:")
		      (print-alts node alts))
		    (when alts-applicable-ops
		      (format t "~%      applicable-ops-left:")
		      (print-alts node alts-applicable-ops)))
		   (t
		    (when alts
		      (princ " [g:")
		      (princ (length alts))
		      (princ "]"))
		    (when alts-applicable-ops
		      (princ " [a:")
		      (princ (length alts-applicable-ops))
		      (princ "]"))))))))
	;; Only print an operator node if we backtrack to it, from
	;; somewhere other than its own child.
	((and (typep node 'operator-node)
	      (not (eq node last-node))
	      (not (eq (nexus-parent last-node) node)))
	 (announce-operator-node node current-depth last-node))
	)
  (unless (typep node 'operator-node)
    (setf *last-node-printed* node)))

(in-package common-lisp-user)



     
