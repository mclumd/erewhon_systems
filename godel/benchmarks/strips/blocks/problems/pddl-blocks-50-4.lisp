;;---------------------------------------------

(define (problem p50_4)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30 b31 b32 b33 b34 b35 b36 b37 b38 b39 b40 b41 b42 b43 b44 b45 b46 b47 b48 b49 b50)
(:init
	(arm-empty)
	(on-table b1) (on b5 b1) (on b8 b5) (on b37 b8) (on b38 b37) (on b50 b38) (clear b50)
	(on-table b2) (on b3 b2) (on b6 b3) (on b9 b6) (on b13 b9) (on b15 b13) (on b16 b15) (on b17 b16) (on b20 b17) (on b28 b20) (on b34 b28) (on b41 b34) (clear b41)
	(on-table b4) (on b7 b4) (on b14 b7) (on b23 b14) (on b26 b23) (on b35 b26) (on b44 b35) (clear b44)
	(on-table b10) (on b11 b10) (on b12 b11) (on b22 b12) (on b24 b22) (on b27 b24) (on b40 b27) (on b49 b40) (clear b49)
	(on-table b18) (on b19 b18) (on b42 b19) (on b43 b42) (on b46 b43) (clear b46)
	(on-table b21) (on b25 b21) (on b31 b25) (on b39 b31) (clear b39)
	(on-table b29) (on b32 b29) (on b47 b32) (clear b47)
	(on-table b30) (on b33 b30) (on b36 b33) (clear b36)
	(on-table b45) (clear b45)
	(on-table b48) (clear b48)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b2 b1) (on b4 b2) (on b9 b4) (on b14 b9) (on b18 b14) (on b24 b18) (on b25 b24) (on b29 b25) (on b43 b29) (on b44 b43) (clear b44)
	(on-table b3) (on b5 b3) (on b7 b5) (on b12 b7) (on b13 b12) (on b15 b13) (on b16 b15) (on b20 b16) (on b23 b20) (on b39 b23) (on b46 b39) (on b49 b46) (clear b49)
	(on-table b6) (on b19 b6) (on b26 b19) (on b28 b26) (on b33 b28) (on b45 b33) (on b48 b45) (clear b48)
	(on-table b8) (on b11 b8) (on b17 b11) (on b31 b17) (on b32 b31) (on b37 b32) (on b38 b37) (on b41 b38) (on b50 b41) (clear b50)
	(on-table b10) (on b21 b10) (on b27 b21) (on b35 b27) (clear b35)
	(on-table b22) (on b36 b22) (clear b36)
	(on-table b30) (clear b30)
	(on-table b34) (on b40 b34) (on b42 b40) (clear b42)
	(on-table b47) (clear b47)
))
)


