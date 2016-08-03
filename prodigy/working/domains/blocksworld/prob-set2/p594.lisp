(setf (current-problem)
  (create-problem
    (name p594)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockC)
          (on-table blockC)
          (clear blockE)
          (on-table blockE)
          (clear blockB)
          (on blockB blockD)
          (on blockD blockF)
          (on blockF blockH)
          (on-table blockH)
          (clear blockG)
          (on blockG blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockC)
          (on-table blockC)
))))