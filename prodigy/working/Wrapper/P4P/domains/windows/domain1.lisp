#|
-------------------------------------------------------------------------------
		 Tests for Goal Transformations in ACP domain
-------------------------------------------------------------------------------
|#

;;; The major difference between the goals2 domain and the goals domain is that
;;; goals2 does not contain the existential quantifier embedded within the
;;; forall clause of inference rules REMOVE-ALL-CROSSINGS-OVER and
;;; RESTRICT-ALL-CROSSINGS-OVER. 

;;; Added airport argument to literal airport-secure-at, otherwise given 2
;;; airports at the same location (e.g., Korea-south) the planner could repair
;;; one airport and secure another to satisfy the preconditions of operator
;;; deploy. [19nov97 cox]

(create-problem-space 'GOALS :current t)

;;;
;;; Set parameters for User Interface.
;;;
(setf *node-width* 90)
(setf *node-height* 50)
(setf *inter-x-margin* 55)
(setf *inter-y-margin* 45)
(setf *xmargin* 10)

(defparameter *deployment-operators* 
  '(DEPLOY DEPLOY-AIR-GROUP DEPLOY-TFS SEND SEND-POLICE-WITH-DOG SEND-DOG-WITH-POLICE)
  "These operators can be executed before planning is finished.")



(infinite-type AMOUNT #'numberp)

(ptype-of FORCE-MODULE :top-type)

(ptype-of GROUND-FORCE-MODULE FORCE-MODULE)
(ptype-of TROOPS GROUND-FORCE-MODULE)
(ptype-of INFANTRY TROOPS)

(ptype-of AIR-FORCE-MODULE FORCE-MODULE)
(ptype-of AIRCRAFT AIR-FORCE-MODULE)
(ptype-of TACTICAL-FIGHTER AIRCRAFT)
(ptype-of F15 TACTICAL-FIGHTER)

(ptype-of POLICE GROUND-FORCE-MODULE)

(ptype-of outcome :top-type)
(pinstance-of decisive-victory OUTCOME)
(pinstance-of marginal-victory OUTCOME)
(pinstance-of stalemate OUTCOME)
(pinstance-of marginal-defeat OUTCOME)
(pinstance-of decisive-defeat OUTCOME)

(ptype-of OBSTACLE :top-type)
(ptype-of WATER-BARRIER OBSTACLE)
(ptype-of RIVER WATER-BARRIER)

(ptype-of RIVER-CROSSING :top-type)
(ptype-of FORD RIVER-CROSSING)
(ptype-of BRIDGE RIVER-CROSSING)

(ptype-of LOCATION :top-type)
(ptype-of AIRPORT LOCATION)
;(ptype-of COUNTRY LOCATION) ;Used to be :top-type.
(ptype-of TOWN LOCATION) ;Used to be :top-type.




#|  ------------------------------  OPERATORS ------------------------------ |#

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Deploy an air-force group to some air base after it is secure.
;;;

;;; Added airport parameter so that we can visualize changes during initial
;;; conspiracy heuristic example during replanning under sensed new info.
;;; [22nov97 cox]
;;;
(OPERATOR DEPLOY
  (params <air-unit> <airport>)
  (preconds
   ((<air-unit> AIRCRAFT)
    (<infantry-unit> INFANTRY)
    (<airport> AIRPORT))
   (and
    (is-secure <airport> <infantry-unit>)
    (is-usable <airport>))
   )
  (effects
   ()
  ((add  (is-deployed <air-unit> <airport>))))
  )



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Send a ground unit to an air base in some country if the unit is ready and
;;; the base is usable.
;;;




(OPERATOR SEND
  (params <ground-unit> <loc>)
  (preconds
   (
    (<loc> LOCATION)
;    (<smuggling-threat> WEAPONS-SMUGGLING)
    (<ground-unit> GROUND-FORCE-MODULE )

    )
   (is-ready <ground-unit>)
    )
  (effects
   ()
   ((add (is-deployed <ground-unit> <loc>))))
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Deploy a group of air units.
;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; An air base is secure if two troop forces are deployed there to guard
;;; against external threats and if one police force is deployed there to 
;;; guard against threats inside the base (e.g., saboteurs on the flight 
;;; line). 
;;;
;;; Would like to have a conditional precondition such that if 
;;; weapons-smuggling threat exists then (is-suppressed weapons-smuggling) 
;;; goal generated.
;;;
(OPERATOR SECURE
  (params <airport>
	  <external-security-force>)
  (preconds
   ((<airport> AIRPORT)
    (<internal-security-force> POLICE)
    (<external-security-force> (and INFANTRY 
				    (diff <internal-security-force>
					  <external-security-force>)
				    ))
    )
   (and (is-deployed  <internal-security-force> <airport>)
	(is-deployed  <external-security-force> <airport>))
   )
  (effects
   ()
   ((add (is-secure <airport> <external-security-force>))))
  )


;;;
;;; I could accomplish this by putting the s-threat in the preconds var list
;;; and removing the existential quantifier. Because the preconditions for the
;;; normal secure operator would always be true any time the preconditions here
;;; are true (the former are a proper subset of the latter), we would need a 
;;; control rule to choose the more specific operator (this one) before the more
;;; general one (normal operator secure). NOTE that this represents a 
;;; representational trade-off between operator knowledge and control knowledge.
;;; See special-secure2 operator below.
;;;
;;; Also, Hammond anticipation of goal interactions because of past failure 
;;; cases is like the learning of anticipating the need to detect weapons 
;;; smuggling because of past experience with smugglers, thus contingency
;;; planning. Finally, the discussion with Mei about the implied goal of 
;;; needing blockc on the table during Sussman's Anomaly is related to the 
;;; implied goal of suppressing the smuggling threat here.
;;;


(OPERATOR BLOW
  (params <crossing> <air-force>)
  (preconds
   ((<air-force> F15 ) ;really should be tactical fighter w/special mission like damage operator
    (<local-air-base> AIRPORT)
    (<loc> LOCATION)
    (<river> WATER-BARRIER) 
    (<crossing> (or BRIDGE FORD)))
   (and
    (enables-movement-over <crossing> <river>)
    (near <local-air-base> <river>)
;    (loc-at <local-air-base> <loc>)
    (is-deployed <air-force> <local-air-base>)
    (is-ready <air-force>)
    ))
  (effects
   (
    )
   ((add (is-destroyed <air-force> <crossing>))
    (del (is-ready <air-force>))
    ;(if (occupies <enemy> <crossing>)
;	((add (is-destroyed-by <air-force> <crossing>))
;	 (del (occupies <enemy> <crossing>))))
    ))
   )

(OPERATOR DAMAGE
  (params <crossing> <air-force>)
  (preconds
   ((<air-force> TACTICAL-FIGHTER )
    (<local-air-base> AIRPORT)
    (<loc> LOCATION)
    (<river> WATER-BARRIER) 
    (<crossing> (or BRIDGE FORD)))
   (and
;    (mission-of <air-force> air-interdiction) ;Really should be ground interdiction.
    (enables-movement-over <crossing> <river>)
    (near <local-air-base> <river>)
;    (loc-at <local-air-base> <loc>)
    (is-deployed <air-force> <local-air-base>)
;    (is-ready <air-force>)
    ))
  (effects
   (
    )
   ((add (is-damaged  <air-force> <crossing>))
    ;(if (occupies <enemy> <crossing>)
;	((add (is-destroyed-by <air-force> <crossing>))
;	 (del (occupies <enemy> <crossing>))))
    ))
   )




#|  -------------------  GOAL-SUBSTITUTION TRANSMUTATIONS ------------------- |#


;;;
;;; Given a goal of making some ForceModule deployed, substitute the goal
;;; is-deployed. That is, if the system achieves (is-deployed <unit> <loc>),
;;; then infer (deployed <unit> <loc>). I think this should be a translation
;;; transformation rather than sunbstitution. 
;;;
(INFERENCE-RULE DEPLOY-SYNONYM
  (mode lazy)
  (params <unit> <loc>)
  (preconds
   ((<unit> FORCE-MODULE)
    (<loc> LOCATION))
   (is-deployed <unit> <loc>))
  (effects
   ()
   ((add  (deployed <unit> <loc>))))
  )

#|  ----------------  GOAL-OPERATIONALIZATION TRANSMUTATIONS ---------------- |#

;;; Want to lower expectations here by going from impassable to
;;; restricts-movement goal when not enough air power to destroy all crossings.
;;;
(INFERENCE-RULE REMOVE-ALL-CROSSINGS-OVER
  (mode lazy)
  (params <river>)
  (preconds
   ((<river> WATER-BARRIER) 
    (<air-force> TACTICAL-FIGHTER)    
;    (<local-air-base> AIRPORT)
;    (<loc> LOCATION)
    )
   (and
;    (near <local-air-base> <river>)
    (forall ((<crossing> (AND RIVER-CROSSING
			     (gen-from-pred 
			      (enables-movement-over <crossing> <river>)))))
	    (is-destroyed <air-force> <crossing>))
    ))
  (effects
   ()
   ((add  (outcome-impassable <river>))))
  )


(INFERENCE-RULE RESTRICT-ALL-CROSSINGS-OVER
  (mode lazy)
  (params <river>)
  (preconds
   ((<river> WATER-BARRIER) 
    (<air-force> TACTICAL-FIGHTER)
;    (<local-air-base> AIRPORT)
;    (<loc> LOCATION)
    )
   (and
;    (near <local-air-base> <river>)
    (forall ((<crossing> (AND RIVER-CROSSING
			     (gen-from-pred 
			      (enables-movement-over <crossing> <river>)))))
	    (is-damaged <air-force> <crossing>))
	    ))
  (effects
   ()
   ((add  (outcome-restricts-movement <river>))))
  )

;;; Need so that when tryinmg to restrict all crossings over a river, as many
;;; as possible will be blown before resorting to damaging.
;;;
(INFERENCE-RULE IF-DESTROYED-THEN-DAMAGED-TOO
  (mode lazy)
  (params <crossing>)
  (preconds
   ((<crossing> RIVER-CROSSING)
    (<air-force> TACTICAL-FIGHTER)
    )
   (is-destroyed <air-force> <crossing>))
  (effects
   ()
   ((add  (is-damaged <air-force> <crossing>))))
  )



#|  -------------------------  CONTROL RULES ------------------------------- |#

;;; This rule saves exponential backtracking when more crossings need to be
;;; blown than the number of F-15s ready to do the job.
;;;
(CONTROL-RULE REJECT-WHEN-NO-MORE-READY
  (if (and
        (current-goal (is-destroyed <air-force> <crossing>))
	(type-of-object-gen <crossing> RIVER-CROSSING)
	(false-in-state-forall-values (is-ready <air-force>) (<air-force> F15))))
  (then reject operator BLOW))







(if *analogical-replay*
    (load (concatenate 'string *analogy-pathname* "replay-crs")))
  
