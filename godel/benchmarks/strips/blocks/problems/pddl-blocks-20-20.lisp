;;---------------------------------------------

(define (problem p20_20)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20)
(:init
	(arm-empty)
	(on-table b1) (on b2 b1) (on b3 b2) (on b4 b3) (on b7 b4) (on b8 b7) (on b9 b8) (on b10 b9) (on b11 b10) (clear b11)
	(on-table b5) (on b6 b5) (on b16 b6) (on b18 b16) (clear b18)
	(on-table b12) (on b13 b12) (on b14 b13) (on b20 b14) (clear b20)
	(on-table b15) (on b17 b15) (on b19 b17) (clear b19)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b2 b1) (on b20 b2) (clear b20)
	(on-table b3) (on b4 b3) (on b8 b4) (on b9 b8) (on b11 b9) (clear b11)
	(on-table b5) (on b7 b5) (on b10 b7) (on b17 b10) (clear b17)
	(on-table b6) (on b13 b6) (on b14 b13) (on b16 b14) (on b18 b16) (on b19 b18) (clear b19)
	(on-table b12) (clear b12)
	(on-table b15) (clear b15)
))
)


