;;---------------------------------------------

(define (problem p80_5)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30 b31 b32 b33 b34 b35 b36 b37 b38 b39 b40 b41 b42 b43 b44 b45 b46 b47 b48 b49 b50 b51 b52 b53 b54 b55 b56 b57 b58 b59 b60 b61 b62 b63 b64 b65 b66 b67 b68 b69 b70 b71 b72 b73 b74 b75 b76 b77 b78 b79 b80)
(:init
	(arm-empty)
	(on-table b1) (on b2 b1) (on b13 b2) (on b23 b13) (on b44 b23) (on b50 b44) (clear b50)
	(on-table b3) (on b6 b3) (on b8 b6) (on b17 b8) (on b27 b17) (on b33 b27) (on b34 b33) (on b37 b34) (on b42 b37) (clear b42)
	(on-table b4) (on b10 b4) (on b22 b10) (on b53 b22) (on b66 b53) (clear b66)
	(on-table b5) (on b7 b5) (on b9 b7) (on b14 b9) (on b18 b14) (on b28 b18) (on b43 b28) (on b51 b43) (on b62 b51) (on b64 b62) (clear b64)
	(on-table b11) (on b12 b11) (on b24 b12) (on b40 b24) (on b52 b40) (on b56 b52) (on b57 b56) (on b78 b57) (clear b78)
	(on-table b15) (on b19 b15) (on b21 b19) (on b31 b21) (on b39 b31) (on b45 b39) (on b65 b45) (on b72 b65) (on b79 b72) (clear b79)
	(on-table b16) (on b58 b16) (on b73 b58) (on b80 b73) (clear b80)
	(on-table b20) (on b25 b20) (on b30 b25) (on b32 b30) (on b35 b32) (on b46 b35) (on b48 b46) (on b54 b48) (on b59 b54) (on b69 b59) (clear b69)
	(on-table b26) (on b29 b26) (on b63 b29) (on b70 b63) (on b74 b70) (on b75 b74) (on b76 b75) (clear b76)
	(on-table b36) (on b38 b36) (on b41 b38) (on b47 b41) (on b61 b47) (on b67 b61) (on b68 b67) (on b71 b68) (clear b71)
	(on-table b49) (on b55 b49) (on b60 b55) (clear b60)
	(on-table b77) (clear b77)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b10 b1) (on b11 b10) (on b15 b11) (on b41 b15) (clear b41)
	(on-table b2) (on b3 b2) (on b22 b3) (on b38 b22) (on b53 b38) (on b54 b53) (on b74 b54) (clear b74)
	(on-table b4) (on b5 b4) (on b9 b5) (on b13 b9) (on b16 b13) (on b37 b16) (on b40 b37) (on b68 b40) (on b77 b68) (clear b77)
	(on-table b6) (on b8 b6) (on b34 b8) (on b35 b34) (on b47 b35) (on b50 b47) (on b76 b50) (clear b76)
	(on-table b7) (on b12 b7) (on b14 b12) (on b20 b14) (on b21 b20) (on b32 b21) (on b36 b32) (on b63 b36) (clear b63)
	(on-table b17) (on b18 b17) (on b59 b18) (on b60 b59) (on b71 b60) (on b75 b71) (clear b75)
	(on-table b19) (on b23 b19) (on b26 b23) (on b31 b26) (on b33 b31) (on b39 b33) (on b49 b39) (on b51 b49) (on b57 b51) (clear b57)
	(on-table b24) (on b29 b24) (on b30 b29) (on b42 b30) (on b43 b42) (on b80 b43) (clear b80)
	(on-table b25) (on b27 b25) (on b56 b27) (on b61 b56) (on b64 b61) (clear b64)
	(on-table b28) (on b45 b28) (on b48 b45) (on b65 b48) (on b67 b65) (on b73 b67) (clear b73)
	(on-table b44) (on b46 b44) (on b55 b46) (on b62 b55) (on b66 b62) (on b69 b66) (on b78 b69) (on b79 b78) (clear b79)
	(on-table b52) (on b58 b52) (clear b58)
	(on-table b70) (on b72 b70) (clear b72)
))
)

