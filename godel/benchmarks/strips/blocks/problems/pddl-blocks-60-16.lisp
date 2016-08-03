;;---------------------------------------------

(define (problem p60_16)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30 b31 b32 b33 b34 b35 b36 b37 b38 b39 b40 b41 b42 b43 b44 b45 b46 b47 b48 b49 b50 b51 b52 b53 b54 b55 b56 b57 b58 b59 b60)
(:init
	(arm-empty)
	(on-table b1) (on b3 b1) (on b6 b3) (on b7 b6) (on b9 b7) (on b20 b9) (on b22 b20) (on b26 b22) (on b31 b26) (on b40 b31) (on b49 b40) (on b53 b49) (on b60 b53) (clear b60)
	(on-table b2) (on b5 b2) (on b8 b5) (on b10 b8) (on b11 b10) (on b15 b11) (on b17 b15) (on b35 b17) (on b37 b35) (on b41 b37) (on b56 b41) (clear b56)
	(on-table b4) (on b16 b4) (on b28 b16) (on b29 b28) (on b34 b29) (on b39 b34) (on b51 b39) (on b57 b51) (clear b57)
	(on-table b12) (on b25 b12) (on b38 b25) (on b44 b38) (on b47 b44) (clear b47)
	(on-table b13) (on b14 b13) (on b18 b14) (on b19 b18) (clear b19)
	(on-table b21) (on b27 b21) (on b36 b27) (on b58 b36) (clear b58)
	(on-table b23) (on b24 b23) (on b32 b24) (on b33 b32) (on b54 b33) (clear b54)
	(on-table b30) (on b46 b30) (on b55 b46) (clear b55)
	(on-table b42) (on b43 b42) (clear b43)
	(on-table b45) (on b48 b45) (on b50 b48) (on b52 b50) (on b59 b52) (clear b59)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b2 b1) (on b4 b2) (on b5 b4) (on b7 b5) (on b18 b7) (on b21 b18) (on b25 b21) (on b34 b25) (on b36 b34) (on b49 b36) (on b53 b49) (on b55 b53) (clear b55)
	(on-table b3) (on b8 b3) (on b12 b8) (on b23 b12) (on b26 b23) (on b28 b26) (on b29 b28) (on b31 b29) (on b43 b31) (on b45 b43) (on b54 b45) (on b57 b54) (clear b57)
	(on-table b6) (on b9 b6) (on b10 b9) (on b11 b10) (on b13 b11) (on b40 b13) (on b46 b40) (on b47 b46) (clear b47)
	(on-table b14) (on b15 b14) (on b16 b15) (on b17 b16) (on b19 b17) (on b20 b19) (on b22 b20) (on b27 b22) (on b37 b27) (on b52 b37) (on b56 b52) (clear b56)
	(on-table b24) (clear b24)
	(on-table b30) (on b35 b30) (on b41 b35) (on b42 b41) (on b44 b42) (on b59 b44) (clear b59)
	(on-table b32) (on b33 b32) (on b38 b33) (on b39 b38) (on b48 b39) (on b50 b48) (clear b50)
	(on-table b51) (on b58 b51) (on b60 b58) (clear b60)
))
)


