;;---------------------------------------------

(define (problem p20_23)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20)
(:init
	(arm-empty)
	(on-table b1) (on b2 b1) (on b3 b2) (on b4 b3) (on b5 b4) (on b6 b5) (on b9 b6) (clear b9)
	(on-table b7) (on b11 b7) (on b12 b11) (clear b12)
	(on-table b8) (on b10 b8) (on b14 b10) (on b17 b14) (on b18 b17) (clear b18)
	(on-table b13) (on b15 b13) (on b16 b15) (on b19 b16) (on b20 b19) (clear b20)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b2 b1) (on b3 b2) (on b6 b3) (on b7 b6) (on b9 b7) (on b11 b9) (on b12 b11) (on b14 b12) (on b15 b14) (on b18 b15) (on b19 b18) (clear b19)
	(on-table b4) (on b5 b4) (on b16 b5) (on b17 b16) (clear b17)
	(on-table b8) (on b13 b8) (on b20 b13) (clear b20)
	(on-table b10) (clear b10)
))
)


