(setf (current-problem)
  (create-problem
    (name p70)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockH)
          (on-table blockH)
          (clear blockD)
          (on-table blockD)
          (clear blockG)
          (on-table blockG)
          (clear blockA)
          (on-table blockA)
          (clear blockC)
          (on-table blockC)
          (clear blockF)
          (on-table blockF)
          (clear blockB)
          (on-table blockB)
          (clear blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockH)
          (on-table blockH)
          (clear blockC)
          (on blockC blockF)
          (on-table blockF)
          (clear blockE)
          (on blockE blockD)
          (on blockD blockA)
          (on-table blockA)
))))