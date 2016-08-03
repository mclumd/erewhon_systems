;;;*****************************************************************
;;; Manuela Veloso -- Adapted from Vera's code
;;; Hundreds of changes! 
;;; (see page 52 yellow notebook)
;;;*****************************************************************

(setf *guiding-cases* ':not-computed)
(setf *case-cache* nil)
(setf *goals-to-guiding-cases* nil) ;assoc list
(defvar *replay-cases* nil)

;;; The variable *replay-cases* needs to be set before
;;; calling load-cases. If it is not, it will tell you so
;;; and ask you to define it either manually or through
;;; automatic retrieval.
;;; *replay-cases* is a "complicated" list:
;;; ((case-name1 new-case-name1
;;;   (goal1 goal2 goal3...) ;goals from the new problem; right subst already
;;;   ((<l20> . locb) (<o93> . <o93>) ...;all the vars in case))
;;;  (case-name2 ...))
;;; Call (load-cases)

(defun load-cases ()
  (setf *case-cache* nil
	*case-headers* nil)
  (format t "~% Resetting (setting to nil) *case-cache* and *case-headers*")
  (dolist (case-info *replay-cases*)
    (let ((case-name (car case-info))
	  (new-case-name (nth 1 case-info))
	  (goals-covered (nth 2 case-info))
	  (substitution (nth 3 case-info)))
      (load-case-header case-name)
      (if (null (p4::get-operator p4::*finish*))
	  (p4::load-problem (current-problem)))
      (defvar p4::*node-counter*)
      (proclaim '(fixnum p4::*node-counter*))
      (setf p4::*node-counter* 0)
      (setf *case-object-list* nil)
      (generate-additional-objects
       (case-header-objects
	(get-case-header-from-case-name case-name)))
      (p4::top-nodes 0) 
      (setf *old-case-root* (find-node 1))
      (setf path-to-case
	    (concatenate 'string *problem-path* "/probs/cases/" case-name ".lisp"))
      (load path-to-case)
      (reinitialize-my-ptrs)
      (format t "~% Creating case ~S" case-name)
      (setf case 
	    (make-guiding-case
	     :name new-case-name
	     :real-name case-name
	     :case-root *old-case-root*
	     :ptr *old-case-ptr*
	     :aux-ptr *old-case-ptr*
	     :goal nil
	     :covered-goals goals-covered
	     :base-substitution substitution
	     :additional-bindings nil
	     :objs *case-object-list*
	     ))
      (setf *case-cache* (cons case  *case-cache*))))
  (setf *guiding-cases* *case-cache*)
  (setf *goals-to-guiding-cases* nil) 
  (goals-to-guiding-cases)
  (all-guided-goals-cases)
  (print "Done !")
  (if (null *replay-cases*)
      (print "No cases set for replay! Retrieve cases before replay!"))
  nil)

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
;;; One goal is only covered by one case
;;; but one case may cover several goals.

(defun goals-to-guiding-cases ()
  (dolist (case *guiding-cases*)
    (dolist (goal (guiding-case-covered-goals case))
      (pushnew (cons goal (guiding-case-name case))
	       *goals-to-guiding-cases*))))
      
(defun print-gcs ()
;;print the set of guiding-cases
  (if (listp *guiding-cases*)
      (progn
	(format t " ~%  *guiding-cases* :")
	(if *guiding-cases*
	    (progn
	      (dolist (case *guiding-cases*)
		(format t  "~S  " (guiding-case-name case)))
	      (format t "~%"))
	    (format t "nil~%")))
      (format t "The set of guiding cases has not been computed yet !~%")))

(defun all-guided-goals-cases ()
  (setf *all-goals-cases-hash* (make-hash-table :test #'equal))
  (dolist (case *guiding-cases*)
    (setf (guiding-case-aux-ptr case)
	  (guiding-case-case-root case))
    (compile-all-case-goals case)))

(defun compile-all-case-goals (case)
  (cond
    ((null (guiding-case-aux-ptr case)) nil)
    ((case-goal-p (guiding-case-aux-ptr case))
     (let ((in-hash (gethash (get-case-new-visible-goal
			      (guiding-case-aux-ptr case) case)
			     *all-goals-cases-hash*)))
       (if in-hash
	   (setf (gethash (get-case-new-visible-goal
			   (guiding-case-aux-ptr case) case)
			  *all-goals-cases-hash*)
		 (pushnew (guiding-case-name case) in-hash :test #'string=))
	   (setf (gethash (get-case-new-visible-goal
			   (guiding-case-aux-ptr case) case)
			  *all-goals-cases-hash*)
		 (list (guiding-case-name case)))))
     (advance-aux-ptr case)
     (advance-aux-ptr case)
     (advance-aux-ptr case)     
     (compile-all-case-goals case))
    (t 
     (advance-aux-ptr case)     
     (compile-all-case-goals case))))

(defun show-all-goals-cases-hash ()
  (maphash #'(lambda (key val)
	       (format t "~% ~S ~S" key val))
	   *all-goals-cases-hash*))

(defun reinitialize-my-ptrs ()
  (setf *old-case-ptr* *old-case-root*)
  (setf *old-case-ptr* (car (get-case-children-nodes *old-case-ptr*)))
  (setf *old-case-ptr* (car (get-case-children-nodes *old-case-ptr*))))


  
