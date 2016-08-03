;;---------------------------------------------

(define (problem p40_14)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30 b31 b32 b33 b34 b35 b36 b37 b38 b39 b40)
(:init
	(arm-empty)
	(on-table b1) (on b3 b1) (on b5 b3) (on b15 b5) (on b18 b15) (clear b18)
	(on-table b2) (on b4 b2) (on b6 b4) (on b11 b6) (on b14 b11) (on b21 b14) (on b29 b21) (on b31 b29) (on b33 b31) (on b35 b33) (on b39 b35) (clear b39)
	(on-table b7) (on b32 b7) (clear b32)
	(on-table b8) (on b9 b8) (on b10 b9) (on b12 b10) (on b13 b12) (on b17 b13) (on b20 b17) (on b24 b20) (on b28 b24) (on b30 b28) (on b34 b30) (on b37 b34) (clear b37)
	(on-table b16) (on b23 b16) (on b25 b23) (clear b25)
	(on-table b19) (on b36 b19) (on b38 b36) (on b40 b38) (clear b40)
	(on-table b22) (on b26 b22) (on b27 b26) (clear b27)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b6 b1) (on b16 b6) (on b31 b16) (on b37 b31) (clear b37)
	(on-table b2) (on b4 b2) (on b5 b4) (on b7 b5) (on b8 b7) (on b9 b8) (on b15 b9) (on b19 b15) (on b32 b19) (clear b32)
	(on-table b3) (on b11 b3) (on b18 b11) (on b20 b18) (on b27 b20) (on b28 b27) (on b33 b28) (clear b33)
	(on-table b10) (on b22 b10) (on b24 b22) (on b34 b24) (clear b34)
	(on-table b12) (on b17 b12) (on b21 b17) (on b29 b21) (on b30 b29) (clear b30)
	(on-table b13) (on b14 b13) (on b38 b14) (clear b38)
	(on-table b23) (on b25 b23) (on b26 b25) (clear b26)
	(on-table b35) (clear b35)
	(on-table b36) (clear b36)
	(on-table b39) (clear b39)
	(on-table b40) (clear b40)
))
)


