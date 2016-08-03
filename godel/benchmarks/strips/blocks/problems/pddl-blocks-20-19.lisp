;;---------------------------------------------

(define (problem p20_19)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20)
(:init
	(arm-empty)
	(on-table b1) (on b10 b1) (on b11 b10) (on b15 b11) (clear b15)
	(on-table b2) (on b3 b2) (clear b3)
	(on-table b4) (on b5 b4) (on b9 b5) (on b13 b9) (on b16 b13) (clear b16)
	(on-table b6) (on b8 b6) (clear b8)
	(on-table b7) (on b12 b7) (on b14 b12) (on b20 b14) (clear b20)
	(on-table b17) (on b18 b17) (clear b18)
	(on-table b19) (clear b19)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b5 b1) (on b13 b5) (on b17 b13) (clear b17)
	(on-table b2) (on b6 b2) (clear b6)
	(on-table b3) (clear b3)
	(on-table b4) (on b7 b4) (clear b7)
	(on-table b8) (clear b8)
	(on-table b9) (on b12 b9) (on b16 b12) (on b20 b16) (clear b20)
	(on-table b10) (on b14 b10) (on b15 b14) (clear b15)
	(on-table b11) (on b18 b11) (on b19 b18) (clear b19)
))
)


