;;---------------------------------------------

(define (problem p20_21)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20)
(:init
	(arm-empty)
	(on-table b1) (on b3 b1) (on b5 b3) (on b15 b5) (clear b15)
	(on-table b2) (on b12 b2) (on b13 b12) (clear b13)
	(on-table b4) (on b8 b4) (on b11 b8) (clear b11)
	(on-table b6) (on b7 b6) (on b14 b7) (on b17 b14) (clear b17)
	(on-table b9) (on b10 b9) (clear b10)
	(on-table b16) (clear b16)
	(on-table b18) (on b19 b18) (clear b19)
	(on-table b20) (clear b20)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b2 b1) (on b3 b2) (on b4 b3) (on b5 b4) (on b7 b5) (on b11 b7) (on b12 b11) (on b15 b12) (on b16 b15) (clear b16)
	(on-table b6) (on b8 b6) (on b9 b8) (on b10 b9) (on b14 b10) (on b17 b14) (clear b17)
	(on-table b13) (clear b13)
	(on-table b18) (on b19 b18) (clear b19)
	(on-table b20) (clear b20)
))
)


