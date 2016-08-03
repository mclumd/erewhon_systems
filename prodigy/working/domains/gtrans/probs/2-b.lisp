;;; To win the battle in the area of the airport, friendly forces must make 
;;; ineffective  all enemy present. Because of local residents are near enemy1, 
;;; they must be cutoff, whereas enemy2 can be destroyed. 
;;;
;;; NOTE that if the goal was to win the battle at town-center2, then no steps 
;;; need to be executed (other than inference rules) to succeed. There are no 
;;; enemy at town-center2 and so the forall clause in inference rule 
;;; DEFEAT-ALL-ENEMY is true by default.
;;;
;;; By un-commenting the impossible precondition, the user can force a lowering
;;; of expectations (goal-erosion transmutation).
;;;
(SETF (CURRENT-PROBLEM)
      (CREATE-PROBLEM (NAME ONE-BRIDGE.1)
                      (OBJECTS 
;		       (OBJECTS-ARE TFS2 TFS3 TFS)
			       (object-is town1 town)
;                       (OBJECTS-ARE AIR-INTERDICTION AIR-SUPERIORITY
;                                    CLOSE-AIR-SUPPORT COUNTER-AIR MISSION-NAME)
;                       (OBJECTS-ARE WEAPONS-SMUGGLING TERRORISM THREAT)
;                       (OBJECTS-ARE TERRORISM1 TERRORISM2 TERRORISM3 TERRORISM)
;                       (OBJECT-IS WEAPONS-SMUGGLING1 WEAPONS-SMUGGLING)
;                       (OBJECT-IS TOWN-CENTER BUILDING)
;                       (OBJECTS-ARE ENEMY1 ENEMY2 INFANTRY)
;                       (OBJECT-IS AIR-FORCE-MODULE FORCE-MODULE)
                       (OBJECT-is
;			F15-A-SQUADRON F15-B-SQUADRON
			F151
                                    F15)
;                       (OBJECTS-ARE F16-A-SQUADRON F16-B-SQUADRON F16-C-SQUADRON
;                                    F16)
;                       (OBJECTS-ARE A10A-A-SQUADRON A10A-B-SQUADRON
;                                    A10A-C-SQUADRON A10A)
;                       (OBJECT-IS DOG-TEAM1 DOG-TEAM)
;                       (OBJECT-IS DOG-TEAM2 DOG-TEAM)
;                       (OBJECT-IS SECURITY-POLICE-A SECURITY-POLICE)
;                       (OBJECT-IS SECURITY-POLICE-B SECURITY-POLICE)
;                       (OBJECTS-ARE SPECIAL-FORCES-A MAGTF-MEU-GCE
;                                    SPECIAL-OPERATION-FORCE
;                                    SPECIAL-FORCE-MODULE)
                       (OBJECTS-ARE AIRPORT2 AIRPORT1 
                                    AIRPORT)
;                       (OBJECTS-ARE TOWN-CENTER1 TOWN-CENTER2 TOWN-CENTER)
;                       (OBJECT-is
;			BOSNIA-AND-HERZEGOVINA SAUDI-ARABIA
;			KOREA-SOUTH 
;				    SRI-LANKA KUWAIT
;                                    COUNTRY)
;                       (OBJECTS-ARE BD1 BD2 BRIGADE-TASK-FORCE
;                                    ENGINEERING-BRIGADE DIVISION-READY-BRIGADE
;                                    BRIGADE)
;                       (OBJECT-IS MILITARY-POLICE-A MILITARY-POLICE)
;                       (OBJECT-IS HAWKA HAWK-BATTALION)
;                       (OBJECT-IS 25TH-INFANTRY-DIVISION-LIGHT INFANTRY)
                       (OBJECT-IS INFANTRY1 INFANTRY)
                       (OBJECT-IS POLICE1 POLICE)
                       (OBJECT-IS F15 
;				    F16 
				    TACTICAL-FIGHTER)
;		       (Object-is Local-Residents NONCOMBATANTS)
		       (Object-is ford1 FORD)
		       (Object-is River1 RIVER)
		       (Objects-are bridge1 bridge2 BRIDGE)
		       )
                      (STATE (AND 
;			      (nothing)
;				  (impossible-precondition)
				  (enables-movement-over bridge1 River1)
				  (enables-movement-over bridge2 River1)
;				  (enables-movement-over ford1 Yalu)
				  (near airport2 River1)
				  (near airport1 River1)
                                  (LESS-BY-1 2 1) (LESS-BY-1 1 0)
				  (more-than decisive-victory marginal-victory)
				  (more-than marginal-victory stalemate)
				  (more-than stalemate marginal-defeat)
				  (more-than marginal-defeat decisive-defeat)
;                                  (LOC-AT AIRPORT5 KUWAIT)
;                                  (LOC-AT TOWN-CENTER2 KOREA-SOUTH)
;                                  (MISSION-OF F15-A-SQUADRON AIR-INTERDICTION)
;                                  (MISSION-OF F15-B-SQUADRON AIR-INTERDICTION)
;                                  (MISSION-OF F151 AIR-INTERDICTION)
                                  (IS-USABLE AIRPORT2) (IS-USABLE AIRPORT1)
;                                  (IS-USABLE AIRPORT3) (IS-USABLE AIRPORT4)
					;                                  (IS-USABLE AIRPORT5) 
				  (IS-READY POLICE1)
 ;                                 (IS-READY SECURITY-POLICE-A)
;                                  (IS-READY SECURITY-POLICE-B)
;                                  (IS-READY SPECIAL-FORCES-A)
;                                  (IS-READY SPECIAL-OPERATION-FORCE)
;                                  (IS-READY MAGTF-MEU-GCE) 
;				  (IS-READY DOG-TEAM1)
;                                  (IS-READY DOG-TEAM2) 
;				  (IS-READY HAWKA)
;                                  (IS-READY BD1) (IS-READY BD2)
;                                  (IS-READY MILITARY-POLICE-A)
;                                  (IS-READY A10A-A-SQUADRON)
;                                  (IS-READY A10A-B-SQUADRON)
;                                  (IS-READY A10A-C-SQUADRON)
;                                  (MISSION-OF A10A-A-SQUADRON CLOSE-AIR-SUPPORT)
;                                  (MISSION-OF A10A-B-SQUADRON CLOSE-AIR-SUPPORT)
;                                  (MISSION-OF A10A-C-SQUADRON CLOSE-AIR-SUPPORT)
;                                  (IS-READY F15-A-SQUADRON)
;                                  (IS-READY F15-B-SQUADRON)
                                  (IS-READY F151)
                                  (IS-READY INFANTRY1)
				  ))
                      (GOAL (AND (outcome-restricts-movement River1)
				 (is-deployed f151 airport2)))))


