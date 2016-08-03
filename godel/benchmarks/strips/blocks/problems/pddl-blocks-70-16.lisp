;;---------------------------------------------

(define (problem p70_16)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30 b31 b32 b33 b34 b35 b36 b37 b38 b39 b40 b41 b42 b43 b44 b45 b46 b47 b48 b49 b50 b51 b52 b53 b54 b55 b56 b57 b58 b59 b60 b61 b62 b63 b64 b65 b66 b67 b68 b69 b70)
(:init
	(arm-empty)
	(on-table b1) (on b5 b1) (on b8 b5) (on b10 b8) (on b13 b10) (on b25 b13) (on b26 b25) (on b28 b26) (on b32 b28) (on b33 b32) (on b39 b33) (on b55 b39) (on b56 b55) (on b63 b56) (clear b63)
	(on-table b2) (on b3 b2) (on b9 b3) (on b18 b9) (on b20 b18) (on b31 b20) (on b40 b31) (on b42 b40) (on b49 b42) (on b50 b49) (on b52 b50) (on b54 b52) (on b57 b54) (clear b57)
	(on-table b4) (on b11 b4) (on b35 b11) (on b66 b35) (on b67 b66) (on b70 b67) (clear b70)
	(on-table b6) (on b16 b6) (on b19 b16) (on b27 b19) (on b36 b27) (on b38 b36) (on b61 b38) (on b64 b61) (clear b64)
	(on-table b7) (on b14 b7) (on b34 b14) (on b53 b34) (clear b53)
	(on-table b12) (on b17 b12) (on b23 b17) (on b43 b23) (clear b43)
	(on-table b15) (on b44 b15) (on b48 b44) (on b69 b48) (clear b69)
	(on-table b21) (on b22 b21) (on b24 b22) (on b29 b24) (on b65 b29) (on b68 b65) (clear b68)
	(on-table b30) (on b46 b30) (on b47 b46) (on b58 b47) (on b62 b58) (clear b62)
	(on-table b37) (on b41 b37) (on b45 b41) (on b60 b45) (clear b60)
	(on-table b51) (clear b51)
	(on-table b59) (clear b59)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b2 b1) (on b5 b2) (on b15 b5) (on b18 b15) (on b41 b18) (on b44 b41) (on b63 b44) (clear b63)
	(on-table b3) (on b13 b3) (on b14 b13) (on b21 b14) (on b42 b21) (on b51 b42) (on b60 b51) (clear b60)
	(on-table b4) (on b6 b4) (on b10 b6) (on b12 b10) (on b16 b12) (on b17 b16) (on b39 b17) (on b56 b39) (on b68 b56) (clear b68)
	(on-table b7) (on b8 b7) (on b9 b8) (on b11 b9) (on b22 b11) (on b26 b22) (on b35 b26) (on b40 b35) (on b43 b40) (on b53 b43) (on b58 b53) (on b61 b58) (on b70 b61) (clear b70)
	(on-table b19) (on b20 b19) (on b27 b20) (on b28 b27) (on b33 b28) (on b37 b33) (on b64 b37) (on b69 b64) (clear b69)
	(on-table b23) (on b24 b23) (on b45 b24) (on b47 b45) (on b50 b47) (on b54 b50) (clear b54)
	(on-table b25) (on b31 b25) (on b36 b31) (on b46 b36) (clear b46)
	(on-table b29) (on b30 b29) (on b38 b30) (on b49 b38) (on b55 b49) (on b57 b55) (clear b57)
	(on-table b32) (on b34 b32) (on b48 b34) (on b52 b48) (on b67 b52) (clear b67)
	(on-table b59) (on b62 b59) (on b65 b62) (clear b65)
	(on-table b66) (clear b66)
))
)

