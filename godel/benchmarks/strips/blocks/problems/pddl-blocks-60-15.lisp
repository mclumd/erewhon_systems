;;---------------------------------------------

(define (problem p60_15)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30 b31 b32 b33 b34 b35 b36 b37 b38 b39 b40 b41 b42 b43 b44 b45 b46 b47 b48 b49 b50 b51 b52 b53 b54 b55 b56 b57 b58 b59 b60)
(:init
	(arm-empty)
	(on-table b1) (on b6 b1) (on b7 b6) (on b12 b7) (on b15 b12) (on b21 b15) (on b25 b21) (on b33 b25) (on b37 b33) (on b40 b37) (on b42 b40) (on b46 b42) (on b53 b46) (on b57 b53) (on b60 b57) (clear b60)
	(on-table b2) (on b4 b2) (on b8 b4) (on b13 b8) (on b24 b13) (on b28 b24) (on b38 b28) (clear b38)
	(on-table b3) (on b17 b3) (on b19 b17) (on b27 b19) (on b32 b27) (on b49 b32) (clear b49)
	(on-table b5) (on b11 b5) (on b22 b11) (on b23 b22) (on b51 b23) (on b54 b51) (clear b54)
	(on-table b9) (on b10 b9) (on b20 b10) (on b44 b20) (on b47 b44) (on b50 b47) (on b58 b50) (clear b58)
	(on-table b14) (on b18 b14) (on b26 b18) (on b29 b26) (on b43 b29) (clear b43)
	(on-table b16) (on b30 b16) (on b39 b30) (on b48 b39) (on b52 b48) (clear b52)
	(on-table b31) (on b34 b31) (on b35 b34) (on b36 b35) (on b41 b36) (on b45 b41) (on b55 b45) (on b56 b55) (clear b56)
	(on-table b59) (clear b59)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b2 b1) (on b3 b2) (on b4 b3) (on b5 b4) (on b9 b5) (on b10 b9) (on b11 b10) (on b12 b11) (on b17 b12) (on b42 b17) (on b60 b42) (clear b60)
	(on-table b6) (on b7 b6) (on b8 b7) (on b13 b8) (on b14 b13) (on b23 b14) (on b26 b23) (on b31 b26) (on b35 b31) (on b51 b35) (on b57 b51) (on b58 b57) (clear b58)
	(on-table b15) (on b16 b15) (on b36 b16) (on b43 b36) (on b49 b43) (on b56 b49) (clear b56)
	(on-table b18) (on b20 b18) (on b22 b20) (on b24 b22) (on b28 b24) (on b29 b28) (on b37 b29) (on b38 b37) (on b40 b38) (clear b40)
	(on-table b19) (on b21 b19) (on b25 b21) (on b32 b25) (on b39 b32) (on b50 b39) (clear b50)
	(on-table b27) (on b34 b27) (on b48 b34) (on b54 b48) (clear b54)
	(on-table b30) (on b33 b30) (on b41 b33) (on b45 b41) (clear b45)
	(on-table b44) (on b46 b44) (on b55 b46) (clear b55)
	(on-table b47) (clear b47)
	(on-table b52) (on b59 b52) (clear b59)
	(on-table b53) (clear b53)
))
)


