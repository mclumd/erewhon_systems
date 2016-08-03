;;; ********************************************************
;;; Purpose:
;;; To allow static information to be stored in a separate file from
;;; the problem definition. Only dynamic information needs to be specified
;;; in the problem.
;;; 

;merge-static-data (&rest args)
;   merges new static info into old problem
;create-static-data (&rest args)
;   creates a problem with only static info
;create-problem-with-static-data (&rest args)
;   creates a new problem merged with static stuff
;

; Order -- either
; 1.       (create-problem ...) as per usual
;   Then:  (merge-static-data ...) to add static stuff (can be done multiple times)
; OR:
; 2.       (create-static-data ...) to make a "problem" with only static
;   Then:  (merge-static-data ...) as many as you like
;   Then:  (create-problem-with-static-static-data ...) merges the new
;          problem with the static data already in memory. Doesn't reload
;          static stuff every time.
;
; Note that the pname needed for (merge-static-data) is what you did with
; the setf:
;    (setf myproblem (create-problem (name 'p1) ...))
;    (merge-static-data (problem myproblem) ...)
; or
;    (setf static-stuff (create-static-data ...))
;    (merge-static-data (problem static-stuff) ...)
;    (create-problem-with-static-data (name p1) (static-data static-stuff) ...)
;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;  MACROS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;; ********************************************************
; Merges any static information into the problem pname
; Format:
;;;  (merge-static-data
;;;     (problem pname)   % optional; defaults to (current-problem)
;;;     (objects ...)
;;;     (state ...))
;
(defmacro merge-static-data (&rest args)
  `(merge-static-data-with-problem
     ,@(mapcar #'(lambda (x) (list 'quote x))
               args)))


;;; ********************************************************
; Creates a problem in memory which is only static information.
; Done so that you can keep static info in memory between problems
;  eg.  (create-static-data
;          (name something)
;          (objects ...)
;          (state ...))
;
; If you have a (problem pname) in it, the function acts just
; like (merge-static-data). It will also ig
;
(defmacro create-static-data (&rest args)
  (let* ((problem (or (second (assoc 'problem args))
		      'new)))
    (if (eq problem 'new)
	`(p4::make-problem :name ',(second (assoc 'user::name args))
	                   :objects ',(cdr (assoc 'user::objects args))
	                   :state ',(assoc 'user::state args))
	`(merge-static-data-with-problem
	  ,@(mapcar #'(lambda (x) (list 'quote x))
	     args)))))

;;; ********************************************************
; Creates a new problem pname, adds static data already in memory
; Format identical to (create-problem), with additional 'static-data'
;        and no need for a single quote in front of pname.
;;;  (create-problem-with-static-data
;;;     (name pname)
;;;     (static-data sinfo)
;;;     (objects ...)
;;;     (state ...)
;;;     (igoal ...)
;
; sinfo came from
; (setf sinfo (create-static-data ...))
;
;
(defmacro create-problem-with-static-data (&rest args)
  `(create-prob-and-merge-static
    ,@(mapcar #'(lambda (x) (list 'quote x))
              args)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;  FUNCTIONS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;; ********************************************************
;; WARNING: THIS IS A HIGHLY UNINTELLIGENT FUNCTION

;; All it does is merge various lists in the static data with
;; the various lists in the dynamic data. If you were to have conflicting
;; information (eg. static: (on a b), dynamic: (~ (on a b)), BOTH would
;; be added to the state description...
;;
;; I'm sure there are lots of other situations where this would fail.
;; If you decide to challenge it, please keep track of BOTH when it did
;; fail, and when it did NOT.

(defun merge-static-data-with-problem (&rest args)
    (let* ((problem (or (eval (second (assoc 'problem args)))
                        (current-problem)))
           (static-objects (cdr (assoc 'user::objects args)))
           (static-state   (second (assoc 'user::state args)))
	   (dynamic-objects nil)
	   (dynamic-state nil))
      (if (null problem)
	  (error "Merging static data: default (current-problem) does not exist. Please specify problem"))
      (setf dynamic-objects (p4::problem-objects problem))
      (setf dynamic-state   (second (p4::problem-state problem)))

       (setf (p4::problem-objects problem)
             (union static-objects dynamic-objects :test #'equalp))
       (setf (p4::problem-state problem)
	     (merge-state dynamic-state static-state))))


;;; ********************************************************
(defun create-prob-and-merge-static (&rest args)
  (let ((static-problem (eval (second (assoc 'user::static-data args)))))
    (if (null static-problem)
	(error "~%Static problem ~S does not exist"
	       (second (assoc 'user::static-data args))))
    (p4::make-problem
        :name (second (assoc 'user::name args))
        :objects (union (p4::problem-objects static-problem)
                        (cdr (assoc 'user::objects args))
                        :test #'equalp)
        :state (merge-state (second (assoc 'user::state args))
	             (second (p4::problem-state static-problem)))
        :goal (p4::assure-goal args)
        :plist (assoc 'user::plist args))))



;;; ********************************************************
(defun merge-state (dynamic-state static-state)
  (if (null dynamic-state)
      `(user::state ,static-state)
      (progn
	(if (null static-state)
	    `(user::state dynamic-state)
	    (progn
	      (if (eq (car dynamic-state) 'user::and)
		  (setf dynamic-state (cdr dynamic-state))
		  (setf dynamic-state (list dynamic-state)))
	      (if (eq (car static-state) 'user::and)
		  (setf static-state (cdr static-state))
		  (setf static-state (list static-state)))
	     
	      `(user::state
		(user::and
		 ,@(union static-state dynamic-state :test #'equalp)))
	    )
	)
      )
  )
)


