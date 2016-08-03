;; Time-stamp: <Mon Jan 13 17:30:46 EST 1997 ferguson>
(in-package :cl-user)

(defpackage :hack
  (:use common-lisp cl-lib :kqml :demo-kb-lib :logging :lymphocyte)
  (:shadowing-import-from sa-defs #:between)
  (:shadowing-import-from kqml #:comment)
  (:export #:do-toplevel #:handle-kqml #:handle-speech-kqml #:*version-string* #:*version-number*
           #:other-config-message #:parse-config-message #:*im-stream* #:*use-truetalk* 
            #:*used-speech* #:config-done #:handle-input #:setup-im-interface #:kill-im
            #:check-module-running #:wait-for-module-ready #:send-to-im #:send-to-log #:send-to-display #:send-to-dm
            #:handle-im-input #:im-rendezvous #:handle-kqml #:send-kqml-to-im #:send-kqml-to-display
            #:mail-log-file))
