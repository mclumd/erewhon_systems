;;---------------------------------------------

(define (problem p50_9)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30 b31 b32 b33 b34 b35 b36 b37 b38 b39 b40 b41 b42 b43 b44 b45 b46 b47 b48 b49 b50)
(:init
	(arm-empty)
	(on-table b1) (on b3 b1) (on b5 b3) (on b15 b5) (on b25 b15) (on b46 b25) (clear b46)
	(on-table b2) (on b12 b2) (on b13 b12) (on b38 b13) (clear b38)
	(on-table b4) (on b8 b4) (on b11 b8) (on b22 b11) (on b35 b22) (on b40 b35) (on b43 b40) (clear b43)
	(on-table b6) (on b7 b6) (on b14 b7) (on b17 b14) (on b23 b17) (on b31 b23) (on b36 b31) (clear b36)
	(on-table b9) (on b10 b9) (on b21 b10) (on b33 b21) (on b45 b33) (on b49 b45) (clear b49)
	(on-table b16) (on b27 b16) (on b50 b27) (clear b50)
	(on-table b18) (on b19 b18) (on b30 b19) (on b39 b30) (on b41 b39) (on b44 b41) (clear b44)
	(on-table b20) (on b26 b20) (on b34 b26) (on b47 b34) (clear b47)
	(on-table b24) (on b32 b24) (on b42 b32) (clear b42)
	(on-table b28) (on b29 b28) (on b37 b29) (on b48 b37) (clear b48)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b5 b1) (on b6 b5) (on b13 b6) (on b18 b13) (on b19 b18) (on b39 b19) (clear b39)
	(on-table b2) (on b3 b2) (on b4 b3) (on b7 b4) (on b8 b7) (on b9 b8) (on b10 b9) (on b11 b10) (on b21 b11) (on b22 b21) (on b26 b22) (on b30 b26) (on b41 b30) (clear b41)
	(on-table b12) (on b33 b12) (on b35 b33) (clear b35)
	(on-table b14) (on b25 b14) (on b29 b25) (on b31 b29) (on b37 b31) (on b43 b37) (on b46 b43) (clear b46)
	(on-table b15) (on b24 b15) (on b27 b24) (on b28 b27) (on b36 b28) (on b38 b36) (clear b38)
	(on-table b16) (on b17 b16) (on b23 b17) (on b42 b23) (on b45 b42) (on b47 b45) (clear b47)
	(on-table b20) (on b32 b20) (on b34 b32) (on b40 b34) (on b44 b40) (clear b44)
	(on-table b48) (clear b48)
	(on-table b49) (on b50 b49) (clear b50)
))
)


