;;---------------------------------------------

(define (problem p100_13)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30 b31 b32 b33 b34 b35 b36 b37 b38 b39 b40 b41 b42 b43 b44 b45 b46 b47 b48 b49 b50 b51 b52 b53 b54 b55 b56 b57 b58 b59 b60 b61 b62 b63 b64 b65 b66 b67 b68 b69 b70 b71 b72 b73 b74 b75 b76 b77 b78 b79 b80 b81 b82 b83 b84 b85 b86 b87 b88 b89 b90 b91 b92 b93 b94 b95 b96 b97 b98 b99 b100)
(:init
	(arm-empty)
	(on-table b1) (on b4 b1) (on b10 b4) (on b13 b10) (on b14 b13) (on b16 b14) (on b18 b16) (on b24 b18) (on b28 b24) (on b36 b28) (on b44 b36) (on b60 b44) (clear b60)
	(on-table b2) (on b5 b2) (on b6 b5) (on b11 b6) (on b17 b11) (on b21 b17) (on b23 b21) (on b25 b23) (on b26 b25) (on b32 b26) (on b39 b32) (on b40 b39) (on b46 b40) (on b65 b46) (on b66 b65) (on b71 b66) (clear b71)
	(on-table b3) (on b7 b3) (on b9 b7) (on b12 b9) (on b20 b12) (on b22 b20) (on b30 b22) (on b33 b30) (on b42 b33) (on b48 b42) (on b54 b48) (on b61 b54) (on b68 b61) (on b95 b68) (clear b95)
	(on-table b8) (on b27 b8) (on b31 b27) (on b37 b31) (on b41 b37) (on b51 b41) (on b52 b51) (on b56 b52) (on b62 b56) (on b70 b62) (on b100 b70) (clear b100)
	(on-table b15) (on b34 b15) (on b53 b34) (on b58 b53) (on b75 b58) (on b91 b75) (on b97 b91) (on b98 b97) (on b99 b98) (clear b99)
	(on-table b19) (on b29 b19) (on b43 b29) (on b47 b43) (on b57 b47) (on b67 b57) (on b96 b67) (clear b96)
	(on-table b35) (on b45 b35) (on b50 b45) (on b55 b50) (on b63 b55) (on b72 b63) (on b94 b72) (clear b94)
	(on-table b38) (on b79 b38) (on b87 b79) (on b89 b87) (on b90 b89) (clear b90)
	(on-table b49) (on b74 b49) (on b76 b74) (on b80 b76) (clear b80)
	(on-table b59) (on b69 b59) (on b82 b69) (on b92 b82) (clear b92)
	(on-table b64) (on b73 b64) (on b77 b73) (on b81 b77) (clear b81)
	(on-table b78) (on b85 b78) (on b93 b85) (clear b93)
	(on-table b83) (on b84 b83) (clear b84)
	(on-table b86) (clear b86)
	(on-table b88) (clear b88)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b3 b1) (on b5 b3) (on b6 b5) (on b8 b6) (on b12 b8) (on b13 b12) (on b16 b13) (on b19 b16) (on b20 b19) (on b26 b20) (on b28 b26) (on b30 b28) (on b31 b30) (on b32 b31) (on b35 b32) (on b82 b35) (on b84 b82) (clear b84)
	(on-table b2) (on b4 b2) (on b15 b4) (on b18 b15) (on b21 b18) (on b27 b21) (on b38 b27) (on b45 b38) (on b52 b45) (on b53 b52) (on b58 b53) (on b92 b58) (clear b92)
	(on-table b7) (on b23 b7) (on b37 b23) (on b39 b37) (on b42 b39) (on b43 b42) (on b46 b43) (on b51 b46) (on b56 b51) (on b57 b56) (on b72 b57) (on b87 b72) (on b98 b87) (clear b98)
	(on-table b9) (on b14 b9) (on b22 b14) (on b29 b22) (on b36 b29) (on b41 b36) (on b47 b41) (on b49 b47) (on b60 b49) (on b78 b60) (on b81 b78) (on b89 b81) (on b90 b89) (clear b90)
	(on-table b10) (on b11 b10) (on b17 b11) (on b25 b17) (on b33 b25) (on b64 b33) (on b65 b64) (on b68 b65) (on b69 b68) (on b77 b69) (clear b77)
	(on-table b24) (on b34 b24) (on b40 b34) (on b44 b40) (on b62 b44) (on b70 b62) (on b79 b70) (on b93 b79) (clear b93)
	(on-table b48) (on b59 b48) (on b75 b59) (on b94 b75) (clear b94)
	(on-table b50) (on b67 b50) (clear b67)
	(on-table b54) (on b74 b54) (on b91 b74) (clear b91)
	(on-table b55) (on b85 b55) (clear b85)
	(on-table b61) (on b83 b61) (on b97 b83) (clear b97)
	(on-table b63) (on b66 b63) (on b73 b66) (on b88 b73) (on b96 b88) (clear b96)
	(on-table b71) (on b76 b71) (on b80 b76) (on b86 b80) (on b95 b86) (clear b95)
	(on-table b99) (on b100 b99) (clear b100)
))
)

