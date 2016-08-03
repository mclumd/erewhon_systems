(setf (current-problem)
      (create-problem (name PlanB)
                      (objects (OBJECT-IS 25TH-INFANTRY-DIVISION-LIGHT INFANTRY)
;			       (object-is USS-Essex-CVG carrier-battle-group)
			       (objects-are A10A-A-Squadron A10A-B-Squadron A10A-C-Squadron A10A)
			       (OBJECT-IS ENEMY enemy-ground-unit)
			       (OBJECTS-ARE SPECIAL-FORCES-A MAGTF-MEU-GCE SPECIAL-OPERATION-FORCE SPECIAL-FORCE-MODULE)
			       (OBJECTS-ARE TFS2 TFS3 GROUP-UNIT)
					; (OBJECTS-ARE TFS2 TFS3 TFS)
			       (OBJECTS-ARE AIR-INTERDICTION AIR-SUPERIORITY CLOSE-AIR-SUPPORT COUNTER-AIR MISSION-NAME)
			       (OBJECTS-ARE WEAPONS-SMUGGLING TERRORISM THREAT)
			       (OBJECTS-ARE TERRORISM1 TERRORISM2 TERRORISM3 TERRORISM)
			       (OBJECTS-ARE WEAPONS-SMUGGLING1 WEAPONS-SMUGGLING2 WEAPONS-SMUGGLING)
			       (OBJECT-IS AIR-FORCE-MODULE FORCE-MODULE)
			       (OBJECTS-ARE F15-A-SQUADRON F15-B-SQUADRON F15-C-SQUADRON F15)
			       (OBJECTS-ARE F16-A-SQUADRON F16-B-SQUADRON F16-C-SQUADRON F16)
			       (OBJECT-IS DOG-TEAM1 DOG-TEAM) (OBJECT-IS DOG-TEAM2 DOG-TEAM)
			       (OBJECT-IS SECURITY-POLICE-A SECURITY-POLICE)
			       (OBJECT-IS SECURITY-POLICE-B SECURITY-POLICE)
			       (OBJECTS-ARE AIRPORT1 AIRPORT2 AIRPORT3 AIRPORT4 AIRPORT5 AIRPORT6 AIRPORT)
			       (OBJECTS-ARE TOWN-CENTER1 TOWN-CENTER2 TOWN-CENTER)
			       (OBJECTS-ARE BOSNIA-AND-HERZEGOVINA SAUDI-ARABIA KOREA-SOUTH SRI-LANKA KUWAIT PACIFICA COUNTRY)
			       (OBJECTS-ARE BD1 BD2 BRIGADE-TASK-FORCE ENGINEERING-BRIGADE DIVISION-READY-BRIGADE BRIGADE)
			       (OBJECT-IS MILITARY-POLICE-A MILITARY-POLICE)
			       (OBJECT-IS HAWKA HAWK-BATTALION)
			       (OBJECT-IS INFANTRY-BATTALION-A INFANTRY-BATTALION)
			       (OBJECT-IS POLICE-A POLICE-FORCE-MODULE)
			       (OBJECTS-ARE F15 F16 A10A TACTICAL-FIGHTER))
;		      (objects (object-is tfs2 group-unit)
;                       (object-is tfs3 group-unit)
;                       (objects-are air-interdiction air-superiority
;                                    close-air-support mission-name)
;                       (objects-are weapons-smuggling terrorism threat)
;                       (objects-are terrorism1 terrorism2 terrorism)
;                       (object-is weapons-smuggling1 weapons-smuggling)
;                       (object-is town-center building)
;                       (object-is air-force-module force-module)
;                       (objects-are f15-a-squadron f15-b-squadron
;                                    f15-c-squadron f15)
;                       (objects-are f16-a-squadron f16-b-squadron
;                                    f16-c-squadron f16)
;                       (object-is dog-team1 dog-team)
;                       (object-is security-police-a security-police)
;                       (objects-are special-forces-a magtf-meu-gce
;                                    special-force-module)
;                       (objects-are airport1 airport2 airport3 airport4
;                                    airport5 airport)
;                       (objects-are bosnia saudi-arabia korea sri-lanka kuwait
;                                    country)
;                       (objects-are bd1 bd2 brigade-task-force
;                                    engineering-brigade division-ready-brigade
;                                    brigade)
;                       (object-is military-police-a military-police)
;                       (object-is hawka hawk-battalion)
;                       (object-is 25th-infantry-division-light infantry)
;                       (object-is infantry-battalion-a infantry-battalion))
                      (state (AND (IS-ACTIVE HAWKA)
				  (IS-ACTIVE SPECIAL-FORCES-A)
				  (IS-ACTIVE MAGTF-MEU-GCE)
				  (is-active A10A-A-SQUADRON)
				  (is-active A10A-B-SQUADRON)
				  (is-active A10A-C-SQUADRON)
				  (is-active DIVISION-READY-BRIGADE)
				  (is-active ENGINEERING-BRIGADE)
				  (is-active BRIGADE-TASK-FORCE)
				  (is-active BD2)
				  (is-active DOG-TEAM1)
				  (is-active DOG-TEAM2)
				  (is-active SPECIAL-OPERATION-FORCE)
				  (is-active bd1)
				  (is-active division-ready-brigade)
				  (is-active SECURITY-POLICE-A)
				  (is-active SECURITY-POLICE-B)
				  (PART-OF F15-A-SQUADRON TFS2)
				  (PART-OF F15-B-SQUADRON TFS2)
				  (GROUP-TYPE TFS2 F15)
				  (SIZE TFS2 2)
				  (PART-OF F16-A-SQUADRON TFS3)
				  (PART-OF F16-B-SQUADRON TFS3)
				  (PART-OF F16-C-SQUADRON TFS3)
 
				  (GROUP-TYPE TFS2 F16)
				  (SIZE TFS3 3)
				  (LESS-BY-1 2 1)
				  (LESS-BY-1 1 0)
				  (THREAT-AT TERRORISM1 BOSNIA-AND-HERZEGOVINA)
				  (THREAT-AT TERRORISM3 KOREA-SOUTH)
				  (THREAT-AT TERRORISM2 SRI-LANKA)
				  (THREAT-AT WEAPONS-SMUGGLING1 SAUDI-ARABIA)
				  (THREAT-AT WEAPONS-SMUGGLING2 PACIFICA)
				  (LOC-AT AIRPORT1 SRI-LANKA)
				  (LOC-AT AIRPORT2 KOREA-SOUTH)
				  (LOC-AT AIRPORT3 SAUDI-ARABIA)
				  (LOC-AT AIRPORT4 BOSNIA-AND-HERZEGOVINA)
				  (LOC-AT AIRPORT5 KUWAIT)
				  (LOC-AT AIRPORT6 PACIFICA)
 
				  (LOC-AT TOWN-CENTER1 BOSNIA-AND-HERZEGOVINA)
				  (IS-ENEMY ENEMY)
				  (IS-DEPLOYED ENEMY TOWN-CENTER1)
				  (NEAR AIRPORT4 TOWN-CENTER1)
 
				  (LOC-AT TOWN-CENTER2 KOREA-SOUTH)
				  (MISSION-OF F15-A-SQUADRON AIR-INTERDICTION)
				  (MISSION-OF F15-B-SQUADRON AIR-INTERDICTION)
				  (MISSION-OF F15-C-SQUADRON AIR-INTERDICTION)
				  (IS-USABLE AIRPORT1)
				  (IS-USABLE AIRPORT2)
				  (IS-USABLE AIRPORT3)
				  (IS-USABLE AIRPORT4)
				  (IS-USABLE AIRPORT5)
				  (IS-USABLE AIRPORT6)

				  (IS-READY POLICE-A)
				  (IS-READY SECURITY-POLICE-A)
				  (IS-READY SECURITY-POLICE-B)
				  (IS-READY SPECIAL-FORCES-A)
 
				  (IS-READY SPECIAL-OPERATION-FORCE)
				  (IS-READY MAGTF-MEU-GCE)
				  (IS-READY DOG-TEAM1)
				  (IS-READY DOG-TEAM2)
				  (IS-READY HAWKA)
				  (IS-READY BD1)
				  (IS-READY BD2)
 
				  (IS-READY MILITARY-POLICE-A)
				  (IS-active MILITARY-POLICE-A)

				  (IS-READY A10A-A-SQUADRON)
				  (IS-READY A10A-B-SQUADRON)
				  (IS-READY A10A-C-SQUADRON)
				  (MISSION-OF A10A-B-SQUADRON CLOSE-AIR-SUPPORT)
 
				  (MISSION-OF A10A-C-SQUADRON CLOSE-AIR-SUPPORT)

				  (IS-READY F15-A-SQUADRON)
				  (IS-READY F15-B-SQUADRON)
				  (IS-READY F15-C-SQUADRON)
				  (IS-active F15-A-SQUADRON)
				  (IS-active F15-B-SQUADRON)
				  (IS-active F15-C-SQUADRON)

				  (IS-READY F16-A-SQUADRON)
				  (IS-READY F16-B-SQUADRON)
				  (IS-READY F16-C-SQUADRON)
				  (IS-active F16-A-SQUADRON)
				  (IS-active F16-B-SQUADRON)
				  (IS-active F16-C-SQUADRON)

				  (IS-READY 25TH-INFANTRY-DIVISION-LIGHT)
				  (IS-READY INFANTRY-BATTALION-A)
				  (IS-active INFANTRY-BATTALION-A)
				  (IS-READY BRIGADE-TASK-FORCE)
 
				  (IS-READY ENGINEERING-BRIGADE)
				  (IS-READY DIVISION-READY-BRIGADE))
;			     (and (part-of f15-a-squadron tfs2)
;                                  (part-of f15-b-squadron tfs2) (size tfs2 2)
;                                  (part-of f16-a-squadron tfs3)
;                                  (part-of f16-b-squadron tfs3)
;                                  (part-of f16-c-squadron tfs3) (size tfs3 3)
;                                  (less-by-1 2 1) (less-by-1 1 0)
;                                  (threat-at terrorism1 bosnia)
;                                  (threat-at terrorism2 sri-lanka)
;                                  (threat-at weapons-smuggling1 saudi-arabia)
;                                  (loc-at airport1 sri-lanka)
;                                  (loc-at airport2 korea)
;                                  (loc-at airport3 saudi-arabia)
;                                  (loc-at airport4 bosnia)
;                                  (loc-at airport5 kuwait)
;                                  (loc-at town-center bosnia)
;                                  (mission-of f15-a-squadron air-interdiction)
;                                  (mission-of f15-b-squadron air-interdiction)
;                                  (mission-of f15-c-squadron air-interdiction)
;                                  (is-usable airport1) (is-usable airport2)
;                                  (is-usable airport3) (is-usable airport4)
;                                  (is-ready security-police-a)
;                                  (is-ready special-forces-a)
;                                  (is-ready magtf-meu-gce)
;                                  (is-ready dog-team1) (is-active hawka) (is-ready hawka)
;                                  (is-ready bd1) (is-ready bd2)
;                                  (is-ready military-police-a)
;                                  (is-ready f15-a-squadron)
;                                  (is-ready f15-b-squadron)
;                                  (is-ready f15-c-squadron)
;                                  (is-ready f16-a-squadron)
;                                  (is-ready f16-b-squadron)
;                                  (is-ready f16-c-squadron)
;                                  (is-ready 25th-infantry-division-light)
;                                  (is-ready infantry-battalion-a)
;                                  (is-ready brigade-task-force)
;                                  (is-ready engineering-brigade)
;                                  (is-ready division-ready-brigade))
)
                      (goal (and (is-deployed hawka
                                   saudi-arabia)
;				 (is-deployed USS-Essex-CVG KOREA-SOUTH) ;to test out SELECT-OP-4-NAVAL-UNIT-MOVEMENT cr
                                 (is-deployed infantry-battalion-a
                                   saudi-arabia)
                                 (is-deployed f15-c-squadron saudi-arabia)
				 (is-interdicted saudi-arabia)
))))