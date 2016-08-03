;;---------------------------------------------

(define (problem p10_12)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10)
(:init
	(arm-empty)
	(on-table b1) (on b4 b1) (on b5 b4) (on b10 b5) (clear b10)
	(on-table b2) (on b6 b2) (on b7 b6) (on b8 b7) (clear b8)
	(on-table b3) (on b9 b3) (clear b9)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b4 b1) (clear b4)
	(on-table b2) (on b3 b2) (on b5 b3) (on b6 b5) (on b7 b6) (on b9 b7) (clear b9)
	(on-table b8) (on b10 b8) (clear b10)
))
)


