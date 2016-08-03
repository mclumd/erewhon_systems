;;---------------------------------------------

(define (problem p30_17)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30)
(:init
	(arm-empty)
	(on-table b1) (on b2 b1) (on b3 b2) (on b4 b3) (on b6 b4) (on b7 b6) (on b13 b7) (on b21 b13) (on b30 b21) (clear b30)
	(on-table b5) (on b8 b5) (on b9 b8) (on b12 b9) (on b24 b12) (clear b24)
	(on-table b10) (on b15 b10) (on b18 b15) (on b19 b18) (on b25 b19) (clear b25)
	(on-table b11) (on b16 b11) (on b27 b16) (clear b27)
	(on-table b14) (on b17 b14) (on b20 b17) (clear b20)
	(on-table b22) (on b23 b22) (clear b23)
	(on-table b26) (on b28 b26) (on b29 b28) (clear b29)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b2 b1) (on b7 b2) (on b9 b7) (on b10 b9) (on b12 b10) (on b14 b12) (on b16 b14) (on b20 b16) (on b23 b20) (clear b23)
	(on-table b3) (on b21 b3) (clear b21)
	(on-table b4) (on b11 b4) (on b18 b11) (on b29 b18) (on b30 b29) (clear b30)
	(on-table b5) (on b6 b5) (on b8 b6) (on b17 b8) (on b22 b17) (on b26 b22) (clear b26)
	(on-table b13) (on b15 b13) (on b19 b15) (clear b19)
	(on-table b24) (clear b24)
	(on-table b25) (on b28 b25) (clear b28)
	(on-table b27) (clear b27)
))
)


