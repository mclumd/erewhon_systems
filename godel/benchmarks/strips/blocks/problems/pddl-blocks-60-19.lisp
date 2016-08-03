;;---------------------------------------------

(define (problem p60_19)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30 b31 b32 b33 b34 b35 b36 b37 b38 b39 b40 b41 b42 b43 b44 b45 b46 b47 b48 b49 b50 b51 b52 b53 b54 b55 b56 b57 b58 b59 b60)
(:init
	(arm-empty)
	(on-table b1) (on b3 b1) (on b4 b3) (on b5 b4) (on b15 b5) (on b25 b15) (on b28 b25) (on b51 b28) (on b54 b51) (clear b54)
	(on-table b2) (on b7 b2) (on b9 b7) (on b10 b9) (on b13 b10) (on b17 b13) (on b23 b17) (on b24 b23) (on b31 b24) (on b52 b31) (clear b52)
	(on-table b6) (on b12 b6) (on b14 b12) (on b16 b14) (on b20 b16) (on b22 b20) (on b26 b22) (on b27 b26) (on b49 b27) (clear b49)
	(on-table b8) (on b11 b8) (on b18 b11) (on b19 b18) (on b21 b19) (on b32 b21) (on b36 b32) (on b45 b36) (on b50 b45) (on b53 b50) (clear b53)
	(on-table b29) (on b30 b29) (on b37 b30) (on b38 b37) (on b43 b38) (on b47 b43) (clear b47)
	(on-table b33) (on b34 b33) (on b55 b34) (on b57 b55) (on b60 b57) (clear b60)
	(on-table b35) (on b41 b35) (on b46 b41) (on b56 b46) (clear b56)
	(on-table b39) (on b40 b39) (on b48 b40) (on b59 b48) (clear b59)
	(on-table b42) (on b44 b42) (on b58 b44) (clear b58)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b2 b1) (on b4 b2) (on b5 b4) (on b11 b5) (on b13 b11) (on b17 b13) (on b19 b17) (on b24 b19) (on b40 b24) (on b44 b40) (on b52 b44) (on b53 b52) (on b57 b53) (clear b57)
	(on-table b3) (on b7 b3) (on b8 b7) (on b12 b8) (on b16 b12) (on b25 b16) (on b59 b25) (clear b59)
	(on-table b6) (on b10 b6) (on b15 b10) (on b18 b15) (on b23 b18) (on b27 b23) (on b28 b27) (on b32 b28) (on b39 b32) (on b41 b39) (on b58 b41) (clear b58)
	(on-table b9) (on b14 b9) (on b20 b14) (on b21 b20) (on b22 b21) (on b26 b22) (on b30 b26) (on b35 b30) (on b38 b35) (on b46 b38) (clear b46)
	(on-table b29) (on b31 b29) (on b33 b31) (on b37 b33) (on b50 b37) (on b54 b50) (clear b54)
	(on-table b34) (on b43 b34) (on b47 b43) (on b60 b47) (clear b60)
	(on-table b36) (on b45 b36) (on b48 b45) (on b51 b48) (on b55 b51) (clear b55)
	(on-table b42) (clear b42)
	(on-table b49) (on b56 b49) (clear b56)
))
)


