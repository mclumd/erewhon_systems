(setf (current-problem)
  (create-problem
    (name p66)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockB)
          (on blockB blockD)
          (on blockD blockF)
          (on-table blockF)
          (clear blockA)
          (on blockA blockG)
          (on blockG blockE)
          (on-table blockE)
          (clear blockC)
          (on blockC blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockD)
          (on-table blockD)
))))