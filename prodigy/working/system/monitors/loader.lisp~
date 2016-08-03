(in-package USER)

;;;
;;; File loader.lisp is the loader file for the Prodigy module that
;;; allows the planner to sense the environment during planning (see
;;; sensing.lisp), to interleave the execution of plan steps with planning
;;; itself (see execute.lisp), and to dynamically monitor the environment
;;; according to the planning rationale so that replanning can be performed
;;; during the planning process as the state changes. The software that
;;; performs experiments for various monitors is in test-battery.lisp and
;;; test-gtrans.lisp. The system works with and without the Graphical User
;;; Interface (see files monitor.tcl and overload.tcl for implementation).
;;;


(defparameter *monitor-directory* 
  (concatenate 'string *system-directory* "monitors/")
  "The directory where the sensing, interleaving, 
   and rationale-based monitoring code exists."
  )

(defparameter *monitors-binary-pathname*
  (set-binary-path *monitor-directory*)
  )


;;; NOTE that the modules specifications are variable, unlike most other
;;; Prodigy subsystem in which they are static. The reason is that, depending
;;; on the value of *load-sensing-only* (flag in parameters.lisp), the
;;; specification may be changed by the program. See load-monitor-code and
;;; load-monitor-source below.
;;;
(defvar *monitor-modules*
  '(("/source/" "parameters" "print-rules" "execute" "monitor" "patches" 
     "meta-preds" "state-manipulate")
    ;; The following 4 are all that will be loaded if *load-sensing-only* is t.
    ("/source/" "sensing" 
     "test-battery" "test-gtrans")
    ("/../customizations/"		;patch file
     "find-branches")) 
  )



(defun load-monitor-source (&optional
			    load-sensing-only
			    &aux 
			    (monitor-modules
			     (if load-sensing-only
				  (rest 
				   *monitor-modules*)
			       *monitor-modules*)))
  (dolist (each-mod monitor-modules)
	  (dolist (each-file (cdr each-mod))
		  (user::p-load 
		   (car each-mod) 
		   each-file 
		   *monitor-directory*)
		  ))
  (setf *monitors-loaded* t)
  )




;;; NOTE that *binary-extension* is defined in Prodigy's loader.lisp file in
;;; *prodigy-root-directory*.
;;;
(defun monitors-compile-all ()
  (dolist (each-mod *monitor-modules*)
    (dolist (each-file (rest each-mod))
      (p-compile (first each-mod)
		 each-file 
		 *monitor-directory*
		 *monitors-binary-pathname*)
      )))


(defun load-monitors (&optional
		      load-sensing-only
		      &aux 
		      (monitor-modules
		       (if load-sensing-only
			   (rest 
			    *monitor-modules*)
			 *monitor-modules*)))
  (dolist (module monitor-modules)
	  (let ((ender (concatenate 
			'string 
			"." 
			*binary-extension*))
		(*load-verbose* t))
	    (dolist (file (cdr module))
		    ;;(format t "~%Loading ~S"  (concatenate 'string *monitors-binary-pathname* file ender))
		    (load (concatenate 
			   'string 
			   *monitors-binary-pathname* 
			   file 
			   ender))))
	  (setf *monitors-loaded* t)
	  )
  )


;;; Add the sensing interrupt handler by default. See sensing.lisp.  Commented
;;; out because reset does this. May want to load, but use non-sensing
;;; scenario first. [2nov97 cox]

;(add-handler)
;(add-handler 'pause)
;(load-senses)

(setf *always-remove-p* t)

;;; Here is where the assumption that it is previously compiled comes
;;; into play.
(defvar *load-monitors-immediately* t)

(when *load-monitors-immediately*
      ;; Get the value of *use-compiled-code* 
      (load (concatenate
	     'string
	     *monitor-directory*
	     "source/parameters.lisp"))
      (if *use-compiled-code* 
	  (load-monitors)
	(load-monitor-source))
      (format t "~%;;; Monitors are loaded.~%"))
