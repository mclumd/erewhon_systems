;;---------------------------------------------

(define (problem p50_10)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30 b31 b32 b33 b34 b35 b36 b37 b38 b39 b40 b41 b42 b43 b44 b45 b46 b47 b48 b49 b50)
(:init
	(arm-empty)
	(on-table b1) (on b2 b1) (on b3 b2) (on b6 b3) (on b7 b6) (on b9 b7) (on b11 b9) (on b12 b11) (on b14 b12) (on b15 b14) (on b18 b15) (on b19 b18) (on b27 b19) (on b32 b27) (on b33 b32) (on b36 b33) (clear b36)
	(on-table b4) (on b5 b4) (on b16 b5) (on b17 b16) (on b22 b17) (on b25 b22) (on b40 b25) (clear b40)
	(on-table b8) (on b13 b8) (on b20 b13) (on b21 b20) (on b28 b21) (on b38 b28) (on b39 b38) (clear b39)
	(on-table b10) (on b30 b10) (on b35 b30) (on b44 b35) (on b48 b44) (clear b48)
	(on-table b23) (on b49 b23) (clear b49)
	(on-table b24) (on b42 b24) (on b45 b42) (clear b45)
	(on-table b26) (on b29 b26) (on b34 b29) (clear b34)
	(on-table b31) (clear b31)
	(on-table b37) (on b43 b37) (clear b43)
	(on-table b41) (clear b41)
	(on-table b46) (clear b46)
	(on-table b47) (clear b47)
	(on-table b50) (clear b50)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b12 b1) (on b13 b12) (on b17 b13) (on b23 b17) (on b29 b23) (on b40 b29) (on b42 b40) (clear b42)
	(on-table b2) (on b5 b2) (on b9 b5) (on b11 b9) (on b18 b11) (on b19 b18) (on b26 b19) (on b30 b26) (on b34 b30) (on b36 b34) (on b46 b36) (on b47 b46) (on b49 b47) (clear b49)
	(on-table b3) (on b7 b3) (on b48 b7) (clear b48)
	(on-table b4) (on b6 b4) (on b8 b6) (on b10 b8) (on b15 b10) (on b16 b15) (on b21 b16) (on b37 b21) (on b45 b37) (on b50 b45) (clear b50)
	(on-table b14) (on b22 b14) (on b24 b22) (on b25 b24) (on b33 b25) (on b44 b33) (clear b44)
	(on-table b20) (on b27 b20) (on b28 b27) (on b32 b28) (on b41 b32) (on b43 b41) (clear b43)
	(on-table b31) (on b35 b31) (on b38 b35) (on b39 b38) (clear b39)
))
)


