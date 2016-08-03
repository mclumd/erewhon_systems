;;---------------------------------------------

(define (problem p80_7)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30 b31 b32 b33 b34 b35 b36 b37 b38 b39 b40 b41 b42 b43 b44 b45 b46 b47 b48 b49 b50 b51 b52 b53 b54 b55 b56 b57 b58 b59 b60 b61 b62 b63 b64 b65 b66 b67 b68 b69 b70 b71 b72 b73 b74 b75 b76 b77 b78 b79 b80)
(:init
	(arm-empty)
	(on-table b1) (on b2 b1) (on b3 b2) (on b4 b3) (on b6 b4) (on b7 b6) (on b13 b7) (on b21 b13) (on b30 b21) (on b32 b30) (on b44 b32) (on b53 b44) (on b56 b53) (on b67 b56) (on b69 b67) (on b73 b69) (clear b73)
	(on-table b5) (on b8 b5) (on b9 b8) (on b12 b9) (on b24 b12) (on b36 b24) (on b37 b36) (on b39 b37) (on b49 b39) (on b64 b49) (on b65 b64) (on b76 b65) (clear b76)
	(on-table b10) (on b15 b10) (on b18 b15) (on b19 b18) (on b25 b19) (on b38 b25) (on b48 b38) (on b54 b48) (on b55 b54) (on b59 b55) (on b60 b59) (on b79 b60) (clear b79)
	(on-table b11) (on b16 b11) (on b27 b16) (on b35 b27) (on b40 b35) (on b46 b40) (on b57 b46) (on b66 b57) (on b78 b66) (clear b78)
	(on-table b14) (on b17 b14) (on b20 b17) (on b34 b20) (on b41 b34) (on b63 b41) (on b71 b63) (on b74 b71) (on b77 b74) (clear b77)
	(on-table b22) (on b23 b22) (on b31 b23) (on b33 b31) (on b80 b33) (clear b80)
	(on-table b26) (on b28 b26) (on b29 b28) (on b42 b29) (on b47 b42) (on b50 b47) (on b52 b50) (on b58 b52) (on b68 b58) (on b72 b68) (clear b72)
	(on-table b43) (on b45 b43) (on b51 b45) (on b61 b51) (on b62 b61) (on b75 b62) (clear b75)
	(on-table b70) (clear b70)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b3 b1) (on b5 b3) (on b15 b5) (on b18 b15) (on b46 b18) (on b55 b46) (on b61 b55) (on b70 b61) (on b77 b70) (clear b77)
	(on-table b2) (on b4 b2) (on b6 b4) (on b11 b6) (on b14 b11) (on b21 b14) (on b29 b21) (on b31 b29) (on b33 b31) (on b35 b33) (on b39 b35) (on b45 b39) (on b48 b45) (on b49 b48) (on b59 b49) (on b78 b59) (clear b78)
	(on-table b7) (on b32 b7) (on b43 b32) (on b58 b43) (on b60 b58) (on b66 b60) (on b67 b66) (on b68 b67) (on b73 b68) (clear b73)
	(on-table b8) (on b9 b8) (on b10 b9) (on b12 b10) (on b13 b12) (on b17 b13) (on b20 b17) (on b24 b20) (on b28 b24) (on b30 b28) (on b34 b30) (on b37 b34) (on b74 b37) (on b75 b74) (on b79 b75) (clear b79)
	(on-table b16) (on b23 b16) (on b25 b23) (on b41 b25) (on b69 b41) (clear b69)
	(on-table b19) (on b36 b19) (on b38 b36) (on b40 b38) (on b42 b40) (on b44 b42) (on b47 b44) (on b57 b47) (on b72 b57) (clear b72)
	(on-table b22) (on b26 b22) (on b27 b26) (on b65 b27) (on b80 b65) (clear b80)
	(on-table b50) (on b56 b50) (clear b56)
	(on-table b51) (on b53 b51) (on b54 b53) (on b63 b54) (on b71 b63) (on b76 b71) (clear b76)
	(on-table b52) (on b62 b52) (clear b62)
	(on-table b64) (clear b64)
))
)


