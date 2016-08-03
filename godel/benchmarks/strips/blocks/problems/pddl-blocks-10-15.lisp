;;---------------------------------------------

(define (problem p10_15)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10)
(:init
	(arm-empty)
	(on-table b1) (on b2 b1) (on b3 b2) (on b4 b3) (on b5 b4) (on b9 b5) (on b10 b9) (clear b10)
	(on-table b6) (on b7 b6) (on b8 b7) (clear b8)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b2 b1) (on b5 b2) (clear b5)
	(on-table b3) (clear b3)
	(on-table b4) (clear b4)
	(on-table b6) (clear b6)
	(on-table b7) (clear b7)
	(on-table b8) (on b9 b8) (clear b9)
	(on-table b10) (clear b10)
))
)


