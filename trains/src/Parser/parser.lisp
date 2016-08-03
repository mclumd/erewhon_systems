;;;;
;;;; parser.lisp : Definitions of Lisp files used by the parser and functions
;;;;		   to load and compile them.
;;;;
;;;; George Ferguson, ferguson@cs.rochester.edu, 13 Dec 1995
;;;; Time-stamp: <Mon Jan 20 14:55:10 EST 1997 ferguson>
;;;;

(if (not (find-package "PARSER"))
    (defpackage "PARSER"))
(in-package "PARSER")

;; Change this for a new version!
(defvar TRAINS_BASE_DEFAULT
  "/fs/disco/group/systems/trains"
  ;;"/u/trains/96/2.2"
  "Default directory for loading files not found in the current directory.")

;; These are loaded by load-parser and compile-parser
(defvar *defn-files*
  '("parser/structures"
    "robust/parse"
    )
  "Files with definitions common to multiple parser Lisp files.")

;; These are loaded by load-parser and compiled by compile-parser
(defvar *parser-files*
  '("parser/trace"
    "parser/Chart"
    "parser/GrammarandLexicon"
    "parser/FeatureHandling"
    "parser/onlineParser"
    "parser/hierarchFeatures"
    "parser/attachment"
    "parser/hierarchy-functions"
    "parser/lex-functions"
    "parser/char"
    "parser/printing"
    "robust/robustParser"
    "robust/attachments"
    "robust/mouse"
    "robust/kqml"
    "robust/speeling" 
    "robust/types"
    "robust/unify"
    "robust/munger"
    "robust/parse"
    "robust/support_funs"
    "robust/questions"
    )
  "Files defining parser functions.")

;; These are loaded by load-parser but not compiled by compile-parser
(defvar *grammar-files*
  '("grammar/hierarchy"
    "grammar/phrase-grammar"
    "grammar/clause-grammar"
    "grammar/robust"
    "grammar/lexicalRules"
    "grammar/nonverb-lex"
    "grammar/verb-lex")
  "Files defining the grammar for the parser.")

;; Only used when the parser is running in "robust" mode
(defvar *robust-grammar-files*
  '("grammar/robust")
  "Files used in the robust grammar.")

;;;
;;; Loading
;;;
(defun load-smart (filename)
  "Load FILENAME from either the current directory or a default directory
given by the environment variable TRAINS_BASE (or the value of the symbol
`TRAINS_BASE_DEFAULT' if the environment variable is not defined."
  (let ((TRAINS_BASE (or (sys:getenv "TRAINS_BASE") TRAINS_BASE_DEFAULT)))
    (or (load (format nil "~A" filename) :if-does-not-exist nil)
	(load (format nil "~A/src/Parser/~A" TRAINS_BASE filename)))))

(defun load-silent (filename)
  "Load FILENAME from either the current directory or a default directory
given by the environment variable TRAINS_BASE (or the value of the symbol
`TRAINS_BASE_DEFAULT' if the environment variable is not defined."
  (let ((TRAINS_BASE (or (sys:getenv "TRAINS_BASE") TRAINS_BASE_DEFAULT)))
    (or (load (format nil "~A" filename) :verbose nil :if-does-not-exist nil)
	(load (format nil "~A/src/Parser/~A" TRAINS_BASE filename) :verbose nil))))

(defun load-parser ()
  "Load the parser and initialize the grammar."
  ;; Load the parser files themselves
  (mapc #'load-smart (append *defn-files* *parser-files*))
  ;; Set various initializations
  (disablegaps)
  (enablesem)
  (traceoff)
  ;; And load the grammar files
  (load-grammar)
  ;; init the spell checker's dictionary [must be done after loading
  ;; noun-lex.lisp and speeling-corrector.lisp]
  (init-spellchecklist-to-cities)
  (init-munger)
;;  (init-simplifier)
  )

;; Useful function for reloading
(defun load-grammar (&key (robust nil) (printsmart t))
  "Load the parser grammar files."
  (make-grammar nil)
  (make-lexicon nil)
  (cond (printsmart
	 (mapc #'load-smart *grammar-files*)
	 (when robust (mapc #'load-smart *robust-grammar-files*)))
	(t (mapc #'load-silent *grammar-files*)
  (when robust (mapc #'load-silent *robust-grammar-files*)))))

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
	  (compile-file filename :print nil)
	nil))))

(defun compile-parser ()
  "Compile the necessary parser .lisp files into .fasl files."
  ;; Compile the parser definitions (which don't depend on anything)
  (mapc #'compile-smart *defn-files*)
  ;; Load the (compiled) parser definitions
  (mapc #'load-smart *defn-files*)
  ;; Compile the remaining parser files (but not the grammar files)
  (mapcar #'compile-smart *parser-files*)
  (load-parser)
  (values)
)

;;;
;;; When this file is loaded...
;;;
;; This is in the USER package so it can be used as a -e argument to lisp
(defvar user::parser-is-being-compiled nil
  "T if this file is being loaded for purposes of compiling.")

(unless user::parser-is-being-compiled
  (load-parser))
