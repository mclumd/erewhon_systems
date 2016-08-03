;; Time-stamp: <Mon Jan 13 17:20:06 EST 1997 ferguson>
(in-package :cl-user)

(defpackage :reference-resolution
  (:nicknames :ref)
  (:use common-lisp cl-lib :kqml :demo-kb-lib :logging :lymphocyte) ; get common symbols
  (:shadowing-import-from sa-defs #:between)
  (:shadowing-import-from kqml #:comment))
