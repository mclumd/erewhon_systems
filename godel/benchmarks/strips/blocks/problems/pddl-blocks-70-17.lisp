;;---------------------------------------------

(define (problem p70_17)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30 b31 b32 b33 b34 b35 b36 b37 b38 b39 b40 b41 b42 b43 b44 b45 b46 b47 b48 b49 b50 b51 b52 b53 b54 b55 b56 b57 b58 b59 b60 b61 b62 b63 b64 b65 b66 b67 b68 b69 b70)
(:init
	(arm-empty)
	(on-table b1) (on b3 b1) (on b5 b3) (on b7 b5) (on b22 b7) (on b32 b22) (on b39 b32) (on b43 b39) (on b47 b43) (on b66 b47) (clear b66)
	(on-table b2) (on b4 b2) (on b6 b4) (on b12 b6) (on b18 b12) (on b19 b18) (on b29 b19) (on b30 b29) (on b45 b30) (on b70 b45) (clear b70)
	(on-table b8) (on b9 b8) (on b13 b9) (on b16 b13) (on b21 b16) (on b23 b21) (on b31 b23) (on b33 b31) (on b36 b33) (on b37 b36) (clear b37)
	(on-table b10) (on b11 b10) (on b14 b11) (on b15 b14) (on b17 b15) (on b20 b17) (on b24 b20) (on b26 b24) (on b28 b26) (on b38 b28) (on b42 b38) (on b44 b42) (on b49 b44) (on b59 b49) (clear b59)
	(on-table b25) (on b50 b25) (on b64 b50) (on b68 b64) (clear b68)
	(on-table b27) (on b34 b27) (on b35 b34) (on b55 b35) (on b57 b55) (on b65 b57) (clear b65)
	(on-table b40) (on b41 b40) (on b46 b41) (on b48 b46) (on b53 b48) (on b56 b53) (on b62 b56) (clear b62)
	(on-table b51) (on b54 b51) (on b63 b54) (on b67 b63) (on b69 b67) (clear b69)
	(on-table b52) (clear b52)
	(on-table b58) (clear b58)
	(on-table b60) (on b61 b60) (clear b61)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b2 b1) (on b12 b2) (on b22 b12) (on b52 b22) (on b61 b52) (clear b61)
	(on-table b3) (on b4 b3) (on b10 b4) (on b11 b10) (on b20 b11) (on b21 b20) (on b24 b21) (clear b24)
	(on-table b5) (on b7 b5) (on b8 b7) (on b13 b8) (on b14 b13) (on b15 b14) (on b16 b15) (on b31 b16) (on b38 b31) (on b43 b38) (on b50 b43) (clear b50)
	(on-table b6) (on b27 b6) (on b33 b27) (on b41 b33) (on b46 b41) (clear b46)
	(on-table b9) (on b23 b9) (on b35 b23) (on b36 b35) (on b40 b36) (on b68 b40) (on b69 b68) (clear b69)
	(on-table b17) (on b18 b17) (on b25 b18) (on b28 b25) (on b66 b28) (clear b66)
	(on-table b19) (on b26 b19) (on b32 b26) (on b48 b32) (on b60 b48) (clear b60)
	(on-table b29) (on b37 b29) (clear b37)
	(on-table b30) (on b34 b30) (on b42 b34) (on b45 b42) (on b55 b45) (on b67 b55) (clear b67)
	(on-table b39) (on b49 b39) (on b54 b49) (on b57 b54) (on b59 b57) (on b64 b59) (clear b64)
	(on-table b44) (on b58 b44) (clear b58)
	(on-table b47) (clear b47)
	(on-table b51) (on b53 b51) (on b62 b53) (clear b62)
	(on-table b56) (on b63 b56) (on b70 b63) (clear b70)
	(on-table b65) (clear b65)
))
)


