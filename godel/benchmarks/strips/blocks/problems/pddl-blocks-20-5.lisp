;;---------------------------------------------

(define (problem p20_5)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20)
(:init
	(arm-empty)
	(on-table b1) (on b3 b1) (on b11 b3) (on b20 b11) (clear b20)
	(on-table b2) (on b5 b2) (on b9 b5) (on b14 b9) (on b15 b14) (on b17 b15) (on b18 b17) (on b19 b18) (clear b19)
	(on-table b4) (on b6 b4) (on b8 b6) (on b10 b8) (on b13 b10) (on b16 b13) (clear b16)
	(on-table b7) (on b12 b7) (clear b12)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b8 b1) (on b9 b8) (on b12 b9) (clear b12)
	(on-table b2) (on b3 b2) (on b4 b3) (on b11 b4) (on b13 b11) (on b16 b13) (clear b16)
	(on-table b5) (on b6 b5) (on b14 b6) (on b15 b14) (clear b15)
	(on-table b7) (on b10 b7) (on b19 b10) (clear b19)
	(on-table b17) (on b18 b17) (clear b18)
	(on-table b20) (clear b20)
))
)


