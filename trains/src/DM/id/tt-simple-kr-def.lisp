;; Time-stamp: <Mon Jan 13 16:39:55 EST 1997 ferguson>
(in-package :cl-user)

(defpackage :simple-kr
  (:use common-lisp cl-lib :kqml :logging)
  (:shadowing-import-from kqml #:comment)
  (:export #:*captured-initializations*
           #:simple-add #:simple-addl #:simple-replace
           #:simple-subtract #:simple-find #:simple-rfind #:simple-clear
           #:simple-push #:simple-pop #:simple-stack))
