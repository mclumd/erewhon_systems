;;; $Revision: 1.4 $
;;; $Date: 1995/10/03 14:24:01 $
;;; $Author: jblythe $
;;;
;;; REVISION HISTORY
;;;
;;;  $Log: result.lisp,v $
;;; Revision 1.4  1995/10/03  14:24:01  jblythe
;;; 2 small fixes: 1 in load-domain to fix the print-out when a variable
;;; is not printed correctly, 1 in result.lisp to fix the output in
;;; multiple-solutions where a first solution is found but not a second, for
;;; example because of a time limit (this from dborrajo).
;;;
;;; Revision 1.3  1994/05/30  20:56:25  jblythe
;;; Added Tony Maida's patches to have Prodigy run with CMU Lisp 16 and 17.
;;;
;;; Revision 1.2  1994/05/30  20:30:37  jblythe
;;; Added CVS headers so the revision history and descriptions are included in
;;; each changed file.
;;;


;;; This file contains the code for letting Prodigy have a more
;;; uniform result.
;;; Authors: Daniel Borrajo and Jim Blythe
;;; Created: November 93

(in-package "USER")

;;;; **********************************************************************
;;;;   Structures
;;;; **********************************************************************
;;;
;;; Structure that has a uniform representation of Prodigy's output
;;;
(defstruct (prodigy-result (:print-function pp-result))
  (problem nil)				; problem the last run was for
  (time 0)				; time of the last run in seconds
  (nodes 0)				; number of nodes explored
  (solutionp nil)			; t iff a solution was found
  (number-solutions 0)			; if you can't figure this out..
  (solution nil)			; see above
  (solutions nil)			; if there was more than one
  (interrupt nil)			; what the interrupt handler returned
  (whole-tree-expanded-p nil)		; see number-solutions
  (acc-runs 0)				; number of runs used for
					; cumulative data
  (acc-time 0)				; total time over all these runs
  (acc-nodes 0)				; nodes explored over all runs
  (acc-solutions 0)			; total number of solutions found
  (plist nil))				; property list for other data


;;;; **********************************************************************
;;;;   Variables
;;;; **********************************************************************

(defvar *prodigy-result* (make-prodigy-result)
  "Contains the structure that summarizes the last prodigy run")


;;;; **********************************************************************
;;;;   Macros
;;;; **********************************************************************

(eval-when (load eval compile)

   ;;
   ;; Returns t if there is at least a solution
   ;; 
   (defmacro p4::solutionp (result all-solutions)
     `(and (if (p4::problem-space-property :multiple-sols)
               (cdr ,all-solutions)
	       (and (listp (car ,result))
		    (listp (caar ,result))
		    (eq (cdaar ,result) :achieve)))
	   t))

   ;;
   ;; Returns t if it expanded the whole search tree
   ;;
   (defmacro p4::whole-tree-expanded-p (result)
     `(or (and ,result
	       (eq (car ,result) :fail))
	  (not ,result)))

;; Daniel. 3/17/94   
;; When it has multiple-sols=nil, it can also explore the whole tree
;;     `(and (or (p4::problem-space-property :multiple-sols)
;;               (p4::problem-space-property :shortest))
;;	   (or (and ,result
;;		    (eq (car ,result) :fail))
;;	       (not ,result))))

   ;;
   ;; Returns the visible expression of a solution
   ;;
   (defmacro visible-solution (solution)
     `(mapcar #'(lambda (op)
		  (get-applicable-op op))
	      ,solution))
   
   ;;
   ;; Returns the visible form of the application of an operator
   ;;
   (defmacro get-applicable-op (instantiated-op)
     `(cons (get-operator-name ,instantiated-op)
	    (convert-objects-in-constants
	     (p4::instantiated-op-values ,instantiated-op))))

   ;;
   ;; Returns the operator name
   ;;
   (defmacro get-operator-name (instantiated-op)
     `(p4::operator-name (p4::instantiated-op-op ,instantiated-op)))

   ;;
   ;; It returns a list of the object names that appear in the seq
   ;;
   (defmacro convert-objects-in-constants (seq)
     `(map 'list #'(lambda (arg) (convert-object-in-name arg)) ,seq))

   ;;
   ;; Returns the name of the object
   ;;
   (defmacro convert-object-in-name (object)
     `(if (p4::prodigy-object-p ,object)
	  (p4::prodigy-object-name ,object)
	  ,object))

)   


;;;; **********************************************************************
;;;;   Functions
;;;; **********************************************************************

;;
;; Pretty-print function
;;
(defun pp-result (result stream z)
  (declare (ignore z))
  (format stream "#<PRODIGY result: ~a, ~d secs, ~d nodes, ~d sol>"
	  (prodigy-result-solutionp result)
	  (prodigy-result-time result)
	  (prodigy-result-nodes result)
	  (prodigy-result-number-solutions result)))

;;
;; Pretty-print function for the user
;;
(defun pp-prodigy-result (&key (result *prodigy-result*)
			       (stream t)
			       (print-all-solutions-p nil))
  (let ((solutionp (prodigy-result-solutionp result)))
    (format stream "~2%PRODIGY's result:")
    (format stream "~% Time spent: ~d~% Number of nodes explored: ~d"
	    (prodigy-result-time result)
	    (prodigy-result-nodes result))
    (format stream "~% Solution reached: ~a~% Number of solutions: ~d"
	    solutionp
	    (prodigy-result-number-solutions result))
    (cond (solutionp
	   (format stream "~% Solution: ~%")
	   (pp-solution (visible-solution (prodigy-result-solution result))
			2 stream)
	   (when (and print-all-solutions-p
		      (cdr (prodigy-result-solutions result)))
	     (format stream " Other solutions:")
	     (dolist (solution (cdr (prodigy-result-solutions result)))
	       (format stream "~%  *")
	       (pp-solution (visible-solution solution) 4 stream))))
	  (t (format stream "~%")))
    (format stream " Accumulative number of runs: ~d"
	    (prodigy-result-acc-runs result))
    (format stream "~% Accumulative time: ~d"
	    (prodigy-result-acc-time result))
    (format stream "~% Accumulative number of nodes: ~d"
	    (prodigy-result-acc-nodes result))
    (format stream "~% Accumulative number of solutions: ~d"
	    (prodigy-result-acc-solutions result))))


;;
;; Pprints a solution
;;
(defun pp-solution (solution tab-steps stream)
  (format stream "~2t~a~%" (car solution))
  (let ((control-string (format nil "~~~dt~~a~~%" tab-steps)))
    (dolist (instantiated-op (cdr solution))
      (format stream control-string instantiated-op))))
      
;;
;; Inits the structure of prodigy-result
;;
(defun init-prodigy-result (&optional (result *prodigy-result*))
  (setf (prodigy-result-problem result) nil)
  (setf (prodigy-result-time result) 0)
  (setf (prodigy-result-nodes result) 0)
  (setf (prodigy-result-solutionp result) nil)
  (setf (prodigy-result-solution result) nil)
  (setf (prodigy-result-solutions result) nil)
  (setf (prodigy-result-number-solutions result) 0)
  (setf (prodigy-result-interrupt result) nil)
  (setf (prodigy-result-whole-tree-expanded-p result) nil)
  (setf (prodigy-result-acc-runs result) 0)
  (setf (prodigy-result-acc-time result) 0)
  (setf (prodigy-result-acc-nodes result) 0)
  (setf (prodigy-result-acc-solutions result) 0)
  result)
  
(in-package "P4")
(import 'user::*prodigy-result*)

;;
;; Returns a list of solutions
;;
(defun get-solutions (result all-solutions)
  (if (p4::problem-space-property :multiple-sols)
      (if (cdr all-solutions)
	  (mapcar #'cdr (cdr all-solutions))
	  (and (eq (cdaaar all-solutions) :achieve)
	       (cdar all-solutions)))
      (if (listp (caar result))
	  (list (cdr result)))))


