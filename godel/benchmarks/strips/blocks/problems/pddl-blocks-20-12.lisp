;;---------------------------------------------

(define (problem p20_12)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20)
(:init
	(arm-empty)
	(on-table b1) (on b4 b1) (on b7 b4) (on b11 b7) (on b14 b11) (on b18 b14) (clear b18)
	(on-table b2) (on b5 b2) (on b12 b5) (on b13 b12) (clear b13)
	(on-table b3) (on b6 b3) (on b15 b6) (on b16 b15) (clear b16)
	(on-table b8) (clear b8)
	(on-table b9) (on b17 b9) (on b19 b17) (clear b19)
	(on-table b10) (on b20 b10) (clear b20)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b2 b1) (on b9 b2) (on b12 b9) (on b17 b12) (clear b17)
	(on-table b3) (on b4 b3) (on b5 b4) (on b6 b5) (on b11 b6) (on b13 b11) (on b15 b13) (on b16 b15) (on b18 b16) (clear b18)
	(on-table b7) (clear b7)
	(on-table b8) (on b10 b8) (on b14 b10) (clear b14)
	(on-table b19) (on b20 b19) (clear b20)
))
)


