;;---------------------------------------------

(define (problem p40_24)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30 b31 b32 b33 b34 b35 b36 b37 b38 b39 b40)
(:init
	(arm-empty)
	(on-table b1) (on b3 b1) (on b6 b3) (on b7 b6) (on b17 b7) (on b23 b17) (on b24 b23) (on b35 b24) (on b40 b35) (clear b40)
	(on-table b2) (on b5 b2) (on b8 b5) (on b12 b8) (on b16 b12) (clear b16)
	(on-table b4) (on b14 b4) (on b15 b14) (on b20 b15) (on b27 b20) (clear b27)
	(on-table b9) (on b13 b9) (on b22 b13) (on b25 b22) (on b34 b25) (on b39 b34) (clear b39)
	(on-table b10) (on b18 b10) (on b21 b18) (on b36 b21) (on b37 b36) (clear b37)
	(on-table b11) (on b19 b11) (on b26 b19) (on b32 b26) (on b38 b32) (clear b38)
	(on-table b28) (on b29 b28) (on b30 b29) (on b31 b30) (on b33 b31) (clear b33)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b5 b1) (on b9 b5) (on b11 b9) (on b12 b11) (on b14 b12) (on b17 b14) (on b20 b17) (on b23 b20) (on b27 b23) (on b28 b27) (on b31 b28) (on b32 b31) (on b38 b32) (clear b38)
	(on-table b2) (on b4 b2) (on b7 b4) (on b8 b7) (on b10 b8) (on b18 b10) (on b22 b18) (on b26 b22) (on b33 b26) (clear b33)
	(on-table b3) (on b21 b3) (on b29 b21) (on b34 b29) (clear b34)
	(on-table b6) (on b25 b6) (on b37 b25) (on b40 b37) (clear b40)
	(on-table b13) (on b16 b13) (on b19 b16) (on b24 b19) (on b35 b24) (on b39 b35) (clear b39)
	(on-table b15) (on b30 b15) (clear b30)
	(on-table b36) (clear b36)
))
)


