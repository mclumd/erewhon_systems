;; Time-stamp: <Tue Jan 21 17:03:45 EST 1997 ferguson>
(in-package :cl-user)

(defpackage :demo-kb-lib 
  (:use common-lisp cl-lib :kqml :sa-defs :logging)
  (:shadowing-import-from kqml #:comment)
  (:shadowing-import-from sa-defs #:between)
  (:export 
   ;; generic classes 
   #:point #:point-x #:point-y
   #:make-point #:point-p #:basic-kb-object  #:basic-name #:basic-predicates #:basic-noise
   #:basic-kb-object-p #:basic-container #:basic-contents #:basic-for-reference-p #:basic-congested-p
   #:fixed-object #:fixed-object-p #:congestion-reason
   #:basic-container-p #:map-object #:mo-position #:mo-connections
   #:mo-contained-in #:map-object-p #:map-container #:map-container-p
   #:mobile-object #:mobile-at #:mobile-object-p #:mobile-container #:mobile-orientation
   #:mobile-container-p #:connected-object #:co-loc-1 #:co-loc-2 #:co-distance #:co-cost
   #:connected-object-p

   ;; preestablished predicates
   #:*from-pred*
   #:*other-pred*
   
   ;; scenerio objects 
   #:city #:city-p
   #:make-city #:track #:track-p #:make-track #:dtrack #:dtrack-p #:make-dtrack #:engine #:engine-p
   #:make-engine #:route #:color #:route-p #:make-route #:segment-list #:path
      
   ;; basic functions (in kb-functions)
   #:contained-in #:other-connection #:other-connection-city #:object-name #:city-congested-p #:track-congested-p
   #:pick-one #:pick-one-short #:common-connection #:find-matches #:force-list-c #:compare-cities
   #:satisfy-predicate-p #:ref-object-of-type #:perf-prop-p #:rperf-prop-p #:perf-be-p #:ref-object-of-types
   #:mentioned-predicate #:get-sslot #:get-sslotn #:do-ps-find #:identify #:ps-ask-if #:ps-ask-one #:ps-ask-all
   #:rcheck-prop-p
   
   #:set-quantifier-p 
   
   #:proc-ss-pred-for-ps

   ;; call relevant hack functions
   ))
