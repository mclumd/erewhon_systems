;;**************************************************************;;
;;--------------------------------------------------------------;;
;; Problem File: The Foreign Conference				;;
;; Author:	Anthony G. Francis, Jr.				;;
;; Assignment:	Visiting Research Work.				;;
;; Due:		Not Specified					;;
;;--------------------------------------------------------------;;
;; Module:	Travel Domain version 2				;;
;; File:	"probs/foreign-conference.lisp"			;;
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
       (name foreign-conference)

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
		   (in-city-l   Kinkos      Atlanta)
		   (in-city-l   PostOffice  Atlanta)
		   (in-city-l   Gatwick     Inverness) ;; not true but...
		   (in-city-l   Athensport  Iraklion)  ;; not true but...
		   (nationality Researcher  USA)
		   
		   (at-loc-o    AKR          Kinkos)
		   (at-loc-o    Passport1    PostOffice)
		   (at-loc-p    Researcher   GeorgiaTech)
		   (in-city-p   Researcher   Atlanta)
		   )
	      )

       ;;-------------------------------------------------------
       ;; GOAL STATE
       ;;-------------------------------------------------------
       (goal (and
	      (in-city-p Researcher Iraklion)
	      (holding   Researcher AKR)
	      )
	     )
       )
      )

