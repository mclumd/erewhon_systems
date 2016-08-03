;;---------------------------------------------

(define (problem p20_13)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20)
(:init
	(arm-empty)
	(on-table b1) (on b9 b1) (on b11 b9) (on b12 b11) (on b19 b12) (clear b19)
	(on-table b2) (on b13 b2) (clear b13)
	(on-table b3) (on b4 b3) (on b6 b4) (on b8 b6) (on b20 b8) (clear b20)
	(on-table b5) (on b15 b5) (on b16 b15) (on b17 b16) (clear b17)
	(on-table b7) (on b10 b7) (on b14 b10) (on b18 b14) (clear b18)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b2 b1) (on b3 b2) (on b4 b3) (on b5 b4) (on b10 b5) (clear b10)
	(on-table b6) (on b18 b6) (on b20 b18) (clear b20)
	(on-table b7) (on b11 b7) (on b12 b11) (on b15 b12) (on b16 b15) (on b17 b16) (clear b17)
	(on-table b8) (on b9 b8) (on b13 b9) (on b19 b13) (clear b19)
	(on-table b14) (clear b14)
))
)


