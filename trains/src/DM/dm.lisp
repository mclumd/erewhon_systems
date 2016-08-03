;;;;
;;;; dm.lisp : Definitions of Lisp files used by the DM and functions
;;;;		   to load and compile them.
;;;;
;;;; George Ferguson, ferguson@cs.rochester.edu, 13 Jan 1997
;;;; Time-stamp: <Wed Jan 15 13:39:42 EST 1997 ferguson>
;;;;

(when (not (find-package "DM"))
  (defpackage "DM"))
(in-package "DM")

;; This ordering is important!
(defvar *dm-defs*
  '("cl-lib/trains-cl-lib-def"
    "id/logging-def"
    "id/tt-kernel/kqml-library-def"
    "id/tt-simple-kr-def"
    "modules/speechacts/sa-defs-def"
    "lymphocyte/lym-def"
    "modules/kb-lib/kb-lib-def"
    "modules/world-kb/world-kb-def"
    "modules/reference-resolution/user-model-kb-def"
    "modules/display-manager/display-kb-def"
    "modules/generator/self-model-kb-def"
    "modules/reference-resolution/reference-resolution-def"
    "modules/verbal-reasoner/verbal-reasoner-def"
    "modules/generator/generator-def"
    "modules/dm/context-manager-def"
    "modules/dm/discourse-manager-def"
    "modules/display-manager/display-parser-def"
    "id/tt-kernel/hack-def"
    )
  "Files defining DM packages")

(defvar *dm-files*
  '("cl-lib/trains-cl-lib"
    "id/toplevel"
    "modules/speechacts/sa-defs"
    "id/tt-simple-kr"
    "id/tt-kernel/kqml-library"
    "id/logging"
    "lymphocyte/pat-match"
    "lymphocyte/lym-defs"
    "lymphocyte/lym-language"
    "lymphocyte/lym-engine"
    "modules/kb-lib/kb-defs"
    "modules/kb-lib/kb-functions"
    "modules/kb-lib/kb-lib-hack-exports"
    "modules/world-kb/world-kb-defs"
    "modules/world-kb/world-kb"
    "modules/reference-resolution/user-model-kb"
    "modules/display-manager/display-kb-defs"
    "modules/display-manager/display-kb"
    "modules/generator/self-model-kb"
    "modules/reference-resolution/reference-resolution-defs"
    "modules/reference-resolution/path-parser"
    "modules/reference-resolution/ref-rules-support"
    "modules/reference-resolution/ref-rules"
    "modules/reference-resolution/reference-resolution"
    "modules/verbal-reasoner/verbal-reasoner-predefs"
    "modules/verbal-reasoner/verbal-reasoner-defs"
    "modules/verbal-reasoner/verbal-reasoner"
    "modules/verbal-reasoner/prince-ps-interface"
    "modules/verbal-reasoner/vr-lym-support"
    "modules/generator/generator-defs"
    "modules/generator/generator"
    "modules/generator/gen-lym-support"
    "modules/dm/context-manager"
    "modules/dm/discourse-manager"
    "modules/display-manager/display-parser"
    "id/tt-lispmodule"
    "id/tt-kernel/version"
    "id/tt-kernel/x-interface"
    "id/tt-kernel/scoring"
    "id/tt-kernel/world-dump"
    )
  "Files defining DM functions.")

(defvar *dm-lym-files*
  '("modules/verbal-reasoner/vr-lym"
    "modules/generator/gen-lym"
    )
  "Files defining DM lymphocyte rules.")

;;;
;;; Loading
;;;
(defun load-dm ()
  "Load the DM."
  ;; Load the parser files themselves
  (mapc #'load (append *dm-defs* *dm-files* *dm-lym-files*)))

;;;
;;; Compiling
;;;
(defun compile-dm ()
  "Compile the necessary DM .lisp files into .fasl files."
  (mapc #'load *dm-defs*)
  (mapc #'(lambda (filename)
	    (compile-file filename :verbose t :print nil)
	    (load filename)) *dm-files*)
  ;; dm-lym-files are not compiled
)

;;;
;;; When this file is loaded...
;;;
;; This is in the USER package so it can be used as a -e argument to lisp
(defvar user::dm-is-being-compiled nil
  "T if this file is being loaded for purposes of compiling.")

(unless user::dm-is-being-compiled
  (load-dm))
