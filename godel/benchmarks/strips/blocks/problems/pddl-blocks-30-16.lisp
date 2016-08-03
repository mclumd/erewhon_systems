;;---------------------------------------------

(define (problem p30_16)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30)
(:init
	(arm-empty)
	(on-table b1) (on b2 b1) (on b3 b2) (on b6 b3) (on b7 b6) (on b9 b7) (on b11 b9) (on b12 b11) (on b14 b12) (on b15 b14) (on b18 b15) (on b19 b18) (on b27 b19) (clear b27)
	(on-table b4) (on b5 b4) (on b16 b5) (on b17 b16) (on b22 b17) (on b25 b22) (clear b25)
	(on-table b8) (on b13 b8) (on b20 b13) (on b21 b20) (on b28 b21) (clear b28)
	(on-table b10) (on b30 b10) (clear b30)
	(on-table b23) (clear b23)
	(on-table b24) (clear b24)
	(on-table b26) (on b29 b26) (clear b29)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b2 b1) (on b3 b2) (on b4 b3) (on b5 b4) (on b8 b5) (on b23 b8) (clear b23)
	(on-table b6) (on b13 b6) (on b25 b13) (clear b25)
	(on-table b7) (on b9 b7) (on b14 b9) (clear b14)
	(on-table b10) (on b15 b10) (on b26 b15) (clear b26)
	(on-table b11) (on b12 b11) (on b16 b12) (clear b16)
	(on-table b17) (on b24 b17) (clear b24)
	(on-table b18) (on b29 b18) (clear b29)
	(on-table b19) (on b22 b19) (on b27 b22) (clear b27)
	(on-table b20) (on b21 b20) (on b28 b21) (on b30 b28) (clear b30)
))
)

