(in-package :shop2)
;;---------------------------------------------

(defproblem toy blocks-hgn-simpl
(
        (arm-empty)
        (block b1)
        (block b2)
        (block b3)
;        (block b4)
;        (block b4)
;        (block b5)
;        (block b6)
;        (block b7)
;        (block b8)
;        (block b9)
;        (block b10)
;        (on-table b1) (on b6 b1) (clear b6)
;        (on-table b2) (on b3 b2) (on b4 b3) (clear b4)
;        (on-table b5) (on b7 b5) (on b8 b7) (on b9 b8) (on b10 b9) (clear b10)
        (on-table b1) (on-table b2) (clear b1) (on b3 b2) (clear b3)
)
;Goal Task Network
((on b1 b3) (on b2 b1) (on-table b3))
;End of goal task network
)

