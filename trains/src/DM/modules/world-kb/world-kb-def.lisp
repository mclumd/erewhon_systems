;; Time-stamp: <Mon Jan 13 17:14:18 EST 1997 ferguson>
(in-package :cl-user)

(defpackage :world-kb
  (:use common-lisp cl-lib :kqml :demo-kb-lib :simple-kr :logging)
    (:shadowing-import-from sa-defs #:between)
    (:shadowing-import-from kqml #:comment)
  (:export #:*max-search-depth* #:*number-of-engines* #:*congested-cities-max* #:*congested-tracks-max*
           #:*city-congestion-delay-alist* #:*track-congestion-delay-alist* #:*scenario-name*))
