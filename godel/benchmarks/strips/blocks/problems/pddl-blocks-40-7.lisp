;;---------------------------------------------

(define (problem p40_7)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30 b31 b32 b33 b34 b35 b36 b37 b38 b39 b40)
(:init
	(arm-empty)
	(on-table b1) (on b9 b1) (on b11 b9) (on b12 b11) (on b19 b12) (on b23 b19) (on b24 b23) (clear b24)
	(on-table b2) (on b13 b2) (on b21 b13) (on b27 b21) (on b30 b27) (on b34 b30) (on b38 b34) (clear b38)
	(on-table b3) (on b4 b3) (on b6 b4) (on b8 b6) (on b20 b8) (on b22 b20) (on b25 b22) (on b35 b25) (on b37 b35) (clear b37)
	(on-table b5) (on b15 b5) (on b16 b15) (on b17 b16) (on b31 b17) (on b32 b31) (clear b32)
	(on-table b7) (on b10 b7) (on b14 b10) (on b18 b14) (on b28 b18) (clear b28)
	(on-table b26) (on b33 b26) (clear b33)
	(on-table b29) (on b36 b29) (clear b36)
	(on-table b39) (on b40 b39) (clear b40)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b2 b1) (on b4 b2) (on b12 b4) (on b25 b12) (on b26 b25) (on b30 b26) (on b34 b30) (on b39 b34) (clear b39)
	(on-table b3) (on b6 b3) (on b9 b6) (on b24 b9) (on b28 b24) (on b29 b28) (clear b29)
	(on-table b5) (on b7 b5) (on b8 b7) (on b16 b8) (on b18 b16) (on b20 b18) (on b22 b20) (on b37 b22) (clear b37)
	(on-table b10) (on b11 b10) (on b13 b11) (on b14 b13) (on b15 b14) (on b23 b15) (on b32 b23) (on b33 b32) (clear b33)
	(on-table b17) (on b19 b17) (on b21 b19) (on b27 b21) (on b31 b27) (on b36 b31) (clear b36)
	(on-table b35) (clear b35)
	(on-table b38) (on b40 b38) (clear b40)
))
)


