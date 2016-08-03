;;---------------------------------------------

(define (problem p20_18)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20)
(:init
	(arm-empty)
	(on-table b1) (on b10 b1) (on b18 b10) (clear b18)
	(on-table b2) (on b3 b2) (on b4 b3) (on b5 b4) (on b12 b5) (on b19 b12) (clear b19)
	(on-table b6) (on b7 b6) (on b9 b7) (on b13 b9) (clear b13)
	(on-table b8) (on b11 b8) (clear b11)
	(on-table b14) (on b15 b14) (on b16 b15) (on b17 b16) (on b20 b17) (clear b20)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b5 b1) (on b6 b5) (on b8 b6) (on b15 b8) (clear b15)
	(on-table b2) (on b14 b2) (on b19 b14) (clear b19)
	(on-table b3) (on b10 b3) (on b20 b10) (clear b20)
	(on-table b4) (on b7 b4) (on b11 b7) (clear b11)
	(on-table b9) (on b13 b9) (on b16 b13) (on b18 b16) (clear b18)
	(on-table b12) (clear b12)
	(on-table b17) (clear b17)
))
)


