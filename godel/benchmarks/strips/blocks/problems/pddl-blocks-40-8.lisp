;;---------------------------------------------

(define (problem p40_8)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30 b31 b32 b33 b34 b35 b36 b37 b38 b39 b40)
(:init
	(arm-empty)
	(on-table b1) (on b2 b1) (on b3 b2) (on b4 b3) (on b5 b4) (on b14 b5) (clear b14)
	(on-table b6) (on b7 b6) (on b17 b7) (on b22 b17) (on b33 b22) (on b40 b33) (clear b40)
	(on-table b8) (on b12 b8) (on b25 b12) (on b30 b25) (on b36 b30) (clear b36)
	(on-table b9) (on b10 b9) (on b11 b10) (on b13 b11) (on b16 b13) (on b18 b16) (on b20 b18) (on b24 b20) (on b26 b24) (clear b26)
	(on-table b15) (on b19 b15) (on b21 b19) (on b31 b21) (clear b31)
	(on-table b23) (on b28 b23) (on b37 b28) (on b39 b37) (clear b39)
	(on-table b27) (clear b27)
	(on-table b29) (on b35 b29) (on b38 b35) (clear b38)
	(on-table b32) (on b34 b32) (clear b34)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b5 b1) (on b8 b5) (on b9 b8) (on b23 b9) (on b24 b23) (on b28 b24) (on b33 b28) (on b38 b33) (clear b38)
	(on-table b2) (on b3 b2) (on b15 b3) (on b30 b15) (clear b30)
	(on-table b4) (on b6 b4) (on b7 b6) (on b12 b7) (on b17 b12) (on b20 b17) (on b25 b20) (clear b25)
	(on-table b10) (on b22 b10) (on b27 b22) (on b36 b27) (clear b36)
	(on-table b11) (on b26 b11) (on b37 b26) (clear b37)
	(on-table b13) (on b14 b13) (on b18 b14) (on b19 b18) (on b29 b19) (clear b29)
	(on-table b16) (on b21 b16) (on b31 b21) (on b34 b31) (clear b34)
	(on-table b32) (on b35 b32) (clear b35)
	(on-table b39) (on b40 b39) (clear b40)
))
)


