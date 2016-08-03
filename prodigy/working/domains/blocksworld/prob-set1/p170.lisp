(setf (current-problem)
  (create-problem
    (name p170)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockG)
          (on-table blockG)
          (clear blockD)
          (on blockD blockC)
          (on-table blockC)
          (clear blockH)
          (on blockH blockA)
          (on-table blockA)
          (clear blockB)
          (on blockB blockF)
          (on blockF blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockG)
          (on-table blockG)
))))