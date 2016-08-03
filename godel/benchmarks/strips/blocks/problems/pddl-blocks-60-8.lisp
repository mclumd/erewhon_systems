;;---------------------------------------------

(define (problem p60_8)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30 b31 b32 b33 b34 b35 b36 b37 b38 b39 b40 b41 b42 b43 b44 b45 b46 b47 b48 b49 b50 b51 b52 b53 b54 b55 b56 b57 b58 b59 b60)
(:init
	(arm-empty)
	(on-table b1) (on b3 b1) (on b27 b3) (on b29 b27) (on b37 b29) (on b49 b37) (clear b49)
	(on-table b2) (on b4 b2) (on b10 b4) (on b15 b10) (on b17 b15) (on b52 b17) (on b53 b52) (clear b53)
	(on-table b5) (on b11 b5) (on b19 b11) (on b35 b19) (on b36 b35) (on b39 b36) (on b43 b39) (on b54 b43) (clear b54)
	(on-table b6) (on b9 b6) (on b16 b9) (on b18 b16) (on b31 b18) (on b40 b31) (on b51 b40) (on b55 b51) (on b56 b55) (clear b56)
	(on-table b7) (on b12 b7) (on b20 b12) (on b21 b20) (on b22 b21) (on b23 b22) (on b28 b23) (on b30 b28) (on b38 b30) (clear b38)
	(on-table b8) (on b13 b8) (on b26 b13) (on b32 b26) (on b33 b32) (on b34 b33) (clear b34)
	(on-table b14) (on b42 b14) (on b48 b42) (on b50 b48) (clear b50)
	(on-table b24) (on b25 b24) (on b47 b25) (on b57 b47) (on b58 b57) (clear b58)
	(on-table b41) (on b44 b41) (on b45 b44) (on b46 b45) (on b59 b46) (on b60 b59) (clear b60)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b2 b1) (on b3 b2) (on b6 b3) (on b7 b6) (on b9 b7) (on b11 b9) (on b12 b11) (on b14 b12) (on b15 b14) (on b18 b15) (on b19 b18) (on b27 b19) (on b32 b27) (on b33 b32) (on b36 b33) (clear b36)
	(on-table b4) (on b5 b4) (on b16 b5) (on b17 b16) (on b22 b17) (on b25 b22) (on b40 b25) (on b59 b40) (clear b59)
	(on-table b8) (on b13 b8) (on b20 b13) (on b21 b20) (on b28 b21) (on b38 b28) (on b39 b38) (clear b39)
	(on-table b10) (on b30 b10) (on b35 b30) (on b44 b35) (on b48 b44) (on b56 b48) (on b58 b56) (clear b58)
	(on-table b23) (on b49 b23) (clear b49)
	(on-table b24) (on b42 b24) (on b45 b42) (on b52 b45) (on b54 b52) (clear b54)
	(on-table b26) (on b29 b26) (on b34 b29) (clear b34)
	(on-table b31) (on b57 b31) (clear b57)
	(on-table b37) (on b43 b37) (on b60 b43) (clear b60)
	(on-table b41) (clear b41)
	(on-table b46) (on b51 b46) (on b53 b51) (clear b53)
	(on-table b47) (clear b47)
	(on-table b50) (clear b50)
	(on-table b55) (clear b55)
))
)


