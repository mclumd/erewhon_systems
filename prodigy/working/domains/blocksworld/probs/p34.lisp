(setf (current-problem)
  (create-problem
    (name p34)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockH)
          (on-table blockH)
          (clear blockC)
          (on-table blockC)
          (clear blockF)
          (on blockF blockD)
          (on-table blockD)
          (clear blockA)
          (on blockA blockG)
          (on-table blockG)
          (clear blockB)
          (on blockB blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockH)
          (on-table blockH)
))))