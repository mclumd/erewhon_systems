;;---------------------------------------------

(define (problem p50_3)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30 b31 b32 b33 b34 b35 b36 b37 b38 b39 b40 b41 b42 b43 b44 b45 b46 b47 b48 b49 b50)
(:init
	(arm-empty)
	(on-table b1) (on b2 b1) (on b3 b2) (on b4 b3) (on b5 b4) (on b27 b5) (on b28 b27) (on b40 b28) (on b41 b40) (on b43 b41) (on b47 b43) (clear b47)
	(on-table b6) (on b8 b6) (on b9 b8) (on b14 b9) (on b33 b14) (on b48 b33) (clear b48)
	(on-table b7) (on b10 b7) (on b15 b10) (on b18 b15) (on b23 b18) (on b30 b23) (on b46 b30) (on b50 b46) (clear b50)
	(on-table b11) (on b24 b11) (on b42 b24) (clear b42)
	(on-table b12) (on b13 b12) (on b19 b13) (on b45 b19) (clear b45)
	(on-table b16) (on b17 b16) (on b21 b17) (on b25 b21) (on b29 b25) (on b38 b29) (on b49 b38) (clear b49)
	(on-table b20) (on b26 b20) (on b31 b26) (on b32 b31) (on b34 b32) (on b44 b34) (clear b44)
	(on-table b22) (on b35 b22) (on b36 b35) (on b37 b36) (clear b37)
	(on-table b39) (clear b39)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b4 b1) (on b5 b4) (on b6 b5) (on b20 b6) (on b25 b20) (on b30 b25) (on b42 b30) (clear b42)
	(on-table b2) (on b19 b2) (on b37 b19) (on b44 b37) (clear b44)
	(on-table b3) (on b7 b3) (on b9 b7) (on b11 b9) (on b16 b11) (on b29 b16) (on b41 b29) (clear b41)
	(on-table b8) (on b12 b8) (on b17 b12) (on b22 b17) (on b27 b22) (on b32 b27) (clear b32)
	(on-table b10) (on b13 b10) (on b14 b13) (on b21 b14) (on b24 b21) (on b38 b24) (clear b38)
	(on-table b15) (on b26 b15) (on b31 b26) (on b34 b31) (on b48 b34) (clear b48)
	(on-table b18) (on b23 b18) (on b33 b23) (on b35 b33) (on b36 b35) (on b39 b36) (on b40 b39) (on b45 b40) (clear b45)
	(on-table b28) (on b46 b28) (clear b46)
	(on-table b43) (on b50 b43) (clear b50)
	(on-table b47) (clear b47)
	(on-table b49) (clear b49)
))
)


