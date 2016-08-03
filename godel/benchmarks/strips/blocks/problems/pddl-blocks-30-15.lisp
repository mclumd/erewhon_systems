;;---------------------------------------------

(define (problem p30_15)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30)
(:init
	(arm-empty)
	(on-table b1) (on b3 b1) (on b27 b3) (on b29 b27) (clear b29)
	(on-table b2) (on b4 b2) (on b10 b4) (on b15 b10) (on b17 b15) (clear b17)
	(on-table b5) (on b11 b5) (on b19 b11) (clear b19)
	(on-table b6) (on b9 b6) (on b16 b9) (on b18 b16) (clear b18)
	(on-table b7) (on b12 b7) (on b20 b12) (on b21 b20) (on b22 b21) (on b23 b22) (on b28 b23) (on b30 b28) (clear b30)
	(on-table b8) (on b13 b8) (on b26 b13) (clear b26)
	(on-table b14) (clear b14)
	(on-table b24) (on b25 b24) (clear b25)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b4 b1) (on b7 b4) (on b11 b7) (on b13 b11) (on b19 b13) (clear b19)
	(on-table b2) (on b10 b2) (on b12 b10) (on b21 b12) (clear b21)
	(on-table b3) (clear b3)
	(on-table b5) (on b17 b5) (on b23 b17) (on b26 b23) (clear b26)
	(on-table b6) (on b8 b6) (on b14 b8) (on b16 b14) (on b18 b16) (clear b18)
	(on-table b9) (on b22 b9) (on b25 b22) (on b27 b25) (clear b27)
	(on-table b15) (on b20 b15) (on b24 b20) (clear b24)
	(on-table b28) (clear b28)
	(on-table b29) (on b30 b29) (clear b30)
))
)


