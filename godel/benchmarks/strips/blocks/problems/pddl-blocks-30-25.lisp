;;---------------------------------------------

(define (problem p30_25)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30)
(:init
	(arm-empty)
	(on-table b1) (on b2 b1) (on b3 b2) (on b4 b3) (on b9 b4) (on b15 b9) (on b24 b15) (on b27 b24) (clear b27)
	(on-table b5) (on b13 b5) (on b17 b13) (on b26 b17) (on b28 b26) (on b30 b28) (clear b30)
	(on-table b6) (on b11 b6) (on b14 b11) (on b18 b14) (clear b18)
	(on-table b7) (on b8 b7) (on b10 b8) (on b25 b10) (on b29 b25) (clear b29)
	(on-table b12) (on b22 b12) (clear b22)
	(on-table b16) (on b19 b16) (on b20 b19) (on b21 b20) (on b23 b21) (clear b23)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b5 b1) (on b9 b5) (on b11 b9) (on b15 b11) (on b17 b15) (on b19 b17) (on b21 b19) (on b22 b21) (clear b22)
	(on-table b2) (on b4 b2) (on b8 b4) (on b18 b8) (on b23 b18) (on b30 b23) (clear b30)
	(on-table b3) (on b12 b3) (on b14 b12) (on b20 b14) (on b29 b20) (clear b29)
	(on-table b6) (on b13 b6) (on b16 b13) (on b25 b16) (on b27 b25) (on b28 b27) (clear b28)
	(on-table b7) (on b10 b7) (on b24 b10) (clear b24)
	(on-table b26) (clear b26)
))
)


