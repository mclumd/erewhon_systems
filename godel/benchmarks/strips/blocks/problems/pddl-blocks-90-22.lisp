;;---------------------------------------------

(define (problem p90_22)
(:domain blocks)
(:objects  b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30 b31 b32 b33 b34 b35 b36 b37 b38 b39 b40 b41 b42 b43 b44 b45 b46 b47 b48 b49 b50 b51 b52 b53 b54 b55 b56 b57 b58 b59 b60 b61 b62 b63 b64 b65 b66 b67 b68 b69 b70 b71 b72 b73 b74 b75 b76 b77 b78 b79 b80 b81 b82 b83 b84 b85 b86 b87 b88 b89 b90)
(:init
	(arm-empty)
	(on-table b1) (on b3 b1) (on b5 b3) (on b6 b5) (on b7 b6) (on b8 b7) (on b9 b8) (on b11 b9) (on b13 b11) (on b34 b13) (on b35 b34) (on b44 b35) (on b62 b44) (on b68 b62) (on b82 b68) (clear b82)
	(on-table b2) (on b4 b2) (on b10 b4) (on b15 b10) (on b16 b15) (on b17 b16) (on b33 b17) (on b42 b33) (on b45 b42) (on b51 b45) (on b55 b51) (on b57 b55) (on b90 b57) (clear b90)
	(on-table b12) (on b19 b12) (on b27 b19) (on b30 b27) (on b41 b30) (on b72 b41) (on b76 b72) (clear b76)
	(on-table b14) (on b26 b14) (on b36 b26) (on b43 b36) (on b46 b43) (on b49 b46) (on b88 b49) (clear b88)
	(on-table b18) (on b20 b18) (on b22 b20) (on b23 b22) (on b24 b23) (on b25 b24) (on b31 b25) (on b32 b31) (on b63 b32) (on b71 b63) (clear b71)
	(on-table b21) (on b28 b21) (on b40 b28) (on b48 b40) (on b61 b48) (on b70 b61) (clear b70)
	(on-table b29) (on b38 b29) (on b83 b38) (on b85 b83) (clear b85)
	(on-table b37) (on b56 b37) (on b59 b56) (on b60 b59) (on b66 b60) (on b73 b66) (on b75 b73) (on b84 b75) (clear b84)
	(on-table b39) (on b50 b39) (on b52 b50) (on b77 b52) (on b86 b77) (clear b86)
	(on-table b47) (on b53 b47) (on b80 b53) (on b87 b80) (clear b87)
	(on-table b54) (on b58 b54) (on b79 b58) (on b81 b79) (clear b81)
	(on-table b64) (on b65 b64) (on b69 b65) (on b78 b69) (on b89 b78) (clear b89)
	(on-table b67) (on b74 b67) (clear b74)
)
(:goal
	(and (arm-empty)
	(on-table b1) (on b2 b1) (on b4 b2) (on b5 b4) (on b7 b5) (on b9 b7) (on b13 b9) (on b14 b13) (on b79 b14) (on b86 b79) (clear b86)
	(on-table b3) (on b6 b3) (on b8 b6) (on b16 b8) (on b51 b16) (on b71 b51) (clear b71)
	(on-table b10) (on b15 b10) (on b25 b15) (on b31 b25) (on b41 b31) (on b45 b41) (clear b45)
	(on-table b11) (on b12 b11) (on b18 b12) (on b22 b18) (on b39 b22) (on b44 b39) (on b46 b44) (on b50 b46) (on b53 b50) (on b56 b53) (on b65 b56) (on b68 b65) (on b69 b68) (on b78 b69) (on b82 b78) (on b88 b82) (on b89 b88) (clear b89)
	(on-table b17) (on b20 b17) (on b21 b20) (on b29 b21) (on b34 b29) (on b43 b34) (on b62 b43) (on b72 b62) (on b87 b72) (clear b87)
	(on-table b19) (on b23 b19) (on b24 b23) (on b26 b24) (on b27 b26) (on b30 b27) (on b40 b30) (on b42 b40) (on b74 b42) (on b83 b74) (clear b83)
	(on-table b28) (on b32 b28) (on b33 b32) (on b35 b33) (on b77 b35) (on b80 b77) (clear b80)
	(on-table b36) (on b47 b36) (on b57 b47) (on b60 b57) (on b61 b60) (on b63 b61) (on b64 b63) (clear b64)
	(on-table b37) (on b38 b37) (on b58 b38) (on b76 b58) (on b85 b76) (clear b85)
	(on-table b48) (on b49 b48) (on b52 b49) (on b54 b52) (on b55 b54) (on b59 b55) (on b70 b59) (on b90 b70) (clear b90)
	(on-table b66) (on b67 b66) (on b84 b67) (clear b84)
	(on-table b73) (on b75 b73) (on b81 b75) (clear b81)
))
)


