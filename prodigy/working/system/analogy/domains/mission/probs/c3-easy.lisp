;;**************************************************************;;
;;--------------------------------------------------------------;;
;; Problem File: Mission Impossible: Simple Mission 1		;;
;; Author:	 Anthony G. Francis, Jr.			;;
;; Assignment:	 Visiting Research Work.			;;
;; Due:		 Not Specified					;;
;;--------------------------------------------------------------;;
;; Module:	 Mission Impossible Domain version 1		;;
;; File:	 "probs/c3-easy.lisp"			;;
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
       (name c3-easy)

       ;;-------------------------------------------------------
       ;; OBJECT DECLARATIONS
       ;;-------------------------------------------------------
       (objects

	;;--- Places ------
	(Roswell  Place)
	(Area51   Place)
	(Langley  Place)
	(London   Place)

	;;--- MOBILE OBJECTS------
	(Noc-List Secret)
	)

       ;;-------------------------------------------------------
       ;; INITIAL STATE
       ;;-------------------------------------------------------
       (state 
	(and 
	 ;;--- PLACES -------------
	 (insecure Langley)

	 ;;--- SECRETS ------------
	 (stored      Noc-List     Langley)

	 ;;--- PEOPLE -------------
	 (at          Roswell)

	 ;;--- PASSPORTS ----------
	 (pass        Roswell      Langley)
	 (pass        Langley      London)
	 (pass        Langley      Area51)
	 (pass        Area51       London)
	 )
	)

       ;;-------------------------------------------------------
       ;; GOAL STATE
       ;;-------------------------------------------------------
       (goal (and
	      (dropped Noc-List London)
	      )
	     )
       )
      )

