;;---------------------------------------------

(define (problem p30_8)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30)
(:init
	(arm-empty)
	(on-table b1) (on b3 b1) (on b15 b3) (on b19 b15) (on b28 b19) (on b30 b28) (clear b30)
	(on-table b2) (on b5 b2) (on b11 b5) (on b21 b11) (on b22 b21) (on b29 b22) (clear b29)
	(on-table b4) (on b7 b4) (on b10 b7) (on b18 b10) (clear b18)
	(on-table b6) (on b9 b6) (on b23 b9) (clear b23)
	(on-table b8) (on b12 b8) (on b13 b12) (on b14 b13) (clear b14)
	(on-table b16) (on b17 b16) (on b20 b17) (on b24 b20) (on b25 b24) (on b26 b25) (on b27 b26) (clear b27)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b7 b1) (on b8 b7) (clear b8)
	(on-table b2) (on b3 b2) (on b4 b3) (on b5 b4) (on b6 b5) (on b9 b6) (on b18 b9) (on b20 b18) (on b24 b20) (on b26 b24) (clear b26)
	(on-table b10) (on b12 b10) (on b13 b12) (on b15 b13) (on b17 b15) (on b29 b17) (clear b29)
	(on-table b11) (on b14 b11) (on b21 b14) (on b25 b21) (on b28 b25) (clear b28)
	(on-table b16) (on b22 b16) (on b23 b22) (clear b23)
	(on-table b19) (on b27 b19) (on b30 b27) (clear b30)
))
)

