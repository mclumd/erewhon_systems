;;---------------------------------------------

(define (problem p80_17)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30 b31 b32 b33 b34 b35 b36 b37 b38 b39 b40 b41 b42 b43 b44 b45 b46 b47 b48 b49 b50 b51 b52 b53 b54 b55 b56 b57 b58 b59 b60 b61 b62 b63 b64 b65 b66 b67 b68 b69 b70 b71 b72 b73 b74 b75 b76 b77 b78 b79 b80)
(:init
	(arm-empty)
	(on-table b1) (on b7 b1) (on b10 b7) (on b22 b10) (on b23 b22) (on b34 b23) (on b47 b34) (on b54 b47) (on b61 b54) (on b64 b61) (on b67 b64) (on b73 b67) (clear b73)
	(on-table b2) (on b6 b2) (on b9 b6) (on b14 b9) (on b36 b14) (on b41 b36) (on b55 b41) (on b69 b55) (on b79 b69) (clear b79)
	(on-table b3) (on b5 b3) (on b8 b5) (on b12 b8) (on b16 b12) (on b20 b16) (on b27 b20) (clear b27)
	(on-table b4) (on b18 b4) (on b21 b18) (on b25 b21) (on b28 b25) (on b40 b28) (on b45 b40) (on b51 b45) (on b62 b51) (on b63 b62) (on b80 b63) (clear b80)
	(on-table b11) (on b26 b11) (on b31 b26) (on b37 b31) (on b46 b37) (on b52 b46) (on b53 b52) (on b65 b53) (on b66 b65) (on b77 b66) (clear b77)
	(on-table b13) (on b19 b13) (on b29 b19) (on b30 b29) (on b48 b30) (on b50 b48) (on b68 b50) (on b78 b68) (clear b78)
	(on-table b15) (on b17 b15) (on b24 b17) (on b38 b24) (on b49 b38) (on b56 b49) (on b60 b56) (on b70 b60) (clear b70)
	(on-table b32) (on b33 b32) (on b44 b33) (clear b44)
	(on-table b35) (on b43 b35) (on b71 b43) (clear b71)
	(on-table b39) (on b42 b39) (on b57 b42) (clear b57)
	(on-table b58) (on b59 b58) (on b72 b59) (clear b72)
	(on-table b74) (on b75 b74) (clear b75)
	(on-table b76) (clear b76)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b7 b1) (on b8 b7) (on b9 b8) (on b12 b9) (on b22 b12) (on b25 b22) (on b36 b25) (on b65 b36) (clear b65)
	(on-table b2) (on b3 b2) (on b4 b3) (on b5 b4) (on b6 b5) (on b15 b6) (on b23 b15) (on b28 b23) (on b34 b28) (on b35 b34) (on b37 b35) (on b45 b37) (on b47 b45) (on b59 b47) (on b76 b59) (clear b76)
	(on-table b10) (on b11 b10) (on b21 b11) (on b26 b21) (on b42 b26) (on b49 b42) (on b55 b49) (on b68 b55) (on b74 b68) (clear b74)
	(on-table b13) (on b17 b13) (on b18 b17) (on b20 b18) (on b31 b20) (on b77 b31) (clear b77)
	(on-table b14) (on b16 b14) (on b19 b16) (on b24 b19) (on b60 b24) (on b72 b60) (clear b72)
	(on-table b27) (on b29 b27) (on b50 b29) (on b52 b50) (on b73 b52) (clear b73)
	(on-table b30) (on b46 b30) (on b53 b46) (on b57 b53) (on b58 b57) (on b71 b58) (on b80 b71) (clear b80)
	(on-table b32) (on b39 b32) (on b40 b39) (clear b40)
	(on-table b33) (on b44 b33) (on b51 b44) (on b62 b51) (clear b62)
	(on-table b38) (on b41 b38) (on b48 b41) (on b70 b48) (clear b70)
	(on-table b43) (on b54 b43) (on b67 b54) (on b69 b67) (on b78 b69) (clear b78)
	(on-table b56) (on b61 b56) (on b63 b61) (on b75 b63) (clear b75)
	(on-table b64) (on b66 b64) (on b79 b66) (clear b79)
))
)

