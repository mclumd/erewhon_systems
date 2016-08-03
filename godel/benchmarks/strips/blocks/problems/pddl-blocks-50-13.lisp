;;---------------------------------------------

(define (problem p50_13)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30 b31 b32 b33 b34 b35 b36 b37 b38 b39 b40 b41 b42 b43 b44 b45 b46 b47 b48 b49 b50)
(:init
	(arm-empty)
	(on-table b1) (on b6 b1) (on b13 b6) (on b21 b13) (on b22 b21) (on b28 b22) (on b31 b28) (on b33 b31) (on b37 b33) (clear b37)
	(on-table b2) (on b3 b2) (on b5 b3) (on b7 b5) (on b17 b7) (on b19 b17) (on b20 b19) (on b25 b20) (on b40 b25) (clear b40)
	(on-table b4) (on b8 b4) (on b10 b8) (on b18 b10) (on b26 b18) (on b27 b26) (on b29 b27) (on b32 b29) (on b36 b32) (on b45 b36) (on b46 b45) (on b47 b46) (clear b47)
	(on-table b9) (on b11 b9) (on b12 b11) (on b14 b12) (on b15 b14) (on b16 b15) (on b30 b16) (on b34 b30) (on b35 b34) (on b41 b35) (on b43 b41) (on b44 b43) (clear b44)
	(on-table b23) (on b24 b23) (on b38 b24) (clear b38)
	(on-table b39) (on b42 b39) (clear b42)
	(on-table b48) (clear b48)
	(on-table b49) (on b50 b49) (clear b50)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b2 b1) (on b3 b2) (on b4 b3) (on b5 b4) (on b6 b5) (on b10 b6) (on b12 b10) (on b14 b12) (on b22 b14) (on b23 b22) (on b26 b23) (on b39 b26) (clear b39)
	(on-table b7) (on b9 b7) (on b16 b9) (on b17 b16) (on b18 b17) (on b20 b18) (on b21 b20) (on b24 b21) (on b35 b24) (clear b35)
	(on-table b8) (on b11 b8) (on b25 b11) (on b27 b25) (on b28 b27) (on b33 b28) (clear b33)
	(on-table b13) (on b15 b13) (on b19 b15) (on b31 b19) (on b38 b31) (on b49 b38) (on b50 b49) (clear b50)
	(on-table b29) (on b34 b29) (on b40 b34) (on b41 b40) (on b43 b41) (clear b43)
	(on-table b30) (on b32 b30) (on b44 b32) (on b45 b44) (on b47 b45) (clear b47)
	(on-table b36) (on b37 b36) (on b46 b37) (on b48 b46) (clear b48)
	(on-table b42) (clear b42)
))
)


