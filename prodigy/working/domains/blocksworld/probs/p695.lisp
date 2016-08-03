(setf (current-problem)
  (create-problem
    (name p695)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockG)
          (on blockG blockD)
          (on blockD blockH)
          (on blockH blockC)
          (on-table blockC)
          (clear blockA)
          (on blockA blockF)
          (on blockF blockB)
          (on blockB blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockH)
          (on-table blockH)
))))