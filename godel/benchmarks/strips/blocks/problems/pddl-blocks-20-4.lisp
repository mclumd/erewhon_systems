;;---------------------------------------------

(define (problem p20_4)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20)
(:init
	(arm-empty)
	(on-table b1) (on b2 b1) (on b3 b2) (on b4 b3) (clear b4)
	(on-table b5) (on b16 b5) (on b19 b16) (on b20 b19) (clear b20)
	(on-table b6) (on b9 b6) (on b17 b9) (clear b17)
	(on-table b7) (on b8 b7) (on b12 b8) (on b14 b12) (clear b14)
	(on-table b10) (on b13 b10) (clear b13)
	(on-table b11) (on b15 b11) (clear b15)
	(on-table b18) (clear b18)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b2 b1) (on b13 b2) (clear b13)
	(on-table b3) (on b4 b3) (on b6 b4) (on b12 b6) (on b15 b12) (on b16 b15) (on b19 b16) (clear b19)
	(on-table b5) (on b7 b5) (on b8 b7) (on b11 b8) (on b18 b11) (clear b18)
	(on-table b9) (on b17 b9) (clear b17)
	(on-table b10) (on b20 b10) (clear b20)
	(on-table b14) (clear b14)
))
)


