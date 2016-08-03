;;---------------------------------------------

(define (problem p30_22)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30)
(:init
	(arm-empty)
	(on-table b1) (on b2 b1) (on b6 b2) (on b12 b6) (on b13 b12) (on b16 b13) (on b29 b16) (clear b29)
	(on-table b3) (on b10 b3) (on b11 b10) (on b14 b11) (on b25 b14) (clear b25)
	(on-table b4) (on b5 b4) (on b7 b5) (on b8 b7) (on b15 b8) (on b17 b15) (on b18 b17) (on b23 b18) (clear b23)
	(on-table b9) (on b21 b9) (on b28 b21) (clear b28)
	(on-table b19) (on b24 b19) (on b30 b24) (clear b30)
	(on-table b20) (on b22 b20) (clear b22)
	(on-table b26) (on b27 b26) (clear b27)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b6 b1) (on b8 b6) (on b16 b8) (on b17 b16) (on b27 b17) (on b28 b27) (clear b28)
	(on-table b2) (on b3 b2) (on b5 b3) (on b20 b5) (on b24 b20) (on b25 b24) (on b30 b25) (clear b30)
	(on-table b4) (on b7 b4) (on b10 b7) (on b13 b10) (on b29 b13) (clear b29)
	(on-table b9) (on b22 b9) (clear b22)
	(on-table b11) (on b12 b11) (on b18 b12) (on b21 b18) (on b23 b21) (clear b23)
	(on-table b14) (on b15 b14) (clear b15)
	(on-table b19) (on b26 b19) (clear b26)
))
)


