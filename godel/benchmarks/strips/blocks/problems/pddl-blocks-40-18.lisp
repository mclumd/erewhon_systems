;;---------------------------------------------

(define (problem p40_18)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30 b31 b32 b33 b34 b35 b36 b37 b38 b39 b40)
(:init
	(arm-empty)
	(on-table b1) (on b4 b1) (on b27 b4) (on b29 b27) (clear b29)
	(on-table b2) (on b5 b2) (on b7 b5) (on b12 b7) (on b20 b12) (on b37 b20) (on b38 b37) (on b39 b38) (clear b39)
	(on-table b3) (on b8 b3) (on b30 b8) (on b36 b30) (clear b36)
	(on-table b6) (on b10 b6) (on b14 b10) (on b31 b14) (on b32 b31) (on b33 b32) (clear b33)
	(on-table b9) (on b13 b9) (on b19 b13) (on b40 b19) (clear b40)
	(on-table b11) (on b15 b11) (on b16 b15) (on b17 b16) (on b21 b17) (on b24 b21) (on b25 b24) (clear b25)
	(on-table b18) (on b23 b18) (on b26 b23) (on b28 b26) (clear b28)
	(on-table b22) (on b34 b22) (clear b34)
	(on-table b35) (clear b35)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b3 b1) (on b6 b3) (on b16 b6) (on b17 b16) (on b22 b17) (on b36 b22) (clear b36)
	(on-table b2) (on b4 b2) (on b5 b4) (on b7 b5) (on b10 b7) (on b11 b10) (on b12 b11) (on b14 b12) (on b15 b14) (on b21 b15) (on b40 b21) (clear b40)
	(on-table b8) (on b18 b8) (on b19 b18) (on b27 b19) (on b30 b27) (clear b30)
	(on-table b9) (on b13 b9) (on b20 b13) (on b24 b20) (on b28 b24) (on b29 b28) (on b33 b29) (on b34 b33) (clear b34)
	(on-table b23) (on b25 b23) (on b26 b25) (on b31 b26) (on b32 b31) (on b35 b32) (on b37 b35) (on b38 b37) (on b39 b38) (clear b39)
))
)


