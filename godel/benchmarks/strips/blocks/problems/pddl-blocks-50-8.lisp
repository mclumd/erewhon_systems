;;---------------------------------------------

(define (problem p50_8)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30 b31 b32 b33 b34 b35 b36 b37 b38 b39 b40 b41 b42 b43 b44 b45 b46 b47 b48 b49 b50)
(:init
	(arm-empty)
	(on-table b1) (on b5 b1) (on b6 b5) (on b8 b6) (on b15 b8) (on b34 b15) (clear b34)
	(on-table b2) (on b14 b2) (on b19 b14) (on b21 b19) (on b44 b21) (clear b44)
	(on-table b3) (on b10 b3) (on b20 b10) (on b25 b20) (on b29 b25) (on b31 b29) (on b33 b31) (clear b33)
	(on-table b4) (on b7 b4) (on b11 b7) (on b23 b11) (on b26 b23) (on b28 b26) (on b37 b28) (clear b37)
	(on-table b9) (on b13 b9) (on b16 b13) (on b18 b16) (on b24 b18) (on b32 b24) (on b35 b32) (on b36 b35) (clear b36)
	(on-table b12) (on b22 b12) (on b42 b22) (on b45 b42) (clear b45)
	(on-table b17) (on b27 b17) (on b30 b27) (on b40 b30) (on b46 b40) (clear b46)
	(on-table b38) (on b49 b38) (on b50 b49) (clear b50)
	(on-table b39) (on b41 b39) (on b43 b41) (on b47 b43) (clear b47)
	(on-table b48) (clear b48)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b3 b1) (on b4 b3) (on b5 b4) (on b12 b5) (on b13 b12) (on b21 b13) (on b31 b21) (clear b31)
	(on-table b2) (on b15 b2) (on b33 b15) (on b36 b33) (on b38 b36) (on b41 b38) (on b43 b41) (on b48 b43) (on b49 b48) (clear b49)
	(on-table b6) (on b8 b6) (on b14 b8) (on b24 b14) (on b25 b24) (on b40 b25) (clear b40)
	(on-table b7) (on b18 b7) (on b19 b18) (on b29 b19) (on b44 b29) (clear b44)
	(on-table b9) (on b26 b9) (on b27 b26) (on b30 b27) (on b42 b30) (clear b42)
	(on-table b10) (on b22 b10) (on b47 b22) (clear b47)
	(on-table b11) (on b16 b11) (on b20 b16) (on b23 b20) (on b28 b23) (on b39 b28) (on b46 b39) (clear b46)
	(on-table b17) (on b35 b17) (on b37 b35) (clear b37)
	(on-table b32) (on b34 b32) (clear b34)
	(on-table b45) (on b50 b45) (clear b50)
))
)


