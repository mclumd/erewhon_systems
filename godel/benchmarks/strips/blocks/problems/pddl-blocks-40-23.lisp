;;---------------------------------------------

(define (problem p40_23)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30 b31 b32 b33 b34 b35 b36 b37 b38 b39 b40)
(:init
	(arm-empty)
	(on-table b1) (on b4 b1) (on b13 b4) (on b19 b13) (on b21 b19) (on b25 b21) (on b40 b25) (clear b40)
	(on-table b2) (on b3 b2) (on b5 b3) (on b6 b5) (on b15 b6) (on b17 b15) (on b18 b17) (on b28 b18) (on b32 b28) (on b33 b32) (on b36 b33) (on b38 b36) (on b39 b38) (clear b39)
	(on-table b7) (on b8 b7) (on b9 b8) (on b27 b9) (on b30 b27) (clear b30)
	(on-table b10) (on b14 b10) (on b20 b14) (on b24 b20) (clear b24)
	(on-table b11) (on b12 b11) (on b16 b12) (on b22 b16) (on b23 b22) (on b26 b23) (on b29 b26) (clear b29)
	(on-table b31) (on b34 b31) (on b35 b34) (clear b35)
	(on-table b37) (clear b37)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b3 b1) (on b6 b3) (on b7 b6) (on b9 b7) (on b20 b9) (on b22 b20) (on b26 b22) (on b31 b26) (on b40 b31) (clear b40)
	(on-table b2) (on b5 b2) (on b8 b5) (on b10 b8) (on b11 b10) (on b15 b11) (on b17 b15) (on b35 b17) (on b37 b35) (clear b37)
	(on-table b4) (on b16 b4) (on b28 b16) (on b29 b28) (on b34 b29) (on b39 b34) (clear b39)
	(on-table b12) (on b25 b12) (on b38 b25) (clear b38)
	(on-table b13) (on b14 b13) (on b18 b14) (on b19 b18) (clear b19)
	(on-table b21) (on b27 b21) (on b36 b27) (clear b36)
	(on-table b23) (on b24 b23) (on b32 b24) (on b33 b32) (clear b33)
	(on-table b30) (clear b30)
))
)


