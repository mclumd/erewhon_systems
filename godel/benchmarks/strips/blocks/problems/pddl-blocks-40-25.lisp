;;---------------------------------------------

(define (problem p40_25)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30 b31 b32 b33 b34 b35 b36 b37 b38 b39 b40)
(:init
	(arm-empty)
	(on-table b1) (on b3 b1) (on b7 b3) (on b11 b7) (on b14 b11) (on b16 b14) (on b30 b16) (clear b30)
	(on-table b2) (on b5 b2) (on b12 b5) (on b15 b12) (on b25 b15) (on b26 b25) (on b33 b26) (on b40 b33) (clear b40)
	(on-table b4) (on b8 b4) (on b31 b8) (on b35 b31) (on b37 b35) (clear b37)
	(on-table b6) (on b9 b6) (on b17 b9) (on b23 b17) (clear b23)
	(on-table b10) (on b13 b10) (on b18 b13) (on b19 b18) (on b21 b19) (on b22 b21) (on b24 b22) (on b27 b24) (clear b27)
	(on-table b20) (on b29 b20) (clear b29)
	(on-table b28) (on b34 b28) (clear b34)
	(on-table b32) (clear b32)
	(on-table b36) (on b39 b36) (clear b39)
	(on-table b38) (clear b38)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b2 b1) (on b5 b2) (on b8 b5) (on b11 b8) (on b12 b11) (on b15 b12) (on b16 b15) (on b18 b16) (on b26 b18) (on b28 b26) (clear b28)
	(on-table b3) (on b4 b3) (on b9 b4) (on b10 b9) (on b13 b10) (on b14 b13) (on b17 b14) (on b29 b17) (clear b29)
	(on-table b6) (on b7 b6) (on b21 b7) (on b24 b21) (clear b24)
	(on-table b19) (on b20 b19) (on b23 b20) (on b33 b23) (on b34 b33) (on b36 b34) (clear b36)
	(on-table b22) (on b35 b22) (on b37 b35) (on b40 b37) (clear b40)
	(on-table b25) (on b32 b25) (clear b32)
	(on-table b27) (on b31 b27) (on b38 b31) (clear b38)
	(on-table b30) (on b39 b30) (clear b39)
))
)


