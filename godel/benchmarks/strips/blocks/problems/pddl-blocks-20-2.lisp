;;---------------------------------------------

(define (problem p20_2)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20)
(:init
	(arm-empty)
	(on-table b1) (on b2 b1) (on b4 b2) (clear b4)
	(on-table b3) (on b5 b3) (on b7 b5) (on b10 b7) (on b15 b10) (on b16 b15) (clear b16)
	(on-table b6) (on b8 b6) (on b14 b8) (on b19 b14) (clear b19)
	(on-table b9) (clear b9)
	(on-table b11) (clear b11)
	(on-table b12) (clear b12)
	(on-table b13) (on b20 b13) (clear b20)
	(on-table b17) (on b18 b17) (clear b18)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b6 b1) (on b16 b6) (clear b16)
	(on-table b2) (on b4 b2) (on b15 b4) (clear b15)
	(on-table b3) (on b7 b3) (on b8 b7) (on b10 b8) (on b12 b10) (on b13 b12) (on b18 b13) (clear b18)
	(on-table b5) (on b9 b5) (on b11 b9) (on b20 b11) (clear b20)
	(on-table b14) (clear b14)
	(on-table b17) (on b19 b17) (clear b19)
))
)


