(in-package "USER")

;;; Commented out older domain for tfs and included the philippines scenario.  [cox 24feb98]


;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;
;;;; PROGRAM PROBLEM
;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;

;;;
;;; See file set-problem.lisp for comments discussing these variables. This 
;;; file must be loaded after file set-problem.
;;;

(setf FE::*ForMat-Loaded* t)


;;; Defines the objects in PRODIGY-ForMAT's initial state.

(setf *object-list*
  (if FE::*JADE-demo-p*
      '(               (objects-are A10A F16 F15 F117 TACTICAL-FIGHTER)
		       (object-is kc135 AERIAL-REFUELING)
		       (object-is e3 E3-AWACS)
		       (object-is EC130H ELECTRONICS)
		       (object-is ELECTRONICS AIRCRAFT)
		       (object-is C130 RECONNAISSANCE)
		       (object-is tfs2 group-unit)
                       (object-is tfs3 group-unit)
                       (objects-are air-interdiction air-superiority
                                    close-air-support mission-name)
                       (objects-are weapons-smuggling terrorism threat)
                       (objects-are terrorism1 terrorism2 terrorism)
                       (object-is weapons-smuggling1 weapons-smuggling)
                       (object-is town-center building)
		       (objects-are medium low high QUALITATIVE_VALUE)
                       (object-is air-force-module force-module)
		       (object-is f117-squadron F117) 
                       (objects-are f15-a-squadron f15-b-squadron
                                    f15-c-squadron f15)
                       (objects-are f16-a-squadron f16-b-squadron
                                    f16-c-squadron f16)
                       (object-is dog-team1 dog-team)
                       (object-is security-police-a security-police)
                       (objects-are special-forces-a magtf-meu-gce
                                    special-force-module)
                       (objects-are airport1 airport2 airport3 airport4
                                    airport5 airport6 airport)
                       (objects-are bosnia-and-herzegovina saudi-arabia 
				    korea-south sri-lanka kuwait
                                    country)

                                  
(OBJECT-IS TOWN-CENTER1 BUILDING)
(object-is phillipine-elected-government GOVERNMENT)
(objects-are palawan mindanao portugal romania philippines country)
                       (objects-are bd1 bd2 brigade-task-force
                                    engineering-brigade 25TH-ID-DIVISION-READY-BRIGADE
                                    brigade)
                       (object-is military-police-a military-police)
                       (object-is hawka hawk-battalion)
                       (objects-are 25th-id-battalion-task-force 25th-infantry-division-light
				    6th-id infantry)
                       (object-is infantry-battalion-a infantry-battalion)

(objects-are 18th-wing 374-aw 3-wing 354-wing 355-wing air-wing)
(objects-are 49-fighter-wing 388-fighter-wing 432-fighter-wing fighter-wing)
(object-is 33-ars air-refueling-station)

(object-is malayasian-brigade enemy-ground-unit)

(object-is 45th-support-group combat-support-force)
(object-is USS-Nimitz-CVG carrier-battle-group)
(object-is USS-Vinson-CVG carrier-battle-group)
(object-is USS-Essex-CVG carrier-battle-group)
(object-is pacific-fleet fleet-group)
(object-is atlantic-fleet fleet-group)
(object-is USS-Nimitz carrier)
(object-is USS-Vinson carrier)
(object-is USS-Essex carrier)
(object-is third-fleet fleet)
(object-is fifth-fleet fleet)
(object-is sixth-fleet fleet)
(object-is seventh-fleet fleet)
(object-is US-navy navy)

(objects-are day-19 day-22 day-25 day)
(object-is kadena-airbase airport)

(object-is yokota-airbase airport)
(object-is elmendorf-afb airport)
(object-is eielson-afb airport)
(object-is misawa-airbase airport)
(object-is holloman-afb airport)
(object-is hill-afb airport)
(object-is davis-montham-afb airport)


(object-is Basa-airbase airport)
(object-is SangleyPt-airbase airport)
(object-is CubiPt-NAS airport)

(object-is Puerto-Princessa airport) ;is this really an airport?

(object-is Camp-Evangalista LOCATION)
(object-is Mactan-Intl-Aprt AIRPORT) ;should be airport
(objects-are Fort-Bonifacio Fort-Magsaysay BUILDING) ;strongpoints


(object-is schofield-barracks army-base)

(object-is C141-A C141) 
(object-is 25th-id INFANTRY)
(object-is 11-meu-soc meu-soc)
(object-is safe-haven evac-location)
(object-is johnston-atoll location)
(object-is conus location)
(objects-are alice mike sorin manuela NONCOMBATANTS)
(objects-are us-population1 us-population2 portuguese-population romanian-population POPULATION)

;(object-is malayasian-brigade brigade)

(object-is Carrier-air-wing-9 carrier-air-wing)

(object-is weapons-mass-dest-a  weapon)
(object-is weapons-mass-dest-b  weapon)
(object-is weapons-mass-dest-c  weapon)

                       (objects-are A10A-A-Squadron A10A-B-Squadron A10A-C-Squadron A10A)
		       (object-is recce-ac1 recce)
		       (object-is intel1 intel)
		       (object-is surveillance1 surveillance)
		       (object-is Sabiran-isr-capability ISR-CAPABILITY)
		       (object-is Sabiran-intel enemy-intel)
		       (object-is Sabiran-surveillance enemy-surveillance)
		       (object-is Sabiran-recce enemy-recce)

		       (object-is Sabiran-theater-ballistic-missile-elements
				  theater-ballistic-missile-elements )
                       (object-is Sabiran-surface-to-air-missles 
				  surface-to-air-missles)
                       (object-is Sabiran-reporting-post reporting-post)
		       (objects-are Awacs1 Awacs2 E3-AWACS)
		       (objects-are Sabiran-tbm-stockpile  
				    Sabiran-tbm-launcher 
				    Sabiran-tbm-support-facility  
				    Sabiran-tbm-c3 missile-element)
		       (objects-are Sabiran Monrovia Palluvia country)
		       (object-is Sabiran-Integrated-Air-Defense  
				  Integrated-Air-Defense)
		       (objects-are Sabiran-Sector-Operations-Centers 
				    Sabiran-Integrated-Operations-Centers 
				    ops-center) 

		       )
'(
    (objects-are TFS2 TFS3 TFS)
    (objects-are air-interdiction air-superiority close-air-support counter-air MISSION-NAME)
    (objects-are weapons-smuggling terrorism THREAT)
    (objects-are terrorism1 terrorism2 terrorism3 TERRORISM)
    (objects-are weapons-smuggling1 weapons-smuggling2 WEAPONS-SMUGGLING)
    (object-is town-center BUILDING)
    (object-is enemy INFANTRY)  ;10sep96
    (object-is AIR-FORCE-MODULE FORCE-MODULE) ;Need for handling DEPLOY-TFS goal.
    (objects-are F15-A-Squadron F15-B-Squadron F15-C-Squadron F15)
    (objects-are F16-A-Squadron F16-B-Squadron F16-C-Squadron F16)
    (object-is dog-team1 DOG-TEAM)
    (object-is dog-team2 DOG-TEAM)
    (object-is security-police-a SECURITY-POLICE)
    (object-is security-police-b SECURITY-POLICE)
    (objects-are special-forces-a magtf-meu-gce special-operation-force SPECIAL-FORCE-MODULE)
    (objects-are airport1 airport2 airport3 airport4 airport5 airport6 AIRPORT)
    (objects-are town-center1 town-center2 TOWN-CENTER)
    ;; Note that pacifica is identical to saudi-arabia, but nonexistent. [cox 26feb97]
    (objects-are bosnia-and-herzegovina saudi-arabia korea-south sri-lanka kuwait pacifica COUNTRY)
    (objects-are bd1 bd2 brigade-task-force engineering-brigade division-ready-brigade BRIGADE)
    (object-is military-police-a MILITARY-POLICE)
    (object-is hawka HAWK-BATTALION)
    (object-is infantry-battalion-a INFANTRY-BATTALION)
    (object-is police-a POLICE-FORCE-MODULE)
    (objects-are f15 f16 A10A TACTICAL-FIGHTER)
    )
))


;;; Defines PRODIGY-ForMAT's initial state.
(setf *state-list*
  (if FE::*JADE-demo-p*
      '((part-of f15-a-squadron tfs2)
                                  (part-of f15-b-squadron tfs2) (size tfs2 2)
                                  (part-of f16-a-squadron tfs3)
                                  (part-of f16-b-squadron tfs3)
                                  (part-of f16-c-squadron tfs3) (size tfs3 3)

;;; Added [cox 11apr98]
(part-of 45th-support-group 25th-id) ;relationship here for demo ONLY 
                                     ;45th is part of ARPAC -- it supports 25th ID
(part-of f15 18th-wing)
(part-of kc135 18th-wing)
(part-of e3 18th-wing)
(part-of F16 354-wing)
(part-of A10A 354-wing)
(part-of A10A 355-wing)
(part-of EC130H 355-wing)
(part-of C130 374-aw)
(part-of 11-meu-soc USS-Essex-CVG)

(part-of Carrier-air-wing-9 USS-Nimitz-CVG)
(part-of pacific-fleet US-navy)
(part-of atlantic-fleet US-navy)
(part-of third-fleet pacific-fleet)
(part-of fifth-fleet pacific-fleet)
(part-of sixth-fleet atlantic-fleet)
(part-of seventh-fleet pacific-fleet)

(part-of USS-Nimitz-CVG third-fleet)
(nothing)

(today-is day-19)

(is-ready A10A-A-Squadron)
(mission-of A10A-A-Squadron close-air-support)

(is-active 25th-id-battalion-task-force)
(is-available 25th-id-battalion-task-force day-19)
(is-ready 25th-id-battalion-task-force)

(is-active 18th-wing)
(is-active 374-aw)
(is-active 3-wing)
(is-active 354-wing)
(is-active 355-wing)
(is-active 45th-support-group)
(is-active USS-Nimitz-CVG)
(is-active USS-Vinson-CVG)
(is-active USS-Essex-CVG)
(is-active USS-Nimitz)
(is-active USS-Essex)
(is-active C141-A)
(is-active 25th-id)
;(is-active bd1)
(is-active 11-meu-soc)
(is-active Carrier-air-wing-9)
(is-active security-police-a)
(is-active military-police-a)
(is-active hawka)
(is-active 25th-id-division-ready-brigade)
 
 
(is-ready a10a-a-squadron) 
(is-ready a10a-b-squadron)
(is-ready a10a-c-squadron)
(is-active a10a-a-squadron) 
(is-active a10a-b-squadron)
(is-active a10a-c-squadron)
 
 
;;Need to specify which are available subsequent days.
(is-available 25th-id day-19)
(is-available 25th-infantry-division-light day-19)
(is-available 25th-id-division-ready-brigade day-19)
(is-available USS-Essex-CVG day-19)
(is-available USS-Nimitz-CVG day-19)
(is-available Carrier-air-wing-9 day-19)
(is-available 18th-wing day-19)
(is-available 374-aw day-19)
(is-available 33-ars day-19)
(is-available 3-wing day-19)
(is-available 354-wing day-19)
(is-available 432-fighter-wing day-19)
(is-available 49-fighter-wing day-19)
(is-available 388-fighter-wing day-19)
(is-available 355-wing day-19)
(is-available 11-meu-soc day-19)

(is-US-military-installation CubiPt-NAS)
(is-US-military-installation SangleyPt-airbase)
(is-enemy malayasian-brigade)
(legitimate-gov phillipine-elected-government philippines)

(loc-at 18th-wing kadena-airbase) ;day-19
(loc-at 374-aw yokota-airbase) ; day-19
(loc-at 33-ars kadena-airbase)  ;day-19
(loc-at 3-wing elmendorf-afb)  ;day-19
(loc-at 354-wing eielson-afb) ;day-19
(loc-at 432-fighter-wing misawa-airbase) ;day-19
(loc-at 49-fighter-wing holloman-afb) ;day-19
(loc-at 388-fighter-wing hill-afb) ;day-19
(loc-at 355-wing davis-montham-afb) ; day-19

(belongs-to 49-fighter-wing conus)
(belongs-to 388-fighter-wing conus)
(belongs-to 355-wing conus)

(loc-at 25th-id schofield-barracks) ; day-19


;;; Need also to provide locations for airbases e.g., kadena.
(loc-at Basa-airbase philippines)
(loc-at SangleyPt-airbase philippines)
(loc-at CubiPt-NAS philippines)

;;; Added next 2 for better replay [cox 2jun98] but them
;;; comments out because it did not work. But why??
(is-usable Mactan-Intl-Aprt)
(airport-secure-at Philippines Mactan-Intl-Aprt)

(loc-at Mactan-Intl-Aprt philippines)
(designated-location Mactan-Intl-Aprt)
(loc-at Camp-Evangalista philippines)
(designated-location Camp-Evangalista)

(province-of philippines palawan)
(province-of philippines mindanao)

(loc-at Fort-Magsaysay philippines)
(designated-strong-point Fort-Magsaysay)
(loc-at Fort-Bonifacio philippines)
(designated-strong-point Fort-Bonifacio)

(loc-at Puerto-Princessa palawan)
(near Puerto-Princessa safe-haven)
(loc-at-p mike mindanao)
(loc-at-p alice mindanao)
(loc-at-p manuela mindanao)
(loc-at-p sorin mindanao)
(loc-at-p us-population1 palawan)
(loc-at-p us-population2 palawan)
(loc-at-p portuguese-population  palawan)
(loc-at-p romanian-population palawan)
(citizen-of-US us-population1)
(citizen-of US us-population1)
(citizen-of US us-population2)
(citizen-of-US us-population2)
(citizen-of-US mike)
(citizen-of US mike)
(citizen-of US alice)
(citizen-of-US alice)

(citizen-of PORTUGAL manuela)
(citizen-of ROMANIA sorin)
(citizen-of PORTUGAL portuguese-population)
(citizen-of ROMANIA romanian-population)
(member-of ROMANIA designated-foreign-national-countries)
(member-of PORTUGAL designated-foreign-national-countries)

                                  (less-by-1 2 1) (less-by-1 1 0)
                                  (threat-at terrorism1 bosnia-and-herzegovina)
                                  (threat-at terrorism2 sri-lanka)
                                  (threat-at weapons-smuggling1 saudi-arabia)
                                  (loc-at airport1 sri-lanka)

(loc-at safe-haven palawan)
(is-usable Basa-airbase)
(airport-secure-at Philippines Basa-airbase)
(is-usable Puerto-Princessa)
(is-ready 25th-id)
(is-ready c141-a)
(isa-c141 c141-a)

(loc-at TOWN-CENTER1 MINDANAO) 
(is-deployed malayasian-brigade town-center1) 

(loc-at airport6 johnston-atoll)
(is-usable airport6)
                                  (loc-at airport2 korea-south)
                                  (loc-at airport3 saudi-arabia)
                                  (loc-at airport4 bosnia-and-herzegovina)
                                  (loc-at airport5 kuwait)
                                  (loc-at town-center bosnia-and-herzegovina)
                                  (mission-of f15-a-squadron air-interdiction)
                                  (mission-of f15-b-squadron air-interdiction)
                                  (mission-of f15-c-squadron air-interdiction)
                                  (is-usable airport1) (is-usable airport2)
                                  (is-usable airport3) (is-usable airport4)
                                  (is-ready security-police-a)
                                  (is-ready special-forces-a)
                                  (is-ready 11-meu-soc)
				   (is-ready magtf-meu-gce)
                                  (is-ready dog-team1) (is-ready hawka)
                                  (is-ready bd1) (is-ready bd2)
                                  (is-ready military-police-a)
				  (has-value Awacs1 high)
				  (has-value Awacs2 high)
				  (has-value f15-a-squadron medium)
(has-value  weapons-mass-dest-a medium)
(has-value  weapons-mass-dest-b high)
(has-value  weapons-mass-dest-c high)
				  (loc-at Awacs1 Sabiran)
                                  (loc-at Awacs2 Sabiran)
                                  (loc-at f15-a-squadron Sabiran)
                                  (is-ready f15-a-squadron)
                                  (is-ready f15-b-squadron)
                                  (is-ready f15-c-squadron)
                                  (is-ready f16-a-squadron)
                                  (is-ready f16-b-squadron)
                                  (is-ready f16-c-squadron)
                                  (is-ready 25th-infantry-division-light)
                                  (is-ready infantry-battalion-a)
                                  (is-ready brigade-task-force)
                                  (is-ready engineering-brigade)
                                  (is-ready 25TH-ID-DIVISION-READY-BRIGADE)
(loc-at infantry-battalion-a Sabiran)
(loc-at weapons-mass-dest-a Sabiran)
(loc-at weapons-mass-dest-b Sabiran)
(loc-at weapons-mass-dest-c Sabiran)
				  (loc-at Sabiran-isr-capability Sabiran)
				  (is-ready recce-ac1)
				  (is-ready intel1)
				  (is-ready surveillance1)


(is-target weapons-mass-dest-a)
(is-target weapons-mass-dest-b)
(is-target weapons-mass-dest-c)
				  (is-target Sabiran-intel)
				  (is-target Sabiran-surveillance)
				  (is-target Sabiran-recce)
				  (loc-at Sabiran-intel  Sabiran)
				  (loc-at Sabiran-surveillance Sabiran)
				  (loc-at Sabiran-recce  Sabiran)

				  (is-target Sabiran-Integrated-Air-Defense)
				  (loc-at Sabiran-Integrated-Air-Defense 
					  Sabiran)
				  (airthreat-exists-near 
				   Sabiran-Integrated-Air-Defense)

				  (part-of Sabiran-reporting-post 
					   Sabiran-Integrated-Air-Defense)
				  (loc-at Sabiran-reporting-post Sabiran)
				  (airthreat-exists-near 
				   Sabiran-reporting-post)

				  (part-of Sabiran-surface-to-air-missles 
					   Sabiran-Integrated-Air-Defense)
				  (loc-at Sabiran-surface-to-air-missles 
					  Sabiran)
				  (airthreat-exists-near 
				   Sabiran-surface-to-air-missles)

				  (part-of Sabiran-Sector-Operations-Centers
					   Sabiran-Integrated-Air-Defense)
				  (loc-at Sabiran-Sector-Operations-Centers 
					  Sabiran)
				  (airthreat-exists-near 
				   Sabiran-Sector-Operations-Centers)

				  (loc-at Sabiran-Integrated-Operations-Centers 
					  Sabiran)
				  (part-of Sabiran-Integrated-Operations-Centers 
					   Sabiran-Integrated-Air-Defense)
				  (airthreat-exists-near 
				   Sabiran-Integrated-Operations-Centers)


				  (is-target 
				   Sabiran-theater-ballistic-missile-elements)

				  (near Sabiran-theater-ballistic-missile-elements 
					Sabiran-Integrated-Air-Defense)
				  (near Sabiran-Integrated-Air-Defense 
					Sabiran-theater-ballistic-missile-elements)
				  (loc-at Sabiran-theater-ballistic-missile-elements 
					  Sabiran)
				  (loc-at Sabiran-tbm-stockpile Sabiran)
				  (loc-at Sabiran-tbm-launcher Sabiran)
				  (loc-at Sabiran-tbm-c3 Sabiran)
				  (loc-at Sabiran-tbm-support-facility Sabiran)
				  )
'(
    (part-of F15-A-Squadron TFS2)
    (part-of F15-B-Squadron TFS2)
    (group-type TFS2 F15)
    (size TFS2 2)
    (part-of F16-A-Squadron TFS3)
    (part-of F16-B-Squadron TFS3)
    (part-of F16-C-Squadron TFS3)
    (group-type TFS2 F16)
    (size TFS3 3)
    (less-by-1 2 1)
    (less-by-1 1 0)
    (threat-at terrorism1 bosnia-and-herzegovina)
    (threat-at terrorism3 korea-south)
    (threat-at terrorism2 sri-lanka)
    (threat-at weapons-smuggling1 saudi-arabia)
    (threat-at weapons-smuggling2 pacifica)
    (loc-at airport1 sri-lanka)
    (loc-at airport2 korea-south)
    (loc-at airport3 saudi-arabia)
    (loc-at airport4 bosnia-and-herzegovina)
    (loc-at airport5 kuwait)
    (loc-at airport6 pacifica)
    (loc-at town-center1 bosnia-and-herzegovina)
    (is-enemy enemy)
    (is-deployed enemy town-center1)  ;10sep96
    (near airport4 town-center1)  ;10sep96
    (loc-at town-center2 korea-south)
    (mission-of F15-A-Squadron air-interdiction)
    (mission-of F15-B-Squadron air-interdiction)
    (mission-of F15-C-Squadron air-interdiction)
    (is-usable airport1)
    (is-usable airport2)
    (is-usable airport3)
    (is-usable airport4)
    (is-usable airport5)
    (is-usable airport6)
    (is-ready police-a)
    (is-ready security-police-a)
    (is-ready security-police-b)
    (is-ready special-forces-a)
    (is-ready special-operation-force)
    (is-ready magtf-meu-gce)
    (is-ready dog-team1)
    (is-ready dog-team2)
    (is-ready hawka)
    (is-ready bd1)
    (is-ready bd2)
    (is-ready military-police-a)
    (is-ready A10A-B-Squadron)
    (is-ready A10A-C-Squadron)
    (mission-of A10A-B-Squadron close-air-support)
    (mission-of A10A-C-Squadron close-air-support)
    (is-ready F15-A-Squadron)
    (is-ready F15-B-Squadron)
    (is-ready F15-C-Squadron)
    (is-ready F16-A-Squadron)
    (is-ready F16-B-Squadron)
    (is-ready F16-C-Squadron)
    (is-ready 25th-infantry-division-light)
    (is-ready infantry-battalion-a)
    (is-ready brigade-task-force)
    (is-ready engineering-brigade)
    (is-ready division-ready-brigade)
    )
))



(setf *goal-list*
  (if FE::*JADE-demo-p*
      '(and (IS-EVACUATED 11-MEU-SOC PHILIPPINES) 
	    (REMOVED-FROM-LOC 11-MEU-SOC PHILIPPINES US-POPULATION1)
	    (REMOVED-FROM-LOC 11-MEU-SOC PHILIPPINES US-POPULATION2)
	    (REMOVED-FROM-LOC 11-MEU-SOC PHILIPPINES PORTUGUESE-POPULATION)
	    (IS-PROTECTED-AND-DEFENDED PHILIPPINES)
	    (IS-DEFENDED PHILIPPINES)
	    (IS-PROTECTED PHILIPPINES)
	    (LAW-ABIDING PHILIPPINES)
	    (IS-ASSISTED PHILIPPINES PHILLIPINE-ELECTED-GOVERNMENT)
	    (AIRPORT-SECURE-AT PHILIPPINES MACTAN-INTL-APRT)
	    (IS-DEPLOYED SECURITY-POLICE-A PHILIPPINES)
	    (SAFE-US-PERSONNEL PHILIPPINES)
	    (IS-DEPLOYED 25TH-ID-DIVISION-READY-BRIGADE PHILIPPINES)
	    (IS-DEPLOYED MILITARY-POLICE-A PHILIPPINES)
	    (IS-SOVEREIGN PHILIPPINES 11-MEU-SOC)
	    (AIR-DEFENDED PHILIPPINES 355-WING)
	    (AIR-BLOCKADED PHILIPPINES CARRIER-AIR-WING-9)
	    (NAVAL-BLOCKADED PHILIPPINES USS-NIMITZ-CVG))
    '(AND 
    (exists ((<h> hawk-battalion)) (is-deployed <h> pacifica))
    (is-deployed division-ready-brigade pacifica)
    (AIRPORT-SECURE-AT KOREA-SOUTH)
;    (is-secure town-center1)
;    (IS-DEPLOYED BRIGADE-TASK-FORCE SAUDI-ARABIA)
    (EXISTS ((<SECURITY-POLICE.920> SECURITY-POLICE)) (IS-DEPLOYED <SECURITY-POLICE.920> pacifica))
    (exists ((<A10A.12396> A10A)) (IS-DEPLOYED <A10A.12396> pacifica))
;    (EXISTS ((<DOG-TEAM.920> DOG-TEAM)) (IS-DEPLOYED <DOG-TEAM.920> KOREA-SOUTH))
;    (EXISTS ((<SECURITY-POLICE.920> SECURITY-POLICE)) (IS-DEPLOYED <SECURITY-POLICE.920> KOREA-SOUTH))
;    (IS-DEPLOYED BRIGADE-TASK-FORCE KOREA-SOUTH)
;    (IS-DEPLOYED SPECIAL-OPERATION-FORCE KOREA-SOUTH)
; Current    (exists ((<T.323> TERRORISM)) (IS-SUPPRESSED <T.323> KOREA-SOUTH))
;    (EXISTS ((<AIRCRAFT.920> AIRCRAFT)) (IS-DEPLOYED <AIRCRAFT.920> KOREA-SOUTH))
;    (AIRPORT-SECURE-AT KOREA-SOUTH)
;'(and
;    (group-deployed BOSNIA-AND-HERZEGOVINA F15 2)
;    (is-deployed TFS2 BOSNIA-AND-HERZEGOVINA)
;    (is-deployed dog-team1 BOSNIA-AND-HERZEGOVINA)
;    (is-deployed A10A-A-Squadron BOSNIA-AND-HERZEGOVINA)
;    (exists ((<h> hawk-battalion)) (is-deployed <h> saudi-arabia))
;    (is-deployed division-ready-brigade saudi-arabia)
;    )

    )))


