;; Time-stamp: <Mon Jan 20 18:12:50 EST 1997 ferguson>
(in-package :cl-user)

(defpackage :logging
  (:use common-lisp cl-lib)
  (:export
   #:do-log #:do-log-direct #:transcribe #:transcribe-and-log #:open-transcript-stream #:open-log-stream #:close-logs
   #:do-log-timestamp #:do-log-direct-timestamp #:reset-timestamp
   #:debug-log #:debug-p #:do-log-all #:find-log-stream #:log-warning
   #:*transcript-stream* #:*transcript-file* #:*log-file* #:*log-stream* #:*log-streams*
   #:stamp-view-log-indicator #:open-log-stream-for-module))
