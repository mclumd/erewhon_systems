;;---------------------------------------------

(define (problem p60_12)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30 b31 b32 b33 b34 b35 b36 b37 b38 b39 b40 b41 b42 b43 b44 b45 b46 b47 b48 b49 b50 b51 b52 b53 b54 b55 b56 b57 b58 b59 b60)
(:init
	(arm-empty)
	(on-table b1) (on b9 b1) (on b22 b9) (on b32 b22) (on b39 b32) (on b44 b39) (on b53 b44) (on b59 b53) (clear b59)
	(on-table b2) (on b3 b2) (on b5 b3) (on b10 b5) (on b14 b10) (on b30 b14) (on b37 b30) (on b42 b37) (on b45 b42) (on b47 b45) (on b60 b47) (clear b60)
	(on-table b4) (on b8 b4) (on b11 b8) (on b15 b11) (on b23 b15) (clear b23)
	(on-table b6) (on b7 b6) (on b12 b7) (on b17 b12) (on b18 b17) (on b19 b18) (on b20 b19) (on b28 b20) (on b41 b28) (on b46 b41) (clear b46)
	(on-table b13) (on b16 b13) (on b29 b16) (on b35 b29) (on b43 b35) (on b56 b43) (clear b56)
	(on-table b21) (on b24 b21) (on b31 b24) (on b33 b31) (on b36 b33) (on b40 b36) (on b51 b40) (on b57 b51) (clear b57)
	(on-table b25) (on b26 b25) (clear b26)
	(on-table b27) (on b48 b27) (on b52 b48) (clear b52)
	(on-table b34) (on b38 b34) (clear b38)
	(on-table b49) (on b50 b49) (on b54 b50) (clear b54)
	(on-table b55) (on b58 b55) (clear b58)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b3 b1) (on b7 b3) (on b11 b7) (on b13 b11) (on b21 b13) (on b26 b21) (on b30 b26) (on b33 b30) (on b39 b33) (on b42 b39) (on b50 b42) (on b57 b50) (clear b57)
	(on-table b2) (on b14 b2) (on b22 b14) (on b31 b22) (on b41 b31) (on b60 b41) (clear b60)
	(on-table b4) (on b10 b4) (on b16 b10) (on b20 b16) (on b27 b20) (on b32 b27) (on b34 b32) (clear b34)
	(on-table b5) (on b6 b5) (on b9 b6) (on b12 b9) (on b19 b12) (on b29 b19) (on b44 b29) (on b48 b44) (clear b48)
	(on-table b8) (on b23 b8) (on b25 b23) (on b35 b25) (on b36 b35) (on b43 b36) (on b46 b43) (on b55 b46) (clear b55)
	(on-table b15) (on b17 b15) (on b24 b17) (on b38 b24) (on b54 b38) (clear b54)
	(on-table b18) (on b28 b18) (on b47 b28) (on b56 b47) (clear b56)
	(on-table b37) (on b49 b37) (on b53 b49) (clear b53)
	(on-table b40) (on b45 b40) (on b51 b45) (on b52 b51) (on b58 b52) (on b59 b58) (clear b59)
))
)


