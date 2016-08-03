;;---------------------------------------------

(define (problem p20_24)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20)
(:init
	(arm-empty)
	(on-table b1) (on b2 b1) (on b3 b2) (on b5 b3) (on b7 b5) (on b12 b7) (on b14 b12) (on b15 b14) (clear b15)
	(on-table b4) (on b11 b4) (clear b11)
	(on-table b6) (on b8 b6) (on b9 b8) (on b17 b9) (clear b17)
	(on-table b10) (on b16 b10) (clear b16)
	(on-table b13) (on b18 b13) (on b19 b18) (clear b19)
	(on-table b20) (clear b20)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b2 b1) (on b8 b2) (on b13 b8) (on b14 b13) (clear b14)
	(on-table b3) (on b5 b3) (on b15 b5) (on b19 b15) (clear b19)
	(on-table b4) (on b6 b4) (on b9 b6) (on b10 b9) (on b12 b10) (on b17 b12) (clear b17)
	(on-table b7) (on b11 b7) (on b16 b11) (on b18 b16) (on b20 b18) (clear b20)
))
)


