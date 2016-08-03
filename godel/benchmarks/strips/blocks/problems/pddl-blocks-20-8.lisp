;;---------------------------------------------

(define (problem p20_8)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20)
(:init
	(arm-empty)
	(on-table b1) (on b2 b1) (on b3 b2) (on b4 b3) (on b5 b4) (on b9 b5) (on b10 b9) (on b12 b10) (on b15 b12) (clear b15)
	(on-table b6) (on b7 b6) (on b8 b7) (on b13 b8) (on b14 b13) (clear b14)
	(on-table b11) (clear b11)
	(on-table b16) (clear b16)
	(on-table b17) (clear b17)
	(on-table b18) (on b19 b18) (clear b19)
	(on-table b20) (clear b20)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b5 b1) (on b8 b5) (clear b8)
	(on-table b2) (on b3 b2) (on b6 b3) (on b9 b6) (on b13 b9) (on b15 b13) (on b16 b15) (on b17 b16) (on b20 b17) (clear b20)
	(on-table b4) (on b7 b4) (on b14 b7) (clear b14)
	(on-table b10) (on b11 b10) (on b12 b11) (clear b12)
	(on-table b18) (on b19 b18) (clear b19)
))
)


