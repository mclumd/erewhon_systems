;;;;;;;;;;;;;;;;;;;;
(create-problem-space 'jade :current t)
;(pset :depth-bound 1000)

(infinite-type AMOUNT #'numberp)
(ptype-of QUALITATIVE_VALUE :top-type)
(ptype-of GROUP-UNIT :top-type)
(ptype-of GROUP-SET :top-type)
(ptype-of TFS GROUP-UNIT)

(ptype-of BATTLE-GROUP GROUP-UNIT)
(ptype-of POPULATION GROUP-UNIT)

(ptype-of institution :top-type)
(ptype-of government institution)
(ptype-of day :top-type)

(ptype-of object :top-type)
(ptype-of inanimate-object object)
(ptype-of animate-object object)
(ptype-of PERSON animate-object)


;;; So much inefficiency results from having to make sure that bindings for
;;; variables that are part of subgoals are not "is-enemy that I am finally
;;; creating a special type for them instead of having them a brigade with
;;; special predicate and special preconditions and special control rules,
;;; [cox 27may98]
;;;
(ptype-of enemy-ground-unit :top-type)

(ptype-of FORCE-MODULE :top-type)
(ptype-of MISSION-NAME :top-type)
(ptype-of THREAT :top-type)
(ptype-of TERRORISM THREAT)
(ptype-of WEAPONS-SMUGGLING THREAT)
(ptype-of BUILDING :top-type)
(ptype-of AIR-FORCE-MODULE FORCE-MODULE) ;FORCE-MODULE -> FORCE-ELEMENT
(ptype-of AIRCRAFT AIR-FORCE-MODULE)

(ptype-of HELICOPTER AIRCRAFT)
(ptype-of BLACKHAWK HELICOPTER)

(ptype-of FIGHTER-AIRCRAFT AIRCRAFT)
(ptype-of air-wing FIGHTER-AIRCRAFT)

(ptype-of NONCOMBATANTS :top-type)

(ptype-of NAVY :top-type)
(ptype-of fleet-group :top-type)
(ptype-of fleet :top-type)

(ptype-of ship :top-type)
(ptype-of carrier-air-wing air-wing)
(ptype-of fighter-wing :top-type)
(ptype-of air-refueling-station :top-type) 

(ptype-of carrier-battle-group battle-group)
(ptype-of carrier ship)
(ptype-of frigate ship)

(ptype-of TACTICAL-FIGHTER AIRCRAFT)
(ptype-of F111F TACTICAL-FIGHTER)
(ptype-of F4G TACTICAL-FIGHTER)
(ptype-of F16 TACTICAL-FIGHTER)
(ptype-of F15 TACTICAL-FIGHTER)
(ptype-of F15A TACTICAL-FIGHTER)
(ptype-of A10A TACTICAL-FIGHTER)
(ptype-of F117 TACTICAL-FIGHTER)
(ptype-of AERIAL-REFUELING AIRCRAFT)
(ptype-of KC135Q AERIAL-REFUELING)
(ptype-of KC135 AERIAL-REFUELING)
(ptype-of KC10A AERIAL-REFUELING)
(ptype-of ELECTRONICS AIRCRAFT)
(ptype-of EF111 ELECTRONICS)
(ptype-of EC130H ELECTRONICS)
(ptype-of EC135 ELECTRONICS)
(ptype-of COMMAND-AND-CONTROL AIRCRAFT)
(ptype-of EC130E COMMAND-AND-CONTROL)
(ptype-of E3-AWACS COMMAND-AND-CONTROL)
(ptype-of E3-QUICK-RESPONSE COMMAND-AND-CONTROL)
(ptype-of SOF-AIRCRAFT AIRCRAFT)
(ptype-of RECONNAISSANCE AIRCRAFT)
(ptype-of T43A-CARDA-VIS-RECON RECONNAISSANCE)
(ptype-of RF4C RECONNAISSANCE)
(ptype-of U2-ENROUTE-SUP-TM RECONNAISSANCE)
(ptype-of RC135 RECONNAISSANCE)
(ptype-of C130 RECONNAISSANCE) ;This may actually a tactical transport, not recce
(ptype-of U2 RECONNAISSANCE)
(ptype-of BOMBARDMENT AIRCRAFT)
(ptype-of B1B BOMBARDMENT)
(ptype-of B52 BOMBARDMENT)
(ptype-of AIRLIFT AIRCRAFT)

(ptype-of C141 AIRLIFT) ;Never in TPFDD
(ptype-of C5 AIRLIFT) ;Never in TPFDD
(ptype-of C17 AIRLIFT) ;Never in TPFDD

(ptype-of GROUND-FORCE-MODULE FORCE-MODULE)
(ptype-of DEFENSIVE-FORCE-MODULE GROUND-FORCE-MODULE)
(ptype-of ANTI-AIR-FORCE-MODULE DEFENSIVE-FORCE-MODULE)
(ptype-of HAWK-BATTALION ANTI-AIR-FORCE-MODULE)
(ptype-of PATRIOT ANTI-AIR-FORCE-MODULE)

(ptype-of combat-support GROUND-FORCE-MODULE )
(ptype-of combat-support-force combat-support)

(ptype-of POLICE-FORCE-MODULE GROUND-FORCE-MODULE)
(ptype-of MILITARY-POLICE POLICE-FORCE-MODULE)
(ptype-of SECURITY-POLICE POLICE-FORCE-MODULE)
(ptype-of ATTACHMENT GROUND-FORCE-MODULE)
(ptype-of DOG-TEAM ATTACHMENT)

(ptype-of SPECIAL-FORCE-MODULE GROUND-FORCE-MODULE)
(ptype-of MEU-SOC SPECIAL-FORCE-MODULE)
(ptype-of TROOPS GROUND-FORCE-MODULE)
(ptype-of ARMOR TROOPS)
(ptype-of INFANTRY TROOPS)
(ptype-of INFANTRY-BATTALION INFANTRY)
(ptype-of BRIGADE INFANTRY)

(ptype-of MARINE-UNIT INFANTRY)

(ptype-of LOCATION :top-type)
(ptype-of evac-location LOCATION)
(ptype-of naval-base location)
(ptype-of army-base location)
(ptype-of AIRPORT LOCATION)
(ptype-of conus location)

(ptype-of TOWN-CENTER LOCATION)
(ptype-of COUNTRY LOCATION) ;Used to be :top-type.
(ptype-of CITY LOCATION) ;Used to be :top-type.

;;; The following was added for Blue Flag 97 examples

(ptype-of Weapon :top-type)
(ptype-of weapons-mass-dest Weapon)

(ptype-of Defense :top-type)
(ptype-of Air-Defense Defense)
(ptype-of Ground-Defense Defense)

(ptype-of surface-to-air-missles Air-Defense)

(ptype-of isr :top-type)
(ptype-of intel isr)
(ptype-of surveillance isr)
(ptype-of recce isr)

(ptype-of isr-capability :top-type)

(ptype-of enemy-isr :top-type)
(ptype-of enemy-intel enemy-isr)
(ptype-of enemy-surveillance enemy-isr)
(ptype-of enemy-recce enemy-isr)

(ptype-of missile-element :top-type)
(ptype-of asset :top-type)
(ptype-of theater-ballistic-missile-elements asset)
(ptype-of Integrated-Air-Defense asset)
(ptype-of C2-Center asset)

(ptype-of Ops-Center C2-Center)
(ptype-of reporting-post C2-Center)

;;;Deleted these three because they are objects rather than types. [cox 3mar98]
;(ptype-of Expandiva COUNTRY)
;(ptype-of Monrovia COUNTRY)
;(ptype-of Palluvia COUNTRY)

(pinstance-of US COUNTRY)
(pinstance-of designated-foreign-national-countries GROUP-SET)
#|  ------------------------------  OPERATORS ------------------------------ |#

(OPERATOR ATTACK
  (params <infantry-force> <enemy-force> <stronghold>)
  (preconds
   (
    (<enemy-force> ENEMY-GROUND-UNIT)
    (<stronghold> BUILDING)
    (<infantry-force> SPECIAL-FORCE-MODULE)
    (<loc> LOCATION)
    )
   (and (~ (impossible-precondition))
	(is-ready <infantry-force>) ;; Needs to be here since the predicate is NOT static.
	(loc-at <stronghold> <loc>)
	;; Commented out so cannot subgoal on literal below. [cox 26may98]
;	(is-deployed <enemy-force> <stronghold>)
	(loc-at <stronghold> <loc>)
 	(is-deployed  <infantry-force> <loc>)
	))
  (effects
   ()
   ((add (is-destroyed-by <enemy-force> <infantry-force>))
    (del (is-ready <infantry-force>))))
   )




(OPERATOR SUPPORT-COMBAT-MISSION 
   (params <loc> <support-unit>)
  (preconds
   (
    (<loc> LOCATION)
    (<support-unit> COMBAT-SUPPORT-FORCE)
    )
   (and
    (is-deployed <support-unit> <loc>)
    )
   )
  (effects
   ()
  ((add  (is-mission-supported <loc> <support-unit>))
   ))
  )


(OPERATOR PROVIDE-MEDICAL-ASSISTANCE 
   (params <loc> <support-unit>)
  (preconds
   (
    (<loc> LOCATION)
    (<support-unit> COMBAT-SUPPORT-FORCE)
    )
   (and
    (is-deployed <support-unit> <loc>)
    )
   )
  (effects
   ()
  ((add  (is-medically-assisted <loc> <support-unit>))
   ))
  )



(OPERATOR ISOLATE-BATTLEFIELD
   (params <loc> <soc-unit> <enemy-unit>)
  (preconds
   (
    (<loc> LOCATION)
    (<soc-unit> MEU-SOC)
    (<air-unit> CARRIER-AIR-WING)
    (<naval-unit> CARRIER-BATTLE-GROUP)
    (<enemy-unit> ENEMY-GROUND-UNIT)
    )
   (and
    (is-blockaded <loc> <naval-unit> <air-unit>)
;    (is-ready <soc-unit>)
    ;; Only one enemy unit and I need to avoid universal quantifiers, so
    ;; replace with single predicate. [cox 27apr98]
    (made-ineffective-by <enemy-unit> <soc-unit>)
;    (forall ((<enemy-unit> (and FORCE-MODULE
;			   (gen-from-pred (is-enemy <enemy-unit>)))))
;	       (made-ineffective-by <enemy-unit> <soc-unit>))    
    )
   )
  (effects
   ()
  ((add  (is-sovereign <loc> <soc-unit>))
;   (del (is-ready <soc-unit>))
))
  )




(INFERENCE-RULE DO-BLOCKADE
  (params <loc> <naval-unit>)
  (preconds
   (
    (<loc> COUNTRY)
    (<air-unit> CARRIER-AIR-WING)
    (<naval-unit> CARRIER-BATTLE-GROUP)
    (<today> (and DAY '(gen-from-pred (today-is <today>))))
    )
   (and 
    (is-available <naval-unit> <today>)
    (part-of <air-unit> <naval-unit>)
    (naval-blockaded <loc> <naval-unit>)
    (air-blockaded <loc> <air-unit>)
    ))
  (effects
   ()
   ((add (is-blockaded <loc> <naval-unit> <air-unit>))))
   )


(OPERATOR NAVAL-BLOCKADE
  (params <loc> <naval-unit>)
  (preconds
   (
    (<loc> COUNTRY)
    (<naval-unit> CARRIER-BATTLE-GROUP)
    (<today> (and DAY '(gen-from-pred (today-is <today>))))
    )
   (and 
    (is-available <naval-unit> <today>)
    (is-deployed <naval-unit> <loc>)
    ))
  (effects
   ()
   ((add (naval-blockaded <loc> <naval-unit>))))
   )

(OPERATOR AIR-BLOCKADE
  (params <loc> <air-unit>)
  (preconds
   (
    (<loc> COUNTRY)
    (<air-unit> CARRIER-AIR-WING)
    (<naval-unit> CARRIER-BATTLE-GROUP)
    (<today> (and DAY '(gen-from-pred (today-is <today>))))
    )
   (and 
    (is-available <naval-unit> <today>)
    (part-of <air-unit> <naval-unit>)
    ))
  (effects
   ()
   ((add (air-blockaded <loc> <air-unit>))))
   )



(OPERATOR AIR-DEFENSE
  (params <loc> <air-unit>)
  (preconds
   (
    (<loc> COUNTRY)
    (<air-unit> FIGHTER-AIRCRAFT)
    (<today> (and DAY '(gen-from-pred (today-is <today>))))
    )
   (and 
    (is-available <air-unit> <today>)
    (is-deployed <air-unit> <loc>)
    ))
  (effects
   ()
   ((add (air-defended <loc> <air-unit>))))
   )



;(OPERATOR CONDUCT-NEO
;  (params <loc>)
;  (preconds
;   (
;    (<loc> COUNTRY) 
;;    (<perimeter> LOCATION)
;    )
;   (and
;;    (loc-at <perimeter> <loc>)
;;    (is-secure <perimeter>)
;    (~ (exists ((<citizen> (and POPULATION
;				(gen-from-pred (citizen-of-US <citizen>)))))
;	       (loc-at-p <citizen> <loc>)))
;    (~ (exists ((<foreign-country> (and COUNTRY 
;					(diff <foreign-country> <loc>)
;					(diff <foreign-country> 'US)))
;		(<foreign-national> (and POPULATION
;				(gen-from-pred 
;				 (citizen-of <foreign-country> 
;					     <foreign-national>))
;				(gen-from-pred
;				 (member-of <foreign-country> 
;					    designated-foreign-national-countries)))))
;	       (loc-at-p <foreign-national> <loc>)))
;;    (~ (loc-at-p <foreign-national> <loc>))
;    )
;   )
;  (effects
;   ()
;  ((add  (is-evacuated <loc>))))
;  )


(OPERATOR CONDUCT-NEO
  (params <force> <loc>)
  (preconds
   ((<force> SPECIAL-FORCE-MODULE)
    (<loc> COUNTRY) 
;    (<new-loc> (and LOCATION (diff <loc> <new-loc>)))
    )
   (and
    (forall ((<citizen> (and POPULATION
			     (gen-from-pred (citizen-of-US <citizen>))
			     (gen-from-pred (loc-at-p <citizen> <loc>)))))
	       (removed-from-loc <force> <loc> <citizen>)
;	       (loc-at-p <citizen> <new-loc>)
	       )
    (forall ((<foreign-country> (and COUNTRY 
					(diff <foreign-country> <loc>)
					(diff <foreign-country> 'US)))
		(<foreign-national> (and POPULATION
				(gen-from-pred 
				 (citizen-of <foreign-country> 
					     <foreign-national>))
				(gen-from-pred (loc-at-p <foreign-national> <loc>))
				(gen-from-pred
				 (member-of <foreign-country> 
					    designated-foreign-national-countries)))))
	       (removed-from-loc <force> <loc> <foreign-national>))
    )
   )
  (effects
   ()
  ((add  (is-evacuated <force> <loc>))))
  )


;;;Why was this operator written?
;;; Because both conduct and support neo are in PlanM
;;;
;;; ????? need to change like conduct neo above.
;;;
(OPERATOR SUPPORT-NEO
  (params <loc>)
  (preconds
   (
    (<loc> COUNTRY) 
;    (<perimeter> LOCATION)
    )
   (and
;    (loc-at <perimeter> <loc>)
;    (is-secure <perimeter>)
    (~ (exists ((<citizen> (and POPULATION
				(gen-from-pred (citizen-of-US <citizen>)))))
	       (loc-at-p <citizen> <loc>)))
    (~ (exists ((<foreign-country> (and COUNTRY 
					(diff <foreign-country> <loc>)
					(diff <foreign-country> 'US)))
		(<foreign-national> (and POPULATION
				(gen-from-pred 
				 (citizen-of <foreign-country> 
					     <foreign-national>))
				(gen-from-pred
				 (member-of <foreign-country> 
					    designated-foreign-national-countries)))))
	       (loc-at-p <foreign-national> <loc>)))
;    (~ (loc-at-p <foreign-national> <loc>))
    )
   )
  (effects
   ()
  ((add  (is-neo-supported <loc>))))
  )


(OPERATOR EVACUATE-NON-COMBATANTS-BY-AIRLIFT
  (params <perimeter> <airport> <transport> <new-loc> <citizen>)
  (preconds
   ((<loc> COUNTRY)
    (<province> COUNTRY)
    (<new-loc> (and COUNTRY 
			 (diff <loc> <new-loc>)))
    (<home-country> (and COUNTRY 
			 (diff <loc> <home-country>)))
    (<perimeter> LOCATION)
    (<airport> AIRPORT)
    (<transport> AIRLIFT)
    (<force> SPECIAL-FORCE-MODULE)
    )
   (and
    (province-of <loc> <province>)
    (loc-at <perimeter> <province>)
    (loc-at <airport> <province>)
    (near <airport> <perimeter>)
    (is-deployed <transport> <province>)
    (is-secure <perimeter>)
;redundant    (airport-secure-at <loc> <airport>)
    )
   )
  (effects
   ((<citizen> POPULATION))
  ((if (and (province-of <loc> <province>)
	    (loc-at-p <citizen> <province>) (citizen-of <home-country> <citizen>))
   ((add  (removed-from-loc <force> <loc> <citizen>)
;;;	  (loc-at-p <citizen> <new-loc>)
	  )
    (del  (loc-at-p <citizen> <loc>))))))
  )


(OPERATOR EVACUATE-NON-COMBATANTS-BY-HELLIO
  (params <loc> <perimeter>)
  (preconds
   ((<loc> COUNTRY)
    (<home-country> (and COUNTRY 
			 (diff <loc> <home-country>)))
    (<perimeter> LOCATION)
    (<offshore> LOCATION)
    (<hellios> BLACKHAWK)
    (<amphib-craft> SHIP)
    (<force> SPECIAL-FORCE-MODULE)
    )
   (and
    (loc-at <perimeter> <loc>)
    (near <offshore> <perimeter>)
    (is-deployed <amphib-craft> <offshore>)
    (is-deployed <hellios> <perimeter>)
    (is-secure <perimeter>)
    )
   )
  (effects
   ((<citizen> POPULATION))
  ((if (and (loc-at-p <citizen> <loc>) (citizen-of <home-country> <citizen>))
   ((add (removed-from-loc <force> <loc> <citizen>)
;;;	 (loc-at-p <citizen> <offshore>)
	 )
    (del  (loc-at-p <citizen> <loc>))))))
  )


(OPERATOR SECURE-PERIMETER
  (params <infantry-unit> <perimeter> <loc>)
  (preconds
   (
    (<loc> COUNTRY)
    (<perimeter> LOCATION)
    (<infantry-unit> (or INFANTRY SPECIAL-FORCE-MODULE SECURITY-POLICE ))
    )
   (and 
    (loc-at <perimeter> <loc>)
    (~ (exists ((<enemy-force> enemy-ground-unit))
	    (is-deployed <enemy-force> <perimeter>)))
    (is-deployed  <infantry-unit> <loc>)
    ))
  (effects
   ()
   ((add (is-secure <perimeter>))))
   )


(OPERATOR DEPLOY
  (params <air-unit> <loc> <airport>)
  (preconds
   ((<air-unit> AIRCRAFT)
    (<loc> LOCATION) ;Was of type airport. Currently, usually a country.
;    (<larger-unit> GROUP-UNIT)
    (<airport> AIRPORT))
   (and
;    (~(part-of <air-unit> <larger-unit>))
    (~ (isa-C141 <air-unit>))
    (loc-at <airport> <loc>)
    (is-active <air-unit>)
    (airport-secure-at <loc> <airport>)
    (is-usable <airport>))
   )
  (effects
   ()
  ((add  (is-deployed <air-unit> <loc>))))
  )

(OPERATOR DEPLOY-SHIPS
  (params <naval-unit> <loc>)
  (preconds
   (
    (<loc>  LOCATION) 
    (<naval-unit> (or CARRIER-BATTLE-GROUP SHIP))
    )
   (and
    (is-active <naval-unit>)
    )
    )
  (effects
   ()
   ((add (is-deployed <naval-unit> <loc>))))
  )




;;; Dave Brown says c141s do not deploy, they transit instead.
(OPERATOR TRANSIT
  (params <air-unit> <loc> <airport>)
  (preconds
   ((<air-unit> C141)
    (<loc> LOCATION) ;Was of type airport. Currently, usually a country.
;    (<larger-unit> GROUP-UNIT)
    (<airport> AIRPORT))
   (and
;    (~(part-of <air-unit> <larger-unit>))
    (is-active <air-unit>)
    (loc-at <airport> <loc>)
    (airport-secure-at <loc> <airport>)
    (is-usable <airport>))
   )
  (effects
   ()
  ((add  (is-deployed <air-unit> <loc>))))
  )


(OPERATOR SECURE-STRONGHOLD
  (params <infantry-force> <stronghold>)
  (preconds
   (
    (<loc> LOCATION)
    (<stronghold> BUILDING)
    (<infantry-force> 
;     (and
      INFANTRY 
      ;; Now handled by control rule.
;      (gen-from-pred '(is-active <infantry-force>))
;      )
    )
    (<security-force> POLICE-FORCE-MODULE)
    )
   (and 
;    (loc-at <stronghold> <loc>) ;Control rule now handles binding
;    (forall ((<enemy-force> (and FORCE-MODULE
;				 (gen-from-pred (is-enemy <enemy-force>)))))
;	    (~(is-deployed <enemy-force> <stronghold>)))
    (~ (exists ((<enemy-force> ENEMY-GROUND-UNIT))
	    (is-deployed <enemy-force> <stronghold>)))
    (is-deployed  <infantry-force> <loc>)
    (is-deployed  <security-force> <loc>)
    ))
  (effects
   ()
   ((add (is-secure <stronghold>))))
   )


(OPERATOR MAINTAIN-LAW-AND-ORDER
  (params <loc>)
  (preconds
   ((<loc> COUNTRY)
    (<gov> GOVERNMENT)
    )
   (and
    (legitimate-gov <gov> <loc>)
    (is-assisted <loc> <gov>)
   ))
  (effects
   ()
   ((add (law-abiding <loc>))))
  )

(OPERATOR PROVIDE-SECURITY-FOR-US-MILITARY-PERSONNEL
  (params <loc>)
  (preconds
   ((<loc> COUNTRY)
    )
   (and
    (forall ((<military-base> (and LOCATION
				  (gen-from-pred 
				   ;Should change to has-us-military-persons. 
				   ;Phillipines does not have US base any more
				   (is-US-military-installation <military-base>)))))
	    (and
	     (loc-at <military-base> <loc>)
	     (is-secure <military-base>))
	     )
    ))
  (effects
   ()
   ((add (safe-US-personnel <loc>))))
  )

(OPERATOR DO-ASSIST
  (params <gov> <loc>)
  (preconds
   ((<loc> COUNTRY)
    (<gov> GOVERNMENT)
    (<police-unit> MILITARY-POLICE)
    )
   (and
    (legitimate-gov <gov> <loc>)
    (is-deployed <police-unit> <loc>)
    )
   )
  (effects
   ()
   ((add (is-assisted <loc> <gov>))))
  )


(OPERATOR DEFEND-STRONGPOINTS-AND-LOCS
  (params <loc>)
  (preconds
   ((<loc> COUNTRY)
    )
   (and
    (forall ((<strong-point> (and BUILDING
				  (gen-from-pred 
				   (designated-strong-point <strong-point>)))))
	    (is-secure <strong-point>))
    ;; Special-locs are really lines of communication (loc), not locations.
    (forall ((<special-loc> (and LOCATION 
;				 (not-airport-p <special-loc>) ;Not working.
				 (gen-from-pred 
				  (designated-location <special-loc>)))))
	    (is-secure <special-loc>))
   (forall ((<airport> (and AIRPORT
				 (gen-from-pred 
				  (designated-location <airport>)))))
	    (airport-secure-at <loc> <airport>)))
   )
  (effects
   ()
   ((add (is-defended <loc>))))
  )



(OPERATOR PROTECT-STRONGPOINTS-AND-LOCS
  (params <loc>)
  (preconds
   ((<loc> COUNTRY)
    )
   (and
    (forall ((<strong-point> (and BUILDING
				  (gen-from-pred 
				   (designated-strong-point <strong-point>)))))
	    (is-secure <strong-point>))
    (forall ((<special-loc> (and LOCATION 
;				 (not-airport-p <special-loc>) ;Not working.
				 (gen-from-pred 
				  (designated-location <special-loc>)))))
	    (is-secure <special-loc>))
   (forall ((<airport> (and AIRPORT
				 (gen-from-pred 
				  (designated-location <airport>)))))
	    (airport-secure-at <loc> <airport>)))
   )
  (effects
   ()
   ((add (is-protected <loc>))))
  )



(OPERATOR PROTECT-AND-DEFEND-STRONGPOINTS-AND-LOCS
  (params <loc>)
  (preconds
   ((<loc> COUNTRY)
    )
   (and
    (is-protected <loc>)
    (is-defended <loc>)
    )
   )
  (effects
   ()
   ((add (is-protected-and-defended <loc>))))
  )



(OPERATOR SEND
  (params <ground-unit> <loc>)
  (preconds
   (
    (<loc>  LOCATION) ;Country isa location so either will do here.
    (<smuggling-threat> WEAPONS-SMUGGLING)
    (<ground-unit> (and GROUND-FORCE-MODULE 
			(gen-from-pred 
			 '(is-ready <ground-unit>))))
    )
   (and
    (is-active <ground-unit>)
;Temporary. Add back in later [cox 4mar98]
    (~ (threat-at <smuggling-threat> <loc>))
    )
    )
  (effects
   ()
   ((add (is-deployed <ground-unit> <loc>))))
  )


(OPERATOR SECURE
  (params <airport>
	  <loc>)
  (preconds
   ((<loc> LOCATION) ;was of type airport
    (<airport> AIRPORT) ;was of type location. changed 3mar98 [cox]
    (<internal-security-force> SECURITY-POLICE)
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
    (<object-suppressed> TERRORISM)
    )
   (and 
	(is-deployed  <external-security-force1> <loc>)
	(is-deployed  <external-security-force2> <loc>)
	(is-deployed  <internal-security-force> <loc>)
	(threat-at <object-suppressed> <loc>)
	))
  (effects
   ( )
   ((add (is-suppressed <object-suppressed> <loc>))))
  )


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#|

(OPERATOR DESTROY-AGREGATE
  (params <target> <loc>)
  (preconds
   ((<target> INTEGRATED-AIR-DEFENSE)
    (<loc> COUNTRY) 
    (<Sector-Operations-Centers> OPS-CENTER)
    (<reporting-post> (and REPORTING-POST 
			   (diff <reporting-post> <Sector-Operations-Centers>)
			   ))
    (<surface-to-air-missles> surface-to-air-missles)
    (<Integrated-Operations-Centers> 
     (and OPS-CENTER 
	  (diff <reporting-post> <Integrated-Operations-Centers>)
	  (diff <Sector-Operations-Centers> <Integrated-Operations-Centers>)))
    )
   (and
    (loc-at <target> <loc>)
    (is-destroyed <Sector-Operations-Centers> <loc>)
    (is-destroyed <Integrated-Operations-Centers> <loc>)
    (is-destroyed <reporting-post> <loc>)
    (is-destroyed <surface-to-air-missles> <loc>)
;    (~(airthreat-exists-near <target>))
    )
   )
  (effects
   ()
  ((add  (is-destroyed <target> <loc>))))
  )



(OPERATOR DESTROY-C2-CENTER-COMPONENT
  (params <component> <fighter-ac>)
  (preconds
   (
    (<target> INTEGRATED-AIR-DEFENSE)
    (<component> C2-CENTER)
    (<other-target> (and ASSET 
			 (diff <target> <other-target>)))
    (<loc> COUNTRY)
    (<fighter-ac> F15)
    )
   (and
    (part-of <component> <target>)
    (near <target> <other-target>)
    (loc-at <target> <loc>)
    (is-ready <fighter-ac>)
    (CAP-in-place <loc>)
    (~(airthreat-exists-near <target>))
    )
   )
  (effects
   ()
  (
   (add  (is-destroyed <component> <loc>))))
  )


(OPERATOR ESCORTED-DESTROY-C2-CENTER
  (params <component> <fighter-ac>)
  (preconds
   ((<target>  INTEGRATED-AIR-DEFENSE)
    (<component> C2-CENTER)
    (<loc> COUNTRY)
    (<fighter-ac> TACTICAL-FIGHTER)
    )
   (and
    (part-of <component> <target>)
    (airthreat-exists-near <target>)
    (loc-at <target> <loc>)
    (forall ((<other-target> (and asset 
				  (diff <target> <other-target>)
				  (gen-from-pred (is-target <other-target>)))))
	    (~(near <target> <other-target>)))
    (is-ready <fighter-ac>)
    (CAP-in-place <loc>)
    )
   )
  (effects
   ()
  ((add  (is-destroyed <component> <loc>))))
  )


(OPERATOR DESTROY-SAM-COMPONENT
  (params <target> <loc> <fighter-ac>)
  (preconds
   ((<target> SURFACE-TO-AIR-MISSLES)
    (<loc> COUNTRY)
    (<fighter-ac> TACTICAL-FIGHTER)
    )
   (and
    (loc-at <target> <loc>)
    (is-ready <fighter-ac>)
    (CAP-in-place <loc>)
    )
   )
  (effects
   ()
  ((add  (is-destroyed <target> <loc>))))
  )

(control-rule  DESTROY-SAM-COMPONENT
  (if (and (current-operator  DESTROY-SAM-COMPONENT)
	   (type-of-object <X> F16)))	   
  (then select bindings ((<fighter-ac> . <X>))))


(OPERATOR DO-COMBAT-AIR-PATROL
  (params <escort-ac> <loc> <fighter-ac>)
  (preconds
   ((<escort-ac> TACTICAL-FIGHTER)
    (<loc> COUNTRY)
    (<fighter-ac> (and TACTICAL-FIGHTER 
		       (diff <escort-ac> <fighter-ac>))))
   (and
    (is-ready <fighter-ac>)
    (is-ready <escort-ac>)

    )
   )
  (effects
   ()
  ((add (CAP-in-place <loc>))))
  )


(control-rule SELECT-ESCORT
  (if (and (current-operator DO-COMBAT-AIR-PATROL)
	   (type-of-object <X> F15)))	   
  (then select bindings ((<escort-ac> . <X>))))
|#


;;; [cox 30apr98]
(CONTROL-RULE SELECT-ISOLATE-BATTLEFIELD-BINDINGS
  (if (and (current-operator ISOLATE-BATTLEFIELD)
	   (current-goal (is-sovereign <loc> <s>))
	   (type-of-object <enemy> ENEMY-GROUND-UNIT)
;	   (true-in-state (is-enemy <enemy>))
	   (true-in-state (is-blockaded <loc> <n-unit> <a-unit>))
	   ))
  (then select bindings ((<enemy-unit> . <enemy>) (<air-unit> . <a-unit>) (<naval-unit> . <n-unit>)))
  )


(CONTROL-RULE SELECT-ISOLATE-BATTLEFIELD-BINDINGS2
  (if (and (current-operator ISOLATE-BATTLEFIELD)
	   (current-goal (is-sovereign <loc> <s>))
	   (type-of-object <enemy> ENEMY-GROUND-UNIT)
;	   (true-in-state (is-enemy <enemy>))
	   (false-in-state-forall-values (is-blockaded <loc> <n-unit> <a-unit>))
	   ))
  (then select bindings ((<enemy-unit> . <enemy>)))
  )




;;; [cox 3mar98 24apr98]
(CONTROL-RULE SELECT-SECURE-BINDINGS
  (if (and (current-operator SECURE)
	   (type-of-object <x> AIRPORT)
	   (true-in-state (loc-at <x> <loc>))
	   (type-of-object <q> SECURITY-POLICE)
	   (true-in-state (is-active <q>))
	   (true-in-state (is-active <r>))
	   (true-in-state (is-active <s>))
	   ))
  (then select bindings ((<airport> . <x>) 
			 (<internal-security-force> . <q>)
			 (<external-security-force1> . <r>)
			 (<external-security-force2> . <s>)
			 )))


(CONTROL-RULE SELECT-DEPLOY-BINDINGS
  (if (and (current-operator DEPLOY)
	   (type-of-object <x> AIRCRAFT)
	   (true-in-state (is-active <x>))
	   (false-in-state-forall-values (isa-C141 <x>))
	   ))
  (then select bindings ((<air-unit> . <x>) )))


;;; [cox 8apr98]
(CONTROL-RULE SELECT-SEND-BINDINGS
  (if (and (current-operator SEND)
	   (type-of-object <x> GROUND-FORCE-MODULE)
	   (true-in-state (is-ready <x>))
	   (true-in-state (is-active <x>))
;	   (false-in-state-forall-values (is-enemy <x>))
	   ))
  (then select bindings ((<ground-unit> . <x>) )))



;;; [cox 8apr98]
(CONTROL-RULE SELECT-SUPPRESS-BINDINGS
  (if (and (current-operator SUPPRESS)
	   (type-of-object <x> INFANTRY)
	   (true-in-state (is-ready <x>))
	   (true-in-state (is-active <x>))
;	   (false-in-state-forall-values (is-enemy <x>))
	   ))
  (then select bindings ((<external-security-force1> . <x>) )))

(CONTROL-RULE SELECT-OP-4-IS-SECURE-GOAL
  (if (and (current-goal (is-deployed <airunit> <country>))
	   (true-in-state (isa-C141 <airunit>))
	   ))
  (then select operator TRANSIT)) 


(CONTROL-RULE SELECT-OP-4-GROUND-UNIT-MOVEMENT
  (if (and (current-goal (is-deployed <groundunit> <country>))
	   (type-of-object <groundunit> GROUND-FORCE-MODULE)  
	   ))
  (then select operator SEND))
 

(CONTROL-RULE SELECT-SECURE-STRONGHOLD-BINDINGS
  (if (and (current-operator SECURE-STRONGHOLD)
	   (type-of-object <x> INFANTRY)
	   (true-in-state (is-active <x>))
	   (type-of-object <y>  POLICE-FORCE-MODULE)
	   (true-in-state (is-active <y>))
	   (current-goal (is-secure <stronghold>))
	   (type-of-object <z> COUNTRY)
	   (true-in-state (loc-at <stronghold> <z>))
	   ))
  (then select bindings ((<infantry-force> . <X>) (<security-force> . <y>) (<loc> . <z>))))

;;; Used to be 3 rules for secure-stronghold bindings (above). But only one
;;; will fire.
#|
(CONTROL-RULE SELECT-LOC
  (if (and (current-operator SECURE-STRONGHOLD)
	   (current-goal (is-secure <stronghold>))
	   (type-of-object <x> COUNTRY)
	   (true-in-state (loc-at <stronghold> <x>))
	   ))
  (then select bindings ((<loc> . <X>))))

(CONTROL-RULE SELECT-INFANTRY
  (if (and (current-operator SECURE-STRONGHOLD)
	   (type-of-object <x> INFANTRY)
	   (true-in-state (is-active <x>))
	   ))
  (then select bindings ((<infantry-force> . <X>))))

(CONTROL-RULE SELECT-POLICE
  (if (and (current-operator SECURE-STRONGHOLD)
	   (type-of-object <x>  POLICE-FORCE-MODULE)
	   (true-in-state (is-active <x>))
	   ))
  (then select bindings ((<security-force> . <X>))))
|#


(CONTROL-RULE SELECT-MEU-SOC
  (if (and (current-operator SECURE-PERIMETER)
	   (current-goal (is-secure <Y>))
	   (type-of-object <Y> EVAC-LOCATION)
	   (type-of-object <X> MEU-SOC)
	   (true-in-state (is-active <X>))
	   (true-in-state (is-ready <X>))
	   ))
  (then select bindings ((<infantry-unit> . <X>))))

(CONTROL-RULE SELECT-SEC-POLICE
  (if (and (current-operator SECURE-PERIMETER)
	   (current-goal (is-secure <Y>))
	   (type-of-object <Y> AIRPORT)
	   (type-of-object <X> SECURITY-POLICE)
	   (true-in-state (is-active <X>))
	   (true-in-state (is-ready <X>))
	   ))
  (then select bindings ((<infantry-unit> . <X>))))

#|

(OPERATOR ACHIEVE-AIR-SUPERIORITY
  (params  <loc>)
  (preconds
    ((<integrated-air-defense> INTEGRATED-AIR-DEFENSE)
     (<THEATER-BALLISTIC-MISSILE-ELEMENTS> THEATER-BALLISTIC-MISSILE-ELEMENTS)
     (<ENEMY-ISR> ISR-CAPABILITY)
     (<loc> COUNTRY))
   (and
    (is-destroyed <integrated-air-defense> <loc>)
    (is-destroyed <THEATER-BALLISTIC-MISSILE-ELEMENTS> <loc>)
    (is-destroyed <ENEMY-ISR> <loc>)
    (hva-protected <loc>)
    (CAP-in-place <loc>)
    (ISR-in-place <loc>))
   )
  (effects
   ()
   ((add (achieved-air-superiority <loc>))))
  )

;;;;;;;;alice added tasks.....

(OPERATOR DESTROY-TBM-AGREGATE
  (params <target> <loc>)
  (preconds
   ((<target> THEATER-BALLISTIC-MISSILE-ELEMENTS)
    (<loc> COUNTRY) 
    (<tbm-stockpile> MISSILE-ELEMENT)
    (<tbm-c3> (and MISSILE-ELEMENT (diff <tbm-c3> <tbm-stockpile>)))
    (<tbm-support-facility>  (and MISSILE-ELEMENT 
				  (diff <tbm-support-facility> <tbm-c3>)
				  (diff <tbm-support-facility> <tbm-stockpile>)
				  ))
    (<tbm-launcher> (and MISSILE-ELEMENT (diff <tbm-c3> <tbm-launcher>)
			 (diff <tbm-launcher> <tbm-support-facility>)
			 (diff <tbm-launcher> <tbm-stockpile>))))
   (and
    (loc-at <target> <loc>)
    (is-destroyed <tbm-stockpile> <loc>)
    (is-destroyed <tbm-launcher> <loc>)
    (is-destroyed <tbm-c3> <loc>)
    (is-destroyed <tbm-support-facility> <loc>)
    )
   )
  (effects
   ()
  ((add  (is-destroyed <target> <loc>))))
  )


(OPERATOR DESTROY-TBM-C3-COMPONENT
  (params <target> <loc> <fighter-ac> )
  (preconds
   ((<target> MISSILE-ELEMENT)
    (<loc> COUNTRY)
    (<fighter-ac> TACTICAL-FIGHTER)
    )
   (and
    (loc-at <target> <loc>)
    (is-ready <fighter-ac>)
    (CAP-in-place <loc>)
    )
   )
  (effects
   ()
  ((add  (is-destroyed <target> <loc>))))
  )

(OPERATOR DESTROY-TBM-SUPPORT-FACILITY-COMPONENT
  (params <target> <loc> <fighter-ac> )
  (preconds
   ((<target> MISSILE-ELEMENT)
    (<loc> COUNTRY)
    (<fighter-ac> TACTICAL-FIGHTER)
    )
   (and
    (loc-at <target> <loc>)
    (is-ready <fighter-ac>)
    (CAP-in-place <loc>)
    )
   )
  (effects
   ()
  ((add  (is-destroyed <target> <loc>))))
  )


(OPERATOR DESTROY-TBM-STOCKPILE-COMPONENT
  (params <target> <loc> <fighter-ac> )
  (preconds
   ((<target> MISSILE-ELEMENT)
    (<loc> COUNTRY)
    (<fighter-ac> TACTICAL-FIGHTER)
    )
   (and
    (loc-at <target> <loc>)
    (is-ready <fighter-ac>)
    (CAP-in-place <loc>)
    )
   )
  (effects
   ()
  ((add  (is-destroyed <target> <loc>))))
  )


(OPERATOR DESTROY-TBM-LAUNCHER-COMPONENT
  (params <target> <loc> <fighter-ac>)
  (preconds
   ((<target> MISSILE-ELEMENT)
    (<loc> COUNTRY)
    (<fighter-ac> TACTICAL-FIGHTER)
    )
   (and
    (loc-at <target> <loc>)
    (is-ready <fighter-ac>)
    (CAP-in-place <loc>)
    )
   )
  (effects
   ()
  ((add  (is-destroyed <target> <loc>))))
  )
|#

;;; Needed to delete this op because it has only del list. Commented out the other blueflag ops [cox 4mar98]
;(OPERATOR SWEEP
;  (params <loc> <fighter-ac>)
;  (preconds
;   (
;    (<strike-target> ASSET)
;    (<other-target> (and ASSET 
;			 (diff <strike-target> <other-target>)))
;    (<loc> COUNTRY)
;    (<fighter-ac> F15)
;    )
;   (and
;    (is-target <other-target>)
;    (loc-at <strike-target> <loc>)
;    (airthreat-exists-near <strike-target>)
;   ))
;  (effects
;   ()
;  ((del  (airthreat-exists-near <strike-target>))
;    ))
;  )


#|

(OPERATOR PROTECT-ASSETS
  (params <loc>)
  (preconds
   (
    (<loc> COUNTRY)
    )
   (forall ((<asset> (and AIRCRAFT 
			  (gen-from-pred 
			   (has-value <asset> high)))))
	   (and (loc-at <asset> <loc>)
		(protected <asset> <loc>)))
   )
  (effects
   ()
   ((add  (hva-protected <loc>))))
  )

(OPERATOR PROTECT
  (params <asset> <loc>)
  (preconds
   ((<asset> AIRCRAFT)
    (<loc> COUNTRY)
    )
   (and ;Added and [cox 3mar98]
    (loc-at <asset> <loc>))
   )
  (effects
   ()
   ((add  (protected <asset> <loc>))))
  )

;;;;alice added task1g

(OPERATOR PROTECT-GROUND-FORCES
  (params <ground-force> <loc>)
  (preconds
   ((<ground-force> TROOPS)
    (<loc> COUNTRY)
    )
   (loc-at <ground-force> <loc>)
   )
  (effects
   ()
   ((add  (protected <ground-force> <loc>))))
  )


(OPERATOR CONDUCT-ISR
	  (params <loc>)
  (preconds
   (
    (<loc> COUNTRY))
   (and
    (INTEL-in-place <loc>)
    (RECCE-in-place <loc>)
    (SURVEILLANCE-in-place <loc>)
    )
   )
(effects
 ()
 ((add (ISR-in-place <loc>)))))


(OPERATOR DO-24-hr-intel-op
  (params <intel> <target> <loc>)
  (preconds
   ((<target> MISSILE-ELEMENT)
    (<intel> INTEL)
    (<loc> COUNTRY))
   (and
    (loc-at <target> <loc>)
    (is-ready <intel>)
     )
   )
  (effects
   ()
  ((add (INTEL-in-place <loc>))))
  )

(OPERATOR DO-24-hr-surveillance-op
  (params <surveillance> <target> <loc>)
  (preconds
   ((<target> MISSILE-ELEMENT)
    (<surveillance> SURVEILLANCE)
    (<loc> COUNTRY))
   (and
    (loc-at <target> <loc>)
    (is-ready <surveillance>)
     )
   )
  (effects
   ()
  ((add (surveillance-in-place <loc>))))
  )



(OPERATOR DO-24-hr-recce-op
  (params <recce> <target> <loc>)
  (preconds
   ((<target> MISSILE-ELEMENT)
    (<recce> RECCE)
    (<loc> COUNTRY))
   (and
    (loc-at <target> <loc>)
    (is-ready <recce>)
     )
   )
  (effects
   ()
  ((add (recce-in-place <loc>))))
  )



(OPERATOR DESTROY-ENEMY-INTEL-OPS
  (params <target> <loc> <fighter-ac>)
  (preconds
   ((<target> ENEMY-INTEL)
    (<loc> COUNTRY)
    (<fighter-ac> TACTICAL-FIGHTER)
    )
   (and
    (loc-at <target> <loc>)
    (is-ready <fighter-ac>)
    (CAP-in-place <loc>)
    )
   )
  (effects
   ()
  ((add  (is-destroyed <target> <loc>))))
  )


(OPERATOR DESTROY-ENEMY-SURVEILLANCE-OPS
  (params <target> <loc> <fighter-ac>)
  (preconds
   ((<target> ENEMY-SURVEILLANCE)
    (<loc> COUNTRY)
    (<fighter-ac> TACTICAL-FIGHTER)
    )
   (and
    (loc-at <target> <loc>)
    (is-ready <fighter-ac>)
    (CAP-in-place <loc>)
    )
   )
  (effects
   ()
  ((add  (is-destroyed <target> <loc>))))
  )


(OPERATOR DESTROY-ENEMY-RECCE-OPS
  (params <target> <loc> <fighter-ac>)
  (preconds
   ((<target> ENEMY-RECCE)
    (<loc> COUNTRY)
    (<fighter-ac> TACTICAL-FIGHTER)
    )
   (and
    (loc-at <target> <loc>)
    (is-ready <fighter-ac>)
    (CAP-in-place <loc>)
    )
   )
  (effects
   ()
  ((add  (is-destroyed <target> <loc>))))
  )


(OPERATOR DESTROY-ENEMY-ISR
  (params <target> <loc>)
  (preconds
   ((<target> ISR-CAPABILITY)  
    (<loc> COUNTRY) 
    (<enemy-intel> ENEMY-ISR)
    (<enemy-recce> (and ENEMY-ISR (diff <enemy-intel> <enemy-recce>)))
    (<enemy-surveillance> (and ENEMY-ISR (diff <enemy-intel> <enemy-surveillance>)
			       (diff <enemy-intel> <enemy-surveillance>))))
   (and
    (loc-at <target> <loc>)
    (is-destroyed <enemy-intel> <loc>)
    (is-destroyed <enemy-recce> <loc>)
    (is-destroyed <enemy-surveillance> <loc>)
      )
   )
  (effects
   ()
  ((add  (is-destroyed <target> <loc>))))
  )


(OPERATOR SELECTIVELY-DESTROY-WMD-CAPABILITY
  (params  <loc>)
  (preconds
   (
    (<loc> COUNTRY)
    )
  (and
   (forall ((<weapons-mass-dest> (and WEAPON 
			  (gen-from-pred 
			   (has-value <weapons-mass-dest> high)))))
	   (and (loc-at <weapons-mass-dest> <loc>)
		(destroyed <weapons-mass-dest> <loc>)))
   )
  )
  (effects
   ()
   ((add (neutralized-wmd-capability <loc>))))
  )


(OPERATOR DESTROY-WMD
  (params <loc> <wmd>)
  (preconds
   (
    (<wmd> WEAPON)
    (<loc> COUNTRY)
    )
   (loc-at <wmd> <loc>)
   )
  (effects
   ()
   ((add  (destroyed <wmd> <loc>))))
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
    (<enemy-unit> ENEMY-GROUND-UNIT)
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
    (<enemy-unit> ENEMY-GROUND-UNIT)
    )
   (and
    (near <civilians> <enemy-unit>)
    (is-isolated-by <enemy-unit> <unit>)))
  (effects
   ()
   ((add  (made-ineffective-by <enemy-unit> <unit>))))
  )


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(if *analogical-replay*
    (load (concatenate 'string *analogy-pathname* "replay-crs")))
  
;(pset :linear t)

;;; This is the most radical linear mode.
;;; Add this to the end of the domain file.

(in-package user)

(defun linear-remove-alts (signal)
  (cond
   ((p4::goal-node-p *current-node*)
    ;;(format t "~% I am here goal.")
    (setf (p4::goal-node-goals-left *current-node*) nil))
   ((p4::a-or-b-node-p *current-node*)
    ;;(format t "~% I am here a-or-b-node.")
    (setf (p4::a-or-b-node-applicable-ops-left *current-node*) nil)
    (setf (p4::a-or-b-node-goals-left *current-node*) nil))
   (t nil))
  nil)


(cond (*analogical-replay*
       (load (concatenate 'string *analogy-pathname* "replay-crs")))
      (t
       (clear-prod-handlers) 
       (define-prod-handler :always #'linear-remove-alts) )
      )

