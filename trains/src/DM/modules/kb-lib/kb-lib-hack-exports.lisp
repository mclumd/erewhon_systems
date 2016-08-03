;; Time-stamp: <Mon Jan 13 18:54:24 EST 1997 ferguson>
(in-package :cl-user)

;;; This was in defsystem.lisp just after demo-kb-lib was defined.
;;; I have no fucking idea...

(let (exports)
  (do-external-symbols (sym :sa-defs) (push sym exports))
  (export exports :demo-kb-lib))





