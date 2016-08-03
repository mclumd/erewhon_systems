;;---------------------------------------------

(define (problem p40_19)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30 b31 b32 b33 b34 b35 b36 b37 b38 b39 b40)
(:init
	(arm-empty)
	(on-table b1) (on b2 b1) (on b3 b2) (on b4 b3) (on b9 b4) (on b15 b9) (on b24 b15) (on b27 b24) (on b38 b27) (clear b38)
	(on-table b5) (on b13 b5) (on b17 b13) (on b26 b17) (on b28 b26) (on b30 b28) (on b33 b30) (on b40 b33) (clear b40)
	(on-table b6) (on b11 b6) (on b14 b11) (on b18 b14) (on b39 b18) (clear b39)
	(on-table b7) (on b8 b7) (on b10 b8) (on b25 b10) (on b29 b25) (on b32 b29) (clear b32)
	(on-table b12) (on b22 b12) (on b31 b22) (on b34 b31) (clear b34)
	(on-table b16) (on b19 b16) (on b20 b19) (on b21 b20) (on b23 b21) (on b35 b23) (on b36 b35) (on b37 b36) (clear b37)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b2 b1) (on b5 b2) (on b9 b5) (on b11 b9) (on b12 b11) (on b19 b12) (on b20 b19) (on b31 b20) (on b39 b31) (clear b39)
	(on-table b3) (on b6 b3) (on b8 b6) (on b18 b8) (on b22 b18) (on b32 b22) (on b33 b32) (clear b33)
	(on-table b4) (on b7 b4) (on b10 b7) (on b14 b10) (on b15 b14) (on b16 b15) (on b21 b16) (on b24 b21) (on b27 b24) (on b28 b27) (on b36 b28) (on b37 b36) (on b38 b37) (clear b38)
	(on-table b13) (on b26 b13) (on b40 b26) (clear b40)
	(on-table b17) (on b23 b17) (on b29 b23) (on b34 b29) (clear b34)
	(on-table b25) (clear b25)
	(on-table b30) (on b35 b30) (clear b35)
))
)


