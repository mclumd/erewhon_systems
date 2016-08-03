;;---------------------------------------------

(define (problem p30_9)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30)
(:init
	(arm-empty)
	(on-table b1) (on b9 b1) (on b11 b9) (on b12 b11) (on b19 b12) (on b23 b19) (on b24 b23) (clear b24)
	(on-table b2) (on b13 b2) (on b21 b13) (on b27 b21) (on b30 b27) (clear b30)
	(on-table b3) (on b4 b3) (on b6 b4) (on b8 b6) (on b20 b8) (on b22 b20) (on b25 b22) (clear b25)
	(on-table b5) (on b15 b5) (on b16 b15) (on b17 b16) (clear b17)
	(on-table b7) (on b10 b7) (on b14 b10) (on b18 b14) (on b28 b18) (clear b28)
	(on-table b26) (clear b26)
	(on-table b29) (clear b29)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b3 b1) (on b4 b3) (on b10 b4) (on b13 b10) (on b22 b13) (clear b22)
	(on-table b2) (on b8 b2) (on b14 b8) (on b17 b14) (on b18 b17) (on b20 b18) (clear b20)
	(on-table b5) (on b6 b5) (on b7 b6) (on b11 b7) (on b12 b11) (on b26 b12) (on b28 b26) (on b30 b28) (clear b30)
	(on-table b9) (on b15 b9) (on b16 b15) (on b19 b16) (on b21 b19) (on b23 b21) (on b24 b23) (on b25 b24) (clear b25)
	(on-table b27) (on b29 b27) (clear b29)
))
)


