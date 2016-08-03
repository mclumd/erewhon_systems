(setf (current-problem)
  (create-problem
    (name p73)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockG)
          (on blockG blockF)
          (on blockF blockA)
          (on-table blockA)
          (clear blockE)
          (on blockE blockB)
          (on blockB blockH)
          (on-table blockH)
          (clear blockC)
          (on blockC blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockH)
          (on-table blockH)
))))