;;---------------------------------------------

(define (problem p60_25)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30 b31 b32 b33 b34 b35 b36 b37 b38 b39 b40 b41 b42 b43 b44 b45 b46 b47 b48 b49 b50 b51 b52 b53 b54 b55 b56 b57 b58 b59 b60)
(:init
	(arm-empty)
	(on-table b1) (on b2 b1) (on b4 b2) (on b5 b4) (on b8 b5) (on b22 b8) (on b23 b22) (on b28 b23) (on b29 b28) (on b33 b29) (on b37 b33) (on b39 b37) (on b40 b39) (on b43 b40) (on b48 b43) (clear b48)
	(on-table b3) (on b12 b3) (on b16 b12) (on b17 b16) (on b21 b17) (on b24 b21) (on b26 b24) (on b30 b26) (on b38 b30) (on b50 b38) (on b54 b50) (on b55 b54) (clear b55)
	(on-table b6) (on b7 b6) (on b10 b7) (on b11 b10) (on b19 b11) (on b35 b19) (on b44 b35) (clear b44)
	(on-table b9) (on b15 b9) (clear b15)
	(on-table b13) (on b20 b13) (on b25 b20) (on b27 b25) (on b34 b27) (on b45 b34) (on b47 b45) (on b51 b47) (on b53 b51) (on b56 b53) (on b59 b56) (clear b59)
	(on-table b14) (on b18 b14) (on b46 b18) (on b49 b46) (clear b49)
	(on-table b31) (on b32 b31) (on b36 b32) (on b57 b36) (on b60 b57) (clear b60)
	(on-table b41) (on b42 b41) (clear b42)
	(on-table b52) (on b58 b52) (clear b58)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b5 b1) (on b9 b5) (on b50 b9) (clear b50)
	(on-table b2) (on b7 b2) (on b8 b7) (on b13 b8) (on b18 b13) (on b20 b18) (on b25 b20) (on b26 b25) (on b27 b26) (on b32 b27) (on b48 b32) (on b49 b48) (on b55 b49) (on b60 b55) (clear b60)
	(on-table b3) (on b4 b3) (on b6 b4) (on b10 b6) (on b12 b10) (on b14 b12) (on b15 b14) (on b16 b15) (on b17 b16) (on b24 b17) (on b30 b24) (on b33 b30) (on b37 b33) (on b38 b37) (on b54 b38) (clear b54)
	(on-table b11) (on b19 b11) (on b21 b19) (on b31 b21) (on b40 b31) (on b45 b40) (on b52 b45) (on b56 b52) (on b58 b56) (clear b58)
	(on-table b22) (on b23 b22) (on b28 b23) (on b29 b28) (on b34 b29) (on b35 b34) (on b42 b35) (on b57 b42) (clear b57)
	(on-table b36) (on b43 b36) (on b44 b43) (on b46 b44) (on b53 b46) (on b59 b53) (clear b59)
	(on-table b39) (on b41 b39) (on b47 b41) (on b51 b47) (clear b51)
))
)


