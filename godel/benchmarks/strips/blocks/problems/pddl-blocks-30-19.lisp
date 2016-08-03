;;---------------------------------------------

(define (problem p30_19)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30)
(:init
	(arm-empty)
	(on-table b1) (on b6 b1) (on b16 b6) (clear b16)
	(on-table b2) (on b4 b2) (on b5 b4) (on b7 b5) (on b8 b7) (on b9 b8) (on b15 b9) (on b19 b15) (clear b19)
	(on-table b3) (on b11 b3) (on b18 b11) (on b20 b18) (on b27 b20) (on b28 b27) (clear b28)
	(on-table b10) (on b22 b10) (on b24 b22) (clear b24)
	(on-table b12) (on b17 b12) (on b21 b17) (on b29 b21) (on b30 b29) (clear b30)
	(on-table b13) (on b14 b13) (clear b14)
	(on-table b23) (on b25 b23) (on b26 b25) (clear b26)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b7 b1) (on b8 b7) (on b10 b8) (on b13 b10) (on b17 b13) (clear b17)
	(on-table b2) (on b6 b2) (on b21 b6) (on b22 b21) (on b29 b22) (on b30 b29) (clear b30)
	(on-table b3) (on b5 b3) (on b14 b5) (on b16 b14) (on b20 b16) (clear b20)
	(on-table b4) (on b12 b4) (on b25 b12) (clear b25)
	(on-table b9) (on b11 b9) (on b27 b11) (clear b27)
	(on-table b15) (on b18 b15) (on b19 b18) (on b24 b19) (clear b24)
	(on-table b23) (on b26 b23) (on b28 b26) (clear b28)
))
)


