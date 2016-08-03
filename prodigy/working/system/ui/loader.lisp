(in-package "USER")

;;;
;;; NOTE that most of the contents of this file used to be contained in ui.lisp
;;;
;;; NOTE also that changes marked CRH are from Clint Hyde of BBN (Boston).
;;;


;;; History 
;;;
;;;
;;; 11mar98 Added compiled code loads and compile functions modified from
;;; setup2.lisp in Prodigy/Analogy source. [cox]
;;;
;;; 20mar98 Modified loading calls to differentiate between execution on
;;; Pushkin (Solaris) and other machines (SunOS). [cox] 
;;; 
;;; Removed socket module from *ui-modules* if version 5.0.1 of Allegro is
;;; running. [2aug00 cox]




(defparameter *prod-ui-home* 
  (concatenate 'string 
	       *system-directory*
	       "ui/"))


(defparameter *tcl-home* 
  "/Program Files/Tcl/"
  )

(defvar *tcl-customizations* 
  (concatenate 'string 
	       *prod-ui-home*
	       "example-param-custom.tcl")
  "A string specifying a file with your personal tcl code")

;;; NOTE that this must remain a variable rather than a parameter so that users
;;; can change it. Otherwise the value remains nil when the systrem tries to
;;; load it. [cox 31oct96]
;;;
(defvar *post-tcl-customizations* nil
  "String specifies file with code loaded last that overloads existing code")


(defvar *load-ui-immediately* t
  "If t, then load binaries, else load source code.")


(defparameter *ui-modules*
    #+(and ALLEGRO-V6.0) 
    '(("lisp-source/"  "tcl" "prod-specific" "ask-rules" "shell" 
     ;;"ipc" ;Clint Hyde replaced the need for this file. 
     "scrollbutton" "op-graph" "ui" 
     )
      )
    #-(and ALLEGRO-V6.0) 
    '(("lisp-source/"  "tcl" "prod-specific" "ask-rules" "shell" 
     ;;"ipc" ;Clint Hyde replaced the need for this file. 
     "scrollbutton" "op-graph" "ui" 
     )
    ("/sockets/"  "c-interface" "socket-interface"
     )
      )
    )


(defparameter *ui-binary-pathname*
  (set-binary-path *prod-ui-home*)
  )





;;; Added [17jun98 cox]
(defun load-ui-source ()
  (dolist (module *ui-modules*)
    (dolist (file (rest module))
      (load (concatenate 'string *prod-ui-home*  (first module) file))))
  )

(defun load-ui-binaries ()
  (dolist (module *ui-modules*)
    (dolist (file (rest module))
      (load (concatenate 'string *ui-binary-pathname*  file))))
  )



(defun ui-compile-all ()
  (dolist (each-mod *ui-modules*)
    (dolist (each-file (rest each-mod))
	    (p-compile 
	     (first each-mod)
	     each-file 
	     *prod-ui-home*
	     *ui-binary-pathname*)
	    ))
  )


;;;this is new, CRH. 10-2-97.
;(load (concatenate 'string *prod-ui-home* "/sockets/c-interface.lisp"))
;(load (concatenate 'string *prod-ui-home* "/sockets/socket-interface.lisp"))

;;;commented, for new socket code. CRH, 10-2-97.
;(load (concatenate 'string *prod-ui-home* "/ipc"))

;;; del 17jun98 (load (concatenate 'string *prod-ui-home* "/tcl"))

;;; Want this loaded up front for the partial order stuff to work
;;; smoothly
#|
(unless (find-package "PSGRAPH") (make-package "PSGRAPH"))
(load "/afs/cs/project/prodigy-aperez/order/access-fns-pro4.lisp")
(load "/afs/cs/project/prodigy-aperez/order/my-release-partial.lisp")
(load "/afs/cs/project/prodigy-aperez/order/process-preconds.lisp")
(load "/afs/cs/project/prodigy-jblythe/tcl-tk/footprint.lisp")
(load "/afs/cs/project/prodigy-aperez/codep4/psgraph.lisp")
(load "/afs/cs/project/prodigy-aperez/codep4/print-partial.lisp"))

(load (concatenate 'string 
		   (if *load-ui-immediately* *ui-binary-pathname* *prod-ui-home*) 
		   "/prod-specific" 
		   (if *load-ui-immediately* ".fasl" ".lisp")))
;;;Added to implement user control of planning decisions [19sep97 cox]
(load (concatenate 'string 
		   (if *load-ui-immediately* *ui-binary-pathname* *prod-ui-home*)
		   "/ask-rules"
		   (if *load-ui-immediately* ".fasl" ".lisp")))
;;; Added [15jun98 cox]
(load (concatenate 'string 
		   (if *load-ui-immediately* *ui-binary-pathname* *prod-ui-home*)
		   "/shell"
		   (if *load-ui-immediately* ".fasl" ".lisp")))
(load (concatenate 'string 
		   (if *load-ui-immediately* *ui-binary-pathname* *prod-ui-home*) 
		   "/scrollbutton"
		   (if *load-ui-immediately* ".fasl" ".lisp")))
(load (concatenate 'string 
		   (if *load-ui-immediately* *ui-binary-pathname* *prod-ui-home*) 
		   "/op-graph"
		   (if *load-ui-immediately* ".fasl" ".lisp")))


;;; Added [15jun98 cox]
(load (concatenate 'string 
		   (if *load-ui-immediately* *ui-binary-pathname* *prod-ui-home*) 
		   "/ui"
		   (if *load-ui-immediately* ".fasl" ".lisp")))

|#

;;; Placed here because I removed it from ask-rules.lisp. Wanted that file to
;;; be compiled, but this function cannot be compiled with the control
;;; rules. [17jun98 cox]
;;;
(defun enable-user-control (flag)
  "Turn on user guidance and load the control rules."
  (setf *user-guidance* flag)
  (when flag
	(control-rule ASK-FOR-GOAL
		      (if (and
			   (user-prefers-goal <goal>)))
		      (then prefer goal <goal> <g>))

	(control-rule ASK-FOR-OPERATOR
		      (if (and
			   (user-prefers-operator <operator>)))
		      (then prefer operator <operator> <ops>))

	(control-rule ASK-FOR-BINDINGS
		      (if (and 
			   (user-prefers-bindings <bindings>)))
		      (then prefer bindings <bindings> <bs>))
	))


(if *load-ui-immediately*
    (load-ui-binaries)
  (load-ui-source))
