;;---------------------------------------------

(define (problem p60_9)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30 b31 b32 b33 b34 b35 b36 b37 b38 b39 b40 b41 b42 b43 b44 b45 b46 b47 b48 b49 b50 b51 b52 b53 b54 b55 b56 b57 b58 b59 b60)
(:init
	(arm-empty)
	(on-table b1) (on b2 b1) (on b3 b2) (on b4 b3) (on b6 b4) (on b7 b6) (on b13 b7) (on b21 b13) (on b30 b21) (on b32 b30) (on b44 b32) (on b53 b44) (on b56 b53) (clear b56)
	(on-table b5) (on b8 b5) (on b9 b8) (on b12 b9) (on b24 b12) (on b36 b24) (on b37 b36) (on b39 b37) (on b49 b39) (clear b49)
	(on-table b10) (on b15 b10) (on b18 b15) (on b19 b18) (on b25 b19) (on b38 b25) (on b48 b38) (on b54 b48) (on b55 b54) (on b59 b55) (on b60 b59) (clear b60)
	(on-table b11) (on b16 b11) (on b27 b16) (on b35 b27) (on b40 b35) (on b46 b40) (on b57 b46) (clear b57)
	(on-table b14) (on b17 b14) (on b20 b17) (on b34 b20) (on b41 b34) (clear b41)
	(on-table b22) (on b23 b22) (on b31 b23) (on b33 b31) (clear b33)
	(on-table b26) (on b28 b26) (on b29 b28) (on b42 b29) (on b47 b42) (on b50 b47) (on b52 b50) (on b58 b52) (clear b58)
	(on-table b43) (on b45 b43) (on b51 b45) (clear b51)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b6 b1) (on b7 b6) (on b8 b7) (on b9 b8) (on b11 b9) (on b12 b11) (on b13 b12) (on b14 b13) (on b19 b14) (on b21 b19) (on b35 b21) (on b38 b35) (clear b38)
	(on-table b2) (on b3 b2) (on b4 b3) (on b5 b4) (on b15 b5) (on b16 b15) (on b18 b16) (on b20 b18) (on b22 b20) (on b23 b22) (on b26 b23) (on b27 b26) (on b31 b27) (on b34 b31) (on b41 b34) (on b49 b41) (on b51 b49) (on b53 b51) (on b55 b53) (on b59 b55) (clear b59)
	(on-table b10) (on b17 b10) (on b24 b17) (on b52 b24) (clear b52)
	(on-table b25) (on b28 b25) (on b29 b28) (on b30 b29) (on b32 b30) (on b33 b32) (on b37 b33) (on b40 b37) (on b44 b40) (on b48 b44) (on b50 b48) (on b54 b50) (on b57 b54) (clear b57)
	(on-table b36) (on b43 b36) (on b45 b43) (clear b45)
	(on-table b39) (on b56 b39) (on b58 b56) (on b60 b58) (clear b60)
	(on-table b42) (on b46 b42) (on b47 b46) (clear b47)
))
)


