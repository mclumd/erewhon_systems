;;---------------------------------------------

(define (problem p60_11)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30 b31 b32 b33 b34 b35 b36 b37 b38 b39 b40 b41 b42 b43 b44 b45 b46 b47 b48 b49 b50 b51 b52 b53 b54 b55 b56 b57 b58 b59 b60)
(:init
	(arm-empty)
	(on-table b1) (on b6 b1) (on b13 b6) (on b21 b13) (on b22 b21) (on b28 b22) (on b31 b28) (on b33 b31) (on b37 b33) (clear b37)
	(on-table b2) (on b3 b2) (on b5 b3) (on b7 b5) (on b17 b7) (on b19 b17) (on b20 b19) (on b25 b20) (on b40 b25) (on b55 b40) (on b59 b55) (clear b59)
	(on-table b4) (on b8 b4) (on b10 b8) (on b18 b10) (on b26 b18) (on b27 b26) (on b29 b27) (on b32 b29) (on b36 b32) (on b45 b36) (on b46 b45) (on b47 b46) (on b60 b47) (clear b60)
	(on-table b9) (on b11 b9) (on b12 b11) (on b14 b12) (on b15 b14) (on b16 b15) (on b30 b16) (on b34 b30) (on b35 b34) (on b41 b35) (on b43 b41) (on b44 b43) (on b56 b44) (clear b56)
	(on-table b23) (on b24 b23) (on b38 b24) (on b52 b38) (clear b52)
	(on-table b39) (on b42 b39) (clear b42)
	(on-table b48) (on b51 b48) (on b53 b51) (on b54 b53) (clear b54)
	(on-table b49) (on b50 b49) (on b57 b50) (clear b57)
	(on-table b58) (clear b58)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b2 b1) (on b6 b2) (on b12 b6) (on b13 b12) (on b16 b13) (on b29 b16) (on b48 b29) (on b49 b48) (on b57 b49) (on b59 b57) (clear b59)
	(on-table b3) (on b10 b3) (on b11 b10) (on b14 b11) (on b25 b14) (on b42 b25) (on b46 b42) (on b55 b46) (clear b55)
	(on-table b4) (on b5 b4) (on b7 b5) (on b8 b7) (on b15 b8) (on b17 b15) (on b18 b17) (on b23 b18) (on b41 b23) (on b44 b41) (on b56 b44) (clear b56)
	(on-table b9) (on b21 b9) (on b28 b21) (on b39 b28) (on b40 b39) (clear b40)
	(on-table b19) (on b24 b19) (on b30 b24) (on b31 b30) (on b33 b31) (on b47 b33) (on b58 b47) (clear b58)
	(on-table b20) (on b22 b20) (on b34 b22) (on b35 b34) (on b37 b35) (on b43 b37) (on b45 b43) (clear b45)
	(on-table b26) (on b27 b26) (on b36 b27) (on b38 b36) (on b51 b38) (on b53 b51) (clear b53)
	(on-table b32) (on b50 b32) (on b52 b50) (clear b52)
	(on-table b54) (clear b54)
	(on-table b60) (clear b60)
))
)


