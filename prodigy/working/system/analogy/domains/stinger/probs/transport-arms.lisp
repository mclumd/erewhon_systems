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
       (name compete-transport-arms)

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
	(Mall        Location)

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
;;	(Doomsday1   ICBM)
	(Monument    Fixed)
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
	 (air-security USA High)
	 
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
	 (in-city-l   Mall        Washington)
	 (at-loc-o    Monument    Mall)

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
	 (at-loc-o    Luggage1     AirBase)
	 (at-loc-o    Stinger1     AirBase)

	 ;;--- PEOPLE -------------
	 (nationality Researcher   USA)
	 (at-loc-p    Researcher   AirBase)
	 (in-city-p   Researcher   WhiteSands)
	 )
	)

       ;;-------------------------------------------------------
       ;; GOAL STATE
       ;;-------------------------------------------------------
       (goal (and
	      (holding Researcher Stinger1)
	      (in-city-p Researcher Atlanta)
	      )
	     )
       )
      )
