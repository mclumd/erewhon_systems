;; Time-stamp: <Mon Jan 13 17:25:22 EST 1997 ferguson>
(in-package :cl-user)

(defpackage :context-manager
  (:use common-lisp cl-lib :kqml :demo-kb-lib :logging :lymphocyte :simple-kr)
  (:shadowing-import-from sa-defs #:between)
  (:shadowing-import-from kqml #:comment))
