(in-package p4)

(export '(find-branches find-branches2 print-search-nodes))

;;; Prints out nodes touched as side-effect.
(defun find-branches (&optional 
		      (node 
		       (cdr (user::prodigy-result-interrupt 
			     *prodigy-result*))))
  "Find all branch nodes in the search tree along the solution path."
  (if (not (null node))
      (print (nexus-name node)))
  (cond ((null node)
	 nil)
	((> (length (nexus-children node)) 1)
	 (cons node (find-branches (nexus-parent node))))
	(t
	 (find-branches (nexus-parent node))))
  )

;;; Prints out nodes touched as side-effect. Performs depth first search.
(defun find-branches2 (&optional 
		      (root
		       (user::pspace-prop :root)))
  "Find all branch nodes in the search tree."
  (if (not (null root))
      (print (nexus-name root)))
  (cond ((null root)
	 nil)
	((= (length (nexus-children root)) 1)
	 (find-branches2 (first (nexus-children root))))
	(t
	 (cons root (mapcan #'find-branches2 (nexus-children root))))))

(defun print-search-nodes (&optional 
			   interactive
			   node-type
			   (root
			    (user::pspace-prop :root))
			   &aux
			   user-input)
  "Print all nodes in the current search tree."
  (if interactive
      (when (or (not node-type)
		(eq node-type
		    (type-of root)))
	    (describe root)
	    (setf user-input (read))
	    (if (eq user-input 'user::q)
		(return-from print-search-nodes)))
    (if (not (null root))
	(print root)))
  (cond ((null root)
	 nil)
	((= (length (nexus-children root)) 1)
	 (print-search-nodes interactive
			     node-type
			     (first (nexus-children root))))
	(t
	 (let ((children (nexus-children root)))
	   (cons root (mapcan #'print-search-nodes 
			      (make-list (length children) :initial-element interactive)
			      (make-list (length children) :initial-element node-type)
			      children)))))
  )
