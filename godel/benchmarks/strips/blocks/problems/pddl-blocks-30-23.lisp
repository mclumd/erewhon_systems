;;---------------------------------------------

(define (problem p30_23)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30)
(:init
	(arm-empty)
	(on-table b1) (on b9 b1) (on b22 b9) (clear b22)
	(on-table b2) (on b3 b2) (on b5 b3) (on b10 b5) (on b14 b10) (on b30 b14) (clear b30)
	(on-table b4) (on b8 b4) (on b11 b8) (on b15 b11) (on b23 b15) (clear b23)
	(on-table b6) (on b7 b6) (on b12 b7) (on b17 b12) (on b18 b17) (on b19 b18) (on b20 b19) (on b28 b20) (clear b28)
	(on-table b13) (on b16 b13) (on b29 b16) (clear b29)
	(on-table b21) (on b24 b21) (clear b24)
	(on-table b25) (on b26 b25) (clear b26)
	(on-table b27) (clear b27)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b2 b1) (on b3 b2) (on b9 b3) (on b10 b9) (on b14 b10) (on b16 b14) (on b23 b16) (on b29 b23) (clear b29)
	(on-table b4) (on b5 b4) (on b12 b5) (on b30 b12) (clear b30)
	(on-table b6) (on b17 b6) (on b18 b17) (clear b18)
	(on-table b7) (on b8 b7) (on b11 b8) (clear b11)
	(on-table b13) (on b26 b13) (clear b26)
	(on-table b15) (on b27 b15) (clear b27)
	(on-table b19) (clear b19)
	(on-table b20) (clear b20)
	(on-table b21) (clear b21)
	(on-table b22) (on b24 b22) (clear b24)
	(on-table b25) (on b28 b25) (clear b28)
))
)


