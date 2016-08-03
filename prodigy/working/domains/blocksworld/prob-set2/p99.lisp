(setf (current-problem)
  (create-problem
    (name p99)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockC)
          (on-table blockC)
          (clear blockD)
          (on-table blockD)
          (clear blockF)
          (on-table blockF)
          (clear blockG)
          (on blockG blockH)
          (on blockH blockA)
          (on blockA blockB)
          (on blockB blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockD)
          (on-table blockD)
))))