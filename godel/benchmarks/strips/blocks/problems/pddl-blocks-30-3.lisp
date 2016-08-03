;;---------------------------------------------

(define (problem p30_3)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30)
(:init
	(arm-empty)
	(on-table b1) (on b2 b1) (on b3 b2) (on b4 b3) (clear b4)
	(on-table b5) (on b16 b5) (on b19 b16) (on b20 b19) (on b26 b20) (clear b26)
	(on-table b6) (on b9 b6) (on b17 b9) (on b22 b17) (clear b22)
	(on-table b7) (on b8 b7) (on b12 b8) (on b14 b12) (on b23 b14) (on b25 b23) (on b29 b25) (clear b29)
	(on-table b10) (on b13 b10) (on b21 b13) (clear b21)
	(on-table b11) (on b15 b11) (on b24 b15) (clear b24)
	(on-table b18) (on b27 b18) (on b28 b27) (clear b28)
	(on-table b30) (clear b30)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b3 b1) (on b6 b3) (on b10 b6) (on b13 b10) (on b22 b13) (on b26 b22) (on b27 b26) (on b29 b27) (clear b29)
	(on-table b2) (on b8 b2) (on b11 b8) (on b16 b11) (on b20 b16) (clear b20)
	(on-table b4) (on b5 b4) (on b17 b5) (on b21 b17) (clear b21)
	(on-table b7) (on b12 b7) (on b19 b12) (clear b19)
	(on-table b9) (on b15 b9) (on b23 b15) (clear b23)
	(on-table b14) (on b28 b14) (on b30 b28) (clear b30)
	(on-table b18) (on b24 b18) (on b25 b24) (clear b25)
))
)


