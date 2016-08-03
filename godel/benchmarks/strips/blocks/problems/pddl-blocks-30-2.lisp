;;---------------------------------------------

(define (problem p30_2)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30)
(:init
	(arm-empty)
	(on-table b1) (on b6 b1) (on b16 b6) (clear b16)
	(on-table b2) (on b4 b2) (on b15 b4) (on b24 b15) (clear b24)
	(on-table b3) (on b7 b3) (on b8 b7) (on b10 b8) (on b12 b10) (on b13 b12) (on b18 b13) (on b25 b18) (on b29 b25) (clear b29)
	(on-table b5) (on b9 b5) (on b11 b9) (on b20 b11) (on b21 b20) (on b23 b21) (clear b23)
	(on-table b14) (on b27 b14) (on b30 b27) (clear b30)
	(on-table b17) (on b19 b17) (on b22 b19) (clear b22)
	(on-table b26) (clear b26)
	(on-table b28) (clear b28)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b4 b1) (on b7 b4) (on b23 b7) (clear b23)
	(on-table b2) (on b3 b2) (on b11 b3) (on b12 b11) (on b19 b12) (clear b19)
	(on-table b5) (on b6 b5) (on b17 b6) (on b27 b17) (clear b27)
	(on-table b8) (on b9 b8) (on b13 b9) (on b15 b13) (on b22 b15) (on b28 b22) (clear b28)
	(on-table b10) (on b14 b10) (on b29 b14) (on b30 b29) (clear b30)
	(on-table b16) (on b18 b16) (clear b18)
	(on-table b20) (on b24 b20) (on b26 b24) (clear b26)
	(on-table b21) (clear b21)
	(on-table b25) (clear b25)
))
)


