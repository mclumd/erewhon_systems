;;---------------------------------------------

(define (problem p40_11)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30 b31 b32 b33 b34 b35 b36 b37 b38 b39 b40)
(:init
	(arm-empty)
	(on-table b1) (on b3 b1) (on b5 b3) (on b15 b5) (on b25 b15) (clear b25)
	(on-table b2) (on b12 b2) (on b13 b12) (on b38 b13) (clear b38)
	(on-table b4) (on b8 b4) (on b11 b8) (on b22 b11) (on b35 b22) (on b40 b35) (clear b40)
	(on-table b6) (on b7 b6) (on b14 b7) (on b17 b14) (on b23 b17) (on b31 b23) (on b36 b31) (clear b36)
	(on-table b9) (on b10 b9) (on b21 b10) (on b33 b21) (clear b33)
	(on-table b16) (on b27 b16) (clear b27)
	(on-table b18) (on b19 b18) (on b30 b19) (on b39 b30) (clear b39)
	(on-table b20) (on b26 b20) (on b34 b26) (clear b34)
	(on-table b24) (on b32 b24) (clear b32)
	(on-table b28) (on b29 b28) (on b37 b29) (clear b37)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b3 b1) (on b27 b3) (on b29 b27) (on b37 b29) (clear b37)
	(on-table b2) (on b4 b2) (on b10 b4) (on b15 b10) (on b17 b15) (clear b17)
	(on-table b5) (on b11 b5) (on b19 b11) (on b35 b19) (on b36 b35) (on b39 b36) (clear b39)
	(on-table b6) (on b9 b6) (on b16 b9) (on b18 b16) (on b31 b18) (on b40 b31) (clear b40)
	(on-table b7) (on b12 b7) (on b20 b12) (on b21 b20) (on b22 b21) (on b23 b22) (on b28 b23) (on b30 b28) (on b38 b30) (clear b38)
	(on-table b8) (on b13 b8) (on b26 b13) (on b32 b26) (on b33 b32) (on b34 b33) (clear b34)
	(on-table b14) (clear b14)
	(on-table b24) (on b25 b24) (clear b25)
))
)


