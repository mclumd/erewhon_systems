;;---------------------------------------------

(define (problem p40_4)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30 b31 b32 b33 b34 b35 b36 b37 b38 b39 b40)
(:init
	(arm-empty)
	(on-table b1) (on b3 b1) (on b19 b3) (on b23 b19) (on b30 b23) (on b35 b30) (on b40 b35) (clear b40)
	(on-table b2) (on b8 b2) (on b9 b8) (on b18 b9) (on b22 b18) (on b25 b22) (on b29 b25) (clear b29)
	(on-table b4) (on b5 b4) (on b6 b5) (on b7 b6) (on b10 b7) (on b13 b10) (on b15 b13) (on b16 b15) (on b17 b16) (on b27 b17) (on b39 b27) (clear b39)
	(on-table b11) (on b12 b11) (on b26 b12) (on b32 b26) (on b37 b32) (clear b37)
	(on-table b14) (on b31 b14) (on b34 b31) (clear b34)
	(on-table b20) (on b28 b20) (on b36 b28) (clear b36)
	(on-table b21) (on b24 b21) (on b33 b24) (clear b33)
	(on-table b38) (clear b38)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b2 b1) (on b3 b2) (on b4 b3) (on b5 b4) (on b9 b5) (on b10 b9) (on b12 b10) (on b15 b12) (clear b15)
	(on-table b6) (on b7 b6) (on b8 b7) (on b13 b8) (on b14 b13) (clear b14)
	(on-table b11) (on b34 b11) (clear b34)
	(on-table b16) (clear b16)
	(on-table b17) (on b21 b17) (on b23 b21) (on b35 b23) (clear b35)
	(on-table b18) (on b19 b18) (on b24 b19) (on b26 b24) (clear b26)
	(on-table b20) (clear b20)
	(on-table b22) (on b36 b22) (on b40 b36) (clear b40)
	(on-table b25) (on b27 b25) (on b28 b27) (on b30 b28) (on b32 b30) (on b33 b32) (clear b33)
	(on-table b29) (on b38 b29) (clear b38)
	(on-table b31) (on b37 b31) (on b39 b37) (clear b39)
))
)


