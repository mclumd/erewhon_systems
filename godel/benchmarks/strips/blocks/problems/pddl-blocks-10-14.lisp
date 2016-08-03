;;---------------------------------------------

(define (problem p10_14)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10)
(:init
	(arm-empty)
	(on-table b1) (on b10 b1) (clear b10)
	(on-table b2) (on b3 b2) (on b4 b3) (on b7 b4) (clear b7)
	(on-table b5) (on b8 b5) (clear b8)
	(on-table b6) (clear b6)
	(on-table b9) (clear b9)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b3 b1) (on b8 b3) (clear b8)
	(on-table b2) (on b4 b2) (on b5 b4) (on b6 b5) (on b7 b6) (on b10 b7) (clear b10)
	(on-table b9) (clear b9)
))
)


