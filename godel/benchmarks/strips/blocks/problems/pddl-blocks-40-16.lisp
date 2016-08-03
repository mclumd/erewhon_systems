;;---------------------------------------------

(define (problem p40_16)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30 b31 b32 b33 b34 b35 b36 b37 b38 b39 b40)
(:init
	(arm-empty)
	(on-table b1) (on b6 b1) (on b13 b6) (on b21 b13) (on b22 b21) (on b28 b22) (on b31 b28) (on b33 b31) (on b37 b33) (clear b37)
	(on-table b2) (on b3 b2) (on b5 b3) (on b7 b5) (on b17 b7) (on b19 b17) (on b20 b19) (on b25 b20) (on b40 b25) (clear b40)
	(on-table b4) (on b8 b4) (on b10 b8) (on b18 b10) (on b26 b18) (on b27 b26) (on b29 b27) (on b32 b29) (on b36 b32) (clear b36)
	(on-table b9) (on b11 b9) (on b12 b11) (on b14 b12) (on b15 b14) (on b16 b15) (on b30 b16) (on b34 b30) (on b35 b34) (clear b35)
	(on-table b23) (on b24 b23) (on b38 b24) (clear b38)
	(on-table b39) (clear b39)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b2 b1) (on b4 b2) (on b8 b4) (on b13 b8) (on b14 b13) (on b16 b14) (on b20 b16) (on b22 b20) (clear b22)
	(on-table b3) (on b5 b3) (on b6 b5) (on b10 b6) (on b17 b10) (on b25 b17) (on b26 b25) (on b32 b26) (on b33 b32) (on b39 b33) (clear b39)
	(on-table b7) (on b24 b7) (on b27 b24) (clear b27)
	(on-table b9) (on b11 b9) (on b19 b11) (on b36 b19) (clear b36)
	(on-table b12) (on b15 b12) (on b37 b15) (clear b37)
	(on-table b18) (on b31 b18) (on b34 b31) (on b40 b34) (clear b40)
	(on-table b21) (on b29 b21) (on b30 b29) (on b35 b30) (clear b35)
	(on-table b23) (on b28 b23) (on b38 b28) (clear b38)
))
)


