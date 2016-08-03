;;---------------------------------------------

(define (problem p20_1)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20)
(:init
	(arm-empty)
	(on-table b1) (on b2 b1) (on b3 b2) (on b14 b3) (on b17 b14) (clear b17)
	(on-table b4) (on b5 b4) (on b6 b5) (on b13 b6) (clear b13)
	(on-table b7) (on b11 b7) (on b12 b11) (clear b12)
	(on-table b8) (on b9 b8) (clear b9)
	(on-table b10) (clear b10)
	(on-table b15) (clear b15)
	(on-table b16) (on b19 b16) (clear b19)
	(on-table b18) (clear b18)
	(on-table b20) (clear b20)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b4 b1) (on b12 b4) (on b15 b12) (on b18 b15) (on b20 b18) (clear b20)
	(on-table b2) (on b5 b2) (on b11 b5) (on b13 b11) (on b16 b13) (on b19 b16) (clear b19)
	(on-table b3) (on b9 b3) (on b10 b9) (clear b10)
	(on-table b6) (on b14 b6) (clear b14)
	(on-table b7) (on b17 b7) (clear b17)
	(on-table b8) (clear b8)
))
)

