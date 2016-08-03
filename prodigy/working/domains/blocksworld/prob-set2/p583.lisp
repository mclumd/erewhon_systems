(setf (current-problem)
  (create-problem
    (name p583)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockD)
          (on-table blockD)
          (clear blockE)
          (on-table blockE)
          (clear blockC)
          (on blockC blockA)
          (on blockA blockF)
          (on-table blockF)
          (clear blockB)
          (on blockB blockH)
          (on blockH blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockG)
          (on-table blockG)
))))