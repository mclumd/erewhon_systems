(setf (current-problem)
  (create-problem
    (name p34)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockB)
          (on-table blockB)
          (clear blockG)
          (on-table blockG)
          (clear blockE)
          (on-table blockE)
          (clear blockC)
          (on blockC blockH)
          (on blockH blockD)
          (on-table blockD)
          (clear blockF)
          (on blockF blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockB)
          (on blockB blockE)
          (on-table blockE)
))))