;;---------------------------------------------

(define (problem p50_18)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30 b31 b32 b33 b34 b35 b36 b37 b38 b39 b40 b41 b42 b43 b44 b45 b46 b47 b48 b49 b50)
(:init
	(arm-empty)
	(on-table b1) (on b3 b1) (on b4 b3) (on b19 b4) (on b26 b19) (on b28 b26) (on b33 b28) (on b34 b33) (on b37 b34) (on b42 b37) (on b44 b42) (clear b44)
	(on-table b2) (on b6 b2) (on b8 b6) (on b9 b8) (on b14 b9) (on b15 b14) (on b16 b15) (on b18 b16) (on b25 b18) (on b27 b25) (on b35 b27) (on b36 b35) (on b49 b36) (clear b49)
	(on-table b5) (on b7 b5) (on b10 b7) (on b12 b10) (on b23 b12) (on b29 b23) (on b41 b29) (on b45 b41) (on b47 b45) (on b50 b47) (clear b50)
	(on-table b11) (on b17 b11) (on b20 b17) (on b22 b20) (on b31 b22) (on b32 b31) (clear b32)
	(on-table b13) (on b21 b13) (on b24 b21) (on b30 b24) (on b38 b30) (on b40 b38) (on b43 b40) (on b46 b43) (clear b46)
	(on-table b39) (on b48 b39) (clear b48)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b2 b1) (on b3 b2) (on b7 b3) (on b32 b7) (on b50 b32) (clear b50)
	(on-table b4) (on b13 b4) (on b16 b13) (on b21 b16) (on b25 b21) (on b41 b25) (on b47 b41) (on b48 b47) (clear b48)
	(on-table b5) (on b6 b5) (on b26 b6) (on b33 b26) (on b39 b33) (on b46 b39) (clear b46)
	(on-table b8) (on b10 b8) (on b12 b10) (on b14 b12) (on b18 b14) (on b19 b18) (on b27 b19) (on b28 b27) (on b30 b28) (clear b30)
	(on-table b9) (on b11 b9) (on b15 b11) (on b22 b15) (on b29 b22) (on b40 b29) (clear b40)
	(on-table b17) (on b24 b17) (on b38 b24) (on b44 b38) (clear b44)
	(on-table b20) (on b23 b20) (on b31 b23) (on b35 b31) (clear b35)
	(on-table b34) (on b36 b34) (on b45 b36) (clear b45)
	(on-table b37) (clear b37)
	(on-table b42) (on b49 b42) (clear b49)
	(on-table b43) (clear b43)
))
)


