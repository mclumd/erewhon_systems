(setf (current-problem)
  (create-problem
    (name p164)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockE)
          (on-table blockE)
          (clear blockH)
          (on-table blockH)
          (clear blockG)
          (on-table blockG)
          (clear blockB)
          (on blockB blockA)
          (on blockA blockF)
          (on blockF blockD)
          (on blockD blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockH)
          (on-table blockH)
))))