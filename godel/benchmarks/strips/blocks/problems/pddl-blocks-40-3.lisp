;;---------------------------------------------

(define (problem p40_3)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30 b31 b32 b33 b34 b35 b36 b37 b38 b39 b40)
(:init
	(arm-empty)
	(on-table b1) (on b3 b1) (on b11 b3) (on b20 b11) (on b28 b20) (on b35 b28) (on b39 b35) (clear b39)
	(on-table b2) (on b5 b2) (on b9 b5) (on b14 b9) (on b15 b14) (on b17 b15) (on b18 b17) (on b19 b18) (clear b19)
	(on-table b4) (on b6 b4) (on b8 b6) (on b10 b8) (on b13 b10) (on b16 b13) (on b32 b16) (clear b32)
	(on-table b7) (on b12 b7) (on b21 b12) (on b22 b21) (on b27 b22) (on b31 b27) (clear b31)
	(on-table b23) (on b24 b23) (on b34 b24) (on b36 b34) (clear b36)
	(on-table b25) (on b26 b25) (on b30 b26) (on b40 b30) (clear b40)
	(on-table b29) (on b33 b29) (clear b33)
	(on-table b37) (on b38 b37) (clear b38)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b2 b1) (on b3 b2) (on b4 b3) (on b5 b4) (on b27 b5) (on b28 b27) (on b40 b28) (clear b40)
	(on-table b6) (on b8 b6) (on b9 b8) (on b14 b9) (on b33 b14) (clear b33)
	(on-table b7) (on b10 b7) (on b15 b10) (on b18 b15) (on b23 b18) (on b30 b23) (clear b30)
	(on-table b11) (on b24 b11) (clear b24)
	(on-table b12) (on b13 b12) (on b19 b13) (clear b19)
	(on-table b16) (on b17 b16) (on b21 b17) (on b25 b21) (on b29 b25) (on b38 b29) (clear b38)
	(on-table b20) (on b26 b20) (on b31 b26) (on b32 b31) (on b34 b32) (clear b34)
	(on-table b22) (on b35 b22) (on b36 b35) (on b37 b36) (clear b37)
	(on-table b39) (clear b39)
))
)


