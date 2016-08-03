;;---------------------------------------------

(define (problem p30_14)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30)
(:init
	(arm-empty)
	(on-table b1) (on b2 b1) (on b20 b2) (on b27 b20) (on b28 b27) (clear b28)
	(on-table b3) (on b4 b3) (on b8 b4) (on b9 b8) (on b11 b9) (on b24 b11) (clear b24)
	(on-table b5) (on b7 b5) (on b10 b7) (on b17 b10) (clear b17)
	(on-table b6) (on b13 b6) (on b14 b13) (on b16 b14) (on b18 b16) (on b19 b18) (on b26 b19) (clear b26)
	(on-table b12) (on b23 b12) (on b29 b23) (on b30 b29) (clear b30)
	(on-table b15) (on b21 b15) (on b22 b21) (on b25 b22) (clear b25)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b4 b1) (on b5 b4) (on b8 b5) (on b15 b8) (on b20 b15) (on b30 b20) (clear b30)
	(on-table b2) (on b3 b2) (on b7 b3) (on b11 b7) (on b12 b11) (on b17 b12) (on b21 b17) (on b26 b21) (clear b26)
	(on-table b6) (on b9 b6) (on b14 b9) (on b23 b14) (on b24 b23) (clear b24)
	(on-table b10) (clear b10)
	(on-table b13) (on b28 b13) (on b29 b28) (clear b29)
	(on-table b16) (on b18 b16) (clear b18)
	(on-table b19) (clear b19)
	(on-table b22) (on b25 b22) (on b27 b25) (clear b27)
))
)


