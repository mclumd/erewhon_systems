;;---------------------------------------------

(define (problem p30_10)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30)
(:init
	(arm-empty)
	(on-table b1) (on b2 b1) (on b5 b2) (on b6 b5) (on b10 b6) (on b12 b10) (on b13 b12) (on b14 b13) (on b16 b14) (on b17 b16) (on b18 b17) (on b19 b18) (on b21 b19) (on b22 b21) (on b23 b22) (on b25 b23) (on b28 b25) (on b29 b28) (clear b29)
	(on-table b3) (on b4 b3) (on b7 b4) (on b8 b7) (on b9 b8) (on b11 b9) (on b26 b11) (clear b26)
	(on-table b15) (on b20 b15) (on b24 b20) (clear b24)
	(on-table b27) (on b30 b27) (clear b30)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b2 b1) (on b3 b2) (on b5 b3) (on b6 b5) (on b8 b6) (on b10 b8) (on b15 b10) (on b22 b15) (on b27 b22) (on b29 b27) (clear b29)
	(on-table b4) (on b7 b4) (on b9 b7) (on b11 b9) (on b12 b11) (on b14 b12) (on b16 b14) (on b18 b16) (on b20 b18) (on b21 b20) (on b23 b21) (on b30 b23) (clear b30)
	(on-table b13) (on b17 b13) (on b25 b17) (on b26 b25) (on b28 b26) (clear b28)
	(on-table b19) (on b24 b19) (clear b24)
))
)


