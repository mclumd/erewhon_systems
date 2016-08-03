;;---------------------------------------------

(define (problem p20_10)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20)
(:init
	(arm-empty)
	(on-table b1) (on b4 b1) (on b7 b4) (on b8 b7) (on b19 b8) (clear b19)
	(on-table b2) (on b3 b2) (on b5 b3) (on b6 b5) (on b12 b6) (on b14 b12) (on b15 b14) (on b17 b15) (clear b17)
	(on-table b9) (on b13 b9) (clear b13)
	(on-table b10) (on b11 b10) (on b16 b11) (on b18 b16) (on b20 b18) (clear b20)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b3 b1) (on b4 b3) (on b9 b4) (clear b9)
	(on-table b2) (on b5 b2) (on b7 b5) (on b8 b7) (on b12 b8) (clear b12)
	(on-table b6) (on b13 b6) (on b15 b13) (clear b15)
	(on-table b10) (on b11 b10) (clear b11)
	(on-table b14) (on b16 b14) (on b18 b16) (clear b18)
	(on-table b17) (clear b17)
	(on-table b19) (clear b19)
	(on-table b20) (clear b20)
))
)


