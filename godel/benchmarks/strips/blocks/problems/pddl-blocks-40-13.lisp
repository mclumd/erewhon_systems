;;---------------------------------------------

(define (problem p40_13)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30 b31 b32 b33 b34 b35 b36 b37 b38 b39 b40)
(:init
	(arm-empty)
	(on-table b1) (on b2 b1) (on b3 b2) (on b4 b3) (on b6 b4) (on b7 b6) (on b13 b7) (on b21 b13) (on b30 b21) (on b32 b30) (clear b32)
	(on-table b5) (on b8 b5) (on b9 b8) (on b12 b9) (on b24 b12) (on b36 b24) (on b37 b36) (on b39 b37) (clear b39)
	(on-table b10) (on b15 b10) (on b18 b15) (on b19 b18) (on b25 b19) (on b38 b25) (clear b38)
	(on-table b11) (on b16 b11) (on b27 b16) (on b35 b27) (on b40 b35) (clear b40)
	(on-table b14) (on b17 b14) (on b20 b17) (on b34 b20) (clear b34)
	(on-table b22) (on b23 b22) (on b31 b23) (on b33 b31) (clear b33)
	(on-table b26) (on b28 b26) (on b29 b28) (clear b29)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b2 b1) (on b4 b2) (on b6 b4) (on b7 b6) (on b27 b7) (on b28 b27) (on b29 b28) (on b38 b29) (clear b38)
	(on-table b3) (on b5 b3) (on b22 b5) (on b23 b22) (on b31 b23) (clear b31)
	(on-table b8) (on b9 b8) (on b10 b9) (on b13 b10) (on b14 b13) (on b19 b14) (on b20 b19) (on b36 b20) (on b40 b36) (clear b40)
	(on-table b11) (on b12 b11) (on b16 b12) (on b17 b16) (on b18 b17) (on b26 b18) (on b34 b26) (on b35 b34) (clear b35)
	(on-table b15) (on b21 b15) (on b24 b21) (on b25 b24) (on b37 b25) (on b39 b37) (clear b39)
	(on-table b30) (on b32 b30) (on b33 b32) (clear b33)
))
)


