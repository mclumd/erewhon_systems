(setf (current-problem)
  (create-problem
    (name p606)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockD)
          (on-table blockD)
          (clear blockA)
          (on-table blockA)
          (clear blockB)
          (on-table blockB)
          (clear blockE)
          (on blockE blockG)
          (on-table blockG)
          (clear blockC)
          (on blockC blockH)
          (on blockH blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockG)
          (on-table blockG)
))))