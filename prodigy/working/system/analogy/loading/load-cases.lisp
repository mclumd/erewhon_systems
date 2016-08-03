;;;*****************************************************************
;;; Manuela Veloso -- Adapted from Vera's code
;;; Hundreds of changes! 
;;; (see page 52 yellow notebook)
;;;*****************************************************************

(setf *guiding-cases* ':not-computed)
(setf *case-cache* nil)
(setf *goals-to-guiding-cases* nil) ;assoc list
(defvar *replay-cases* nil)
(defvar p4::*node-counter*)

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

(defun load-cases (&key (add-to-case-cache nil)
			(case-dir (concatenate 'string *problem-path* 
					       "probs/cases/")))
  (if (not add-to-case-cache)
      (setf *case-cache* nil
	    *case-headers* nil))
  (format t "~% Resetting (setting to nil) *case-cache* and *case-headers*")
  (let ((original-root (pspace-prop :root)))
    (dolist (case-info *replay-cases*)
      (let ((case-name (car case-info))
	    (new-case-name (nth 1 case-info))
	    (goals-covered (nth 2 case-info))
	    (substitution (nth 3 case-info)))
	(load-case-header case-name)
	(if (null (p4::get-operator p4::*finish*))
	    (p4::load-problem (current-problem)))
	(proclaim '(fixnum p4::*node-counter*))
	(setf p4::*node-counter* 0)
	(setf *case-object-list* nil)
	(generate-additional-objects
	 (case-header-objects
	  (get-case-header-from-case-name case-name)))
	(p4::top-nodes 0) 
	(setf *old-case-root* (find-node 1))
	(setf path-to-case
	      (concatenate 'string case-dir case-name ".lisp"))
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
  (pset :root original-root))		; Jim, saving original root of
					; tree.
  (print "Done !")
  (if (null *replay-cases*)
      (print "No cases set for replay! Retrieve cases before replay!"))
  nil)


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


  
