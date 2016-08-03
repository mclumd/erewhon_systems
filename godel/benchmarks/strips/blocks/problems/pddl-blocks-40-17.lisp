;;---------------------------------------------

(define (problem p40_17)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30 b31 b32 b33 b34 b35 b36 b37 b38 b39 b40)
(:init
	(arm-empty)
	(on-table b1) (on b2 b1) (on b3 b2) (on b28 b3) (on b29 b28) (on b37 b29) (on b39 b37) (clear b39)
	(on-table b4) (on b6 b4) (on b9 b6) (on b22 b9) (on b26 b22) (on b35 b26) (clear b35)
	(on-table b5) (on b7 b5) (on b13 b7) (on b15 b13) (on b21 b15) (on b24 b21) (on b36 b24) (clear b36)
	(on-table b8) (on b20 b8) (clear b20)
	(on-table b10) (on b11 b10) (on b14 b11) (on b16 b14) (on b18 b16) (on b27 b18) (on b38 b27) (clear b38)
	(on-table b12) (on b23 b12) (on b25 b23) (clear b25)
	(on-table b17) (on b31 b17) (on b33 b31) (clear b33)
	(on-table b19) (on b30 b19) (on b32 b30) (clear b32)
	(on-table b34) (clear b34)
	(on-table b40) (clear b40)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b9 b1) (on b22 b9) (on b32 b22) (on b39 b32) (clear b39)
	(on-table b2) (on b3 b2) (on b5 b3) (on b10 b5) (on b14 b10) (on b30 b14) (on b37 b30) (clear b37)
	(on-table b4) (on b8 b4) (on b11 b8) (on b15 b11) (on b23 b15) (clear b23)
	(on-table b6) (on b7 b6) (on b12 b7) (on b17 b12) (on b18 b17) (on b19 b18) (on b20 b19) (on b28 b20) (clear b28)
	(on-table b13) (on b16 b13) (on b29 b16) (on b35 b29) (clear b35)
	(on-table b21) (on b24 b21) (on b31 b24) (on b33 b31) (on b36 b33) (on b40 b36) (clear b40)
	(on-table b25) (on b26 b25) (clear b26)
	(on-table b27) (clear b27)
	(on-table b34) (on b38 b34) (clear b38)
))
)


