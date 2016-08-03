;;;***************************************************************************
;;;
;;; History:
;;;
;;;         NOTE that setup2.lisp is now called loader.lisp (i.e., this file)
;;;         in order to be consisant with the remainer of the PRODIGY modules.
;;;
;;; 12sep97 Created setup2.lisp to replace setup.lisp. Difference is that the
;;;         Development subdirectory that contains the x-analogy code is now
;;;         considered a full-fledged part of the analogy code. It is now
;;;         listed as an analogy module in *analogy-modules*. The separate code
;;;         to load interpreted x-analogy code has been removed. It is now
;;;         compiled along with the rest and loaded as binaries. [cox]
;;;
;;;


;;; Setup of path to analogy source and compiled files
(defparameter *analogy-pathname* 
  (concatenate
   'string
   *system-directory*
   "analogy/"))

(defparameter *analogy-binary-pathname*
  (set-binary-path *analogy-pathname*)
  )


;;;***************************************************************************
;;; Defines the files to be loaded for analogy 
;;; Some extra code is needed for the analogy control rules.
;;; The extra printing code is just here because I like this way of showing
;;; the alternatives at the applied op level.

(defparameter *analogy-modules*
  '(("prodigy-extras/"  "operator-inf-rule" "binding-ctrl-rules"
                        "my-comforts" "print-current-search-path")
    ("storage/"   "case-structures" "access-case" "store" "save-case"
                  "footprint" "print-rules" "preconds")
    ("loading/"   "load-cases" "load-case-headers")
    ("replay/"    "newest-replay" "interrupt-replay")
    ("retrieval/" "manual-retrieval" "retrieve-test")
    ("tcl/" "load-cases-tcl")
    ("Development/"  "loadtrace" "x-retrieval" "x-replay" 
                     "x-step" "x-analogy-support" "x-merge-eval")
   ))

;;;***************************************************************************
;;; Different functions to load and compile analogy

(defun load-analogy-source ()
  (dolist (each-mod *analogy-modules*)
    (dolist (each-file (cdr each-mod))
      (p-load 
       (car each-mod) 
       each-file 
       *analogy-pathname*)
      ))
  (setf *analogy-loaded* t))


;;; NOTE that *binary-extension* is defined in Prodigy's loader.lisp file in
;;; *prodigy-root-directory*.
;;;
(defun analogy-compile-all ()
  (dolist (each-mod *analogy-modules*)
    (dolist (each-file (rest each-mod))
      (p-compile (first each-mod)
		 each-file 
		 *analogy-pathname*
		 *analogy-binary-pathname*)
      )))

(defun load-analogy ()
  (let ((old-print-case *print-case*))
    (dolist (module *analogy-modules*)
      (let ((ender (concatenate 
		    'string 
		    "." 
		    *binary-extension*))
	    (*load-verbose* t))
	(dolist (file (cdr module))
	  ;;(format t "~%Loading ~S"  (concatenate 'string *analogy-binary-pathname* file ender))
	  (load (concatenate 
		 'string 
		 *analogy-binary-pathname* 
		 file 
		 ender)))))
    (setf *analogy-loaded* t)
    (setf *print-case* old-print-case)))


;;;***************************************************************************
(defvar *load-analogy-immediately* t)


;;;***************************************************************************
;;; Other settings
(setf *class-short-names* nil)

(setf *automated-retrieval* nil
      *analogical-replay* nil
      *a-star-search* nil
      *weaver-search* nil
      *talk-case-p* t
      *always-remove-p* t
      p4::*print-search-path-p* t
      *ui* nil)

(setf p4::*compile-tests* nil)
(setf p4::*use-new-matcher* nil)

(clear-prod-handlers)

;;;***************************************************************************
;;; Only makes sense to call after load-analogy was called.

(defun set-for-replay ()
  (clear-prod-handlers) ;;not sure what is the effect of this in other handlers.
  (define-prod-handler :always #'link-to-case-prodigy-node)

  (setf *automated-retrieval* nil
	*analogical-replay* t
	*a-star-search* nil
	*weaver-search* nil
	*talk-case-p* t
	*merge-mode* 'saba
	*ui* nil))

;;; Don't forget that the control rules for replay need to be loaded with
;;; the domain. The rules are in /afs/cs/project/prodigy-1/analogy/replay-crs.lisp
;;;***************************************************************************

(defun set-for-replay-ui ()
  (setf *ui* t))


(if *load-analogy-immediately*
    (load-analogy)			;Load binaries
  (load-analogy-source))

(format t "~%;;; Prodigy-Analogy is loaded.~%~%")


(set-for-replay)




