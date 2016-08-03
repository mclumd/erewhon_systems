;;---------------------------------------------

(define (problem p40_21)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30 b31 b32 b33 b34 b35 b36 b37 b38 b39 b40)
(:init
	(arm-empty)
	(on-table b1) (on b10 b1) (on b11 b10) (on b19 b11) (on b21 b19) (on b28 b21) (on b29 b28) (on b32 b29) (clear b32)
	(on-table b2) (on b5 b2) (on b9 b5) (on b13 b9) (on b22 b13) (on b36 b22) (on b39 b36) (clear b39)
	(on-table b3) (on b4 b3) (on b6 b4) (on b12 b6) (on b17 b12) (on b23 b17) (on b40 b23) (clear b40)
	(on-table b7) (on b14 b7) (on b15 b14) (clear b15)
	(on-table b8) (on b20 b8) (on b30 b20) (on b31 b30) (clear b31)
	(on-table b16) (on b25 b16) (on b27 b25) (clear b27)
	(on-table b18) (on b26 b18) (on b38 b26) (clear b38)
	(on-table b24) (on b34 b24) (clear b34)
	(on-table b33) (on b35 b33) (on b37 b35) (clear b37)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b3 b1) (on b5 b3) (on b15 b5) (on b25 b15) (clear b25)
	(on-table b2) (on b4 b2) (on b6 b4) (on b10 b6) (on b12 b10) (on b13 b12) (on b16 b13) (on b28 b16) (on b30 b28) (on b39 b30) (clear b39)
	(on-table b7) (on b8 b7) (on b21 b8) (on b23 b21) (on b26 b23) (on b37 b26) (on b40 b37) (clear b40)
	(on-table b9) (on b32 b9) (on b38 b32) (clear b38)
	(on-table b11) (on b18 b11) (on b22 b18) (on b31 b22) (clear b31)
	(on-table b14) (on b17 b14) (on b24 b17) (on b34 b24) (clear b34)
	(on-table b19) (on b20 b19) (on b29 b20) (on b35 b29) (on b36 b35) (clear b36)
	(on-table b27) (on b33 b27) (clear b33)
))
)


