;;---------------------------------------------

(define (problem p50_2)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30 b31 b32 b33 b34 b35 b36 b37 b38 b39 b40 b41 b42 b43 b44 b45 b46 b47 b48 b49 b50)
(:init
	(arm-empty)
	(on-table b1) (on b3 b1) (on b5 b3) (on b13 b5) (on b14 b13) (on b16 b14) (on b17 b16) (on b20 b17) (on b21 b20) (on b24 b21) (on b30 b24) (clear b30)
	(on-table b2) (on b4 b2) (on b7 b4) (on b18 b7) (on b25 b18) (on b36 b25) (on b39 b36) (on b40 b39) (on b46 b40) (clear b46)
	(on-table b6) (on b15 b6) (on b22 b15) (on b26 b22) (on b37 b26) (on b42 b37) (clear b42)
	(on-table b8) (on b10 b8) (on b11 b10) (on b12 b11) (on b27 b12) (on b32 b27) (on b34 b32) (on b43 b34) (on b45 b43) (on b49 b45) (clear b49)
	(on-table b9) (on b19 b9) (on b23 b19) (on b28 b23) (on b29 b28) (on b33 b29) (on b41 b33) (clear b41)
	(on-table b31) (on b35 b31) (on b44 b35) (clear b44)
	(on-table b38) (on b47 b38) (on b48 b47) (clear b48)
	(on-table b50) (clear b50)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b3 b1) (on b6 b3) (on b10 b6) (on b13 b10) (on b22 b13) (on b26 b22) (on b27 b26) (on b29 b27) (on b36 b29) (on b37 b36) (on b43 b37) (clear b43)
	(on-table b2) (on b8 b2) (on b11 b8) (on b16 b11) (on b20 b16) (on b33 b20) (on b42 b33) (clear b42)
	(on-table b4) (on b5 b4) (on b17 b5) (on b21 b17) (on b35 b21) (on b45 b35) (on b49 b45) (clear b49)
	(on-table b7) (on b12 b7) (on b19 b12) (clear b19)
	(on-table b9) (on b15 b9) (on b23 b15) (on b41 b23) (on b50 b41) (clear b50)
	(on-table b14) (on b28 b14) (on b30 b28) (on b31 b30) (on b48 b31) (clear b48)
	(on-table b18) (on b24 b18) (on b25 b24) (on b46 b25) (clear b46)
	(on-table b32) (on b34 b32) (on b38 b34) (on b39 b38) (on b40 b39) (clear b40)
	(on-table b44) (clear b44)
	(on-table b47) (clear b47)
))
)


