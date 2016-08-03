;;---------------------------------------------

(define (problem p20_14)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20)
(:init
	(arm-empty)
	(on-table b1) (on b2 b1) (on b4 b2) (on b12 b4) (clear b12)
	(on-table b3) (on b6 b3) (on b9 b6) (clear b9)
	(on-table b5) (on b7 b5) (on b8 b7) (on b16 b8) (on b18 b16) (on b20 b18) (clear b20)
	(on-table b10) (on b11 b10) (on b13 b11) (on b14 b13) (on b15 b14) (clear b15)
	(on-table b17) (on b19 b17) (clear b19)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b2 b1) (on b5 b2) (on b6 b5) (on b10 b6) (on b12 b10) (on b13 b12) (on b14 b13) (on b16 b14) (on b17 b16) (on b18 b17) (on b19 b18) (clear b19)
	(on-table b3) (on b4 b3) (on b7 b4) (on b8 b7) (on b9 b8) (on b11 b9) (clear b11)
	(on-table b15) (on b20 b15) (clear b20)
))
)


