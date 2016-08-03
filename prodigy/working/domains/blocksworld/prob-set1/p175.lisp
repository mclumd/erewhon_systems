(setf (current-problem)
  (create-problem
    (name p175)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockG)
          (on blockG blockF)
          (on-table blockF)
          (clear blockE)
          (on blockE blockD)
          (on-table blockD)
          (clear blockC)
          (on blockC blockH)
          (on-table blockH)
          (clear blockA)
          (on blockA blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockA)
          (on-table blockA)
))))