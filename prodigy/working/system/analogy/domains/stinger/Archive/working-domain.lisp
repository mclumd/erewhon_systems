;;**************************************************************;;
;;--------------------------------------------------------------;;
;; Domain File: The Stinger Missle Domain, Version 1		;;
;; Author:	Anthony G. Francis, Jr.				;;
;; Assignment:	Visiting Research Work.				;;
;; Due:		Not Specified					;;
;;--------------------------------------------------------------;;
;; Module:	Travel Domain File				;;
;; File:	"domain.lisp"					;;
;;--------------------------------------------------------------;;
;; Notes: 							;;
;;--------------------------------------------------------------;;
;; File Contents:						;;
;; 1. Travel Domain Initialization				;;
;; 2. Travel Domain Ontology					;;
;; 3. Operator Table						;;
;; 4. Inference Rules						;;
;; 5. Control Rules						;;
;; 6. Meta Predicates						;;
;; 7. Replay Control Rules					;;
;; 8. Class Short Names Table					;;
;;--------------------------------------------------------------;;
;;**************************************************************;;

;;**************************************************************;;
;; 1. Travel Domain Initialization				;;
;;**************************************************************;;
;; NOTES: This domain is based on the Travel Domain used in     ;;
;;	Anthony's "Multi-Plan Retrieval" Paper, with the 	;;
;;	addition of macabre features like a stinger missle	;;
;;	launcher and other launchable warheads.			;;
;;**************************************************************;;
(create-problem-space 'travel :current t)

;;**************************************************************;;
;; 2. Travel Domain Ontology					;;
;;**************************************************************;;
;;--------------------------------------------------------------;;
;; TYPE DEFINITION Object					;;
;;--------------------------------------------------------------;;
;; NOTES: Something that can be carried by a person.		;;
;;--------------------------------------------------------------;;
;; PREDICATE DEFINITIONS:					;;
;; - AT-LOC-O means an Object is at a Location.			;;
;;   (at-loc-o <Object> <Place>)				;;
;;--------------------------------------------------------------;;
(ptype-of Object       :top-type)
(ptype-of Movable      Object)
(ptype-of Fixed        Object)
(ptype-of Passport     Movable)
(ptype-of Presentation Movable)

;;--------------------------------------------------------------;;
;; TYPE DEFINITION Container					;;
;;--------------------------------------------------------------;;
;; NOTES: Something that can carry Movables.			;;
;;--------------------------------------------------------------;;
;; PREDICATE DEFINITIONS:					;;
;;--------------------------------------------------------------;;
(ptype-of Container  Movable)
(ptype-of Luggage    Container)

;;--------------------------------------------------------------;;
;; TYPE DEFINITION Missile					;;
;;--------------------------------------------------------------;;
;; NOTES: Something that can blow things up.			;;
;;								;;
;; 	Ok, here's the drill: Conventional objects blow up 	;;
;;	everything at a location. Nuclears blow up a city.	;;
;;	(need a control rule for nuked-city!). I need params	;;
;;	for neutron bombs as well, a la the subway domain.	;;
;;--------------------------------------------------------------;;
;; PREDICATE DEFINITIONS:					;;
;;	A few other predicates of note:				;;
;;		(carryable  <bomb>)				;;
;;			need to write inference rules ... 	;;
;;			anything that is not (huge <object>)	;;
;;			should be carryable.			;;
;;		(launchable <missile>)				;;
;;			All missiles should be launchable,	;;
;;			except those which are (bomb <missile>)	;;
;;			Feelin' th' pinch-o-Prodigy's rep-lang? ;;
;;--------------------------------------------------------------;;
(ptype-of Missile      Movable)
(ptype-of Conventional Missile)
(ptype-of Nuclear      Missile)
(ptype-of Tactical     Nuclear)
(ptype-of ICBM	       Nuclear)
(ptype-of Stinger      Conventional)

;;--------------------------------------------------------------;;
;; TYPE DEFINITION Person					;;
;;--------------------------------------------------------------;;
;; NOTES: Something that can fly or carry luggage.		;;
;;--------------------------------------------------------------;;
;; PREDICATE DEFINITIONS:					;;
;; - AT-LOC-P means a Person is at a Location.			;;
;;   (at-loc-p <Person> <Place>)				;;
;; - IN-CITY-P: what city are we in?				;;
;;   (in-city-p <Person> <City>)				;;
;; - NATIONALITY: What country is this person from?		;;
;;   (nationality <Person> <Country>)				;;
;; - HOLDING: somebody has got something.			;;
;;   (holding <Person> <Movable>)				;;
;;--------------------------------------------------------------;;
(ptype-of Person      :top-type)

;;--------------------------------------------------------------;;
;; TYPE DEFINITION Place					;;
;;--------------------------------------------------------------;;
;; NOTES: Something that can be flown to or from.		;;
;;--------------------------------------------------------------;;
;; PREDICATE DEFINITIONS:					;;
;; - IN-CITY-l: what city is this location in?			;;
;;   (in-city-l <Person> <City>)				;;
;; - IN-COUNTRY: What country is this city in?			;;
;;   (in-country <City> <Country>)				;;
;;--------------------------------------------------------------;;
(ptype-of Place           :top-type)
(ptype-of Country         Place)
(ptype-of City            Place)
(ptype-of Location        Place)
(ptype-of Airport         Location)

;;**************************************************************;;
;; 3. Operator Table						;;
;;**************************************************************;;
;;--------------------------------------------------------------;;
;; OPERATOR pick-up						;;
;;--------------------------------------------------------------;;
;; NOTES:							;;
;;--------------------------------------------------------------;;
(OPERATOR 
 Pick-Up
 ;; ------------------------------------------------
 ;; Parameter List
 (params <Movable> <person> <place>)
 
 ;; ------------------------------------------------
 ;; Precondition List
 (preconds 
  ;; Type Conditions
  ((<person> Person)
   (<Movable> Movable)
   (<place>  Location))
  
  ;; Predicate Conditions
  (and (at-loc-p <person> <place>)
       (at-loc-o <Movable> <place>)
       (~ (immobile <Movable>))
       )
  )
 
 ;; ------------------------------------------------
 ;; Effects List
 
 (effects 
  () ; no vars need genenerated in effects list
  ((del (at-loc-o <Movable> <place>))
   (add (holding  <person> <Movable>)))
  )
 )


;;--------------------------------------------------------------;;
;; OPERATOR put-down						;;
;;--------------------------------------------------------------;;
;; NOTES:							;;
;;--------------------------------------------------------------;;
(OPERATOR 
 Put-Down
 ;; ------------------------------------------------
 ;; Parameter List
 (params <Movable> <person> <place>)
 
 ;; ------------------------------------------------
 ;; Precondition List
 (preconds 
  ;; Type Conditions
  ((<person> Person)
   (<Movable> Movable)
   (<place>  Location))
  
  ;; Predicate Conditions
  (and (at-loc-p <person> <place>)
       (holding  <person> <Movable>)
       )
  )
 
 ;; ------------------------------------------------
 ;; Effects List
 
 (effects 
  () ; no vars need genenerated in effects list
  ((del (holding  <person> <Movable>))
   (add (at-loc-o <Movable> <place>))
   )
  )
 )

;;--------------------------------------------------------------;;
;; OPERATOR go							;;
;;--------------------------------------------------------------;;
;; NOTES:							;;
;;--------------------------------------------------------------;;
(OPERATOR 
 go
 ;; ------------------------------------------------
 ;; Parameter List
 (params <person> <start> <dest> <city>)
 
 ;; ------------------------------------------------
 ;; Precondition List
 (preconds 
  ;; Type Conditions
  ((<person> Person)
   (<start>  Location)
   (<dest>   (and Location
		  (diff <start> <dest>)
		  )
	     )
   (<city>   City)
   )
  
  ;; Predicate Conditions
  (and (in-city-l <dest>   <city>)
       (in-city-l <start>  <city>)
       (in-city-p <person> <city>)
       (at-loc-p  <person> <start>)
       )
  )
 
 ;; ------------------------------------------------
 ;; Effects List
 
 (effects 
  () ; no vars need genenerated in effects list
  ((del (at-loc-p <person> <start>))
   (add (at-loc-p <person> <dest>))
   )
  )
 )

;;--------------------------------------------------------------;;
;; OPERATOR launch						;;
;;--------------------------------------------------------------;;
;; NOTES:							;;
;;--------------------------------------------------------------;;
(OPERATOR 
 launch
 ;; ------------------------------------------------
 ;; Parameter List
 (params <person> <missile> <start> <dest> <city>)
 
 ;; ------------------------------------------------
 ;; Precondition List
 (preconds 
  ;; Type Conditions
  ((<person>  Person)
   (<missile> Missile)
   (<start>   Location)
   (<dest>    Location)
   (<city>    City)
   )
  
  ;; Predicate Conditions
  (and (at-loc-p  <person> <start>)
       (holding   <person> <missile>)
       (in-city-l <start>  <city>)
       (in-city-l <dest>   <city>)
       )
  )
 
 ;; ------------------------------------------------
 ;; Effects List
 
 (effects 
  () ; no vars need genenerated in effects list
  ((del (holding  <person>  <missile>))
   (forall ((<object> Object))
	   (at-loc-o <object> <dest>)
	   ((add (destroyed <object>)))
	   )
   (add (destroyed <missile>))
   )
  )
 )

;;--------------------------------------------------------------;;
;; OPERATOR fly-domestic					;;
;;--------------------------------------------------------------;;
;; NOTES:							;;
;;--------------------------------------------------------------;;
(OPERATOR 
 Fly-Domestic
 ;; ------------------------------------------------
 ;; Parameter List
 (params <person> <nationality>
	 <start-airport> <start-city> 
	 <dest-airport>  <dest-city>)
 
 ;; ------------------------------------------------
 ;; Precondition List
 (preconds 
  ;; Type Conditions
  ((<person>        Person)
   (<nationality>   Country)
   (<start-airport> Airport)
   (<start-city>    City)
   (<dest-airport>  (and Airport
			 (diff <start-airport> <dest-airport>)
			 )
		    )
   (<dest-city>     (and City
			 (diff <start-city> <dest-city>)
			 )
		    )
   )
  
  ;; Predicate Conditions
  (and (nationality  <person>        <nationality>)
       (at-loc-p     <person>        <start-airport>)
       (in-city-l    <start-airport> <start-city>)
       (in-city-p    <person>        <start-city>)
       (in-country   <start-city>    <nationality>)
       (in-city-l    <dest-airport>  <dest-city>)
       (in-country   <dest-city>     <nationality>)
       )
  )
 
 ;; ------------------------------------------------
 ;; Effects List
 
 (effects 
  () ; no vars need genenerated in effects list
  ((del (at-loc-p  <person> <start-airport>))
   (del (in-city-p <person> <start-city>))
   (add (at-loc-p  <person> <dest-airport>))
   (add (in-city-p <person> <dest-city>))
   )
  )
 )

;;--------------------------------------------------------------;;
;; OPERATOR fly-international					;;
;;--------------------------------------------------------------;;
;; NOTES: Requiring that the destination country be a different ;;
;;	nationality leads to problems ... can we get away with	;;
;;	something simpler?					;;
;;--------------------------------------------------------------;;
(OPERATOR 
 Fly-International
 ;; ------------------------------------------------
 ;; Parameter List
 (params <person> <passport> <nationality>
	 <start-airport> <start-city> <start-country>
	 <dest-airport>  <dest-city>  <dest-country>)
 
 ;; ------------------------------------------------
 ;; Precondition List
 (preconds 
  ;; Type Conditions
  ((<person>        Person)
   (<passport>      Passport)
   (<nationality>   Country)
   (<start-airport> Airport)
   (<start-city>    City)
   (<start-country> Country)
   (<dest-airport>  (and Airport
			 (diff <start-airport> <dest-airport>)
			 )
		    )

   (<dest-city>     (and City
			 (diff <start-city> <dest-city>)
			 )
		    )
   (<dest-country>  (and Country
			 (diff <dest-country> <nationality>)
			 )
		    )
   )
  
  ;; Predicate Conditions
  (and (holding      <person>        <passport>)
       (nationality  <person>        <nationality>)
       (at-loc-p     <person>        <start-airport>)
       (in-city-l    <start-airport> <start-city>)
       (in-city-p    <person>        <start-city>)
       (in-country   <start-city>    <start-country>)
       (in-city-l    <dest-airport>  <dest-city>)
       (in-country   <dest-city>     <dest-country>)
       )
  )
 
 ;; ------------------------------------------------
 ;; Effects List
 
 (effects 
  () ; no vars need genenerated in effects list
  ((del (at-loc-p  <person> <start-airport>))
   (del (in-city-p <person> <start-city>))
   (add (at-loc-p  <person> <dest-airport>))
   (add (in-city-p <person> <dest-city>))
   )
  )
 )

;;**************************************************************;;
;; 4. Inference Rules						;;
;;**************************************************************;;
#|
(Inference-Rule
 explode-conventional
 (mode eager)
 (params <missile> <location>)
 (preconds
  ((<missile>  Missile)
   (<location> Location)
   )
  (and (detonating <missile> <location>)
       )
  )
 (effects
  ()
  ((forall ((<object> Object))
	   (at-loc-o <object> <location>)
	   ((add (destroyed <object>)))
	   )
   (del (detonating <missile> <location>))
   (add (destroyed   <missile>))
   )
  )
 )
|#

(Inference-Rule
 immovable-object
 (mode eager)
 (params <object>)
 (preconds
  ((<object>   Fixed)
   )
  (and )
  )
 (effects
  ()
  ((add (immobile <object>))
   )
  )
 )

;;**************************************************************;;
;; 5. Control Rules						;;
;;**************************************************************;;
;;--------------------------------------------------------------;;
;; CONTROL RULE go-before-flying				;;
;;--------------------------------------------------------------;;
;; NOTES: Successfully Fires!					;;
;;--------------------------------------------------------------;;
(control-rule only-go-to-useful-places
	      ;; If the current goal and op are ok,
	      (if (and (current-goal   (at-loc-p  <daperson> <destloc>))
		       (current-ops    (GO))
		       (true-in-state  (at-loc-p  <daperson> <startloc>))
		       (true-in-state  (in-city-l <startloc> <dacity>))
		       (true-in-state  (in-city-l <destloc>  <dacity>))
		       )
		  )

	      ;; Then set the bindings for the operator to something
	      ;; useful for a change.
	      (then select bindings
		    ((<start>  . <startloc>)
		     (<dest>   . <destloc>)
		     (<person> . <daperson>)
		     (<city>   . <dacity>)
		     )
		    )
	      )

;;--------------------------------------------------------------;;
;; CONTROL RULE go-before-flying				;;
;;--------------------------------------------------------------;;
;; NOTES: Successfully Fires!					;;
;;--------------------------------------------------------------;;
(control-rule dont-move-immobile-objects
	      ;; If the current goal and op are ok,
	      (if (and (candidate-goal (at-loc-o  <object> <destloc>))
		       (not (true-in-state (at-loc-o <object> <destloc>)))
		       (true-in-state (immobile <object>))
		       )
		  )

	      ;; Then set the bindings for the operator to something
	      ;; useful for a change.
	      (then reject goal (at-loc-o <object> <destloc>)
		    )
	      )
#|
(control-rule dont-move-the-world
	      ;; If the current goal and op are ok,
	      (if (and (candidate-goal (destroyed <object>))
		       (candidate-ops  (launch))
		       (true-in-state  (immobile <object>))
		       (candidate-bindings ( 
					    ((<person>  . <daperson>)
					     (<missile> . <damissile>)
					     (<start>   . <dastart>)
					     (<dest>    . <dadest>)
					     (<city>    . <dacity>)
					     )
					    )
					   )
		       (~ (true-in-state (at-loc-o <object> <dadest>)))
		       )
		  )

	      ;; Then set the bindings for the operator to something
	      ;; useful for a change.
	      (then reject bindings
		    ((<person>  . <daperson>)
		     (<missile> . <damissile>)
		     (<start>   . <dastart>)
		     (<dest>    . <dadest>)
		     (<city>    . <dacity>)
		     )
		    )
	      )
|#

(control-rule shoot-somewhere-useful-bozo
	      ;; If the current goal and op are ok,
	      (if (and (current-goal   (destroyed <object>))
		       (current-ops    (launch))
		       (true-in-state  (immobile  <object>))
		       (true-in-state  (at-loc-o  <object> <dadest>))
		       (true-in-state  (in-city-l <dadest> <dacity>))
		       )
		  )

	      ;; Then set the bindings for the operator to something
	      ;; useful for a change.
	      (then select bindings
		    ((<dest>    . <dadest>)
		     (<city>    . <dacity>)
		     )
		    )
	      )


(control-rule go-somewhere-useful-bozo
	      ;; If the current goal and op are ok,
	      (if (and (current-goal (at-loc-p <daperson> <daplace>))
		       (type-of-object <daplace> Airport)
		       (true-in-state  (in-city-l <dadest> <dacity>))
		       (true-in-state  (in-city-p <daperson> <diffcity>))
		       (diff <dacity> <diffcity>)
		       )
		  )

	      ;; Then set the bindings for the operator to something
	      ;; useful for a change.
	      (then select operator FLY-DOMESTIC))

;;--------------------------------------------------------------;;
;; CONTROL RULE go-before-flying				;;
;;--------------------------------------------------------------;;
;; NOTES:							;;
;;--------------------------------------------------------------;;
(control-rule select-go-if-in-same-city
	      (if (and (current-goal   (at-loc-p   <daperson> <destloc>))
		       (true-in-state  (in-city-l  <destloc>  <destcity>))
		       (true-in-state  (in-city-p  <daperson> <destcity>))
		       )
		  )
	      (then select operator GO))

(control-rule avoid-apply-when-should-subgoal
	      (if (and (on-goal-stack  (at-loc-p <daperson> <destloc>))
		       (true-in-state  (in-city-l <destloc> <destcity>))
		       (not (true-in-state
			     (in-city-p <daperson> <destcity>))
			    )
		       )
		  )
	      (then sub-goal)
	      )

(control-rule get-city-right-first
	      (if (and (candidate-goal (at-loc-p  <daperson> <destloc>))
		       (true-in-state  (in-city-l  <destloc>  <destcity>))
		       (not (true-in-state  
			     (in-city-p <daperson> <destcity>)))
		       )
		  )
	      (then select goal (in-city-p <daperson> <destcity>)
		    )
	      )

;;--------------------------------------------------------------;;
;; CONTROL RULE go-where-stuff-is				;;
;;--------------------------------------------------------------;;
;; NOTES:							;;
;;--------------------------------------------------------------;;
(control-rule go-where-stuff-is
	      (if (and (candidate-goal (at-loc-p <x> <y>))
		       (candidate-goal (at-loc-p <x> <z>))
		       (true-in-state  (at-loc-o <o> <z>))
		       (candidate-goal (holding  <x> <o>)))
		  )
	      (then prefer goal 
		    (at-loc-p <x> <z>) 
		    (at-loc-p <x> <y>)
		    )
	      )
		 

(control-rule
 Dont-move-immobile-objects
 (IF (and (current-goal (at-p <someone> <somewhere>))
	  (ptype <someone> Person)))
 (THEN reject operator put-down))



;;**************************************************************;;
;; 6. Meta Predicates						;;
;;**************************************************************;;
;;--------------------------------------------------------------;;
;; META PREDICTATE diff						;;
;;--------------------------------------------------------------;;
;; NOTES:							;;
;;--------------------------------------------------------------;;
(defun diff (x y)
  (not (eq x y)))

;;--------------------------------------------------------------;;
;; META PREDICTATE other-candidate-goals			;;
;;--------------------------------------------------------------;;
;; NOTES:							;;
;;--------------------------------------------------------------;;
(defun other-candidate-goals ()
  (if (> (length (candidate-goals)) 1) t nil))


;;**************************************************************;;
;; 7. Replay Control Rules					;;
;;**************************************************************;;
;; NOTES: Required for use in the Analogy domain.		;;
;;**************************************************************;;
;;--------------------------------------------------------------;;
;; CONTROL RULE ask-for-goal					;;
;;--------------------------------------------------------------;;
;; NOTES: Allows Analogy to suggest a goal			;;
;;--------------------------------------------------------------;;
(control-rule ASK-FOR-GOAL
  (if (and
       (analogy-get-guidance-goal <goal>)))
  (then select goal <goal>))

;;--------------------------------------------------------------;;
;; CONTROL RULE ask-for-operator				;;
;;--------------------------------------------------------------;;
;; NOTES: Allows Analogy to suggest an operator			;;
;;--------------------------------------------------------------;;
(control-rule ASK-FOR-OPERATOR
  (if (and
       (analogy-get-guidance-operator <operator>)))
  (then select operator <operator>))

;;--------------------------------------------------------------;;
;; CONTROL RULE ask-for-bindings				;;
;;--------------------------------------------------------------;;
;; NOTES: Allows Analogy to suggest bindings			;;
;;--------------------------------------------------------------;;
(control-rule ASK-FOR-BINDINGS
  (if (and 
       (analogy-get-guidance-bindings <bindings>)))
  (then select bindings <bindings>))

;;--------------------------------------------------------------;;
;; CONTROL RULE guided-subgoal					;;
;;--------------------------------------------------------------;;
;; NOTES: Allows Analogy to provide guidance on subgoalling.	;;
;;--------------------------------------------------------------;;
(control-rule GUIDED-SUBGOAL
  (if (and 
       (analogy-decide-subgoal)))
  (then sub-goal))

;;--------------------------------------------------------------;;
;; CONTROL RULE guided-subgoal					;;
;;--------------------------------------------------------------;;
;; NOTES: Allows Analogy to provide guidance on application.	;;
;;--------------------------------------------------------------;;
(control-rule GUIDED-APPLY
  (if (and 
       (analogy-decide-apply)))
  (then apply))


;;**************************************************************;;
;; 7. Class Short Names Table					;;
;;**************************************************************;;
;; NOTES: Setting this variable is REQUIRED for use with 	;;
;;	Analogy. Even if you don't use it, if you load somebody	;;
;;	else's domain and *they* set it, it can screw up your	;;
;;	saved cases and prevent proper retrievals.		;;
;;**************************************************************;;
;;--------------------------------------------------------------;;
;; VARIABLE *class-short-names*					;;
;;--------------------------------------------------------------;;
;; NOTES: Allows Analogy to shorten case headers.		;;
;;--------------------------------------------------------------;;
(setf *class-short-names* NIL)



