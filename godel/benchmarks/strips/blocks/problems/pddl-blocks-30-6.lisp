;;---------------------------------------------

(define (problem p30_6)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30)
(:init
	(arm-empty)
	(on-table b1) (on b5 b1) (on b8 b5) (clear b8)
	(on-table b2) (on b3 b2) (on b6 b3) (on b9 b6) (on b13 b9) (on b15 b13) (on b16 b15) (on b17 b16) (on b20 b17) (on b28 b20) (clear b28)
	(on-table b4) (on b7 b4) (on b14 b7) (on b23 b14) (on b26 b23) (clear b26)
	(on-table b10) (on b11 b10) (on b12 b11) (on b22 b12) (on b24 b22) (on b27 b24) (clear b27)
	(on-table b18) (on b19 b18) (clear b19)
	(on-table b21) (on b25 b21) (clear b25)
	(on-table b29) (clear b29)
	(on-table b30) (clear b30)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b2 b1) (on b3 b2) (on b10 b3) (on b15 b10) (clear b15)
	(on-table b4) (on b6 b4) (on b8 b6) (on b9 b8) (on b12 b9) (on b13 b12) (on b17 b13) (on b29 b17) (clear b29)
	(on-table b5) (clear b5)
	(on-table b7) (on b16 b7) (on b24 b16) (on b25 b24) (clear b25)
	(on-table b11) (clear b11)
	(on-table b14) (on b23 b14) (on b26 b23) (on b30 b26) (clear b30)
	(on-table b18) (on b19 b18) (clear b19)
	(on-table b20) (on b21 b20) (clear b21)
	(on-table b22) (clear b22)
	(on-table b27) (on b28 b27) (clear b28)
))
)


