;;---------------------------------------------

(define (problem p20_25)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20)
(:init
	(arm-empty)
	(on-table b1) (on b2 b1) (on b3 b2) (on b4 b3) (on b6 b4) (on b7 b6) (on b13 b7) (clear b13)
	(on-table b5) (on b8 b5) (on b9 b8) (on b12 b9) (clear b12)
	(on-table b10) (on b15 b10) (on b18 b15) (on b19 b18) (clear b19)
	(on-table b11) (on b16 b11) (clear b16)
	(on-table b14) (on b17 b14) (on b20 b17) (clear b20)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b9 b1) (on b12 b9) (on b14 b12) (on b15 b14) (on b17 b15) (on b19 b17) (on b20 b19) (clear b20)
	(on-table b2) (on b3 b2) (on b4 b3) (on b5 b4) (on b8 b5) (on b13 b8) (clear b13)
	(on-table b6) (on b11 b6) (clear b11)
	(on-table b7) (on b10 b7) (on b16 b10) (on b18 b16) (clear b18)
))
)


