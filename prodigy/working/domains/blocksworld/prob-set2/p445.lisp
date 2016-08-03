(setf (current-problem)
  (create-problem
    (name p445)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockH)
          (on blockH blockG)
          (on-table blockG)
          (clear blockC)
          (on blockC blockF)
          (on-table blockF)
          (clear blockE)
          (on blockE blockD)
          (on-table blockD)
          (clear blockA)
          (on blockA blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockE)
          (on blockE blockD)
          (on blockD blockA)
          (on-table blockA)
))))