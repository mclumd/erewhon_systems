;;---------------------------------------------

(define (problem p70_23)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30 b31 b32 b33 b34 b35 b36 b37 b38 b39 b40 b41 b42 b43 b44 b45 b46 b47 b48 b49 b50 b51 b52 b53 b54 b55 b56 b57 b58 b59 b60 b61 b62 b63 b64 b65 b66 b67 b68 b69 b70)
(:init
	(arm-empty)
	(on-table b1) (on b2 b1) (on b5 b2) (on b6 b5) (on b8 b6) (on b10 b8) (on b12 b10) (on b14 b12) (on b17 b14) (on b25 b17) (on b37 b25) (on b45 b37) (on b47 b45) (on b67 b47) (clear b67)
	(on-table b3) (on b13 b3) (on b24 b13) (on b27 b24) (on b33 b27) (on b38 b33) (on b43 b38) (on b49 b43) (clear b49)
	(on-table b4) (on b7 b4) (on b9 b7) (on b15 b9) (on b19 b15) (on b20 b19) (on b26 b20) (on b35 b26) (on b60 b35) (clear b60)
	(on-table b11) (on b16 b11) (on b18 b16) (on b22 b18) (on b28 b22) (on b29 b28) (on b30 b29) (on b32 b30) (on b36 b32) (on b54 b36) (on b59 b54) (on b69 b59) (clear b69)
	(on-table b21) (on b23 b21) (on b39 b23) (on b41 b39) (on b51 b41) (on b52 b51) (on b53 b52) (on b55 b53) (on b58 b55) (on b61 b58) (on b66 b61) (on b68 b66) (clear b68)
	(on-table b31) (on b42 b31) (on b46 b42) (on b48 b46) (on b50 b48) (on b64 b50) (on b65 b64) (clear b65)
	(on-table b34) (on b44 b34) (clear b44)
	(on-table b40) (on b56 b40) (on b62 b56) (on b63 b62) (clear b63)
	(on-table b57) (clear b57)
	(on-table b70) (clear b70)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b2 b1) (on b5 b2) (on b6 b5) (on b11 b6) (on b20 b11) (on b23 b20) (on b26 b23) (on b33 b26) (on b45 b33) (on b51 b45) (on b52 b51) (on b54 b52) (on b56 b54) (on b64 b56) (on b65 b64) (clear b65)
	(on-table b3) (on b4 b3) (on b8 b4) (on b9 b8) (on b12 b9) (on b14 b12) (on b16 b14) (on b17 b16) (on b29 b17) (on b43 b29) (on b48 b43) (on b55 b48) (on b66 b55) (clear b66)
	(on-table b7) (on b15 b7) (on b18 b15) (on b22 b18) (on b24 b22) (on b35 b24) (on b38 b35) (on b53 b38) (clear b53)
	(on-table b10) (on b13 b10) (on b58 b13) (on b59 b58) (on b68 b59) (clear b68)
	(on-table b19) (on b25 b19) (on b27 b25) (on b31 b27) (on b34 b31) (on b39 b34) (on b40 b39) (on b44 b40) (on b47 b44) (on b50 b47) (on b62 b50) (on b63 b62) (on b67 b63) (clear b67)
	(on-table b21) (on b30 b21) (on b42 b30) (on b46 b42) (on b57 b46) (clear b57)
	(on-table b28) (on b32 b28) (on b36 b32) (on b37 b36) (on b41 b37) (on b49 b41) (clear b49)
	(on-table b60) (on b70 b60) (clear b70)
	(on-table b61) (on b69 b61) (clear b69)
))
)


