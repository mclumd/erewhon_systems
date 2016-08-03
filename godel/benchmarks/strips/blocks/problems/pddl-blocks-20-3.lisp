;;---------------------------------------------

(define (problem p20_3)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20)
(:init
	(arm-empty)
	(on-table b1) (on b3 b1) (on b7 b3) (on b11 b7) (on b12 b11) (on b13 b12) (on b17 b13) (clear b17)
	(on-table b2) (on b4 b2) (on b6 b4) (on b9 b6) (clear b9)
	(on-table b5) (on b10 b5) (on b14 b10) (clear b14)
	(on-table b8) (on b15 b8) (on b16 b15) (on b18 b16) (on b19 b18) (clear b19)
	(on-table b20) (clear b20)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b3 b1) (on b5 b3) (on b13 b5) (on b14 b13) (on b16 b14) (on b17 b16) (on b20 b17) (clear b20)
	(on-table b2) (on b4 b2) (on b7 b4) (on b18 b7) (clear b18)
	(on-table b6) (on b15 b6) (clear b15)
	(on-table b8) (on b10 b8) (on b11 b10) (on b12 b11) (clear b12)
	(on-table b9) (on b19 b9) (clear b19)
))
)


