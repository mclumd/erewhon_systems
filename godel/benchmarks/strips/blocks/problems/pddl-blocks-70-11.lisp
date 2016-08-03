;;---------------------------------------------

(define (problem p70_11)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30 b31 b32 b33 b34 b35 b36 b37 b38 b39 b40 b41 b42 b43 b44 b45 b46 b47 b48 b49 b50 b51 b52 b53 b54 b55 b56 b57 b58 b59 b60 b61 b62 b63 b64 b65 b66 b67 b68 b69 b70)
(:init
	(arm-empty)
	(on-table b1) (on b3 b1) (on b6 b3) (on b16 b6) (on b17 b16) (on b22 b17) (on b36 b22) (on b50 b36) (on b51 b50) (on b53 b51) (on b64 b53) (on b67 b64) (clear b67)
	(on-table b2) (on b4 b2) (on b5 b4) (on b7 b5) (on b10 b7) (on b11 b10) (on b12 b11) (on b14 b12) (on b15 b14) (on b21 b15) (on b40 b21) (on b45 b40) (on b57 b45) (on b66 b57) (on b68 b66) (on b70 b68) (clear b70)
	(on-table b8) (on b18 b8) (on b19 b18) (on b27 b19) (on b30 b27) (on b42 b30) (on b43 b42) (on b44 b43) (on b47 b44) (on b58 b47) (clear b58)
	(on-table b9) (on b13 b9) (on b20 b13) (on b24 b20) (on b28 b24) (on b29 b28) (on b33 b29) (on b34 b33) (on b41 b34) (on b48 b41) (on b65 b48) (on b69 b65) (clear b69)
	(on-table b23) (on b25 b23) (on b26 b25) (on b31 b26) (on b32 b31) (on b35 b32) (on b37 b35) (on b38 b37) (on b39 b38) (on b49 b39) (on b54 b49) (on b56 b54) (on b62 b56) (clear b62)
	(on-table b46) (on b52 b46) (on b55 b52) (on b59 b55) (on b60 b59) (on b61 b60) (on b63 b61) (clear b63)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b5 b1) (on b9 b5) (on b11 b9) (on b15 b11) (on b17 b15) (on b19 b17) (on b21 b19) (on b22 b21) (on b41 b22) (on b49 b41) (clear b49)
	(on-table b2) (on b4 b2) (on b8 b4) (on b18 b8) (on b23 b18) (on b30 b23) (on b42 b30) (on b43 b42) (on b51 b43) (on b52 b51) (on b61 b52) (on b62 b61) (on b64 b62) (on b69 b64) (clear b69)
	(on-table b3) (on b12 b3) (on b14 b12) (on b20 b14) (on b29 b20) (on b37 b29) (on b38 b37) (on b46 b38) (on b47 b46) (on b48 b47) (on b60 b48) (on b65 b60) (on b67 b65) (clear b67)
	(on-table b6) (on b13 b6) (on b16 b13) (on b25 b16) (on b27 b25) (on b28 b27) (on b31 b28) (on b35 b31) (on b36 b35) (on b50 b36) (on b57 b50) (on b58 b57) (clear b58)
	(on-table b7) (on b10 b7) (on b24 b10) (on b39 b24) (on b44 b39) (on b55 b44) (on b68 b55) (clear b68)
	(on-table b26) (on b32 b26) (on b33 b32) (on b34 b33) (on b53 b34) (clear b53)
	(on-table b40) (on b45 b40) (on b54 b45) (clear b54)
	(on-table b56) (on b59 b56) (on b63 b59) (clear b63)
	(on-table b66) (clear b66)
	(on-table b70) (clear b70)
))
)


