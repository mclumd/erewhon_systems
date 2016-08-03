;;---------------------------------------------

(define (problem p70_20)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30 b31 b32 b33 b34 b35 b36 b37 b38 b39 b40 b41 b42 b43 b44 b45 b46 b47 b48 b49 b50 b51 b52 b53 b54 b55 b56 b57 b58 b59 b60 b61 b62 b63 b64 b65 b66 b67 b68 b69 b70)
(:init
	(arm-empty)
	(on-table b1) (on b2 b1) (on b5 b2) (on b10 b5) (on b13 b10) (on b16 b13) (on b31 b16) (on b42 b31) (on b66 b42) (on b69 b66) (clear b69)
	(on-table b3) (on b4 b3) (on b7 b4) (on b8 b7) (on b11 b8) (on b12 b11) (on b14 b12) (on b15 b14) (on b17 b15) (on b25 b17) (on b30 b25) (on b32 b30) (on b46 b32) (on b57 b46) (on b64 b57) (clear b64)
	(on-table b6) (on b19 b6) (on b20 b19) (on b23 b20) (on b26 b23) (on b29 b26) (on b33 b29) (on b39 b33) (on b41 b39) (on b48 b41) (on b49 b48) (clear b49)
	(on-table b9) (on b36 b9) (on b37 b36) (on b43 b37) (on b44 b43) (on b45 b44) (on b62 b45) (on b67 b62) (clear b67)
	(on-table b18) (on b22 b18) (on b38 b22) (on b58 b38) (clear b58)
	(on-table b21) (on b27 b21) (on b28 b27) (on b50 b28) (clear b50)
	(on-table b24) (on b34 b24) (on b35 b34) (on b52 b35) (on b54 b52) (on b60 b54) (on b61 b60) (on b65 b61) (on b68 b65) (clear b68)
	(on-table b40) (on b53 b40) (on b55 b53) (on b56 b55) (on b63 b56) (clear b63)
	(on-table b47) (on b51 b47) (on b59 b51) (on b70 b59) (clear b70)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b11 b1) (on b12 b11) (on b16 b12) (on b20 b16) (on b32 b20) (on b37 b32) (on b43 b37) (on b47 b43) (on b49 b47) (on b69 b49) (clear b69)
	(on-table b2) (on b4 b2) (on b7 b4) (on b9 b7) (on b17 b9) (on b21 b17) (on b31 b21) (on b36 b31) (on b50 b36) (clear b50)
	(on-table b3) (on b6 b3) (on b8 b6) (on b24 b8) (on b58 b24) (on b68 b58) (clear b68)
	(on-table b5) (on b13 b5) (on b18 b13) (on b23 b18) (on b27 b23) (on b29 b27) (on b34 b29) (on b38 b34) (on b54 b38) (on b61 b54) (clear b61)
	(on-table b10) (on b19 b10) (on b22 b19) (on b26 b22) (on b30 b26) (on b41 b30) (clear b41)
	(on-table b14) (on b15 b14) (on b25 b15) (on b28 b25) (on b33 b28) (on b35 b33) (on b39 b35) (on b40 b39) (on b51 b40) (on b62 b51) (on b70 b62) (clear b70)
	(on-table b42) (on b45 b42) (on b46 b45) (on b55 b46) (on b56 b55) (on b57 b56) (on b66 b57) (clear b66)
	(on-table b44) (on b48 b44) (on b52 b48) (on b63 b52) (on b64 b63) (clear b64)
	(on-table b53) (on b60 b53) (on b67 b60) (clear b67)
	(on-table b59) (on b65 b59) (clear b65)
))
)


