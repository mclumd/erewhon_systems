;;---------------------------------------------

(define (problem p40_22)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30 b31 b32 b33 b34 b35 b36 b37 b38 b39 b40)
(:init
	(arm-empty)
	(on-table b1) (on b6 b1) (on b7 b6) (on b12 b7) (on b15 b12) (on b21 b15) (on b25 b21) (on b33 b25) (on b37 b33) (on b40 b37) (clear b40)
	(on-table b2) (on b4 b2) (on b8 b4) (on b13 b8) (on b24 b13) (on b28 b24) (on b38 b28) (clear b38)
	(on-table b3) (on b17 b3) (on b19 b17) (on b27 b19) (on b32 b27) (clear b32)
	(on-table b5) (on b11 b5) (on b22 b11) (on b23 b22) (clear b23)
	(on-table b9) (on b10 b9) (on b20 b10) (clear b20)
	(on-table b14) (on b18 b14) (on b26 b18) (on b29 b26) (clear b29)
	(on-table b16) (on b30 b16) (on b39 b30) (clear b39)
	(on-table b31) (on b34 b31) (on b35 b34) (on b36 b35) (clear b36)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b4 b1) (on b13 b4) (on b14 b13) (on b17 b14) (on b22 b17) (on b24 b22) (on b33 b24) (on b36 b33) (on b37 b36) (on b40 b37) (clear b40)
	(on-table b2) (on b5 b2) (on b15 b5) (on b16 b15) (on b29 b16) (on b34 b29) (on b35 b34) (clear b35)
	(on-table b3) (on b6 b3) (on b9 b6) (on b10 b9) (on b21 b10) (on b25 b21) (on b27 b25) (on b30 b27) (clear b30)
	(on-table b7) (on b8 b7) (on b12 b8) (on b31 b12) (on b32 b31) (clear b32)
	(on-table b11) (on b18 b11) (on b20 b18) (on b23 b20) (on b26 b23) (clear b26)
	(on-table b19) (on b28 b19) (clear b28)
	(on-table b38) (clear b38)
	(on-table b39) (clear b39)
))
)


