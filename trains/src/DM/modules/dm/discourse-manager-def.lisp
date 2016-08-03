;; Time-stamp: <Mon Jan 13 18:15:03 EST 1997 ferguson>
(in-package :cl-user)

(defpackage :discourse-manager
  ;;(:nicknames :dm)
  (:use common-lisp cl-lib :kqml :demo-kb-lib :logging :lymphocyte)
  (:shadowing-import-from sa-defs #:between)
  (:shadowing-import-from kqml #:comment))
