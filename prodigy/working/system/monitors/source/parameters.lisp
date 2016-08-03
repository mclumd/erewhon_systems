;;;
;;; File Parameters.lisp contains the global system parameters that the user
;;; may change to affect program behavior during experiments. NOTE that the
;;; system is loaded by the .clinit.cl initialization file at the current time
;;; because it uses some of the values. The file loader.lisp also reloads it
;;; in order for the system to be publically usable. Reloading it will have no
;;; side-effect.
;;;


;;;
;;; NOTE that this variable might also be set in .clinit.cl or
;;; system-loader.lisp, thus the value here might not be used.
;;;
(defvar *run-experiment* nil
  "If t, do not prompt user. Run experiment instead.")


(defparameter *test-condition* 'with-goal-transformations
  "Either alternative-based-subgoal, alternative-based-usability,
with-goal-transformations or without-goal-transformations.")


;;; The next 2 are specific for the experiments for Veloso, Pollock, & Cox,
;;; 1998.

(defparameter *max-ops* 30 
  "Really *n-ops*.")

(defparameter *max-delay* 25 
  "Maximum sensing delay in experiment.")


;;;
;;; This variable is actually defined in system-loader.lisp.
;;;
;(defvar *use-monitors-p* nil
;  "If t, monitors are spawned during planning.")


(defparameter *o-level* 3 "Prodigy output level.")



;;;
;;; The following parameter used to be in file loader.lisp.
;;;
(defparameter *use-compiled-code* nil)


;;; Directory is in loader.lisp so that it can load this file without using a
;;; hard-coded path.
;;;
;(defparameter *monitor-directory* 
;  (concatenate 'string *system-directory* "monitors/")
;  "The directory where the sensing, interleaving, and rationale-based monitoring code exists."
;  )




(defparameter *load-sensing-only* nil
  "If nil, load the sensing-execution-monitor code. 
If t, will load part of the code in Interleave, but not the execution-specific code.")


(defparameter *monitor-trace* t 
  "If t, then provide screen output.")



(defvar *monitors-loaded* nil
  "Indicates whether or not monitor code, either source or binary, 
   is loaded yet.")


;;; Should add *sensor-count*. What others? See experiment.txt.
;;;
;;; *load-sensing-only* and load-sensing-only used to be called *load-execute*
;;; and load-execute respectively. Moreover, the semantics sense was reversed.
;;; [cox 24mar98]
;;;
(defun set-parameters (&optional
		       (interactive-p t)
		       &key 
		       run-experiment 
		       (load-sensing-only t)
		       (test-condition 'alternative-based-subgoal)
		       (max-ops 30)
		       (max-delay 25 )
		       (use-monitors-p t)
		       (o-level 0))
  (when interactive-p
	(format t "~%CURRENT PARAMETERS: ~%")
	(mapc #'(lambda (var)
		  (format
		   t
		   "~%~a = ~s~%  (~a)" 
		   (symbol-name var) 
		   (symbol-value var) 
		   (documentation var 'variable)))
	      '(*run-experiment* *load-sensing-only* *test-condition* 
		*max-ops* *max-delay* *use-monitors-p* *o-level*))
	(let ((ans nil))
	  (format t "~%~%To use defaults, type 'd in place of value~%")
	  (format t "~%*run-experiment* (default ~s): " run-experiment)
	  (setf ans (read))
	  (if (not (eq ans 'd))
	      (setf run-experiment ans))
	  (format t "~%*load-sensing-only* (default ~s): " load-sensing-only)
	  (setf ans (read))
	  (if (not (eq ans 'd))
	      (setf load-sensing-only ans))
	  (format t "~%*test-condition* (default ~s): " test-condition)
	  (setf ans (read))
	  (if (not (eq ans 'd))
	      (setf test-condition ans))
	  (format t "~%*max-ops* (default ~s): " max-ops)
	  (setf ans (read))
	  (if (not (eq ans 'd))
	      (setf max-ops ans))
	  (format t "~%*max-delay* (default ~s): " max-delay)
	  (setf ans (read))
	  (if (not (eq ans 'd))
	      (setf max-delay ans))
	  (format t "~%*use-monitors-p* (default ~s): " use-monitors-p)
	  (setf ans (read))
	  (if (not (eq ans 'd))
	      (setf use-monitors-p ans))
	  (format t "~%*o-level* (default ~s): " o-level)
	  (setf ans (read))
	  (if (not (eq ans 'd))
	      (setf o-level ans))
	  )
	)
  (setf *run-experiment* run-experiment)
  (setf *load-sensing-only* load-sensing-only)
  (setf *test-condition* test-condition)
  (setf *max-ops* max-ops)
  (setf *max-delay* max-delay)
  (setf *use-monitors-p* use-monitors-p)
  (setf *o-level* o-level)
  nil
  )


