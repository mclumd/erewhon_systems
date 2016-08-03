;;---------------------------------------------

(define (problem p40_10)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30 b31 b32 b33 b34 b35 b36 b37 b38 b39 b40)
(:init
	(arm-empty)
	(on-table b1) (on b10 b1) (on b11 b10) (on b15 b11) (clear b15)
	(on-table b2) (on b3 b2) (on b22 b3) (on b38 b22) (clear b38)
	(on-table b4) (on b5 b4) (on b9 b5) (on b13 b9) (on b16 b13) (on b37 b16) (on b40 b37) (clear b40)
	(on-table b6) (on b8 b6) (on b34 b8) (on b35 b34) (clear b35)
	(on-table b7) (on b12 b7) (on b14 b12) (on b20 b14) (on b21 b20) (on b32 b21) (on b36 b32) (clear b36)
	(on-table b17) (on b18 b17) (clear b18)
	(on-table b19) (on b23 b19) (on b26 b23) (on b31 b26) (on b33 b31) (on b39 b33) (clear b39)
	(on-table b24) (on b29 b24) (on b30 b29) (clear b30)
	(on-table b25) (on b27 b25) (clear b27)
	(on-table b28) (clear b28)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b2 b1) (on b3 b2) (on b4 b3) (on b7 b4) (on b8 b7) (on b9 b8) (on b10 b9) (on b11 b10) (on b40 b11) (clear b40)
	(on-table b5) (on b6 b5) (on b16 b6) (on b18 b16) (on b21 b18) (on b23 b21) (on b26 b23) (on b28 b26) (on b29 b28) (on b31 b29) (clear b31)
	(on-table b12) (on b13 b12) (on b14 b13) (on b20 b14) (on b25 b20) (on b27 b25) (on b30 b27) (on b37 b30) (clear b37)
	(on-table b15) (on b17 b15) (on b19 b17) (on b22 b19) (on b24 b22) (on b33 b24) (on b34 b33) (on b36 b34) (on b38 b36) (on b39 b38) (clear b39)
	(on-table b32) (clear b32)
	(on-table b35) (clear b35)
))
)


