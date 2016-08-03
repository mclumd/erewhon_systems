;;---------------------------------------------

(define (problem p70_2)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30 b31 b32 b33 b34 b35 b36 b37 b38 b39 b40 b41 b42 b43 b44 b45 b46 b47 b48 b49 b50 b51 b52 b53 b54 b55 b56 b57 b58 b59 b60 b61 b62 b63 b64 b65 b66 b67 b68 b69 b70)
(:init
	(arm-empty)
	(on-table b1) (on b2 b1) (on b13 b2) (on b22 b13) (on b32 b22) (on b36 b32) (on b37 b36) (on b39 b37) (on b46 b39) (on b47 b46) (on b53 b47) (on b63 b53) (clear b63)
	(on-table b3) (on b4 b3) (on b6 b4) (on b12 b6) (on b15 b12) (on b16 b15) (on b19 b16) (on b26 b19) (on b30 b26) (on b43 b30) (on b52 b43) (clear b52)
	(on-table b5) (on b7 b5) (on b8 b7) (on b11 b8) (on b18 b11) (on b23 b18) (on b24 b23) (on b27 b24) (on b31 b27) (on b45 b31) (on b55 b45) (on b59 b55) (clear b59)
	(on-table b9) (on b17 b9) (on b21 b17) (on b29 b21) (on b61 b29) (clear b61)
	(on-table b10) (on b20 b10) (on b25 b20) (on b33 b25) (on b51 b33) (on b60 b51) (on b62 b60) (clear b62)
	(on-table b14) (on b38 b14) (on b40 b38) (on b41 b40) (on b58 b41) (on b69 b58) (clear b69)
	(on-table b28) (on b34 b28) (on b35 b34) (on b56 b35) (clear b56)
	(on-table b42) (on b44 b42) (on b48 b44) (on b49 b48) (on b50 b49) (clear b50)
	(on-table b54) (on b65 b54) (on b70 b65) (clear b70)
	(on-table b57) (on b68 b57) (clear b68)
	(on-table b64) (on b67 b64) (clear b67)
	(on-table b66) (clear b66)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b14 b1) (on b44 b14) (on b45 b44) (on b46 b45) (on b53 b46) (on b60 b53) (on b65 b60) (on b70 b65) (clear b70)
	(on-table b2) (on b3 b2) (on b4 b3) (on b6 b4) (on b12 b6) (on b23 b12) (on b27 b23) (on b32 b27) (on b33 b32) (on b38 b33) (on b52 b38) (on b55 b52) (on b59 b55) (clear b59)
	(on-table b5) (on b7 b5) (on b8 b7) (on b11 b8) (on b15 b11) (on b19 b15) (on b20 b19) (on b40 b20) (on b57 b40) (on b69 b57) (clear b69)
	(on-table b9) (on b10 b9) (on b16 b10) (on b17 b16) (on b18 b17) (on b21 b18) (on b22 b21) (on b24 b22) (on b41 b24) (on b42 b41) (on b43 b42) (on b48 b43) (on b56 b48) (on b62 b56) (on b67 b62) (clear b67)
	(on-table b13) (on b25 b13) (on b26 b25) (on b30 b26) (on b31 b30) (on b51 b31) (on b61 b51) (on b64 b61) (clear b64)
	(on-table b28) (on b29 b28) (on b39 b29) (on b50 b39) (on b58 b50) (on b66 b58) (clear b66)
	(on-table b34) (on b35 b34) (on b36 b35) (on b37 b36) (on b47 b37) (on b49 b47) (on b54 b49) (on b63 b54) (clear b63)
	(on-table b68) (clear b68)
))
)


