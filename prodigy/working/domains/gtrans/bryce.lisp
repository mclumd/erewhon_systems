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



(ptype-of outcome :top-type)

(ptype-of GROUP-UNIT :top-type)
(ptype-of TFS GROUP-UNIT)

(ptype-of FORCE-MODULE :top-type)


(ptype-of AIR-FORCE-MODULE FORCE-MODULE)
(ptype-of AIRCRAFT AIR-FORCE-MODULE)
(ptype-of TACTICAL-FIGHTER AIRCRAFT)
(ptype-of F15 TACTICAL-FIGHTER)


(ptype-of GROUND-FORCE-MODULE FORCE-MODULE)
(ptype-of DEFENSIVE-FORCE-MODULE GROUND-FORCE-MODULE)
(ptype-of ANTI-AIR-FORCE-MODULE DEFENSIVE-FORCE-MODULE)
(ptype-of HAWK-BATTALION ANTI-AIR-FORCE-MODULE)

(ptype-of POLICE-FORCE-MODULE GROUND-FORCE-MODULE)
(ptype-of MILITARY-POLICE POLICE-FORCE-MODULE)
(ptype-of SECURITY-POLICE POLICE-FORCE-MODULE)
(ptype-of ATTACHMENT GROUND-FORCE-MODULE)
(ptype-of DOG-TEAM ATTACHMENT)


(ptype-of TROOPS GROUND-FORCE-MODULE)
(ptype-of INFANTRY TROOPS)
(ptype-of INFANTRY-BATTALION INFANTRY)


(ptype-of OBSTACLE :top-type)
(ptype-of WATER-BARRIER OBSTACLE)
(ptype-of RIVER WATER-BARRIER)
(ptype-of RIVER-CROSSING :top-type)
(ptype-of FORD RIVER-CROSSING)
(ptype-of BRIDGE RIVER-CROSSING)

(ptype-of LOCATION :top-type)
(ptype-of AIRPORT LOCATION)
(ptype-of CITY LOCATION) ;Used to be :top-type.




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
  (params <air-unit> <loc> <airport>)
  (preconds
   ((<air-unit> AIRCRAFT)
    (<loc> LOCATION) ;Was of type airport. Currently, usually a country.
;    (<larger-unit> GROUP-UNIT)
    (<airport> AIRPORT))
   (and
;    (~(part-of <air-unit> <larger-unit>))
    (loc-at <airport> <loc>)
    (airport-secure-at <loc> <airport>)
    (is-usable <airport>))
   )
  (effects
   ()
  ((add  (is-deployed <air-unit> <loc>))))
  )


;;; Third attempt with Eugene's suggestion to use universal quantification.

#|
(OPERATOR DEPLOY-AIR-GROUP
  (params <loc> <larger-unit>)
  (preconds
   (
    (<loc> LOCATION) 
    (<larger-unit> TFS) ;TFS isa GROUP-UNIT
    )
    (forall ((<component> (and AIRCRAFT 
			       (gen-from-pred 
				(part-of <component> <larger-unit>)))))
	    (is-deployed <component> <loc>))
   )
  (effects
   (
    )
  ((add  (is-deployed <larger-unit> <loc>))
  )
  ))



;;;
;;; Deploy tactical fighter squadron.
;;;
(OPERATOR DEPLOY-TFS
  (params <loc> <unit-size> <unit-type>)
  (preconds
   (
    (<loc> LOCATION)
    (<unit-size> AMOUNT)
    (<unit-type> AIRCRAFT)
    (<group-unit> TFS) 
    )
   (and 
    (size <group-unit> <unit-size>)              ;Only to bind variables.
    (group-type <group-unit> <unit-type>) ;Only to bind variables.
    ;; Wanted to say clause below instead.
;    (forall ((<component> (and AIRCRAFT 
;			       (gen-from-pred 
;				(part-of <component> <group-unit>)))))
;	    (isa-p <unit-type> <component>))
    (is-deployed <group-unit> <loc>)
    )
   )
  (effects
   ()
   ((add (group-deployed <loc> <unit-type> <unit-size>)))
   ))


|#


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
    (<smuggling-threat> WEAPONS-SMUGGLING)
    (<ground-unit> (and GROUND-FORCE-MODULE 
			(gen-from-pred 
			 '(is-ready <ground-unit>))))
    )
;   (and
    (~(threat-at <smuggling-threat> <loc>))
;    )
    )
  (effects
   ()
   ((add (is-deployed <ground-unit> <loc>))))
  )

#|
;;;
;;; The more specific operator to send police. This operator applies, however, 
;;; only if a smuggling threat exists at the location to which the police are 
;;; being sent; otherwise, the ordinary send operator is used (even for police)
;;;
(OPERATOR SEND-POLICE-WITH-DOG
  (params <security-unit> <loc>)
  (preconds
   (
    (<loc> LOCATION)
    (<security-unit> (and POLICE-FORCE-MODULE
			  (gen-from-pred
			   '(is-ready <security-unit>))))
    (<smuggling-threat> WEAPONS-SMUGGLING)
    (<dog-unit> DOG-TEAM)
    )
   (and
    (threat-at <smuggling-threat> <loc>)
    (is-deployed <dog-unit> <loc>))
   )
  (effects
   ()
   ((add (is-deployed <security-unit> <loc>))))
  )


;;; Added because if the goal is to secure and airport and smuggling threats
;;; exists in the area, no unit but dog and police units can be sent to the
;;; airport. Neither hawks nor brigades can go. [24nov97 cox]
;;;
(OPERATOR SEND-UNIT-WITH-DOG
  (params <unit> <loc>)
  (preconds
   (
    (<loc> LOCATION)
    (<unit> (and GROUND-FORCE-MODULE ;was POLICE-FORCE-MODULE
			  (gen-from-pred
			   '(is-ready <unit>))))
    (<smuggling-threat> WEAPONS-SMUGGLING)
    (<dog-unit> DOG-TEAM)
    )
   (and
    (threat-at <smuggling-threat> <loc>)
    (is-deployed <dog-unit> <loc>))
   )
  (effects
   ()
   ((add (is-deployed <unit> <loc>))))
  )



;;;
;;; The following opertor does not have the precondition that the dog must be
;;; deployed before the police can go. Instead, if the threat exists, then they
;;; both go as an effect of the operator.
;;; 
(OPERATOR SEND-DOG-WITH-POLICE
  (params <security-unit> <loc>)
  (preconds
   ((<loc> LOCATION)
    (<security-unit> (and POLICE-FORCE-MODULE
			  (gen-from-pred 
			   '(is-ready <security-unit>))))
    (<smuggling-threat> WEAPONS-SMUGGLING)
    (<dog-unit> (and DOG-TEAM
		     (gen-from-pred
		      '(is-ready <dog-unit>))))
    )
;   (and
    (threat-at <smuggling-threat> <loc>)
;    )
   )
  (effects
   ()
   ((add (is-deployed <security-unit> <loc>))
    (add (is-deployed <dog-unit> <loc>))))
  )
|#
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Deploy a group of air units.
;;;

#|
(OPERATOR DEPLOY-GROUP
  (params <group> <loc>)
  (preconds
   ((<group> FORCE-MODULE) ;Does not work because not group-unit
    (<unit1> AIR-FORCE-MODULE)
    (<unit2> (and AIR-FORCE-MODULE (diff <unit1> <unit2>)))
    (<unit3> (and AIR-FORCE-MODULE 
		  (diff <unit2> <unit3>)
		  (diff <unit1> <unit3>)))
    (<loc> LOCATION)
    )
   (and
    (is-deployed <unit1> <loc>)
    (is-deployed <unit2> <loc>)
    (is-deployed <unit3> <loc>)
   ))
  (effects
   ()
  ((add  (is-deployed <group> <loc>))))
  )
|#


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
	  <loc>)
  (preconds
   ((<loc> LOCATION) ;was of type airport
    (<airport> LOCATION)
    (<internal-security-force> POLICE-FORCE-MODULE)
    (<external-security-force1> (and ANTI-AIR-FORCE-MODULE
				     (diff <internal-security-force>
					   <external-security-force1>)))
    (<external-security-force2> (and TROOPS 
				    (diff <internal-security-force>
					  <external-security-force2>)
				    (diff <external-security-force1>
					  <external-security-force2>)))
    )
   (and (loc-at <airport> <loc>) ;Not state 4 subgoal, used to bind <country>
	(is-deployed  <internal-security-force> <loc>)
	(is-deployed  <external-security-force1> <loc>)
	(is-deployed  <external-security-force2> <loc>))
   )
  (effects
   ()
   ((add (airport-secure-at <loc> <airport>))))
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
#|
(OPERATOR SPECIAL-SECURE
  (params <airport>
	  <loc>)
  (preconds
   ((<loc> LOCATION)
    (<airport> LOCATION)
    (<internal-security-force> POLICE-FORCE-MODULE)
    (<external-security-force1> (and ANTI-AIR-FORCE-MODULE
				     (diff <internal-security-force>
					   <external-security-force1>)))
    (<external-security-force2> (and TROOPS 
				    (diff <internal-security-force>
					  <external-security-force2>)
				    (diff <external-security-force1>
					  <external-security-force2>)))
    )
   (and (loc-at <airport> <loc>)
	(is-deployed  <internal-security-force> <loc>)
	(is-deployed  <external-security-force1> <loc>)
	(is-deployed  <external-security-force2> <loc>)
	(if (exists ((<smuggling-threat> WEAPONS-SMUGGLING))
		    (threat-at <smuggling-threat> <loc>))
	    (is-suppressed <smuggling-threat>)
	  t))
   )
  (effects
   ()
   ((add (airport-secure-at <loc>))))
  )
|#

#|
(OPERATOR SPECIAL-SECURE2
  (params <airport>
	  <loc>)
  (preconds
   ((<loc> LOCATION)
    (<airport> LOCATION)
    (<smuggling-threat> WEAPONS-SMUGGLING)
    (<internal-security-force> POLICE-FORCE-MODULE)
    (<external-security-force1> (and ANTI-AIR-FORCE-MODULE
				     (diff <internal-security-force>
					   <external-security-force1>)))
    (<external-security-force2> (and TROOPS 
				    (diff <internal-security-force>
					  <external-security-force2>)
				    (diff <external-security-force1>
					  <external-security-force2>)))
    )
   (and (loc-at <airport> <loc>)
	
	(is-deployed  <internal-security-force> <loc>)
	(is-deployed  <external-security-force1> <loc>)
	(is-deployed  <external-security-force2> <loc>)
	(threat-at <smuggling-threat> <loc>)
	(is-suppressed <smuggling-threat>))
   )
  (effects
   ()
   ((add (airport-secure-at <loc>))))
  )
|#

#|
(OPERATOR SPECIAL-SECURE3
  (params <town-center>
	  <loc>)
  (preconds
   ((<loc> LOCATION)
    (<town-center> LOCATION)
    (<smuggling-threat> WEAPONS-SMUGGLING)
    (<internal-security-force1> POLICE-FORCE-MODULE)
    (<internal-security-force2> (and POLICE-FORCE-MODULE
				     (diff <internal-security-force1>
					   <internal-security-force2>)))
    (<external-security-force> (and TROOPS 
				    (diff <internal-security-force1>
					  <external-security-force>)
				    (diff <internal-security-force2>
					  <external-security-force>)))
    )
   (and (loc-at <town-center> <loc>)
	(is-deployed  <internal-security-force1> <loc>)
	(is-deployed  <internal-security-force2> <loc>)
	(is-deployed  <external-security-force> <loc>)
	)
   )
  (effects
   ()
   ((add (town-center-secure-at <loc>))))
  )



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Deploy an air unit to support an air interdiction mission. 
;;;
(OPERATOR SUPPORT
  (params <mission> <air-unit> <loc>)
  (preconds 
   ((<air-unit> AIR-FORCE-MODULE)
    (<mission> MISSION-NAME)
    (<loc> LOCATION)
    )
   (and (is-deployed <air-unit> <loc>)
	(mission-of <air-unit> <mission>))
   )
  (effects
   ()
   ((add (is-interdicted <loc>)))) ;Is this the right goal state?
  )


;;;
;;; Really want one support operator that has conditional effects depending on 
;;; whether air-unit or ground-unit involved?
;;;
(OPERATOR SUPPORT2
  (params <mission> <ground-unit> <loc>)
  (preconds 
   ((<ground-unit> GROUND-FORCE-MODULE)
    (<mission> MISSION-NAME)
    (<loc> LOCATION)
    )
   (and (is-deployed <ground-unit> <loc>)
	(mission-of <ground-unit> <mission>))
   )
  (effects
   ()
   ((add (is-combat-supported <loc>)))) ;Also, is this the right goal state?
  )


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Suppress enemy threat using ground forces.
;;;
;;; Now to suppress general terrorism, we may want to have a more abstract
;;; operator like this. To suppress a more concrete threat such as weapons 
;;; smuggling (which may be a specific instance of terrorism?), may have a 
;;; more refined operator that "isa suppress operator." This concrete operator 
;;; would have things like precondition for detecting hidden weapons, thus 
;;; requiring the deployment of dog-teams. This possibly related to the 
;;; abstraction hierarchies in PRODIGY. But, how many of these details are
;;; necessary for the Mitre TIE?
;;;
(OPERATOR SUPPRESS
  (params <object-suppressed>
	  <loc>)
  (preconds 
   (
    (<loc> LOCATION)
    (<external-security-force1> INFANTRY)
    (<external-security-force2> (and SPECIAL-FORCE-MODULE
				     (diff <external-security-force1>
					   <external-security-force2>)))
    (<internal-security-force> (and POLICE-FORCE-MODULE 
				    (diff <external-security-force1>
					  <internal-security-force>)
				    (diff <external-security-force2>
					  <internal-security-force>)))
    )
   (and 
	(is-deployed  <external-security-force1> <loc>)
	(is-deployed  <external-security-force2> <loc>)
	(is-deployed  <internal-security-force> <loc>)
;	(threat-at <object-suppressed> <loc>)
	))
  (effects
   (
    (<object-suppressed> (and TERRORISM 
			      (gen-from-pred 
			       (threat-at <object-suppressed> korea-south))))
    )
   ((add (is-suppressed <object-suppressed> <loc>))))
  )

|#

#|
(OPERATOR SUPPRESS-SMUGGLING
  (params <object-suppressed>
	  <loc>)
  (preconds 
   ((<object-suppressed> WEAPONS-SMUGGLING)
    (<loc> LOCATION)
    (<attached-force> DOG-TEAM)
    (<internal-security-force> (and POLICE-FORCE-MODULE 
				    (diff <attached-force>
					  <internal-security-force>)))
    )
   (and (threat-at <object-suppressed> <loc>)
	(is-deployed  <attached-force> <loc>)
	(is-deployed  <internal-security-force> <loc>))
   )
  (effects
   ()
   ((add (is-suppressed <object-suppressed>))))
  )

|#

#|
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Should really have generalized secure operator test to see if object to be 
;;; secured is held by the enemy. If so, different than if not (as with 
;;; securing airport.
;;;
(OPERATOR SECURE-STRONGHOLD
  (params <infantry-force> <stronghold>)
  (preconds
   (
    (<loc> LOCATION)
    (<stronghold> BUILDING)
    (<infantry-force> INFANTRY)
    (<security-force> POLICE-FORCE-MODULE)
    )
   (and 
    (loc-at <stronghold> <loc>)
    (~ (is-enemy <infantry-force>))
;    (forall ((<enemy-force> (and FORCE-MODULE
;				 (gen-from-pred (is-enemy <enemy-force>)))))
;	    (~(is-deployed <enemy-force> <stronghold>)))
    (~ (exists ((<enemy-force> (and FORCE-MODULE
				 (gen-from-pred (is-enemy <enemy-force>)))))
	    (is-deployed <enemy-force> <stronghold>)))
    (is-deployed  <infantry-force> <loc>)
    (is-deployed  <security-force> <loc>)
    ))
  (effects
   ()
   ((add (is-secure <stronghold>))))
   )


;;;
;;; Operator Capture-Stronghold is a sibling of operator Secure-Stronghold. 
;;; This one is used when enemy are deployed in the stronghold.
;;;
(OPERATOR NEUTRALIZE-STRONGHOLD
  (params <infantry-force> <enemy-force> <stronghold>)
  (preconds
   ((<stronghold> BUILDING)
    (<infantry-force> INFANTRY)
    (<enemy-force> INFANTRY)
    (<loc> LOCATION)
    )
   (and (loc-at <stronghold> <loc>)
	(is-deployed <enemy-force> <stronghold>)
	(made-ineffective-by <enemy-force> <infantry-force>)
	(is-deployed  <infantry-force> <loc>)
	))
  (effects
   ()
   ((add (is-secure <stronghold>))))
   )

|#

;(OPERATOR NEUTRALIZE
;  (params <infantry-force> <enemy-force> <stronghold>)
;  (preconds
;   ((<stronghold> BUILDING)
;    (<infantry-force> INFANTRY)
;    (<enemy-force> INFANTRY)
;    (<airport> LOCATION)
;    (<loc> LOCATION)
;    )
;   (and (loc-at <stronghold> <loc>)
;	(is-deployed <enemy-force> <stronghold>)
;	(is-enemy <enemy-force>)
;	(near <airport> <stronghold>)
;	(loc-at <airport> <loc>)
;	(is-deployed  <infantry-force> <loc>)
;	))
;  (effects
;   ()
;   ((add (made-ineffective-by <enemy-force> <infantry-force>))))
;   )

#|
;;;
;;; Operator Attack is a specialized version of operator Neutralize.
;;;
(OPERATOR ATTACK
  (params <infantry-force> <enemy-force> <stronghold>)
  (preconds
   (
    (<enemy-force> (and INFANTRY 
			(gen-from-pred 
			 '(is-enemy <enemy-force>)) ))
    (<stronghold> BUILDING)
    (<infantry-force> INFANTRY)
    (<airport> LOCATION)
    (<loc> LOCATION)
    )
   (and (~ (impossible-precondition))
	(is-ready <infantry-force>) ;; Needs to be here since the predicate is NOT static.
	(loc-at <stronghold> <loc>)
	(is-deployed <enemy-force> <stronghold>)
;	(near <airport> <stronghold>)
 	(is-deployed  <infantry-force> <loc>)
	))
  (effects
   ()
   ((add (is-destroyed-by <enemy-force> <infantry-force>))
    (del (is-ready <infantry-force>))))
   )
|#


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
    (loc-at <local-air-base> <loc>)
    (is-deployed <air-force> <loc>)
    (is-ready <air-force>)
    ))
  (effects
   (
;    (<enemy> INFANTRY)
    )
   ((add (is-destroyed <crossing>))
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
    (mission-of <air-force> air-interdiction) ;Really should be ground interdiction.
    (enables-movement-over <crossing> <river>)
    (near <local-air-base> <river>)
    (loc-at <local-air-base> <loc>)
    (is-deployed <air-force> <loc>)
;    (is-ready <air-force>)
    ))
  (effects
   (
;    (<enemy> INFANTRY)
    )
   ((add (is-damaged <crossing>))
    ;(if (occupies <enemy> <crossing>)
;	((add (is-destroyed-by <air-force> <crossing>))
;	 (del (occupies <enemy> <crossing>))))
    ))
   )

#|
;;;
;;; Operator Cutoff is a specialized version of operator Neutralize.
;;;
(OPERATOR CUTOFF
  (params <infantry-force> <enemy-force> <stronghold>)
  (preconds
   (
    (<enemy-force> (and INFANTRY 
			(gen-from-pred 
			 '(is-enemy <enemy-force>)) ))
    (<stronghold> BUILDING)
    (<infantry-force> (and INFANTRY 
			   (gen-from-pred 
			    '(is-ready <infantry-force>))))
    (<airport> LOCATION)
    (<loc> LOCATION)
    )
   (and (loc-at <stronghold> <loc>)
	(is-deployed <enemy-force> <stronghold>)
;	(near <airport> <stronghold>)
	(loc-at <stronghold> <loc>)
	(is-deployed  <infantry-force> <loc>)
	))
  (effects
   ()
   ((add (is-isolated-by <enemy-force> <infantry-force>))
;    (del (is-ready <infantry-force>))
    ))
  )

|#



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

;;; Might want friendly-force to be existentially quantified so that one unit
;;; does not have to defeat all enemy forces by itself.
;;;
;;; Also, right now this is specific to enemy near the airport. I really want
;;; to specify that there exists some placed near the location that all enemy
;;; are near.
;;;
;(INFERENCE-RULE DEFEAT-ALL-ENEMY-AT
;  (mode lazy)
;  (params <loc>)
;  (preconds
;   (
;    (<loc> LOCATION))
;   (and
;;    (~ (is-enemy <friendly-force>))
;    (forall ((<enemy-force> (and FORCE-MODULE 
;				 (gen-from-pred (is-enemy <enemy-force>))
;;				(gen-from-pred (is-deployed <enemy-force> airport4))
;;				(gen-from-pred (near <loc> airport4))
;				 ))
;	     (<friendly-force> (and TROOPS (diff <enemy-force> <friendly-force>))))
;	    (made-ineffective-by <enemy-force> <friendly-force>))))
;  (effects
;   ()
;   ((add  (outcome-of-battle decisive-victory <loc>))))
;  )

;;; Old version
(INFERENCE-RULE DEFEAT-ALL-ENEMY
  (mode lazy)
  (params <friendly-force> <loc>)
  (preconds
   (
    (<friendly-force> TROOPS)
    (<loc> (or BUILDING LOCATION))
    )
   (and
    (~ (is-enemy <friendly-force>))
    (forall ((<enemy-force> (and FORCE-MODULE 
				 (diff <enemy-force> <friendly-force>)
				 (gen-from-pred (is-enemy <enemy-force>))
				 (gen-from-pred (is-deployed <enemy-force> <loc>))
				 )))
	   (made-ineffective-by <enemy-force> <friendly-force>))))
  (effects
   ()
   ((add  (outcome-of-battle decisive-victory <loc>))))
  )


(INFERENCE-RULE DEFEAT-SOME-ENEMY
  (mode lazy)
  (params <friendly-force> <loc>)
  (preconds
   (
    (<friendly-force> TROOPS)
    (<loc> (or BUILDING LOCATION))
    (<enemy-force> (and FORCE-MODULE 
				 (diff <enemy-force> <friendly-force>)
				 (gen-from-pred '(is-enemy <enemy-force>))
				 )))
   (and
    (~ (is-enemy <friendly-force>))
    (is-deployed <enemy-force> <loc>)
    (made-ineffective-by <enemy-force> <friendly-force>)))
  (effects
   ()
   ((add  (outcome-of-battle marginal-victory <loc>))))
  )



;;; Want to lower expectations here by going from impassable to
;;; restricts-movement goal when not enough air power to destroy all crossings.
;;;
(INFERENCE-RULE REMOVE-ALL-CROSSINGS-OVER
  (mode lazy)
  (params <river>)
  (preconds
   ((<river> WATER-BARRIER) 
;    (<local-air-base> AIRPORT)
;    (<loc> LOCATION)
    )
   (and
;    (near <local-air-base> <river>)
;    (loc-at <local-air-base> <loc>)
;    (airport-secure-at <loc>)
    (forall ((<crossing> (AND RIVER-CROSSING
			     (gen-from-pred 
			      (enables-movement-over <crossing> <river>)))))
	    (is-destroyed <crossing>))
    ))
  (effects
   ()
   ((add  (outcome impassable <river>))))
  )


(INFERENCE-RULE RESTRICT-ALL-CROSSINGS-OVER
  (mode lazy)
  (params <river>)
  (preconds
   ((<river> WATER-BARRIER) 
;    (<local-air-base> AIRPORT)
;    (<loc> LOCATION)
    )
   (and
;    (near <local-air-base> <river>)
;    (loc-at <local-air-base> <loc>)
;    (airport-secure-at <loc>)
    (forall ((<crossing> (AND RIVER-CROSSING
			     (gen-from-pred 
			      (enables-movement-over <crossing> <river>)))))
	    (is-damaged <crossing>))
	    ))
  (effects
   ()
   ((add  (outcome restricts-movement <river>))))
  )

;;; Need so that when tryinmg to restrict all crossings over a river, as many
;;; as possible will be blown before resorting to damaging.
;;;
(INFERENCE-RULE IF-DESTROYED-THEN-DAMAGED-TOO
  (mode lazy)
  (params <crossing>)
  (preconds
   ((<crossing> RIVER-CROSSING) 
    )
   (is-destroyed <crossing>))
  (effects
   ()
   ((add  (is-damaged <crossing>))))
  )


#|  --------------------  GOAL-EROSION TRANSMUTATIONS --------------------- |#

;;; Must be guaranteed that this rule is applied only when all plans to achieve
;;; decisive-vistory have been exhausted.
;;;
(INFERENCE-RULE LOWER-EXPECTATIONS-CONCERNING
  (mode lazy)
  (params <loc>)
  (preconds
   (
    (<loc> (or BUILDING LOCATION))
    )
   (and
    (outcome-of-battle marginal-victory <loc>)
    ))
  (effects
   ()
   ((add  (outcome-of-battle decisive-victory <loc>))))
  )


(INFERENCE-RULE LOWER-OUTCOME-EXPECTATIONS
  (mode lazy)
  (params <river>)
  (preconds
   (
    (<river> WATER-BARRIER)
    )
    (outcome restricts-movement <river>)
    )
  (effects
   ()
   ((add  (outcome impassable <river>))))
  )


;;; Dummy to test transformation.
;;;
;(OPERATOR DUMMY-OP
;  (params <loc>)
;  (preconds
;   (
;    (<loc> (or BUILDING LOCATION))
;    )
;   (and
;    (nothing)
;    ))
;  (effects
;   ()
;   ((add  (outcome-of-battle marginal-victory <loc>))))
;  )
;;; For test2.lisp
;(OPERATOR DUMMY-OP
;  (params <loc>)
;  (preconds
;   (
;    (<loc> (or BUILDING LOCATION))
;    )
;   (and
;    (exists ((<Y> INFANTRY))
;	    (is-ready <Y>))
;    (forall ((<X> AIRPORT))
;	    (IS-USABLE <X>))
;    ))
;  (effects
;   ()
;   ((add  (test  <loc>))))
;  )

#|
(OPERATOR REPAIR-AIRPORT
  (params <loc>)
  (preconds
   (
    (<loc> AIRPORT)
    )
    (nothing)
    )
  (effects
   ()
   ((add  (is-usable  <loc>))))
  )

|#


#|  -----------------  GOAL-SPECIALIZATION TRANSMUTATIONS ------------------ |#

;;;
;;; Without the <unit> value in the goal, PRODIGY will deploy two different 
;;; infantry units during the plan to capture the stronghold.
;;;
(INFERENCE-RULE SPECIALIZE-INNEFFECTIVE-2-DESTROY
  (mode lazy)
  (params <unit> <enemy-unit>)
  (preconds
   ((<unit> FORCE-MODULE)
    (<civilians> NONCOMBATANTS)
    (<enemy-unit> (and FORCE-MODULE (diff <unit> <enemy-unit>)))
    )
   (and
    (~ (near <civilians> <enemy-unit>))
    (is-destroyed-by <enemy-unit> <unit>)))
  (effects
   ()
   ((add  (made-ineffective-by <enemy-unit> <unit>))))
  )


(INFERENCE-RULE SPECIALIZE-INNEFFECTIVE-2-ISOLATE
  (mode lazy)
  (params <unit> <enemy-unit>)
  (preconds
   ((<unit> FORCE-MODULE)
    (<civilians> NONCOMBATANTS)
    (<enemy-unit> (and FORCE-MODULE (diff <unit> <enemy-unit>)))
    )
   (and
    (near <civilians> <enemy-unit>)
    (is-isolated-by <enemy-unit> <unit>)))
  (effects
   ()
   ((add  (made-ineffective-by <enemy-unit> <unit>))))
  )




#|

;;; The following 3 substitutions begin to address the notion of expanded goal 
;;; types (i.e., acheivement, prevention, and maintenance goals). PRODIGY is 
;;; built around acheivement goals without naming them as such. There is a 
;;; relation between achievement goals and both prevention and maintenance 
;;; goals. Prevention goals are achieved by negating all preconditions of all 
;;; operators that can achieve the object-state. That is to prevent S1, find 
;;; all operators that can achieve S1. Then make sure that none of these 
;;; operators can have their preconditions met by making the achievement of at 
;;; least one precondition impossible (or unlikely). For example, to deploy 
;;; enemy aircraft to a particular airport requires that the airport be usable 
;;; and secure. Bombing the airport before enemy troops get there to secure it 
;;; makes the usable precondition false. Now the enemy can still send engineers
;;; to repair the airport, but the deployment has been prevented in the 
;;; near-term. I know of no formalism that represents partial achievement in 
;;; this sense, however. What exactly does it mean for a state to be achieved 
;;; in a world where events or other agents can come along and undo a state 
;;; change performed by a planner. Some state changes a more persistent than 
;;; others and, as a result, more resistent to reversal.
;;;


;;;
;;; If <state> is true, then the goal (achieve <state>) is true.
;;;
(INFERENCE-RULE ACHIEVE-STATE
  (mode lazy)
  (params <state>)
  (preconds
   ((<state> :top-type))
   <state>)
  (effects
   ()
   ((add  (achieve <state>))))
  )


;;;
;;; Substitute the prevention of <state> for the maintainance of the negation 
;;; of <state>.
;;;
(INFERENCE-RULE MAINTAIN->PREVENT
  (mode lazy)
  (params <state>)
  (preconds
   ((<state> :top-type))
   (prevent <state>))
  (effects
   ()
   ((add  (maintain (~ <state>)))))
  )


;;;
;;; Substitute the maintenance of <state> for the prevention of the negation 
;;; of <state>.
;;;
(INFERENCE-RULE PREVENT->MAINTAIN
  (mode lazy)
  (params <state>)
  (preconds
   ((<state> :top-type))
   (maintain <state>))
  (effects
   ()
   ((add  (prevent (~ <state>)))))
  )

|#



#|  -------------------------  CONTROL RULES ------------------------------- |#

;;; This was added to control for operator choices when securing a base with
;;; smuggling threats. See comments on operator SEND-UNIT-WITH-DOG. [24nov97
;;; cox]
;;;
;;; I wanted to have the case where this was a prefer rule, but Prodigy
;;; apparently did not generate SEND-DOG-WITH-POLICE in the candidates. ??
;;;
(CONTROL-RULE SELECT-OP-WHEN-SENDING-POLICE
  (if (and (current-goal (is-deployed <police> <loc>))
	   (type-of-object-gen <police> POLICE-FORCE-MODULE)
	   (true-in-state (threat-at <threat> <loc>))
	   (type-of-object-gen <threat> WEAPONS-SMUGGLING)
	   ))
  (then select operator SEND-DOG-WITH-POLICE ; SEND-POLICE-WITH-DOG
	))


;;;
;;; Without control rule, secure-stronghold is rejected only after trying all
;;; possible bindings. Using this rule saves much useless search (e.g., 77
;;; search nodes, versus 20 with the rule. We reject the operator if any enemy
;;; is present at the stronghold. The secure-stronghold operator is meant for 
;;; securing safe areas.
;;; 
(CONTROL-RULE REJECT-IF-ENEMY-PRESENT 
  (if (and (current-goal (is-secure <stronghold>))
	   (true-in-state (is-deployed <enemy-force> <stronghold>))
	   (true-in-state (is-enemy <enemy-force>))))
  (then reject operator SECURE-STRONGHOLD))



(CONTROL-RULE REJECT-WHEN-IMPOSSIBLE
  (if (and (current-goal (is-destroyed-by <enemy-force> <infantry-force>))
	   (true-in-state (impossible-precondition))))
  (then reject operator ATTACK))



;;; This rule saves the expensive search through all possible plans for
;;; defeating all enemy when we know that none will work. The alternative will
;;; be to lower expectations. Which control rule should be implemented? This
;;; one or the commented out select rule below?
;;;
;(CONTROL-RULE REJECT-GLOBALLY-WHEN-IMPOSSIBLE2
;  (if (and 
;;       (current-goal (outcome impassable <river>))
;       (true-in-state (impossible-precondition2))))
;  (then reject operator REMOVE-ALL-CROSSINGS-OVER))


;;; This rule saves exponential backtracking when more crossings need to be
;;; blown than the number of F-15s ready to do the job.
;;;
(CONTROL-RULE REJECT-WHEN-NO-MORE-READY
  (if (and
        (current-goal (is-destroyed <crossing>))
	(type-of-object-gen <crossing> RIVER-CROSSING)
	(false-in-state-forall-values (is-ready <air-force>) (<air-force> F15))))
  (then reject operator BLOW))

#|
;;;
;;; For is-not-executable-p definition, see execute.lisp.
;;;
(CONTROL-RULE REJECT-NONEXECUTABLE-OP-FOR-APPLY
  (if (and (candidate-applicable-op <A>)
	   (is-not-executable-p <A>)
	   ))
  (then reject applied-op))


(CONTROL-RULE SUBGOAL-IF-ALL-APPLICABLE-OPS-NOT-EXECUTABLE
  (if (and (exists-pending-goals-p)
	   (all-applicable-ops-not-executable)))
  (then sub-goal))
|#


#|
;;Never got this one working exactly right so I removed the precondition of
;;air-unit beiong ready from operator damage. 
(CONTROL-RULE SUBGOAL-IF-BLOW-APPLICABLE
  (if (and (on-goal-stack (is-damaged <crossing1>))
	   (candidate-goal (is-destroyed <crossing2>))
	   (diff <crossing1> <crossing2>)
	   (applicable-operator (blow <AIR-FORCE> <LOCAL-AIR-BASE> <LOC> <RIVER> <crossing2>))))
  (then sub-goal))

(CONTROL-RULE SUBGOAL-IF-BLOW-APPLICABLE
  (if (and (on-goal-stack (is-damaged <crossing>))
	   (applicable-operator (blow <AIR-FORCE> <LOCAL-AIR-BASE> <LOC> <RIVER> <crossing> ))))
  (then sub-goal))

;;Was used to see what was actually apllicable.
(defun gen-appl ()
  (if (print (p4::generate-applicable-ops *current-node*))
      t)
)
|#

(CONTROL-RULE REJECT-GLOBALLY-WHEN-IMPOSSIBLE
  (if (and 
       (current-goal (outcome-of-battle decisive-victory <loc>))
       (true-in-state (impossible-precondition))))
  (then reject operator DEFEAT-ALL-ENEMY))


;(CONTROL-RULE SELECT-GLOBALLY-WHEN-IMPOSSIBLE
;  (if (and 
;       (current-goal (outcome-of-battle decisive-victory <loc>))
;       (true-in-state (impossible-precondition))))
;  (then select operator LOWER-EXPECTATIONS))


#|  -----------------  CONTROL RULES FOR ForMAT TIE----------------------- |#
;;; These rules have problems with negated preconditions.

#|
;;;
;;; Given two operators from which to choose, prefer the more specific one. An 
;;; operator is more specific than another if its primary results are more 
;;; specific than the primary results of the other. Finally, one resultunt 
;;; state is more specific than another if the two share the same predicate, 
;;; and all corresponding arguments are more specific via the domain's type
;;; hierarchy. For example (is-deployed division-ready-brigade saudi-arabia) is
;;; more specific than (is-deployed troops location); whereas, neither 
;;; (is-deployed troops saudi-arabia) nor (is-deployed division-ready-brigade 
;;; location) can be said to be more specific than the other.
;;;
(CONTROL-RULE Prefer-More-Specific-Op
  (if 
      (and (candidate-operator <OP1>)
	   (candidate-operator <OP2>)
	   (is-ancestor-op-of-p <OP1> <OP2>)))
  (then prefer operator <OP1> <OP2>)
  )



;;;
;;; Given a choice between two goals, prefer one if making the other true 
;;; solves one of the preconditions for an operator that results in the 
;;; preferred one (or is likewise further removed). That is, G2 is a subgoal of
;;; G2. Note that ordinarily subgoals are not present in a top-level goal 
;;; conjunction; however, humans often provide subgoal information in a mission
;;; statement. Therefore both goal and subgoal statements can be in the 
;;; top-most set of goals received from ForMAT. 
;;;
;;; This control-rule assures that the goal trees created during planning will 
;;; be maximaly deep and fewest in number. For example if we have two goals, 
;;; (is-secure airport4) and (exists ((<s-p> security-police))(is-deployed
;;; <s-p> Bosnia-and-Herzegovina), then PRODIGY should prefer the first to the 
;;; second. Solving for them in this order results in one goal tree, rather 
;;; than two. 
;;;
(CONTROL-RULE Prefer-Top-Most-Goal
  (if
      (and (candidate-goal <G1>)
	   (candidate-goal <G2>)
	   (solves-precondition-of-p <G1> <G2>)))
  (then prefer goal <G1> <G2>)
  )



;;;
;;; Given a current operator and candidate set of bindings, prefer those 
;;; bindings that opportunistically solve some other top-level goal. For 
;;; example, if the current operator is to secure an airport, then we want to 
;;; prefer bindings for <internal-security-force> that match a concurrent goal 
;;; to deploy some security-police to the same location.
;;;
;;; The control rule works as follows. Given the current operator <OP> and the 
;;; candidate bindings proposed by prodigy <CB>, find goals <G> that further 
;;; constrain the values of the bindings for the preconditions of <OP>, use 
;;; <G> to generate more constrained bindings <B>, then identify from <CB> and 
;;; <B> the corresponding lists <WB> and <BB> of worse and better bindings from
;;; which the control rule can distinguish preferences.
;;;
(control-rule Prefer-Bindings-Opportunistically
  (if (and
       (current-operator <OP>)
       (candidate-bindings <CB>)
       (match-constraining-goals <G> <OP>)
       (generate-new-bindings <B> <G> <OP>)
       (identify-worse-bindings <CB> <B> <WB> <OP>)
       (identify-better-bindings <CB> <B> <BB> <OP>)))
  (then prefer bindings <BB> <WB>))


|#
;----------------------------------------------------------------------------

(if *analogical-replay*
    (load (concatenate 'string *analogy-pathname* "replay-crs")))
  
