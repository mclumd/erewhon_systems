;;---------------------------------------------

(define (problem p30_1)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30)
(:init
	(arm-empty)
	(on-table b1) (on b2 b1) (on b3 b2) (on b14 b3) (on b17 b14) (on b23 b17) (on b24 b23) (clear b24)
	(on-table b4) (on b5 b4) (on b6 b5) (on b13 b6) (on b22 b13) (on b26 b22) (on b29 b26) (on b30 b29) (clear b30)
	(on-table b7) (on b11 b7) (on b12 b11) (clear b12)
	(on-table b8) (on b9 b8) (clear b9)
	(on-table b10) (on b27 b10) (clear b27)
	(on-table b15) (on b21 b15) (on b25 b21) (clear b25)
	(on-table b16) (on b19 b16) (clear b19)
	(on-table b18) (on b28 b18) (clear b28)
	(on-table b20) (clear b20)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b2 b1) (on b13 b2) (on b20 b13) (clear b20)
	(on-table b3) (on b4 b3) (on b5 b4) (on b6 b5) (on b7 b6) (on b11 b7) (on b15 b11) (on b21 b15) (clear b21)
	(on-table b8) (on b12 b8) (on b19 b12) (on b29 b19) (clear b29)
	(on-table b9) (on b10 b9) (on b24 b10) (clear b24)
	(on-table b14) (on b18 b14) (clear b18)
	(on-table b16) (on b17 b16) (on b25 b17) (clear b25)
	(on-table b22) (on b30 b22) (clear b30)
	(on-table b23) (on b26 b23) (on b27 b26) (on b28 b27) (clear b28)
))
)


