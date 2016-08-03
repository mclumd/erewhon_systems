;;---------------------------------------------

(define (problem p50_19)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30 b31 b32 b33 b34 b35 b36 b37 b38 b39 b40 b41 b42 b43 b44 b45 b46 b47 b48 b49 b50)
(:init
	(arm-empty)
	(on-table b1) (on b3 b1) (on b6 b3) (on b7 b6) (on b9 b7) (on b20 b9) (on b22 b20) (on b26 b22) (on b31 b26) (on b40 b31) (on b49 b40) (clear b49)
	(on-table b2) (on b5 b2) (on b8 b5) (on b10 b8) (on b11 b10) (on b15 b11) (on b17 b15) (on b35 b17) (on b37 b35) (on b41 b37) (clear b41)
	(on-table b4) (on b16 b4) (on b28 b16) (on b29 b28) (on b34 b29) (on b39 b34) (clear b39)
	(on-table b12) (on b25 b12) (on b38 b25) (on b44 b38) (on b47 b44) (clear b47)
	(on-table b13) (on b14 b13) (on b18 b14) (on b19 b18) (clear b19)
	(on-table b21) (on b27 b21) (on b36 b27) (clear b36)
	(on-table b23) (on b24 b23) (on b32 b24) (on b33 b32) (clear b33)
	(on-table b30) (on b46 b30) (clear b46)
	(on-table b42) (on b43 b42) (clear b43)
	(on-table b45) (on b48 b45) (on b50 b48) (clear b50)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b5 b1) (on b7 b5) (on b15 b7) (on b23 b15) (on b28 b23) (on b35 b28) (clear b35)
	(on-table b2) (on b3 b2) (on b17 b3) (on b22 b17) (on b32 b22) (on b38 b32) (on b42 b38) (on b47 b42) (clear b47)
	(on-table b4) (on b6 b4) (on b9 b6) (on b10 b9) (on b12 b10) (on b20 b12) (on b25 b20) (on b31 b25) (on b46 b31) (clear b46)
	(on-table b8) (on b11 b8) (on b13 b11) (on b14 b13) (on b16 b14) (on b18 b16) (on b36 b18) (clear b36)
	(on-table b19) (on b21 b19) (on b26 b21) (on b29 b26) (clear b29)
	(on-table b24) (on b27 b24) (on b34 b27) (on b37 b34) (on b40 b37) (on b41 b40) (clear b41)
	(on-table b30) (on b33 b30) (on b43 b33) (on b44 b43) (on b49 b44) (on b50 b49) (clear b50)
	(on-table b39) (clear b39)
	(on-table b45) (on b48 b45) (clear b48)
))
)


