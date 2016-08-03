;;---------------------------------------------

(define (problem p50_24)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30 b31 b32 b33 b34 b35 b36 b37 b38 b39 b40 b41 b42 b43 b44 b45 b46 b47 b48 b49 b50)
(:init
	(arm-empty)
	(on-table b1) (on b2 b1) (on b6 b2) (on b12 b6) (on b13 b12) (on b16 b13) (on b22 b16) (on b32 b22) (clear b32)
	(on-table b3) (on b4 b3) (on b8 b4) (on b10 b8) (on b20 b10) (on b21 b20) (on b30 b21) (on b31 b30) (on b34 b31) (clear b34)
	(on-table b5) (on b11 b5) (on b14 b11) (on b17 b14) (on b18 b17) (on b23 b18) (on b24 b23) (on b25 b24) (on b26 b25) (on b41 b26) (on b48 b41) (clear b48)
	(on-table b7) (on b9 b7) (on b15 b9) (on b37 b15) (on b43 b37) (clear b43)
	(on-table b19) (on b33 b19) (on b45 b33) (on b46 b45) (on b50 b46) (clear b50)
	(on-table b27) (on b28 b27) (on b35 b28) (on b38 b35) (clear b38)
	(on-table b29) (on b36 b29) (on b42 b36) (clear b42)
	(on-table b39) (on b47 b39) (clear b47)
	(on-table b40) (on b44 b40) (clear b44)
	(on-table b49) (clear b49)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b5 b1) (on b8 b5) (on b13 b8) (on b18 b13) (on b22 b18) (on b25 b22) (on b27 b25) (on b32 b27) (on b44 b32) (clear b44)
	(on-table b2) (on b4 b2) (on b15 b4) (on b24 b15) (on b36 b24) (clear b36)
	(on-table b3) (on b12 b3) (on b42 b12) (on b45 b42) (on b46 b45) (clear b46)
	(on-table b6) (on b9 b6) (on b10 b9) (on b19 b10) (on b31 b19) (on b33 b31) (clear b33)
	(on-table b7) (on b11 b7) (on b28 b11) (on b29 b28) (on b41 b29) (on b47 b41) (on b50 b47) (clear b50)
	(on-table b14) (on b21 b14) (on b23 b21) (on b26 b23) (on b30 b26) (on b40 b30) (on b49 b40) (clear b49)
	(on-table b16) (on b17 b16) (on b20 b17) (on b34 b20) (on b35 b34) (on b38 b35) (on b43 b38) (clear b43)
	(on-table b37) (clear b37)
	(on-table b39) (on b48 b39) (clear b48)
))
)


