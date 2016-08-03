;;---------------------------------------------

(define (problem p20_16)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20)
(:init
	(arm-empty)
	(on-table b1) (on b5 b1) (on b8 b5) (on b9 b8) (clear b9)
	(on-table b2) (on b3 b2) (on b15 b3) (clear b15)
	(on-table b4) (on b6 b4) (on b7 b6) (on b12 b7) (on b17 b12) (on b20 b17) (clear b20)
	(on-table b10) (clear b10)
	(on-table b11) (clear b11)
	(on-table b13) (on b14 b13) (on b18 b14) (on b19 b18) (clear b19)
	(on-table b16) (clear b16)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b6 b1) (on b16 b6) (clear b16)
	(on-table b2) (on b3 b2) (on b11 b3) (on b17 b11) (clear b17)
	(on-table b4) (on b5 b4) (on b8 b5) (clear b8)
	(on-table b7) (on b9 b7) (on b10 b9) (on b12 b10) (on b13 b12) (on b18 b13) (clear b18)
	(on-table b14) (on b15 b14) (clear b15)
	(on-table b19) (on b20 b19) (clear b20)
))
)


