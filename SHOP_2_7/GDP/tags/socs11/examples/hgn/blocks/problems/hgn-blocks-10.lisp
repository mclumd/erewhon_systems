(in-package :shop2)
;;---------------------------------------------

(defproblem p10_1 blocks-hgn
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
	(on-table b1) (on b6 b1) (clear b6)
	(on-table b2) (on b3 b2) (on b4 b3) (clear b4)
	(on-table b5) (on b7 b5) (on b8 b7) (on b9 b8) (on b10 b9) (clear b10)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b2 b1) (on b6 b2) (clear b6)
	(on-table b3) (clear b3)
	(on-table b4) (clear b4)
	(on-table b5) (on b8 b5) (clear b8)
	(on-table b7) (on b9 b7) (clear b9)
	(on-table b10) (clear b10)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p10_2 blocks-hgn
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
	(on-table b1) (on b3 b1) (on b4 b3) (on b5 b4) (on b7 b5) (on b8 b7) (on b9 b8) (clear b9)
	(on-table b2) (on b6 b2) (clear b6)
	(on-table b10) (clear b10)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b2 b1) (on b3 b2) (on b7 b3) (on b9 b7) (clear b9)
	(on-table b4) (on b5 b4) (clear b5)
	(on-table b6) (on b8 b6) (clear b8)
	(on-table b10) (clear b10)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p10_3 blocks-hgn
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
	(on-table b1) (on b3 b1) (on b6 b3) (clear b6)
	(on-table b2) (on b4 b2) (clear b4)
	(on-table b5) (on b8 b5) (on b10 b8) (clear b10)
	(on-table b7) (clear b7)
	(on-table b9) (clear b9)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b4 b1) (on b6 b4) (on b8 b6) (clear b8)
	(on-table b2) (on b3 b2) (on b5 b3) (on b10 b5) (clear b10)
	(on-table b7) (clear b7)
	(on-table b9) (clear b9)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p10_4 blocks-hgn
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
	(on-table b1) (on b4 b1) (on b9 b4) (clear b9)
	(on-table b2) (on b3 b2) (on b5 b3) (on b6 b5) (on b7 b6) (on b8 b7) (clear b8)
	(on-table b10) (clear b10)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (clear b1)
	(on-table b2) (on b3 b2) (on b7 b3) (clear b7)
	(on-table b4) (on b5 b4) (on b6 b5) (clear b6)
	(on-table b8) (clear b8)
	(on-table b9) (clear b9)
	(on-table b10) (clear b10)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p10_5 blocks-hgn
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
	(on-table b1) (on b2 b1) (on b4 b2) (on b9 b4) (clear b9)
	(on-table b3) (on b10 b3) (clear b10)
	(on-table b5) (on b6 b5) (on b8 b6) (clear b8)
	(on-table b7) (clear b7)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b2 b1) (on b3 b2) (on b4 b3) (on b6 b4) (clear b6)
	(on-table b5) (on b9 b5) (on b10 b9) (clear b10)
	(on-table b7) (clear b7)
	(on-table b8) (clear b8)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p10_6 blocks-hgn
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
	(on-table b1) (on b2 b1) (on b3 b2) (on b4 b3) (on b5 b4) (on b8 b5) (clear b8)
	(on-table b6) (clear b6)
	(on-table b7) (clear b7)
	(on-table b9) (clear b9)
	(on-table b10) (clear b10)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b4 b1) (on b8 b4) (clear b8)
	(on-table b2) (on b3 b2) (on b5 b3) (on b6 b5) (on b7 b6) (on b10 b7) (clear b10)
	(on-table b9) (clear b9)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p10_7 blocks-hgn
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
	(on-table b1) (on b2 b1) (on b3 b2) (on b4 b3) (on b7 b4) (clear b7)
	(on-table b5) (on b6 b5) (clear b6)
	(on-table b8) (on b9 b8) (clear b9)
	(on-table b10) (clear b10)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b2 b1) (on b3 b2) (on b4 b3) (on b5 b4) (on b6 b5) (on b7 b6) (on b8 b7) (clear b8)
	(on-table b9) (clear b9)
	(on-table b10) (clear b10)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p10_8 blocks-hgn
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
	(on-table b1) (on b3 b1) (on b4 b3) (on b5 b4) (on b6 b5) (on b7 b6) (on b8 b7) (clear b8)
	(on-table b2) (clear b2)
	(on-table b9) (clear b9)
	(on-table b10) (clear b10)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b2 b1) (on b3 b2) (on b4 b3) (on b6 b4) (on b7 b6) (clear b7)
	(on-table b5) (on b10 b5) (clear b10)
	(on-table b8) (on b9 b8) (clear b9)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p10_9 blocks-hgn
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
	(on-table b1) (on b2 b1) (on b3 b2) (on b4 b3) (on b6 b4) (clear b6)
	(on-table b5) (on b8 b5) (clear b8)
	(on-table b7) (clear b7)
	(on-table b9) (clear b9)
	(on-table b10) (clear b10)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b2 b1) (on b4 b2) (on b5 b4) (clear b5)
	(on-table b3) (on b6 b3) (clear b6)
	(on-table b7) (on b10 b7) (clear b10)
	(on-table b8) (clear b8)
	(on-table b9) (clear b9)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p10_10 blocks-hgn
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
	(on-table b1) (on b2 b1) (on b4 b2) (on b6 b4) (on b8 b6) (on b10 b8) (clear b10)
	(on-table b3) (clear b3)
	(on-table b5) (clear b5)
	(on-table b7) (clear b7)
	(on-table b9) (clear b9)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b2 b1) (on b3 b2) (on b6 b3) (on b7 b6) (on b9 b7) (clear b9)
	(on-table b4) (on b5 b4) (on b8 b5) (on b10 b8) (clear b10)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p10_11 blocks-hgn
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
	(on-table b1) (on b2 b1) (clear b2)
	(on-table b3) (on b10 b3) (clear b10)
	(on-table b4) (on b5 b4) (on b7 b5) (on b8 b7) (clear b8)
	(on-table b6) (clear b6)
	(on-table b9) (clear b9)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b2 b1) (on b3 b2) (on b8 b3) (clear b8)
	(on-table b4) (on b5 b4) (on b10 b5) (clear b10)
	(on-table b6) (on b7 b6) (clear b7)
	(on-table b9) (clear b9)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p10_12 blocks-hgn
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
	(on-table b1) (on b2 b1) (on b3 b2) (on b5 b3) (clear b5)
	(on-table b4) (on b6 b4) (on b7 b6) (on b8 b7) (on b9 b8) (on b10 b9) (clear b10)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b2 b1) (clear b2)
	(on-table b3) (on b8 b3) (clear b8)
	(on-table b4) (on b10 b4) (clear b10)
	(on-table b5) (on b6 b5) (clear b6)
	(on-table b7) (clear b7)
	(on-table b9) (clear b9)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p10_13 blocks-hgn
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
	(on-table b1) (on b3 b1) (on b4 b3) (on b5 b4) (on b9 b5) (clear b9)
	(on-table b2) (on b7 b2) (on b10 b7) (clear b10)
	(on-table b6) (clear b6)
	(on-table b8) (clear b8)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b2 b1) (on b8 b2) (clear b8)
	(on-table b3) (on b4 b3) (on b5 b4) (clear b5)
	(on-table b6) (clear b6)
	(on-table b7) (on b10 b7) (clear b10)
	(on-table b9) (clear b9)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p10_14 blocks-hgn
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
	(on-table b1) (on b2 b1) (on b3 b2) (clear b3)
	(on-table b4) (on b5 b4) (on b10 b5) (clear b10)
	(on-table b6) (on b8 b6) (clear b8)
	(on-table b7) (on b9 b7) (clear b9)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b10 b1) (clear b10)
	(on-table b2) (on b4 b2) (clear b4)
	(on-table b3) (on b5 b3) (clear b5)
	(on-table b6) (on b7 b6) (on b9 b7) (clear b9)
	(on-table b8) (clear b8)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p10_15 blocks-hgn
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
	(on-table b1) (on b5 b1) (on b9 b5) (on b10 b9) (clear b10)
	(on-table b2) (on b3 b2) (on b8 b3) (clear b8)
	(on-table b4) (on b6 b4) (on b7 b6) (clear b7)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b2 b1) (on b4 b2) (on b7 b4) (on b8 b7) (on b9 b8) (clear b9)
	(on-table b3) (on b10 b3) (clear b10)
	(on-table b5) (clear b5)
	(on-table b6) (clear b6)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p10_16 blocks-hgn
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
	(on-table b1) (on b2 b1) (on b7 b2) (on b10 b7) (clear b10)
	(on-table b3) (on b8 b3) (clear b8)
	(on-table b4) (on b6 b4) (clear b6)
	(on-table b5) (clear b5)
	(on-table b9) (clear b9)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b2 b1) (on b3 b2) (on b5 b3) (on b8 b5) (on b9 b8) (clear b9)
	(on-table b4) (clear b4)
	(on-table b6) (on b7 b6) (clear b7)
	(on-table b10) (clear b10)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p10_17 blocks-hgn
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
	(on-table b1) (on b2 b1) (on b3 b2) (on b4 b3) (on b5 b4) (clear b5)
	(on-table b6) (clear b6)
	(on-table b7) (on b8 b7) (on b9 b8) (on b10 b9) (clear b10)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b2 b1) (on b4 b2) (on b5 b4) (clear b5)
	(on-table b3) (on b9 b3) (clear b9)
	(on-table b6) (on b8 b6) (on b10 b8) (clear b10)
	(on-table b7) (clear b7)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p10_18 blocks-hgn
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
	(on-table b1) (on b2 b1) (on b4 b2) (on b9 b4) (clear b9)
	(on-table b3) (on b5 b3) (on b8 b5) (clear b8)
	(on-table b6) (on b7 b6) (clear b7)
	(on-table b10) (clear b10)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b3 b1) (on b6 b3) (on b7 b6) (on b9 b7) (clear b9)
	(on-table b2) (on b4 b2) (on b8 b4) (clear b8)
	(on-table b5) (clear b5)
	(on-table b10) (clear b10)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p10_19 blocks-hgn
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
	(on-table b1) (on b3 b1) (on b7 b3) (clear b7)
	(on-table b2) (on b6 b2) (on b9 b6) (clear b9)
	(on-table b4) (on b10 b4) (clear b10)
	(on-table b5) (on b8 b5) (clear b8)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b3 b1) (on b4 b3) (clear b4)
	(on-table b2) (on b5 b2) (on b9 b5) (on b10 b9) (clear b10)
	(on-table b6) (on b7 b6) (clear b7)
	(on-table b8) (clear b8)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p10_20 blocks-hgn
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
	(on-table b1) (on b5 b1) (clear b5)
	(on-table b2) (on b3 b2) (on b4 b3) (clear b4)
	(on-table b6) (clear b6)
	(on-table b7) (on b9 b7) (clear b9)
	(on-table b8) (on b10 b8) (clear b10)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b2 b1) (on b3 b2) (on b4 b3) (on b7 b4) (on b10 b7) (clear b10)
	(on-table b5) (on b6 b5) (on b8 b6) (clear b8)
	(on-table b9) (clear b9)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p10_21 blocks-hgn
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
	(on-table b1) (on b2 b1) (on b3 b2) (on b4 b3) (on b5 b4) (on b7 b5) (clear b7)
	(on-table b6) (on b9 b6) (on b10 b9) (clear b10)
	(on-table b8) (clear b8)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b3 b1) (on b6 b3) (on b9 b6) (on b10 b9) (clear b10)
	(on-table b2) (on b4 b2) (on b5 b4) (on b7 b5) (on b8 b7) (clear b8)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p10_22 blocks-hgn
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
	(on-table b1) (on b4 b1) (on b7 b4) (on b10 b7) (clear b10)
	(on-table b2) (on b5 b2) (clear b5)
	(on-table b3) (on b8 b3) (clear b8)
	(on-table b6) (on b9 b6) (clear b9)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b4 b1) (on b5 b4) (on b8 b5) (on b10 b8) (clear b10)
	(on-table b2) (clear b2)
	(on-table b3) (on b6 b3) (on b7 b6) (clear b7)
	(on-table b9) (clear b9)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p10_23 blocks-hgn
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
	(on-table b1) (on b2 b1) (on b6 b2) (on b9 b6) (clear b9)
	(on-table b3) (on b7 b3) (on b8 b7) (clear b8)
	(on-table b4) (clear b4)
	(on-table b5) (clear b5)
	(on-table b10) (clear b10)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b4 b1) (clear b4)
	(on-table b2) (on b3 b2) (on b6 b3) (on b7 b6) (on b8 b7) (clear b8)
	(on-table b5) (clear b5)
	(on-table b9) (on b10 b9) (clear b10)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p10_24 blocks-hgn
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
	(on-table b1) (on b3 b1) (on b7 b3) (on b8 b7) (clear b8)
	(on-table b2) (on b5 b2) (clear b5)
	(on-table b4) (on b6 b4) (on b10 b6) (clear b10)
	(on-table b9) (clear b9)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b2 b1) (on b3 b2) (on b4 b3) (on b5 b4) (on b6 b5) (on b8 b6) (clear b8)
	(on-table b7) (on b10 b7) (clear b10)
	(on-table b9) (clear b9)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p10_25 blocks-hgn
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
	(on-table b1) (on b3 b1) (on b4 b3) (on b9 b4) (clear b9)
	(on-table b2) (on b5 b2) (on b6 b5) (on b7 b6) (on b8 b7) (on b10 b8) (clear b10)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b2 b1) (on b3 b2) (on b6 b3) (on b7 b6) (on b8 b7) (on b10 b8) (clear b10)
	(on-table b4) (on b9 b4) (clear b9)
	(on-table b5) (clear b5)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p10_26 blocks-hgn
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
	(on-table b1) (on b2 b1) (on b6 b2) (on b7 b6) (clear b7)
	(on-table b3) (on b9 b3) (on b10 b9) (clear b10)
	(on-table b4) (on b8 b4) (clear b8)
	(on-table b5) (clear b5)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (clear b1)
	(on-table b2) (on b3 b2) (on b5 b3) (on b8 b5) (on b9 b8) (clear b9)
	(on-table b4) (on b6 b4) (clear b6)
	(on-table b7) (clear b7)
	(on-table b10) (clear b10)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p10_27 blocks-hgn
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
	(on-table b1) (on b2 b1) (on b3 b2) (on b5 b3) (on b6 b5) (clear b6)
	(on-table b4) (clear b4)
	(on-table b7) (clear b7)
	(on-table b8) (clear b8)
	(on-table b9) (on b10 b9) (clear b10)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (clear b1)
	(on-table b2) (on b4 b2) (on b8 b4) (clear b8)
	(on-table b3) (clear b3)
	(on-table b5) (clear b5)
	(on-table b6) (on b9 b6) (on b10 b9) (clear b10)
	(on-table b7) (clear b7)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p10_28 blocks-hgn
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
	(on-table b1) (on b3 b1) (on b6 b3) (clear b6)
	(on-table b2) (on b8 b2) (on b9 b8) (clear b9)
	(on-table b4) (on b5 b4) (clear b5)
	(on-table b7) (clear b7)
	(on-table b10) (clear b10)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b2 b1) (on b3 b2) (clear b3)
	(on-table b4) (on b6 b4) (on b8 b6) (clear b8)
	(on-table b5) (on b7 b5) (on b9 b7) (on b10 b9) (clear b10)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p10_29 blocks-hgn
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
	(on-table b1) (on b3 b1) (clear b3)
	(on-table b2) (on b5 b2) (on b6 b5) (on b7 b6) (clear b7)
	(on-table b4) (on b9 b4) (clear b9)
	(on-table b8) (on b10 b8) (clear b10)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b2 b1) (on b10 b2) (clear b10)
	(on-table b3) (on b6 b3) (on b8 b6) (clear b8)
	(on-table b4) (clear b4)
	(on-table b5) (on b7 b5) (on b9 b7) (clear b9)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p10_30 blocks-hgn
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
	(on-table b1) (on b2 b1) (clear b2)
	(on-table b3) (clear b3)
	(on-table b4) (on b9 b4) (clear b9)
	(on-table b5) (on b6 b5) (on b7 b6) (clear b7)
	(on-table b8) (clear b8)
	(on-table b10) (clear b10)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b2 b1) (on b3 b2) (on b4 b3) (on b5 b4) (on b6 b5) (on b7 b6) (on b8 b7) (clear b8)
	(on-table b9) (clear b9)
	(on-table b10) (clear b10)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p10_31 blocks-hgn
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
	(on-table b1) (on b2 b1) (clear b2)
	(on-table b3) (on b9 b3) (clear b9)
	(on-table b4) (on b5 b4) (on b8 b5) (clear b8)
	(on-table b6) (on b7 b6) (on b10 b7) (clear b10)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b2 b1) (on b3 b2) (on b6 b3) (on b7 b6) (on b10 b7) (clear b10)
	(on-table b4) (on b5 b4) (on b8 b5) (on b9 b8) (clear b9)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p10_32 blocks-hgn
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
	(on-table b1) (on b4 b1) (on b5 b4) (clear b5)
	(on-table b2) (on b6 b2) (on b7 b6) (on b10 b7) (clear b10)
	(on-table b3) (clear b3)
	(on-table b8) (clear b8)
	(on-table b9) (clear b9)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b2 b1) (on b3 b2) (on b5 b3) (on b6 b5) (clear b6)
	(on-table b4) (on b7 b4) (on b8 b7) (on b9 b8) (clear b9)
	(on-table b10) (clear b10)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p10_33 blocks-hgn
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
	(on-table b1) (on b2 b1) (clear b2)
	(on-table b3) (on b6 b3) (on b9 b6) (clear b9)
	(on-table b4) (on b5 b4) (on b7 b5) (on b8 b7) (clear b8)
	(on-table b10) (clear b10)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b9 b1) (on b10 b9) (clear b10)
	(on-table b2) (on b3 b2) (on b4 b3) (on b5 b4) (on b6 b5) (on b7 b6) (clear b7)
	(on-table b8) (clear b8)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p10_34 blocks-hgn
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
	(on-table b1) (on b2 b1) (on b4 b2) (on b9 b4) (on b10 b9) (clear b10)
	(on-table b3) (on b7 b3) (clear b7)
	(on-table b5) (on b6 b5) (on b8 b6) (clear b8)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b4 b1) (on b5 b4) (on b7 b5) (clear b7)
	(on-table b2) (on b3 b2) (on b6 b3) (on b10 b6) (clear b10)
	(on-table b8) (on b9 b8) (clear b9)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p10_35 blocks-hgn
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
	(on-table b1) (clear b1)
	(on-table b2) (on b9 b2) (clear b9)
	(on-table b3) (on b10 b3) (clear b10)
	(on-table b4) (clear b4)
	(on-table b5) (on b6 b5) (clear b6)
	(on-table b7) (clear b7)
	(on-table b8) (clear b8)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b3 b1) (on b4 b3) (on b7 b4) (clear b7)
	(on-table b2) (clear b2)
	(on-table b5) (on b6 b5) (clear b6)
	(on-table b8) (clear b8)
	(on-table b9) (clear b9)
	(on-table b10) (clear b10)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p10_36 blocks-hgn
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
	(on-table b1) (on b4 b1) (on b7 b4) (clear b7)
	(on-table b2) (on b3 b2) (on b10 b3) (clear b10)
	(on-table b5) (clear b5)
	(on-table b6) (on b8 b6) (on b9 b8) (clear b9)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b4 b1) (on b6 b4) (on b7 b6) (clear b7)
	(on-table b2) (on b3 b2) (on b5 b3) (clear b5)
	(on-table b8) (on b10 b8) (clear b10)
	(on-table b9) (clear b9)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p10_37 blocks-hgn
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
	(on-table b1) (on b6 b1) (clear b6)
	(on-table b2) (clear b2)
	(on-table b3) (on b8 b3) (on b10 b8) (clear b10)
	(on-table b4) (on b7 b4) (clear b7)
	(on-table b5) (on b9 b5) (clear b9)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b4 b1) (on b7 b4) (clear b7)
	(on-table b2) (on b3 b2) (on b9 b3) (on b10 b9) (clear b10)
	(on-table b5) (clear b5)
	(on-table b6) (clear b6)
	(on-table b8) (clear b8)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p10_38 blocks-hgn
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
	(on-table b1) (on b2 b1) (on b4 b2) (on b6 b4) (clear b6)
	(on-table b3) (on b7 b3) (on b10 b7) (clear b10)
	(on-table b5) (on b8 b5) (on b9 b8) (clear b9)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b2 b1) (on b5 b2) (on b7 b5) (on b9 b7) (clear b9)
	(on-table b3) (on b4 b3) (on b8 b4) (clear b8)
	(on-table b6) (on b10 b6) (clear b10)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p10_39 blocks-hgn
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
	(on-table b1) (on b3 b1) (on b6 b3) (clear b6)
	(on-table b2) (on b10 b2) (clear b10)
	(on-table b4) (on b7 b4) (on b9 b7) (clear b9)
	(on-table b5) (clear b5)
	(on-table b8) (clear b8)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b6 b1) (on b8 b6) (clear b8)
	(on-table b2) (on b4 b2) (clear b4)
	(on-table b3) (on b5 b3) (on b7 b5) (on b10 b7) (clear b10)
	(on-table b9) (clear b9)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p10_40 blocks-hgn
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
	(on-table b1) (on b2 b1) (on b5 b2) (clear b5)
	(on-table b3) (on b6 b3) (on b8 b6) (clear b8)
	(on-table b4) (on b7 b4) (clear b7)
	(on-table b9) (on b10 b9) (clear b10)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b2 b1) (on b3 b2) (on b4 b3) (on b5 b4) (on b6 b5) (on b10 b6) (clear b10)
	(on-table b7) (on b8 b7) (on b9 b8) (clear b9)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p10_41 blocks-hgn
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
	(on-table b1) (on b6 b1) (on b7 b6) (on b8 b7) (on b10 b8) (clear b10)
	(on-table b2) (on b3 b2) (on b5 b3) (on b9 b5) (clear b9)
	(on-table b4) (clear b4)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b3 b1) (on b7 b3) (on b8 b7) (on b10 b8) (clear b10)
	(on-table b2) (on b4 b2) (on b9 b4) (clear b9)
	(on-table b5) (on b6 b5) (clear b6)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p10_42 blocks-hgn
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
	(on-table b1) (on b2 b1) (on b5 b2) (clear b5)
	(on-table b3) (on b4 b3) (on b6 b4) (on b8 b6) (on b10 b8) (clear b10)
	(on-table b7) (on b9 b7) (clear b9)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b2 b1) (on b9 b2) (clear b9)
	(on-table b3) (on b4 b3) (on b5 b4) (on b6 b5) (on b7 b6) (clear b7)
	(on-table b8) (clear b8)
	(on-table b10) (clear b10)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p10_43 blocks-hgn
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
	(on-table b1) (on b2 b1) (on b7 b2) (on b9 b7) (clear b9)
	(on-table b3) (on b6 b3) (on b8 b6) (clear b8)
	(on-table b4) (clear b4)
	(on-table b5) (clear b5)
	(on-table b10) (clear b10)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b4 b1) (on b8 b4) (clear b8)
	(on-table b2) (on b3 b2) (on b5 b3) (on b9 b5) (on b10 b9) (clear b10)
	(on-table b6) (on b7 b6) (clear b7)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p10_44 blocks-hgn
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
	(on-table b1) (on b2 b1) (on b3 b2) (clear b3)
	(on-table b4) (clear b4)
	(on-table b5) (on b7 b5) (clear b7)
	(on-table b6) (on b8 b6) (clear b8)
	(on-table b9) (clear b9)
	(on-table b10) (clear b10)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b6 b1) (on b8 b6) (clear b8)
	(on-table b2) (on b5 b2) (clear b5)
	(on-table b3) (on b4 b3) (on b7 b4) (on b9 b7) (clear b9)
	(on-table b10) (clear b10)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p10_45 blocks-hgn
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
	(on-table b1) (on b2 b1) (on b3 b2) (clear b3)
	(on-table b4) (clear b4)
	(on-table b5) (on b7 b5) (on b10 b7) (clear b10)
	(on-table b6) (clear b6)
	(on-table b8) (on b9 b8) (clear b9)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b7 b1) (on b8 b7) (on b10 b8) (clear b10)
	(on-table b2) (on b3 b2) (on b4 b3) (on b5 b4) (on b9 b5) (clear b9)
	(on-table b6) (clear b6)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p10_46 blocks-hgn
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
	(on-table b1) (on b2 b1) (on b3 b2) (on b6 b3) (clear b6)
	(on-table b4) (on b8 b4) (clear b8)
	(on-table b5) (on b7 b5) (on b9 b7) (on b10 b9) (clear b10)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b4 b1) (on b7 b4) (on b8 b7) (clear b8)
	(on-table b2) (on b5 b2) (on b10 b5) (clear b10)
	(on-table b3) (on b6 b3) (on b9 b6) (clear b9)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p10_47 blocks-hgn
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
	(on-table b1) (on b6 b1) (on b10 b6) (clear b10)
	(on-table b2) (on b3 b2) (on b4 b3) (on b5 b4) (on b7 b5) (on b9 b7) (clear b9)
	(on-table b8) (clear b8)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b2 b1) (on b4 b2) (on b8 b4) (on b9 b8) (on b10 b9) (clear b10)
	(on-table b3) (on b7 b3) (clear b7)
	(on-table b5) (on b6 b5) (clear b6)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p10_48 blocks-hgn
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
	(on-table b1) (on b2 b1) (on b3 b2) (on b8 b3) (on b9 b8) (clear b9)
	(on-table b4) (on b5 b4) (on b6 b5) (on b7 b6) (on b10 b7) (clear b10)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b3 b1) (clear b3)
	(on-table b2) (on b10 b2) (clear b10)
	(on-table b4) (on b8 b4) (clear b8)
	(on-table b5) (on b6 b5) (on b7 b6) (clear b7)
	(on-table b9) (clear b9)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p10_49 blocks-hgn
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
	(on-table b1) (on b2 b1) (on b3 b2) (on b4 b3) (on b6 b4) (on b10 b6) (clear b10)
	(on-table b5) (on b9 b5) (clear b9)
	(on-table b7) (on b8 b7) (clear b8)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b10 b1) (clear b10)
	(on-table b2) (clear b2)
	(on-table b3) (on b7 b3) (clear b7)
	(on-table b4) (on b8 b4) (clear b8)
	(on-table b5) (clear b5)
	(on-table b6) (on b9 b6) (clear b9)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p10_50 blocks-hgn
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
	(on-table b1) (on b2 b1) (clear b2)
	(on-table b3) (on b4 b3) (on b6 b4) (on b7 b6) (on b9 b7) (clear b9)
	(on-table b5) (on b8 b5) (clear b8)
	(on-table b10) (clear b10)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b2 b1) (on b5 b2) (on b8 b5) (on b10 b8) (clear b10)
	(on-table b3) (on b4 b3) (clear b4)
	(on-table b6) (on b7 b6) (on b9 b7) (clear b9)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p10_51 blocks-hgn
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
	(on-table b1) (on b3 b1) (on b4 b3) (on b7 b4) (on b8 b7) (clear b8)
	(on-table b2) (clear b2)
	(on-table b5) (on b6 b5) (clear b6)
	(on-table b9) (clear b9)
	(on-table b10) (clear b10)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b6 b1) (clear b6)
	(on-table b2) (on b7 b2) (on b8 b7) (clear b8)
	(on-table b3) (clear b3)
	(on-table b4) (on b5 b4) (on b9 b5) (on b10 b9) (clear b10)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p10_52 blocks-hgn
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
	(on-table b1) (on b2 b1) (on b4 b2) (clear b4)
	(on-table b3) (on b8 b3) (clear b8)
	(on-table b5) (on b10 b5) (clear b10)
	(on-table b6) (on b7 b6) (on b9 b7) (clear b9)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b8 b1) (clear b8)
	(on-table b2) (on b3 b2) (on b4 b3) (on b5 b4) (on b6 b5) (on b10 b6) (clear b10)
	(on-table b7) (on b9 b7) (clear b9)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p10_53 blocks-hgn
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
	(on-table b1) (on b2 b1) (on b5 b2) (clear b5)
	(on-table b3) (on b6 b3) (on b9 b6) (clear b9)
	(on-table b4) (on b7 b4) (on b10 b7) (clear b10)
	(on-table b8) (clear b8)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b2 b1) (on b4 b2) (clear b4)
	(on-table b3) (on b5 b3) (on b7 b5) (on b9 b7) (clear b9)
	(on-table b6) (clear b6)
	(on-table b8) (clear b8)
	(on-table b10) (clear b10)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p10_54 blocks-hgn
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
	(on-table b1) (on b2 b1) (on b3 b2) (on b4 b3) (on b5 b4) (on b6 b5) (on b7 b6) (on b8 b7) (on b10 b8) (clear b10)
	(on-table b9) (clear b9)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b2 b1) (on b3 b2) (on b4 b3) (on b5 b4) (on b8 b5) (clear b8)
	(on-table b6) (clear b6)
	(on-table b7) (on b9 b7) (on b10 b9) (clear b10)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p10_55 blocks-hgn
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
	(on-table b1) (on b4 b1) (on b5 b4) (on b6 b5) (clear b6)
	(on-table b2) (on b3 b2) (on b7 b3) (on b8 b7) (on b9 b8) (on b10 b9) (clear b10)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b2 b1) (on b3 b2) (on b4 b3) (on b6 b4) (on b9 b6) (clear b9)
	(on-table b5) (on b7 b5) (on b8 b7) (clear b8)
	(on-table b10) (clear b10)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p10_56 blocks-hgn
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
	(on-table b1) (on b2 b1) (on b3 b2) (on b7 b3) (on b8 b7) (clear b8)
	(on-table b4) (on b6 b4) (clear b6)
	(on-table b5) (on b9 b5) (clear b9)
	(on-table b10) (clear b10)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b5 b1) (clear b5)
	(on-table b2) (on b3 b2) (on b4 b3) (on b8 b4) (on b9 b8) (on b10 b9) (clear b10)
	(on-table b6) (on b7 b6) (clear b7)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p10_57 blocks-hgn
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
	(on-table b1) (on b4 b1) (on b5 b4) (on b9 b5) (clear b9)
	(on-table b2) (on b7 b2) (on b10 b7) (clear b10)
	(on-table b3) (on b6 b3) (on b8 b6) (clear b8)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b5 b1) (on b6 b5) (clear b6)
	(on-table b2) (on b4 b2) (clear b4)
	(on-table b3) (on b8 b3) (on b9 b8) (clear b9)
	(on-table b7) (on b10 b7) (clear b10)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p10_58 blocks-hgn
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
	(on-table b1) (on b2 b1) (on b7 b2) (on b10 b7) (clear b10)
	(on-table b3) (clear b3)
	(on-table b4) (on b9 b4) (clear b9)
	(on-table b5) (clear b5)
	(on-table b6) (on b8 b6) (clear b8)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b2 b1) (on b3 b2) (on b9 b3) (clear b9)
	(on-table b4) (on b6 b4) (clear b6)
	(on-table b5) (on b7 b5) (on b8 b7) (clear b8)
	(on-table b10) (clear b10)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p10_59 blocks-hgn
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
	(on-table b1) (on b3 b1) (on b4 b3) (on b5 b4) (on b7 b5) (on b8 b7) (on b10 b8) (clear b10)
	(on-table b2) (on b6 b2) (clear b6)
	(on-table b9) (clear b9)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b4 b1) (on b6 b4) (on b8 b6) (clear b8)
	(on-table b2) (on b5 b2) (on b9 b5) (clear b9)
	(on-table b3) (clear b3)
	(on-table b7) (on b10 b7) (clear b10)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p10_60 blocks-hgn
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
	(on-table b1) (on b2 b1) (on b4 b2) (clear b4)
	(on-table b3) (on b8 b3) (on b10 b8) (clear b10)
	(on-table b5) (on b9 b5) (clear b9)
	(on-table b6) (clear b6)
	(on-table b7) (clear b7)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b2 b1) (on b3 b2) (clear b3)
	(on-table b4) (on b5 b4) (on b9 b5) (clear b9)
	(on-table b6) (clear b6)
	(on-table b7) (on b10 b7) (clear b10)
	(on-table b8) (clear b8)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p10_61 blocks-hgn
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
	(on-table b1) (on b2 b1) (on b9 b2) (clear b9)
	(on-table b3) (on b5 b3) (clear b5)
	(on-table b4) (on b7 b4) (clear b7)
	(on-table b6) (on b8 b6) (clear b8)
	(on-table b10) (clear b10)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b2 b1) (on b3 b2) (on b4 b3) (on b5 b4) (clear b5)
	(on-table b6) (on b8 b6) (on b9 b8) (clear b9)
	(on-table b7) (on b10 b7) (clear b10)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p10_62 blocks-hgn
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
	(on-table b1) (on b2 b1) (on b4 b2) (on b5 b4) (on b7 b5) (clear b7)
	(on-table b3) (on b10 b3) (clear b10)
	(on-table b6) (on b8 b6) (on b9 b8) (clear b9)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b2 b1) (on b3 b2) (on b4 b3) (clear b4)
	(on-table b5) (on b6 b5) (on b7 b6) (on b8 b7) (clear b8)
	(on-table b9) (clear b9)
	(on-table b10) (clear b10)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p10_63 blocks-hgn
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
	(on-table b1) (on b4 b1) (on b5 b4) (on b9 b5) (on b10 b9) (clear b10)
	(on-table b2) (on b3 b2) (clear b3)
	(on-table b6) (on b7 b6) (on b8 b7) (clear b8)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b3 b1) (clear b3)
	(on-table b2) (on b4 b2) (on b5 b4) (on b7 b5) (clear b7)
	(on-table b6) (on b8 b6) (on b10 b8) (clear b10)
	(on-table b9) (clear b9)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p10_64 blocks-hgn
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
	(on-table b1) (on b2 b1) (on b8 b2) (clear b8)
	(on-table b3) (on b4 b3) (on b5 b4) (on b9 b5) (clear b9)
	(on-table b6) (on b7 b6) (on b10 b7) (clear b10)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b5 b1) (on b6 b5) (clear b6)
	(on-table b2) (on b3 b2) (on b4 b3) (on b7 b4) (on b9 b7) (clear b9)
	(on-table b8) (on b10 b8) (clear b10)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p10_65 blocks-hgn
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
	(on-table b1) (on b2 b1) (on b3 b2) (on b7 b3) (on b9 b7) (on b10 b9) (clear b10)
	(on-table b4) (on b5 b4) (on b6 b5) (clear b6)
	(on-table b8) (clear b8)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b3 b1) (on b4 b3) (clear b4)
	(on-table b2) (clear b2)
	(on-table b5) (on b6 b5) (on b9 b6) (clear b9)
	(on-table b7) (on b8 b7) (on b10 b8) (clear b10)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p10_66 blocks-hgn
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
	(on-table b1) (on b2 b1) (on b4 b2) (on b5 b4) (on b6 b5) (clear b6)
	(on-table b3) (clear b3)
	(on-table b7) (on b9 b7) (on b10 b9) (clear b10)
	(on-table b8) (clear b8)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b3 b1) (on b5 b3) (on b6 b5) (clear b6)
	(on-table b2) (on b8 b2) (clear b8)
	(on-table b4) (on b9 b4) (on b10 b9) (clear b10)
	(on-table b7) (clear b7)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p10_67 blocks-hgn
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
	(on-table b1) (on b3 b1) (on b7 b3) (on b10 b7) (clear b10)
	(on-table b2) (on b5 b2) (on b8 b5) (on b9 b8) (clear b9)
	(on-table b4) (on b6 b4) (clear b6)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b5 b1) (on b6 b5) (on b7 b6) (clear b7)
	(on-table b2) (on b3 b2) (on b4 b3) (on b8 b4) (clear b8)
	(on-table b9) (clear b9)
	(on-table b10) (clear b10)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p10_68 blocks-hgn
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
	(on-table b1) (on b3 b1) (on b4 b3) (on b5 b4) (clear b5)
	(on-table b2) (on b10 b2) (clear b10)
	(on-table b6) (on b7 b6) (on b8 b7) (clear b8)
	(on-table b9) (clear b9)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b2 b1) (clear b2)
	(on-table b3) (clear b3)
	(on-table b4) (clear b4)
	(on-table b5) (on b6 b5) (clear b6)
	(on-table b7) (on b8 b7) (on b9 b8) (clear b9)
	(on-table b10) (clear b10)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p10_69 blocks-hgn
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
	(on-table b1) (on b2 b1) (clear b2)
	(on-table b3) (on b4 b3) (on b8 b4) (on b9 b8) (clear b9)
	(on-table b5) (on b10 b5) (clear b10)
	(on-table b6) (on b7 b6) (clear b7)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b2 b1) (on b3 b2) (on b4 b3) (on b9 b4) (on b10 b9) (clear b10)
	(on-table b5) (on b6 b5) (clear b6)
	(on-table b7) (on b8 b7) (clear b8)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p10_70 blocks-hgn
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
	(on-table b1) (clear b1)
	(on-table b2) (on b3 b2) (on b4 b3) (on b9 b4) (clear b9)
	(on-table b5) (on b10 b5) (clear b10)
	(on-table b6) (clear b6)
	(on-table b7) (clear b7)
	(on-table b8) (clear b8)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b2 b1) (on b7 b2) (on b8 b7) (clear b8)
	(on-table b3) (on b4 b3) (on b5 b4) (clear b5)
	(on-table b6) (on b9 b6) (on b10 b9) (clear b10)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p10_71 blocks-hgn
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
	(on-table b1) (on b2 b1) (on b4 b2) (on b7 b4) (on b8 b7) (clear b8)
	(on-table b3) (on b6 b3) (on b9 b6) (clear b9)
	(on-table b5) (on b10 b5) (clear b10)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b2 b1) (on b3 b2) (on b5 b3) (on b6 b5) (on b7 b6) (on b8 b7) (on b9 b8) (clear b9)
	(on-table b4) (on b10 b4) (clear b10)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p10_72 blocks-hgn
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
	(on-table b1) (on b2 b1) (on b7 b2) (clear b7)
	(on-table b3) (on b8 b3) (on b9 b8) (on b10 b9) (clear b10)
	(on-table b4) (clear b4)
	(on-table b5) (on b6 b5) (clear b6)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b2 b1) (on b3 b2) (on b7 b3) (clear b7)
	(on-table b4) (on b10 b4) (clear b10)
	(on-table b5) (on b6 b5) (on b9 b6) (clear b9)
	(on-table b8) (clear b8)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p10_73 blocks-hgn
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
	(on-table b1) (on b2 b1) (on b4 b2) (on b5 b4) (on b7 b5) (on b8 b7) (on b9 b8) (clear b9)
	(on-table b3) (on b10 b3) (clear b10)
	(on-table b6) (clear b6)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b2 b1) (on b4 b2) (on b7 b4) (clear b7)
	(on-table b3) (on b5 b3) (clear b5)
	(on-table b6) (on b8 b6) (clear b8)
	(on-table b9) (on b10 b9) (clear b10)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p10_74 blocks-hgn
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
	(on-table b1) (on b6 b1) (clear b6)
	(on-table b2) (on b3 b2) (on b4 b3) (on b5 b4) (on b10 b5) (clear b10)
	(on-table b7) (clear b7)
	(on-table b8) (on b9 b8) (clear b9)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b4 b1) (clear b4)
	(on-table b2) (on b3 b2) (on b6 b3) (on b8 b6) (clear b8)
	(on-table b5) (on b7 b5) (on b9 b7) (clear b9)
	(on-table b10) (clear b10)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p10_75 blocks-hgn
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
	(on-table b1) (on b2 b1) (on b5 b2) (on b7 b5) (on b10 b7) (clear b10)
	(on-table b3) (on b8 b3) (clear b8)
	(on-table b4) (on b6 b4) (on b9 b6) (clear b9)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (clear b1)
	(on-table b2) (on b3 b2) (clear b3)
	(on-table b4) (on b8 b4) (clear b8)
	(on-table b5) (on b10 b5) (clear b10)
	(on-table b6) (on b7 b6) (clear b7)
	(on-table b9) (clear b9)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p10_76 blocks-hgn
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
	(on-table b1) (on b2 b1) (on b8 b2) (clear b8)
	(on-table b3) (on b5 b3) (on b6 b5) (on b7 b6) (clear b7)
	(on-table b4) (clear b4)
	(on-table b9) (on b10 b9) (clear b10)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b2 b1) (clear b2)
	(on-table b3) (clear b3)
	(on-table b4) (on b5 b4) (on b6 b5) (on b7 b6) (clear b7)
	(on-table b8) (on b10 b8) (clear b10)
	(on-table b9) (clear b9)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p10_77 blocks-hgn
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
	(on-table b1) (on b3 b1) (on b4 b3) (clear b4)
	(on-table b2) (on b5 b2) (on b6 b5) (on b7 b6) (on b8 b7) (clear b8)
	(on-table b9) (clear b9)
	(on-table b10) (clear b10)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b3 b1) (on b4 b3) (on b5 b4) (on b6 b5) (on b10 b6) (clear b10)
	(on-table b2) (clear b2)
	(on-table b7) (on b9 b7) (clear b9)
	(on-table b8) (clear b8)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p10_78 blocks-hgn
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
	(on-table b1) (on b2 b1) (on b3 b2) (on b4 b3) (on b5 b4) (on b6 b5) (clear b6)
	(on-table b7) (clear b7)
	(on-table b8) (on b9 b8) (on b10 b9) (clear b10)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b2 b1) (on b3 b2) (on b7 b3) (on b10 b7) (clear b10)
	(on-table b4) (on b8 b4) (on b9 b8) (clear b9)
	(on-table b5) (clear b5)
	(on-table b6) (clear b6)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p10_79 blocks-hgn
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
	(on-table b1) (on b2 b1) (on b4 b2) (on b5 b4) (on b6 b5) (on b9 b6) (clear b9)
	(on-table b3) (on b7 b3) (on b8 b7) (on b10 b8) (clear b10)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b2 b1) (clear b2)
	(on-table b3) (on b5 b3) (clear b5)
	(on-table b4) (on b6 b4) (on b7 b6) (on b9 b7) (clear b9)
	(on-table b8) (on b10 b8) (clear b10)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p10_80 blocks-hgn
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
	(on-table b1) (on b4 b1) (on b5 b4) (on b7 b5) (clear b7)
	(on-table b2) (on b3 b2) (on b8 b3) (clear b8)
	(on-table b6) (on b9 b6) (clear b9)
	(on-table b10) (clear b10)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b2 b1) (on b3 b2) (on b4 b3) (on b6 b4) (on b7 b6) (on b8 b7) (clear b8)
	(on-table b5) (on b10 b5) (clear b10)
	(on-table b9) (clear b9)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p10_81 blocks-hgn
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
	(on-table b1) (on b2 b1) (on b9 b2) (clear b9)
	(on-table b3) (on b4 b3) (clear b4)
	(on-table b5) (on b7 b5) (on b10 b7) (clear b10)
	(on-table b6) (clear b6)
	(on-table b8) (clear b8)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b4 b1) (on b6 b4) (clear b6)
	(on-table b2) (on b3 b2) (on b5 b3) (on b7 b5) (on b9 b7) (clear b9)
	(on-table b8) (clear b8)
	(on-table b10) (clear b10)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p10_82 blocks-hgn
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
	(on-table b1) (on b2 b1) (on b3 b2) (on b10 b3) (clear b10)
	(on-table b4) (on b5 b4) (on b7 b5) (clear b7)
	(on-table b6) (on b9 b6) (clear b9)
	(on-table b8) (clear b8)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b2 b1) (on b5 b2) (on b7 b5) (clear b7)
	(on-table b3) (on b6 b3) (on b8 b6) (clear b8)
	(on-table b4) (clear b4)
	(on-table b9) (on b10 b9) (clear b10)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p10_83 blocks-hgn
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
	(on-table b1) (on b4 b1) (on b5 b4) (on b6 b5) (clear b6)
	(on-table b2) (on b3 b2) (on b7 b3) (on b10 b7) (clear b10)
	(on-table b8) (on b9 b8) (clear b9)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b3 b1) (on b7 b3) (on b8 b7) (on b10 b8) (clear b10)
	(on-table b2) (on b5 b2) (on b6 b5) (on b9 b6) (clear b9)
	(on-table b4) (clear b4)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p10_84 blocks-hgn
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
	(on-table b1) (on b2 b1) (on b3 b2) (on b5 b3) (on b6 b5) (clear b6)
	(on-table b4) (clear b4)
	(on-table b7) (on b9 b7) (on b10 b9) (clear b10)
	(on-table b8) (clear b8)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b2 b1) (on b3 b2) (on b4 b3) (on b8 b4) (on b10 b8) (clear b10)
	(on-table b5) (on b7 b5) (on b9 b7) (clear b9)
	(on-table b6) (clear b6)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p10_85 blocks-hgn
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
	(on-table b1) (on b2 b1) (on b3 b2) (on b4 b3) (on b8 b4) (on b10 b8) (clear b10)
	(on-table b5) (on b9 b5) (clear b9)
	(on-table b6) (on b7 b6) (clear b7)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b3 b1) (on b6 b3) (on b9 b6) (clear b9)
	(on-table b2) (on b7 b2) (on b8 b7) (on b10 b8) (clear b10)
	(on-table b4) (on b5 b4) (clear b5)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p10_86 blocks-hgn
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
	(on-table b1) (on b7 b1) (on b9 b7) (clear b9)
	(on-table b2) (clear b2)
	(on-table b3) (clear b3)
	(on-table b4) (on b5 b4) (on b6 b5) (on b8 b6) (on b10 b8) (clear b10)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b7 b1) (clear b7)
	(on-table b2) (on b3 b2) (on b6 b3) (on b8 b6) (clear b8)
	(on-table b4) (on b5 b4) (clear b5)
	(on-table b9) (on b10 b9) (clear b10)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p10_87 blocks-hgn
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
	(on-table b1) (on b2 b1) (on b4 b2) (on b5 b4) (on b7 b5) (clear b7)
	(on-table b3) (on b6 b3) (on b10 b6) (clear b10)
	(on-table b8) (on b9 b8) (clear b9)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b8 b1) (on b9 b8) (clear b9)
	(on-table b2) (on b7 b2) (clear b7)
	(on-table b3) (on b5 b3) (on b10 b5) (clear b10)
	(on-table b4) (clear b4)
	(on-table b6) (clear b6)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p10_88 blocks-hgn
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
	(on-table b1) (on b2 b1) (on b7 b2) (on b9 b7) (on b10 b9) (clear b10)
	(on-table b3) (on b4 b3) (clear b4)
	(on-table b5) (on b6 b5) (clear b6)
	(on-table b8) (clear b8)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b3 b1) (on b5 b3) (on b8 b5) (clear b8)
	(on-table b2) (on b7 b2) (clear b7)
	(on-table b4) (on b6 b4) (clear b6)
	(on-table b9) (on b10 b9) (clear b10)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p10_89 blocks-hgn
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
	(on-table b1) (on b2 b1) (on b3 b2) (on b4 b3) (on b7 b4) (clear b7)
	(on-table b5) (on b8 b5) (clear b8)
	(on-table b6) (on b9 b6) (clear b9)
	(on-table b10) (clear b10)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b3 b1) (on b4 b3) (on b7 b4) (on b8 b7) (clear b8)
	(on-table b2) (on b5 b2) (on b6 b5) (on b9 b6) (clear b9)
	(on-table b10) (clear b10)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p10_90 blocks-hgn
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
	(on-table b1) (clear b1)
	(on-table b2) (on b3 b2) (on b9 b3) (clear b9)
	(on-table b4) (on b5 b4) (on b7 b5) (clear b7)
	(on-table b6) (clear b6)
	(on-table b8) (clear b8)
	(on-table b10) (clear b10)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b2 b1) (on b4 b2) (clear b4)
	(on-table b3) (on b5 b3) (on b6 b5) (on b7 b6) (clear b7)
	(on-table b8) (clear b8)
	(on-table b9) (clear b9)
	(on-table b10) (clear b10)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p10_91 blocks-hgn
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
	(on-table b1) (on b8 b1) (clear b8)
	(on-table b2) (on b3 b2) (clear b3)
	(on-table b4) (on b10 b4) (clear b10)
	(on-table b5) (clear b5)
	(on-table b6) (clear b6)
	(on-table b7) (on b9 b7) (clear b9)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b7 b1) (clear b7)
	(on-table b2) (on b3 b2) (on b5 b3) (on b6 b5) (on b10 b6) (clear b10)
	(on-table b4) (clear b4)
	(on-table b8) (on b9 b8) (clear b9)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p10_92 blocks-hgn
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
	(on-table b1) (on b2 b1) (on b3 b2) (on b4 b3) (clear b4)
	(on-table b5) (on b10 b5) (clear b10)
	(on-table b6) (on b7 b6) (on b8 b7) (clear b8)
	(on-table b9) (clear b9)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b4 b1) (clear b4)
	(on-table b2) (on b3 b2) (on b7 b3) (on b9 b7) (clear b9)
	(on-table b5) (clear b5)
	(on-table b6) (on b8 b6) (on b10 b8) (clear b10)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p10_93 blocks-hgn
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
	(on-table b1) (on b5 b1) (on b9 b5) (clear b9)
	(on-table b2) (on b3 b2) (on b4 b3) (on b6 b4) (on b7 b6) (on b8 b7) (clear b8)
	(on-table b10) (clear b10)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b4 b1) (on b7 b4) (on b10 b7) (clear b10)
	(on-table b2) (on b3 b2) (on b5 b3) (on b8 b5) (on b9 b8) (clear b9)
	(on-table b6) (clear b6)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p10_94 blocks-hgn
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
	(on-table b1) (on b3 b1) (clear b3)
	(on-table b2) (on b4 b2) (on b5 b4) (on b6 b5) (on b8 b6) (on b9 b8) (on b10 b9) (clear b10)
	(on-table b7) (clear b7)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b3 b1) (on b8 b3) (on b10 b8) (clear b10)
	(on-table b2) (clear b2)
	(on-table b4) (on b6 b4) (on b7 b6) (clear b7)
	(on-table b5) (on b9 b5) (clear b9)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p10_95 blocks-hgn
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
	(on-table b1) (on b3 b1) (on b5 b3) (clear b5)
	(on-table b2) (on b4 b2) (on b7 b4) (on b8 b7) (clear b8)
	(on-table b6) (on b9 b6) (clear b9)
	(on-table b10) (clear b10)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b7 b1) (on b8 b7) (on b9 b8) (on b10 b9) (clear b10)
	(on-table b2) (on b3 b2) (on b4 b3) (clear b4)
	(on-table b5) (clear b5)
	(on-table b6) (clear b6)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p10_96 blocks-hgn
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
	(on-table b1) (on b2 b1) (on b5 b2) (on b9 b5) (clear b9)
	(on-table b3) (on b4 b3) (on b6 b4) (on b7 b6) (on b8 b7) (on b10 b8) (clear b10)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b2 b1) (on b10 b2) (clear b10)
	(on-table b3) (on b9 b3) (clear b9)
	(on-table b4) (on b5 b4) (on b6 b5) (on b8 b6) (clear b8)
	(on-table b7) (clear b7)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p10_97 blocks-hgn
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
	(on-table b1) (on b8 b1) (clear b8)
	(on-table b2) (on b3 b2) (clear b3)
	(on-table b4) (on b6 b4) (on b9 b6) (clear b9)
	(on-table b5) (clear b5)
	(on-table b7) (clear b7)
	(on-table b10) (clear b10)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b3 b1) (on b4 b3) (on b7 b4) (on b8 b7) (clear b8)
	(on-table b2) (on b5 b2) (on b6 b5) (on b9 b6) (clear b9)
	(on-table b10) (clear b10)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p10_98 blocks-hgn
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
	(on-table b1) (on b4 b1) (on b6 b4) (on b7 b6) (on b8 b7) (on b9 b8) (on b10 b9) (clear b10)
	(on-table b2) (on b3 b2) (on b5 b3) (clear b5)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b2 b1) (on b4 b2) (on b7 b4) (on b9 b7) (clear b9)
	(on-table b3) (on b10 b3) (clear b10)
	(on-table b5) (clear b5)
	(on-table b6) (on b8 b6) (clear b8)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p10_99 blocks-hgn
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
	(on-table b1) (on b2 b1) (on b9 b2) (clear b9)
	(on-table b3) (on b7 b3) (on b10 b7) (clear b10)
	(on-table b4) (on b5 b4) (on b6 b5) (clear b6)
	(on-table b8) (clear b8)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b2 b1) (on b3 b2) (on b4 b3) (on b5 b4) (on b8 b5) (on b10 b8) (clear b10)
	(on-table b6) (clear b6)
	(on-table b7) (on b9 b7) (clear b9)
)));End of goal task network
)


;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p10_100 blocks-hgn
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
	(on-table b1) (on b2 b1) (on b3 b2) (on b4 b3) (on b5 b4) (on b6 b5) (on b7 b6) (on b9 b7) (on b10 b9) (clear b10)
	(on-table b8) (clear b8)
)
(;Goal Task Network
(goal-achieved (
	(on-table b1) (on b8 b1) (clear b8)
	(on-table b2) (on b5 b2) (on b7 b5) (clear b7)
	(on-table b3) (on b4 b3) (on b6 b4) (on b9 b6) (on b10 b9) (clear b10)
)));End of goal task network
)


;;-------------------------------
