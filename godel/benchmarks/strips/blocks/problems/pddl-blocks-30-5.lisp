;;---------------------------------------------

(define (problem p30_5)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30)
(:init
	(arm-empty)
	(on-table b1) (on b3 b1) (on b19 b3) (on b23 b19) (on b30 b23) (clear b30)
	(on-table b2) (on b8 b2) (on b9 b8) (on b18 b9) (on b22 b18) (on b25 b22) (on b29 b25) (clear b29)
	(on-table b4) (on b5 b4) (on b6 b5) (on b7 b6) (on b10 b7) (on b13 b10) (on b15 b13) (on b16 b15) (on b17 b16) (on b27 b17) (clear b27)
	(on-table b11) (on b12 b11) (on b26 b12) (clear b26)
	(on-table b14) (clear b14)
	(on-table b20) (on b28 b20) (clear b28)
	(on-table b21) (on b24 b21) (clear b24)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b3 b1) (on b8 b3) (on b12 b8) (on b22 b12) (clear b22)
	(on-table b2) (on b4 b2) (on b5 b4) (on b6 b5) (on b7 b6) (on b10 b7) (on b24 b10) (on b25 b24) (on b27 b25) (clear b27)
	(on-table b9) (on b11 b9) (on b13 b11) (on b14 b13) (on b15 b14) (on b17 b15) (on b21 b17) (on b29 b21) (clear b29)
	(on-table b16) (on b19 b16) (on b20 b19) (on b28 b20) (clear b28)
	(on-table b18) (on b30 b18) (clear b30)
	(on-table b23) (clear b23)
	(on-table b26) (clear b26)
))
)


