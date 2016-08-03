;;---------------------------------------------

(define (problem p50_23)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30 b31 b32 b33 b34 b35 b36 b37 b38 b39 b40 b41 b42 b43 b44 b45 b46 b47 b48 b49 b50)
(:init
	(arm-empty)
	(on-table b1) (on b3 b1) (on b6 b3) (on b7 b6) (on b11 b7) (on b16 b11) (on b24 b16) (on b32 b24) (on b40 b32) (clear b40)
	(on-table b2) (on b4 b2) (on b8 b4) (on b10 b8) (on b12 b10) (on b13 b12) (on b15 b13) (on b17 b15) (on b19 b17) (on b20 b19) (on b33 b20) (clear b33)
	(on-table b5) (on b9 b5) (on b14 b9) (on b18 b14) (on b25 b18) (on b26 b25) (on b27 b26) (on b42 b27) (on b43 b42) (on b50 b43) (clear b50)
	(on-table b21) (on b22 b21) (on b23 b22) (on b28 b23) (on b30 b28) (on b31 b30) (on b34 b31) (on b35 b34) (on b37 b35) (on b38 b37) (on b49 b38) (clear b49)
	(on-table b29) (on b39 b29) (on b44 b39) (on b48 b44) (clear b48)
	(on-table b36) (on b41 b36) (on b45 b41) (on b46 b45) (on b47 b46) (clear b47)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b2 b1) (on b3 b2) (on b6 b3) (on b7 b6) (on b10 b7) (on b22 b10) (on b29 b22) (on b33 b29) (on b37 b33) (clear b37)
	(on-table b4) (on b5 b4) (on b8 b5) (on b19 b8) (on b20 b19) (on b35 b20) (clear b35)
	(on-table b9) (on b11 b9) (on b13 b11) (on b21 b13) (on b23 b21) (on b26 b23) (on b27 b26) (clear b27)
	(on-table b12) (on b14 b12) (on b16 b14) (on b18 b16) (on b28 b18) (on b32 b28) (on b34 b32) (on b39 b34) (on b49 b39) (clear b49)
	(on-table b15) (on b40 b15) (clear b40)
	(on-table b17) (on b24 b17) (on b25 b24) (on b45 b25) (on b47 b45) (clear b47)
	(on-table b30) (on b31 b30) (on b36 b31) (on b38 b36) (on b43 b38) (on b46 b43) (clear b46)
	(on-table b41) (on b44 b41) (clear b44)
	(on-table b42) (clear b42)
	(on-table b48) (clear b48)
	(on-table b50) (clear b50)
))
)


