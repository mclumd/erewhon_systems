;;---------------------------------------------

(define (problem p40_2)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30 b31 b32 b33 b34 b35 b36 b37 b38 b39 b40)
(:init
	(arm-empty)
	(on-table b1) (on b3 b1) (on b7 b3) (on b11 b7) (on b12 b11) (on b13 b12) (on b17 b13) (on b33 b17) (clear b33)
	(on-table b2) (on b4 b2) (on b6 b4) (on b9 b6) (on b21 b9) (on b22 b21) (on b29 b22) (clear b29)
	(on-table b5) (on b10 b5) (on b14 b10) (on b27 b14) (on b37 b27) (clear b37)
	(on-table b8) (on b15 b8) (on b16 b15) (on b18 b16) (on b19 b18) (on b23 b19) (on b25 b23) (on b32 b25) (on b38 b32) (clear b38)
	(on-table b20) (on b24 b20) (on b39 b24) (on b40 b39) (clear b40)
	(on-table b26) (on b28 b26) (clear b28)
	(on-table b30) (on b34 b30) (on b36 b34) (clear b36)
	(on-table b31) (clear b31)
	(on-table b35) (clear b35)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b2 b1) (on b3 b2) (on b4 b3) (on b36 b4) (on b38 b36) (on b40 b38) (clear b40)
	(on-table b5) (on b16 b5) (on b19 b16) (on b20 b19) (on b26 b20) (on b32 b26) (clear b32)
	(on-table b6) (on b9 b6) (on b17 b9) (on b22 b17) (on b31 b22) (on b39 b31) (clear b39)
	(on-table b7) (on b8 b7) (on b12 b8) (on b14 b12) (on b23 b14) (on b25 b23) (on b29 b25) (on b33 b29) (clear b33)
	(on-table b10) (on b13 b10) (on b21 b13) (on b35 b21) (clear b35)
	(on-table b11) (on b15 b11) (on b24 b15) (clear b24)
	(on-table b18) (on b27 b18) (on b28 b27) (clear b28)
	(on-table b30) (clear b30)
	(on-table b34) (clear b34)
	(on-table b37) (clear b37)
))
)


