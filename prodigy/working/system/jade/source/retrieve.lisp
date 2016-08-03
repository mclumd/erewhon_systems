(in-package "FRONT-END")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;
;;;;	  Case retrieval function for the PRODIGY-Analogy/ForMAT TIE
;;;;
;;;;

;;; NOTE that this file is obsolete for the most part. Case retrieval is now
;;; done through Prodigy/Analogy's retrieval process.




;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;
;;;; SIMILARITY 
;;;; FUNCTIONS 
;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;


(defun similar-arg-p (arg1 arg2)
  (or (siblings-p arg1 arg2)
      (isa-p arg1 arg2)
      (isa-p arg2 arg1))
)


(defun similar-args-p (args1 args2)
  (cond ((null args1)
	 t)
	(t
	 (and
	  (similar-arg-p (first args1)
			 (first args2))
	  (similar-args-p (rest args1)
			  (rest args2)))))
  )



(defun is-similar-p (g1 g2)
  ;; goal-match-p is in function.lisp. Change this.
  (or (user::goal-match-p g1 g2) ;May be inefficient to use goal-match-p.
      (user::goal-match-p g2 g1) ;Especially twice.
      (and (eq (first g1)
	       (first g2))
	   (eq (length g1)
	       (length g2))
	   (similar-args-p (rest g1)
			   (rest g2))))
  )



;;; Still need to be able to handle the existentially quantified goals.
;;;
(defun goal-set-difference (old-goals current-goals)
  (set-difference
   old-goals
   current-goals
   :test #'is-similar-p)
  )


(defun goal-intersection (old-goals current-goals)
  (intersection 
   old-goals 
   current-goals 
   :test #'is-similar-p)
  )




;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;
;;;;  CASE ACCESS
;;;;  FUNCTIONS 
;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;


;;;
;;; NOTE that this function is interpretting the goals by calling get-preconditions.
;;; 
;;; This function can also be used to convert the current goals of PRODIGY to 
;;; a abstract form. E.g., (get-goals nil (get-current-goals))
;;;
(defun get-goals (case &optional (actual-goals (second case)))
  (mapcar #'(lambda (each-goal)
	      (get-preconditions
	       nil
	       each-goal))
	  (if (eq 'and (first actual-goals))
	      (rest actual-goals)
	    actual-goals))
  )


;;;
;;; Access function get-case-id returns the identifier of a given case.
;;;
(defun get-case-id (case)
  (first case)
  )


;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;
;;;;  MAIN FUNCTION
;;;;  DEFINITIONS
;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;


(defun compute-intersection-lengths (current-goals 
				     &optional 
				     (case-list user::*case-list*))
  (mapcar #'(lambda (each-case)
	      (length
	       (goal-intersection
		(get-goals each-case)
		current-goals)))
	  case-list)
  )



;;;
;;; Function return-all-of-x-length takes a particular length, a list of cases,
;;; and a corresponding list of intersection lengths for the cases as input. 
;;; The function then returns a list of those cases matching the particular x-
;;; length.
;;;
(defun return-all-of-x-length (x-length
			       length-list
			       &optional
			       (case-list user::*case-list*))
  (cond ((null length-list)
	 nil)
	((eq x-length (first length-list))
	 (cons (first case-list)
	       (return-all-of-x-length 
		x-length
		(rest length-list)
		(rest case-list))))
	(t
	 (return-all-of-x-length
	  x-length
	  (rest length-list)
	  (rest case-list))))
  )


(defvar *max-cover-set* nil)
(defvar *coverage-length-list* nil)


(defun find-max-coverage (current-goals
			  &aux
			  (coverage-length-list
			   (setf *coverage-length-list*
				 (compute-intersection-lengths
				  current-goals))))
  (setf
   *max-cover-set*
   (return-all-of-x-length
    (apply #'max
	   coverage-length-list)
    coverage-length-list))
  )
  
(defvar *extraneous-goals-list* nil)

;;;
;;; Function retrieve-best-matches returns a list of cases having the highest 
;;; number of goals covered and the smallest number of irrelevant, or 
;;; extraneous, goals. 
;;;
(defun retrieve-best-matches (current-goals
			    &aux
			    (max-cover-set 
			     (find-max-coverage current-goals)))
  "Return case with highest number of covered goals and smallest number of extraneous goals."
  (if (eq 1
	  (length max-cover-set))
      max-cover-set
    (let ((extraneous-goals-list
	   (setf
	    *extraneous-goals-list*
	    (mapcar #'(lambda (each-case)
			(length
			 (goal-set-difference
			  (get-goals each-case)
			  current-goals)))
		    max-cover-set))))
      (return-all-of-x-length
       (apply #'min
	      extraneous-goals-list)
       extraneous-goals-list
       max-cover-set)
      ;; Used to return just the first of the smallest.
;      (elt
;       max-cover-set
;       (position 
;	(apply #'min
;	       extraneous-goals-list)
;	extraneous-goals-list))
      ))
  )




;;;
;;; Function create-case-list builds a list of case tuples as described in the
;;; comment for global variable user::*case-list* (see file
;;; case-list.lisp). NOTE that fgoal-action-list must be a list of :save-goal
;;; actions. See top-level comments for the structure of an fgoal-action in
;;; file transformations.lisp.
;;;
(defun create-case-list (fgoal-action-list)
  (mapcar #'(lambda (each-fgoal-action)
	      (cons (get-plan-name each-fgoal-action)
		    (list 
		     (translate-goals each-fgoal-action))))
	  fgoal-action-list)
  )



