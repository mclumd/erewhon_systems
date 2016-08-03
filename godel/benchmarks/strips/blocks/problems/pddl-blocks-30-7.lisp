;;---------------------------------------------

(define (problem p30_7)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30)
(:init
	(arm-empty)
	(on-table b1) (on b4 b1) (on b7 b4) (on b8 b7) (on b19 b8) (on b21 b19) (on b22 b21) (on b26 b22) (clear b26)
	(on-table b2) (on b3 b2) (on b5 b3) (on b6 b5) (on b12 b6) (on b14 b12) (on b15 b14) (on b17 b15) (on b23 b17) (on b25 b23) (on b30 b25) (clear b30)
	(on-table b9) (on b13 b9) (clear b13)
	(on-table b10) (on b11 b10) (on b16 b11) (on b18 b16) (on b20 b18) (on b24 b20) (on b28 b24) (clear b28)
	(on-table b27) (on b29 b27) (clear b29)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b3 b1) (on b4 b3) (on b15 b4) (on b19 b15) (clear b19)
	(on-table b2) (on b9 b2) (clear b9)
	(on-table b5) (on b6 b5) (on b8 b6) (on b12 b8) (on b14 b12) (on b16 b14) (on b25 b16) (on b30 b25) (clear b30)
	(on-table b7) (on b10 b7) (on b13 b10) (on b23 b13) (clear b23)
	(on-table b11) (on b28 b11) (clear b28)
	(on-table b17) (on b24 b17) (on b26 b24) (clear b26)
	(on-table b18) (on b22 b18) (on b27 b22) (clear b27)
	(on-table b20) (clear b20)
	(on-table b21) (clear b21)
	(on-table b29) (clear b29)
))
)


