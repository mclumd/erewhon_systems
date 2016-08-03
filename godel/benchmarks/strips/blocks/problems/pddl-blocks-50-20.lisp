;;---------------------------------------------

(define (problem p50_20)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30 b31 b32 b33 b34 b35 b36 b37 b38 b39 b40 b41 b42 b43 b44 b45 b46 b47 b48 b49 b50)
(:init
	(arm-empty)
	(on-table b1) (on b5 b1) (on b9 b5) (on b12 b9) (on b14 b12) (on b17 b14) (on b28 b17) (on b30 b28) (on b33 b30) (on b43 b33) (on b49 b43) (clear b49)
	(on-table b2) (on b3 b2) (on b4 b3) (on b20 b4) (on b25 b20) (on b37 b25) (clear b37)
	(on-table b6) (on b7 b6) (on b8 b7) (on b10 b8) (on b15 b10) (on b16 b15) (on b19 b16) (on b36 b19) (on b39 b36) (on b42 b39) (on b46 b42) (on b47 b46) (clear b47)
	(on-table b11) (on b13 b11) (on b21 b13) (on b35 b21) (on b40 b35) (clear b40)
	(on-table b18) (on b27 b18) (clear b27)
	(on-table b22) (on b23 b22) (on b24 b23) (on b26 b24) (on b29 b26) (on b32 b29) (clear b32)
	(on-table b31) (on b34 b31) (on b38 b34) (on b41 b38) (clear b41)
	(on-table b44) (on b45 b44) (on b48 b45) (on b50 b48) (clear b50)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b4 b1) (on b7 b4) (on b11 b7) (on b12 b11) (on b29 b12) (on b38 b29) (clear b38)
	(on-table b2) (on b3 b2) (on b10 b3) (on b15 b10) (on b30 b15) (on b39 b30) (clear b39)
	(on-table b5) (on b6 b5) (on b9 b6) (on b16 b9) (on b17 b16) (on b22 b17) (on b24 b22) (on b26 b24) (on b27 b26) (on b37 b27) (clear b37)
	(on-table b8) (on b13 b8) (on b14 b13) (on b18 b14) (on b19 b18) (on b28 b19) (on b33 b28) (on b35 b33) (on b43 b35) (on b44 b43) (on b46 b44) (clear b46)
	(on-table b20) (on b21 b20) (on b25 b21) (on b45 b25) (on b47 b45) (on b50 b47) (clear b50)
	(on-table b23) (on b31 b23) (on b36 b31) (on b42 b36) (clear b42)
	(on-table b32) (on b34 b32) (on b41 b34) (on b48 b41) (clear b48)
	(on-table b40) (on b49 b40) (clear b49)
))
)


