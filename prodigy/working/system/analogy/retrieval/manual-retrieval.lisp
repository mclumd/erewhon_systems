;;;*****************************************************************

(defun manual-retrieval ()
  (format t "~% Need to see goal and initial state of current problem? y/n ")
  (when (eq (read) 'y)
    (format t "~% Problem goal: ~S"
	    (get-lits-no-and (p4::problem-goal (current-problem))))
    (format t "~% Problem state: ~S"
	    (get-lits-no-and (p4::problem-state (current-problem)))))
  (format t "~%")
  (setf *replay-cases* nil)
  (do () ()
    (format t "~% Enter a case? y/n ")
    (case (read)
      (n (return))
      (y 
       (format t "~% Case name (as a string): ")
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

;;;*****************************************************************
