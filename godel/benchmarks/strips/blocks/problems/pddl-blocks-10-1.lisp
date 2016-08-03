;;---------------------------------------------

(define (problem p10_1)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10)
(:init
	(arm-empty)
	(on-table b1) (on b2 b1) (on b3 b2) (clear b3)
	(on-table b4) (on b5 b4) (on b6 b5) (clear b6)
	(on-table b7) (clear b7)
	(on-table b8) (on b9 b8) (clear b9)
	(on-table b10) (clear b10)
)
(:goal
	(and (on-table b1) (on b2 b1) (on b4 b2) (on b6 b4) (on b7 b6) (on b9 b7) (clear b9)
	(on-table b3) (clear b3)
	(on-table b5) (on b10 b5) (clear b10)
	(on-table b8) (clear b8)
))
)


