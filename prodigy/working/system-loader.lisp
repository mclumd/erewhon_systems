(in-package "USER")



;;; This overrides the default. If t, do not prompt user. Run experiment
;;; instead.
;;;
(setf *run-experiment* nil)


;;;
;;; This variable is located here because even if the monitor module is not
;;; loaded, the UI checks the variable's value.
;;;
(defvar *use-monitors-p* nil
  "If t, monitors are spawned during planning.")


(defparameter *load-monitors-p* t
  "If t and not *interactive-loading*, load monitors module.")


(defvar *interactive-loading* t
  "If t, then ask user, otherwise use parameter settings 
   to determine what modules to load.")

(defparameter *disable-loading* nil
  "If t, do not load any Prodigy code.")

(defvar *prodigy-base-directory* 
 ; "/usr/local/users/mcox/prodigy/");;GE
"c:/prodigy/working/")
    
    
;;;
;;; This path is the location of an example post-tcl-customization file for the
;;; User Interface. The file changes the UI to include JADE-specific
;;; features. It also houses a PRODIGY patch file. The default is a directory
;;; off the system dir. Note that the name of this directory may change, but it
;;; is assumed below (with the matches-initial-substr call) that the location
;;; will remain off the system directory.
;;;
(defparameter *customizations-path* 
  (concatenate
   'string
   *prodigy-base-directory*
   "working/system/customizations")
  "Path to where system customizations and patches are located.")


;;;
;;; This file sets the value of this variable to the system customization
;;; location where an example user interface customizations file exists. The
;;; individual user can change the value to a location of his/her choice in the
;;; individual's LISP initialization file (e.g., .clinit.cl for Allegro CL).
;;;
(defvar *personal-customizations-path* 
  *customizations-path* 
  "Path to where user customizations and patches are located.")




(defvar *post-tcl-customizations-filename* "overload.tcl"
  "Name of the tcl/tk file that is loaded after the standard ui files.")


(defparameter *run-with-no-terminal-io* nil
  "If t, do not write to the screen.")


;;;
;;; If t then load overload file that redefines functions  fire-prefer (from 
;;; file matcher-interface.lisp), expand-goal, really-expand-operator, 
;;; do-apply-op (all from file search.lisp). This redefinition is the same 
;;; except that they also save the names of any fired preference rules to the 
;;; :why-chosen field of the plist of the search node.
;;;
;;; Are other functions in the file now? [18jun98 cox]
;;;
(defparameter *load-patches* t)


;;;
;;; I should make this a variable and add the ability to run with or without
;;; partial goal satisfaction in the UI.
;;;
(defparameter *load-partial-goal-satisfac* nil)


;;;
;;; If t, then the JADE front end to Prodigy is also loaded. The front end
;;; accepts ForMAT input and provides case modification suggestions to its user
;;; in the Jade integrated system.
;;;
;;; [mcox 11jul96; 18apr97] Note also that this variable is referenced by the
;;; UI when determining whether or not to add a button in the planning mode
;;; menu for the JADE demo. See overload.tcl.
;;;
(defvar *load-prodigy-front-end* nil)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; PRODIGY Loading Code
;;;


;;;
;;; Function load-prodigy loads the system as configured by program parameters
;;; and user interaction.
;;;
(defun load-prodigy (&key 
		     load-monitor-code
		     (custom-dir-path
		      *customizations-path*)
		     (personal-custom-dir-path
		      *personal-customizations-path*)
		     )
  ;; Load the base Prodigy system first.
  (load (concatenate 
	 'string 
	 *prodigy-base-directory* 
	 "working/loader.lisp"))
  ;; Set the post tcl customizations file.
  (setf *post-tcl-customizations* 
	(concatenate 
	 'string 
	 personal-custom-dir-path
	 *post-tcl-customizations-filename*))
  (when *load-patches*
	(load 
	 (if *load-prodigy-immediately*
	     ;; Then load binary file
	     (concatenate 
	      'string 
	      *binary-pathname* 
	      "overload." 
	      *binary-extension*)
	   ;; else load source file
	   (concatenate 
	    'string 
	    custom-dir-path 
	    "/overload.lisp"))
	 )
	;; By changing this value, recompiles (and reloads) of the planner will
	;; incorporate any patches.
	(setf *prodigy-modules*
	      (append 
	       *prodigy-modules*
	       (list 
		(list
		 (concatenate
		  'string
		  (matches-initial-substr 
		   *system-directory* 
		   *customizations-path*)
		  "/")
		 "overload")))))
  ;; Load the front-end for JADE 
  (when *load-prodigy-front-end*
	(load (concatenate 
	       'string 
	       *system-directory* 
	       "jade/loader.lisp"))
	(use-package "FE")
	)
  ;; Load the code to handle partial goal satisfaction
  (if *load-partial-goal-satisfac*
      (load (concatenate 
	     'string 
	     *system-directory* 
	     "contrib/partial-satisfaction.lisp")))
  (if load-monitor-code
      ;;Load the code to perform interleaved planning and execution with
      ;;rationale-based monitoring of the environment.
      (load (concatenate
	     'string
	     *system-directory* 
	     "monitors/loader"))
    )
  )



;;;
;;; Function matches-initial-substr checks to see if arg-string has initial-str
;;; as a leading substring, and if so, it returns the "remainder" of the string
;;; (i.e., the tail of the string after the matching part). If not, it returns
;;; the string (i.e., "NIL"). The reason for this latter return value is so
;;; that if the value is passed to read-from-string, it will not have problems
;;; taking input from it in either case.
;;; 
(defun matches-initial-substr (substr 
			       full-str
			       &aux
			       (init-str-len
				(length substr))
			       (full-str-len
				(length full-str)))
  (if (and 
       (>= full-str-len
	   init-str-len)
       (string= substr 
		(subseq full-str 
			0 
			init-str-len)))
       (subseq full-str 
	      init-str-len
	      (- full-str-len 1))
    "NIL")
  )


(defun disable-terminal-io (run-with-no-terminal-io)
  (when run-with-no-terminal-io
	(setf *load-verbose* nil)
	(setf lisp:*load-print* nil)
	(setf *error-output* 
	      (make-string-output-stream))
	(setf *standard-output* 
	      (make-string-output-stream)))
)



;----------------------------------------------------------------------------



(cond (*disable-loading*
       nil				;do nothing
       )
      (*run-experiment*			;*run-experiment* parameter defined in
					;*system-directory*/monitors/parameters.lisp
       (disable-terminal-io 
	*run-with-no-terminal-io*)
       (load-prodigy :load-monitor-code t)
       (run-experiment)
       (exit)
       )
      (*interactive-loading*
       (if (y-or-n-p "Load Prodigy? ")
	   (if (y-or-n-p "Load Monitor Code? ")
	       ;; Note that if *load-sensing-only* nil, then even if user says "y",
	       ;; will not load all of the code. See parameters.lisp.
	       (load-prodigy :load-monitor-code t)
	     (load-prodigy :load-monitor-code nil)
	     )) 
       )
      (t
       (load-prodigy :load-monitor-code *load-monitors-p* )
       )
      )

