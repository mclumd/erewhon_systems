;;---------------------------------------------

(define (problem p20_9)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20)
(:init
	(arm-empty)
	(on-table b1) (on b4 b1) (on b7 b4) (on b10 b7) (on b11 b10) (on b14 b11) (on b18 b14) (clear b18)
	(on-table b2) (on b5 b2) (on b6 b5) (on b9 b6) (on b13 b9) (on b20 b13) (clear b20)
	(on-table b3) (on b12 b3) (on b15 b12) (clear b15)
	(on-table b8) (on b17 b8) (clear b17)
	(on-table b16) (clear b16)
	(on-table b19) (clear b19)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b6 b1) (on b7 b6) (clear b7)
	(on-table b2) (on b3 b2) (on b8 b3) (on b13 b8) (on b15 b13) (on b20 b15) (clear b20)
	(on-table b4) (on b5 b4) (on b9 b5) (on b17 b9) (on b19 b17) (clear b19)
	(on-table b10) (on b11 b10) (on b14 b11) (clear b14)
	(on-table b12) (clear b12)
	(on-table b16) (on b18 b16) (clear b18)
))
)


