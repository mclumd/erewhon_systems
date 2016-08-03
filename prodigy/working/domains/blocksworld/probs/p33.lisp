(setf (current-problem)
  (create-problem
    (name p33)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockA)
          (on-table blockA)
          (clear blockG)
          (on-table blockG)
          (clear blockB)
          (on blockB blockE)
          (on-table blockE)
          (clear blockC)
          (on blockC blockH)
          (on-table blockH)
          (clear blockD)
          (on blockD blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockD)
          (on blockD blockH)
          (on-table blockH)
))))