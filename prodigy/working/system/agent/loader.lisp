(in-package :user)

(defvar *load-wrapper-immediately* t
  "If t, then load binaries, else load source code.")


(defvar *wrapper-home* 
    (concatenate
               'string
	    *system-directory* "agent/"))

(defparameter *wrapper-modules*
    '(("latest-source/"  "registrar" "goal-extract"
			"in-wrap" "process-domain-file"
			"file-fns" "plan2frames"
			"frame2alternate" "patches3"
			"kqml"  "application-agent" 
			)
      ("utils/" "shell"
       )
      ("a-distance/" "plans2vectors" "a-dist-eval" 
                     "data-alt" ;"data" 
                     "plan2frames-and-state"
                     "adist6" "atest4"
       )
   ))


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

;(load (concatenate
;	  'string
;	*wrapper-home*
;	"java-lisp.sockets/loader.lisp")
;      )

;;; 
;;; Function load-a-dist loads the code that implements the data
;;; generator for the A-distance evaluation. [mcox 24jan12]
;;; 
(defun load-a-dist (&optional
		    (current-domain
		     'logistics))
  ;;(load 
  ;; (format nil
	;;   "~Achanged/plan2frames-and-state.lisp"
	;;   *wrapper-home*))
  ;;(load (concatenate 'string 
	;;  *wrapper-binary-pathname*  
	 ;; "plans2vectors"))
  ;;(if (eql 'blocksworld
;;	   current-domain)
 ;;     (load 
  ;;     (format nil
;;	       "~Adata.lisp"
;;	       *wrapper-home*)))
  (if (eql 'logistics
	   current-domain)
      (load (concatenate 'string 
	      *wrapper-binary-pathname* 
	      "data-alt"))
    )
    ;; Nothing for extended-STRIPS yet.

  ;;(load (concatenate 'string 
	;;  *wrapper-binary-pathname*  
	;;  "a-dist-eval"))
  ;; Function initialize defined in plan2vectors loaded above.
  (initialize current-domain)
  )
