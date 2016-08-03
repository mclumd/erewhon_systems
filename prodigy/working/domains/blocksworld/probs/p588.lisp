(setf (current-problem)
  (create-problem
    (name p588)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockC)
          (on blockC blockD)
          (on-table blockD)
          (clear blockB)
          (on blockB blockF)
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
          (clear blockF)
          (on blockF blockH)
          (on-table blockH)
))))