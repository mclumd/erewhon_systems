;;---------------------------------------------

(define (problem p10_16)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10)
(:init
	(arm-empty)
	(on-table b1) (on b5 b1) (on b8 b5) (clear b8)
	(on-table b2) (on b3 b2) (on b6 b3) (on b9 b6) (clear b9)
	(on-table b4) (on b7 b4) (clear b7)
	(on-table b10) (clear b10)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b2 b1) (on b3 b2) (on b4 b3) (on b5 b4) (on b8 b5) (clear b8)
	(on-table b6) (on b7 b6) (on b9 b7) (on b10 b9) (clear b10)
))
)


