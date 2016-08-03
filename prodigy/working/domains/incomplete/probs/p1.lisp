;; The problem demonstrates Prodigy's incompleteness.
;; The solution is (O2, O1, O3).

(setf (current-problem)
  (create-problem
    (name p1)
    (objects )
    (state (and (true) (g2) (g3)))
    (goal (and (g1) (g2)))))