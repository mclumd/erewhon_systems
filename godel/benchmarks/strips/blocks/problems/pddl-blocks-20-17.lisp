;;---------------------------------------------

(define (problem p20_17)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20)
(:init
	(arm-empty)
	(on-table b1) (on b2 b1) (on b13 b2) (clear b13)
	(on-table b3) (on b6 b3) (on b8 b6) (on b17 b8) (clear b17)
	(on-table b4) (on b10 b4) (clear b10)
	(on-table b5) (on b7 b5) (on b9 b7) (on b14 b9) (on b18 b14) (clear b18)
	(on-table b11) (on b12 b11) (clear b12)
	(on-table b15) (on b19 b15) (clear b19)
	(on-table b16) (clear b16)
	(on-table b20) (clear b20)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b2 b1) (on b11 b2) (on b18 b11) (clear b18)
	(on-table b3) (on b4 b3) (on b5 b4) (on b13 b5) (on b14 b13) (clear b14)
	(on-table b6) (on b10 b6) (on b12 b10) (on b15 b12) (clear b15)
	(on-table b7) (on b8 b7) (on b9 b8) (on b17 b9) (clear b17)
	(on-table b16) (clear b16)
	(on-table b19) (clear b19)
	(on-table b20) (clear b20)
))
)


