(in-package :shop2)
;;---------------------------------------------

(defproblem p20_1 blocks-hgn
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
	(on-table b1) (on b6 b1) (on b8 b6) (on b10 b8) (on b17 b10) (clear b17)
	(on-table b2) (on b3 b2) (on b7 b3) (on b11 b7) (on b15 b11) (clear b15)
	(on-table b4) (on b14 b4) (on b16 b14) (clear b16)
	(on-table b5) (on b12 b5) (clear b12)
	(on-table b9) (on b13 b9) (on b18 b13) (on b19 b18) (on b20 b19) (clear b20)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b5 b1) (on b7 b5) (on b8 b7) (on b9 b8) (on b10 b9) (on b15 b10) (clear b15)
	(on-table b2) (on b3 b2) (on b4 b3) (on b6 b4) (on b12 b6) (on b14 b12) (clear b14)
	(on-table b11) (on b13 b11) (on b16 b13) (on b17 b16) (on b20 b17) (clear b20)
	(on-table b18) (on b19 b18) (clear b19)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p20_2 blocks-hgn
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
	(on-table b1) (on b3 b1) (on b8 b3) (on b10 b8) (clear b10)
	(on-table b2) (on b13 b2) (on b14 b13) (on b19 b14) (clear b19)
	(on-table b4) (on b5 b4) (on b18 b5) (clear b18)
	(on-table b6) (on b7 b6) (on b12 b7) (clear b12)
	(on-table b9) (on b16 b9) (on b20 b16) (clear b20)
	(on-table b11) (on b15 b11) (clear b15)
	(on-table b17) (clear b17)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b2 b1) (on b6 b2) (on b8 b6) (on b9 b8) (on b10 b9) (on b13 b10) (on b14 b13) (on b15 b14) (on b16 b15) (on b18 b16) (clear b18)
	(on-table b3) (on b4 b3) (on b5 b4) (on b7 b5) (on b11 b7) (on b12 b11) (on b17 b12) (on b19 b17) (clear b19)
	(on-table b20) (clear b20)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p20_3 blocks-hgn
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
	(on-table b1) (on b2 b1) (on b4 b2) (on b5 b4) (on b7 b5) (on b20 b7) (clear b20)
	(on-table b3) (on b13 b3) (on b18 b13) (clear b18)
	(on-table b6) (on b9 b6) (on b17 b9) (clear b17)
	(on-table b8) (on b10 b8) (on b16 b10) (on b19 b16) (clear b19)
	(on-table b11) (on b12 b11) (clear b12)
	(on-table b14) (on b15 b14) (clear b15)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b2 b1) (on b3 b2) (on b4 b3) (on b6 b4) (on b10 b6) (on b15 b10) (on b17 b15) (clear b17)
	(on-table b5) (on b19 b5) (on b20 b19) (clear b20)
	(on-table b7) (on b8 b7) (on b9 b8) (on b11 b9) (on b13 b11) (on b16 b13) (clear b16)
	(on-table b12) (on b18 b12) (clear b18)
	(on-table b14) (clear b14)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p20_4 blocks-hgn
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
	(on-table b1) (on b3 b1) (on b8 b3) (on b9 b8) (on b10 b9) (on b12 b10) (on b15 b12) (on b18 b15) (clear b18)
	(on-table b2) (on b5 b2) (on b11 b5) (on b14 b11) (clear b14)
	(on-table b4) (on b6 b4) (on b16 b6) (clear b16)
	(on-table b7) (on b17 b7) (on b19 b17) (clear b19)
	(on-table b13) (on b20 b13) (clear b20)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b10 b1) (on b18 b10) (on b20 b18) (clear b20)
	(on-table b2) (on b3 b2) (on b8 b3) (clear b8)
	(on-table b4) (on b5 b4) (on b6 b5) (on b7 b6) (on b9 b7) (on b14 b9) (on b16 b14) (clear b16)
	(on-table b11) (on b17 b11) (clear b17)
	(on-table b12) (on b13 b12) (on b15 b13) (clear b15)
	(on-table b19) (clear b19)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p20_5 blocks-hgn
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
	(on-table b1) (on b2 b1) (on b3 b2) (on b4 b3) (on b5 b4) (on b8 b5) (clear b8)
	(on-table b6) (on b7 b6) (on b13 b7) (on b17 b13) (clear b17)
	(on-table b9) (on b11 b9) (on b15 b11) (on b20 b15) (clear b20)
	(on-table b10) (on b12 b10) (on b14 b12) (on b19 b14) (clear b19)
	(on-table b16) (clear b16)
	(on-table b18) (clear b18)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b2 b1) (on b3 b2) (on b7 b3) (on b8 b7) (on b9 b8) (on b14 b9) (on b19 b14) (clear b19)
	(on-table b4) (on b5 b4) (on b6 b5) (on b10 b6) (on b11 b10) (on b13 b11) (on b20 b13) (clear b20)
	(on-table b12) (on b15 b12) (on b16 b15) (on b17 b16) (on b18 b17) (clear b18)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p20_6 blocks-hgn
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
	(on-table b1) (on b3 b1) (on b10 b3) (on b11 b10) (clear b11)
	(on-table b2) (on b4 b2) (on b12 b4) (on b15 b12) (on b17 b15) (clear b17)
	(on-table b5) (on b6 b5) (on b9 b6) (on b14 b9) (on b16 b14) (on b18 b16) (clear b18)
	(on-table b7) (on b8 b7) (on b13 b8) (on b19 b13) (clear b19)
	(on-table b20) (clear b20)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b2 b1) (on b5 b2) (on b6 b5) (on b14 b6) (clear b14)
	(on-table b3) (clear b3)
	(on-table b4) (clear b4)
	(on-table b7) (on b12 b7) (on b13 b12) (on b18 b13) (clear b18)
	(on-table b8) (on b10 b8) (on b11 b10) (on b19 b11) (clear b19)
	(on-table b9) (on b15 b9) (on b17 b15) (clear b17)
	(on-table b16) (on b20 b16) (clear b20)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p20_7 blocks-hgn
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
	(on-table b1) (on b2 b1) (on b3 b2) (on b8 b3) (on b10 b8) (on b15 b10) (on b16 b15) (clear b16)
	(on-table b4) (on b7 b4) (on b9 b7) (on b12 b9) (on b17 b12) (on b18 b17) (clear b18)
	(on-table b5) (on b6 b5) (clear b6)
	(on-table b11) (on b14 b11) (on b19 b14) (clear b19)
	(on-table b13) (clear b13)
	(on-table b20) (clear b20)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b2 b1) (on b4 b2) (on b7 b4) (on b20 b7) (clear b20)
	(on-table b3) (on b5 b3) (on b8 b5) (on b13 b8) (on b19 b13) (clear b19)
	(on-table b6) (on b10 b6) (on b17 b10) (clear b17)
	(on-table b9) (on b11 b9) (clear b11)
	(on-table b12) (on b16 b12) (on b18 b16) (clear b18)
	(on-table b14) (clear b14)
	(on-table b15) (clear b15)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p20_8 blocks-hgn
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
	(on-table b1) (on b3 b1) (on b4 b3) (on b5 b4) (on b6 b5) (on b8 b6) (on b9 b8) (on b11 b9) (clear b11)
	(on-table b2) (on b10 b2) (on b16 b10) (on b20 b16) (clear b20)
	(on-table b7) (on b13 b7) (on b14 b13) (on b17 b14) (on b19 b17) (clear b19)
	(on-table b12) (on b15 b12) (on b18 b15) (clear b18)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b6 b1) (on b8 b6) (on b19 b8) (clear b19)
	(on-table b2) (on b4 b2) (on b5 b4) (on b9 b5) (on b10 b9) (on b11 b10) (on b15 b11) (on b17 b15) (clear b17)
	(on-table b3) (on b7 b3) (on b14 b7) (on b16 b14) (clear b16)
	(on-table b12) (on b20 b12) (clear b20)
	(on-table b13) (clear b13)
	(on-table b18) (clear b18)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p20_9 blocks-hgn
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
	(on-table b1) (on b14 b1) (on b16 b14) (clear b16)
	(on-table b2) (on b3 b2) (on b4 b3) (on b7 b4) (on b12 b7) (on b19 b12) (on b20 b19) (clear b20)
	(on-table b5) (on b6 b5) (on b11 b6) (on b15 b11) (on b18 b15) (clear b18)
	(on-table b8) (on b9 b8) (clear b9)
	(on-table b10) (on b13 b10) (clear b13)
	(on-table b17) (clear b17)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b15 b1) (clear b15)
	(on-table b2) (on b3 b2) (on b4 b3) (on b7 b4) (clear b7)
	(on-table b5) (on b6 b5) (on b17 b6) (clear b17)
	(on-table b8) (on b14 b8) (on b18 b14) (on b20 b18) (clear b20)
	(on-table b9) (on b10 b9) (on b13 b10) (clear b13)
	(on-table b11) (clear b11)
	(on-table b12) (on b16 b12) (on b19 b16) (clear b19)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p20_10 blocks-hgn
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
	(on-table b1) (on b2 b1) (on b4 b2) (on b6 b4) (on b10 b6) (on b15 b10) (clear b15)
	(on-table b3) (on b5 b3) (on b9 b5) (on b12 b9) (clear b12)
	(on-table b7) (on b8 b7) (on b11 b8) (on b13 b11) (clear b13)
	(on-table b14) (on b16 b14) (on b19 b16) (clear b19)
	(on-table b17) (clear b17)
	(on-table b18) (on b20 b18) (clear b20)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b4 b1) (on b7 b4) (on b10 b7) (on b13 b10) (on b17 b13) (on b20 b17) (clear b20)
	(on-table b2) (on b3 b2) (on b5 b3) (on b6 b5) (on b8 b6) (on b9 b8) (on b14 b9) (clear b14)
	(on-table b11) (on b12 b11) (clear b12)
	(on-table b15) (on b16 b15) (clear b16)
	(on-table b18) (on b19 b18) (clear b19)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p20_11 blocks-hgn
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
	(on-table b1) (on b7 b1) (on b17 b7) (on b18 b17) (clear b18)
	(on-table b2) (on b3 b2) (on b8 b3) (on b11 b8) (on b16 b11) (clear b16)
	(on-table b4) (on b13 b4) (clear b13)
	(on-table b5) (on b6 b5) (on b9 b6) (on b14 b9) (on b19 b14) (clear b19)
	(on-table b10) (on b15 b10) (clear b15)
	(on-table b12) (clear b12)
	(on-table b20) (clear b20)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b3 b1) (on b14 b3) (on b19 b14) (clear b19)
	(on-table b2) (on b5 b2) (on b6 b5) (on b20 b6) (clear b20)
	(on-table b4) (on b7 b4) (on b8 b7) (on b9 b8) (clear b9)
	(on-table b10) (on b11 b10) (on b17 b11) (on b18 b17) (clear b18)
	(on-table b12) (on b13 b12) (on b15 b13) (on b16 b15) (clear b16)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p20_12 blocks-hgn
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
	(on-table b1) (on b2 b1) (on b17 b2) (on b18 b17) (clear b18)
	(on-table b3) (on b8 b3) (on b11 b8) (on b15 b11) (clear b15)
	(on-table b4) (on b5 b4) (on b6 b5) (on b7 b6) (on b19 b7) (clear b19)
	(on-table b9) (on b10 b9) (on b14 b10) (on b20 b14) (clear b20)
	(on-table b12) (on b13 b12) (on b16 b13) (clear b16)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b6 b1) (on b8 b6) (on b9 b8) (on b20 b9) (clear b20)
	(on-table b2) (on b10 b2) (on b11 b10) (on b13 b11) (on b14 b13) (on b15 b14) (on b17 b15) (clear b17)
	(on-table b3) (on b4 b3) (on b5 b4) (on b12 b5) (on b16 b12) (on b19 b16) (clear b19)
	(on-table b7) (on b18 b7) (clear b18)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p20_13 blocks-hgn
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
	(on-table b1) (on b4 b1) (on b7 b4) (clear b7)
	(on-table b2) (on b3 b2) (on b6 b3) (on b18 b6) (clear b18)
	(on-table b5) (on b9 b5) (on b10 b9) (on b12 b10) (clear b12)
	(on-table b8) (on b16 b8) (on b19 b16) (clear b19)
	(on-table b11) (on b15 b11) (on b17 b15) (clear b17)
	(on-table b13) (on b14 b13) (clear b14)
	(on-table b20) (clear b20)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b11 b1) (on b13 b11) (clear b13)
	(on-table b2) (on b3 b2) (on b5 b3) (on b12 b5) (on b17 b12) (clear b17)
	(on-table b4) (on b7 b4) (on b8 b7) (on b10 b8) (on b14 b10) (on b16 b14) (clear b16)
	(on-table b6) (on b18 b6) (on b19 b18) (on b20 b19) (clear b20)
	(on-table b9) (clear b9)
	(on-table b15) (clear b15)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p20_14 blocks-hgn
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
	(on-table b1) (on b2 b1) (on b5 b2) (on b7 b5) (on b11 b7) (on b15 b11) (on b18 b15) (clear b18)
	(on-table b3) (on b16 b3) (on b19 b16) (clear b19)
	(on-table b4) (on b9 b4) (clear b9)
	(on-table b6) (clear b6)
	(on-table b8) (on b10 b8) (on b17 b10) (clear b17)
	(on-table b12) (on b13 b12) (on b14 b13) (clear b14)
	(on-table b20) (clear b20)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b7 b1) (on b9 b7) (on b11 b9) (on b12 b11) (on b14 b12) (on b18 b14) (clear b18)
	(on-table b2) (on b3 b2) (on b4 b3) (on b6 b4) (on b8 b6) (on b13 b8) (on b16 b13) (clear b16)
	(on-table b5) (on b10 b5) (on b17 b10) (on b20 b17) (clear b20)
	(on-table b15) (on b19 b15) (clear b19)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p20_15 blocks-hgn
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
	(on-table b1) (on b3 b1) (on b4 b3) (on b5 b4) (on b8 b5) (on b13 b8) (on b17 b13) (clear b17)
	(on-table b2) (on b6 b2) (on b10 b6) (on b11 b10) (on b12 b11) (on b14 b12) (on b16 b14) (on b20 b16) (clear b20)
	(on-table b7) (on b18 b7) (clear b18)
	(on-table b9) (on b15 b9) (clear b15)
	(on-table b19) (clear b19)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b2 b1) (on b7 b2) (on b12 b7) (on b18 b12) (clear b18)
	(on-table b3) (on b9 b3) (on b13 b9) (clear b13)
	(on-table b4) (on b17 b4) (clear b17)
	(on-table b5) (on b6 b5) (on b8 b6) (on b14 b8) (on b19 b14) (clear b19)
	(on-table b10) (on b11 b10) (on b15 b11) (on b20 b15) (clear b20)
	(on-table b16) (clear b16)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p20_16 blocks-hgn
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
	(on-table b1) (on b3 b1) (on b5 b3) (on b6 b5) (on b9 b6) (on b10 b9) (on b12 b10) (on b15 b12) (on b17 b15) (on b19 b17) (clear b19)
	(on-table b2) (on b4 b2) (on b7 b4) (on b8 b7) (on b13 b8) (on b18 b13) (clear b18)
	(on-table b11) (on b14 b11) (on b16 b14) (on b20 b16) (clear b20)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b4 b1) (on b6 b4) (on b8 b6) (clear b8)
	(on-table b2) (on b5 b2) (on b11 b5) (clear b11)
	(on-table b3) (on b12 b3) (on b14 b12) (on b16 b14) (clear b16)
	(on-table b7) (on b9 b7) (on b13 b9) (on b15 b13) (clear b15)
	(on-table b10) (on b17 b10) (on b19 b17) (clear b19)
	(on-table b18) (on b20 b18) (clear b20)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p20_17 blocks-hgn
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
	(on-table b1) (on b2 b1) (on b3 b2) (on b7 b3) (on b9 b7) (on b13 b9) (on b14 b13) (on b16 b14) (clear b16)
	(on-table b4) (on b10 b4) (on b11 b10) (on b15 b11) (clear b15)
	(on-table b5) (on b6 b5) (on b8 b6) (on b20 b8) (clear b20)
	(on-table b12) (on b17 b12) (on b19 b17) (clear b19)
	(on-table b18) (clear b18)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b3 b1) (on b5 b3) (on b7 b5) (on b10 b7) (on b11 b10) (on b15 b11) (on b17 b15) (on b18 b17) (on b19 b18) (clear b19)
	(on-table b2) (on b4 b2) (on b6 b4) (on b12 b6) (clear b12)
	(on-table b8) (on b9 b8) (clear b9)
	(on-table b13) (on b14 b13) (clear b14)
	(on-table b16) (clear b16)
	(on-table b20) (clear b20)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p20_18 blocks-hgn
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
	(on-table b1) (on b2 b1) (on b3 b2) (on b4 b3) (on b5 b4) (on b6 b5) (on b7 b6) (on b9 b7) (clear b9)
	(on-table b8) (on b14 b8) (on b15 b14) (clear b15)
	(on-table b10) (on b11 b10) (on b13 b11) (on b16 b13) (on b17 b16) (on b19 b17) (on b20 b19) (clear b20)
	(on-table b12) (clear b12)
	(on-table b18) (clear b18)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b3 b1) (on b4 b3) (on b9 b4) (on b15 b9) (clear b15)
	(on-table b2) (on b6 b2) (on b13 b6) (on b17 b13) (on b19 b17) (clear b19)
	(on-table b5) (on b8 b5) (on b12 b8) (clear b12)
	(on-table b7) (on b10 b7) (clear b10)
	(on-table b11) (on b14 b11) (on b16 b14) (on b20 b16) (clear b20)
	(on-table b18) (clear b18)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p20_19 blocks-hgn
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
	(on-table b1) (on b2 b1) (on b6 b2) (on b9 b6) (on b14 b9) (on b15 b14) (on b16 b15) (on b18 b16) (on b19 b18) (clear b19)
	(on-table b3) (on b4 b3) (on b5 b4) (clear b5)
	(on-table b7) (on b8 b7) (on b10 b8) (on b11 b10) (on b12 b11) (on b13 b12) (on b17 b13) (on b20 b17) (clear b20)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b3 b1) (on b4 b3) (on b5 b4) (on b9 b5) (on b10 b9) (clear b10)
	(on-table b2) (on b6 b2) (on b19 b6) (on b20 b19) (clear b20)
	(on-table b7) (on b14 b7) (clear b14)
	(on-table b8) (on b12 b8) (on b15 b12) (on b16 b15) (on b18 b16) (clear b18)
	(on-table b11) (on b13 b11) (on b17 b13) (clear b17)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p20_20 blocks-hgn
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
	(on-table b1) (on b2 b1) (on b3 b2) (on b7 b3) (on b9 b7) (on b15 b9) (clear b15)
	(on-table b4) (on b5 b4) (on b14 b5) (on b19 b14) (clear b19)
	(on-table b6) (on b8 b6) (on b10 b8) (on b11 b10) (on b12 b11) (on b13 b12) (clear b13)
	(on-table b16) (on b18 b16) (clear b18)
	(on-table b17) (clear b17)
	(on-table b20) (clear b20)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b6 b1) (on b11 b6) (on b18 b11) (on b20 b18) (clear b20)
	(on-table b2) (on b3 b2) (on b4 b3) (on b5 b4) (on b7 b5) (on b8 b7) (on b15 b8) (on b16 b15) (clear b16)
	(on-table b9) (on b10 b9) (on b14 b10) (on b17 b14) (clear b17)
	(on-table b12) (clear b12)
	(on-table b13) (on b19 b13) (clear b19)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p20_21 blocks-hgn
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
	(on-table b1) (on b11 b1) (on b18 b11) (on b20 b18) (clear b20)
	(on-table b2) (on b5 b2) (on b19 b5) (clear b19)
	(on-table b3) (on b4 b3) (on b16 b4) (clear b16)
	(on-table b6) (on b7 b6) (on b9 b7) (on b10 b9) (on b13 b10) (on b14 b13) (clear b14)
	(on-table b8) (on b12 b8) (on b17 b12) (clear b17)
	(on-table b15) (clear b15)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b6 b1) (on b9 b6) (on b18 b9) (clear b18)
	(on-table b2) (on b11 b2) (on b16 b11) (clear b16)
	(on-table b3) (on b5 b3) (on b10 b5) (on b13 b10) (clear b13)
	(on-table b4) (on b7 b4) (clear b7)
	(on-table b8) (on b15 b8) (on b19 b15) (clear b19)
	(on-table b12) (on b17 b12) (clear b17)
	(on-table b14) (on b20 b14) (clear b20)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p20_22 blocks-hgn
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
	(on-table b1) (on b3 b1) (on b4 b3) (on b6 b4) (on b10 b6) (on b12 b10) (on b18 b12) (clear b18)
	(on-table b2) (on b5 b2) (on b15 b5) (on b17 b15) (clear b17)
	(on-table b7) (on b8 b7) (on b9 b8) (on b11 b9) (on b16 b11) (clear b16)
	(on-table b13) (on b14 b13) (on b20 b14) (clear b20)
	(on-table b19) (clear b19)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b3 b1) (on b4 b3) (on b15 b4) (clear b15)
	(on-table b2) (on b7 b2) (on b10 b7) (on b16 b10) (on b17 b16) (clear b17)
	(on-table b5) (on b8 b5) (on b9 b8) (on b12 b9) (on b13 b12) (on b20 b13) (clear b20)
	(on-table b6) (on b11 b6) (on b14 b11) (clear b14)
	(on-table b18) (on b19 b18) (clear b19)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p20_23 blocks-hgn
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
	(on-table b1) (on b3 b1) (on b7 b3) (on b15 b7) (on b16 b15) (on b17 b16) (on b20 b17) (clear b20)
	(on-table b2) (on b8 b2) (on b9 b8) (on b10 b9) (on b12 b10) (clear b12)
	(on-table b4) (on b5 b4) (on b14 b5) (on b18 b14) (clear b18)
	(on-table b6) (on b13 b6) (clear b13)
	(on-table b11) (on b19 b11) (clear b19)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b2 b1) (on b10 b2) (on b14 b10) (clear b14)
	(on-table b3) (on b13 b3) (clear b13)
	(on-table b4) (on b6 b4) (on b8 b6) (on b11 b8) (clear b11)
	(on-table b5) (on b7 b5) (on b9 b7) (on b12 b9) (on b18 b12) (clear b18)
	(on-table b15) (clear b15)
	(on-table b16) (clear b16)
	(on-table b17) (on b20 b17) (clear b20)
	(on-table b19) (clear b19)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p20_24 blocks-hgn
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
	(on-table b1) (on b2 b1) (on b3 b2) (on b4 b3) (on b5 b4) (on b6 b5) (on b8 b6) (on b10 b8) (on b11 b10) (on b12 b11) (on b13 b12) (on b20 b13) (clear b20)
	(on-table b7) (on b17 b7) (clear b17)
	(on-table b9) (on b16 b9) (on b19 b16) (clear b19)
	(on-table b14) (on b18 b14) (clear b18)
	(on-table b15) (clear b15)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b3 b1) (on b4 b3) (on b7 b4) (on b8 b7) (on b9 b8) (on b15 b9) (on b16 b15) (clear b16)
	(on-table b2) (on b5 b2) (on b6 b5) (on b10 b6) (on b13 b10) (clear b13)
	(on-table b11) (on b20 b11) (clear b20)
	(on-table b12) (on b18 b12) (on b19 b18) (clear b19)
	(on-table b14) (on b17 b14) (clear b17)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p20_25 blocks-hgn
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
	(on-table b1) (on b2 b1) (on b19 b2) (clear b19)
	(on-table b3) (on b9 b3) (on b10 b9) (on b12 b10) (on b13 b12) (on b14 b13) (clear b14)
	(on-table b4) (on b5 b4) (on b7 b5) (on b8 b7) (on b18 b8) (on b20 b18) (clear b20)
	(on-table b6) (on b11 b6) (on b15 b11) (clear b15)
	(on-table b16) (on b17 b16) (clear b17)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b4 b1) (on b6 b4) (on b7 b6) (on b8 b7) (on b19 b8) (clear b19)
	(on-table b2) (on b3 b2) (on b5 b3) (on b9 b5) (on b10 b9) (on b11 b10) (on b14 b11) (on b17 b14) (on b20 b17) (clear b20)
	(on-table b12) (on b13 b12) (on b15 b13) (on b16 b15) (on b18 b16) (clear b18)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p20_26 blocks-hgn
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
	(on-table b1) (on b4 b1) (on b16 b4) (on b19 b16) (clear b19)
	(on-table b2) (on b5 b2) (on b8 b5) (on b10 b8) (on b11 b10) (on b15 b11) (on b17 b15) (on b20 b17) (clear b20)
	(on-table b3) (on b6 b3) (on b7 b6) (on b12 b7) (clear b12)
	(on-table b9) (on b13 b9) (on b14 b13) (clear b14)
	(on-table b18) (clear b18)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b2 b1) (on b3 b2) (on b5 b3) (on b11 b5) (on b12 b11) (on b16 b12) (on b18 b16) (clear b18)
	(on-table b4) (on b8 b4) (on b15 b8) (clear b15)
	(on-table b6) (on b7 b6) (on b10 b7) (clear b10)
	(on-table b9) (on b17 b9) (clear b17)
	(on-table b13) (on b14 b13) (on b19 b14) (clear b19)
	(on-table b20) (clear b20)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p20_27 blocks-hgn
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
	(on-table b1) (clear b1)
	(on-table b2) (on b4 b2) (on b5 b4) (on b10 b5) (on b17 b10) (clear b17)
	(on-table b3) (on b6 b3) (on b7 b6) (on b8 b7) (on b9 b8) (on b11 b9) (on b13 b11) (on b16 b13) (on b19 b16) (clear b19)
	(on-table b12) (on b14 b12) (on b15 b14) (on b18 b15) (clear b18)
	(on-table b20) (clear b20)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b2 b1) (on b5 b2) (on b8 b5) (clear b8)
	(on-table b3) (on b6 b3) (on b7 b6) (on b9 b7) (on b11 b9) (clear b11)
	(on-table b4) (on b10 b4) (on b17 b10) (on b18 b17) (on b19 b18) (clear b19)
	(on-table b12) (on b13 b12) (on b14 b13) (on b15 b14) (clear b15)
	(on-table b16) (on b20 b16) (clear b20)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p20_28 blocks-hgn
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
	(on-table b1) (on b5 b1) (on b6 b5) (on b16 b6) (clear b16)
	(on-table b2) (on b3 b2) (on b11 b3) (on b13 b11) (clear b13)
	(on-table b4) (on b8 b4) (on b18 b8) (on b19 b18) (clear b19)
	(on-table b7) (on b9 b7) (on b14 b9) (clear b14)
	(on-table b10) (on b12 b10) (clear b12)
	(on-table b15) (on b17 b15) (clear b17)
	(on-table b20) (clear b20)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b8 b1) (clear b8)
	(on-table b2) (on b5 b2) (on b6 b5) (on b12 b6) (on b13 b12) (clear b13)
	(on-table b3) (on b7 b3) (on b11 b7) (on b16 b11) (on b19 b16) (clear b19)
	(on-table b4) (on b17 b4) (clear b17)
	(on-table b9) (on b10 b9) (on b15 b10) (on b18 b15) (on b20 b18) (clear b20)
	(on-table b14) (clear b14)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p20_29 blocks-hgn
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
	(on-table b1) (on b2 b1) (clear b2)
	(on-table b3) (on b9 b3) (on b12 b9) (on b14 b12) (on b19 b14) (clear b19)
	(on-table b4) (on b5 b4) (on b6 b5) (on b15 b6) (clear b15)
	(on-table b7) (on b10 b7) (on b11 b10) (on b18 b11) (on b20 b18) (clear b20)
	(on-table b8) (on b13 b8) (clear b13)
	(on-table b16) (on b17 b16) (clear b17)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b8 b1) (on b11 b8) (on b17 b11) (on b19 b17) (clear b19)
	(on-table b2) (on b3 b2) (on b5 b3) (on b9 b5) (on b12 b9) (clear b12)
	(on-table b4) (on b6 b4) (on b10 b6) (on b13 b10) (on b20 b13) (clear b20)
	(on-table b7) (on b14 b7) (on b15 b14) (clear b15)
	(on-table b16) (on b18 b16) (clear b18)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p20_30 blocks-hgn
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
	(on-table b1) (on b2 b1) (on b3 b2) (on b4 b3) (on b5 b4) (on b10 b5) (on b11 b10) (on b12 b11) (on b18 b12) (clear b18)
	(on-table b6) (on b7 b6) (on b9 b7) (on b16 b9) (clear b16)
	(on-table b8) (on b13 b8) (on b14 b13) (on b17 b14) (clear b17)
	(on-table b15) (on b20 b15) (clear b20)
	(on-table b19) (clear b19)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b2 b1) (on b5 b2) (on b6 b5) (on b14 b6) (on b18 b14) (on b20 b18) (clear b20)
	(on-table b3) (on b4 b3) (on b8 b4) (on b13 b8) (on b15 b13) (on b19 b15) (clear b19)
	(on-table b7) (on b9 b7) (on b10 b9) (on b11 b10) (on b12 b11) (on b16 b12) (on b17 b16) (clear b17)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p20_31 blocks-hgn
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
	(on-table b1) (on b2 b1) (on b4 b2) (on b9 b4) (on b11 b9) (on b14 b11) (clear b14)
	(on-table b3) (on b6 b3) (on b13 b6) (clear b13)
	(on-table b5) (on b18 b5) (clear b18)
	(on-table b7) (on b15 b7) (on b17 b15) (clear b17)
	(on-table b8) (on b12 b8) (on b19 b12) (clear b19)
	(on-table b10) (on b16 b10) (clear b16)
	(on-table b20) (clear b20)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b2 b1) (on b3 b2) (on b5 b3) (on b20 b5) (clear b20)
	(on-table b4) (on b7 b4) (on b8 b7) (on b13 b8) (on b14 b13) (clear b14)
	(on-table b6) (on b9 b6) (on b16 b9) (clear b16)
	(on-table b10) (on b11 b10) (on b15 b11) (clear b15)
	(on-table b12) (on b18 b12) (on b19 b18) (clear b19)
	(on-table b17) (clear b17)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p20_32 blocks-hgn
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
	(on-table b1) (on b5 b1) (on b10 b5) (on b12 b10) (on b13 b12) (on b14 b13) (on b20 b14) (clear b20)
	(on-table b2) (on b3 b2) (on b4 b3) (on b6 b4) (on b7 b6) (on b8 b7) (on b9 b8) (on b11 b9) (clear b11)
	(on-table b15) (on b16 b15) (clear b16)
	(on-table b17) (clear b17)
	(on-table b18) (on b19 b18) (clear b19)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b6 b1) (on b20 b6) (clear b20)
	(on-table b2) (on b5 b2) (on b7 b5) (on b9 b7) (on b10 b9) (on b11 b10) (on b12 b11) (on b13 b12) (on b16 b13) (clear b16)
	(on-table b3) (on b4 b3) (on b8 b4) (on b14 b8) (on b15 b14) (on b17 b15) (on b19 b17) (clear b19)
	(on-table b18) (clear b18)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p20_33 blocks-hgn
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
	(on-table b1) (on b3 b1) (on b8 b3) (on b16 b8) (on b18 b16) (clear b18)
	(on-table b2) (on b12 b2) (on b20 b12) (clear b20)
	(on-table b4) (on b6 b4) (on b11 b6) (on b15 b11) (clear b15)
	(on-table b5) (on b7 b5) (on b10 b7) (on b13 b10) (on b14 b13) (on b17 b14) (on b19 b17) (clear b19)
	(on-table b9) (clear b9)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b7 b1) (on b13 b7) (on b14 b13) (on b18 b14) (clear b18)
	(on-table b2) (on b3 b2) (on b6 b3) (on b8 b6) (on b9 b8) (on b12 b9) (on b15 b12) (on b16 b15) (on b20 b16) (clear b20)
	(on-table b4) (on b5 b4) (on b10 b5) (on b11 b10) (clear b11)
	(on-table b17) (clear b17)
	(on-table b19) (clear b19)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p20_34 blocks-hgn
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
	(on-table b1) (on b3 b1) (on b4 b3) (on b10 b4) (on b12 b10) (on b13 b12) (clear b13)
	(on-table b2) (on b6 b2) (on b8 b6) (on b16 b8) (on b20 b16) (clear b20)
	(on-table b5) (on b17 b5) (on b18 b17) (on b19 b18) (clear b19)
	(on-table b7) (on b9 b7) (on b11 b9) (on b15 b11) (clear b15)
	(on-table b14) (clear b14)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b3 b1) (on b5 b3) (on b8 b5) (clear b8)
	(on-table b2) (on b9 b2) (on b14 b9) (on b17 b14) (clear b17)
	(on-table b4) (on b7 b4) (on b10 b7) (on b11 b10) (on b15 b11) (on b20 b15) (clear b20)
	(on-table b6) (on b12 b6) (clear b12)
	(on-table b13) (on b16 b13) (on b19 b16) (clear b19)
	(on-table b18) (clear b18)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p20_35 blocks-hgn
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
	(on-table b1) (on b6 b1) (on b8 b6) (on b11 b8) (on b20 b11) (clear b20)
	(on-table b2) (on b3 b2) (on b5 b3) (on b12 b5) (on b16 b12) (clear b16)
	(on-table b4) (on b9 b4) (on b10 b9) (on b13 b10) (on b14 b13) (on b15 b14) (on b18 b15) (on b19 b18) (clear b19)
	(on-table b7) (on b17 b7) (clear b17)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b3 b1) (on b8 b3) (on b10 b8) (on b14 b10) (on b16 b14) (clear b16)
	(on-table b2) (on b15 b2) (clear b15)
	(on-table b4) (on b5 b4) (on b7 b5) (on b9 b7) (on b11 b9) (on b13 b11) (clear b13)
	(on-table b6) (on b17 b6) (on b18 b17) (clear b18)
	(on-table b12) (on b20 b12) (clear b20)
	(on-table b19) (clear b19)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p20_36 blocks-hgn
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
	(on-table b1) (on b9 b1) (on b13 b9) (clear b13)
	(on-table b2) (on b4 b2) (on b11 b4) (on b14 b11) (clear b14)
	(on-table b3) (on b5 b3) (on b6 b5) (on b10 b6) (on b15 b10) (on b18 b15) (on b19 b18) (clear b19)
	(on-table b7) (on b8 b7) (on b12 b8) (on b16 b12) (on b17 b16) (on b20 b17) (clear b20)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b2 b1) (on b4 b2) (on b6 b4) (on b17 b6) (on b20 b17) (clear b20)
	(on-table b3) (on b5 b3) (on b9 b5) (on b14 b9) (clear b14)
	(on-table b7) (on b8 b7) (on b10 b8) (on b15 b10) (on b16 b15) (clear b16)
	(on-table b11) (on b12 b11) (on b18 b12) (on b19 b18) (clear b19)
	(on-table b13) (clear b13)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p20_37 blocks-hgn
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
	(on-table b1) (on b2 b1) (on b8 b2) (on b15 b8) (on b16 b15) (on b20 b16) (clear b20)
	(on-table b3) (on b4 b3) (on b5 b4) (on b6 b5) (clear b6)
	(on-table b7) (on b12 b7) (clear b12)
	(on-table b9) (on b13 b9) (on b14 b13) (on b18 b14) (clear b18)
	(on-table b10) (on b11 b10) (clear b11)
	(on-table b17) (clear b17)
	(on-table b19) (clear b19)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b4 b1) (on b8 b4) (on b10 b8) (on b11 b10) (on b12 b11) (on b16 b12) (clear b16)
	(on-table b2) (on b5 b2) (on b6 b5) (on b7 b6) (on b17 b7) (on b19 b17) (clear b19)
	(on-table b3) (on b20 b3) (clear b20)
	(on-table b9) (on b13 b9) (clear b13)
	(on-table b14) (on b15 b14) (clear b15)
	(on-table b18) (clear b18)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p20_38 blocks-hgn
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
	(on-table b1) (on b3 b1) (on b12 b3) (clear b12)
	(on-table b2) (on b4 b2) (on b10 b4) (clear b10)
	(on-table b5) (on b7 b5) (on b11 b7) (clear b11)
	(on-table b6) (on b17 b6) (on b18 b17) (on b20 b18) (clear b20)
	(on-table b8) (clear b8)
	(on-table b9) (on b14 b9) (on b15 b14) (clear b15)
	(on-table b13) (on b16 b13) (clear b16)
	(on-table b19) (clear b19)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b3 b1) (on b5 b3) (on b12 b5) (on b18 b12) (clear b18)
	(on-table b2) (on b4 b2) (on b6 b4) (on b11 b6) (on b13 b11) (on b14 b13) (on b19 b14) (clear b19)
	(on-table b7) (on b8 b7) (on b9 b8) (on b10 b9) (on b15 b10) (clear b15)
	(on-table b16) (on b17 b16) (on b20 b17) (clear b20)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p20_39 blocks-hgn
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
	(on-table b1) (on b2 b1) (on b3 b2) (on b5 b3) (on b6 b5) (on b7 b6) (on b17 b7) (clear b17)
	(on-table b4) (on b9 b4) (on b14 b9) (on b15 b14) (on b19 b15) (clear b19)
	(on-table b8) (on b10 b8) (on b11 b10) (on b12 b11) (on b13 b12) (on b16 b13) (clear b16)
	(on-table b18) (on b20 b18) (clear b20)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b6 b1) (on b8 b6) (on b9 b8) (on b13 b9) (on b15 b13) (on b19 b15) (clear b19)
	(on-table b2) (on b3 b2) (on b7 b3) (on b12 b7) (on b16 b12) (clear b16)
	(on-table b4) (on b5 b4) (clear b5)
	(on-table b10) (on b18 b10) (clear b18)
	(on-table b11) (clear b11)
	(on-table b14) (on b17 b14) (clear b17)
	(on-table b20) (clear b20)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p20_40 blocks-hgn
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
	(on-table b1) (on b2 b1) (on b4 b2) (on b6 b4) (on b7 b6) (on b17 b7) (on b18 b17) (clear b18)
	(on-table b3) (on b5 b3) (on b8 b5) (on b13 b8) (on b16 b13) (clear b16)
	(on-table b9) (on b10 b9) (on b14 b10) (on b20 b14) (clear b20)
	(on-table b11) (on b12 b11) (on b15 b12) (on b19 b15) (clear b19)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b3 b1) (on b4 b3) (on b14 b4) (clear b14)
	(on-table b2) (on b9 b2) (on b10 b9) (on b13 b10) (clear b13)
	(on-table b5) (on b7 b5) (on b11 b7) (on b16 b11) (on b18 b16) (on b19 b18) (clear b19)
	(on-table b6) (on b8 b6) (on b12 b8) (clear b12)
	(on-table b15) (on b20 b15) (clear b20)
	(on-table b17) (clear b17)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p20_41 blocks-hgn
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
	(on-table b1) (on b4 b1) (on b9 b4) (clear b9)
	(on-table b2) (on b8 b2) (on b11 b8) (on b19 b11) (on b20 b19) (clear b20)
	(on-table b3) (on b7 b3) (on b13 b7) (clear b13)
	(on-table b5) (on b6 b5) (on b10 b6) (on b12 b10) (on b16 b12) (on b18 b16) (clear b18)
	(on-table b14) (on b15 b14) (on b17 b15) (clear b17)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b4 b1) (on b6 b4) (on b12 b6) (clear b12)
	(on-table b2) (on b3 b2) (clear b3)
	(on-table b5) (on b7 b5) (on b14 b7) (on b18 b14) (clear b18)
	(on-table b8) (on b9 b8) (on b13 b9) (on b15 b13) (clear b15)
	(on-table b10) (on b19 b10) (on b20 b19) (clear b20)
	(on-table b11) (on b16 b11) (on b17 b16) (clear b17)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p20_42 blocks-hgn
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
	(on-table b1) (on b2 b1) (on b3 b2) (on b4 b3) (on b7 b4) (on b19 b7) (clear b19)
	(on-table b5) (on b13 b5) (clear b13)
	(on-table b6) (on b8 b6) (on b9 b8) (on b15 b9) (clear b15)
	(on-table b10) (on b11 b10) (on b12 b11) (on b14 b12) (on b20 b14) (clear b20)
	(on-table b16) (on b17 b16) (clear b17)
	(on-table b18) (clear b18)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b8 b1) (on b9 b8) (on b10 b9) (clear b10)
	(on-table b2) (on b3 b2) (on b4 b3) (on b5 b4) (on b6 b5) (on b11 b6) (on b12 b11) (on b13 b12) (on b16 b13) (on b17 b16) (clear b17)
	(on-table b7) (on b14 b7) (on b15 b14) (on b20 b15) (clear b20)
	(on-table b18) (clear b18)
	(on-table b19) (clear b19)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p20_43 blocks-hgn
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
	(on-table b1) (on b10 b1) (on b14 b10) (clear b14)
	(on-table b2) (on b11 b2) (on b12 b11) (on b16 b12) (clear b16)
	(on-table b3) (on b15 b3) (on b19 b15) (clear b19)
	(on-table b4) (on b6 b4) (on b7 b6) (on b18 b7) (clear b18)
	(on-table b5) (on b8 b5) (on b9 b8) (on b13 b9) (on b17 b13) (clear b17)
	(on-table b20) (clear b20)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b2 b1) (on b4 b2) (on b7 b4) (on b11 b7) (on b13 b11) (on b15 b13) (on b16 b15) (on b18 b16) (clear b18)
	(on-table b3) (on b10 b3) (clear b10)
	(on-table b5) (on b6 b5) (on b8 b6) (on b9 b8) (on b19 b9) (clear b19)
	(on-table b12) (on b14 b12) (clear b14)
	(on-table b17) (on b20 b17) (clear b20)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p20_44 blocks-hgn
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
	(on-table b1) (on b2 b1) (on b4 b2) (on b6 b4) (on b7 b6) (on b16 b7) (clear b16)
	(on-table b3) (on b5 b3) (on b8 b5) (on b9 b8) (on b10 b9) (on b11 b10) (on b12 b11) (on b13 b12) (on b18 b13) (clear b18)
	(on-table b14) (on b19 b14) (on b20 b19) (clear b20)
	(on-table b15) (on b17 b15) (clear b17)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b3 b1) (on b9 b3) (on b11 b9) (on b14 b11) (clear b14)
	(on-table b2) (on b5 b2) (on b6 b5) (on b12 b6) (on b13 b12) (clear b13)
	(on-table b4) (on b8 b4) (on b15 b8) (on b16 b15) (clear b16)
	(on-table b7) (on b10 b7) (on b19 b10) (clear b19)
	(on-table b17) (on b18 b17) (on b20 b18) (clear b20)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p20_45 blocks-hgn
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
	(on-table b1) (on b2 b1) (on b4 b2) (on b6 b4) (on b7 b6) (on b13 b7) (on b14 b13) (on b20 b14) (clear b20)
	(on-table b3) (on b5 b3) (on b8 b5) (on b9 b8) (on b18 b9) (clear b18)
	(on-table b10) (on b11 b10) (on b12 b11) (on b15 b12) (on b17 b15) (clear b17)
	(on-table b16) (on b19 b16) (clear b19)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b2 b1) (on b3 b2) (on b8 b3) (clear b8)
	(on-table b4) (on b5 b4) (on b6 b5) (on b7 b6) (on b9 b7) (on b12 b9) (on b19 b12) (on b20 b19) (clear b20)
	(on-table b10) (on b13 b10) (on b15 b13) (on b17 b15) (on b18 b17) (clear b18)
	(on-table b11) (on b14 b11) (on b16 b14) (clear b16)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p20_46 blocks-hgn
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
	(on-table b1) (clear b1)
	(on-table b2) (on b15 b2) (on b16 b15) (on b18 b16) (on b19 b18) (clear b19)
	(on-table b3) (on b4 b3) (on b6 b4) (on b9 b6) (on b17 b9) (on b20 b17) (clear b20)
	(on-table b5) (on b7 b5) (on b10 b7) (clear b10)
	(on-table b8) (on b11 b8) (on b12 b11) (on b13 b12) (clear b13)
	(on-table b14) (clear b14)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b2 b1) (on b3 b2) (on b7 b3) (on b9 b7) (on b10 b9) (on b11 b10) (on b12 b11) (on b15 b12) (on b16 b15) (clear b16)
	(on-table b4) (on b5 b4) (on b6 b5) (on b8 b6) (on b17 b8) (clear b17)
	(on-table b13) (on b14 b13) (clear b14)
	(on-table b18) (on b19 b18) (clear b19)
	(on-table b20) (clear b20)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p20_47 blocks-hgn
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
	(on-table b1) (on b2 b1) (on b3 b2) (on b4 b3) (on b5 b4) (on b6 b5) (on b7 b6) (clear b7)
	(on-table b8) (on b9 b8) (on b10 b9) (on b12 b10) (on b14 b12) (on b17 b14) (on b19 b17) (clear b19)
	(on-table b11) (on b13 b11) (on b18 b13) (on b20 b18) (clear b20)
	(on-table b15) (on b16 b15) (clear b16)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b2 b1) (on b3 b2) (on b4 b3) (clear b4)
	(on-table b5) (on b7 b5) (on b8 b7) (on b12 b8) (on b18 b12) (clear b18)
	(on-table b6) (on b13 b6) (on b14 b13) (on b15 b14) (clear b15)
	(on-table b9) (clear b9)
	(on-table b10) (on b16 b10) (clear b16)
	(on-table b11) (clear b11)
	(on-table b17) (on b20 b17) (clear b20)
	(on-table b19) (clear b19)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p20_48 blocks-hgn
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
	(on-table b1) (on b3 b1) (on b4 b3) (on b9 b4) (on b14 b9) (on b15 b14) (clear b15)
	(on-table b2) (on b12 b2) (clear b12)
	(on-table b5) (on b8 b5) (clear b8)
	(on-table b6) (on b10 b6) (on b11 b10) (on b19 b11) (on b20 b19) (clear b20)
	(on-table b7) (on b13 b7) (on b16 b13) (on b17 b16) (clear b17)
	(on-table b18) (clear b18)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b2 b1) (on b3 b2) (on b4 b3) (on b15 b4) (clear b15)
	(on-table b5) (on b6 b5) (on b7 b6) (on b11 b7) (on b13 b11) (on b14 b13) (on b18 b14) (clear b18)
	(on-table b8) (on b9 b8) (clear b9)
	(on-table b10) (clear b10)
	(on-table b12) (on b17 b12) (clear b17)
	(on-table b16) (on b19 b16) (clear b19)
	(on-table b20) (clear b20)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p20_49 blocks-hgn
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
	(on-table b1) (on b2 b1) (on b10 b2) (on b12 b10) (on b20 b12) (clear b20)
	(on-table b3) (on b5 b3) (on b6 b5) (on b9 b6) (on b13 b9) (on b14 b13) (clear b14)
	(on-table b4) (on b7 b4) (on b8 b7) (clear b8)
	(on-table b11) (clear b11)
	(on-table b15) (on b16 b15) (clear b16)
	(on-table b17) (on b18 b17) (on b19 b18) (clear b19)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b9 b1) (on b14 b9) (clear b14)
	(on-table b2) (on b3 b2) (on b4 b3) (on b5 b4) (on b6 b5) (on b10 b6) (on b16 b10) (on b17 b16) (on b18 b17) (clear b18)
	(on-table b7) (on b8 b7) (on b11 b8) (on b12 b11) (on b19 b12) (on b20 b19) (clear b20)
	(on-table b13) (on b15 b13) (clear b15)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p20_50 blocks-hgn
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
	(on-table b1) (on b6 b1) (on b7 b6) (on b10 b7) (on b11 b10) (on b17 b11) (on b18 b17) (clear b18)
	(on-table b2) (on b3 b2) (on b5 b3) (on b8 b5) (on b12 b8) (on b15 b12) (clear b15)
	(on-table b4) (on b9 b4) (on b13 b9) (on b14 b13) (on b16 b14) (on b19 b16) (on b20 b19) (clear b20)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b6 b1) (on b13 b6) (on b15 b13) (on b17 b15) (clear b17)
	(on-table b2) (on b3 b2) (on b5 b3) (on b7 b5) (on b9 b7) (on b14 b9) (on b20 b14) (clear b20)
	(on-table b4) (clear b4)
	(on-table b8) (on b10 b8) (on b11 b10) (clear b11)
	(on-table b12) (on b16 b12) (on b19 b16) (clear b19)
	(on-table b18) (clear b18)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p20_51 blocks-hgn
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
	(on-table b1) (on b6 b1) (clear b6)
	(on-table b2) (on b5 b2) (on b11 b5) (on b14 b11) (on b16 b14) (clear b16)
	(on-table b3) (on b9 b3) (on b12 b9) (on b17 b12) (clear b17)
	(on-table b4) (on b7 b4) (on b8 b7) (on b10 b8) (clear b10)
	(on-table b13) (on b15 b13) (on b18 b15) (clear b18)
	(on-table b19) (on b20 b19) (clear b20)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b2 b1) (on b8 b2) (on b11 b8) (on b12 b11) (on b13 b12) (clear b13)
	(on-table b3) (on b4 b3) (on b5 b4) (on b9 b5) (on b15 b9) (clear b15)
	(on-table b6) (on b10 b6) (on b19 b10) (clear b19)
	(on-table b7) (on b16 b7) (on b17 b16) (on b18 b17) (clear b18)
	(on-table b14) (on b20 b14) (clear b20)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p20_52 blocks-hgn
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
	(on-table b1) (on b2 b1) (on b5 b2) (on b6 b5) (on b8 b6) (on b9 b8) (on b11 b9) (on b12 b11) (on b17 b12) (clear b17)
	(on-table b3) (on b7 b3) (on b19 b7) (clear b19)
	(on-table b4) (on b10 b4) (on b14 b10) (on b16 b14) (clear b16)
	(on-table b13) (clear b13)
	(on-table b15) (on b20 b15) (clear b20)
	(on-table b18) (clear b18)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b11 b1) (on b12 b11) (on b16 b12) (on b17 b16) (clear b17)
	(on-table b2) (on b4 b2) (on b8 b4) (on b15 b8) (clear b15)
	(on-table b3) (on b5 b3) (clear b5)
	(on-table b6) (on b7 b6) (on b10 b7) (on b14 b10) (on b19 b14) (clear b19)
	(on-table b9) (on b13 b9) (clear b13)
	(on-table b18) (on b20 b18) (clear b20)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p20_53 blocks-hgn
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
	(on-table b1) (on b2 b1) (on b3 b2) (on b4 b3) (on b8 b4) (on b9 b8) (on b10 b9) (clear b10)
	(on-table b5) (on b11 b5) (on b13 b11) (on b14 b13) (clear b14)
	(on-table b6) (on b7 b6) (on b16 b7) (on b17 b16) (on b18 b17) (clear b18)
	(on-table b12) (clear b12)
	(on-table b15) (on b19 b15) (clear b19)
	(on-table b20) (clear b20)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b2 b1) (on b3 b2) (on b5 b3) (on b10 b5) (on b12 b10) (on b15 b12) (on b16 b15) (on b17 b16) (clear b17)
	(on-table b4) (on b6 b4) (on b7 b6) (on b8 b7) (on b14 b8) (on b18 b14) (on b19 b18) (clear b19)
	(on-table b9) (on b11 b9) (on b20 b11) (clear b20)
	(on-table b13) (clear b13)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p20_54 blocks-hgn
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
	(on-table b1) (on b2 b1) (on b7 b2) (on b9 b7) (on b12 b9) (on b13 b12) (on b15 b13) (clear b15)
	(on-table b3) (on b5 b3) (on b6 b5) (on b16 b6) (clear b16)
	(on-table b4) (on b8 b4) (on b11 b8) (on b17 b11) (on b18 b17) (on b19 b18) (clear b19)
	(on-table b10) (on b14 b10) (clear b14)
	(on-table b20) (clear b20)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b13 b1) (clear b13)
	(on-table b2) (on b8 b2) (on b10 b8) (on b11 b10) (on b12 b11) (on b17 b12) (on b18 b17) (on b19 b18) (clear b19)
	(on-table b3) (on b7 b3) (on b20 b7) (clear b20)
	(on-table b4) (clear b4)
	(on-table b5) (on b6 b5) (on b9 b6) (on b15 b9) (clear b15)
	(on-table b14) (on b16 b14) (clear b16)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p20_55 blocks-hgn
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
	(on-table b1) (on b4 b1) (on b5 b4) (on b7 b5) (on b8 b7) (on b12 b8) (on b13 b12) (on b14 b13) (on b17 b14) (on b20 b17) (clear b20)
	(on-table b2) (on b9 b2) (on b18 b9) (on b19 b18) (clear b19)
	(on-table b3) (on b6 b3) (on b15 b6) (clear b15)
	(on-table b10) (on b11 b10) (on b16 b11) (clear b16)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b2 b1) (clear b2)
	(on-table b3) (on b4 b3) (on b5 b4) (on b9 b5) (on b11 b9) (on b14 b11) (on b15 b14) (on b19 b15) (clear b19)
	(on-table b6) (on b12 b6) (clear b12)
	(on-table b7) (on b8 b7) (on b17 b8) (on b18 b17) (clear b18)
	(on-table b10) (clear b10)
	(on-table b13) (on b16 b13) (clear b16)
	(on-table b20) (clear b20)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p20_56 blocks-hgn
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
	(on-table b1) (on b2 b1) (clear b2)
	(on-table b3) (on b6 b3) (on b9 b6) (on b12 b9) (on b13 b12) (on b16 b13) (clear b16)
	(on-table b4) (on b5 b4) (on b7 b5) (on b17 b7) (on b20 b17) (clear b20)
	(on-table b8) (on b11 b8) (on b14 b11) (clear b14)
	(on-table b10) (on b15 b10) (on b18 b15) (clear b18)
	(on-table b19) (clear b19)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b4 b1) (on b6 b4) (on b9 b6) (on b15 b9) (on b17 b15) (on b18 b17) (clear b18)
	(on-table b2) (on b3 b2) (on b8 b3) (on b13 b8) (clear b13)
	(on-table b5) (on b12 b5) (on b19 b12) (clear b19)
	(on-table b7) (on b10 b7) (on b11 b10) (on b14 b11) (clear b14)
	(on-table b16) (on b20 b16) (clear b20)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p20_57 blocks-hgn
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
	(on-table b1) (on b2 b1) (on b4 b2) (on b6 b4) (on b9 b6) (on b11 b9) (on b16 b11) (clear b16)
	(on-table b3) (on b7 b3) (on b8 b7) (on b10 b8) (on b13 b10) (on b17 b13) (clear b17)
	(on-table b5) (on b12 b5) (on b15 b12) (on b18 b15) (on b19 b18) (on b20 b19) (clear b20)
	(on-table b14) (clear b14)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b6 b1) (on b7 b6) (on b11 b7) (on b15 b11) (clear b15)
	(on-table b2) (on b4 b2) (on b9 b4) (on b10 b9) (on b17 b10) (clear b17)
	(on-table b3) (on b8 b3) (on b12 b8) (on b13 b12) (on b16 b13) (on b19 b16) (clear b19)
	(on-table b5) (clear b5)
	(on-table b14) (on b18 b14) (on b20 b18) (clear b20)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p20_58 blocks-hgn
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
	(on-table b1) (on b3 b1) (clear b3)
	(on-table b2) (on b4 b2) (on b5 b4) (on b11 b5) (on b16 b11) (on b17 b16) (clear b17)
	(on-table b6) (on b7 b6) (on b8 b7) (on b9 b8) (on b10 b9) (on b13 b10) (on b19 b13) (clear b19)
	(on-table b12) (on b20 b12) (clear b20)
	(on-table b14) (clear b14)
	(on-table b15) (clear b15)
	(on-table b18) (clear b18)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b11 b1) (on b12 b11) (on b14 b12) (on b15 b14) (on b18 b15) (clear b18)
	(on-table b2) (on b4 b2) (on b10 b4) (clear b10)
	(on-table b3) (on b5 b3) (on b6 b5) (on b7 b6) (on b8 b7) (on b9 b8) (on b13 b9) (clear b13)
	(on-table b16) (clear b16)
	(on-table b17) (on b19 b17) (on b20 b19) (clear b20)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p20_59 blocks-hgn
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
	(on-table b1) (on b2 b1) (on b3 b2) (on b4 b3) (on b5 b4) (on b6 b5) (on b8 b6) (on b10 b8) (on b13 b10) (clear b13)
	(on-table b7) (on b9 b7) (on b11 b9) (on b16 b11) (on b17 b16) (clear b17)
	(on-table b12) (on b14 b12) (clear b14)
	(on-table b15) (clear b15)
	(on-table b18) (clear b18)
	(on-table b19) (on b20 b19) (clear b20)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b2 b1) (on b4 b2) (on b16 b4) (on b20 b16) (clear b20)
	(on-table b3) (on b5 b3) (on b8 b5) (on b18 b8) (clear b18)
	(on-table b6) (on b11 b6) (on b17 b11) (clear b17)
	(on-table b7) (on b9 b7) (on b13 b9) (on b14 b13) (clear b14)
	(on-table b10) (on b12 b10) (clear b12)
	(on-table b15) (clear b15)
	(on-table b19) (clear b19)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p20_60 blocks-hgn
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
	(on-table b1) (on b3 b1) (on b12 b3) (on b14 b12) (on b19 b14) (clear b19)
	(on-table b2) (on b8 b2) (on b13 b8) (on b15 b13) (clear b15)
	(on-table b4) (on b5 b4) (on b6 b5) (clear b6)
	(on-table b7) (on b16 b7) (on b17 b16) (clear b17)
	(on-table b9) (on b18 b9) (on b20 b18) (clear b20)
	(on-table b10) (on b11 b10) (clear b11)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b16 b1) (on b18 b16) (clear b18)
	(on-table b2) (on b6 b2) (clear b6)
	(on-table b3) (on b5 b3) (on b7 b5) (on b8 b7) (on b12 b8) (on b19 b12) (on b20 b19) (clear b20)
	(on-table b4) (on b14 b4) (clear b14)
	(on-table b9) (on b11 b9) (clear b11)
	(on-table b10) (on b17 b10) (clear b17)
	(on-table b13) (clear b13)
	(on-table b15) (clear b15)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p20_61 blocks-hgn
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
	(on-table b1) (on b2 b1) (on b8 b2) (on b10 b8) (on b16 b10) (on b18 b16) (clear b18)
	(on-table b3) (clear b3)
	(on-table b4) (on b5 b4) (on b7 b5) (on b9 b7) (on b20 b9) (clear b20)
	(on-table b6) (on b11 b6) (on b12 b11) (on b13 b12) (on b17 b13) (clear b17)
	(on-table b14) (on b15 b14) (on b19 b15) (clear b19)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b3 b1) (on b5 b3) (on b9 b5) (on b11 b9) (on b18 b11) (clear b18)
	(on-table b2) (on b4 b2) (on b7 b4) (on b14 b7) (clear b14)
	(on-table b6) (on b8 b6) (on b13 b8) (on b16 b13) (on b17 b16) (clear b17)
	(on-table b10) (on b15 b10) (on b19 b15) (clear b19)
	(on-table b12) (clear b12)
	(on-table b20) (clear b20)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p20_62 blocks-hgn
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
	(on-table b1) (on b2 b1) (on b3 b2) (on b4 b3) (on b5 b4) (on b7 b5) (clear b7)
	(on-table b6) (on b9 b6) (on b15 b9) (on b19 b15) (clear b19)
	(on-table b8) (on b10 b8) (on b11 b10) (on b12 b11) (on b13 b12) (clear b13)
	(on-table b14) (on b16 b14) (clear b16)
	(on-table b17) (on b18 b17) (on b20 b18) (clear b20)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b4 b1) (on b16 b4) (on b18 b16) (on b20 b18) (clear b20)
	(on-table b2) (on b7 b2) (on b10 b7) (clear b10)
	(on-table b3) (on b5 b3) (on b6 b5) (on b9 b6) (on b11 b9) (on b14 b11) (on b15 b14) (on b17 b15) (clear b17)
	(on-table b8) (clear b8)
	(on-table b12) (on b13 b12) (on b19 b13) (clear b19)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p20_63 blocks-hgn
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
	(on-table b1) (on b14 b1) (clear b14)
	(on-table b2) (on b7 b2) (on b10 b7) (on b15 b10) (clear b15)
	(on-table b3) (on b13 b3) (on b19 b13) (clear b19)
	(on-table b4) (on b5 b4) (on b8 b5) (on b9 b8) (on b11 b9) (on b20 b11) (clear b20)
	(on-table b6) (on b12 b6) (clear b12)
	(on-table b16) (on b17 b16) (on b18 b17) (clear b18)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b3 b1) (on b6 b3) (on b7 b6) (on b9 b7) (on b11 b9) (on b18 b11) (clear b18)
	(on-table b2) (on b10 b2) (on b14 b10) (clear b14)
	(on-table b4) (on b5 b4) (on b20 b5) (clear b20)
	(on-table b8) (on b12 b8) (on b13 b12) (on b15 b13) (on b16 b15) (on b17 b16) (clear b17)
	(on-table b19) (clear b19)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p20_64 blocks-hgn
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
	(on-table b1) (on b2 b1) (on b3 b2) (on b5 b3) (on b17 b5) (clear b17)
	(on-table b4) (on b8 b4) (on b10 b8) (on b11 b10) (on b13 b11) (clear b13)
	(on-table b6) (on b16 b6) (on b18 b16) (on b19 b18) (clear b19)
	(on-table b7) (clear b7)
	(on-table b9) (on b12 b9) (clear b12)
	(on-table b14) (on b15 b14) (on b20 b15) (clear b20)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b2 b1) (on b3 b2) (on b5 b3) (on b7 b5) (clear b7)
	(on-table b4) (on b11 b4) (on b12 b11) (on b15 b12) (clear b15)
	(on-table b6) (on b18 b6) (on b19 b18) (clear b19)
	(on-table b8) (on b9 b8) (on b10 b9) (on b16 b10) (on b17 b16) (on b20 b17) (clear b20)
	(on-table b13) (clear b13)
	(on-table b14) (clear b14)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p20_65 blocks-hgn
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
	(on-table b1) (on b2 b1) (on b3 b2) (on b4 b3) (on b9 b4) (on b11 b9) (on b12 b11) (on b13 b12) (clear b13)
	(on-table b5) (on b7 b5) (on b8 b7) (clear b8)
	(on-table b6) (on b10 b6) (on b17 b10) (on b19 b17) (clear b19)
	(on-table b14) (on b15 b14) (clear b15)
	(on-table b16) (clear b16)
	(on-table b18) (on b20 b18) (clear b20)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b2 b1) (on b6 b2) (on b7 b6) (on b8 b7) (on b10 b8) (on b14 b10) (on b17 b14) (clear b17)
	(on-table b3) (on b11 b3) (on b12 b11) (on b18 b12) (on b19 b18) (on b20 b19) (clear b20)
	(on-table b4) (on b5 b4) (on b13 b5) (clear b13)
	(on-table b9) (on b16 b9) (clear b16)
	(on-table b15) (clear b15)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p20_66 blocks-hgn
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
	(on-table b1) (on b2 b1) (on b3 b2) (on b4 b3) (on b5 b4) (on b10 b5) (on b15 b10) (clear b15)
	(on-table b6) (on b7 b6) (on b17 b7) (on b20 b17) (clear b20)
	(on-table b8) (on b11 b8) (clear b11)
	(on-table b9) (on b14 b9) (on b16 b14) (on b18 b16) (on b19 b18) (clear b19)
	(on-table b12) (on b13 b12) (clear b13)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b2 b1) (on b5 b2) (on b7 b5) (on b9 b7) (on b14 b9) (on b16 b14) (on b17 b16) (clear b17)
	(on-table b3) (on b4 b3) (on b13 b4) (on b15 b13) (on b18 b15) (on b20 b18) (clear b20)
	(on-table b6) (on b8 b6) (on b10 b8) (on b11 b10) (on b12 b11) (on b19 b12) (clear b19)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p20_67 blocks-hgn
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
	(on-table b1) (on b2 b1) (on b3 b2) (on b4 b3) (on b9 b4) (clear b9)
	(on-table b5) (on b7 b5) (on b10 b7) (on b19 b10) (clear b19)
	(on-table b6) (clear b6)
	(on-table b8) (on b11 b8) (on b12 b11) (on b15 b12) (on b20 b15) (clear b20)
	(on-table b13) (clear b13)
	(on-table b14) (on b18 b14) (clear b18)
	(on-table b16) (on b17 b16) (clear b17)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b6 b1) (on b20 b6) (clear b20)
	(on-table b2) (on b19 b2) (clear b19)
	(on-table b3) (on b4 b3) (on b5 b4) (on b15 b5) (clear b15)
	(on-table b7) (on b8 b7) (clear b8)
	(on-table b9) (on b10 b9) (on b12 b10) (on b13 b12) (on b18 b13) (clear b18)
	(on-table b11) (clear b11)
	(on-table b14) (on b16 b14) (clear b16)
	(on-table b17) (clear b17)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p20_68 blocks-hgn
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
	(on-table b1) (on b2 b1) (on b3 b2) (on b4 b3) (on b8 b4) (on b12 b8) (clear b12)
	(on-table b5) (on b6 b5) (on b20 b6) (clear b20)
	(on-table b7) (on b11 b7) (on b17 b11) (clear b17)
	(on-table b9) (on b14 b9) (on b15 b14) (clear b15)
	(on-table b10) (on b13 b10) (on b18 b13) (clear b18)
	(on-table b16) (on b19 b16) (clear b19)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b2 b1) (on b4 b2) (on b7 b4) (on b9 b7) (on b11 b9) (on b12 b11) (on b14 b12) (on b16 b14) (clear b16)
	(on-table b3) (on b5 b3) (on b6 b5) (on b10 b6) (on b15 b10) (on b18 b15) (clear b18)
	(on-table b8) (clear b8)
	(on-table b13) (clear b13)
	(on-table b17) (on b19 b17) (clear b19)
	(on-table b20) (clear b20)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p20_69 blocks-hgn
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
	(on-table b1) (on b4 b1) (on b5 b4) (on b8 b5) (on b12 b8) (on b18 b12) (on b19 b18) (clear b19)
	(on-table b2) (on b3 b2) (on b14 b3) (on b15 b14) (clear b15)
	(on-table b6) (on b10 b6) (on b11 b10) (clear b11)
	(on-table b7) (on b16 b7) (clear b16)
	(on-table b9) (on b17 b9) (clear b17)
	(on-table b13) (clear b13)
	(on-table b20) (clear b20)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b5 b1) (on b6 b5) (on b18 b6) (clear b18)
	(on-table b2) (on b3 b2) (on b4 b3) (on b7 b4) (clear b7)
	(on-table b8) (on b9 b8) (on b11 b9) (on b14 b11) (on b15 b14) (clear b15)
	(on-table b10) (on b13 b10) (clear b13)
	(on-table b12) (on b19 b12) (clear b19)
	(on-table b16) (on b20 b16) (clear b20)
	(on-table b17) (clear b17)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p20_70 blocks-hgn
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
	(on-table b1) (on b2 b1) (on b3 b2) (on b7 b3) (on b12 b7) (on b20 b12) (clear b20)
	(on-table b4) (on b5 b4) (on b9 b5) (on b10 b9) (on b11 b10) (clear b11)
	(on-table b6) (on b8 b6) (on b14 b8) (on b16 b14) (clear b16)
	(on-table b13) (clear b13)
	(on-table b15) (on b17 b15) (clear b17)
	(on-table b18) (on b19 b18) (clear b19)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b2 b1) (on b3 b2) (on b4 b3) (on b10 b4) (on b13 b10) (clear b13)
	(on-table b5) (on b6 b5) (on b7 b6) (on b14 b7) (on b17 b14) (clear b17)
	(on-table b8) (on b9 b8) (on b12 b9) (clear b12)
	(on-table b11) (on b19 b11) (clear b19)
	(on-table b15) (on b16 b15) (on b18 b16) (clear b18)
	(on-table b20) (clear b20)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p20_71 blocks-hgn
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
	(on-table b1) (on b2 b1) (on b5 b2) (on b8 b5) (clear b8)
	(on-table b3) (on b4 b3) (on b6 b4) (on b12 b6) (on b15 b12) (on b18 b15) (clear b18)
	(on-table b7) (on b9 b7) (on b14 b9) (clear b14)
	(on-table b10) (on b16 b10) (on b20 b16) (clear b20)
	(on-table b11) (on b13 b11) (on b17 b13) (on b19 b17) (clear b19)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b2 b1) (on b4 b2) (on b6 b4) (on b14 b6) (on b15 b14) (on b18 b15) (on b20 b18) (clear b20)
	(on-table b3) (on b5 b3) (on b11 b5) (on b12 b11) (on b13 b12) (on b17 b13) (on b19 b17) (clear b19)
	(on-table b7) (on b8 b7) (on b10 b8) (clear b10)
	(on-table b9) (on b16 b9) (clear b16)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p20_72 blocks-hgn
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
	(on-table b1) (on b6 b1) (on b7 b6) (on b9 b7) (on b10 b9) (on b11 b10) (on b12 b11) (on b14 b12) (on b20 b14) (clear b20)
	(on-table b2) (on b3 b2) (on b4 b3) (on b5 b4) (on b8 b5) (clear b8)
	(on-table b13) (on b19 b13) (clear b19)
	(on-table b15) (on b17 b15) (on b18 b17) (clear b18)
	(on-table b16) (clear b16)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b2 b1) (on b3 b2) (on b4 b3) (on b5 b4) (on b6 b5) (on b8 b6) (clear b8)
	(on-table b7) (on b9 b7) (on b12 b9) (clear b12)
	(on-table b10) (on b20 b10) (clear b20)
	(on-table b11) (on b13 b11) (on b14 b13) (on b15 b14) (on b16 b15) (clear b16)
	(on-table b17) (on b18 b17) (on b19 b18) (clear b19)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p20_73 blocks-hgn
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
	(on-table b1) (on b16 b1) (on b18 b16) (on b20 b18) (clear b20)
	(on-table b2) (on b3 b2) (on b6 b3) (on b7 b6) (clear b7)
	(on-table b4) (on b5 b4) (on b10 b5) (on b17 b10) (clear b17)
	(on-table b8) (on b12 b8) (clear b12)
	(on-table b9) (on b11 b9) (on b14 b11) (on b15 b14) (clear b15)
	(on-table b13) (clear b13)
	(on-table b19) (clear b19)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b5 b1) (on b7 b5) (on b11 b7) (on b15 b11) (on b16 b15) (clear b16)
	(on-table b2) (on b3 b2) (on b6 b3) (on b8 b6) (on b13 b8) (on b14 b13) (on b17 b14) (on b18 b17) (clear b18)
	(on-table b4) (on b9 b4) (on b12 b9) (clear b12)
	(on-table b10) (clear b10)
	(on-table b19) (clear b19)
	(on-table b20) (clear b20)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p20_74 blocks-hgn
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
	(on-table b1) (on b2 b1) (on b3 b2) (on b4 b3) (on b5 b4) (on b11 b5) (on b15 b11) (on b20 b15) (clear b20)
	(on-table b6) (on b13 b6) (clear b13)
	(on-table b7) (on b9 b7) (on b14 b9) (on b17 b14) (clear b17)
	(on-table b8) (on b12 b8) (on b16 b12) (on b18 b16) (on b19 b18) (clear b19)
	(on-table b10) (clear b10)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b2 b1) (on b3 b2) (on b4 b3) (on b5 b4) (on b7 b5) (on b10 b7) (on b11 b10) (on b14 b11) (on b16 b14) (clear b16)
	(on-table b6) (clear b6)
	(on-table b8) (on b9 b8) (on b15 b9) (on b17 b15) (on b19 b17) (clear b19)
	(on-table b12) (on b13 b12) (clear b13)
	(on-table b18) (on b20 b18) (clear b20)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p20_75 blocks-hgn
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
	(on-table b1) (on b2 b1) (on b3 b2) (on b11 b3) (on b19 b11) (clear b19)
	(on-table b4) (on b8 b4) (on b18 b8) (clear b18)
	(on-table b5) (on b10 b5) (on b13 b10) (clear b13)
	(on-table b6) (on b14 b6) (on b17 b14) (clear b17)
	(on-table b7) (on b12 b7) (on b20 b12) (clear b20)
	(on-table b9) (clear b9)
	(on-table b15) (clear b15)
	(on-table b16) (clear b16)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b2 b1) (on b5 b2) (on b18 b5) (on b19 b18) (clear b19)
	(on-table b3) (on b12 b3) (on b15 b12) (clear b15)
	(on-table b4) (on b9 b4) (on b11 b9) (on b16 b11) (on b17 b16) (clear b17)
	(on-table b6) (on b8 b6) (on b14 b8) (on b20 b14) (clear b20)
	(on-table b7) (on b10 b7) (clear b10)
	(on-table b13) (clear b13)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p20_76 blocks-hgn
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
	(on-table b1) (on b3 b1) (on b4 b3) (on b5 b4) (on b10 b5) (on b17 b10) (on b18 b17) (clear b18)
	(on-table b2) (on b6 b2) (on b8 b6) (clear b8)
	(on-table b7) (on b12 b7) (on b14 b12) (clear b14)
	(on-table b9) (on b11 b9) (clear b11)
	(on-table b13) (clear b13)
	(on-table b15) (on b16 b15) (on b20 b16) (clear b20)
	(on-table b19) (clear b19)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b6 b1) (on b7 b6) (on b8 b7) (clear b8)
	(on-table b2) (on b3 b2) (on b9 b3) (on b10 b9) (on b11 b10) (on b12 b11) (on b14 b12) (on b16 b14) (on b17 b16) (on b20 b17) (clear b20)
	(on-table b4) (on b5 b4) (on b15 b5) (on b18 b15) (clear b18)
	(on-table b13) (clear b13)
	(on-table b19) (clear b19)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p20_77 blocks-hgn
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
	(on-table b1) (on b3 b1) (on b9 b3) (on b10 b9) (on b11 b10) (on b13 b11) (on b14 b13) (on b16 b14) (on b18 b16) (clear b18)
	(on-table b2) (on b4 b2) (on b5 b4) (on b6 b5) (on b7 b6) (on b8 b7) (on b12 b8) (on b17 b12) (on b19 b17) (clear b19)
	(on-table b15) (clear b15)
	(on-table b20) (clear b20)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b2 b1) (on b6 b2) (on b13 b6) (on b16 b13) (on b19 b16) (clear b19)
	(on-table b3) (on b5 b3) (on b11 b5) (on b12 b11) (clear b12)
	(on-table b4) (on b7 b4) (on b14 b7) (clear b14)
	(on-table b8) (on b9 b8) (on b10 b9) (clear b10)
	(on-table b15) (clear b15)
	(on-table b17) (on b18 b17) (clear b18)
	(on-table b20) (clear b20)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p20_78 blocks-hgn
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
	(on-table b1) (on b2 b1) (on b3 b2) (on b4 b3) (on b7 b4) (on b12 b7) (on b19 b12) (clear b19)
	(on-table b5) (on b6 b5) (on b8 b6) (on b10 b8) (on b18 b10) (on b20 b18) (clear b20)
	(on-table b9) (clear b9)
	(on-table b11) (on b16 b11) (on b17 b16) (clear b17)
	(on-table b13) (on b15 b13) (clear b15)
	(on-table b14) (clear b14)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b2 b1) (on b8 b2) (on b11 b8) (clear b11)
	(on-table b3) (on b5 b3) (on b14 b5) (clear b14)
	(on-table b4) (on b6 b4) (on b9 b6) (on b15 b9) (on b18 b15) (on b20 b18) (clear b20)
	(on-table b7) (on b13 b7) (on b19 b13) (clear b19)
	(on-table b10) (clear b10)
	(on-table b12) (on b16 b12) (on b17 b16) (clear b17)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p20_79 blocks-hgn
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
	(on-table b1) (on b4 b1) (on b6 b4) (on b9 b6) (on b11 b9) (clear b11)
	(on-table b2) (on b12 b2) (on b16 b12) (on b18 b16) (on b20 b18) (clear b20)
	(on-table b3) (on b8 b3) (on b13 b8) (on b17 b13) (on b19 b17) (clear b19)
	(on-table b5) (on b7 b5) (on b10 b7) (clear b10)
	(on-table b14) (on b15 b14) (clear b15)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b10 b1) (on b14 b10) (on b16 b14) (on b18 b16) (on b20 b18) (clear b20)
	(on-table b2) (on b3 b2) (on b4 b3) (on b5 b4) (on b6 b5) (on b8 b6) (on b12 b8) (clear b12)
	(on-table b7) (on b17 b7) (clear b17)
	(on-table b9) (on b15 b9) (clear b15)
	(on-table b11) (clear b11)
	(on-table b13) (clear b13)
	(on-table b19) (clear b19)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p20_80 blocks-hgn
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
	(on-table b1) (clear b1)
	(on-table b2) (on b5 b2) (on b8 b5) (clear b8)
	(on-table b3) (on b4 b3) (on b9 b4) (on b10 b9) (on b12 b10) (on b13 b12) (on b15 b13) (clear b15)
	(on-table b6) (on b7 b6) (on b11 b7) (on b14 b11) (on b17 b14) (clear b17)
	(on-table b16) (on b20 b16) (clear b20)
	(on-table b18) (clear b18)
	(on-table b19) (clear b19)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b2 b1) (on b3 b2) (on b4 b3) (on b12 b4) (on b13 b12) (on b14 b13) (on b15 b14) (on b18 b15) (clear b18)
	(on-table b5) (on b6 b5) (on b7 b6) (on b11 b7) (on b19 b11) (clear b19)
	(on-table b8) (on b9 b8) (on b10 b9) (clear b10)
	(on-table b16) (on b17 b16) (on b20 b17) (clear b20)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p20_81 blocks-hgn
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
	(on-table b1) (on b3 b1) (on b5 b3) (on b9 b5) (on b18 b9) (on b19 b18) (clear b19)
	(on-table b2) (on b7 b2) (on b8 b7) (on b10 b8) (on b14 b10) (clear b14)
	(on-table b4) (on b6 b4) (on b11 b6) (on b12 b11) (on b13 b12) (on b17 b13) (clear b17)
	(on-table b15) (on b16 b15) (on b20 b16) (clear b20)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b2 b1) (on b3 b2) (on b4 b3) (on b5 b4) (on b12 b5) (on b13 b12) (on b18 b13) (on b19 b18) (clear b19)
	(on-table b6) (on b9 b6) (on b17 b9) (clear b17)
	(on-table b7) (on b8 b7) (on b10 b8) (on b11 b10) (on b14 b11) (on b15 b14) (on b16 b15) (on b20 b16) (clear b20)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p20_82 blocks-hgn
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
	(on-table b1) (on b11 b1) (clear b11)
	(on-table b2) (on b3 b2) (on b4 b3) (on b5 b4) (on b7 b5) (on b8 b7) (on b13 b8) (on b14 b13) (clear b14)
	(on-table b6) (on b9 b6) (on b10 b9) (on b12 b10) (on b18 b12) (clear b18)
	(on-table b15) (on b16 b15) (clear b16)
	(on-table b17) (clear b17)
	(on-table b19) (on b20 b19) (clear b20)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b4 b1) (on b5 b4) (on b9 b5) (on b11 b9) (on b12 b11) (on b14 b12) (on b17 b14) (on b19 b17) (clear b19)
	(on-table b2) (on b8 b2) (on b10 b8) (on b13 b10) (clear b13)
	(on-table b3) (on b6 b3) (on b15 b6) (on b20 b15) (clear b20)
	(on-table b7) (on b16 b7) (on b18 b16) (clear b18)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p20_83 blocks-hgn
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
	(on-table b1) (on b2 b1) (on b5 b2) (on b20 b5) (clear b20)
	(on-table b3) (on b6 b3) (on b7 b6) (on b8 b7) (clear b8)
	(on-table b4) (on b9 b4) (on b11 b9) (on b14 b11) (on b15 b14) (on b17 b15) (on b19 b17) (clear b19)
	(on-table b10) (on b12 b10) (on b13 b12) (on b16 b13) (on b18 b16) (clear b18)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b4 b1) (on b16 b4) (on b17 b16) (clear b17)
	(on-table b2) (on b3 b2) (on b5 b3) (on b11 b5) (on b13 b11) (on b20 b13) (clear b20)
	(on-table b6) (on b7 b6) (on b9 b7) (on b12 b9) (clear b12)
	(on-table b8) (on b10 b8) (clear b10)
	(on-table b14) (on b15 b14) (on b18 b15) (on b19 b18) (clear b19)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p20_84 blocks-hgn
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
	(on-table b1) (on b3 b1) (on b7 b3) (on b11 b7) (on b16 b11) (clear b16)
	(on-table b2) (on b5 b2) (on b6 b5) (clear b6)
	(on-table b4) (on b8 b4) (on b9 b8) (on b12 b9) (on b13 b12) (on b15 b13) (clear b15)
	(on-table b10) (clear b10)
	(on-table b14) (on b17 b14) (on b18 b17) (clear b18)
	(on-table b19) (on b20 b19) (clear b20)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b2 b1) (on b5 b2) (on b6 b5) (on b11 b6) (on b12 b11) (on b16 b12) (on b19 b16) (on b20 b19) (clear b20)
	(on-table b3) (on b4 b3) (on b8 b4) (on b9 b8) (on b14 b9) (clear b14)
	(on-table b7) (on b10 b7) (on b13 b10) (on b15 b13) (on b18 b15) (clear b18)
	(on-table b17) (clear b17)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p20_85 blocks-hgn
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
	(on-table b1) (on b2 b1) (on b3 b2) (on b4 b3) (on b5 b4) (on b10 b5) (on b11 b10) (on b12 b11) (on b16 b12) (clear b16)
	(on-table b6) (on b7 b6) (on b13 b7) (on b17 b13) (clear b17)
	(on-table b8) (on b9 b8) (on b14 b9) (on b15 b14) (on b18 b15) (clear b18)
	(on-table b19) (on b20 b19) (clear b20)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b2 b1) (on b5 b2) (on b10 b5) (on b13 b10) (clear b13)
	(on-table b3) (on b4 b3) (on b14 b4) (on b16 b14) (on b19 b16) (on b20 b19) (clear b20)
	(on-table b6) (on b7 b6) (on b9 b7) (on b15 b9) (clear b15)
	(on-table b8) (clear b8)
	(on-table b11) (on b12 b11) (on b17 b12) (clear b17)
	(on-table b18) (clear b18)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p20_86 blocks-hgn
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
	(on-table b1) (on b2 b1) (on b7 b2) (on b10 b7) (clear b10)
	(on-table b3) (on b4 b3) (on b5 b4) (on b9 b5) (on b19 b9) (clear b19)
	(on-table b6) (on b8 b6) (on b16 b8) (on b17 b16) (clear b17)
	(on-table b11) (on b12 b11) (clear b12)
	(on-table b13) (on b15 b13) (on b18 b15) (clear b18)
	(on-table b14) (clear b14)
	(on-table b20) (clear b20)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b2 b1) (on b3 b2) (on b4 b3) (on b5 b4) (on b7 b5) (on b8 b7) (on b10 b8) (on b13 b10) (on b20 b13) (clear b20)
	(on-table b6) (on b9 b6) (on b16 b9) (on b17 b16) (clear b17)
	(on-table b11) (on b12 b11) (on b14 b12) (on b15 b14) (clear b15)
	(on-table b18) (clear b18)
	(on-table b19) (clear b19)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p20_87 blocks-hgn
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
	(on-table b1) (on b2 b1) (on b3 b2) (on b4 b3) (on b5 b4) (on b6 b5) (on b8 b6) (on b11 b8) (on b12 b11) (on b18 b12) (clear b18)
	(on-table b7) (on b10 b7) (on b14 b10) (on b15 b14) (clear b15)
	(on-table b9) (on b13 b9) (on b17 b13) (on b20 b17) (clear b20)
	(on-table b16) (clear b16)
	(on-table b19) (clear b19)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b3 b1) (on b12 b3) (clear b12)
	(on-table b2) (on b6 b2) (on b11 b6) (on b14 b11) (clear b14)
	(on-table b4) (on b5 b4) (on b8 b5) (on b16 b8) (clear b16)
	(on-table b7) (on b9 b7) (on b15 b9) (clear b15)
	(on-table b10) (on b13 b10) (on b17 b13) (on b19 b17) (clear b19)
	(on-table b18) (clear b18)
	(on-table b20) (clear b20)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p20_88 blocks-hgn
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
	(on-table b1) (on b2 b1) (on b3 b2) (on b4 b3) (on b5 b4) (on b6 b5) (on b8 b6) (on b9 b8) (on b13 b9) (on b14 b13) (on b15 b14) (on b18 b15) (clear b18)
	(on-table b7) (on b10 b7) (on b19 b10) (clear b19)
	(on-table b11) (on b12 b11) (on b17 b12) (clear b17)
	(on-table b16) (on b20 b16) (clear b20)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b10 b1) (on b13 b10) (on b15 b13) (on b18 b15) (clear b18)
	(on-table b2) (on b9 b2) (clear b9)
	(on-table b3) (on b4 b3) (on b6 b4) (on b8 b6) (clear b8)
	(on-table b5) (on b7 b5) (clear b7)
	(on-table b11) (on b12 b11) (clear b12)
	(on-table b14) (clear b14)
	(on-table b16) (on b19 b16) (clear b19)
	(on-table b17) (on b20 b17) (clear b20)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p20_89 blocks-hgn
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
	(on-table b1) (on b2 b1) (on b4 b2) (on b8 b4) (clear b8)
	(on-table b3) (on b6 b3) (on b7 b6) (on b11 b7) (clear b11)
	(on-table b5) (on b15 b5) (on b18 b15) (clear b18)
	(on-table b9) (clear b9)
	(on-table b10) (clear b10)
	(on-table b12) (on b13 b12) (on b20 b13) (clear b20)
	(on-table b14) (on b17 b14) (on b19 b17) (clear b19)
	(on-table b16) (clear b16)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b2 b1) (on b4 b2) (on b7 b4) (on b11 b7) (clear b11)
	(on-table b3) (on b5 b3) (on b6 b5) (on b10 b6) (on b16 b10) (clear b16)
	(on-table b8) (on b9 b8) (on b17 b9) (clear b17)
	(on-table b12) (on b13 b12) (clear b13)
	(on-table b14) (on b15 b14) (on b18 b15) (clear b18)
	(on-table b19) (on b20 b19) (clear b20)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p20_90 blocks-hgn
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
	(on-table b1) (on b4 b1) (on b5 b4) (on b7 b5) (on b8 b7) (on b9 b8) (on b10 b9) (on b14 b10) (on b16 b14) (on b19 b16) (clear b19)
	(on-table b2) (on b3 b2) (on b11 b3) (clear b11)
	(on-table b6) (on b12 b6) (on b17 b12) (on b20 b17) (clear b20)
	(on-table b13) (clear b13)
	(on-table b15) (clear b15)
	(on-table b18) (clear b18)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b5 b1) (on b6 b5) (on b7 b6) (on b8 b7) (on b10 b8) (on b15 b10) (clear b15)
	(on-table b2) (on b3 b2) (on b17 b3) (clear b17)
	(on-table b4) (on b9 b4) (on b12 b9) (on b16 b12) (clear b16)
	(on-table b11) (clear b11)
	(on-table b13) (clear b13)
	(on-table b14) (on b19 b14) (clear b19)
	(on-table b18) (clear b18)
	(on-table b20) (clear b20)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p20_91 blocks-hgn
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
	(on-table b1) (on b2 b1) (on b3 b2) (on b5 b3) (on b13 b5) (on b15 b13) (clear b15)
	(on-table b4) (on b9 b4) (on b11 b9) (clear b11)
	(on-table b6) (on b8 b6) (on b18 b8) (clear b18)
	(on-table b7) (on b12 b7) (on b17 b12) (clear b17)
	(on-table b10) (on b14 b10) (on b20 b14) (clear b20)
	(on-table b16) (clear b16)
	(on-table b19) (clear b19)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b20 b1) (clear b20)
	(on-table b2) (on b4 b2) (on b5 b4) (on b7 b5) (on b15 b7) (clear b15)
	(on-table b3) (on b9 b3) (on b14 b9) (on b17 b14) (clear b17)
	(on-table b6) (on b11 b6) (on b16 b11) (on b18 b16) (on b19 b18) (clear b19)
	(on-table b8) (clear b8)
	(on-table b10) (on b12 b10) (on b13 b12) (clear b13)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p20_92 blocks-hgn
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
	(on-table b1) (on b2 b1) (on b3 b2) (on b17 b3) (clear b17)
	(on-table b4) (on b5 b4) (on b10 b5) (on b14 b10) (clear b14)
	(on-table b6) (on b7 b6) (on b8 b7) (on b20 b8) (clear b20)
	(on-table b9) (on b13 b9) (clear b13)
	(on-table b11) (on b15 b11) (on b16 b15) (on b18 b16) (clear b18)
	(on-table b12) (on b19 b12) (clear b19)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b3 b1) (on b9 b3) (clear b9)
	(on-table b2) (on b6 b2) (on b7 b6) (on b17 b7) (clear b17)
	(on-table b4) (on b5 b4) (clear b5)
	(on-table b8) (on b10 b8) (on b12 b10) (on b13 b12) (on b19 b13) (on b20 b19) (clear b20)
	(on-table b11) (on b14 b11) (on b15 b14) (on b16 b15) (clear b16)
	(on-table b18) (clear b18)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p20_93 blocks-hgn
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
	(on-table b1) (on b5 b1) (on b6 b5) (on b10 b6) (on b11 b10) (on b15 b11) (on b19 b15) (clear b19)
	(on-table b2) (on b3 b2) (on b9 b3) (on b16 b9) (clear b16)
	(on-table b4) (on b7 b4) (on b8 b7) (on b17 b8) (clear b17)
	(on-table b12) (on b13 b12) (on b14 b13) (on b18 b14) (on b20 b18) (clear b20)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b3 b1) (on b19 b3) (on b20 b19) (clear b20)
	(on-table b2) (on b4 b2) (on b7 b4) (clear b7)
	(on-table b5) (on b8 b5) (on b11 b8) (on b17 b11) (clear b17)
	(on-table b6) (clear b6)
	(on-table b9) (on b13 b9) (clear b13)
	(on-table b10) (on b12 b10) (on b14 b12) (on b16 b14) (clear b16)
	(on-table b15) (on b18 b15) (clear b18)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p20_94 blocks-hgn
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
	(on-table b1) (on b2 b1) (on b4 b2) (on b8 b4) (on b11 b8) (on b12 b11) (on b17 b12) (on b18 b17) (on b19 b18) (clear b19)
	(on-table b3) (on b13 b3) (clear b13)
	(on-table b5) (on b10 b5) (on b14 b10) (on b16 b14) (clear b16)
	(on-table b6) (on b7 b6) (on b15 b7) (clear b15)
	(on-table b9) (clear b9)
	(on-table b20) (clear b20)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b8 b1) (on b12 b8) (on b16 b12) (on b20 b16) (clear b20)
	(on-table b2) (on b3 b2) (on b7 b3) (on b11 b7) (on b14 b11) (clear b14)
	(on-table b4) (on b9 b4) (on b13 b9) (on b17 b13) (clear b17)
	(on-table b5) (on b6 b5) (on b10 b6) (on b19 b10) (clear b19)
	(on-table b15) (on b18 b15) (clear b18)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p20_95 blocks-hgn
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
	(on-table b1) (on b2 b1) (on b7 b2) (on b17 b7) (on b19 b17) (clear b19)
	(on-table b3) (on b13 b3) (on b15 b13) (clear b15)
	(on-table b4) (on b6 b4) (on b20 b6) (clear b20)
	(on-table b5) (on b8 b5) (on b12 b8) (on b18 b12) (clear b18)
	(on-table b9) (on b10 b9) (on b14 b10) (clear b14)
	(on-table b11) (on b16 b11) (clear b16)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b3 b1) (on b8 b3) (on b12 b8) (on b16 b12) (clear b16)
	(on-table b2) (on b4 b2) (on b5 b4) (on b20 b5) (clear b20)
	(on-table b6) (on b7 b6) (on b13 b7) (on b19 b13) (clear b19)
	(on-table b9) (on b10 b9) (on b11 b10) (clear b11)
	(on-table b14) (on b17 b14) (clear b17)
	(on-table b15) (clear b15)
	(on-table b18) (clear b18)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p20_96 blocks-hgn
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
	(on-table b1) (on b2 b1) (on b3 b2) (on b6 b3) (on b8 b6) (on b10 b8) (on b13 b10) (on b14 b13) (on b15 b14) (on b17 b15) (clear b17)
	(on-table b4) (on b5 b4) (on b7 b5) (clear b7)
	(on-table b9) (on b12 b9) (on b16 b12) (on b19 b16) (clear b19)
	(on-table b11) (on b20 b11) (clear b20)
	(on-table b18) (clear b18)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b5 b1) (on b7 b5) (on b18 b7) (on b20 b18) (clear b20)
	(on-table b2) (on b3 b2) (on b9 b3) (on b14 b9) (on b16 b14) (on b17 b16) (on b19 b17) (clear b19)
	(on-table b4) (on b6 b4) (on b8 b6) (on b11 b8) (on b13 b11) (clear b13)
	(on-table b10) (clear b10)
	(on-table b12) (clear b12)
	(on-table b15) (clear b15)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p20_97 blocks-hgn
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
	(on-table b1) (on b11 b1) (on b12 b11) (on b16 b12) (on b18 b16) (on b20 b18) (clear b20)
	(on-table b2) (on b4 b2) (on b5 b4) (on b6 b5) (on b9 b6) (on b19 b9) (clear b19)
	(on-table b3) (on b7 b3) (clear b7)
	(on-table b8) (on b13 b8) (on b14 b13) (on b17 b14) (clear b17)
	(on-table b10) (clear b10)
	(on-table b15) (clear b15)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b2 b1) (on b7 b2) (on b18 b7) (clear b18)
	(on-table b3) (on b4 b3) (on b6 b4) (on b8 b6) (on b15 b8) (on b16 b15) (clear b16)
	(on-table b5) (on b10 b5) (on b13 b10) (clear b13)
	(on-table b9) (on b20 b9) (clear b20)
	(on-table b11) (clear b11)
	(on-table b12) (clear b12)
	(on-table b14) (on b17 b14) (on b19 b17) (clear b19)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p20_98 blocks-hgn
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
	(on-table b1) (on b5 b1) (on b8 b5) (clear b8)
	(on-table b2) (on b6 b2) (clear b6)
	(on-table b3) (on b15 b3) (clear b15)
	(on-table b4) (on b7 b4) (on b9 b7) (on b14 b9) (clear b14)
	(on-table b10) (clear b10)
	(on-table b11) (on b13 b11) (on b18 b13) (on b19 b18) (clear b19)
	(on-table b12) (on b20 b12) (clear b20)
	(on-table b16) (clear b16)
	(on-table b17) (clear b17)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b15 b1) (on b16 b15) (on b20 b16) (clear b20)
	(on-table b2) (on b14 b2) (on b17 b14) (clear b17)
	(on-table b3) (on b4 b3) (on b8 b4) (on b9 b8) (clear b9)
	(on-table b5) (on b6 b5) (clear b6)
	(on-table b7) (on b12 b7) (on b18 b12) (clear b18)
	(on-table b10) (on b13 b10) (clear b13)
	(on-table b11) (on b19 b11) (clear b19)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p20_99 blocks-hgn
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
	(on-table b1) (on b3 b1) (on b7 b3) (on b9 b7) (on b16 b9) (clear b16)
	(on-table b2) (on b8 b2) (on b10 b8) (on b12 b10) (on b13 b12) (clear b13)
	(on-table b4) (on b6 b4) (on b14 b6) (on b20 b14) (clear b20)
	(on-table b5) (on b11 b5) (on b15 b11) (on b17 b15) (on b19 b17) (clear b19)
	(on-table b18) (clear b18)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b15 b1) (clear b15)
	(on-table b2) (on b4 b2) (on b5 b4) (on b9 b5) (on b17 b9) (on b19 b17) (clear b19)
	(on-table b3) (on b7 b3) (on b8 b7) (on b12 b8) (on b18 b12) (clear b18)
	(on-table b6) (on b10 b6) (on b11 b10) (on b13 b11) (on b20 b13) (clear b20)
	(on-table b14) (on b16 b14) (clear b16)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p20_100 blocks-hgn
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
	(on-table b1) (on b5 b1) (on b9 b5) (on b11 b9) (on b12 b11) (on b18 b12) (clear b18)
	(on-table b2) (on b3 b2) (on b6 b3) (on b7 b6) (on b10 b7) (on b13 b10) (clear b13)
	(on-table b4) (on b8 b4) (on b14 b8) (on b15 b14) (clear b15)
	(on-table b16) (on b17 b16) (clear b17)
	(on-table b19) (on b20 b19) (clear b20)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b2 b1) (on b11 b2) (on b15 b11) (on b19 b15) (clear b19)
	(on-table b3) (on b4 b3) (on b6 b4) (on b7 b6) (on b8 b7) (on b14 b8) (on b17 b14) (clear b17)
	(on-table b5) (on b9 b5) (on b12 b9) (on b13 b12) (on b16 b13) (on b18 b16) (clear b18)
	(on-table b10) (clear b10)
	(on-table b20) (clear b20)
)));End of goal task network
)


;;-------------------------------
