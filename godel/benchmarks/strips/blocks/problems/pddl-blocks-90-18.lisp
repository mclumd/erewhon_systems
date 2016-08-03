;;---------------------------------------------

(define (problem p90_18)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30 b31 b32 b33 b34 b35 b36 b37 b38 b39 b40 b41 b42 b43 b44 b45 b46 b47 b48 b49 b50 b51 b52 b53 b54 b55 b56 b57 b58 b59 b60 b61 b62 b63 b64 b65 b66 b67 b68 b69 b70 b71 b72 b73 b74 b75 b76 b77 b78 b79 b80 b81 b82 b83 b84 b85 b86 b87 b88 b89 b90)
(:init
	(arm-empty)
	(on-table b1) (on b19 b1) (on b20 b19) (on b26 b20) (on b47 b26) (on b65 b47) (on b81 b65) (on b86 b81) (clear b86)
	(on-table b2) (on b16 b2) (on b31 b16) (on b70 b31) (on b82 b70) (on b85 b82) (clear b85)
	(on-table b3) (on b6 b3) (on b7 b6) (on b14 b7) (on b24 b14) (on b55 b24) (on b63 b55) (on b68 b63) (on b80 b68) (clear b80)
	(on-table b4) (on b15 b4) (on b25 b15) (on b38 b25) (on b48 b38) (on b52 b48) (on b62 b52) (on b64 b62) (on b76 b64) (on b89 b76) (clear b89)
	(on-table b5) (on b8 b5) (on b11 b8) (on b13 b11) (on b17 b13) (on b28 b17) (on b43 b28) (on b45 b43) (on b53 b45) (on b54 b53) (on b56 b54) (clear b56)
	(on-table b9) (on b12 b9) (on b22 b12) (on b23 b22) (on b32 b23) (on b34 b32) (on b37 b34) (on b46 b37) (on b51 b46) (on b58 b51) (on b83 b58) (clear b83)
	(on-table b10) (on b18 b10) (on b33 b18) (on b67 b33) (on b74 b67) (on b78 b74) (on b88 b78) (clear b88)
	(on-table b21) (on b35 b21) (on b39 b35) (on b40 b39) (on b50 b40) (clear b50)
	(on-table b27) (on b29 b27) (on b30 b29) (on b36 b30) (on b59 b36) (on b66 b59) (on b75 b66) (clear b75)
	(on-table b41) (on b42 b41) (on b44 b42) (on b49 b44) (on b84 b49) (on b90 b84) (clear b90)
	(on-table b57) (on b61 b57) (on b72 b61) (on b77 b72) (on b87 b77) (clear b87)
	(on-table b60) (on b71 b60) (on b73 b71) (on b79 b73) (clear b79)
	(on-table b69) (clear b69)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b2 b1) (on b5 b2) (on b6 b5) (on b11 b6) (on b20 b11) (on b23 b20) (on b26 b23) (on b33 b26) (on b45 b33) (on b51 b45) (on b52 b51) (on b54 b52) (on b56 b54) (on b64 b56) (on b65 b64) (clear b65)
	(on-table b3) (on b4 b3) (on b8 b4) (on b9 b8) (on b12 b9) (on b14 b12) (on b16 b14) (on b17 b16) (on b29 b17) (on b43 b29) (on b48 b43) (on b55 b48) (on b66 b55) (clear b66)
	(on-table b7) (on b15 b7) (on b18 b15) (on b22 b18) (on b24 b22) (on b35 b24) (on b38 b35) (on b53 b38) (on b72 b53) (on b86 b72) (on b90 b86) (clear b90)
	(on-table b10) (on b13 b10) (on b58 b13) (on b59 b58) (on b68 b59) (on b71 b68) (on b84 b71) (on b88 b84) (clear b88)
	(on-table b19) (on b25 b19) (on b27 b25) (on b31 b27) (on b34 b31) (on b39 b34) (on b40 b39) (on b44 b40) (on b47 b44) (on b50 b47) (on b62 b50) (on b63 b62) (on b67 b63) (on b74 b67) (clear b74)
	(on-table b21) (on b30 b21) (on b42 b30) (on b46 b42) (on b57 b46) (clear b57)
	(on-table b28) (on b32 b28) (on b36 b32) (on b37 b36) (on b41 b37) (on b49 b41) (on b80 b49) (on b82 b80) (clear b82)
	(on-table b60) (on b70 b60) (on b83 b70) (clear b83)
	(on-table b61) (on b69 b61) (on b76 b69) (on b77 b76) (on b81 b77) (clear b81)
	(on-table b73) (on b75 b73) (on b78 b75) (clear b78)
	(on-table b79) (on b87 b79) (clear b87)
	(on-table b85) (clear b85)
	(on-table b89) (clear b89)
))
)


