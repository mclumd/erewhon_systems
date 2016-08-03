;;---------------------------------------------

(define (problem p60_10)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30 b31 b32 b33 b34 b35 b36 b37 b38 b39 b40 b41 b42 b43 b44 b45 b46 b47 b48 b49 b50 b51 b52 b53 b54 b55 b56 b57 b58 b59 b60)
(:init
	(arm-empty)
	(on-table b1) (on b6 b1) (on b16 b6) (on b31 b16) (on b37 b31) (on b43 b37) (on b50 b43) (on b57 b50) (clear b57)
	(on-table b2) (on b4 b2) (on b5 b4) (on b7 b5) (on b8 b7) (on b9 b8) (on b15 b9) (on b19 b15) (on b32 b19) (clear b32)
	(on-table b3) (on b11 b3) (on b18 b11) (on b20 b18) (on b27 b20) (on b28 b27) (on b33 b28) (on b44 b33) (on b52 b44) (on b56 b52) (on b58 b56) (clear b58)
	(on-table b10) (on b22 b10) (on b24 b22) (on b34 b24) (clear b34)
	(on-table b12) (on b17 b12) (on b21 b17) (on b29 b21) (on b30 b29) (on b49 b30) (clear b49)
	(on-table b13) (on b14 b13) (on b38 b14) (on b45 b38) (on b60 b45) (clear b60)
	(on-table b23) (on b25 b23) (on b26 b25) (clear b26)
	(on-table b35) (on b46 b35) (on b47 b46) (on b53 b47) (on b55 b53) (clear b55)
	(on-table b36) (on b48 b36) (clear b48)
	(on-table b39) (on b42 b39) (on b51 b42) (on b54 b51) (on b59 b54) (clear b59)
	(on-table b40) (on b41 b40) (clear b41)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b2 b1) (on b27 b2) (on b28 b27) (on b32 b28) (on b36 b32) (on b39 b36) (on b44 b39) (on b51 b44) (clear b51)
	(on-table b3) (on b8 b3) (on b12 b8) (on b13 b12) (on b20 b13) (on b23 b20) (on b24 b23) (on b45 b24) (on b47 b45) (clear b47)
	(on-table b4) (on b5 b4) (on b9 b5) (on b11 b9) (on b14 b11) (on b15 b14) (on b25 b15) (on b30 b25) (on b31 b30) (clear b31)
	(on-table b6) (on b18 b6) (clear b18)
	(on-table b7) (on b10 b7) (on b17 b10) (on b22 b17) (on b29 b22) (on b37 b29) (on b38 b37) (on b42 b38) (on b53 b42) (clear b53)
	(on-table b16) (on b19 b16) (on b26 b19) (on b33 b26) (on b40 b33) (on b54 b40) (on b56 b54) (on b57 b56) (on b60 b57) (clear b60)
	(on-table b21) (on b55 b21) (on b58 b55) (on b59 b58) (clear b59)
	(on-table b34) (on b35 b34) (on b41 b35) (on b43 b41) (on b49 b43) (clear b49)
	(on-table b46) (on b52 b46) (clear b52)
	(on-table b48) (on b50 b48) (clear b50)
))
)

