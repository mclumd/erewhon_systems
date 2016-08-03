;;---------------------------------------------

(define (problem p80_4)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30 b31 b32 b33 b34 b35 b36 b37 b38 b39 b40 b41 b42 b43 b44 b45 b46 b47 b48 b49 b50 b51 b52 b53 b54 b55 b56 b57 b58 b59 b60 b61 b62 b63 b64 b65 b66 b67 b68 b69 b70 b71 b72 b73 b74 b75 b76 b77 b78 b79 b80)
(:init
	(arm-empty)
	(on-table b1) (on b9 b1) (on b11 b9) (on b12 b11) (on b19 b12) (on b23 b19) (on b24 b23) (on b49 b24) (on b60 b49) (on b64 b60) (on b69 b64) (on b72 b69) (on b74 b72) (clear b74)
	(on-table b2) (on b13 b2) (on b21 b13) (on b27 b21) (on b30 b27) (on b34 b30) (on b38 b34) (on b58 b38) (on b70 b58) (on b80 b70) (clear b80)
	(on-table b3) (on b4 b3) (on b6 b4) (on b8 b6) (on b20 b8) (on b22 b20) (on b25 b22) (on b35 b25) (on b37 b35) (on b45 b37) (on b56 b45) (on b65 b56) (on b76 b65) (on b78 b76) (clear b78)
	(on-table b5) (on b15 b5) (on b16 b15) (on b17 b16) (on b31 b17) (on b32 b31) (on b48 b32) (on b51 b48) (on b75 b51) (on b79 b75) (clear b79)
	(on-table b7) (on b10 b7) (on b14 b10) (on b18 b14) (on b28 b18) (on b42 b28) (on b71 b42) (clear b71)
	(on-table b26) (on b33 b26) (on b46 b33) (on b52 b46) (on b66 b52) (on b67 b66) (clear b67)
	(on-table b29) (on b36 b29) (on b44 b36) (on b47 b44) (on b68 b47) (on b77 b68) (clear b77)
	(on-table b39) (on b40 b39) (on b41 b40) (on b43 b41) (on b61 b43) (on b62 b61) (clear b62)
	(on-table b50) (on b53 b50) (on b54 b53) (on b55 b54) (on b59 b55) (on b63 b59) (on b73 b63) (clear b73)
	(on-table b57) (clear b57)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b2 b1) (on b3 b2) (on b4 b3) (on b5 b4) (on b14 b5) (on b52 b14) (on b54 b52) (on b68 b54) (on b74 b68) (on b76 b74) (clear b76)
	(on-table b6) (on b7 b6) (on b17 b7) (on b22 b17) (on b33 b22) (on b40 b33) (on b50 b40) (on b59 b50) (on b69 b59) (on b70 b69) (clear b70)
	(on-table b8) (on b12 b8) (on b25 b12) (on b30 b25) (on b36 b30) (on b44 b36) (on b48 b44) (on b60 b48) (on b65 b60) (clear b65)
	(on-table b9) (on b10 b9) (on b11 b10) (on b13 b11) (on b16 b13) (on b18 b16) (on b20 b18) (on b24 b20) (on b26 b24) (on b67 b26) (on b73 b67) (on b78 b73) (clear b78)
	(on-table b15) (on b19 b15) (on b21 b19) (on b31 b21) (on b47 b31) (on b63 b47) (on b75 b63) (on b80 b75) (clear b80)
	(on-table b23) (on b28 b23) (on b37 b28) (on b39 b37) (on b58 b39) (on b79 b58) (clear b79)
	(on-table b27) (on b46 b27) (on b56 b46) (on b61 b56) (on b71 b61) (clear b71)
	(on-table b29) (on b35 b29) (on b38 b35) (on b42 b38) (on b43 b42) (on b45 b43) (on b62 b45) (on b72 b62) (on b77 b72) (clear b77)
	(on-table b32) (on b34 b32) (on b49 b34) (on b64 b49) (on b66 b64) (clear b66)
	(on-table b41) (on b51 b41) (clear b51)
	(on-table b53) (on b55 b53) (on b57 b55) (clear b57)
))
)

