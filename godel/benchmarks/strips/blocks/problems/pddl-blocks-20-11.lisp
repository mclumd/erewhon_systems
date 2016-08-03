;;---------------------------------------------

(define (problem p20_11)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20)
(:init
	(arm-empty)
	(on-table b1) (on b2 b1) (on b5 b2) (on b6 b5) (on b9 b6) (on b14 b9) (on b16 b14) (clear b16)
	(on-table b3) (on b7 b3) (on b11 b7) (on b12 b11) (on b17 b12) (on b19 b17) (clear b19)
	(on-table b4) (on b8 b4) (on b15 b8) (clear b15)
	(on-table b10) (on b13 b10) (clear b13)
	(on-table b18) (on b20 b18) (clear b20)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b3 b1) (on b15 b3) (on b19 b15) (clear b19)
	(on-table b2) (on b5 b2) (on b11 b5) (clear b11)
	(on-table b4) (on b7 b4) (on b10 b7) (on b18 b10) (clear b18)
	(on-table b6) (on b9 b6) (clear b9)
	(on-table b8) (on b12 b8) (on b13 b12) (on b14 b13) (clear b14)
	(on-table b16) (on b17 b16) (on b20 b17) (clear b20)
))
)


