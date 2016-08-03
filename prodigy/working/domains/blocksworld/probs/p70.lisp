(setf (current-problem)
  (create-problem
    (name p70)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockC)
          (on blockC blockB)
          (on-table blockB)
          (clear blockD)
          (on blockD blockF)
          (on-table blockF)
          (clear blockH)
          (on blockH blockG)
          (on-table blockG)
          (clear blockA)
          (on blockA blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockC)
          (on blockC blockH)
          (on blockH blockB)
          (on blockB blockA)
          (on-table blockA)
))))