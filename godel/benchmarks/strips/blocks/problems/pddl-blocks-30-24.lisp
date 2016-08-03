;;---------------------------------------------

(define (problem p30_24)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30)
(:init
	(arm-empty)
	(on-table b1) (on b3 b1) (on b7 b3) (on b11 b7) (on b13 b11) (on b21 b13) (on b26 b21) (on b30 b26) (clear b30)
	(on-table b2) (on b14 b2) (on b22 b14) (clear b22)
	(on-table b4) (on b10 b4) (on b16 b10) (on b20 b16) (on b27 b20) (clear b27)
	(on-table b5) (on b6 b5) (on b9 b6) (on b12 b9) (on b19 b12) (on b29 b19) (clear b29)
	(on-table b8) (on b23 b8) (on b25 b23) (clear b25)
	(on-table b15) (on b17 b15) (on b24 b17) (clear b24)
	(on-table b18) (on b28 b18) (clear b28)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b2 b1) (on b3 b2) (on b4 b3) (on b5 b4) (on b6 b5) (on b12 b6) (on b26 b12) (clear b26)
	(on-table b7) (on b9 b7) (on b30 b9) (clear b30)
	(on-table b8) (on b10 b8) (on b17 b10) (on b20 b17) (clear b20)
	(on-table b11) (on b14 b11) (on b18 b14) (on b19 b18) (on b23 b19) (on b24 b23) (clear b24)
	(on-table b13) (on b15 b13) (on b16 b15) (on b21 b16) (on b22 b21) (on b25 b22) (on b27 b25) (on b28 b27) (on b29 b28) (clear b29)
))
)


