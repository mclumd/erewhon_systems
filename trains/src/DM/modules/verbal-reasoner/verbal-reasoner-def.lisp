;; Time-stamp: <Mon Jan 13 17:21:45 EST 1997 ferguson>
(in-package :cl-user)

(defpackage :verbal-reasoner
  (:nicknames :prince)
  (:use common-lisp cl-lib :kqml :demo-kb-lib :logging :lymphocyte) ; get common symbols
  (:shadowing-import-from sa-defs #:between)
  (:shadowing-import-from kqml #:comment))
