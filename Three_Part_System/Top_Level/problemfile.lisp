;;-------------------------------
(in-package :shop2)
;;---------------------------------------------

(defproblem p_some_problem blocks-htn
(
    (arm-empty)
    (block b2)
    (block b1)
    (block b0)
    (block b1)
    (on-table b1)
    (on b0 b1)
    (clear b0)
    (on b1 b2)
    (clear b1)
)
(;Goal Task Network
    (achieve-goals (
(on b0 b1)
)));End of goal task network
)
