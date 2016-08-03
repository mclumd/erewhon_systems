;;---------------------------------------------

(define (problem p90_10)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30 b31 b32 b33 b34 b35 b36 b37 b38 b39 b40 b41 b42 b43 b44 b45 b46 b47 b48 b49 b50 b51 b52 b53 b54 b55 b56 b57 b58 b59 b60 b61 b62 b63 b64 b65 b66 b67 b68 b69 b70 b71 b72 b73 b74 b75 b76 b77 b78 b79 b80 b81 b82 b83 b84 b85 b86 b87 b88 b89 b90)
(:init
	(arm-empty)
	(on-table b1) (on b7 b1) (on b10 b7) (on b21 b10) (on b23 b21) (on b26 b23) (on b35 b26) (on b45 b35) (on b61 b45) (on b68 b61) (on b79 b68) (on b80 b79) (clear b80)
	(on-table b2) (on b3 b2) (on b16 b3) (on b18 b16) (on b19 b18) (on b25 b19) (on b27 b25) (on b30 b27) (on b31 b30) (on b32 b31) (on b33 b32) (on b36 b33) (on b48 b36) (on b50 b48) (on b59 b50) (on b62 b59) (on b66 b62) (on b67 b66) (on b69 b67) (on b82 b69) (on b84 b82) (on b86 b84) (clear b86)
	(on-table b4) (on b8 b4) (on b12 b8) (on b14 b12) (on b20 b14) (on b24 b20) (on b41 b24) (on b43 b41) (on b46 b43) (on b57 b46) (on b60 b57) (on b77 b60) (clear b77)
	(on-table b5) (on b6 b5) (on b9 b6) (on b11 b9) (on b13 b11) (on b15 b13) (on b17 b15) (on b22 b17) (on b28 b22) (on b52 b28) (on b58 b52) (on b71 b58) (on b83 b71) (on b88 b83) (on b90 b88) (clear b90)
	(on-table b29) (on b38 b29) (on b42 b38) (on b51 b42) (on b76 b51) (clear b76)
	(on-table b34) (on b37 b34) (on b44 b37) (on b54 b44) (on b63 b54) (on b78 b63) (clear b78)
	(on-table b39) (on b40 b39) (on b49 b40) (on b55 b49) (on b56 b55) (on b64 b56) (on b72 b64) (on b81 b72) (clear b81)
	(on-table b47) (on b53 b47) (on b65 b53) (on b70 b65) (on b73 b70) (clear b73)
	(on-table b74) (on b75 b74) (on b85 b75) (on b87 b85) (clear b87)
	(on-table b89) (clear b89)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b3 b1) (on b7 b3) (on b9 b7) (on b10 b9) (on b12 b10) (on b14 b12) (on b23 b14) (on b24 b23) (on b27 b24) (on b32 b27) (on b34 b32) (on b43 b34) (on b46 b43) (on b47 b46) (on b50 b47) (on b52 b50) (on b59 b52) (on b60 b59) (on b61 b60) (on b70 b61) (on b71 b70) (on b74 b71) (on b90 b74) (clear b90)
	(on-table b2) (on b4 b2) (on b5 b4) (on b6 b5) (on b8 b6) (on b11 b8) (on b15 b11) (on b25 b15) (on b26 b25) (on b39 b26) (on b44 b39) (on b45 b44) (on b68 b45) (on b73 b68) (on b81 b73) (on b87 b81) (on b88 b87) (clear b88)
	(on-table b13) (on b16 b13) (on b19 b16) (on b20 b19) (on b31 b20) (on b35 b31) (on b37 b35) (on b40 b37) (on b57 b40) (on b79 b57) (on b86 b79) (clear b86)
	(on-table b17) (on b18 b17) (on b22 b18) (on b41 b22) (on b42 b41) (on b54 b42) (on b63 b54) (on b64 b63) (clear b64)
	(on-table b21) (on b28 b21) (on b30 b28) (on b33 b30) (on b36 b33) (on b51 b36) (on b55 b51) (on b56 b55) (on b62 b56) (on b66 b62) (on b80 b66) (clear b80)
	(on-table b29) (on b38 b29) (on b78 b38) (on b84 b78) (clear b84)
	(on-table b48) (on b58 b48) (on b69 b58) (on b75 b69) (clear b75)
	(on-table b49) (on b53 b49) (on b65 b53) (on b67 b65) (on b72 b67) (on b76 b72) (on b85 b76) (clear b85)
	(on-table b77) (clear b77)
	(on-table b82) (on b89 b82) (clear b89)
	(on-table b83) (clear b83)
))
)

