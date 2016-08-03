;;---------------------------------------------

(define (problem p50_5)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30 b31 b32 b33 b34 b35 b36 b37 b38 b39 b40 b41 b42 b43 b44 b45 b46 b47 b48 b49 b50)
(:init
	(arm-empty)
	(on-table b1) (on b2 b1) (on b5 b2) (on b6 b5) (on b9 b6) (on b14 b9) (on b16 b14) (on b23 b16) (on b25 b23) (on b34 b25) (on b39 b34) (on b48 b39) (on b50 b48) (clear b50)
	(on-table b3) (on b7 b3) (on b11 b7) (on b12 b11) (on b17 b12) (on b19 b17) (on b28 b19) (on b41 b28) (on b42 b41) (on b49 b42) (clear b49)
	(on-table b4) (on b8 b4) (on b15 b8) (on b29 b15) (on b30 b29) (on b31 b30) (on b36 b31) (on b38 b36) (clear b38)
	(on-table b10) (on b13 b10) (on b21 b13) (on b22 b21) (on b32 b22) (on b43 b32) (clear b43)
	(on-table b18) (on b20 b18) (on b27 b20) (clear b27)
	(on-table b24) (on b26 b24) (on b33 b26) (on b35 b33) (on b37 b35) (on b40 b37) (on b44 b40) (on b45 b44) (on b46 b45) (on b47 b46) (clear b47)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b7 b1) (on b8 b7) (on b35 b8) (on b37 b35) (on b41 b37) (on b44 b41) (on b46 b44) (on b47 b46) (clear b47)
	(on-table b2) (on b3 b2) (on b4 b3) (on b5 b4) (on b6 b5) (on b9 b6) (on b18 b9) (on b20 b18) (on b24 b20) (on b26 b24) (on b32 b26) (on b33 b32) (on b43 b33) (clear b43)
	(on-table b10) (on b12 b10) (on b13 b12) (on b15 b13) (on b17 b15) (on b29 b17) (on b31 b29) (clear b31)
	(on-table b11) (on b14 b11) (on b21 b14) (on b25 b21) (on b28 b25) (on b49 b28) (clear b49)
	(on-table b16) (on b22 b16) (on b23 b22) (on b34 b23) (on b36 b34) (on b40 b36) (on b48 b40) (clear b48)
	(on-table b19) (on b27 b19) (on b30 b27) (clear b30)
	(on-table b38) (on b39 b38) (on b42 b39) (clear b42)
	(on-table b45) (clear b45)
	(on-table b50) (clear b50)
))
)


