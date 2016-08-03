;;**************************************************************;;
;;--------------------------------------------------------------;;
;; Domain File: The Mission Impossible Domain, Version 1	;;
;; Author:	Anthony G. Francis, Jr.				;;
;; Assignment:	Visiting Research Work.				;;
;; Due:		Not Specified					;;
;;--------------------------------------------------------------;;
;; Module:	Mission Impossible Domain File			;;
;; File:	"domain.lisp"					;;
;;--------------------------------------------------------------;;
;; NOTES: 	INCOMPLETE!					;;
;;--------------------------------------------------------------;;
;; File Contents:						;;
;; 1. Mission Domain Initialization				;;
;; 2. Mission Domain Ontology					;;
;; 3. Operator Table						;;
;; 4. Inference Rules						;;
;; 5. Control Rules						;;
;; 6. Meta Predicates						;;
;; 7. Replay Control Rules					;;
;; 8. Class Short Names Table					;;
;;--------------------------------------------------------------;;
;;**************************************************************;;

;;**************************************************************;;
;; 1. Mission Domain Initialization				;;
;;**************************************************************;;
;; NOTES: This domain is based on the Mission Impossible	;;
;	movie, which I'm going to go see again in 5 minutes.	;;
;;**************************************************************;;
(create-problem-space 'Mission :current t)

;;**************************************************************;;
;; 2. Mission Domain Ontology					;;
;;**************************************************************;;
;;--------------------------------------------------------------;;
;; TYPE DEFINITION Agent					;;
;;--------------------------------------------------------------;;
;; NOTES: A secret agent that can break in and steal things.	;;
;;	The actual agent object is not yet used.		;;
;;--------------------------------------------------------------;;
;; PREDICATE DEFINITIONS:					;;
;; - AT means the agent is at a place				;;
;;   (at <place>)						;;
;; - INSIDE: the agent is inside (robbing) a place		;;
;;   (inside <place>)						;;
;; - HOLDING: the agent is holding an object.			;;
;;   (holding <secret>)						;;
;;--------------------------------------------------------------;;
;;(ptype-of Agent      :top-type)

;;--------------------------------------------------------------;;
;; TYPE DEFINITION Secret					;;
;;--------------------------------------------------------------;;
;; NOTES: Something that can be stolen or dropped off.		;;
;;--------------------------------------------------------------;;
;; PREDICATE DEFINITIONS:					;;
;; - STORED: where is the secret stored?			;;
;;   (stored <secret> <place>)					;;
;; - DROPPED: where is the secret dropped?			;;
;;   (dropped <secret> <place>)					;;
;;--------------------------------------------------------------;;
(ptype-of Secret       :top-type)

;;--------------------------------------------------------------;;
;; TYPE DEFINITION Place					;;
;;--------------------------------------------------------------;;
;; NOTES: Something that can be flown to or from.		;;
;;--------------------------------------------------------------;;
;; PREDICATE DEFINITIONS:					;;
;; - SECURE: is this place secure?				;;
;;   (secure <place>)						;;
;; - INSECURE: is this place insecure?				;;
;;   (insecure <place>)						;;
;;--------------------------------------------------------------;;
(ptype-of Place           :top-type)

;;**************************************************************;;
;; 3. Operator Table						;;
;;**************************************************************;;
;;--------------------------------------------------------------;;
;; OPERATOR steal						;;
;;--------------------------------------------------------------;;
;; NOTES: An agent stealing a secret.		       		;;
;;--------------------------------------------------------------;;
(OPERATOR 
 Steal
 ;; ------------------------------------------------
 ;; Parameter List
 (params <secret> <place>)
 
 ;; ------------------------------------------------
 ;; Precondition List
 (preconds 
  ;; Type Conditions
  ((<secret> Secret)
   (<place>  Place))
  
  ;; Predicate Conditions
  (and (inside          <place>)
       (stored <secret> <place>)
       )
  )
 
 ;; ------------------------------------------------
 ;; Effects List
 
 (effects 
  () ; no vars need genenerated in effects list
  ((del (stored  <secret> <place>))
   (add (holding <secret>))
   )
  )
 )

;;--------------------------------------------------------------;;
;; OPERATOR plant						;;
;;--------------------------------------------------------------;;
;; NOTES: An agent planting a secret in a secure site		;;
;;--------------------------------------------------------------;;
(OPERATOR 
 Plant
 ;; ------------------------------------------------
 ;; Parameter List
 (params <secret> <place>)
 
 ;; ------------------------------------------------
 ;; Precondition List
 (preconds 
  ;; Type Conditions
  ((<secret> Secret)
   (<place>  Place))
  
  ;; Predicate Conditions
  (and (inside              <place>)
       (holding <secret>)
       )
  )
 
 ;; ------------------------------------------------
 ;; Effects List
 
 (effects 
  () ; no vars need genenerated in effects list
  ((del (holding <secret>))
   (add (stored  <secret> <place>))
   )
  )
 )

;;--------------------------------------------------------------;;
;; OPERATOR pick-up						;;
;;--------------------------------------------------------------;;
;; NOTES: An agent picking up a secret at a drop box.		;;
;;--------------------------------------------------------------;;
(OPERATOR 
 Pick-Up
 ;; ------------------------------------------------
 ;; Parameter List
 (params <secret> <place>)
 
 ;; ------------------------------------------------
 ;; Precondition List
 (preconds 
  ;; Type Conditions
  ((<secret> Secret)
   (<place>  Place))
  
  ;; Predicate Conditions
  (and (at               <place>)
       (dropped <secret> <place>)
       )
  )
 
 ;; ------------------------------------------------
 ;; Effects List
 
 (effects 
  () ; no vars need genenerated in effects list
  ((del (dropped <secret> <place>))
   (add (holding <secret>))
   )
  )
 )

;;--------------------------------------------------------------;;
;; OPERATOR drop-off						;;
;;--------------------------------------------------------------;;
;; NOTES: An agent dropping off a secret at a drop box.		;;
;;--------------------------------------------------------------;;
(OPERATOR 
 Drop-Off
 ;; ------------------------------------------------
 ;; Parameter List
 (params <secret> <place>)
 
 ;; ------------------------------------------------
 ;; Precondition List
 (preconds 
  ;; Type Conditions
  ((<secret> Secret)
   (<place>  Place))
  
  ;; Predicate Conditions
  (and (at               <place>)
       (holding <secret>)
       )
  )
 
 ;; ------------------------------------------------
 ;; Effects List
 
 (effects 
  () ; no vars need genenerated in effects list
  ((del (holding <secret>))
   (add (dropped <secret> <place>))
   )
  )
 )

;;--------------------------------------------------------------;;
;; OPERATOR go							;;
;;--------------------------------------------------------------;;
;; NOTES: An agent traveling from place to place.		;;
;;--------------------------------------------------------------;;
(OPERATOR 
 go
 ;; ------------------------------------------------
 ;; Parameter List
 (params <start> <dest>)
 
 ;; ------------------------------------------------
 ;; Precondition List
 (preconds 
  ;; Type Conditions
  ((<start>  Place)
   (<dest>   (and Place
		  (diff <start> <dest>)
		  )
	     )
   )
  
  ;; Predicate Conditions
  (and (at   <start>)
       (pass <start> <dest>)
       )
  )
 
 ;; ------------------------------------------------
 ;; Effects List
 
 (effects 
  ()  ; no vars need genenerated in effects list
  ((del (at   <start>))
   (del (pass <start> <dest>))
   (add (at           <dest>))
   )
  )
 )

;;--------------------------------------------------------------;;
;; OPERATOR break-in						;;
;;--------------------------------------------------------------;;
;; NOTES: An agent breaks in to a secure zone.			;;
;;--------------------------------------------------------------;;
(OPERATOR 
 break-in
 ;; ------------------------------------------------
 ;; Parameter List
 (params <start>)
 
 ;; ------------------------------------------------
 ;; Precondition List
 (preconds 
  ;; Type Conditions
  ((<start>  Place)
   )
  
  ;; Predicate Conditions
  (and (at       <start>)
       (insecure <start>)
       )
  )
 
 ;; ------------------------------------------------
 ;; Effects List
 
 (effects 
  () ; no vars need genenerated in effects list
  ((del (at       <start>))
   (del (insecure <start>))
   (add (inside   <start>))
   )
  )
 )
;;--------------------------------------------------------------;;
;; OPERATOR escape						;;
;;--------------------------------------------------------------;;
;; NOTES: An agent breaks in to a secure zone.			;;
;;--------------------------------------------------------------;;
(OPERATOR 
 escape
 ;; ------------------------------------------------
 ;; Parameter List
 (params <start>)
 
 ;; ------------------------------------------------
 ;; Precondition List
 (preconds 
  ;; Type Conditions
  ((<start>  Place)
   )
  
  ;; Predicate Conditions
  (and (inside <start>)
       )
  )
 
 ;; ------------------------------------------------
 ;; Effects List
 
 (effects 
  () ; no vars need genenerated in effects list
  ((del (inside <start>))
   (add (secure <start>))
   (add (at     <start>))
   )
  )
 )

;;**************************************************************;;
;; 4. Inference Rules						;;
;;**************************************************************;;

;;**************************************************************;;
;; 5. Control Rules						;;
;;**************************************************************;;
		 
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



