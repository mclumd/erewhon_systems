;;---------------------------------------------

(define (problem p60_24)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30 b31 b32 b33 b34 b35 b36 b37 b38 b39 b40 b41 b42 b43 b44 b45 b46 b47 b48 b49 b50 b51 b52 b53 b54 b55 b56 b57 b58 b59 b60)
(:init
	(arm-empty)
	(on-table b1) (on b12 b1) (on b15 b12) (on b16 b15) (on b18 b16) (on b21 b18) (on b23 b21) (on b32 b23) (on b36 b32) (on b44 b36) (on b49 b44) (clear b49)
	(on-table b2) (on b5 b2) (on b6 b5) (on b7 b6) (on b25 b7) (on b26 b25) (on b27 b26) (on b38 b27) (on b40 b38) (on b42 b40) (on b43 b42) (on b51 b43) (on b56 b51) (on b58 b56) (clear b58)
	(on-table b3) (on b4 b3) (on b11 b4) (on b14 b11) (on b19 b14) (on b22 b19) (on b28 b22) (on b33 b28) (on b35 b33) (on b47 b35) (on b50 b47) (on b54 b50) (clear b54)
	(on-table b8) (on b9 b8) (on b10 b9) (on b13 b10) (on b17 b13) (on b20 b17) (on b24 b20) (on b31 b24) (on b52 b31) (on b53 b52) (clear b53)
	(on-table b29) (on b30 b29) (on b37 b30) (on b39 b37) (on b45 b39) (on b48 b45) (on b60 b48) (clear b60)
	(on-table b34) (on b41 b34) (on b55 b41) (clear b55)
	(on-table b46) (on b59 b46) (clear b59)
	(on-table b57) (clear b57)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b21 b1) (on b25 b21) (on b50 b25) (clear b50)
	(on-table b2) (on b5 b2) (on b8 b5) (on b16 b8) (on b20 b16) (on b32 b20) (on b34 b32) (on b49 b34) (on b53 b49) (on b55 b53) (clear b55)
	(on-table b3) (on b4 b3) (on b7 b4) (on b17 b7) (on b47 b17) (on b54 b47) (clear b54)
	(on-table b6) (on b11 b6) (on b12 b11) (on b19 b12) (on b31 b19) (on b40 b31) (on b43 b40) (on b44 b43) (on b56 b44) (clear b56)
	(on-table b9) (on b13 b9) (on b14 b13) (on b26 b14) (on b33 b26) (on b35 b33) (on b39 b35) (on b42 b39) (on b51 b42) (clear b51)
	(on-table b10) (on b15 b10) (on b22 b15) (on b23 b22) (on b24 b23) (on b41 b24) (on b59 b41) (clear b59)
	(on-table b18) (on b29 b18) (on b37 b29) (on b45 b37) (on b46 b45) (clear b46)
	(on-table b27) (on b28 b27) (on b30 b28) (on b57 b30) (clear b57)
	(on-table b36) (on b38 b36) (clear b38)
	(on-table b48) (on b58 b48) (clear b58)
	(on-table b52) (on b60 b52) (clear b60)
))
)


