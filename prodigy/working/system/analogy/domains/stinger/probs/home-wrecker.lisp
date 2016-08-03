;;**************************************************************;;
;;--------------------------------------------------------------;;
;; Problem File: The Nightmare Conference			;;
;; Author:	Anthony G. Francis, Jr.				;;
;; Assignment:	Visiting Research Work.				;;
;; Due:		Not Specified					;;
;;--------------------------------------------------------------;;
;; Module:	Stinger Domain version 1			;;
;; File:	"probs/nightmare-conference.lisp"		;;
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
       (name nightmare-conference)

       ;;-------------------------------------------------------
       ;; OBJECT DECLARATIONS
       ;;-------------------------------------------------------
       (objects
	(USA         Country)
	(UK          Country)
	(Greece      Country)

	(Atlanta     City)
	(Boston      City)
	(Washington  City)
	(Inverness   City)
	(Iraklion    City)

	(Hartsfield  Airport)
	(Athensport  Airport)
	(Gatwick     Airport)
	(Bostonport  Airport)
	(Dulles      Airport)
	(GeorgiaTech Location)
	(Kinkos      Location)
	(PostOffice  Location)
	(KingsTavern Location)
	(Researcher  Person)
	(Passport1   Passport)
	(AKR         Presentation)
	(Luggage1    Luggage)
	(Stinger1    Stinger)
	)

       ;;-------------------------------------------------------
       ;; INITIAL STATE
       ;;-------------------------------------------------------
       (state (and (in-country  Atlanta     USA)
		   (in-country  Boston      USA)
		   (in-country  Washington  USA)
		   (in-country  Inverness   UK)
		   (in-country  Iraklion    Greece)
		   (in-city-l   Hartsfield  Atlanta)
		   (in-city-l   GeorgiaTech Atlanta)
		   (in-city-l   KingsTavern Atlanta)
		   (in-city-l   Bostonport  Boston)
		   (in-city-l   Kinkos      Boston)
		   (in-city-l   Dulles      Washington)
		   (in-city-l   PostOffice  Washington)
		   (in-city-l   Gatwick     Inverness) ;; not true but...
		   (in-city-l   Athensport  Iraklion)  ;; not true but...
		   (nationality Researcher  USA)
		   
		   (at-loc-o    AKR          Kinkos)
		   (at-loc-o    Passport1    PostOffice)
		   (at-loc-o    Luggage1     KingsTavern)
		   (at-loc-p    Researcher   GeorgiaTech)
		   (in-city-p   Researcher   Atlanta)
		   (holding   Researcher Stinger1)
		   )
	      )

       ;;-------------------------------------------------------
       ;; GOAL STATE
       ;;-------------------------------------------------------
       (goal (and
	      (destroyed Luggage1)
	      )
	     )
       )
      )

