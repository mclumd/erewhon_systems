;;---------------------------------------------

(define (problem p70_9)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30 b31 b32 b33 b34 b35 b36 b37 b38 b39 b40 b41 b42 b43 b44 b45 b46 b47 b48 b49 b50 b51 b52 b53 b54 b55 b56 b57 b58 b59 b60 b61 b62 b63 b64 b65 b66 b67 b68 b69 b70)
(:init
	(arm-empty)
	(on-table b1) (on b3 b1) (on b17 b3) (on b43 b17) (on b49 b43) (on b55 b49) (on b56 b55) (on b60 b56) (clear b60)
	(on-table b2) (on b5 b2) (on b9 b5) (on b28 b9) (on b32 b28) (on b33 b32) (on b46 b33) (on b53 b46) (on b62 b53) (on b64 b62) (on b67 b64) (clear b67)
	(on-table b4) (on b7 b4) (on b8 b7) (on b13 b8) (on b14 b13) (on b18 b14) (on b25 b18) (on b29 b25) (on b35 b29) (on b36 b35) (on b40 b36) (on b50 b40) (on b52 b50) (on b65 b52) (clear b65)
	(on-table b6) (on b10 b6) (on b11 b10) (on b12 b11) (on b15 b12) (on b19 b15) (on b23 b19) (clear b23)
	(on-table b16) (on b21 b16) (on b26 b21) (on b30 b26) (on b42 b30) (on b59 b42) (clear b59)
	(on-table b20) (on b31 b20) (on b34 b31) (on b37 b34) (on b39 b37) (on b41 b39) (on b54 b41) (on b61 b54) (on b66 b61) (clear b66)
	(on-table b22) (on b27 b22) (on b45 b27) (on b48 b45) (clear b48)
	(on-table b24) (on b38 b24) (on b57 b38) (on b69 b57) (clear b69)
	(on-table b44) (on b47 b44) (on b51 b47) (on b58 b51) (on b63 b58) (clear b63)
	(on-table b68) (on b70 b68) (clear b70)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b2 b1) (on b7 b2) (on b25 b7) (on b26 b25) (on b33 b26) (on b39 b33) (on b46 b39) (on b63 b46) (on b66 b63) (clear b66)
	(on-table b3) (on b4 b3) (on b6 b4) (on b11 b6) (on b40 b11) (on b67 b40) (on b69 b67) (clear b69)
	(on-table b5) (on b14 b5) (on b15 b14) (on b17 b15) (on b19 b17) (on b20 b19) (on b22 b20) (on b31 b22) (on b36 b31) (on b42 b36) (on b50 b42) (on b55 b50) (clear b55)
	(on-table b8) (on b13 b8) (on b24 b13) (on b49 b24) (clear b49)
	(on-table b9) (on b16 b9) (on b18 b16) (on b34 b18) (on b47 b34) (on b56 b47) (on b62 b56) (on b65 b62) (on b70 b65) (clear b70)
	(on-table b10) (on b12 b10) (on b21 b12) (on b27 b21) (on b44 b27) (on b68 b44) (clear b68)
	(on-table b23) (on b28 b23) (on b30 b28) (on b48 b30) (on b53 b48) (on b57 b53) (on b61 b57) (on b64 b61) (clear b64)
	(on-table b29) (on b32 b29) (on b35 b32) (on b45 b35) (on b59 b45) (on b60 b59) (clear b60)
	(on-table b37) (on b38 b37) (on b41 b38) (on b43 b41) (on b52 b43) (clear b52)
	(on-table b51) (on b54 b51) (clear b54)
	(on-table b58) (clear b58)
))
)


