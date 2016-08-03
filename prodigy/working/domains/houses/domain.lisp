
(create-problem-space 'house-building :current t)

(ptype-of LOCATION :top-type)
(ptype-of HOUSE LOCATION)

(ptype-of RAW-MATERIAL :top-type)
(ptype-of CONCRETE RAW-MATERIAL)
(ptype-of WALL-MATERIAL RAW-MATERIAL)
(ptype-of BRICK RAW-MATERIAL)
(ptype-of WOOD RAW-MATERIAL)
(ptype-of SHINGLE RAW-MATERIAL)

(ptype-of WORKER :top-type)
(ptype-of CONSTRUCTION-WORKER WORKER)
(ptype-of FIREMAN WORKER)
(ptype-of TEAMSTER WORKER)

(pinstance-of HQ LOCATION)

(operator LAY-FOUNDATION
 (params <house1> <concrete1> <worker1>)
 (preconds
  (
  	(<house1> HOUSE)
  	(<concrete1> CONCRETE)
  	(<worker1> CONSTRUCTION-WORKER)
  )
  (and 	(at <concrete1> <house1>)
  		(at <worker1> <house1>)
  		(~ (has-foundation <house1>))
  		(~ (has-brick-walls <house1>))
  		(~ (has-wood-walls <house1>))
  		(unused <concrete1>)
  )
 )
 (effects
  ()
  (
  	(del (unused <concrete1>))
  	(del (at <concrete1> <house1>))
  	(add (has-foundation <house1>))
  )
 )
)

(operator BUILD-WOOD-WALLS
 (params <house1> <wall-material1> <worker1>)
 (preconds
  (
  	(<house1> HOUSE)
  	(<wall-material1> WOOD)
  	(<worker1> CONSTRUCTION-WORKER)
  )
  (and 	(at <wall-material1> <house1>)
  		(~ (has-brick-walls <house1>))
  		(~ (has-wood-walls <house1>))
  		(unused <wall-material1>)
  		(at <worker1> <house1>)
  )
 )
 (effects
  ()
  (
  	(del (unused <wall-material1>))
  	(del (at <wall-material1> <house1>))
  	(add (has-wood-walls <house1>))
  )
 )
)

(operator BUILD-BRICK-WALLS
 (params <house1> <wall-material1> <worker1>)
 (preconds
  (
  	(<house1> HOUSE)
  	(<wall-material1> BRICK)
  	(<worker1> CONSTRUCTION-WORKER)
  )
  (and 	(at <wall-material1> <house1>)
  		(~ (has-brick-walls <house1>))
  		(~ (has-wood-walls <house1>))
  		(unused <wall-material1>)
  		(at <worker1> <house1>)
  )
 )
 (effects
  ()
  (
  	(del (unused <wall-material1>))
  	(del (at <wall-material1> <house1>))
  	(add (has-brick-walls <house1>))
  )
 )
)

(operator BUILD-ROOF
 (params <house1> <roof-material1> <worker1>)
 (preconds
  (
  	(<house1> HOUSE)
  	(<roof-material1> SHINGLE)
  	(<worker1> CONSTRUCTION-WORKER)
  )
  (and 	(at <roof-material1> <house1>)
  		(~ (has-roof <house1>))
  		(or (has-brick-walls <house1>) (has-wood-walls <house1>))
  		(unused <roof-material1>)
  		(at <worker1> <house1>)
  )
 )
 (effects
  ()
  (
  	(del (unused <roof-material1>))
  	(del (at <roof-material1> <house1>))
  	(add (has-roof <house1>))
  )
 )
)

(operator HOUSE-COMPLETE
 (params <house1>)
 (preconds
  (
  	(<house1> HOUSE)
  )
  (and 	
  		(has-roof <house1>)
  		(has-foundation <house1>)
  		(or (has-brick-walls <house1>) (has-wood-walls <house1>))
  		(~ (on-fire <house1>))
  )
 )
 (effects
  ()
  (
  	(add (complete <house1>))
  )
 )
)

(operator DISPATCH-WORKER
 (params <worker1> <start> <dest>)
 (preconds
  (
  	(<dest> LOCATION)
  	(<start> LOCATION)
  	(<worker1> WORKER)
  )
  (and
  	(at <worker1> <start>)
  )
 )
 (effects
  ()
  (
  	(del (at <worker1> <start>))
  	(add (at <worker1> <dest>))
  )
 )
)

(operator PUT-OUT-FIRE
 (params <worker1> <house1>)
 (preconds
  (
  	(<house1> HOUSE)
  	(<worker1> FIREMAN)
  )
  (and
  	(at <worker1> <house1>)
  	(on-fire <house1>)
  	(hoses-loaded <worker1>)
  )
 )
 (effects
  ()
  (
  	(del (hoses-loaded <worker1>))
  	(del (on-fire <house1>))
  )
 )
)

(operator LOAD-HOSES
 (params <worker1>)
 (preconds
  (
  	(<worker1> FIREMAN)
  )
  (and
  	(at <worker1> HQ)
  	(~ (hoses-loaded <worker1>))
  )
 )
 (effects
  ()
  (
  	(add (hoses-loaded <worker1>))
  )
 )
)

(operator MOVE-MATERIAL
 (params <worker1> <material1> <dest>)
 (preconds
  (
  	(<worker1> TEAMSTER)
  	(<material1> RAW-MATERIAL)
  	(<dest> LOCATION)
  	(<loc1> LOCATION)
  )
  (and
  	(at <worker1> <loc1>)
  	(at <material1> <loc1>)
  )
 )
 (effects
  ()
  (
  	(del (at <worker1> <loc1>))
  	(del (at <material1> <loc1>))
  	(add (at <worker1> <dest>))
  	(add (at <material1> <dest>))
  )
 )
)

;;;Control Rules:


(Control-rule select-current-house1
	(if (and
			(candidate-goal (lay-foundation <house1> <wall-material1> <worker1>))
			(true-in-state (at <worker1> <house1>))
		)
	)
	(then select goal (lay-foundation <house1> <wall-material1> <worker1>))
)

(Control-rule select-current-house2
	(if 
		(and
			(candidate-goal (build-brick-walls <house1> <wall-material1> <worker1>))
			(true-in-state (at <worker1> <house1>))
		)
	)
	(then select goal (build-brick-walls <house1> <wall-material1> <worker1>))
)

(Control-rule select-current-house3
	(if 
		(and
			(candidate-goal (build-wood-walls <house1> <wall-material1> <worker1>))
			(true-in-state (at <worker1> <house1>))
		)
	)
	(then select goal (build-wood-walls <house1> <wall-material1> <worker1>))
)

(Control-rule select-current-house4
	(if 
		(and
			(candidate-goal (build-roof <house1> <wall-material1> <worker1>))
			(true-in-state (at <worker1> <house1>))
		)
	)
	(then select goal (build-roof <house1> <wall-material1> <worker1>))
)

(Control-rule select-current-house5
	(if 
		(and
			(candidate-goal (house-complete <house1>))
			(true-in-state (at <worker1> <house1>))
		)
	)
	(then select goal (house-complete <house1>))
)

(Control-rule select-current-house6
	(if 
		(and
			(candidate-goal (at <m1> <house1>))
			(true-in-state (at <worker1> <house1>))
			(<worker1> CONSTRUCTION-WORKER)
		)
	)
	(then select goal (at <m1> <house1>))
)

(pset :depth-bound 50)