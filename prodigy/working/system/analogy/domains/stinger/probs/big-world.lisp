;;**************************************************************;;
;;--------------------------------------------------------------;;
;; Problem File: The Stinger Domain Big World			;;
;; Author:	 Anthony G. Francis, Jr.			;;
;; Assignment:	 Visiting Research Work.			;;
;; Due:		 Not Specified					;;
;;--------------------------------------------------------------;;
;; Module:	 Stinger Domain version 1			;;
;; File:	 "probs/big-world.lisp"				;;
;;--------------------------------------------------------------;;
;; Notes: 							;;
;;--------------------------------------------------------------;;
;;**************************************************************;;

;;**************************************************************;;
;; PROBLEM DEFINITION						;;
;;**************************************************************;;
(setf (current-problem)
      (create-problem
       ;;-------------------------------------------------------
       ;; PROBLEM NAME
       ;;-------------------------------------------------------
       (name big-world)

       ;;-------------------------------------------------------
       ;; OBJECT DECLARATIONS
       ;;-------------------------------------------------------
       (objects

	;;=====================================================
	;; Largely Fixed Domain Objects
	;;=====================================================
	;;--- UNITED STATES ------
	(USA         Country)

	;; City of Atlanta
	(Atlanta     City)
	(Hartsfield  Airport)
	(GeorgiaTech Location)
	(Kinkos      Location)
	(PostOffice  Location)
	(KingsTavern Location)

	;; City of Boston
	(Boston      City)
	(Bostonport  Airport)
	(CopyService Location)

	;; City of Washington
	(Washington  City)
	(Dulles      Airport)
	(StateDept   Location)

	;; City of White Sands 
	(WhiteSands  City)
	(AirBase     Airport)

	;;--- UNITED KINGDOM -----
	(UK          Country)
	;; London
	(London      City)
	(Gatwick     Airport)
	(BigBen      Location)

	;; Inverness
	(Inverness   City)
	(LochNess    Location)

	;;--- GREECE -------------
	(Greece      Country)
	(Iraklion    City)
	(Tinyport    Airport)
	(Forth       Location)

	;;=====================================================
	;; Changeable Problem Objects
	;;=====================================================
	;;--- MOBILE OBJECTS------
	(Researcher  Person)
	(Passport1   Passport)
	(AKR         Presentation)
	(Luggage1    Luggage)
	(Stinger1    Stinger)
	(Doomsday1   ICBM)
	)

       ;;-------------------------------------------------------
       ;; INITIAL STATE
       ;;-------------------------------------------------------
       (state 
	(and 
	 ;;=====================================================
	 ;; Largely Fixed Domain Knowledge
	 ;;=====================================================
	 ;;--- UNITED STATES ------
	 ;; Atlanta
	 (in-country  Atlanta     USA)
	 (in-city-l   Hartsfield  Atlanta)
	 (in-city-l   GeorgiaTech Atlanta)
	 (in-city-l   KingsTavern Atlanta)
	 (in-city-l   Kinkos      Atlanta)
	 (in-city-l   PostOffice  Atlanta)
	 
	 ;; Boston
	 (in-country  Boston      USA)
	 (in-city-l   Bostonport  Boston)
	 (in-city-l   CopyService Boston)

	 ;; Washington
	 (in-country  Washington  USA)
	 (in-city-l   Dulles      Washington)
	 (in-city-l   StateDept   Washington)

	 ;; White Sands
	 (in-country  WhiteSands  USA)
	 (in-city-l   AirBase     WhiteSands)

	 ;;--- UNITED KINGDOM -----
	 ;; London
	 (in-country  London      UK)
	 (in-city-l   Gatwick     London) 
	 (in-city-l   BigBen      London)

	 ;; Inverness
	 (in-country  Inverness   UK)
	 (in-city-l   Inverness   LochNess)

	 ;;--- GREECE -------------
	 ;; Iraklion
	 (in-country  Iraklion    Greece)
	 (in-city-l   Tinyport    Iraklion)

	 ;;=====================================================
	 ;; Changeable Problem Knowledge
	 ;;=====================================================
	 ;;--- MOBILE OBJECTS------
	 (at-loc-o    AKR          Kinkos)
	 (at-loc-o    Passport1    PostOffice)
	 (at-loc-o    Luggage1     KingsTavern)
	 (at-loc-o    Doomsday1    AirBase)

	 ;;--- PEOPLE -------------
	 (nationality Researcher   USA)
	 (at-loc-p    Researcher   GeorgiaTech)
	 (in-city-p   Researcher   Atlanta)
	 (holding     Researcher   Stinger1)
	 )
	)

       ;;-------------------------------------------------------
       ;; GOAL STATE
       ;;-------------------------------------------------------
       (goal (and
	      (in-city-p Researcher Iraklion)
	      )
	     )
       )
      )

