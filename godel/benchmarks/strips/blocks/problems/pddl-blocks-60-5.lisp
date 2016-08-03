;;---------------------------------------------

(define (problem p60_5)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30 b31 b32 b33 b34 b35 b36 b37 b38 b39 b40 b41 b42 b43 b44 b45 b46 b47 b48 b49 b50 b51 b52 b53 b54 b55 b56 b57 b58 b59 b60)
(:init
	(arm-empty)
	(on-table b1) (on b9 b1) (on b11 b9) (on b12 b11) (on b19 b12) (on b23 b19) (on b24 b23) (on b49 b24) (on b60 b49) (clear b60)
	(on-table b2) (on b13 b2) (on b21 b13) (on b27 b21) (on b30 b27) (on b34 b30) (on b38 b34) (on b58 b38) (clear b58)
	(on-table b3) (on b4 b3) (on b6 b4) (on b8 b6) (on b20 b8) (on b22 b20) (on b25 b22) (on b35 b25) (on b37 b35) (on b45 b37) (on b56 b45) (clear b56)
	(on-table b5) (on b15 b5) (on b16 b15) (on b17 b16) (on b31 b17) (on b32 b31) (on b48 b32) (on b51 b48) (clear b51)
	(on-table b7) (on b10 b7) (on b14 b10) (on b18 b14) (on b28 b18) (on b42 b28) (clear b42)
	(on-table b26) (on b33 b26) (on b46 b33) (on b52 b46) (clear b52)
	(on-table b29) (on b36 b29) (on b44 b36) (on b47 b44) (clear b47)
	(on-table b39) (on b40 b39) (on b41 b40) (on b43 b41) (clear b43)
	(on-table b50) (on b53 b50) (on b54 b53) (on b55 b54) (on b59 b55) (clear b59)
	(on-table b57) (clear b57)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b2 b1) (on b5 b2) (on b6 b5) (on b10 b6) (on b12 b10) (on b13 b12) (on b14 b13) (on b16 b14) (on b17 b16) (on b18 b17) (on b19 b18) (on b21 b19) (on b22 b21) (on b23 b22) (on b25 b23) (on b28 b25) (on b29 b28) (on b34 b29) (clear b34)
	(on-table b3) (on b4 b3) (on b7 b4) (on b8 b7) (on b9 b8) (on b11 b9) (on b26 b11) (on b37 b26) (on b42 b37) (on b53 b42) (on b60 b53) (clear b60)
	(on-table b15) (on b20 b15) (on b24 b20) (on b32 b24) (on b45 b32) (on b50 b45) (on b56 b50) (clear b56)
	(on-table b27) (on b30 b27) (on b31 b30) (on b33 b31) (on b36 b33) (on b38 b36) (on b40 b38) (on b44 b40) (on b46 b44) (clear b46)
	(on-table b35) (on b39 b35) (on b41 b39) (on b51 b41) (clear b51)
	(on-table b43) (on b48 b43) (on b57 b48) (on b59 b57) (clear b59)
	(on-table b47) (clear b47)
	(on-table b49) (on b55 b49) (on b58 b55) (clear b58)
	(on-table b52) (on b54 b52) (clear b54)
))
)


