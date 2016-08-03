(in-package :user)

(defvar *load-wrapper-immediately* t
  "If t, then load binaries, else load source code.")


(defparameter *wrapper-home* 
    "w:/My Documents/prodigy/working/Wrapper/"
    )

(defparameter *wrapper-modules*
    '(("lisp-source/"  "registrar" "goal-extract"
			"in-wrap" "process-domain-file"
			"file-fns" "plan2frames"
			"frame2alternate" "patches3"
			"kqml"
			)
      ("utils/" "shell"
       )
   ))


(defparameter *binary-extension*
  #+APPLE "fasl"
  #+IBM-RT-PC "fasl"
  #+(and ALLEGRO MSWINDOWS) "fasl"
  #+(and ALLEGRO SUN3) "fasl"
  #+(and ALLEGRO DEC3100) "decf"
  #+(and ALLEGRO PRISM) "fasl"
  #+(and CMU PMAX) "pmaxf"
  #+(and (not LUCID) SPARC (NOT GCL)) "fasl"
  #+(or CLISP DOS) "fas"
  #+(and LUCID SPARC) "sbin"
  #+(and LUCID MIPS) "mbin"
  #+GCL "o")






(defparameter *wrapper-binary-pathname*
  (set-binary-path *wrapper-home*)
  )



(defun load-wrapper-source ()
  (dolist (module *wrapper-modules*)
    (dolist (file (rest module))
      (load (concatenate 'string *wrapper-home*  (first module) file))))
  )

(defun load-wrapper-binaries ()
  (dolist (module *wrapper-modules*)
    (dolist (file (rest module))
      (load (concatenate 'string *wrapper-binary-pathname*  file))))
  )



;;;
;;; Function p-compile compiles one file in a series of files within a
;;; module-based system. This is a generic routine that is used by various
;;; loader files of Prodigy modules and the Wrapper system.
;;;
(defun p-compile (module-dir
		  file-name
		  &optional 
		  (system-path
		   *system-directory*)
		  (binary-path
		   *binary-pathname*)
		  )
  (compile-file
   (concatenate 'string 
		system-path 
		module-dir
		file-name
		#+(OR GCL CLISP) ".lisp"
		)
   :output-file
   (concatenate 'string 
		binary-path file-name
		"." 
		user::*binary-extension*))
  )

(defun wrapper-compile-all ()
  (dolist (each-mod *wrapper-modules*)
    (dolist (each-file (rest each-mod))
	    (p-compile 
	     (first each-mod)
	     each-file 
	     *wrapper-home*
	     *wrapper-binary-pathname*)
	    ))
  )




(if *load-wrapper-immediately*
    (load-wrapper-binaries)
  (load-wrapper-source))

(load (concatenate 
	  'string 
	*wrapper-home* 
	"lisp-source/performatives"))


(load (concatenate
	  'string
	*wrapper-home*
	"java-lisp.sockets/loader.lisp")
      )
