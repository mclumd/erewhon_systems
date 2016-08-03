;;---------------------------------------------

(define (problem p20_7)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20)
(:init
	(arm-empty)
	(on-table b1) (on b3 b1) (on b19 b3) (clear b19)
	(on-table b2) (on b8 b2) (on b9 b8) (on b18 b9) (clear b18)
	(on-table b4) (on b5 b4) (on b6 b5) (on b7 b6) (on b10 b7) (on b13 b10) (on b15 b13) (on b16 b15) (on b17 b16) (clear b17)
	(on-table b11) (on b12 b11) (clear b12)
	(on-table b14) (clear b14)
	(on-table b20) (clear b20)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b10 b1) (on b13 b10) (clear b13)
	(on-table b2) (on b3 b2) (on b4 b3) (on b7 b4) (on b16 b7) (on b17 b16) (clear b17)
	(on-table b5) (on b8 b5) (on b19 b8) (clear b19)
	(on-table b6) (on b12 b6) (on b18 b12) (on b20 b18) (clear b20)
	(on-table b9) (on b11 b9) (on b14 b11) (on b15 b14) (clear b15)
))
)


