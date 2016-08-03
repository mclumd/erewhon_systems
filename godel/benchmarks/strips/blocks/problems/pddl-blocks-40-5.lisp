;;---------------------------------------------

(define (problem p40_5)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30 b31 b32 b33 b34 b35 b36 b37 b38 b39 b40)
(:init
	(arm-empty)
	(on-table b1) (on b4 b1) (on b7 b4) (on b10 b7) (on b11 b10) (on b14 b11) (on b18 b14) (on b25 b18) (clear b25)
	(on-table b2) (on b5 b2) (on b6 b5) (on b9 b6) (on b13 b9) (on b20 b13) (on b27 b20) (on b39 b27) (clear b39)
	(on-table b3) (on b12 b3) (on b15 b12) (clear b15)
	(on-table b8) (on b17 b8) (on b21 b17) (on b23 b21) (on b24 b23) (on b26 b24) (on b34 b26) (on b35 b34) (clear b35)
	(on-table b16) (clear b16)
	(on-table b19) (on b22 b19) (on b33 b22) (on b36 b33) (on b40 b36) (clear b40)
	(on-table b28) (on b29 b28) (clear b29)
	(on-table b30) (on b31 b30) (clear b31)
	(on-table b32) (clear b32)
	(on-table b37) (on b38 b37) (clear b38)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b4 b1) (on b7 b4) (on b8 b7) (on b19 b8) (on b21 b19) (on b22 b21) (on b26 b22) (on b31 b26) (clear b31)
	(on-table b2) (on b3 b2) (on b5 b3) (on b6 b5) (on b12 b6) (on b14 b12) (on b15 b14) (on b17 b15) (on b23 b17) (on b25 b23) (on b30 b25) (on b32 b30) (clear b32)
	(on-table b9) (on b13 b9) (on b35 b13) (clear b35)
	(on-table b10) (on b11 b10) (on b16 b11) (on b18 b16) (on b20 b18) (on b24 b20) (on b28 b24) (on b33 b28) (on b34 b33) (clear b34)
	(on-table b27) (on b29 b27) (on b36 b29) (on b38 b36) (clear b38)
	(on-table b37) (clear b37)
	(on-table b39) (clear b39)
	(on-table b40) (clear b40)
))
)


