;;;;
;;;; psm.lisp : Definitions of Lisp files used by the psm and functions
;;;;		   to load and compile them.
;;;;
;;;; George Ferguson, ferguson@cs.rochester.edu, 13 Dec 1995
;;;; Time-stamp: <Mon Jan 20 14:55:41 EST 1997 ferguson>
;;;;

(if (not (find-package "PSM"))
    (defpackage "PSM"))
(in-package "PSM")

;; managing interruptions
(defvar *PSM-interruptable* nil
  "should be set to nil when running in system")

;; Change this for a new version!
(defvar TRAINS_BASE_DEFAULT "/u/trains/96/2.2"
  "Default directory for loading files not found in the current directory.")

;; These are loaded by load-parser and compile-parser
(defvar *defn-files*
  '("structures")
  "Files with definitions common to multiple psm Lisp files.")

;; These are loaded by load-parser and compiled by compile-psm
(defvar *psm-files*
  '("Task_Tree"
    "PSM"
    "constraints"
    "domain_reasoner"
    "route-planner"
    "Interface"
    "kqml"
    "KB"
    "query"
    "QueryPreds"
    "Test-Code"
    "solutions"
           )
  "Files defining PSM functions.")

;;;
;;; Loading
;;;
(defun load-smart (filename)
  "Load FILENAME from either the current directory or a default directory
given by the environment variable TRAINS_BASE (or the value of the symbol
`TRAINS_BASE_DEFAULT' if the environment variable is not defined."
  (let ((TRAINS_BASE (or (sys:getenv "TRAINS_BASE") TRAINS_BASE_DEFAULT)))
    (or (load (format nil "~A" filename) :if-does-not-exist nil)
	(load (format nil "~A/etc/PSM/~A" TRAINS_BASE filename)))))

(defvar *PSM-TRACE-VERBOSE* nil)

(defun load-psm ()
  "Load the psm and initialize the grammar."
  ;; Load the psm files themselves
  (mapc #'load-smart (append *defn-files* *psm-files*))
  ;; Set various initializations
  (setq *PSM-TRACE-VERBOSE* nil)
  )

;;;
;;; Compiling
;;;

(defvar *fasl-extension*
#+(version>= 4 3) "fasl43"
#-(version>= 4 3) "fasl"
  "Extension added to compiled lisp (fasl) files. Different for 4.3.")

(defun compile-smart (filename)
  "Compile FILENAME.lisp into FILENAME.fasl only if the fasl file doesn't
exist or is older than the lisp file."
  (let ((lispfile (format nil "~A.lisp" filename))
	(faslfile (format nil "~A.~A" filename *fasl-extension*)))
    (if (and (probe-file faslfile) (excl:file-older-p lispfile faslfile))
	(format t "; Fasl file ~A is up to date~%" faslfile)
      (if (probe-file lispfile)
	  (compile-file filename :print nil)))))

(defun compile-psm ()
  "Compile the necessary psm .lisp files into .fasl files."
  ;; Compile the psm definitions (which don't depend on anything)
  (mapc #'compile-smart *defn-files*)
  ;; Load the (compiled) psm definitions
  (mapc #'load-smart *defn-files*)
  ;; Compile the remaining psm files (but not the grammar files)
  (mapc #'compile-smart *psm-files*)
  (load-psm)
  (values)
)

;;;
;;; When this file is loaded...
;;;
;; This is in the USER package so it can be used as a -e argument to lisp
(defvar user::psm-is-being-compiled nil
  "T if this file is being loaded for purposes of compiling.")

;; flag to ensure PSM has been initialized

(defvar *initialized* nil
  "T once a scenario has been defined")

(unless user::psm-is-being-compiled
  (load-psm))
