(setf (current-problem)
	(create-problem
		(name p5)
			(objects
				(h1 h2 h4 h3 HOUSE)
				(w3 CONSTRUCTION-WORKER)
				(w1 FIREMAN)
				(w2 TEAMSTER)
				(m4 m1 m3 CONCRETE)
				(m5 WOOD)
				(m6 m2 BRICK)
				(m7 SHINGLE)
			)
			(state
				(and
					(has-foundation h2)
					(on-fire h3)
					(at m5 h3)
					(unused m5)
					(at m4 h3)
					(unused m4)
					(at m7 h3)
					(unused m7)
					(at m6 h1)
					(unused m6)
					(at m1 h1)
					(unused m1)
					(at m3 h2)
					(unused m3)
					(at m2 h4)
					(unused m2)
					(at w3 HQ)
					(at w2 h4)
					(at w1 h4)
				)
			)
			(goal
				(and
					(~ (on-fire h3))
					(has-brick-walls h4)
					(has-foundation h3)
					(has-wood-walls h1)
					(has-roof h2)
				)
			)
	)
)