(setf (current-problem)
	(create-problem
		(name p4)
			(objects
				(h8 h2 h3 h1 h6 h7 h4 h5 HOUSE)
				(w3 CONSTRUCTION-WORKER)
				(w1 FIREMAN)
				(w2 TEAMSTER)
				(m6 m1 m3 CONCRETE)
				(m4 m7 m2 BRICK)
				(m5 SHINGLE)
			)
			(state
				(and
					(has-foundation h8)
					(has-roof h8)
					(has-wood-walls h8)
					(on-fire h8)
					(has-foundation h3)
					(has-foundation h1)
					(on-fire h7)
					(has-foundation h4)
					(has-brick-walls h4)
					(at m5 HQ)
					(unused m5)
					(at m4 h7)
					(unused m4)
					(at m7 h6)
					(unused m7)
					(at m6 h3)
					(unused m6)
					(at m1 h7)
					(unused m1)
					(at m3 h5)
					(unused m3)
					(at m2 h7)
					(unused m2)
					(at w3 h8)
					(at w2 h7)
					(at w1 h5)
				)
			)
			(goal
				(and
					(~ (on-fire h8))
					(~ (on-fire h7))
					(has-brick-walls h2)
					(has-roof h5)
					(has-foundation h8)
					(has-foundation h3)
					(has-foundation h4)
					(has-brick-walls h6)
				)
			)
	)
)