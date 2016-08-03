;;---------------------------------------------

(define (problem p50_7)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30 b31 b32 b33 b34 b35 b36 b37 b38 b39 b40 b41 b42 b43 b44 b45 b46 b47 b48 b49 b50)
(:init
	(arm-empty)
	(on-table b1) (on b5 b1) (on b8 b5) (on b9 b8) (on b23 b9) (on b24 b23) (on b28 b24) (on b33 b28) (on b38 b33) (on b42 b38) (clear b42)
	(on-table b2) (on b3 b2) (on b15 b3) (on b30 b15) (on b48 b30) (clear b48)
	(on-table b4) (on b6 b4) (on b7 b6) (on b12 b7) (on b17 b12) (on b20 b17) (on b25 b20) (on b50 b25) (clear b50)
	(on-table b10) (on b22 b10) (on b27 b22) (on b36 b27) (on b49 b36) (clear b49)
	(on-table b11) (on b26 b11) (on b37 b26) (clear b37)
	(on-table b13) (on b14 b13) (on b18 b14) (on b19 b18) (on b29 b19) (on b43 b29) (on b45 b43) (clear b45)
	(on-table b16) (on b21 b16) (on b31 b21) (on b34 b31) (on b41 b34) (on b46 b41) (clear b46)
	(on-table b32) (on b35 b32) (clear b35)
	(on-table b39) (on b40 b39) (on b44 b40) (on b47 b44) (clear b47)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b2 b1) (on b3 b2) (on b7 b3) (on b13 b7) (on b15 b13) (on b16 b15) (on b21 b16) (on b28 b21) (on b42 b28) (on b46 b42) (on b47 b46) (clear b47)
	(on-table b4) (on b9 b4) (on b10 b9) (on b11 b10) (on b17 b11) (on b23 b17) (on b24 b23) (on b31 b24) (on b35 b31) (clear b35)
	(on-table b5) (on b8 b5) (on b14 b8) (on b20 b14) (on b22 b20) (on b25 b22) (on b34 b25) (on b39 b34) (on b43 b39) (clear b43)
	(on-table b6) (on b12 b6) (on b18 b12) (on b19 b18) (on b27 b19) (on b38 b27) (on b41 b38) (on b44 b41) (clear b44)
	(on-table b26) (on b40 b26) (clear b40)
	(on-table b29) (on b32 b29) (clear b32)
	(on-table b30) (on b33 b30) (on b36 b33) (on b37 b36) (on b45 b37) (on b48 b45) (clear b48)
	(on-table b49) (on b50 b49) (clear b50)
))
)


