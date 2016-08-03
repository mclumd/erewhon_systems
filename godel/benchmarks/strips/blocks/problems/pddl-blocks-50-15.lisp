;;---------------------------------------------

(define (problem p50_15)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30 b31 b32 b33 b34 b35 b36 b37 b38 b39 b40 b41 b42 b43 b44 b45 b46 b47 b48 b49 b50)
(:init
	(arm-empty)
	(on-table b1) (on b3 b1) (on b6 b3) (on b16 b6) (on b17 b16) (on b22 b17) (on b36 b22) (on b50 b36) (clear b50)
	(on-table b2) (on b4 b2) (on b5 b4) (on b7 b5) (on b10 b7) (on b11 b10) (on b12 b11) (on b14 b12) (on b15 b14) (on b21 b15) (on b40 b21) (on b45 b40) (clear b45)
	(on-table b8) (on b18 b8) (on b19 b18) (on b27 b19) (on b30 b27) (on b42 b30) (on b43 b42) (on b44 b43) (on b47 b44) (clear b47)
	(on-table b9) (on b13 b9) (on b20 b13) (on b24 b20) (on b28 b24) (on b29 b28) (on b33 b29) (on b34 b33) (on b41 b34) (on b48 b41) (clear b48)
	(on-table b23) (on b25 b23) (on b26 b25) (on b31 b26) (on b32 b31) (on b35 b32) (on b37 b35) (on b38 b37) (on b39 b38) (on b49 b39) (clear b49)
	(on-table b46) (clear b46)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b2 b1) (on b5 b2) (on b7 b5) (on b18 b7) (on b28 b18) (on b33 b28) (on b35 b33) (on b38 b35) (on b42 b38) (on b46 b42) (clear b46)
	(on-table b3) (on b6 b3) (on b11 b6) (on b14 b11) (on b20 b14) (on b23 b20) (on b30 b23) (on b31 b30) (on b32 b31) (on b39 b32) (on b50 b39) (clear b50)
	(on-table b4) (on b8 b4) (on b15 b8) (on b16 b15) (on b29 b16) (on b34 b29) (on b43 b34) (on b45 b43) (on b49 b45) (clear b49)
	(on-table b9) (on b10 b9) (on b12 b10) (on b17 b12) (on b22 b17) (on b44 b22) (on b47 b44) (on b48 b47) (clear b48)
	(on-table b13) (on b21 b13) (on b24 b21) (on b40 b24) (on b41 b40) (clear b41)
	(on-table b19) (on b25 b19) (on b26 b25) (on b27 b26) (on b36 b27) (on b37 b36) (clear b37)
))
)


