;;---------------------------------------------

(define (problem p80_8)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30 b31 b32 b33 b34 b35 b36 b37 b38 b39 b40 b41 b42 b43 b44 b45 b46 b47 b48 b49 b50 b51 b52 b53 b54 b55 b56 b57 b58 b59 b60 b61 b62 b63 b64 b65 b66 b67 b68 b69 b70 b71 b72 b73 b74 b75 b76 b77 b78 b79 b80)
(:init
	(arm-empty)
	(on-table b1) (on b3 b1) (on b17 b3) (on b43 b17) (on b49 b43) (on b55 b49) (on b56 b55) (on b60 b56) (on b71 b60) (clear b71)
	(on-table b2) (on b5 b2) (on b9 b5) (on b28 b9) (on b32 b28) (on b33 b32) (on b46 b33) (on b53 b46) (on b62 b53) (on b64 b62) (on b67 b64) (clear b67)
	(on-table b4) (on b7 b4) (on b8 b7) (on b13 b8) (on b14 b13) (on b18 b14) (on b25 b18) (on b29 b25) (on b35 b29) (on b36 b35) (on b40 b36) (on b50 b40) (on b52 b50) (on b65 b52) (clear b65)
	(on-table b6) (on b10 b6) (on b11 b10) (on b12 b11) (on b15 b12) (on b19 b15) (on b23 b19) (clear b23)
	(on-table b16) (on b21 b16) (on b26 b21) (on b30 b26) (on b42 b30) (on b59 b42) (on b73 b59) (clear b73)
	(on-table b20) (on b31 b20) (on b34 b31) (on b37 b34) (on b39 b37) (on b41 b39) (on b54 b41) (on b61 b54) (on b66 b61) (on b74 b66) (on b76 b74) (on b77 b76) (on b80 b77) (clear b80)
	(on-table b22) (on b27 b22) (on b45 b27) (on b48 b45) (on b75 b48) (on b78 b75) (on b79 b78) (clear b79)
	(on-table b24) (on b38 b24) (on b57 b38) (on b69 b57) (clear b69)
	(on-table b44) (on b47 b44) (on b51 b47) (on b58 b51) (on b63 b58) (on b72 b63) (clear b72)
	(on-table b68) (on b70 b68) (clear b70)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b6 b1) (on b13 b6) (on b21 b13) (on b22 b21) (on b28 b22) (on b31 b28) (on b33 b31) (on b37 b33) (on b73 b37) (clear b73)
	(on-table b2) (on b3 b2) (on b5 b3) (on b7 b5) (on b17 b7) (on b19 b17) (on b20 b19) (on b25 b20) (on b40 b25) (on b55 b40) (on b59 b55) (on b70 b59) (on b71 b70) (on b74 b71) (clear b74)
	(on-table b4) (on b8 b4) (on b10 b8) (on b18 b10) (on b26 b18) (on b27 b26) (on b29 b27) (on b32 b29) (on b36 b32) (on b45 b36) (on b46 b45) (on b47 b46) (on b60 b47) (on b62 b60) (on b75 b62) (on b77 b75) (on b78 b77) (clear b78)
	(on-table b9) (on b11 b9) (on b12 b11) (on b14 b12) (on b15 b14) (on b16 b15) (on b30 b16) (on b34 b30) (on b35 b34) (on b41 b35) (on b43 b41) (on b44 b43) (on b56 b44) (on b69 b56) (clear b69)
	(on-table b23) (on b24 b23) (on b38 b24) (on b52 b38) (on b79 b52) (clear b79)
	(on-table b39) (on b42 b39) (on b64 b42) (on b72 b64) (on b76 b72) (clear b76)
	(on-table b48) (on b51 b48) (on b53 b51) (on b54 b53) (on b61 b54) (on b66 b61) (on b67 b66) (on b68 b67) (clear b68)
	(on-table b49) (on b50 b49) (on b57 b50) (on b63 b57) (clear b63)
	(on-table b58) (on b65 b58) (clear b65)
	(on-table b80) (clear b80)
))
)


