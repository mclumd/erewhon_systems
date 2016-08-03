;;---------------------------------------------

(define (problem p30_13)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30)
(:init
	(arm-empty)
	(on-table b1) (on b10 b1) (on b11 b10) (on b15 b11) (clear b15)
	(on-table b2) (on b3 b2) (on b22 b3) (clear b22)
	(on-table b4) (on b5 b4) (on b9 b5) (on b13 b9) (on b16 b13) (clear b16)
	(on-table b6) (on b8 b6) (clear b8)
	(on-table b7) (on b12 b7) (on b14 b12) (on b20 b14) (on b21 b20) (clear b21)
	(on-table b17) (on b18 b17) (clear b18)
	(on-table b19) (on b23 b19) (on b26 b23) (clear b26)
	(on-table b24) (on b29 b24) (on b30 b29) (clear b30)
	(on-table b25) (on b27 b25) (clear b27)
	(on-table b28) (clear b28)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b3 b1) (on b4 b3) (on b5 b4) (on b12 b5) (on b13 b12) (on b21 b13) (clear b21)
	(on-table b2) (on b15 b2) (clear b15)
	(on-table b6) (on b8 b6) (on b14 b8) (on b24 b14) (on b25 b24) (clear b25)
	(on-table b7) (on b18 b7) (on b19 b18) (on b29 b19) (clear b29)
	(on-table b9) (on b26 b9) (on b27 b26) (on b30 b27) (clear b30)
	(on-table b10) (on b22 b10) (clear b22)
	(on-table b11) (on b16 b11) (on b20 b16) (on b23 b20) (on b28 b23) (clear b28)
	(on-table b17) (clear b17)
))
)


