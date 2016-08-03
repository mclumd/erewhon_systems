(setf (current-problem)
  (create-problem
    (name p81)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockC)
          (on-table blockC)
          (clear blockB)
          (on-table blockB)
          (clear blockE)
          (on-table blockE)
          (clear blockF)
          (on-table blockF)
          (clear blockH)
          (on-table blockH)
          (clear blockD)
          (on blockD blockA)
          (on blockA blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockH)
          (on blockH blockD)
          (on-table blockD)
))))