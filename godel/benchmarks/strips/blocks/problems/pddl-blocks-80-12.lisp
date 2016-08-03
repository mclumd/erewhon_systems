;;---------------------------------------------

(define (problem p80_12)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30 b31 b32 b33 b34 b35 b36 b37 b38 b39 b40 b41 b42 b43 b44 b45 b46 b47 b48 b49 b50 b51 b52 b53 b54 b55 b56 b57 b58 b59 b60 b61 b62 b63 b64 b65 b66 b67 b68 b69 b70 b71 b72 b73 b74 b75 b76 b77 b78 b79 b80)
(:init
	(arm-empty)
	(on-table b1) (on b4 b1) (on b13 b4) (on b19 b13) (on b21 b19) (on b25 b21) (on b40 b25) (on b46 b40) (on b71 b46) (on b80 b71) (clear b80)
	(on-table b2) (on b3 b2) (on b5 b3) (on b6 b5) (on b15 b6) (on b17 b15) (on b18 b17) (on b28 b18) (on b32 b28) (on b33 b32) (on b36 b33) (on b38 b36) (on b39 b38) (on b41 b39) (on b44 b41) (on b45 b44) (on b50 b45) (on b51 b50) (on b70 b51) (on b75 b70) (on b77 b75) (clear b77)
	(on-table b7) (on b8 b7) (on b9 b8) (on b27 b9) (on b30 b27) (on b53 b30) (on b56 b53) (on b61 b56) (on b74 b61) (on b79 b74) (clear b79)
	(on-table b10) (on b14 b10) (on b20 b14) (on b24 b20) (on b42 b24) (on b52 b42) (on b55 b52) (on b60 b55) (on b62 b60) (on b78 b62) (clear b78)
	(on-table b11) (on b12 b11) (on b16 b12) (on b22 b16) (on b23 b22) (on b26 b23) (on b29 b26) (on b47 b29) (on b49 b47) (on b54 b49) (on b66 b54) (on b68 b66) (on b69 b68) (clear b69)
	(on-table b31) (on b34 b31) (on b35 b34) (on b43 b35) (on b48 b43) (on b64 b48) (on b67 b64) (on b76 b67) (clear b76)
	(on-table b37) (on b65 b37) (on b72 b65) (on b73 b72) (clear b73)
	(on-table b57) (on b58 b57) (on b59 b58) (on b63 b59) (clear b63)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b3 b1) (on b6 b3) (on b7 b6) (on b17 b7) (on b23 b17) (on b24 b23) (on b35 b24) (on b40 b35) (on b45 b40) (on b69 b45) (on b72 b69) (on b73 b72) (clear b73)
	(on-table b2) (on b5 b2) (on b8 b5) (on b12 b8) (on b16 b12) (on b42 b16) (on b48 b42) (on b52 b48) (on b57 b52) (clear b57)
	(on-table b4) (on b14 b4) (on b15 b14) (on b20 b15) (on b27 b20) (on b41 b27) (on b56 b41) (on b66 b56) (on b68 b66) (on b70 b68) (clear b70)
	(on-table b9) (on b13 b9) (on b22 b13) (on b25 b22) (on b34 b25) (on b39 b34) (on b46 b39) (clear b46)
	(on-table b10) (on b18 b10) (on b21 b18) (on b36 b21) (on b37 b36) (on b62 b37) (on b78 b62) (clear b78)
	(on-table b11) (on b19 b11) (on b26 b19) (on b32 b26) (on b38 b32) (on b44 b38) (on b47 b44) (on b50 b47) (on b51 b50) (clear b51)
	(on-table b28) (on b29 b28) (on b30 b29) (on b31 b30) (on b33 b31) (on b43 b33) (on b53 b43) (on b54 b53) (on b59 b54) (on b60 b59) (on b75 b60) (on b76 b75) (clear b76)
	(on-table b49) (on b64 b49) (on b71 b64) (on b77 b71) (on b80 b77) (clear b80)
	(on-table b55) (on b58 b55) (on b63 b58) (on b79 b63) (clear b79)
	(on-table b61) (clear b61)
	(on-table b65) (on b67 b65) (on b74 b67) (clear b74)
))
)


