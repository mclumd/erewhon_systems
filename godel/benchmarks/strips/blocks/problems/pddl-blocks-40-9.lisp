;;---------------------------------------------

(define (problem p40_9)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30 b31 b32 b33 b34 b35 b36 b37 b38 b39 b40)
(:init
	(arm-empty)
	(on-table b1) (on b2 b1) (on b13 b2) (on b23 b13) (clear b23)
	(on-table b3) (on b6 b3) (on b8 b6) (on b17 b8) (on b27 b17) (on b33 b27) (on b34 b33) (on b37 b34) (clear b37)
	(on-table b4) (on b10 b4) (on b22 b10) (clear b22)
	(on-table b5) (on b7 b5) (on b9 b7) (on b14 b9) (on b18 b14) (on b28 b18) (clear b28)
	(on-table b11) (on b12 b11) (on b24 b12) (on b40 b24) (clear b40)
	(on-table b15) (on b19 b15) (on b21 b19) (on b31 b21) (on b39 b31) (clear b39)
	(on-table b16) (clear b16)
	(on-table b20) (on b25 b20) (on b30 b25) (on b32 b30) (on b35 b32) (clear b35)
	(on-table b26) (on b29 b26) (clear b29)
	(on-table b36) (on b38 b36) (clear b38)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b10 b1) (on b18 b10) (on b33 b18) (clear b33)
	(on-table b2) (on b3 b2) (on b4 b3) (on b5 b4) (on b12 b5) (on b19 b12) (on b27 b19) (on b28 b27) (on b32 b28) (on b37 b32) (clear b37)
	(on-table b6) (on b7 b6) (on b9 b7) (on b13 b9) (on b23 b13) (clear b23)
	(on-table b8) (on b11 b8) (on b21 b11) (on b22 b21) (on b24 b22) (on b31 b24) (clear b31)
	(on-table b14) (on b15 b14) (on b16 b15) (on b17 b16) (on b20 b17) (on b35 b20) (on b36 b35) (on b38 b36) (clear b38)
	(on-table b25) (clear b25)
	(on-table b26) (on b34 b26) (on b40 b34) (clear b40)
	(on-table b29) (on b39 b29) (clear b39)
	(on-table b30) (clear b30)
))
)


