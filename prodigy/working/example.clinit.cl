;;;
;;; Example Allegro Common LISP initialization file
;;;

;;;This overrides the default, even after loading loader.lisp.
;;;
(setf *prodigy-base-directory* "/afs/cs/user/mcox/prodigy/")

(excl:chdir *prodigy-base-directory* )

;;; Reset the default domains directory. This also overrides the default when
;;; loading the loader file.
;;;
(setf *world-path* 
      (concatenate 'string *prodigy-base-directory* "working/domains/"))

;;; This overrides the default. If t, do not prompt user. Run experiment
;;; instead.  
;;;
(setf *run-experiment* nil)

(setf *load-prodigy-front-end* t)


(defun init-print-vars ()
  (cond ((search
	       "Allegro"
	      (lisp-implementation-type))
         (set (find-symbol "*PRINT-LENGTH*" 'top-level) nil)
         (set (find-symbol "*PRINT-LEVEL*" 'top-level) nil))))



(tpl:setq-default *print-nickname* t)

(tpl:setq-default top-level:*zoom-display* 10)
(tpl:setq-default top-level:*zoom-print-level* 10)
(tpl:setq-default top-level:*zoom-print-length* nil)

(init-print-vars)




(load (concatenate
       'string
       *prodigy-base-directory*
       "working/system-loader.lisp"))




