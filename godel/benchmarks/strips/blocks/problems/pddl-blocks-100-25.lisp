;;---------------------------------------------

(define (problem p100_25)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30 b31 b32 b33 b34 b35 b36 b37 b38 b39 b40 b41 b42 b43 b44 b45 b46 b47 b48 b49 b50 b51 b52 b53 b54 b55 b56 b57 b58 b59 b60 b61 b62 b63 b64 b65 b66 b67 b68 b69 b70 b71 b72 b73 b74 b75 b76 b77 b78 b79 b80 b81 b82 b83 b84 b85 b86 b87 b88 b89 b90 b91 b92 b93 b94 b95 b96 b97 b98 b99 b100)
(:init
	(arm-empty)
	(on-table b1) (on b8 b1) (on b11 b8) (on b35 b11) (on b49 b35) (on b54 b49) (on b70 b54) (on b86 b70) (clear b86)
	(on-table b2) (on b3 b2) (on b6 b3) (on b7 b6) (on b9 b7) (on b10 b9) (on b13 b10) (on b14 b13) (on b23 b14) (on b33 b23) (on b55 b33) (on b64 b55) (on b69 b64) (on b78 b69) (on b80 b78) (clear b80)
	(on-table b4) (on b25 b4) (on b39 b25) (on b51 b39) (on b57 b51) (on b61 b57) (on b77 b61) (on b94 b77) (clear b94)
	(on-table b5) (on b12 b5) (on b16 b12) (on b24 b16) (on b41 b24) (on b44 b41) (on b59 b44) (on b63 b59) (on b66 b63) (on b68 b66) (on b73 b68) (on b85 b73) (on b87 b85) (on b91 b87) (on b95 b91) (clear b95)
	(on-table b15) (on b18 b15) (on b19 b18) (on b30 b19) (on b36 b30) (on b37 b36) (on b40 b37) (on b50 b40) (on b60 b50) (on b81 b60) (on b82 b81) (on b96 b82) (clear b96)
	(on-table b17) (on b27 b17) (on b28 b27) (on b29 b28) (on b31 b29) (on b32 b31) (on b47 b32) (on b52 b47) (on b65 b52) (on b71 b65) (on b83 b71) (on b84 b83) (clear b84)
	(on-table b20) (on b21 b20) (on b22 b21) (on b26 b22) (on b38 b26) (on b67 b38) (clear b67)
	(on-table b34) (on b45 b34) (on b48 b45) (on b56 b48) (on b58 b56) (on b76 b58) (on b97 b76) (clear b97)
	(on-table b42) (on b43 b42) (on b46 b43) (on b53 b46) (on b90 b53) (on b93 b90) (clear b93)
	(on-table b62) (on b74 b62) (on b75 b74) (on b98 b75) (clear b98)
	(on-table b72) (clear b72)
	(on-table b79) (clear b79)
	(on-table b88) (on b92 b88) (clear b92)
	(on-table b89) (on b100 b89) (clear b100)
	(on-table b99) (clear b99)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b3 b1) (on b8 b3) (on b14 b8) (on b22 b14) (on b36 b22) (on b37 b36) (on b40 b37) (on b57 b40) (on b71 b57) (on b97 b71) (clear b97)
	(on-table b2) (on b5 b2) (on b6 b5) (on b11 b6) (on b12 b11) (on b15 b12) (on b16 b15) (on b20 b16) (on b24 b20) (on b28 b24) (on b31 b28) (on b32 b31) (on b64 b32) (on b78 b64) (clear b78)
	(on-table b4) (on b10 b4) (on b18 b10) (on b19 b18) (on b21 b19) (on b34 b21) (on b59 b34) (on b61 b59) (on b67 b61) (on b70 b67) (on b88 b70) (on b91 b88) (clear b91)
	(on-table b7) (on b9 b7) (on b23 b9) (on b25 b23) (on b27 b25) (on b29 b27) (on b50 b29) (on b53 b50) (on b60 b53) (on b84 b60) (clear b84)
	(on-table b13) (on b17 b13) (on b26 b17) (on b39 b26) (on b42 b39) (on b62 b42) (on b66 b62) (on b69 b66) (on b75 b69) (on b80 b75) (on b95 b80) (clear b95)
	(on-table b30) (on b41 b30) (on b44 b41) (on b47 b44) (clear b47)
	(on-table b33) (on b35 b33) (on b52 b35) (on b55 b52) (on b56 b55) (on b72 b56) (on b73 b72) (on b79 b73) (on b100 b79) (clear b100)
	(on-table b38) (on b43 b38) (on b46 b43) (on b54 b46) (on b68 b54) (on b85 b68) (clear b85)
	(on-table b45) (on b49 b45) (on b58 b49) (on b74 b58) (on b82 b74) (on b89 b82) (clear b89)
	(on-table b48) (on b86 b48) (on b90 b86) (on b96 b90) (on b99 b96) (clear b99)
	(on-table b51) (on b63 b51) (on b87 b63) (on b93 b87) (clear b93)
	(on-table b65) (on b76 b65) (on b77 b76) (on b81 b77) (on b94 b81) (on b98 b94) (clear b98)
	(on-table b83) (on b92 b83) (clear b92)
))
)

