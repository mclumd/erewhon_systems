;;---------------------------------------------

(define (problem p30_4)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30)
(:init
	(arm-empty)
	(on-table b1) (on b8 b1) (on b9 b8) (on b12 b9) (on b22 b12) (on b24 b22) (on b25 b24) (clear b25)
	(on-table b2) (on b3 b2) (on b4 b3) (on b11 b4) (on b13 b11) (on b16 b13) (on b27 b16) (on b28 b27) (on b29 b28) (clear b29)
	(on-table b5) (on b6 b5) (on b14 b6) (on b15 b14) (on b30 b15) (clear b30)
	(on-table b7) (on b10 b7) (on b19 b10) (on b26 b19) (clear b26)
	(on-table b17) (on b18 b17) (on b23 b18) (clear b23)
	(on-table b20) (clear b20)
	(on-table b21) (clear b21)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b14 b1) (clear b14)
	(on-table b2) (on b3 b2) (on b4 b3) (on b6 b4) (on b12 b6) (on b23 b12) (on b27 b23) (clear b27)
	(on-table b5) (on b7 b5) (on b8 b7) (on b11 b8) (on b15 b11) (on b19 b15) (on b20 b19) (clear b20)
	(on-table b9) (on b10 b9) (on b16 b10) (on b17 b16) (on b18 b17) (on b21 b18) (on b22 b21) (on b24 b22) (clear b24)
	(on-table b13) (on b25 b13) (on b26 b25) (on b30 b26) (clear b30)
	(on-table b28) (on b29 b28) (clear b29)
))
)


