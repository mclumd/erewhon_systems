;;---------------------------------------------

(define (problem p10_13)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10)
(:init
	(arm-empty)
	(on-table b1) (on b3 b1) (clear b3)
	(on-table b2) (on b8 b2) (on b9 b8) (clear b9)
	(on-table b4) (on b5 b4) (on b6 b5) (on b7 b6) (on b10 b7) (clear b10)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b4 b1) (on b5 b4) (on b6 b5) (clear b6)
	(on-table b2) (clear b2)
	(on-table b3) (on b7 b3) (on b9 b7) (clear b9)
	(on-table b8) (clear b8)
	(on-table b10) (clear b10)
))
)


