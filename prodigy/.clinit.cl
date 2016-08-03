(in-package :user)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; 
;;; Allegro Common LISP initialization file
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; General configuration
;;; 
;;; With *Run-POIROT*, *Run-INTRO* and *interactive-loading* all nil, 
;;; you get a clean Lisp.
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defvar *Run-POIROT* nil
  "When t, Meta-AQUA will be set up to run with POIROT")

(defvar *Run-INTRO* nil
  "When t the init file will automatically set up for the INTRO demo")

;;; When t, will prompt for code to load.
(setf *interactive-loading* t)

(setf *myhost* (string-downcase (short-site-name)))

;(setf (readtable-case *readtable*) :upcase)

(defvar *Current_Default_Dir* nil)


(defun init-print-vars ()
  "Remove limits on printing large sexps"
  (cond ((search
	       "Allegro"
	      (lisp-implementation-type))
         (set (find-symbol (string '*print-length*) 'top-level) nil)
         (set (find-symbol (string '*print-level*) 'top-level) nil))))

(tpl:setq-default *print-nickname* t)

(tpl:setq-default top-level:*zoom-display* 10)
(tpl:setq-default top-level:*zoom-print-level* 10)
(tpl:setq-default top-level:*zoom-print-length* nil)





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; 
;;; PRODIGY specific
;;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; Variable defined in *prodigy-base-directory*/working/loader.lisp
(setf *load-prodigy-immediately* t)

(setf *load-wrapper-immediately* t)
(setf *load-analogy-immediately* t)

;;;These override the default, even after loading loader.lisp.
;;;
(setf *prodigy-base-directory* "/fs/metacog/group/systems/prodigy/"
	)


;;; The following must be executed to establish packages before
;;; my-init-prod is interpreted.
;;;
(unless (find-package "PRODIGY4")
  (make-package "PRODIGY4" 
		:nicknames 
		'(:p4)))
(unless (find-package "FRONT-END")
  (make-package "FRONT-END" 
		:nicknames 
		'(:fe) 
		:use 
		'(:lisp :p4)))

;;; 
;;; Initialization function for PRODIGY
;;;
(defun my-init-prod (&optional 
		     (load-jade 
		      (or (not *interactive-loading*)
			  (y-or-n-p "Load JADE? "))))
  ;; Reset the default domains directory. This also overrides the default when
  ;; loading the loader file.
  (setf *world-path* 
    (concatenate 'string *prodigy-base-directory* "working/domains/"))
  ;; This overrides the default. If t, then loads JADE binaries.
  (if load-jade
      (setf fe::*load-format-immediately* t))
  ;; This overrides the default. If t, do not prompt user. Run experiment
  ;; instead.  
  (setf *run-experiment* nil)
  (setf *load-prodigy-front-end* t)
  (load (concatenate
	 'string
	 *prodigy-base-directory*
	 "working/system-loader.lisp"))
;  (when (y-or-n-p "Load Transducers? ")
;    (load "/usr/local/mcox/Research/ABMIC/Boris/plan2frames.lisp")
;    (load "/usr/local/mcox/Research/ABMIC/Boris/frame2alternate.lisp")
;    (load "/usr/local/mcox/Research/ABMIC/Boris/in-wrap.lisp")
;    )
  )


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; 
;;; Meta-AQUA, POIROT, and INTRO specific
;;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; CHANGE APPROPRIATELY
;; 
;; Defined in the main Meta-AQUA loader file
(setf *Meta-AQUA-system-dir* 
  "/fs/metacog/group/systems/Meta-AQUA/"
  ;;"c:/Meta-AQUA/"
  ;;"c:/poirot/alldev/meta-aqua/"
  ;;"c:/poirot/MA_STITCH_wit/meta-aqua/"  
  ;;  "~/PotalaFiles/Meta-AQUA/Development/"
  )

;; Defined in the main Meta-AQUA loader file
;; To (re)compile the Meta-AQUA system, set to t
(setf *do-compile-Meta-AQUA* nil)

;;; Defined in POIROT/Meta-AQUA loader to disable auto loading of the Lisp 
;;; connector. The default value is t. 
;;; 
;;; IF RUNNING META-AQUA STANDALONE WITH JAVA WINDOWS, COMMENT OUT LINE BELOW
;;; RATHER THAN SIMPLY MAKING NIL.
;;;
;(setf *run-connector-immediately* t)

(setf *intro-base-dir* 
  "w:/My Documents/BBN/Perpa/"
  ;;"C:/Documents and Settings/mcox/My Documents/BBN/Perpa/"
  )

(defun load-meta-aqua ()
  (load (concatenate 'string 
	  *Meta-AQUA-system-dir* 
          "loader.lisp"))
  )

(defun load-prodigy-window ()
  (load (concatenate 'string *intro-base-dir* "prodigy-op")) 
  (prodigy-op-window)
  )

(defun load-wumpus-window ()
  (load (concatenate 'string *intro-base-dir* "wumpuswindow")) 
  (wumpuswindow)
  )

(defun load-intro ()
  (load (concatenate 'string *intro-base-dir* "rep_w-world"))
  (load (concatenate 'string *intro-base-dir* "patches-meta-aqua"))
  (load (concatenate 'string *intro-base-dir* "intro"))
  (load (concatenate 'string *intro-base-dir* "translator"))
;;  (load (concatenate 'string *intro-base-dir* "newkqml"))
  (load (concatenate 
	    'string 
	  *prodigy-base-directory* 
	  "working/system/agent/.mswin-allegro-6.2/plan2frames-and-state.fasl"))
  (load (concatenate 'string *intro-base-dir* "dictionary")))


(defun load-intro-demo (&optional
			auto?)  
  (cond (auto?
	 (init-jlink)
	 (load-meta-aqua)
	 (load-prodigy-window)
	 (load-intro)
	 (load-aima-agents)
	 (init-jlink)
	 (load-wumpus-window)
	 )
	(t
	 (format t "Select window: 1) Prodigy 2) Meta-aqua 3) Wumpus simulation~%")
	 (case (read)
	   (1
	    (init-jlink)
	    (load-meta-aqua)
	    (load-prodigy-window)
;	    (load-intro)
	    )
	   (2
	    (init-jlink)
	    (load-meta-aqua)
	    (load-meta-aqua-windows)
	    ;(load-intro)
	    )
	   (3
	    (load-aima-agents)
	    (init-jlink)
	    (load-wumpus-window)
	    )
	   )
	 ;; Added because wumpus environment now needs to call function defined
	 ;; in translator.lisp. So all 3 cases load intro [mcox 9mar06]
	 (load-intro)))
  )



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; 
;;; Misc
;;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setf *Aima-base-directory* "w:/My Documents/Aima/"
					;"C:/Documents and Settings/mcox/My Documents/Aima/"
      )

;;; Specific for AIMA code
(defvar *test-agents-loaded* nil)

(defun load-aima-agents ()
  (load (concatenate
	    'string
	  *Aima-base-directory*	
	  "aima"))
    (setf *test-agents-loaded* t)
    (test 'agents)
  (setf *Current_Default_Dir* *Aima-base-directory*)
  (excl:chdir *Current_Default_Dir* )
  )


;;; Default port for UI-PRODIGY socket. 21sep99
(setf *default-port* 5679)


(setf *Paip-base-directory* "C:/Documents and Settings/mcox/My Documents/Paip/")
(setf *local-Paip-base-directory* 
  "C:/Documents and Settings/mcox/My Documents/Teaching/2000/Cs609/Paip/")
;(excl:chdir *Paip-base-directory*)




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; 
;;; Main body
;;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(init-print-vars)

(when (or (and *interactive-loading*
	       (y-or-n-p "Load Prodigy 4.0? "))
	  *Run-INTRO*)
  (my-init-prod))


;;; This should never get loaded
(if (and *interactive-loading* 
	 nil
	 (y-or-n-p "Load P4P? ")
	 )
    (load "C:/Documents and Settings/mcox/My Documents/prodigy/working/Wrapper/P4P/loader.lisp"))

(if (or (and *interactive-loading*
	       (y-or-n-p "Load PRODIGY/Agent? "))
	*Run-INTRO*)
    (load (concatenate
	      'string
	    *system-directory*
	    "agent/loader.lisp")))


(when (and *interactive-loading* 
	   ;nil
	   (y-or-n-p "Load AIMA code? ")
	   )
    (load (concatenate
           'string
	   *Aima-base-directory*	
	   "aima.lisp"))
	   (setf *Current_Default_Dir* *Aima-base-directory*)
	   (excl:chdir *Current_Default_Dir* )
	     )


(when (and *interactive-loading* 
	   ;nil
	   (y-or-n-p "Load PAIP code? ")
	   )
    (load (concatenate
           'string
	   *Paip-base-directory*	
	   "auxfns.lisp"))
    (load (concatenate
           'string
	   *Paip-base-directory*	
	   "intro.lisp"))
    (load (concatenate
           'string
	   *Paip-base-directory*	
	   "simple.lisp"))
    (load (concatenate
           'string
	   *Paip-base-directory*	
	   "syntax1.lisp"))
    (setf *Current_Default_Dir* *Paip-base-directory*)
;    (excl:chdir *local-Paip-base-directory*)
    (setf *default-pathname-defaults* 
      "C:/Documents and Settings/mcox/My Documents/Paip/")
    (load (concatenate 'string
	      *local-Paip-base-directory* 
	    "loader.lisp"))
    )


(when (or *Run-INTRO*
	  *Run-POIROT*
	  (and *interactive-loading*
	       (y-or-n-p (concatenate 
			     'string 
			   (if *do-compile-Meta-AQUA* 
			       "Compile " 
			     "Load ")
			   "Meta-AQUA? ")))
	  )
  (load-meta-aqua)
  (when (and (not *do-compile-Meta-AQUA*)
	     (not *Run-POIROT*)
	     (or *Run-INTRO*
		 (and *interactive-loading*
		      (y-or-n-p "Load Meta-AQUA internal structures display?"))
		 )
	     )
    (init-jlink)
    (load-meta-aqua-windows)
    )
  )


(when (or *Run-INTRO*
	  (and *interactive-loading*
	       (y-or-n-p "Load Introspective Agent demo? ")
	       ))
  (load-intro-demo 
   (not *interactive-loading*)))


;;; To demo Meta-AQUA proper with original Elvis World example, comment out all
;;; loads below.

(when *Run-POIROT*
  ;; Load the telnet server
  (load (concatenate 'string 
	*Meta-AQUA-system-dir* 
	"../lisp/src/lisp/tserver.cl"))
  ;; Load the Lisp Connector
  (load (concatenate 'string 
	*Meta-AQUA-system-dir* 
	"../lisp/src/lisp/loader.cl"))
  ;; Load POIROT/Meta-AQUA  
  (load (concatenate 'string 
	*Meta-AQUA-system-dir* 
	"Poirot/loader")))


;; The following is now done in the POIROT/Meta-AQUA loader.
;;(start (setf *app* (make-instance 'Meta-AQUA-lisp-app :port-number 9095)))

;; Uncomment next line if using Meta-AQUA Internal Structures Display Windows
;(load-meta-aqua-windows)

;; or loading Meta-AQUA stub
;;(load (concatenate 'string 
;;	*Meta-AQUA-system-dir* 
;;	"../lisp/src/lisp/meta-aqua-loader"))

;; or loading example Lisp component 
;;(load (concatenate 'string 
;;	*Meta-AQUA-system-dir* 
;;	"../lisp/src/lisp/example-loader"))

;; Or Goldman's example
;;(load (concatenate 'string 
;;	*Meta-AQUA-system-dir* 
;;	"../ltml/src/lisp/load.lisp")
;;(load (concatenate 'string 
;;	*Meta-AQUA-system-dir* 
;;	"../lisp/src/lisp/rpg-example-loader")



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; 
;;; To load SELF uncomment load below.
;;(load "c:/nlp/nlp/Self/workspace.lisp")
