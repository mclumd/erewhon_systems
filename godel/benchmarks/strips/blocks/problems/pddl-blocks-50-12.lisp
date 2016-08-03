;;---------------------------------------------

(define (problem p50_12)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30 b31 b32 b33 b34 b35 b36 b37 b38 b39 b40 b41 b42 b43 b44 b45 b46 b47 b48 b49 b50)
(:init
	(arm-empty)
	(on-table b1) (on b2 b1) (on b4 b2) (on b5 b4) (on b9 b5) (on b10 b9) (on b11 b10) (on b17 b11) (on b18 b17) (on b20 b18) (on b23 b20) (on b27 b23) (clear b27)
	(on-table b3) (on b12 b3) (on b16 b12) (on b31 b16) (on b32 b31) (on b39 b32) (on b40 b39) (on b48 b40) (clear b48)
	(on-table b6) (on b7 b6) (on b8 b7) (on b13 b8) (on b15 b13) (on b24 b15) (on b26 b24) (on b30 b26) (on b42 b30) (on b45 b42) (on b49 b45) (clear b49)
	(on-table b14) (on b22 b14) (on b35 b22) (on b41 b35) (on b43 b41) (clear b43)
	(on-table b19) (on b21 b19) (on b37 b21) (on b46 b37) (on b50 b46) (clear b50)
	(on-table b25) (on b28 b25) (on b29 b28) (on b34 b29) (clear b34)
	(on-table b33) (on b36 b33) (on b38 b36) (on b47 b38) (clear b47)
	(on-table b44) (clear b44)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b5 b1) (on b7 b5) (on b8 b7) (on b12 b8) (on b17 b12) (on b18 b17) (on b19 b18) (on b22 b19) (on b25 b22) (on b26 b25) (on b47 b26) (clear b47)
	(on-table b2) (on b3 b2) (on b6 b3) (on b10 b6) (on b11 b10) (on b13 b11) (on b14 b13) (on b16 b14) (on b23 b16) (on b31 b23) (on b32 b31) (on b42 b32) (on b46 b42) (clear b46)
	(on-table b4) (on b9 b4) (on b15 b9) (on b20 b15) (on b21 b20) (on b27 b21) (on b30 b27) (on b40 b30) (on b44 b40) (on b45 b44) (on b49 b45) (clear b49)
	(on-table b24) (on b28 b24) (on b34 b28) (on b39 b34) (on b48 b39) (clear b48)
	(on-table b29) (on b33 b29) (on b35 b33) (on b38 b35) (clear b38)
	(on-table b36) (on b37 b36) (on b41 b37) (on b50 b41) (clear b50)
	(on-table b43) (clear b43)
))
)


