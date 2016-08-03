;;---------------------------------------------

(define (problem p50_11)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30 b31 b32 b33 b34 b35 b36 b37 b38 b39 b40 b41 b42 b43 b44 b45 b46 b47 b48 b49 b50)
(:init
	(arm-empty)
	(on-table b1) (on b2 b1) (on b4 b2) (on b6 b4) (on b7 b6) (on b27 b7) (on b28 b27) (on b29 b28) (on b38 b29) (on b42 b38) (on b43 b42) (on b44 b43) (on b45 b44) (on b48 b45) (clear b48)
	(on-table b3) (on b5 b3) (on b22 b5) (on b23 b22) (on b31 b23) (on b50 b31) (clear b50)
	(on-table b8) (on b9 b8) (on b10 b9) (on b13 b10) (on b14 b13) (on b19 b14) (on b20 b19) (on b36 b20) (on b40 b36) (clear b40)
	(on-table b11) (on b12 b11) (on b16 b12) (on b17 b16) (on b18 b17) (on b26 b18) (on b34 b26) (on b35 b34) (clear b35)
	(on-table b15) (on b21 b15) (on b24 b21) (on b25 b24) (on b37 b25) (on b39 b37) (on b47 b39) (on b49 b47) (clear b49)
	(on-table b30) (on b32 b30) (on b33 b32) (on b41 b33) (on b46 b41) (clear b46)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b2 b1) (on b3 b2) (on b12 b3) (on b13 b12) (on b26 b13) (on b36 b26) (on b45 b36) (clear b45)
	(on-table b4) (on b8 b4) (on b14 b8) (on b20 b14) (on b27 b20) (on b29 b27) (on b35 b29) (on b38 b35) (on b39 b38) (on b49 b39) (clear b49)
	(on-table b5) (on b15 b5) (on b16 b15) (on b17 b16) (on b22 b17) (on b24 b22) (on b33 b24) (on b48 b33) (on b50 b48) (clear b50)
	(on-table b6) (on b7 b6) (on b10 b7) (on b18 b10) (on b19 b18) (on b21 b19) (on b28 b21) (on b31 b28) (clear b31)
	(on-table b9) (on b11 b9) (on b25 b11) (on b30 b25) (clear b30)
	(on-table b23) (on b34 b23) (on b37 b34) (on b47 b37) (clear b47)
	(on-table b32) (clear b32)
	(on-table b40) (on b46 b40) (clear b46)
	(on-table b41) (on b43 b41) (on b44 b43) (clear b44)
	(on-table b42) (clear b42)
))
)


