;;---------------------------------------------

(define (problem p50_25)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30 b31 b32 b33 b34 b35 b36 b37 b38 b39 b40 b41 b42 b43 b44 b45 b46 b47 b48 b49 b50)
(:init
	(arm-empty)
	(on-table b1) (on b4 b1) (on b10 b4) (on b13 b10) (on b14 b13) (on b16 b14) (on b18 b16) (on b24 b18) (on b28 b24) (on b36 b28) (on b44 b36) (clear b44)
	(on-table b2) (on b5 b2) (on b6 b5) (on b11 b6) (on b17 b11) (on b21 b17) (on b23 b21) (on b25 b23) (on b26 b25) (on b32 b26) (on b39 b32) (on b40 b39) (on b46 b40) (clear b46)
	(on-table b3) (on b7 b3) (on b9 b7) (on b12 b9) (on b20 b12) (on b22 b20) (on b30 b22) (on b33 b30) (on b42 b33) (on b48 b42) (clear b48)
	(on-table b8) (on b27 b8) (on b31 b27) (on b37 b31) (on b41 b37) (clear b41)
	(on-table b15) (on b34 b15) (clear b34)
	(on-table b19) (on b29 b19) (on b43 b29) (on b47 b43) (clear b47)
	(on-table b35) (on b45 b35) (on b50 b45) (clear b50)
	(on-table b38) (clear b38)
	(on-table b49) (clear b49)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b4 b1) (on b7 b4) (on b31 b7) (on b47 b31) (on b48 b47) (on b49 b48) (clear b49)
	(on-table b2) (on b9 b2) (on b15 b9) (on b17 b15) (clear b17)
	(on-table b3) (on b5 b3) (on b24 b5) (on b37 b24) (clear b37)
	(on-table b6) (on b22 b6) (on b29 b22) (on b30 b29) (on b35 b30) (on b41 b35) (clear b41)
	(on-table b8) (on b10 b8) (on b12 b10) (on b25 b12) (on b27 b25) (clear b27)
	(on-table b11) (on b13 b11) (on b16 b13) (on b19 b16) (on b26 b19) (on b36 b26) (on b40 b36) (clear b40)
	(on-table b14) (on b18 b14) (on b34 b18) (clear b34)
	(on-table b20) (on b21 b20) (on b23 b21) (on b32 b23) (on b39 b32) (on b43 b39) (clear b43)
	(on-table b28) (on b33 b28) (on b42 b33) (on b45 b42) (clear b45)
	(on-table b38) (on b44 b38) (clear b44)
	(on-table b46) (clear b46)
	(on-table b50) (clear b50)
))
)


