;;---------------------------------------------

(define (problem p40_15)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30 b31 b32 b33 b34 b35 b36 b37 b38 b39 b40)
(:init
	(arm-empty)
	(on-table b1) (on b3 b1) (on b17 b3) (clear b17)
	(on-table b2) (on b5 b2) (on b9 b5) (on b28 b9) (on b32 b28) (on b33 b32) (clear b33)
	(on-table b4) (on b7 b4) (on b8 b7) (on b13 b8) (on b14 b13) (on b18 b14) (on b25 b18) (on b29 b25) (on b35 b29) (on b36 b35) (on b40 b36) (clear b40)
	(on-table b6) (on b10 b6) (on b11 b10) (on b12 b11) (on b15 b12) (on b19 b15) (on b23 b19) (clear b23)
	(on-table b16) (on b21 b16) (on b26 b21) (on b30 b26) (clear b30)
	(on-table b20) (on b31 b20) (on b34 b31) (on b37 b34) (on b39 b37) (clear b39)
	(on-table b22) (on b27 b22) (clear b27)
	(on-table b24) (on b38 b24) (clear b38)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b2 b1) (on b7 b2) (on b8 b7) (on b9 b8) (on b12 b9) (on b15 b12) (on b16 b15) (on b37 b16) (clear b37)
	(on-table b3) (on b6 b3) (on b13 b6) (on b21 b13) (on b22 b21) (on b32 b22) (on b36 b32) (clear b36)
	(on-table b4) (on b5 b4) (on b10 b5) (on b11 b10) (on b17 b11) (on b20 b17) (on b30 b20) (on b34 b30) (on b35 b34) (on b39 b35) (clear b39)
	(on-table b14) (on b18 b14) (on b24 b18) (on b29 b24) (on b38 b29) (clear b38)
	(on-table b19) (on b23 b19) (on b25 b23) (on b28 b25) (clear b28)
	(on-table b26) (on b27 b26) (on b31 b27) (on b40 b31) (clear b40)
	(on-table b33) (clear b33)
))
)


