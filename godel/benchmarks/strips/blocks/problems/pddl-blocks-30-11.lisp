;;---------------------------------------------

(define (problem p30_11)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30)
(:init
	(arm-empty)
	(on-table b1) (on b5 b1) (on b8 b5) (on b9 b8) (on b23 b9) (on b24 b23) (on b28 b24) (clear b28)
	(on-table b2) (on b3 b2) (on b15 b3) (on b30 b15) (clear b30)
	(on-table b4) (on b6 b4) (on b7 b6) (on b12 b7) (on b17 b12) (on b20 b17) (on b25 b20) (clear b25)
	(on-table b10) (on b22 b10) (on b27 b22) (clear b27)
	(on-table b11) (on b26 b11) (clear b26)
	(on-table b13) (on b14 b13) (on b18 b14) (on b19 b18) (on b29 b19) (clear b29)
	(on-table b16) (on b21 b16) (clear b21)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b3 b1) (on b4 b3) (on b6 b4) (on b8 b6) (on b10 b8) (on b11 b10) (on b23 b11) (clear b23)
	(on-table b2) (on b5 b2) (on b7 b5) (on b13 b7) (on b16 b13) (on b18 b16) (on b27 b18) (clear b27)
	(on-table b9) (on b12 b9) (on b14 b12) (on b20 b14) (clear b20)
	(on-table b15) (on b17 b15) (on b19 b17) (on b24 b19) (on b28 b24) (clear b28)
	(on-table b21) (on b22 b21) (clear b22)
	(on-table b25) (on b29 b25) (clear b29)
	(on-table b26) (clear b26)
	(on-table b30) (clear b30)
))
)


