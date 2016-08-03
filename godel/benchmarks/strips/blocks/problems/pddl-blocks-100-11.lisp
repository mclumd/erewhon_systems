;;---------------------------------------------

(define (problem p100_11)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30 b31 b32 b33 b34 b35 b36 b37 b38 b39 b40 b41 b42 b43 b44 b45 b46 b47 b48 b49 b50 b51 b52 b53 b54 b55 b56 b57 b58 b59 b60 b61 b62 b63 b64 b65 b66 b67 b68 b69 b70 b71 b72 b73 b74 b75 b76 b77 b78 b79 b80 b81 b82 b83 b84 b85 b86 b87 b88 b89 b90 b91 b92 b93 b94 b95 b96 b97 b98 b99 b100)
(:init
	(arm-empty)
	(on-table b1) (on b4 b1) (on b24 b4) (on b26 b24) (on b28 b26) (on b32 b28) (on b68 b32) (on b69 b68) (on b72 b69) (clear b72)
	(on-table b2) (on b5 b2) (on b7 b5) (on b15 b7) (on b16 b15) (on b22 b16) (on b25 b22) (on b30 b25) (on b36 b30) (on b37 b36) (on b77 b37) (clear b77)
	(on-table b3) (on b6 b3) (on b9 b6) (on b11 b9) (on b17 b11) (on b44 b17) (on b60 b44) (on b83 b60) (on b87 b83) (on b92 b87) (clear b92)
	(on-table b8) (on b19 b8) (on b39 b19) (on b47 b39) (on b54 b47) (on b80 b54) (on b89 b80) (on b94 b89) (on b95 b94) (clear b95)
	(on-table b10) (on b14 b10) (on b18 b14) (on b21 b18) (on b45 b21) (on b65 b45) (on b74 b65) (on b91 b74) (clear b91)
	(on-table b12) (on b20 b12) (on b29 b20) (on b31 b29) (on b33 b31) (on b46 b33) (on b52 b46) (clear b52)
	(on-table b13) (on b23 b13) (on b27 b23) (on b49 b27) (on b58 b49) (on b61 b58) (on b75 b61) (on b79 b75) (clear b79)
	(on-table b34) (on b42 b34) (on b55 b42) (on b59 b55) (clear b59)
	(on-table b35) (on b38 b35) (on b41 b38) (on b48 b41) (on b97 b48) (clear b97)
	(on-table b40) (on b43 b40) (on b66 b43) (on b71 b66) (on b84 b71) (clear b84)
	(on-table b50) (on b57 b50) (on b93 b57) (clear b93)
	(on-table b51) (on b70 b51) (on b76 b70) (on b81 b76) (on b86 b81) (clear b86)
	(on-table b53) (on b56 b53) (on b62 b56) (on b64 b62) (on b73 b64) (clear b73)
	(on-table b63) (on b99 b63) (on b100 b99) (clear b100)
	(on-table b67) (on b78 b67) (on b82 b78) (on b85 b82) (clear b85)
	(on-table b88) (on b96 b88) (clear b96)
	(on-table b90) (clear b90)
	(on-table b98) (clear b98)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b5 b1) (on b8 b5) (on b10 b8) (on b13 b10) (on b25 b13) (on b26 b25) (on b28 b26) (on b32 b28) (on b33 b32) (on b39 b33) (on b55 b39) (on b56 b55) (on b63 b56) (on b90 b63) (clear b90)
	(on-table b2) (on b3 b2) (on b9 b3) (on b18 b9) (on b20 b18) (on b31 b20) (on b40 b31) (on b42 b40) (on b49 b42) (on b50 b49) (on b52 b50) (on b54 b52) (on b57 b54) (on b96 b57) (on b100 b96) (clear b100)
	(on-table b4) (on b11 b4) (on b35 b11) (on b66 b35) (on b67 b66) (on b70 b67) (on b85 b70) (on b86 b85) (clear b86)
	(on-table b6) (on b16 b6) (on b19 b16) (on b27 b19) (on b36 b27) (on b38 b36) (on b61 b38) (on b64 b61) (clear b64)
	(on-table b7) (on b14 b7) (on b34 b14) (on b53 b34) (on b72 b53) (on b80 b72) (on b98 b80) (clear b98)
	(on-table b12) (on b17 b12) (on b23 b17) (on b43 b23) (on b77 b43) (on b91 b77) (clear b91)
	(on-table b15) (on b44 b15) (on b48 b44) (on b69 b48) (on b71 b69) (on b73 b71) (on b76 b73) (on b81 b76) (clear b81)
	(on-table b21) (on b22 b21) (on b24 b22) (on b29 b24) (on b65 b29) (on b68 b65) (on b84 b68) (on b92 b84) (on b97 b92) (clear b97)
	(on-table b30) (on b46 b30) (on b47 b46) (on b58 b47) (on b62 b58) (on b88 b62) (clear b88)
	(on-table b37) (on b41 b37) (on b45 b41) (on b60 b45) (on b93 b60) (on b99 b93) (clear b99)
	(on-table b51) (on b79 b51) (on b87 b79) (clear b87)
	(on-table b59) (on b74 b59) (on b78 b74) (on b82 b78) (on b89 b82) (clear b89)
	(on-table b75) (on b83 b75) (on b94 b83) (clear b94)
	(on-table b95) (clear b95)
))
)

