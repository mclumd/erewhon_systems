;;---------------------------------------------

(define (problem p70_14)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30 b31 b32 b33 b34 b35 b36 b37 b38 b39 b40 b41 b42 b43 b44 b45 b46 b47 b48 b49 b50 b51 b52 b53 b54 b55 b56 b57 b58 b59 b60 b61 b62 b63 b64 b65 b66 b67 b68 b69 b70)
(:init
	(arm-empty)
	(on-table b1) (on b6 b1) (on b13 b6) (on b18 b13) (on b21 b18) (on b26 b21) (on b37 b26) (on b44 b37) (on b47 b44) (on b55 b47) (on b60 b55) (on b65 b60) (clear b65)
	(on-table b2) (on b3 b2) (on b10 b3) (on b15 b10) (on b17 b15) (on b22 b17) (on b24 b22) (on b39 b24) (on b43 b39) (on b45 b43) (on b46 b45) (on b62 b46) (on b68 b62) (clear b68)
	(on-table b4) (on b14 b4) (on b16 b14) (on b33 b16) (on b61 b33) (clear b61)
	(on-table b5) (on b7 b5) (on b11 b7) (on b12 b11) (on b20 b12) (on b29 b20) (on b38 b29) (on b40 b38) (on b41 b40) (on b54 b41) (on b59 b54) (on b66 b59) (clear b66)
	(on-table b8) (on b9 b8) (on b27 b9) (on b30 b27) (on b35 b30) (on b56 b35) (on b57 b56) (clear b57)
	(on-table b19) (on b25 b19) (on b28 b25) (on b31 b28) (on b32 b31) (on b48 b32) (on b52 b48) (on b58 b52) (on b64 b58) (on b67 b64) (on b70 b67) (clear b70)
	(on-table b23) (on b34 b23) (on b36 b34) (on b42 b36) (on b49 b42) (on b50 b49) (on b51 b50) (on b53 b51) (on b63 b53) (clear b63)
	(on-table b69) (clear b69)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b2 b1) (on b3 b2) (on b4 b3) (on b13 b4) (on b17 b13) (on b18 b17) (on b21 b18) (on b22 b21) (on b28 b22) (on b33 b28) (on b34 b33) (on b37 b34) (on b39 b37) (on b41 b39) (on b44 b41) (on b51 b44) (on b52 b51) (on b64 b52) (on b69 b64) (clear b69)
	(on-table b5) (on b9 b5) (on b10 b9) (on b16 b10) (on b23 b16) (on b31 b23) (on b42 b31) (on b43 b42) (on b49 b43) (on b54 b49) (clear b54)
	(on-table b6) (on b19 b6) (on b24 b19) (on b40 b24) (on b55 b40) (on b57 b55) (on b66 b57) (clear b66)
	(on-table b7) (on b8 b7) (on b15 b8) (on b27 b15) (on b30 b27) (on b32 b30) (on b46 b32) (on b47 b46) (on b60 b47) (clear b60)
	(on-table b11) (on b14 b11) (on b25 b14) (on b29 b25) (on b45 b29) (on b67 b45) (clear b67)
	(on-table b12) (on b20 b12) (on b35 b20) (clear b35)
	(on-table b26) (on b38 b26) (on b53 b38) (on b59 b53) (clear b59)
	(on-table b36) (on b48 b36) (on b58 b48) (on b62 b58) (on b68 b62) (clear b68)
	(on-table b50) (on b61 b50) (on b65 b61) (clear b65)
	(on-table b56) (clear b56)
	(on-table b63) (clear b63)
	(on-table b70) (clear b70)
))
)


