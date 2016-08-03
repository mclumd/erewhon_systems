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
(ptype-of Passport     Object)
(ptype-of Presentation Object)

;;--------------------------------------------------------------;;
;; TYPE DEFINITION Container					;;
;;--------------------------------------------------------------;;
;; NOTES: Something that can carry objects.			;;
;;--------------------------------------------------------------;;
;; PREDICATE DEFINITIONS:					;;
;;--------------------------------------------------------------;;
(ptype-of Container  Object)
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
(ptype-of Missile       Object)
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
;;   (holding <Person> <Object>)				;;
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
 (params <object> <person> <place>)
 
 ;; ------------------------------------------------
 ;; Precondition List
 (preconds 
  ;; Type Conditions
  ((<person> Person)
   (<object> Object)
   (<place>  Location))
  
  ;; Predicate Conditions
  (and (at-loc-p <person> <place>)
       (at-loc-o <object> <place>)
       (~ (immobile <object>))
       )
  )
 
 ;; ------------------------------------------------
 ;; Effects List
 
 (effects 
  () ; no vars need genenerated in effects list
  ((del (at-loc-o <object> <place>))
   (add (holding  <person> <object>)))
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
 (params <object> <person> <place>)
 
 ;; ------------------------------------------------
 ;; Precondition List
 (preconds 
  ;; Type Conditions
  ((<person> Person)
   (<object> Object)
   (<place>  Location))
  
  ;; Predicate Conditions
  (and (at-loc-p <person> <place>)
       (holding  <person> <object>)
       )
  )
 
 ;; ------------------------------------------------
 ;; Effects List
 
 (effects 
  () ; no vars need genenerated in effects list
  ((del (holding  <person> <object>))
   (add (at-loc-o <object> <place>))
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
   (add (detonating <missile> <dest>))
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


;;**************************************************************;;
;; 5. Control Rules						;;
;;**************************************************************;;
;;--------------------------------------------------------------;;
;; CONTROL RULE go-before-flying				;;
;;--------------------------------------------------------------;;
;; NOTES:							;;
;;--------------------------------------------------------------;;
(control-rule go-before-flying
	      (if (and (candidate-goal (at-loc-p <x> <y>))
		       (candidate-goal (in-city-p <x> <z>))))
	      (then select goal (at-loc-p <x> <y>)))

;;--------------------------------------------------------------;;
;; CONTROL RULE go-where-stuff-is				;;
;;--------------------------------------------------------------;;
;; NOTES:							;;
;;--------------------------------------------------------------;;
(control-rule go-where-stuff-is
	      (if (and (candidate-goal (at-loc-p <x> <y>))
		       (candidate-goal (at-loc-p <x> <z>))
		       (true-in-state  (at-loc-o <o> <z>))
		       (candidate-goal (holding <x> <o>)))
		  )
	      (then select goal (at-loc-p <x> <z>)))
		 


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
;; 6. Replay Control Rules					;;
;;**************************************************************;;
(control-rule ASK-FOR-GOAL
  (if (and
       (analogy-get-guidance-goal <goal>)))
  (then select goal <goal>))


(control-rule ASK-FOR-OPERATOR
  (if (and
       (analogy-get-guidance-operator <operator>)))
  (then select operator <operator>))

(control-rule ASK-FOR-BINDINGS
  (if (and 
       (analogy-get-guidance-bindings <bindings>)))
  (then select bindings <bindings>))

(control-rule GUIDED-SUBGOAL
  (if (and 
       (analogy-decide-subgoal)))
  (then sub-goal))

(control-rule GUIDED-APPLY
  (if (and 
       (analogy-decide-apply)))
  (then apply))


;============================================================================
