;;---------------------------------------------

(define (problem p30_20)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30)
(:init
	(arm-empty)
	(on-table b1) (on b2 b1) (on b27 b2) (on b28 b27) (clear b28)
	(on-table b3) (on b8 b3) (on b12 b8) (on b13 b12) (on b20 b13) (on b23 b20) (on b24 b23) (clear b24)
	(on-table b4) (on b5 b4) (on b9 b5) (on b11 b9) (on b14 b11) (on b15 b14) (on b25 b15) (on b30 b25) (clear b30)
	(on-table b6) (on b18 b6) (clear b18)
	(on-table b7) (on b10 b7) (on b17 b10) (on b22 b17) (on b29 b22) (clear b29)
	(on-table b16) (on b19 b16) (on b26 b19) (clear b26)
	(on-table b21) (clear b21)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b2 b1) (on b5 b2) (on b6 b5) (on b27 b6) (clear b27)
	(on-table b3) (on b11 b3) (on b12 b11) (on b22 b12) (on b26 b22) (clear b26)
	(on-table b4) (on b10 b4) (on b20 b10) (on b24 b20) (on b25 b24) (on b29 b25) (clear b29)
	(on-table b7) (on b8 b7) (on b14 b8) (on b19 b14) (on b28 b19) (clear b28)
	(on-table b9) (on b13 b9) (on b15 b13) (on b18 b15) (clear b18)
	(on-table b16) (on b17 b16) (on b21 b17) (on b30 b21) (clear b30)
	(on-table b23) (clear b23)
))
)


