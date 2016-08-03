;;---------------------------------------------

(define (problem p50_14)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30 b31 b32 b33 b34 b35 b36 b37 b38 b39 b40 b41 b42 b43 b44 b45 b46 b47 b48 b49 b50)
(:init
	(arm-empty)
	(on-table b1) (on b2 b1) (on b3 b2) (on b8 b3) (on b11 b8) (on b14 b11) (on b17 b14) (on b19 b17) (on b28 b19) (on b29 b28) (on b36 b29) (on b42 b36) (on b48 b42) (clear b48)
	(on-table b4) (on b6 b4) (on b7 b6) (on b10 b7) (on b15 b10) (on b20 b15) (on b23 b20) (on b39 b23) (on b44 b39) (clear b44)
	(on-table b5) (on b9 b5) (on b16 b9) (clear b16)
	(on-table b12) (on b13 b12) (on b21 b13) (on b22 b21) (on b50 b22) (clear b50)
	(on-table b18) (on b33 b18) (on b35 b33) (on b43 b35) (on b46 b43) (clear b46)
	(on-table b24) (on b25 b24) (on b27 b25) (on b30 b27) (on b38 b30) (clear b38)
	(on-table b26) (on b49 b26) (clear b49)
	(on-table b31) (on b37 b31) (on b45 b37) (clear b45)
	(on-table b32) (clear b32)
	(on-table b34) (on b47 b34) (clear b47)
	(on-table b40) (clear b40)
	(on-table b41) (clear b41)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b2 b1) (on b3 b2) (on b9 b3) (on b10 b9) (on b14 b10) (on b16 b14) (on b23 b16) (on b29 b23) (on b40 b29) (clear b40)
	(on-table b4) (on b5 b4) (on b12 b5) (on b30 b12) (on b31 b30) (on b42 b31) (on b49 b42) (clear b49)
	(on-table b6) (on b17 b6) (on b18 b17) (on b41 b18) (on b46 b41) (clear b46)
	(on-table b7) (on b8 b7) (on b11 b8) (on b34 b11) (clear b34)
	(on-table b13) (on b26 b13) (clear b26)
	(on-table b15) (on b27 b15) (on b39 b27) (on b45 b39) (on b47 b45) (clear b47)
	(on-table b19) (on b36 b19) (on b38 b36) (on b43 b38) (clear b43)
	(on-table b20) (clear b20)
	(on-table b21) (clear b21)
	(on-table b22) (on b24 b22) (on b33 b24) (on b37 b33) (on b50 b37) (clear b50)
	(on-table b25) (on b28 b25) (clear b28)
	(on-table b32) (on b44 b32) (clear b44)
	(on-table b35) (clear b35)
	(on-table b48) (clear b48)
))
)


