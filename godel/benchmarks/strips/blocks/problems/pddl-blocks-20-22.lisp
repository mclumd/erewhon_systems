;;---------------------------------------------

(define (problem p20_22)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20)
(:init
	(arm-empty)
	(on-table b1) (on b3 b1) (clear b3)
	(on-table b2) (on b4 b2) (on b10 b4) (on b15 b10) (on b17 b15) (clear b17)
	(on-table b5) (on b11 b5) (on b19 b11) (clear b19)
	(on-table b6) (on b9 b6) (on b16 b9) (on b18 b16) (clear b18)
	(on-table b7) (on b12 b7) (on b20 b12) (clear b20)
	(on-table b8) (on b13 b8) (clear b13)
	(on-table b14) (clear b14)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b2 b1) (on b3 b2) (on b7 b3) (on b11 b7) (on b12 b11) (clear b12)
	(on-table b4) (on b5 b4) (on b8 b5) (on b20 b8) (clear b20)
	(on-table b6) (on b9 b6) (on b14 b9) (on b16 b14) (clear b16)
	(on-table b10) (on b19 b10) (clear b19)
	(on-table b13) (on b18 b13) (clear b18)
	(on-table b15) (clear b15)
	(on-table b17) (clear b17)
))
)


