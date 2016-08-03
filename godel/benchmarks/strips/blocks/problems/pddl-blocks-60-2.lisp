;;---------------------------------------------

(define (problem p60_2)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30 b31 b32 b33 b34 b35 b36 b37 b38 b39 b40 b41 b42 b43 b44 b45 b46 b47 b48 b49 b50 b51 b52 b53 b54 b55 b56 b57 b58 b59 b60)
(:init
	(arm-empty)
	(on-table b1) (on b2 b1) (on b3 b2) (on b4 b3) (on b36 b4) (on b38 b36) (on b40 b38) (on b57 b40) (clear b57)
	(on-table b5) (on b16 b5) (on b19 b16) (on b20 b19) (on b26 b20) (on b32 b26) (on b58 b32) (clear b58)
	(on-table b6) (on b9 b6) (on b17 b9) (on b22 b17) (on b31 b22) (on b39 b31) (on b42 b39) (on b49 b42) (clear b49)
	(on-table b7) (on b8 b7) (on b12 b8) (on b14 b12) (on b23 b14) (on b25 b23) (on b29 b25) (on b33 b29) (on b51 b33) (clear b51)
	(on-table b10) (on b13 b10) (on b21 b13) (on b35 b21) (on b41 b35) (on b56 b41) (on b59 b56) (clear b59)
	(on-table b11) (on b15 b11) (on b24 b15) (on b47 b24) (on b48 b47) (on b60 b48) (clear b60)
	(on-table b18) (on b27 b18) (on b28 b27) (on b43 b28) (on b52 b43) (on b55 b52) (clear b55)
	(on-table b30) (on b44 b30) (on b45 b44) (on b53 b45) (clear b53)
	(on-table b34) (on b50 b34) (clear b50)
	(on-table b37) (on b46 b37) (clear b46)
	(on-table b54) (clear b54)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b8 b1) (on b9 b8) (on b12 b9) (on b22 b12) (on b24 b22) (on b25 b24) (on b37 b25) (on b40 b37) (on b47 b40) (on b48 b47) (on b60 b48) (clear b60)
	(on-table b2) (on b3 b2) (on b4 b3) (on b11 b4) (on b13 b11) (on b16 b13) (on b27 b16) (on b28 b27) (on b29 b28) (on b33 b29) (on b34 b33) (on b53 b34) (clear b53)
	(on-table b5) (on b6 b5) (on b14 b6) (on b15 b14) (on b30 b15) (on b39 b30) (on b43 b39) (on b50 b43) (clear b50)
	(on-table b7) (on b10 b7) (on b19 b10) (on b26 b19) (on b44 b26) (clear b44)
	(on-table b17) (on b18 b17) (on b23 b18) (on b38 b23) (on b41 b38) (clear b41)
	(on-table b20) (on b35 b20) (on b36 b35) (on b45 b36) (on b49 b45) (on b58 b49) (clear b58)
	(on-table b21) (on b32 b21) (on b46 b32) (on b51 b46) (on b52 b51) (on b54 b52) (clear b54)
	(on-table b31) (on b42 b31) (on b55 b42) (on b56 b55) (on b57 b56) (clear b57)
	(on-table b59) (clear b59)
))
)


