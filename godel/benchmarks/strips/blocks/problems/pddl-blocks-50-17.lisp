;;---------------------------------------------

(define (problem p50_17)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30 b31 b32 b33 b34 b35 b36 b37 b38 b39 b40 b41 b42 b43 b44 b45 b46 b47 b48 b49 b50)
(:init
	(arm-empty)
	(on-table b1) (on b10 b1) (on b11 b10) (on b19 b11) (on b21 b19) (on b28 b21) (on b29 b28) (on b32 b29) (on b50 b32) (clear b50)
	(on-table b2) (on b5 b2) (on b9 b5) (on b13 b9) (on b22 b13) (on b36 b22) (on b39 b36) (on b45 b39) (clear b45)
	(on-table b3) (on b4 b3) (on b6 b4) (on b12 b6) (on b17 b12) (on b23 b17) (on b40 b23) (on b44 b40) (clear b44)
	(on-table b7) (on b14 b7) (on b15 b14) (on b42 b15) (clear b42)
	(on-table b8) (on b20 b8) (on b30 b20) (on b31 b30) (clear b31)
	(on-table b16) (on b25 b16) (on b27 b25) (on b41 b27) (on b43 b41) (on b46 b43) (clear b46)
	(on-table b18) (on b26 b18) (on b38 b26) (on b47 b38) (clear b47)
	(on-table b24) (on b34 b24) (clear b34)
	(on-table b33) (on b35 b33) (on b37 b35) (on b48 b37) (clear b48)
	(on-table b49) (clear b49)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b6 b1) (on b7 b6) (on b9 b7) (on b12 b9) (on b15 b12) (on b18 b15) (on b19 b18) (on b26 b19) (on b28 b26) (on b33 b28) (on b49 b33) (on b50 b49) (clear b50)
	(on-table b2) (on b3 b2) (on b5 b3) (on b8 b5) (on b14 b8) (on b29 b14) (on b36 b29) (on b43 b36) (clear b43)
	(on-table b4) (on b10 b4) (on b11 b10) (on b13 b11) (on b16 b13) (on b22 b16) (on b23 b22) (on b27 b23) (on b45 b27) (on b47 b45) (clear b47)
	(on-table b17) (on b20 b17) (on b21 b20) (on b25 b21) (on b39 b25) (on b41 b39) (clear b41)
	(on-table b24) (on b32 b24) (on b38 b32) (on b40 b38) (clear b40)
	(on-table b30) (on b31 b30) (on b34 b31) (on b48 b34) (clear b48)
	(on-table b35) (on b37 b35) (on b42 b37) (clear b42)
	(on-table b44) (clear b44)
	(on-table b46) (clear b46)
))
)


