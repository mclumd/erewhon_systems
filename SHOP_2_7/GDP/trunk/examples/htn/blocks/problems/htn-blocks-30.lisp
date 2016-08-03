(in-package :shop2)
;;---------------------------------------------

(defproblem p30_1 blocks-htn
(
	(arm-empty)
	(block b1)
	(block b2)
	(block b3)
	(block b4)
	(block b5)
	(block b6)
	(block b7)
	(block b8)
	(block b9)
	(block b10)
	(block b11)
	(block b12)
	(block b13)
	(block b14)
	(block b15)
	(block b16)
	(block b17)
	(block b18)
	(block b19)
	(block b20)
	(block b21)
	(block b22)
	(block b23)
	(block b24)
	(block b25)
	(block b26)
	(block b27)
	(block b28)
	(block b29)
	(block b30)
	(on-table b1) (on b2 b1) (on b3 b2) (on b14 b3) (on b17 b14) (on b23 b17) (on b24 b23) (clear b24)
	(on-table b4) (on b5 b4) (on b6 b5) (on b13 b6) (on b22 b13) (on b26 b22) (on b29 b26) (on b30 b29) (clear b30)
	(on-table b7) (on b11 b7) (on b12 b11) (clear b12)
	(on-table b8) (on b9 b8) (clear b9)
	(on-table b10) (on b27 b10) (clear b27)
	(on-table b15) (on b21 b15) (on b25 b21) (clear b25)
	(on-table b16) (on b19 b16) (clear b19)
	(on-table b18) (on b28 b18) (clear b28)
	(on-table b20) (clear b20)
)
(;Goal Task Network
(achieve-goals (
	(on-table b1) (on b2 b1) (on b13 b2) (on b20 b13) (clear b20)
	(on-table b3) (on b4 b3) (on b5 b4) (on b6 b5) (on b7 b6) (on b11 b7) (on b15 b11) (on b21 b15) (clear b21)
	(on-table b8) (on b12 b8) (on b19 b12) (on b29 b19) (clear b29)
	(on-table b9) (on b10 b9) (on b24 b10) (clear b24)
	(on-table b14) (on b18 b14) (clear b18)
	(on-table b16) (on b17 b16) (on b25 b17) (clear b25)
	(on-table b22) (on b30 b22) (clear b30)
	(on-table b23) (on b26 b23) (on b27 b26) (on b28 b27) (clear b28)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p30_2 blocks-htn
(
	(arm-empty)
	(block b1)
	(block b2)
	(block b3)
	(block b4)
	(block b5)
	(block b6)
	(block b7)
	(block b8)
	(block b9)
	(block b10)
	(block b11)
	(block b12)
	(block b13)
	(block b14)
	(block b15)
	(block b16)
	(block b17)
	(block b18)
	(block b19)
	(block b20)
	(block b21)
	(block b22)
	(block b23)
	(block b24)
	(block b25)
	(block b26)
	(block b27)
	(block b28)
	(block b29)
	(block b30)
	(on-table b1) (on b6 b1) (on b16 b6) (clear b16)
	(on-table b2) (on b4 b2) (on b15 b4) (on b24 b15) (clear b24)
	(on-table b3) (on b7 b3) (on b8 b7) (on b10 b8) (on b12 b10) (on b13 b12) (on b18 b13) (on b25 b18) (on b29 b25) (clear b29)
	(on-table b5) (on b9 b5) (on b11 b9) (on b20 b11) (on b21 b20) (on b23 b21) (clear b23)
	(on-table b14) (on b27 b14) (on b30 b27) (clear b30)
	(on-table b17) (on b19 b17) (on b22 b19) (clear b22)
	(on-table b26) (clear b26)
	(on-table b28) (clear b28)
)
(;Goal Task Network
(achieve-goals (
	(on-table b1) (on b4 b1) (on b7 b4) (on b23 b7) (clear b23)
	(on-table b2) (on b3 b2) (on b11 b3) (on b12 b11) (on b19 b12) (clear b19)
	(on-table b5) (on b6 b5) (on b17 b6) (on b27 b17) (clear b27)
	(on-table b8) (on b9 b8) (on b13 b9) (on b15 b13) (on b22 b15) (on b28 b22) (clear b28)
	(on-table b10) (on b14 b10) (on b29 b14) (on b30 b29) (clear b30)
	(on-table b16) (on b18 b16) (clear b18)
	(on-table b20) (on b24 b20) (on b26 b24) (clear b26)
	(on-table b21) (clear b21)
	(on-table b25) (clear b25)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p30_3 blocks-htn
(
	(arm-empty)
	(block b1)
	(block b2)
	(block b3)
	(block b4)
	(block b5)
	(block b6)
	(block b7)
	(block b8)
	(block b9)
	(block b10)
	(block b11)
	(block b12)
	(block b13)
	(block b14)
	(block b15)
	(block b16)
	(block b17)
	(block b18)
	(block b19)
	(block b20)
	(block b21)
	(block b22)
	(block b23)
	(block b24)
	(block b25)
	(block b26)
	(block b27)
	(block b28)
	(block b29)
	(block b30)
	(on-table b1) (on b2 b1) (on b3 b2) (on b4 b3) (clear b4)
	(on-table b5) (on b16 b5) (on b19 b16) (on b20 b19) (on b26 b20) (clear b26)
	(on-table b6) (on b9 b6) (on b17 b9) (on b22 b17) (clear b22)
	(on-table b7) (on b8 b7) (on b12 b8) (on b14 b12) (on b23 b14) (on b25 b23) (on b29 b25) (clear b29)
	(on-table b10) (on b13 b10) (on b21 b13) (clear b21)
	(on-table b11) (on b15 b11) (on b24 b15) (clear b24)
	(on-table b18) (on b27 b18) (on b28 b27) (clear b28)
	(on-table b30) (clear b30)
)
(;Goal Task Network
(achieve-goals (
	(on-table b1) (on b3 b1) (on b6 b3) (on b10 b6) (on b13 b10) (on b22 b13) (on b26 b22) (on b27 b26) (on b29 b27) (clear b29)
	(on-table b2) (on b8 b2) (on b11 b8) (on b16 b11) (on b20 b16) (clear b20)
	(on-table b4) (on b5 b4) (on b17 b5) (on b21 b17) (clear b21)
	(on-table b7) (on b12 b7) (on b19 b12) (clear b19)
	(on-table b9) (on b15 b9) (on b23 b15) (clear b23)
	(on-table b14) (on b28 b14) (on b30 b28) (clear b30)
	(on-table b18) (on b24 b18) (on b25 b24) (clear b25)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p30_4 blocks-htn
(
	(arm-empty)
	(block b1)
	(block b2)
	(block b3)
	(block b4)
	(block b5)
	(block b6)
	(block b7)
	(block b8)
	(block b9)
	(block b10)
	(block b11)
	(block b12)
	(block b13)
	(block b14)
	(block b15)
	(block b16)
	(block b17)
	(block b18)
	(block b19)
	(block b20)
	(block b21)
	(block b22)
	(block b23)
	(block b24)
	(block b25)
	(block b26)
	(block b27)
	(block b28)
	(block b29)
	(block b30)
	(on-table b1) (on b8 b1) (on b9 b8) (on b12 b9) (on b22 b12) (on b24 b22) (on b25 b24) (clear b25)
	(on-table b2) (on b3 b2) (on b4 b3) (on b11 b4) (on b13 b11) (on b16 b13) (on b27 b16) (on b28 b27) (on b29 b28) (clear b29)
	(on-table b5) (on b6 b5) (on b14 b6) (on b15 b14) (on b30 b15) (clear b30)
	(on-table b7) (on b10 b7) (on b19 b10) (on b26 b19) (clear b26)
	(on-table b17) (on b18 b17) (on b23 b18) (clear b23)
	(on-table b20) (clear b20)
	(on-table b21) (clear b21)
)
(;Goal Task Network
(achieve-goals (
	(on-table b1) (on b14 b1) (clear b14)
	(on-table b2) (on b3 b2) (on b4 b3) (on b6 b4) (on b12 b6) (on b23 b12) (on b27 b23) (clear b27)
	(on-table b5) (on b7 b5) (on b8 b7) (on b11 b8) (on b15 b11) (on b19 b15) (on b20 b19) (clear b20)
	(on-table b9) (on b10 b9) (on b16 b10) (on b17 b16) (on b18 b17) (on b21 b18) (on b22 b21) (on b24 b22) (clear b24)
	(on-table b13) (on b25 b13) (on b26 b25) (on b30 b26) (clear b30)
	(on-table b28) (on b29 b28) (clear b29)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p30_5 blocks-htn
(
	(arm-empty)
	(block b1)
	(block b2)
	(block b3)
	(block b4)
	(block b5)
	(block b6)
	(block b7)
	(block b8)
	(block b9)
	(block b10)
	(block b11)
	(block b12)
	(block b13)
	(block b14)
	(block b15)
	(block b16)
	(block b17)
	(block b18)
	(block b19)
	(block b20)
	(block b21)
	(block b22)
	(block b23)
	(block b24)
	(block b25)
	(block b26)
	(block b27)
	(block b28)
	(block b29)
	(block b30)
	(on-table b1) (on b3 b1) (on b19 b3) (on b23 b19) (on b30 b23) (clear b30)
	(on-table b2) (on b8 b2) (on b9 b8) (on b18 b9) (on b22 b18) (on b25 b22) (on b29 b25) (clear b29)
	(on-table b4) (on b5 b4) (on b6 b5) (on b7 b6) (on b10 b7) (on b13 b10) (on b15 b13) (on b16 b15) (on b17 b16) (on b27 b17) (clear b27)
	(on-table b11) (on b12 b11) (on b26 b12) (clear b26)
	(on-table b14) (clear b14)
	(on-table b20) (on b28 b20) (clear b28)
	(on-table b21) (on b24 b21) (clear b24)
)
(;Goal Task Network
(achieve-goals (
	(on-table b1) (on b3 b1) (on b8 b3) (on b12 b8) (on b22 b12) (clear b22)
	(on-table b2) (on b4 b2) (on b5 b4) (on b6 b5) (on b7 b6) (on b10 b7) (on b24 b10) (on b25 b24) (on b27 b25) (clear b27)
	(on-table b9) (on b11 b9) (on b13 b11) (on b14 b13) (on b15 b14) (on b17 b15) (on b21 b17) (on b29 b21) (clear b29)
	(on-table b16) (on b19 b16) (on b20 b19) (on b28 b20) (clear b28)
	(on-table b18) (on b30 b18) (clear b30)
	(on-table b23) (clear b23)
	(on-table b26) (clear b26)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p30_6 blocks-htn
(
	(arm-empty)
	(block b1)
	(block b2)
	(block b3)
	(block b4)
	(block b5)
	(block b6)
	(block b7)
	(block b8)
	(block b9)
	(block b10)
	(block b11)
	(block b12)
	(block b13)
	(block b14)
	(block b15)
	(block b16)
	(block b17)
	(block b18)
	(block b19)
	(block b20)
	(block b21)
	(block b22)
	(block b23)
	(block b24)
	(block b25)
	(block b26)
	(block b27)
	(block b28)
	(block b29)
	(block b30)
	(on-table b1) (on b5 b1) (on b8 b5) (clear b8)
	(on-table b2) (on b3 b2) (on b6 b3) (on b9 b6) (on b13 b9) (on b15 b13) (on b16 b15) (on b17 b16) (on b20 b17) (on b28 b20) (clear b28)
	(on-table b4) (on b7 b4) (on b14 b7) (on b23 b14) (on b26 b23) (clear b26)
	(on-table b10) (on b11 b10) (on b12 b11) (on b22 b12) (on b24 b22) (on b27 b24) (clear b27)
	(on-table b18) (on b19 b18) (clear b19)
	(on-table b21) (on b25 b21) (clear b25)
	(on-table b29) (clear b29)
	(on-table b30) (clear b30)
)
(;Goal Task Network
(achieve-goals (
	(on-table b1) (on b2 b1) (on b3 b2) (on b10 b3) (on b15 b10) (clear b15)
	(on-table b4) (on b6 b4) (on b8 b6) (on b9 b8) (on b12 b9) (on b13 b12) (on b17 b13) (on b29 b17) (clear b29)
	(on-table b5) (clear b5)
	(on-table b7) (on b16 b7) (on b24 b16) (on b25 b24) (clear b25)
	(on-table b11) (clear b11)
	(on-table b14) (on b23 b14) (on b26 b23) (on b30 b26) (clear b30)
	(on-table b18) (on b19 b18) (clear b19)
	(on-table b20) (on b21 b20) (clear b21)
	(on-table b22) (clear b22)
	(on-table b27) (on b28 b27) (clear b28)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p30_7 blocks-htn
(
	(arm-empty)
	(block b1)
	(block b2)
	(block b3)
	(block b4)
	(block b5)
	(block b6)
	(block b7)
	(block b8)
	(block b9)
	(block b10)
	(block b11)
	(block b12)
	(block b13)
	(block b14)
	(block b15)
	(block b16)
	(block b17)
	(block b18)
	(block b19)
	(block b20)
	(block b21)
	(block b22)
	(block b23)
	(block b24)
	(block b25)
	(block b26)
	(block b27)
	(block b28)
	(block b29)
	(block b30)
	(on-table b1) (on b4 b1) (on b7 b4) (on b8 b7) (on b19 b8) (on b21 b19) (on b22 b21) (on b26 b22) (clear b26)
	(on-table b2) (on b3 b2) (on b5 b3) (on b6 b5) (on b12 b6) (on b14 b12) (on b15 b14) (on b17 b15) (on b23 b17) (on b25 b23) (on b30 b25) (clear b30)
	(on-table b9) (on b13 b9) (clear b13)
	(on-table b10) (on b11 b10) (on b16 b11) (on b18 b16) (on b20 b18) (on b24 b20) (on b28 b24) (clear b28)
	(on-table b27) (on b29 b27) (clear b29)
)
(;Goal Task Network
(achieve-goals (
	(on-table b1) (on b3 b1) (on b4 b3) (on b15 b4) (on b19 b15) (clear b19)
	(on-table b2) (on b9 b2) (clear b9)
	(on-table b5) (on b6 b5) (on b8 b6) (on b12 b8) (on b14 b12) (on b16 b14) (on b25 b16) (on b30 b25) (clear b30)
	(on-table b7) (on b10 b7) (on b13 b10) (on b23 b13) (clear b23)
	(on-table b11) (on b28 b11) (clear b28)
	(on-table b17) (on b24 b17) (on b26 b24) (clear b26)
	(on-table b18) (on b22 b18) (on b27 b22) (clear b27)
	(on-table b20) (clear b20)
	(on-table b21) (clear b21)
	(on-table b29) (clear b29)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p30_8 blocks-htn
(
	(arm-empty)
	(block b1)
	(block b2)
	(block b3)
	(block b4)
	(block b5)
	(block b6)
	(block b7)
	(block b8)
	(block b9)
	(block b10)
	(block b11)
	(block b12)
	(block b13)
	(block b14)
	(block b15)
	(block b16)
	(block b17)
	(block b18)
	(block b19)
	(block b20)
	(block b21)
	(block b22)
	(block b23)
	(block b24)
	(block b25)
	(block b26)
	(block b27)
	(block b28)
	(block b29)
	(block b30)
	(on-table b1) (on b3 b1) (on b15 b3) (on b19 b15) (on b28 b19) (on b30 b28) (clear b30)
	(on-table b2) (on b5 b2) (on b11 b5) (on b21 b11) (on b22 b21) (on b29 b22) (clear b29)
	(on-table b4) (on b7 b4) (on b10 b7) (on b18 b10) (clear b18)
	(on-table b6) (on b9 b6) (on b23 b9) (clear b23)
	(on-table b8) (on b12 b8) (on b13 b12) (on b14 b13) (clear b14)
	(on-table b16) (on b17 b16) (on b20 b17) (on b24 b20) (on b25 b24) (on b26 b25) (on b27 b26) (clear b27)
)
(;Goal Task Network
(achieve-goals (
	(on-table b1) (on b7 b1) (on b8 b7) (clear b8)
	(on-table b2) (on b3 b2) (on b4 b3) (on b5 b4) (on b6 b5) (on b9 b6) (on b18 b9) (on b20 b18) (on b24 b20) (on b26 b24) (clear b26)
	(on-table b10) (on b12 b10) (on b13 b12) (on b15 b13) (on b17 b15) (on b29 b17) (clear b29)
	(on-table b11) (on b14 b11) (on b21 b14) (on b25 b21) (on b28 b25) (clear b28)
	(on-table b16) (on b22 b16) (on b23 b22) (clear b23)
	(on-table b19) (on b27 b19) (on b30 b27) (clear b30)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p30_9 blocks-htn
(
	(arm-empty)
	(block b1)
	(block b2)
	(block b3)
	(block b4)
	(block b5)
	(block b6)
	(block b7)
	(block b8)
	(block b9)
	(block b10)
	(block b11)
	(block b12)
	(block b13)
	(block b14)
	(block b15)
	(block b16)
	(block b17)
	(block b18)
	(block b19)
	(block b20)
	(block b21)
	(block b22)
	(block b23)
	(block b24)
	(block b25)
	(block b26)
	(block b27)
	(block b28)
	(block b29)
	(block b30)
	(on-table b1) (on b9 b1) (on b11 b9) (on b12 b11) (on b19 b12) (on b23 b19) (on b24 b23) (clear b24)
	(on-table b2) (on b13 b2) (on b21 b13) (on b27 b21) (on b30 b27) (clear b30)
	(on-table b3) (on b4 b3) (on b6 b4) (on b8 b6) (on b20 b8) (on b22 b20) (on b25 b22) (clear b25)
	(on-table b5) (on b15 b5) (on b16 b15) (on b17 b16) (clear b17)
	(on-table b7) (on b10 b7) (on b14 b10) (on b18 b14) (on b28 b18) (clear b28)
	(on-table b26) (clear b26)
	(on-table b29) (clear b29)
)
(;Goal Task Network
(achieve-goals (
	(on-table b1) (on b3 b1) (on b4 b3) (on b10 b4) (on b13 b10) (on b22 b13) (clear b22)
	(on-table b2) (on b8 b2) (on b14 b8) (on b17 b14) (on b18 b17) (on b20 b18) (clear b20)
	(on-table b5) (on b6 b5) (on b7 b6) (on b11 b7) (on b12 b11) (on b26 b12) (on b28 b26) (on b30 b28) (clear b30)
	(on-table b9) (on b15 b9) (on b16 b15) (on b19 b16) (on b21 b19) (on b23 b21) (on b24 b23) (on b25 b24) (clear b25)
	(on-table b27) (on b29 b27) (clear b29)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p30_10 blocks-htn
(
	(arm-empty)
	(block b1)
	(block b2)
	(block b3)
	(block b4)
	(block b5)
	(block b6)
	(block b7)
	(block b8)
	(block b9)
	(block b10)
	(block b11)
	(block b12)
	(block b13)
	(block b14)
	(block b15)
	(block b16)
	(block b17)
	(block b18)
	(block b19)
	(block b20)
	(block b21)
	(block b22)
	(block b23)
	(block b24)
	(block b25)
	(block b26)
	(block b27)
	(block b28)
	(block b29)
	(block b30)
	(on-table b1) (on b2 b1) (on b5 b2) (on b6 b5) (on b10 b6) (on b12 b10) (on b13 b12) (on b14 b13) (on b16 b14) (on b17 b16) (on b18 b17) (on b19 b18) (on b21 b19) (on b22 b21) (on b23 b22) (on b25 b23) (on b28 b25) (on b29 b28) (clear b29)
	(on-table b3) (on b4 b3) (on b7 b4) (on b8 b7) (on b9 b8) (on b11 b9) (on b26 b11) (clear b26)
	(on-table b15) (on b20 b15) (on b24 b20) (clear b24)
	(on-table b27) (on b30 b27) (clear b30)
)
(;Goal Task Network
(achieve-goals (
	(on-table b1) (on b2 b1) (on b3 b2) (on b5 b3) (on b6 b5) (on b8 b6) (on b10 b8) (on b15 b10) (on b22 b15) (on b27 b22) (on b29 b27) (clear b29)
	(on-table b4) (on b7 b4) (on b9 b7) (on b11 b9) (on b12 b11) (on b14 b12) (on b16 b14) (on b18 b16) (on b20 b18) (on b21 b20) (on b23 b21) (on b30 b23) (clear b30)
	(on-table b13) (on b17 b13) (on b25 b17) (on b26 b25) (on b28 b26) (clear b28)
	(on-table b19) (on b24 b19) (clear b24)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p30_11 blocks-htn
(
	(arm-empty)
	(block b1)
	(block b2)
	(block b3)
	(block b4)
	(block b5)
	(block b6)
	(block b7)
	(block b8)
	(block b9)
	(block b10)
	(block b11)
	(block b12)
	(block b13)
	(block b14)
	(block b15)
	(block b16)
	(block b17)
	(block b18)
	(block b19)
	(block b20)
	(block b21)
	(block b22)
	(block b23)
	(block b24)
	(block b25)
	(block b26)
	(block b27)
	(block b28)
	(block b29)
	(block b30)
	(on-table b1) (on b5 b1) (on b8 b5) (on b9 b8) (on b23 b9) (on b24 b23) (on b28 b24) (clear b28)
	(on-table b2) (on b3 b2) (on b15 b3) (on b30 b15) (clear b30)
	(on-table b4) (on b6 b4) (on b7 b6) (on b12 b7) (on b17 b12) (on b20 b17) (on b25 b20) (clear b25)
	(on-table b10) (on b22 b10) (on b27 b22) (clear b27)
	(on-table b11) (on b26 b11) (clear b26)
	(on-table b13) (on b14 b13) (on b18 b14) (on b19 b18) (on b29 b19) (clear b29)
	(on-table b16) (on b21 b16) (clear b21)
)
(;Goal Task Network
(achieve-goals (
	(on-table b1) (on b3 b1) (on b4 b3) (on b6 b4) (on b8 b6) (on b10 b8) (on b11 b10) (on b23 b11) (clear b23)
	(on-table b2) (on b5 b2) (on b7 b5) (on b13 b7) (on b16 b13) (on b18 b16) (on b27 b18) (clear b27)
	(on-table b9) (on b12 b9) (on b14 b12) (on b20 b14) (clear b20)
	(on-table b15) (on b17 b15) (on b19 b17) (on b24 b19) (on b28 b24) (clear b28)
	(on-table b21) (on b22 b21) (clear b22)
	(on-table b25) (on b29 b25) (clear b29)
	(on-table b26) (clear b26)
	(on-table b30) (clear b30)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p30_12 blocks-htn
(
	(arm-empty)
	(block b1)
	(block b2)
	(block b3)
	(block b4)
	(block b5)
	(block b6)
	(block b7)
	(block b8)
	(block b9)
	(block b10)
	(block b11)
	(block b12)
	(block b13)
	(block b14)
	(block b15)
	(block b16)
	(block b17)
	(block b18)
	(block b19)
	(block b20)
	(block b21)
	(block b22)
	(block b23)
	(block b24)
	(block b25)
	(block b26)
	(block b27)
	(block b28)
	(block b29)
	(block b30)
	(on-table b1) (on b2 b1) (on b11 b2) (on b18 b11) (clear b18)
	(on-table b3) (on b4 b3) (on b5 b4) (on b13 b5) (on b14 b13) (on b21 b14) (on b25 b21) (clear b25)
	(on-table b6) (on b10 b6) (on b12 b10) (on b15 b12) (on b24 b15) (on b29 b24) (clear b29)
	(on-table b7) (on b8 b7) (on b9 b8) (on b17 b9) (on b28 b17) (clear b28)
	(on-table b16) (on b30 b16) (clear b30)
	(on-table b19) (on b22 b19) (clear b22)
	(on-table b20) (on b23 b20) (on b26 b23) (on b27 b26) (clear b27)
)
(;Goal Task Network
(achieve-goals (
	(on-table b1) (on b2 b1) (on b3 b2) (on b8 b3) (on b11 b8) (on b12 b11) (on b15 b12) (on b16 b15) (on b18 b16) (on b25 b18) (clear b25)
	(on-table b4) (on b5 b4) (on b6 b5) (on b7 b6) (on b9 b7) (on b10 b9) (on b24 b10) (on b29 b24) (clear b29)
	(on-table b13) (on b20 b13) (on b30 b20) (clear b30)
	(on-table b14) (on b17 b14) (on b21 b17) (clear b21)
	(on-table b19) (on b23 b19) (on b26 b23) (on b28 b26) (clear b28)
	(on-table b22) (clear b22)
	(on-table b27) (clear b27)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p30_13 blocks-htn
(
	(arm-empty)
	(block b1)
	(block b2)
	(block b3)
	(block b4)
	(block b5)
	(block b6)
	(block b7)
	(block b8)
	(block b9)
	(block b10)
	(block b11)
	(block b12)
	(block b13)
	(block b14)
	(block b15)
	(block b16)
	(block b17)
	(block b18)
	(block b19)
	(block b20)
	(block b21)
	(block b22)
	(block b23)
	(block b24)
	(block b25)
	(block b26)
	(block b27)
	(block b28)
	(block b29)
	(block b30)
	(on-table b1) (on b10 b1) (on b11 b10) (on b15 b11) (clear b15)
	(on-table b2) (on b3 b2) (on b22 b3) (clear b22)
	(on-table b4) (on b5 b4) (on b9 b5) (on b13 b9) (on b16 b13) (clear b16)
	(on-table b6) (on b8 b6) (clear b8)
	(on-table b7) (on b12 b7) (on b14 b12) (on b20 b14) (on b21 b20) (clear b21)
	(on-table b17) (on b18 b17) (clear b18)
	(on-table b19) (on b23 b19) (on b26 b23) (clear b26)
	(on-table b24) (on b29 b24) (on b30 b29) (clear b30)
	(on-table b25) (on b27 b25) (clear b27)
	(on-table b28) (clear b28)
)
(;Goal Task Network
(achieve-goals (
	(on-table b1) (on b3 b1) (on b4 b3) (on b5 b4) (on b12 b5) (on b13 b12) (on b21 b13) (clear b21)
	(on-table b2) (on b15 b2) (clear b15)
	(on-table b6) (on b8 b6) (on b14 b8) (on b24 b14) (on b25 b24) (clear b25)
	(on-table b7) (on b18 b7) (on b19 b18) (on b29 b19) (clear b29)
	(on-table b9) (on b26 b9) (on b27 b26) (on b30 b27) (clear b30)
	(on-table b10) (on b22 b10) (clear b22)
	(on-table b11) (on b16 b11) (on b20 b16) (on b23 b20) (on b28 b23) (clear b28)
	(on-table b17) (clear b17)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p30_14 blocks-htn
(
	(arm-empty)
	(block b1)
	(block b2)
	(block b3)
	(block b4)
	(block b5)
	(block b6)
	(block b7)
	(block b8)
	(block b9)
	(block b10)
	(block b11)
	(block b12)
	(block b13)
	(block b14)
	(block b15)
	(block b16)
	(block b17)
	(block b18)
	(block b19)
	(block b20)
	(block b21)
	(block b22)
	(block b23)
	(block b24)
	(block b25)
	(block b26)
	(block b27)
	(block b28)
	(block b29)
	(block b30)
	(on-table b1) (on b2 b1) (on b20 b2) (on b27 b20) (on b28 b27) (clear b28)
	(on-table b3) (on b4 b3) (on b8 b4) (on b9 b8) (on b11 b9) (on b24 b11) (clear b24)
	(on-table b5) (on b7 b5) (on b10 b7) (on b17 b10) (clear b17)
	(on-table b6) (on b13 b6) (on b14 b13) (on b16 b14) (on b18 b16) (on b19 b18) (on b26 b19) (clear b26)
	(on-table b12) (on b23 b12) (on b29 b23) (on b30 b29) (clear b30)
	(on-table b15) (on b21 b15) (on b22 b21) (on b25 b22) (clear b25)
)
(;Goal Task Network
(achieve-goals (
	(on-table b1) (on b4 b1) (on b5 b4) (on b8 b5) (on b15 b8) (on b20 b15) (on b30 b20) (clear b30)
	(on-table b2) (on b3 b2) (on b7 b3) (on b11 b7) (on b12 b11) (on b17 b12) (on b21 b17) (on b26 b21) (clear b26)
	(on-table b6) (on b9 b6) (on b14 b9) (on b23 b14) (on b24 b23) (clear b24)
	(on-table b10) (clear b10)
	(on-table b13) (on b28 b13) (on b29 b28) (clear b29)
	(on-table b16) (on b18 b16) (clear b18)
	(on-table b19) (clear b19)
	(on-table b22) (on b25 b22) (on b27 b25) (clear b27)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p30_15 blocks-htn
(
	(arm-empty)
	(block b1)
	(block b2)
	(block b3)
	(block b4)
	(block b5)
	(block b6)
	(block b7)
	(block b8)
	(block b9)
	(block b10)
	(block b11)
	(block b12)
	(block b13)
	(block b14)
	(block b15)
	(block b16)
	(block b17)
	(block b18)
	(block b19)
	(block b20)
	(block b21)
	(block b22)
	(block b23)
	(block b24)
	(block b25)
	(block b26)
	(block b27)
	(block b28)
	(block b29)
	(block b30)
	(on-table b1) (on b3 b1) (on b27 b3) (on b29 b27) (clear b29)
	(on-table b2) (on b4 b2) (on b10 b4) (on b15 b10) (on b17 b15) (clear b17)
	(on-table b5) (on b11 b5) (on b19 b11) (clear b19)
	(on-table b6) (on b9 b6) (on b16 b9) (on b18 b16) (clear b18)
	(on-table b7) (on b12 b7) (on b20 b12) (on b21 b20) (on b22 b21) (on b23 b22) (on b28 b23) (on b30 b28) (clear b30)
	(on-table b8) (on b13 b8) (on b26 b13) (clear b26)
	(on-table b14) (clear b14)
	(on-table b24) (on b25 b24) (clear b25)
)
(;Goal Task Network
(achieve-goals (
	(on-table b1) (on b4 b1) (on b7 b4) (on b11 b7) (on b13 b11) (on b19 b13) (clear b19)
	(on-table b2) (on b10 b2) (on b12 b10) (on b21 b12) (clear b21)
	(on-table b3) (clear b3)
	(on-table b5) (on b17 b5) (on b23 b17) (on b26 b23) (clear b26)
	(on-table b6) (on b8 b6) (on b14 b8) (on b16 b14) (on b18 b16) (clear b18)
	(on-table b9) (on b22 b9) (on b25 b22) (on b27 b25) (clear b27)
	(on-table b15) (on b20 b15) (on b24 b20) (clear b24)
	(on-table b28) (clear b28)
	(on-table b29) (on b30 b29) (clear b30)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p30_16 blocks-htn
(
	(arm-empty)
	(block b1)
	(block b2)
	(block b3)
	(block b4)
	(block b5)
	(block b6)
	(block b7)
	(block b8)
	(block b9)
	(block b10)
	(block b11)
	(block b12)
	(block b13)
	(block b14)
	(block b15)
	(block b16)
	(block b17)
	(block b18)
	(block b19)
	(block b20)
	(block b21)
	(block b22)
	(block b23)
	(block b24)
	(block b25)
	(block b26)
	(block b27)
	(block b28)
	(block b29)
	(block b30)
	(on-table b1) (on b2 b1) (on b3 b2) (on b6 b3) (on b7 b6) (on b9 b7) (on b11 b9) (on b12 b11) (on b14 b12) (on b15 b14) (on b18 b15) (on b19 b18) (on b27 b19) (clear b27)
	(on-table b4) (on b5 b4) (on b16 b5) (on b17 b16) (on b22 b17) (on b25 b22) (clear b25)
	(on-table b8) (on b13 b8) (on b20 b13) (on b21 b20) (on b28 b21) (clear b28)
	(on-table b10) (on b30 b10) (clear b30)
	(on-table b23) (clear b23)
	(on-table b24) (clear b24)
	(on-table b26) (on b29 b26) (clear b29)
)
(;Goal Task Network
(achieve-goals (
	(on-table b1) (on b2 b1) (on b3 b2) (on b4 b3) (on b5 b4) (on b8 b5) (on b23 b8) (clear b23)
	(on-table b6) (on b13 b6) (on b25 b13) (clear b25)
	(on-table b7) (on b9 b7) (on b14 b9) (clear b14)
	(on-table b10) (on b15 b10) (on b26 b15) (clear b26)
	(on-table b11) (on b12 b11) (on b16 b12) (clear b16)
	(on-table b17) (on b24 b17) (clear b24)
	(on-table b18) (on b29 b18) (clear b29)
	(on-table b19) (on b22 b19) (on b27 b22) (clear b27)
	(on-table b20) (on b21 b20) (on b28 b21) (on b30 b28) (clear b30)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p30_17 blocks-htn
(
	(arm-empty)
	(block b1)
	(block b2)
	(block b3)
	(block b4)
	(block b5)
	(block b6)
	(block b7)
	(block b8)
	(block b9)
	(block b10)
	(block b11)
	(block b12)
	(block b13)
	(block b14)
	(block b15)
	(block b16)
	(block b17)
	(block b18)
	(block b19)
	(block b20)
	(block b21)
	(block b22)
	(block b23)
	(block b24)
	(block b25)
	(block b26)
	(block b27)
	(block b28)
	(block b29)
	(block b30)
	(on-table b1) (on b2 b1) (on b3 b2) (on b4 b3) (on b6 b4) (on b7 b6) (on b13 b7) (on b21 b13) (on b30 b21) (clear b30)
	(on-table b5) (on b8 b5) (on b9 b8) (on b12 b9) (on b24 b12) (clear b24)
	(on-table b10) (on b15 b10) (on b18 b15) (on b19 b18) (on b25 b19) (clear b25)
	(on-table b11) (on b16 b11) (on b27 b16) (clear b27)
	(on-table b14) (on b17 b14) (on b20 b17) (clear b20)
	(on-table b22) (on b23 b22) (clear b23)
	(on-table b26) (on b28 b26) (on b29 b28) (clear b29)
)
(;Goal Task Network
(achieve-goals (
	(on-table b1) (on b2 b1) (on b7 b2) (on b9 b7) (on b10 b9) (on b12 b10) (on b14 b12) (on b16 b14) (on b20 b16) (on b23 b20) (clear b23)
	(on-table b3) (on b21 b3) (clear b21)
	(on-table b4) (on b11 b4) (on b18 b11) (on b29 b18) (on b30 b29) (clear b30)
	(on-table b5) (on b6 b5) (on b8 b6) (on b17 b8) (on b22 b17) (on b26 b22) (clear b26)
	(on-table b13) (on b15 b13) (on b19 b15) (clear b19)
	(on-table b24) (clear b24)
	(on-table b25) (on b28 b25) (clear b28)
	(on-table b27) (clear b27)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p30_18 blocks-htn
(
	(arm-empty)
	(block b1)
	(block b2)
	(block b3)
	(block b4)
	(block b5)
	(block b6)
	(block b7)
	(block b8)
	(block b9)
	(block b10)
	(block b11)
	(block b12)
	(block b13)
	(block b14)
	(block b15)
	(block b16)
	(block b17)
	(block b18)
	(block b19)
	(block b20)
	(block b21)
	(block b22)
	(block b23)
	(block b24)
	(block b25)
	(block b26)
	(block b27)
	(block b28)
	(block b29)
	(block b30)
	(on-table b1) (on b6 b1) (on b7 b6) (on b8 b7) (on b9 b8) (on b11 b9) (on b12 b11) (on b13 b12) (on b14 b13) (on b19 b14) (on b21 b19) (clear b21)
	(on-table b2) (on b3 b2) (on b4 b3) (on b5 b4) (on b15 b5) (on b16 b15) (on b18 b16) (on b20 b18) (on b22 b20) (on b23 b22) (on b26 b23) (on b27 b26) (clear b27)
	(on-table b10) (on b17 b10) (on b24 b17) (clear b24)
	(on-table b25) (on b28 b25) (on b29 b28) (on b30 b29) (clear b30)
)
(;Goal Task Network
(achieve-goals (
	(on-table b1) (on b2 b1) (on b3 b2) (on b12 b3) (on b13 b12) (on b26 b13) (clear b26)
	(on-table b4) (on b8 b4) (on b14 b8) (on b20 b14) (on b27 b20) (on b29 b27) (clear b29)
	(on-table b5) (on b15 b5) (on b16 b15) (on b17 b16) (on b22 b17) (on b24 b22) (clear b24)
	(on-table b6) (on b7 b6) (on b10 b7) (on b18 b10) (on b19 b18) (on b21 b19) (on b28 b21) (clear b28)
	(on-table b9) (on b11 b9) (on b25 b11) (on b30 b25) (clear b30)
	(on-table b23) (clear b23)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p30_19 blocks-htn
(
	(arm-empty)
	(block b1)
	(block b2)
	(block b3)
	(block b4)
	(block b5)
	(block b6)
	(block b7)
	(block b8)
	(block b9)
	(block b10)
	(block b11)
	(block b12)
	(block b13)
	(block b14)
	(block b15)
	(block b16)
	(block b17)
	(block b18)
	(block b19)
	(block b20)
	(block b21)
	(block b22)
	(block b23)
	(block b24)
	(block b25)
	(block b26)
	(block b27)
	(block b28)
	(block b29)
	(block b30)
	(on-table b1) (on b6 b1) (on b16 b6) (clear b16)
	(on-table b2) (on b4 b2) (on b5 b4) (on b7 b5) (on b8 b7) (on b9 b8) (on b15 b9) (on b19 b15) (clear b19)
	(on-table b3) (on b11 b3) (on b18 b11) (on b20 b18) (on b27 b20) (on b28 b27) (clear b28)
	(on-table b10) (on b22 b10) (on b24 b22) (clear b24)
	(on-table b12) (on b17 b12) (on b21 b17) (on b29 b21) (on b30 b29) (clear b30)
	(on-table b13) (on b14 b13) (clear b14)
	(on-table b23) (on b25 b23) (on b26 b25) (clear b26)
)
(;Goal Task Network
(achieve-goals (
	(on-table b1) (on b7 b1) (on b8 b7) (on b10 b8) (on b13 b10) (on b17 b13) (clear b17)
	(on-table b2) (on b6 b2) (on b21 b6) (on b22 b21) (on b29 b22) (on b30 b29) (clear b30)
	(on-table b3) (on b5 b3) (on b14 b5) (on b16 b14) (on b20 b16) (clear b20)
	(on-table b4) (on b12 b4) (on b25 b12) (clear b25)
	(on-table b9) (on b11 b9) (on b27 b11) (clear b27)
	(on-table b15) (on b18 b15) (on b19 b18) (on b24 b19) (clear b24)
	(on-table b23) (on b26 b23) (on b28 b26) (clear b28)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p30_20 blocks-htn
(
	(arm-empty)
	(block b1)
	(block b2)
	(block b3)
	(block b4)
	(block b5)
	(block b6)
	(block b7)
	(block b8)
	(block b9)
	(block b10)
	(block b11)
	(block b12)
	(block b13)
	(block b14)
	(block b15)
	(block b16)
	(block b17)
	(block b18)
	(block b19)
	(block b20)
	(block b21)
	(block b22)
	(block b23)
	(block b24)
	(block b25)
	(block b26)
	(block b27)
	(block b28)
	(block b29)
	(block b30)
	(on-table b1) (on b2 b1) (on b27 b2) (on b28 b27) (clear b28)
	(on-table b3) (on b8 b3) (on b12 b8) (on b13 b12) (on b20 b13) (on b23 b20) (on b24 b23) (clear b24)
	(on-table b4) (on b5 b4) (on b9 b5) (on b11 b9) (on b14 b11) (on b15 b14) (on b25 b15) (on b30 b25) (clear b30)
	(on-table b6) (on b18 b6) (clear b18)
	(on-table b7) (on b10 b7) (on b17 b10) (on b22 b17) (on b29 b22) (clear b29)
	(on-table b16) (on b19 b16) (on b26 b19) (clear b26)
	(on-table b21) (clear b21)
)
(;Goal Task Network
(achieve-goals (
	(on-table b1) (on b2 b1) (on b5 b2) (on b6 b5) (on b27 b6) (clear b27)
	(on-table b3) (on b11 b3) (on b12 b11) (on b22 b12) (on b26 b22) (clear b26)
	(on-table b4) (on b10 b4) (on b20 b10) (on b24 b20) (on b25 b24) (on b29 b25) (clear b29)
	(on-table b7) (on b8 b7) (on b14 b8) (on b19 b14) (on b28 b19) (clear b28)
	(on-table b9) (on b13 b9) (on b15 b13) (on b18 b15) (clear b18)
	(on-table b16) (on b17 b16) (on b21 b17) (on b30 b21) (clear b30)
	(on-table b23) (clear b23)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p30_21 blocks-htn
(
	(arm-empty)
	(block b1)
	(block b2)
	(block b3)
	(block b4)
	(block b5)
	(block b6)
	(block b7)
	(block b8)
	(block b9)
	(block b10)
	(block b11)
	(block b12)
	(block b13)
	(block b14)
	(block b15)
	(block b16)
	(block b17)
	(block b18)
	(block b19)
	(block b20)
	(block b21)
	(block b22)
	(block b23)
	(block b24)
	(block b25)
	(block b26)
	(block b27)
	(block b28)
	(block b29)
	(block b30)
	(on-table b1) (on b6 b1) (on b13 b6) (on b21 b13) (on b22 b21) (on b28 b22) (clear b28)
	(on-table b2) (on b3 b2) (on b5 b3) (on b7 b5) (on b17 b7) (on b19 b17) (on b20 b19) (on b25 b20) (clear b25)
	(on-table b4) (on b8 b4) (on b10 b8) (on b18 b10) (on b26 b18) (on b27 b26) (on b29 b27) (clear b29)
	(on-table b9) (on b11 b9) (on b12 b11) (on b14 b12) (on b15 b14) (on b16 b15) (on b30 b16) (clear b30)
	(on-table b23) (on b24 b23) (clear b24)
)
(;Goal Task Network
(achieve-goals (
	(on-table b1) (on b2 b1) (on b3 b2) (on b5 b3) (on b12 b5) (clear b12)
	(on-table b4) (on b25 b4) (on b29 b25) (clear b29)
	(on-table b6) (on b7 b6) (on b8 b7) (on b10 b8) (on b15 b10) (on b16 b15) (on b17 b16) (on b30 b17) (clear b30)
	(on-table b9) (on b14 b9) (on b26 b14) (clear b26)
	(on-table b11) (on b22 b11) (clear b22)
	(on-table b13) (clear b13)
	(on-table b18) (on b21 b18) (on b23 b21) (on b24 b23) (clear b24)
	(on-table b19) (on b20 b19) (on b27 b20) (clear b27)
	(on-table b28) (clear b28)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p30_22 blocks-htn
(
	(arm-empty)
	(block b1)
	(block b2)
	(block b3)
	(block b4)
	(block b5)
	(block b6)
	(block b7)
	(block b8)
	(block b9)
	(block b10)
	(block b11)
	(block b12)
	(block b13)
	(block b14)
	(block b15)
	(block b16)
	(block b17)
	(block b18)
	(block b19)
	(block b20)
	(block b21)
	(block b22)
	(block b23)
	(block b24)
	(block b25)
	(block b26)
	(block b27)
	(block b28)
	(block b29)
	(block b30)
	(on-table b1) (on b2 b1) (on b6 b2) (on b12 b6) (on b13 b12) (on b16 b13) (on b29 b16) (clear b29)
	(on-table b3) (on b10 b3) (on b11 b10) (on b14 b11) (on b25 b14) (clear b25)
	(on-table b4) (on b5 b4) (on b7 b5) (on b8 b7) (on b15 b8) (on b17 b15) (on b18 b17) (on b23 b18) (clear b23)
	(on-table b9) (on b21 b9) (on b28 b21) (clear b28)
	(on-table b19) (on b24 b19) (on b30 b24) (clear b30)
	(on-table b20) (on b22 b20) (clear b22)
	(on-table b26) (on b27 b26) (clear b27)
)
(;Goal Task Network
(achieve-goals (
	(on-table b1) (on b6 b1) (on b8 b6) (on b16 b8) (on b17 b16) (on b27 b17) (on b28 b27) (clear b28)
	(on-table b2) (on b3 b2) (on b5 b3) (on b20 b5) (on b24 b20) (on b25 b24) (on b30 b25) (clear b30)
	(on-table b4) (on b7 b4) (on b10 b7) (on b13 b10) (on b29 b13) (clear b29)
	(on-table b9) (on b22 b9) (clear b22)
	(on-table b11) (on b12 b11) (on b18 b12) (on b21 b18) (on b23 b21) (clear b23)
	(on-table b14) (on b15 b14) (clear b15)
	(on-table b19) (on b26 b19) (clear b26)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p30_23 blocks-htn
(
	(arm-empty)
	(block b1)
	(block b2)
	(block b3)
	(block b4)
	(block b5)
	(block b6)
	(block b7)
	(block b8)
	(block b9)
	(block b10)
	(block b11)
	(block b12)
	(block b13)
	(block b14)
	(block b15)
	(block b16)
	(block b17)
	(block b18)
	(block b19)
	(block b20)
	(block b21)
	(block b22)
	(block b23)
	(block b24)
	(block b25)
	(block b26)
	(block b27)
	(block b28)
	(block b29)
	(block b30)
	(on-table b1) (on b9 b1) (on b22 b9) (clear b22)
	(on-table b2) (on b3 b2) (on b5 b3) (on b10 b5) (on b14 b10) (on b30 b14) (clear b30)
	(on-table b4) (on b8 b4) (on b11 b8) (on b15 b11) (on b23 b15) (clear b23)
	(on-table b6) (on b7 b6) (on b12 b7) (on b17 b12) (on b18 b17) (on b19 b18) (on b20 b19) (on b28 b20) (clear b28)
	(on-table b13) (on b16 b13) (on b29 b16) (clear b29)
	(on-table b21) (on b24 b21) (clear b24)
	(on-table b25) (on b26 b25) (clear b26)
	(on-table b27) (clear b27)
)
(;Goal Task Network
(achieve-goals (
	(on-table b1) (on b2 b1) (on b3 b2) (on b9 b3) (on b10 b9) (on b14 b10) (on b16 b14) (on b23 b16) (on b29 b23) (clear b29)
	(on-table b4) (on b5 b4) (on b12 b5) (on b30 b12) (clear b30)
	(on-table b6) (on b17 b6) (on b18 b17) (clear b18)
	(on-table b7) (on b8 b7) (on b11 b8) (clear b11)
	(on-table b13) (on b26 b13) (clear b26)
	(on-table b15) (on b27 b15) (clear b27)
	(on-table b19) (clear b19)
	(on-table b20) (clear b20)
	(on-table b21) (clear b21)
	(on-table b22) (on b24 b22) (clear b24)
	(on-table b25) (on b28 b25) (clear b28)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p30_24 blocks-htn
(
	(arm-empty)
	(block b1)
	(block b2)
	(block b3)
	(block b4)
	(block b5)
	(block b6)
	(block b7)
	(block b8)
	(block b9)
	(block b10)
	(block b11)
	(block b12)
	(block b13)
	(block b14)
	(block b15)
	(block b16)
	(block b17)
	(block b18)
	(block b19)
	(block b20)
	(block b21)
	(block b22)
	(block b23)
	(block b24)
	(block b25)
	(block b26)
	(block b27)
	(block b28)
	(block b29)
	(block b30)
	(on-table b1) (on b3 b1) (on b7 b3) (on b11 b7) (on b13 b11) (on b21 b13) (on b26 b21) (on b30 b26) (clear b30)
	(on-table b2) (on b14 b2) (on b22 b14) (clear b22)
	(on-table b4) (on b10 b4) (on b16 b10) (on b20 b16) (on b27 b20) (clear b27)
	(on-table b5) (on b6 b5) (on b9 b6) (on b12 b9) (on b19 b12) (on b29 b19) (clear b29)
	(on-table b8) (on b23 b8) (on b25 b23) (clear b25)
	(on-table b15) (on b17 b15) (on b24 b17) (clear b24)
	(on-table b18) (on b28 b18) (clear b28)
)
(;Goal Task Network
(achieve-goals (
	(on-table b1) (on b2 b1) (on b3 b2) (on b4 b3) (on b5 b4) (on b6 b5) (on b12 b6) (on b26 b12) (clear b26)
	(on-table b7) (on b9 b7) (on b30 b9) (clear b30)
	(on-table b8) (on b10 b8) (on b17 b10) (on b20 b17) (clear b20)
	(on-table b11) (on b14 b11) (on b18 b14) (on b19 b18) (on b23 b19) (on b24 b23) (clear b24)
	(on-table b13) (on b15 b13) (on b16 b15) (on b21 b16) (on b22 b21) (on b25 b22) (on b27 b25) (on b28 b27) (on b29 b28) (clear b29)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p30_25 blocks-htn
(
	(arm-empty)
	(block b1)
	(block b2)
	(block b3)
	(block b4)
	(block b5)
	(block b6)
	(block b7)
	(block b8)
	(block b9)
	(block b10)
	(block b11)
	(block b12)
	(block b13)
	(block b14)
	(block b15)
	(block b16)
	(block b17)
	(block b18)
	(block b19)
	(block b20)
	(block b21)
	(block b22)
	(block b23)
	(block b24)
	(block b25)
	(block b26)
	(block b27)
	(block b28)
	(block b29)
	(block b30)
	(on-table b1) (on b2 b1) (on b3 b2) (on b4 b3) (on b9 b4) (on b15 b9) (on b24 b15) (on b27 b24) (clear b27)
	(on-table b5) (on b13 b5) (on b17 b13) (on b26 b17) (on b28 b26) (on b30 b28) (clear b30)
	(on-table b6) (on b11 b6) (on b14 b11) (on b18 b14) (clear b18)
	(on-table b7) (on b8 b7) (on b10 b8) (on b25 b10) (on b29 b25) (clear b29)
	(on-table b12) (on b22 b12) (clear b22)
	(on-table b16) (on b19 b16) (on b20 b19) (on b21 b20) (on b23 b21) (clear b23)
)
(;Goal Task Network
(achieve-goals (
	(on-table b1) (on b5 b1) (on b9 b5) (on b11 b9) (on b15 b11) (on b17 b15) (on b19 b17) (on b21 b19) (on b22 b21) (clear b22)
	(on-table b2) (on b4 b2) (on b8 b4) (on b18 b8) (on b23 b18) (on b30 b23) (clear b30)
	(on-table b3) (on b12 b3) (on b14 b12) (on b20 b14) (on b29 b20) (clear b29)
	(on-table b6) (on b13 b6) (on b16 b13) (on b25 b16) (on b27 b25) (on b28 b27) (clear b28)
	(on-table b7) (on b10 b7) (on b24 b10) (clear b24)
	(on-table b26) (clear b26)
)));End of goal task network
)


;;-------------------------------
