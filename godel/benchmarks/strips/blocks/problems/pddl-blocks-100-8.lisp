;;---------------------------------------------

(define (problem p100_8)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30 b31 b32 b33 b34 b35 b36 b37 b38 b39 b40 b41 b42 b43 b44 b45 b46 b47 b48 b49 b50 b51 b52 b53 b54 b55 b56 b57 b58 b59 b60 b61 b62 b63 b64 b65 b66 b67 b68 b69 b70 b71 b72 b73 b74 b75 b76 b77 b78 b79 b80 b81 b82 b83 b84 b85 b86 b87 b88 b89 b90 b91 b92 b93 b94 b95 b96 b97 b98 b99 b100)
(:init
	(arm-empty)
	(on-table b1) (on b3 b1) (on b6 b3) (on b16 b6) (on b17 b16) (on b22 b17) (on b36 b22) (on b50 b36) (on b51 b50) (on b53 b51) (on b64 b53) (on b67 b64) (on b78 b67) (on b83 b78) (on b85 b83) (on b88 b85) (on b92 b88) (on b96 b92) (clear b96)
	(on-table b2) (on b4 b2) (on b5 b4) (on b7 b5) (on b10 b7) (on b11 b10) (on b12 b11) (on b14 b12) (on b15 b14) (on b21 b15) (on b40 b21) (on b45 b40) (on b57 b45) (on b66 b57) (on b68 b66) (on b70 b68) (on b73 b70) (on b80 b73) (on b81 b80) (on b82 b81) (on b89 b82) (on b100 b89) (clear b100)
	(on-table b8) (on b18 b8) (on b19 b18) (on b27 b19) (on b30 b27) (on b42 b30) (on b43 b42) (on b44 b43) (on b47 b44) (on b58 b47) (on b79 b58) (on b84 b79) (on b93 b84) (on b95 b93) (on b99 b95) (clear b99)
	(on-table b9) (on b13 b9) (on b20 b13) (on b24 b20) (on b28 b24) (on b29 b28) (on b33 b29) (on b34 b33) (on b41 b34) (on b48 b41) (on b65 b48) (on b69 b65) (on b72 b69) (on b94 b72) (on b97 b94) (on b98 b97) (clear b98)
	(on-table b23) (on b25 b23) (on b26 b25) (on b31 b26) (on b32 b31) (on b35 b32) (on b37 b35) (on b38 b37) (on b39 b38) (on b49 b39) (on b54 b49) (on b56 b54) (on b62 b56) (on b71 b62) (on b74 b71) (on b90 b74) (on b91 b90) (clear b91)
	(on-table b46) (on b52 b46) (on b55 b52) (on b59 b55) (on b60 b59) (on b61 b60) (on b63 b61) (on b75 b63) (on b76 b75) (on b77 b76) (on b86 b77) (on b87 b86) (clear b87)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b7 b1) (on b9 b7) (on b11 b9) (on b15 b11) (on b16 b15) (on b18 b16) (on b24 b18) (on b41 b24) (on b58 b41) (on b68 b58) (on b72 b68) (on b74 b72) (on b86 b74) (clear b86)
	(on-table b2) (on b3 b2) (on b12 b3) (on b19 b12) (on b25 b19) (on b31 b25) (on b32 b31) (on b34 b32) (on b39 b34) (on b55 b39) (on b57 b55) (on b59 b57) (on b78 b59) (on b80 b78) (clear b80)
	(on-table b4) (on b10 b4) (on b17 b10) (on b30 b17) (on b35 b30) (on b37 b35) (on b52 b37) (on b61 b52) (on b67 b61) (clear b67)
	(on-table b5) (on b8 b5) (on b14 b8) (on b21 b14) (on b48 b21) (on b85 b48) (on b89 b85) (clear b89)
	(on-table b6) (on b20 b6) (on b22 b20) (on b23 b22) (on b38 b23) (on b62 b38) (on b71 b62) (on b81 b71) (on b82 b81) (on b87 b82) (on b90 b87) (on b93 b90) (on b99 b93) (clear b99)
	(on-table b13) (on b26 b13) (on b49 b26) (on b88 b49) (clear b88)
	(on-table b27) (on b42 b27) (on b64 b42) (on b69 b64) (on b75 b69) (clear b75)
	(on-table b28) (on b29 b28) (on b33 b29) (on b43 b33) (clear b43)
	(on-table b36) (on b70 b36) (clear b70)
	(on-table b40) (on b54 b40) (on b56 b54) (on b60 b56) (clear b60)
	(on-table b44) (on b100 b44) (clear b100)
	(on-table b45) (on b51 b45) (on b53 b51) (on b77 b53) (clear b77)
	(on-table b46) (on b63 b46) (on b65 b63) (on b66 b65) (on b76 b66) (on b79 b76) (on b94 b79) (on b98 b94) (clear b98)
	(on-table b47) (on b95 b47) (clear b95)
	(on-table b50) (on b91 b50) (on b96 b91) (clear b96)
	(on-table b73) (on b83 b73) (clear b83)
	(on-table b84) (clear b84)
	(on-table b92) (clear b92)
	(on-table b97) (clear b97)
))
)


