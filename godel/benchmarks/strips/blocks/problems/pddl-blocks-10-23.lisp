;;---------------------------------------------

(define (problem p10_23)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10)
(:init
	(arm-empty)
	(on-table b1) (on b4 b1) (on b7 b4) (clear b7)
	(on-table b2) (on b5 b2) (clear b5)
	(on-table b3) (on b6 b3) (clear b6)
	(on-table b8) (clear b8)
	(on-table b9) (clear b9)
	(on-table b10) (clear b10)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b7 b1) (on b8 b7) (clear b8)
	(on-table b2) (on b3 b2) (on b4 b3) (on b5 b4) (on b6 b5) (on b9 b6) (clear b9)
	(on-table b10) (clear b10)
))
)


