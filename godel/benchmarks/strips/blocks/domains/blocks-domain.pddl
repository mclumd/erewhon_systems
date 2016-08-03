(define (domain blocks)
  (:requirements :strips) 
  (:predicates 	(on ?a ?b)
		(clear ?a)
		(on-table ?a)
		(arm-empty)
		(holding ?a))

  (:action pickup 
	   :parameters 
	   (?a)
	   :precondition
	   (and (on-table ?a)
		(arm-empty)
		(clear ?a))
	   :effect
	   (and (not (clear ?a))
		(not (arm-empty))
		(not (on-table ?a))
		(holding ?a)))

  (:action putdown 
	   :parameters 
	   (?a)
	   :precondition
	   (and (holding ?a))
	   :effect
	   (and (not (holding ?a))
		(clear ?a)
		(arm-empty)
		(on-table ?a)))

  (:action stack 
	   :parameters 
	   (?a ?b)
	   :precondition
	   (and (holding ?a) (clear ?b))
	   :effect
	   (and (not (holding ?a))
		(not (clear ?b))
		(arm-empty)
		(on ?a ?b)
		(clear ?a)))

  (:action unstack 
	   :parameters 
	   (?a ?b)
	   :precondition
	   (and (on ?a ?b)
		(arm-empty)
		(clear ?a))
	   :effect
	   (and (not (on ?a ?b))
		(not (arm-empty))
		(not (clear ?a))
		(holding ?a)
		(clear ?b))))



