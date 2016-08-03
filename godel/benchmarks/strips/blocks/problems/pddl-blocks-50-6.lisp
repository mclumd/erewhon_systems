;;---------------------------------------------

(define (problem p50_6)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30 b31 b32 b33 b34 b35 b36 b37 b38 b39 b40 b41 b42 b43 b44 b45 b46 b47 b48 b49 b50)
(:init
	(arm-empty)
	(on-table b1) (on b2 b1) (on b3 b2) (on b4 b3) (on b5 b4) (on b10 b5) (on b30 b10) (on b32 b30) (on b38 b32) (on b42 b38) (on b47 b42) (on b50 b47) (clear b50)
	(on-table b6) (on b18 b6) (on b20 b18) (on b21 b20) (on b23 b21) (on b31 b23) (on b37 b31) (on b43 b37) (on b44 b43) (clear b44)
	(on-table b7) (on b11 b7) (on b12 b11) (on b15 b12) (on b16 b15) (on b17 b16) (on b25 b17) (on b41 b25) (on b45 b41) (clear b45)
	(on-table b8) (on b9 b8) (on b13 b9) (on b19 b13) (on b24 b19) (on b29 b24) (clear b29)
	(on-table b14) (on b22 b14) (on b35 b22) (on b36 b35) (on b39 b36) (on b40 b39) (on b46 b40) (clear b46)
	(on-table b26) (on b27 b26) (on b28 b27) (on b48 b28) (clear b48)
	(on-table b33) (on b34 b33) (clear b34)
	(on-table b49) (clear b49)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b3 b1) (on b4 b3) (on b6 b4) (on b7 b6) (on b8 b7) (on b9 b8) (on b11 b9) (on b12 b11) (on b13 b12) (on b15 b13) (on b18 b15) (on b19 b18) (on b24 b19) (clear b24)
	(on-table b2) (on b16 b2) (on b27 b16) (on b32 b27) (on b43 b32) (on b50 b43) (clear b50)
	(on-table b5) (on b10 b5) (on b14 b10) (on b22 b14) (on b35 b22) (on b40 b35) (on b46 b40) (clear b46)
	(on-table b17) (on b20 b17) (on b21 b20) (on b23 b21) (on b26 b23) (on b28 b26) (on b30 b28) (on b34 b30) (on b36 b34) (clear b36)
	(on-table b25) (on b29 b25) (on b31 b29) (on b41 b31) (clear b41)
	(on-table b33) (on b38 b33) (on b47 b38) (on b49 b47) (clear b49)
	(on-table b37) (clear b37)
	(on-table b39) (on b45 b39) (on b48 b45) (clear b48)
	(on-table b42) (on b44 b42) (clear b44)
))
)


