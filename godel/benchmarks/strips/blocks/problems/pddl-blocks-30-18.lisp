;;---------------------------------------------

(define (problem p30_18)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30)
(:init
	(arm-empty)
	(on-table b1) (on b6 b1) (on b7 b6) (on b8 b7) (on b9 b8) (on b11 b9) (on b12 b11) (on b13 b12) (on b14 b13) (on b19 b14) (on b21 b19) (clear b21)
	(on-table b2) (on b3 b2) (on b4 b3) (on b5 b4) (on b15 b5) (on b16 b15) (on b18 b16) (on b20 b18) (on b22 b20) (on b23 b22) (on b26 b23) (on b27 b26) (clear b27)
	(on-table b10) (on b17 b10) (on b24 b17) (clear b24)
	(on-table b25) (on b28 b25) (on b29 b28) (on b30 b29) (clear b30)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b2 b1) (on b3 b2) (on b12 b3) (on b13 b12) (on b26 b13) (clear b26)
	(on-table b4) (on b8 b4) (on b14 b8) (on b20 b14) (on b27 b20) (on b29 b27) (clear b29)
	(on-table b5) (on b15 b5) (on b16 b15) (on b17 b16) (on b22 b17) (on b24 b22) (clear b24)
	(on-table b6) (on b7 b6) (on b10 b7) (on b18 b10) (on b19 b18) (on b21 b19) (on b28 b21) (clear b28)
	(on-table b9) (on b11 b9) (on b25 b11) (on b30 b25) (clear b30)
	(on-table b23) (clear b23)
))
)


