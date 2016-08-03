;;---------------------------------------------

(define (problem p30_12)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30)
(:init
	(arm-empty)
	(on-table b1) (on b2 b1) (on b11 b2) (on b18 b11) (clear b18)
	(on-table b3) (on b4 b3) (on b5 b4) (on b13 b5) (on b14 b13) (on b21 b14) (on b25 b21) (clear b25)
	(on-table b6) (on b10 b6) (on b12 b10) (on b15 b12) (on b24 b15) (on b29 b24) (clear b29)
	(on-table b7) (on b8 b7) (on b9 b8) (on b17 b9) (on b28 b17) (clear b28)
	(on-table b16) (on b30 b16) (clear b30)
	(on-table b19) (on b22 b19) (clear b22)
	(on-table b20) (on b23 b20) (on b26 b23) (on b27 b26) (clear b27)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b2 b1) (on b3 b2) (on b8 b3) (on b11 b8) (on b12 b11) (on b15 b12) (on b16 b15) (on b18 b16) (on b25 b18) (clear b25)
	(on-table b4) (on b5 b4) (on b6 b5) (on b7 b6) (on b9 b7) (on b10 b9) (on b24 b10) (on b29 b24) (clear b29)
	(on-table b13) (on b20 b13) (on b30 b20) (clear b30)
	(on-table b14) (on b17 b14) (on b21 b17) (clear b21)
	(on-table b19) (on b23 b19) (on b26 b23) (on b28 b26) (clear b28)
	(on-table b22) (clear b22)
	(on-table b27) (clear b27)
))
)


