;;---------------------------------------------

(define (problem p10_17)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10)
(:init
	(arm-empty)
	(on-table b1) (on b4 b1) (on b7 b4) (on b10 b7) (clear b10)
	(on-table b2) (on b5 b2) (on b6 b5) (on b9 b6) (clear b9)
	(on-table b3) (clear b3)
	(on-table b8) (clear b8)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b2 b1) (on b3 b2) (on b10 b3) (clear b10)
	(on-table b4) (on b6 b4) (on b8 b6) (on b9 b8) (clear b9)
	(on-table b5) (clear b5)
	(on-table b7) (clear b7)
))
)


