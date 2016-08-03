;;; C2 Tasks Taxonomy

(create-problem-space 'c2-tasks :current t)

;;(inference-rule enable-air-space-operations
(OPERATOR enable-air-space-operations
  (params)
  (preconds 
   ()
   (and (en1) (en2) (en3) (en4)))
  (effects 
   ()
   ((add (top-goal)))))

(OPERATOR combat-ops
  (params)
  (preconds 
   ()
   (and (g1) (g2) (g3)))
  (effects 
   ()
   ((add (en1)))))

(OPERATOR combat-service-ops
  (params)
  (preconds 
   ()
   (and (g1) (g2) (g3)))
  (effects 
   ()
   ((add (en2)))))

(OPERATOR combat-support-ops
  (params)
  (preconds 
   ()
   (and (g1) (g2) (g3)))
  (effects 
   ()
   ((add (en3)))))

(OPERATOR training-ops
  (params)
  (preconds 
   ()
   (and (g1) (g2) (g3)))
  (effects 
   ()
   ((add (en4)))))

#|
(operator link
  (params)
  (preconds 
   ()
   (and (g1) (g2) (g3)))
  (effects 
   ()
   ((add (g333)))))
|#

;;(inference-rule assess-situation
(OPERATOR assess-situation
  (params)
  (preconds 
   ()
   (and (a1) (a2) (a3) (a4)))
  (effects 
   () 
   ((add (g1)))))

;;(inference-rule observe-events-intents
(OPERATOR observe-events-intents
  (params)
  (preconds 
   ()
   (and (o1) (o2)))
  (effects 
   () 
   ((add (a1)))))

;;(inference-rule collect-universal-picture
(OPERATOR collect-universal-picture
  (params)
  (preconds 
   ()
   (and (c1) (c2) (c3)))
  (effects 
   () 
   ((add (o1)))))

(OPERATOR manage-sensors
  (params)
  (preconds 
   ()
   ;;(all-sensed))
   (nothing))
  (effects 
   () 
   ((add (c1)))))

(OPERATOR retrieve-data
  (params)
  (preconds 
   ()
   (nothing))
  (effects 
   () 
   ((add (c2)))))

(OPERATOR create-common-information
  (params)
  (preconds 
   ()
   (nothing))
  (effects 
   () 
   ((add (c3)))))

;;(inference-rule provide-common-presentation
(OPERATOR provide-common-presentation
  (params)
  (preconds 
   ()
   (p1))
  (effects 
   () 
   ((add (o2)))))

(OPERATOR fuse-all-source
  (params)
  (preconds 
   ()
   (nothing))
  (effects 
   () 
   ((add (p1)))))

;;(inference-rule assess-significance
(OPERATOR assess-significance
  (params)
  (preconds 
   ()
   (and (as1) (as2)))
  (effects 
   () 
   ((add (a2)))))

(OPERATOR visualize-forces
  (params)
  (preconds 
   ()
   (nothing))
  (effects 
   () 
   ((add (as1)))))

(OPERATOR analyze-options
  (params)
  (preconds 
   ()
   (nothing))
  (effects 
   () 
   ((add (as2)))))

(OPERATOR decide-to-act
  (params)
  (preconds 
   ()
   (nothing))
  (effects 
   () 
   ((add (a3)))))

;;(inference-rule communicate-intent
(OPERATOR communicate-intent
  (params)
  (preconds 
   ()
   (and (co1) (co2)))
  (effects 
   () 
   ((add (a4)))))

(OPERATOR connect-players
  (params)
  (preconds 
   ()
   (nothing))
  (effects 
   () 
   ((add (co1)))))

(OPERATOR deliver-required
  (params)
  (preconds 
   ()
   (nothing))
  (effects 
   () 
   ((add (co2)))))

(OPERATOR plan-operations
  (params)
  (preconds 
   ()
   (and (pl1) (pl2) (pl3) (pl4)))
  (effects 
   () 
   ((add (g2)))))

(OPERATOR choose-coa
  (params)
  (preconds 
   ()
   (and (ch1) (ch2) (ch3) (ch4)))
  (effects 
   () 
   ((add (pl1)))))

(OPERATOR allocate-resources
  (params)
  (preconds 
   ()
   (nothing))
  (effects 
   () 
   ((add (pl2)))))


(OPERATOR build-plan-and-schedule
  (params)
  (preconds 
   ()
   (nothing))
  (effects 
   () 
   ((add (pl3)))))

(OPERATOR communicate-plan
  (params)
  (preconds 
   ()
   (and (com1) (com2)))
  (effects 
   () 
   ((add (pl4)))))


(OPERATOR connect-players-for-plan
  (params)
  (preconds 
   ()
   (nothing))
  (effects 
   () 
   ((add (com1)))))


(OPERATOR deliver-required-for-plan
  (params)
  (preconds 
   ()
   (nothing))
  (effects 
   () 
   ((add (com2)))))


(OPERATOR determine-objectives
  (params)
  (preconds 
   ()
   (nothing))
  (effects 
   () 
   ((add (ch1)))))


(OPERATOR develop-modify-strategy
  (params)
  (preconds 
   ()
   (nothing))
  (effects 
   () 
   ((add (ch2)))))


(OPERATOR visualize-forces-for-coa
  (params)
  (preconds 
   ()
   (nothing))
  (effects 
   () 
   ((add (ch3)))))



(OPERATOR analyze-options-for-coa
  (params)
  (preconds 
   ()
   (nothing))
  (effects 
   () 
   ((add (ch4)))))


(OPERATOR execute-ops
  (params)
  (preconds 
   ()
   (and (ex1) (ex2) (ex3) (ex4)))
  (effects 
   () 
   ((add (g3)))))


(OPERATOR implement-ops
  (params)
  (preconds 
   ()
   (nothing))
  (effects 
   () 
   ((add (ex1)))))


(OPERATOR comm-coor-direction
  (params)
  (preconds 
   ()
   (and (cc1) (cc2)))
  (effects 
   () 
   ((add (ex2)))))


(OPERATOR report-results
  (params)
  (preconds 
   ()
   (and (rr1) (rr2)))
  (effects 
   () 
   ((add (ex3)))))


(OPERATOR connect-players-for-report
  (params)
  (preconds 
   ()
   (nothing))
  (effects 
   () 
   ((add (rr1)))))

(OPERATOR deliver-required-for-report
  (params)
  (preconds 
   ()
   (nothing))
  (effects 
   () 
   ((add (rr2)))))

(OPERATOR connect-players-for-direction
  (params)
  (preconds 
   ()
   (nothing))
  (effects 
   () 
   ((add (cc1)))))

(OPERATOR deliver-required-for-direction
  (params)
  (preconds 
   ()
   (nothing))
  (effects 
   () 
   ((add (cc2)))))

(OPERATOR adapt-ops
  (params)
  (preconds 
   ()
   (and (ao1) (ao2) (ao3) (ao4)))
  (effects 
   () 
   ((add (ex4)))))


(OPERATOR monitor-ops
  (params)
  (preconds 
   ()
   (nothing))
  (effects 
   () 
   ((add (ao1)))))


(OPERATOR plan-adj-ops
  (params)
  (preconds 
   ()
   (nothing))
  (effects 
   () 
   ((add (ao2)))))


(OPERATOR direct-adj-ops
  (params)
  (preconds 
   ()
   (nothing))
  (effects 
   () 
   ((add (ao3)))))
  

(OPERATOR report-results-ops
  (params)
  (preconds 
   ()
   (nothing))
  (effects 
   () 
   ((add (ao4)))))

#|
(ptype-of SATELLITE :top-type)
(ptype-of RECCE :top-type)

(OPERATOR sense-all-sensors
 (params)
 (preconds
  ((<sat> SATELLITE)
   (<recce> RECCE))
  (and (sensed <sat>)
       (sensed <recce>)))
 (effects
  ()
  ((add (all-sensed)))))
|#

(pset :linear t)
(pset :depth-bound 5000)
