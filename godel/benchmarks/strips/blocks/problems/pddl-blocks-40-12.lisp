;;---------------------------------------------

(define (problem p40_12)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30 b31 b32 b33 b34 b35 b36 b37 b38 b39 b40)
(:init
	(arm-empty)
	(on-table b1) (on b2 b1) (on b3 b2) (on b4 b3) (on b5 b4) (on b6 b5) (on b9 b6) (on b29 b9) (on b38 b29) (clear b38)
	(on-table b7) (on b11 b7) (on b12 b11) (on b31 b12) (on b37 b31) (clear b37)
	(on-table b8) (on b10 b8) (on b14 b10) (on b17 b14) (on b18 b17) (on b21 b18) (on b26 b21) (on b33 b26) (on b39 b33) (on b40 b39) (clear b40)
	(on-table b13) (on b15 b13) (on b16 b15) (on b19 b16) (on b20 b19) (on b25 b20) (on b30 b25) (clear b30)
	(on-table b22) (on b23 b22) (on b32 b23) (on b34 b32) (on b35 b34) (clear b35)
	(on-table b24) (on b36 b24) (clear b36)
	(on-table b27) (on b28 b27) (clear b28)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b2 b1) (on b3 b2) (on b5 b3) (on b7 b5) (on b12 b7) (on b14 b12) (on b15 b14) (on b25 b15) (on b26 b25) (on b27 b26) (on b33 b27) (clear b33)
	(on-table b4) (on b11 b4) (on b24 b11) (on b35 b24) (clear b35)
	(on-table b6) (on b8 b6) (on b9 b8) (on b17 b9) (on b23 b17) (clear b23)
	(on-table b10) (on b16 b10) (on b21 b16) (on b22 b21) (on b36 b22) (clear b36)
	(on-table b13) (on b18 b13) (on b19 b18) (clear b19)
	(on-table b20) (on b34 b20) (clear b34)
	(on-table b28) (on b39 b28) (clear b39)
	(on-table b29) (on b32 b29) (on b37 b32) (clear b37)
	(on-table b30) (on b31 b30) (on b38 b31) (on b40 b38) (clear b40)
))
)


