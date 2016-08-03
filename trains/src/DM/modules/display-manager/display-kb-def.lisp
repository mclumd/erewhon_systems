;; Time-stamp: <Mon Jan 13 17:18:43 EST 1997 ferguson>
(in-package :cl-user)

(defpackage :display-kb
  (:use common-lisp cl-lib :kqml :demo-kb-lib :logging :simple-kr)
  (:shadowing-import-from sa-defs #:between)
  (:shadowing-import-from kqml #:comment))
