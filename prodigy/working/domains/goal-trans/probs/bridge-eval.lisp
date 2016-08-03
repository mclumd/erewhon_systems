;;;
;;; Need to vary rivers and the associated bridges (3 for each river). Each
;;; river needs (near airport2 <river>) predicate. Each bridge needs
;;; enables-movement-over river. Rivers vary as to number of goals. 
;;;
;;; Need to vary number of F15s. For each f15 need to add (is-ready <f15>)
;;; predicate. Also each needs (mission-of <air-force> air-interdiction). See
;;; function setup-experiment in test-battery.lisp file.
;;;

;;;
;;; Three crossings over the Yalu, 3 F15 squadrons, one not ready.
;;;
;;; Added airport6: a second airport in korea near the yalu (notice that
;;; airports in south korea are not really near the Yalu which is at the very
;;; north of north korea :-), but one that is NOT usable although secure. New
;;; info will determine it usable. Now because airport2 is usable but not
;;; secure, in the middle of planning to make it secure the new info (i.e.,
;;; airport6 is now usable) arrives. Because the alternative binding (to deploy
;;; the fighter squadron to airport6 instead of airport2) has all of its
;;; preconditions satisfied, we need to change the plan in mid-stream. [19nov97
;;; cox]
;;;
;;; Can also handle the new info that airport2 suddenly becomes secure while
;;; planning for it to become secure. Still need to handle the case when the
;;; secure op has already been moved to the head plan along with the three
;;; sends. [23nov97 cox]
;;;
(SETF (CURRENT-PROBLEM)
      (CREATE-PROBLEM (NAME GTRANS-EVAL)
                      (OBJECTS 
                       (OBJECTS-ARE AIR-INTERDICTION AIR-SUPERIORITY
                                    CLOSE-AIR-SUPPORT COUNTER-AIR MISSION-NAME)
                       (OBJECTS-ARE WEAPONS-SMUGGLING TERRORISM THREAT)
                       (OBJECTS-ARE TERRORISM1 TERRORISM2 TERRORISM3 TERRORISM)
                       (OBJECT-IS WEAPONS-SMUGGLING1 WEAPONS-SMUGGLING)
                       (OBJECT-IS TOWN-CENTER BUILDING)
                       (OBJECTS-ARE ENEMY1 ENEMY2 INFANTRY)
                       (OBJECT-IS AIR-FORCE-MODULE FORCE-MODULE)
                       (OBJECTS-ARE F15-A-SQUADRON F15-B-SQUADRON ;F15-C-SQUADRON
                                    F15)
                       (OBJECTS-ARE F16-A-SQUADRON F16-B-SQUADRON F16-C-SQUADRON
                                    F16)
                       (OBJECTS-ARE A10A-A-SQUADRON A10A-B-SQUADRON
                                    A10A-C-SQUADRON A10A)
                       (OBJECT-IS DOG-TEAM1 DOG-TEAM)
                       (OBJECT-IS DOG-TEAM2 DOG-TEAM)
                       (OBJECT-IS SECURITY-POLICE-A SECURITY-POLICE)
                       (OBJECT-IS SECURITY-POLICE-B SECURITY-POLICE)
                       (OBJECTS-ARE SPECIAL-FORCES-A MAGTF-MEU-GCE
                                    SPECIAL-OPERATION-FORCE
                                    SPECIAL-FORCE-MODULE)
                       (OBJECTS-ARE AIRPORT1 AIRPORT6 AIRPORT3 AIRPORT4 AIRPORT5 AIRPORT2
                                    AIRPORT)
                       (OBJECTS-ARE TOWN-CENTER1 TOWN-CENTER2 TOWN-CENTER)
                       (OBJECTS-ARE BOSNIA-AND-HERZEGOVINA SAUDI-ARABIA KOREA-SOUTH SRI-LANKA KUWAIT
                                    COUNTRY)
                       (OBJECTS-ARE BD1 BD2 BRIGADE-TASK-FORCE
                                    ENGINEERING-BRIGADE DIVISION-READY-BRIGADE
                                    BRIGADE)
                       (OBJECT-IS MILITARY-POLICE-A MILITARY-POLICE)
                       (OBJECT-IS HAWKA HAWK-BATTALION)
                       (OBJECT-IS 25TH-INFANTRY-DIVISION-LIGHT INFANTRY)
                       (OBJECT-IS INFANTRY-BATTALION-A INFANTRY-BATTALION)
                       (OBJECT-IS POLICE-A POLICE-FORCE-MODULE)
                       (OBJECTS-ARE F15 F16 TACTICAL-FIGHTER)
		       (Object-is Local-Residents NONCOMBATANTS)
		       (Object-is ford1 FORD)
		       (Object-is Yalu RIVER)
		       (Objects-are bridge1 bridge2 BRIDGE)
		       )
                      (STATE (AND (nothing)
				  (enables-movement-over bridge1 Yalu)
				  (enables-movement-over bridge2 Yalu)
				  ;;Comment out the following to enable
				  ;;planning without lowering expectation of
				  ;;achieving top-level goal.
;				  (enables-movement-over ford1 Yalu)
				  (near airport2 Yalu)
				  (near airport6 Yalu)
				  (PART-OF F15-A-SQUADRON TFS2)
                                  (PART-OF F15-B-SQUADRON TFS2)
                                  (GROUP-TYPE TFS2 F15) (SIZE TFS2 2)
                                  (PART-OF F16-A-SQUADRON TFS3)
                                  (PART-OF F16-B-SQUADRON TFS3)
                                  (PART-OF F16-C-SQUADRON TFS3)
                                  (GROUP-TYPE TFS2 F16) (SIZE TFS3 3)
                                  (LESS-BY-1 2 1) (LESS-BY-1 1 0)
                                  (THREAT-AT TERRORISM1 BOSNIA-AND-HERZEGOVINA)
                                  (THREAT-AT TERRORISM3 KOREA-SOUTH)
                                  (THREAT-AT TERRORISM2 SRI-LANKA)
                                  (THREAT-AT WEAPONS-SMUGGLING1 SAUDI-ARABIA)
                                  (LOC-AT AIRPORT1 SRI-LANKA)
                                  (LOC-AT AIRPORT2 KOREA-SOUTH)
                                  (LOC-AT AIRPORT6 KOREA-SOUTH)
                                  (LOC-AT AIRPORT3 SAUDI-ARABIA)
                                  (LOC-AT AIRPORT4 BOSNIA-AND-HERZEGOVINA)
                                  (LOC-AT TOWN-CENTER1 BOSNIA-AND-HERZEGOVINA) 
;				  (near Local-Residents Enemy1)
				  (IS-ENEMY ENEMY1)
				  (IS-ENEMY ENEMY2)
                                  (IS-DEPLOYED ENEMY1 TOWN-CENTER1)
                                  (IS-DEPLOYED ENEMY2 TOWN-CENTER1)
                                  (NEAR AIRPORT4 TOWN-CENTER1)
				  (more-than decisive-victory marginal-victory)
				  (more-than marginal-victory stalemate)
				  (more-than stalemate marginal-defeat)
				  (more-than marginal-defeat decisive-defeat)
                                  (LOC-AT AIRPORT5 KUWAIT)
                                  (LOC-AT TOWN-CENTER2 KOREA-SOUTH)
                                  (MISSION-OF F15-A-SQUADRON AIR-INTERDICTION)
                                  (MISSION-OF F15-B-SQUADRON AIR-INTERDICTION)
;                                  (MISSION-OF F15-C-SQUADRON AIR-INTERDICTION)
                                  (IS-USABLE AIRPORT1) (IS-USABLE AIRPORT2)
                                  (IS-USABLE AIRPORT3) (IS-USABLE AIRPORT4)
                                  (IS-USABLE AIRPORT5) 
				  (airport-secure-at korea-south airport6)
				  (IS-READY POLICE-A)
                                  (IS-READY SECURITY-POLICE-A)
                                  (IS-READY SECURITY-POLICE-B)
                                  (IS-READY SPECIAL-FORCES-A)
                                  (IS-READY SPECIAL-OPERATION-FORCE)
                                  (IS-READY MAGTF-MEU-GCE) (IS-READY DOG-TEAM1)
                                  (IS-READY DOG-TEAM2) (IS-READY HAWKA)
                                  (IS-READY BD1) (IS-READY BD2)
                                  (IS-READY MILITARY-POLICE-A)
                                  (IS-READY A10A-A-SQUADRON)
                                  (IS-READY A10A-B-SQUADRON)
                                  (IS-READY A10A-C-SQUADRON)
                                  (MISSION-OF A10A-A-SQUADRON CLOSE-AIR-SUPPORT)
                                  (MISSION-OF A10A-B-SQUADRON CLOSE-AIR-SUPPORT)
                                  (MISSION-OF A10A-C-SQUADRON CLOSE-AIR-SUPPORT)
                                  (IS-READY F15-A-SQUADRON)
                                  (IS-READY F15-B-SQUADRON)
;                                  (IS-READY F15-C-SQUADRON)
                                  (IS-READY F16-A-SQUADRON)
                                  (IS-READY F16-B-SQUADRON)
                                  (IS-READY F16-C-SQUADRON)
                                  (IS-READY 25TH-INFANTRY-DIVISION-LIGHT)
                                  (IS-READY INFANTRY-BATTALION-A)
                                  (IS-READY BRIGADE-TASK-FORCE)
                                  (IS-READY ENGINEERING-BRIGADE)
                                  (IS-READY DIVISION-READY-BRIGADE)))
                      (GOAL (AND (outcome impassable Yalu)))))