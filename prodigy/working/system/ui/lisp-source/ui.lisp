(in-package "USER")

;;;
;;; I'll try to set everything up in here.
;;; Things pointed to here will move around and become stable later
;;; on, but this file will always define prod-ui, which will start up
;;; the ui from lisp.
;;;

;;; History 
;;;
;;; 23apr97 Reconciled the code with Jim's UI version that uses the latest
;;; Tcl/Tk [cox] 
;;;
;;; 15jun98 Split off code pertaining to shell management into new file
;;; (shell.lisp), and split off code pertaining to loading and compiling the UI
;;; into a separate loader file (loader.lisp). Moved ping function to
;;; tcl.lisp. [cox]



#|
;;; This constant and the predicate below also are defined in the .clinit.cl
;;; file so that other loader files can use the functions.
;;;
(defconstant *Pushkin* "id: #x-7f836c05"
  "The string returned by a call of machine-instance when lisp runs on Pushkin.")

;;;
;;; This predicate depends on global constant *Pushkin* above. Knowing whether
;;; the code runs on pushkin is important because Pushkin runs Solaris (not
;;; SunOS) and Allegro 4.3 (not 4.2) from local disks (not afs). The predicate
;;; is used to set path names in gobal program parameters.
;;;
(defun running-on-pushkin-p ()
  "Predicate returns t iff the code runs on the Sparc called pushkin.prodigy.cs.cmu.edu."
  (equal (machine-instance)
      *Pushkin*)
  )
|#



;;; Not using -f so that tcl code can be run before the main ui, which
;;; is necessary under the current scheme for adding to the menu windows.
;;;
;;; Added manual-ui switch to allow loading of tcl code from a separate
;;; tcl window if desired (just pass non-nil arg). If so then prod-ui 
;;; will not source the tcl code. [cox 5may97]
;;;
#+original
(defun prod-ui (&optional manual-ui)
  (let ((tcl-lib (concatenate 'string *tcl-home* 
			      "lib"
			      ))
	(tcl-bin (concatenate 'string *tcl-home*
			      (if (running-on-pushkin-p)
				  "bin"
				"tk4.2/unix")
			      )))
    ;; Create dummy problem-space if none already exists. [cox 28may97]
    (if (not (boundp 
	      '*current-problem-space*))
	(setf *current-problem-space* 
	      (p4::make-problem-space :name 'dummy)))
    (format t "~%Restarting tcl server..")
    (kill-tcl-server :silent t)
    (start-tcl-server t)		; tcl7.5 only supports tcp sockets
    (init-shell)
    (unless (probe-file 
	     (concatenate 
	      'string 
	      tcl-bin 
	      ;;NOTE that if Tcl/Tk has been installed the binary file is
	      ;;called wish4.2. Thus, the person installing PRODIGY should set
	      ;;a symbolic link from it to the name "wish".
	      "/wish"))	
	    (setf tcl-lib  *tcl-home*)
	    (setf tcl-bin  *tcl-home*))
    (send-shell (format nil "setenv TCL_LIBRARY \"~A~A\"" 
			(if (running-on-pushkin-p)
			    tcl-lib
			  *tcl-home*)
			(if (running-on-pushkin-p)
			    "tcl7.6"
			  "tcl7.6/library")
			))
    (send-shell (format nil "setenv TK_LIBRARY \"~A~A\"" 
			tcl-lib
			(if (running-on-pushkin-p)
			    "tk4.2"
			  "tk4.2/library")
			  ))
    (unless manual-ui
	    (send-shell (format nil "~A~A -geometry 1x1+0+0" 
				tcl-bin
				"/wish"))
	    (sleep 5)
	    (send-shell (format nil 
				"source ~A/ui-start.tcl" 
				*prod-ui-home*
				))
	    (sleep 1)
	    (if *tcl-customizations*
		(send-shell (format nil "source ~A" *tcl-customizations*)))
	    (sleep 1)
	    (send-shell (format nil 
				"source ~A/ui-comm.tcl" 
				*prod-ui-home*)) ;[cox 15dec96]
	    (if *post-tcl-customizations*
		(send-shell (format nil "source ~A" *post-tcl-customizations*)))
	    )
    ;; UI begins in generative mode.
    (setf *analogical-replay* nil)	;[cox 26jan97]
    )
  )


;;;
;;; Simpler version [cox 20jul98]
;;;
(defun prod-ui (&optional manual-ui)
  (let ((tcl-bin (concatenate 'string *tcl-home*
			      (if (probe-file
				   (concatenate 'string 
						*tcl-home*
						"bin/wish"))
				  "bin"
				"tk4.2/unix")
			      )))
    ;; Create dummy problem-space if none already exists. [cox 28may97]
    (if (not (boundp 
	      '*current-problem-space*))
	(setf *current-problem-space* 
	      (p4::make-problem-space :name 'dummy)))
    (format t "~%Restarting tcl server..")
    (kill-tcl-server :silent t)
    (start-tcl-server t)		; tcl7.5 only supports tcp sockets
    (unless manual-ui
            (init-shell)
	    (send-shell (format nil "~A~A -geometry 1x1+0+0" 
				tcl-bin
				"/wish"))
	    (sleep 5)
	    (send-shell (format nil 
				"source ~A/ui-start.tcl" 
				*prod-ui-home*
				))
	    (sleep 1)
	    (if *tcl-customizations*
		(send-shell (format nil "source ~A" *tcl-customizations*)))
	    (sleep 1)
	    (send-shell (format nil 
				"source ~A/ui-comm.tcl" 
				*prod-ui-home*)) ;[cox 15dec96]
	    (if *post-tcl-customizations*
		(send-shell (format nil "source ~A" *post-tcl-customizations*)))
	    )
    ;; UI begins in generative mode.
    (setf *analogical-replay* nil)	;[cox 26jan97]
    )
  )


