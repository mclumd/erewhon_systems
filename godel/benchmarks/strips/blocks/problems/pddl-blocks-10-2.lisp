;;---------------------------------------------

(define (problem p10_2)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10)
(:init
	(arm-empty)
	(on-table b1) (on b4 b1) (clear b4)
	(on-table b2) (on b5 b2) (clear b5)
	(on-table b3) (on b9 b3) (on b10 b9) (clear b10)
	(on-table b6) (clear b6)
	(on-table b7) (clear b7)
	(on-table b8) (clear b8)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b2 b1) (clear b2)
	(on-table b3) (on b4 b3) (on b5 b4) (on b6 b5) (on b7 b6) (clear b7)
	(on-table b8) (clear b8)
	(on-table b9) (on b10 b9) (clear b10)
))
)


