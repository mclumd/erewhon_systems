;;---------------------------------------------

(define (problem p40_6)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30 b31 b32 b33 b34 b35 b36 b37 b38 b39 b40)
(:init
	(arm-empty)
	(on-table b1) (on b2 b1) (on b5 b2) (on b6 b5) (on b9 b6) (on b14 b9) (on b16 b14) (on b23 b16) (on b25 b23) (on b34 b25) (on b39 b34) (clear b39)
	(on-table b3) (on b7 b3) (on b11 b7) (on b12 b11) (on b17 b12) (on b19 b17) (on b28 b19) (clear b28)
	(on-table b4) (on b8 b4) (on b15 b8) (on b29 b15) (on b30 b29) (on b31 b30) (on b36 b31) (on b38 b36) (clear b38)
	(on-table b10) (on b13 b10) (on b21 b13) (on b22 b21) (on b32 b22) (clear b32)
	(on-table b18) (on b20 b18) (on b27 b20) (clear b27)
	(on-table b24) (on b26 b24) (on b33 b26) (on b35 b33) (on b37 b35) (on b40 b37) (clear b40)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b4 b1) (on b7 b4) (on b11 b7) (on b14 b11) (on b18 b14) (clear b18)
	(on-table b2) (on b5 b2) (on b12 b5) (on b13 b12) (on b25 b13) (on b26 b25) (on b34 b26) (clear b34)
	(on-table b3) (on b6 b3) (on b15 b6) (on b16 b15) (on b21 b16) (clear b21)
	(on-table b8) (on b31 b8) (clear b31)
	(on-table b9) (on b17 b9) (on b19 b17) (on b36 b19) (clear b36)
	(on-table b10) (on b20 b10) (on b29 b20) (clear b29)
	(on-table b22) (on b33 b22) (clear b33)
	(on-table b23) (on b24 b23) (clear b24)
	(on-table b27) (on b37 b27) (on b38 b37) (on b39 b38) (clear b39)
	(on-table b28) (on b32 b28) (clear b32)
	(on-table b30) (on b35 b30) (on b40 b35) (clear b40)
))
)


