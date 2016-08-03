;;**************************************************************;;
;;--------------------------------------------------------------;;
;; Problem File: The Stinger Domain Parsimonious Crazy Guy	;;
;; Author:	 Anthony G. Francis, Jr.			;;
;; Assignment:	 Visiting Research Work.			;;
;; Due:		 Not Specified					;;
;;--------------------------------------------------------------;;
;; Module:	 Stinger Domain version 1			;;
;; File:	 "probs/p-crazy.lisp"				;;
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
       (name p-crazy)

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
	(KingsTavern Location)
	(Kinkos      Location) ;;##
	(PostOffice  Location) ;;##

	;; City of Washington
	(Washington  City)
	(Dulles      Airport)
	(Mall        Location)

	;;=====================================================
	;; Changeable Problem Objects
	;;=====================================================
	;;--- MOBILE OBJECTS------
	(Researcher  Person)
	(Luggage1    Luggage)
	(Stinger1    Stinger)
	(Monument    Fixed)
	(AKR         Presentation);;##
	(Passport1   Passport);;##
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
	 (in-city-l   Kinkos      Atlanta);;##
	 (in-city-l   PostOffice  Atlanta);;##
 
	 ;; Washington
	 (in-country  Washington  USA)
	 (in-city-l   Dulles      Washington)
	 (in-city-l   Mall        Washington)
	 (at-loc-o    Monument    Mall)

	 ;;=====================================================
	 ;; Changeable Problem Knowledge
	 ;;=====================================================
	 ;;--- MOBILE OBJECTS------
	 (at-loc-o    AKR          Kinkos)
	 (at-loc-o    Passport1    PostOffice)
	 (at-loc-o    Luggage1     KingsTavern)

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
;;	      (in-city-p  Researcher Washington)
	      (destroyed Monument)
	      )
	     )
       )
      )

