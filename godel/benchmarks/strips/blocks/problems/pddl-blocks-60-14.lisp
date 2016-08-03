;;---------------------------------------------

(define (problem p60_14)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30 b31 b32 b33 b34 b35 b36 b37 b38 b39 b40 b41 b42 b43 b44 b45 b46 b47 b48 b49 b50 b51 b52 b53 b54 b55 b56 b57 b58 b59 b60)
(:init
	(arm-empty)
	(on-table b1) (on b2 b1) (on b3 b2) (on b4 b3) (on b5 b4) (on b6 b5) (on b7 b6) (on b8 b7) (on b9 b8) (on b10 b9) (on b11 b10) (on b12 b11) (on b16 b12) (on b19 b16) (on b21 b19) (on b22 b21) (on b24 b22) (on b37 b24) (on b39 b37) (on b47 b39) (clear b47)
	(on-table b13) (on b14 b13) (on b17 b14) (on b23 b17) (on b26 b23) (on b49 b26) (on b54 b49) (on b58 b54) (clear b58)
	(on-table b15) (on b18 b15) (on b20 b18) (on b31 b20) (on b34 b31) (on b35 b34) (on b36 b35) (on b45 b36) (on b51 b45) (on b52 b51) (on b56 b52) (clear b56)
	(on-table b25) (on b27 b25) (on b29 b27) (on b38 b29) (on b40 b38) (on b46 b40) (clear b46)
	(on-table b28) (on b30 b28) (on b41 b30) (on b42 b41) (on b43 b42) (on b50 b43) (on b57 b50) (clear b57)
	(on-table b32) (on b33 b32) (on b44 b33) (on b53 b44) (clear b53)
	(on-table b48) (on b60 b48) (clear b60)
	(on-table b55) (on b59 b55) (clear b59)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b7 b1) (on b10 b7) (on b21 b10) (on b23 b21) (on b26 b23) (on b35 b26) (on b45 b35) (clear b45)
	(on-table b2) (on b3 b2) (on b16 b3) (on b18 b16) (on b19 b18) (on b25 b19) (on b27 b25) (on b30 b27) (on b31 b30) (on b32 b31) (on b33 b32) (on b36 b33) (on b48 b36) (on b50 b48) (on b59 b50) (clear b59)
	(on-table b4) (on b8 b4) (on b12 b8) (on b14 b12) (on b20 b14) (on b24 b20) (on b41 b24) (on b43 b41) (on b46 b43) (on b57 b46) (on b60 b57) (clear b60)
	(on-table b5) (on b6 b5) (on b9 b6) (on b11 b9) (on b13 b11) (on b15 b13) (on b17 b15) (on b22 b17) (on b28 b22) (on b52 b28) (on b58 b52) (clear b58)
	(on-table b29) (on b38 b29) (on b42 b38) (on b51 b42) (clear b51)
	(on-table b34) (on b37 b34) (on b44 b37) (on b54 b44) (clear b54)
	(on-table b39) (on b40 b39) (on b49 b40) (on b55 b49) (on b56 b55) (clear b56)
	(on-table b47) (on b53 b47) (clear b53)
))
)


