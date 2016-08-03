(in-package "USER")

;;; NOTE that this file is obsolete for the most part. Case retrieval is now
;;; done through Prodigy/Analogy's retrieval process.

;;;
;;; The global variable *case-list* contains the list of case-headers for the
;;; system. Each element of the list is a pair. Each pair is a tuple of the
;;; form (<plan-name> <goal-list>). These pairs are used in the retrieval of
;;; similar past plans given a current set of planning goals. See function
;;; retrieve in file retrieve.lisp. Also see function create-case-list in the
;;; same file for how the list can be created from a list of ForMAT goal
;;; actions (:SAVE-GOAL commands).
;;;
(defvar *case-list* nil
  "The list of past cases and associated planning goals.")


(setf *case-list*
'((plana
  (and (exists ((|<security-police.937>| security-police))
        (is-deployed |<security-police.937>| saudi-arabia))
       (exists ((|<brigade.937>| brigade)) (is-deployed |<brigade.937>| saudi-arabia))
       (exists ((|<hawk-battalion.937>| hawk-battalion))
        (is-deployed |<hawk-battalion.937>| saudi-arabia))
       (airport-secure-at saudi-arabia)
       (exists ((|<f15.937>| f15)) (is-deployed |<f15.937>| saudi-arabia))))
 (planb
  (and (exists ((|<hawk-battalion.938>| hawk-battalion))
        (is-deployed |<hawk-battalion.938>| saudi-arabia))
       (exists ((|<ground-force-module.938>| ground-force-module))
        (is-deployed |<ground-force-module.938>| saudi-arabia))
       (is-interdicted saudi-arabia) (exists ((|<f16.938>| f16)) (is-deployed |<f16.938>| saudi-arabia))
       (is-interdicted saudi-arabia)))
 (planc
  (and (exists ((|<brigade.938>| brigade)) (is-deployed |<brigade.938>| saudi-arabia))
       (exists ((|<hawk-battalion.939>| hawk-battalion))
        (is-deployed |<hawk-battalion.939>| saudi-arabia))
       (exists ((|<dog-team.939>| dog-team)) (is-deployed |<dog-team.939>| saudi-arabia))
       (exists ((|<security-police.939>| security-police))
        (is-deployed |<security-police.939>| saudi-arabia))
       (airport-secure-at saudi-arabia)
       (exists ((|<f15.939>| f15)) (is-deployed |<f15.939>| saudi-arabia))))
 (pland
  (and (IS-DEPLOYED 25TH-INFANTRY-DIVISION-LIGHT BOSNIA-AND-HERZEGOVINA)
       (EXISTS ((<DOG-TEAM.1520> DOG-TEAM)) (IS-DEPLOYED <DOG-TEAM.1520> BOSNIA-AND-HERZEGOVINA))
       (EXISTS ((<SECURITY-POLICE.1520> SECURITY-POLICE))
	       (IS-DEPLOYED <SECURITY-POLICE.1520> BOSNIA-AND-HERZEGOVINA))
       (IS-DEPLOYED MAGTF-MEU-GCE BOSNIA-AND-HERZEGOVINA) (TOWN-CENTER-SECURE-AT BOSNIA-AND-HERZEGOVINA)
       (EXISTS ((<TERRORISM.1520> TERRORISM)) (IS-SUPPRESSED <TERRORISM.1520>))))
 (plane
  (and (exists ((|<brigade.940>| brigade)) (is-deployed |<brigade.940>| sri-lanka))
       (exists ((|<security-police.941>| security-police))
        (is-deployed |<security-police.941>| sri-lanka))
       (exists ((|<hawk-battalion.941>| hawk-battalion)) (is-deployed |<hawk-battalion.941>| sri-lanka))
       (airport-secure-at sri-lanka) (exists ((|<f16.941>| f16)) (is-deployed |<f16.941>| sri-lanka))
       (exists ((|<aircraft.941>| f16)) (is-deployed |<aircraft.941>| sri-lanka))))
;;; Commented out temporarily so that it will not match as second best case to
;;; cover Jade demo goals. I do not know why it matches better. Fix
;;; later. [10mar98] Uncommented [cox 10apr98]
 (planf
  (and (exists ((|<infantry-battalion.941>| infantry-battalion))
        (is-deployed |<infantry-battalion.941>| sri-lanka))
       (exists ((|<security-police.942>| security-police))
        (is-deployed |<security-police.942>| sri-lanka))
       (exists ((|<military-police.942>| military-police))
        (is-deployed |<military-police.942>| sri-lanka))
       (exists ((|<terrorism.942>| terrorism)) (is-suppressed |<terrorism.942>|))))
 (planm
  ;;FM K25 has no goal in TPFDD nor here. Where did this goal structure come from?
  ;;A basic FM report?
  (and ;;FM TFS
       (EXISTS ((<A10A.83> A10A)) (IS-DEPLOYED <A10A.83> KOREA-SOUTH))
       (EXISTS ((<AIRCRAFT.82> F117)) (IS-DEPLOYED <AIRCRAFT.82> KOREA-SOUTH))
       (EXISTS ((<AIRCRAFT.84> F16)) (IS-DEPLOYED <AIRCRAFT.84> KOREA-SOUTH))
       ;;FM 45G. NOTE that dest-cc is Korea-south rather than SriLanka
       (EXISTS ((<COMBAT-SUPPORT-FORCE.85> COMBAT-SUPPORT-FORCE))
	       (IS-MISSION-SUPPORTED SRI-LANKA <COMBAT-SUPPORT-FORCE.85>))
       (EXISTS ((<COMBAT-SUPPORT-FORCE.86> COMBAT-SUPPORT-FORCE))
	       (IS-MEDICALLY-ASSISTED SRI-LANKA <COMBAT-SUPPORT-FORCE.86>))
       (IS-NEO-SUPPORTED SRI-LANKA)
       ;;FMs CV2 and TFS. NOTE that no meu-soc is a component of any FM of planm.
       (EXISTS ((<MEU-SOC.88> MEU-SOC)) (IS-SOVEREIGN SRI-LANKA <MEU-SOC.88>))
       ;;FM TFS & ADA. NOTE descrepency TFS dest-cc = korea-south. No Patriots 
       ;;in Prodigy domain.
       (EXISTS ((<FIGHTER-AIRCRAFT.89> FIGHTER-AIRCRAFT)) (AIR-DEFENDED SRI-LANKA <FIGHTER-AIRCRAFT.89>))
       ;;FM CV2. But not in CV2 as goal. Is Subgoal of TFS in TPFDD. Dest-cc= 
       ;;Korea-South
       (EXISTS ((<CARRIER-AIR-WING.90> CARRIER-AIR-WING)) (AIR-BLOCKADED SRI-LANKA <CARRIER-AIR-WING.90>))
       ;;FM CV2. Dest-cc = Korea-South
       (EXISTS ((<CARRIER-BATTLE-GROUP.91> CARRIER-BATTLE-GROUP))
	       (NAVAL-BLOCKADED SRI-LANKA <CARRIER-BATTLE-GROUP.91>))

	       ))
 (jack1
  (and (AIRPORT-SECURE-AT JOHNSTON-ATOLL AIRPORT6)
	       ))
  (jack2
   (and (EXISTS ((<AIRPORT.22> AIRPORT)) 
	       (AIRPORT-SECURE-AT JOHNSTON-ATOLL <AIRPORT.22>)
	       )
	(exists ((|<infantry-battalion.941>| infantry-battalion))
		(is-deployed |<infantry-battalion.941>| JOHNSTON-ATOLL))
	(exists ((|<security-police.942>| security-police))
		(is-deployed |<security-police.942>| JOHNSTON-ATOLL))
	(exists ((|<hawk-battalion.937>| hawk-battalion))
		(is-deployed |<hawk-battalion.937>| saudi-arabia))
       ))
(jack3
  (and (EXISTS ((<MEU-SOC.88> MEU-SOC)) (IS-SOVEREIGN KOREA-SOUTH <MEU-SOC.88>))
       (EXISTS ((<A10A.83> A10A)) (IS-DEPLOYED <A10A.83> KOREA-SOUTH))
       (EXISTS ((<AIRCRAFT.82> F117)) (IS-DEPLOYED <AIRCRAFT.82> KOREA-SOUTH))
       (EXISTS ((<AIRCRAFT.84> F16)) (IS-DEPLOYED <AIRCRAFT.84> KOREA-SOUTH))
       (EXISTS ((<CARRIER-AIR-WING.90> CARRIER-AIR-WING)) 
	       (AIR-BLOCKADED KOREA-SOUTH <CARRIER-AIR-WING.90>))
       (EXISTS ((<FIGHTER-AIRCRAFT.89> FIGHTER-AIRCRAFT)) 
	       (AIR-DEFENDED KOREA-SOUTH <FIGHTER-AIRCRAFT.89>))
       (exists ((|<terrorism.942>| terrorism)) (is-suppressed |<terrorism.942>|))
       (exists ((|<brigade.940>| brigade)) 
	       (is-deployed |<brigade.940>| BOSNIA-AND-HERZEGOVINA))
       (is-evacuated SRI-LANKA)
       (EXISTS ((<POPULATION.25> POPULATION) (<LOCATION.21> LOCATION))
	       	       (LOC-AT-P <POPULATION.25> <LOCATION.21>))
       (EXISTS ((<AIRPORT.22> AIRPORT)) 
	       (AIRPORT-SECURE-AT SRI-LANKA <AIRPORT.22>)
	       )
       (EXISTS ((<COMBAT-SUPPORT-FORCE.55> COMBAT-SUPPORT-FORCE))
	       (is-medically-assisted SRI-LANKA <COMBAT-SUPPORT-FORCE.55>))
       ))
 )
)

