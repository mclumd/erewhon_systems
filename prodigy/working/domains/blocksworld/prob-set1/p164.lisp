(setf (current-problem)
  (create-problem
    (name p164)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockC)
          (on-table blockC)
          (clear blockD)
          (on blockD blockH)
          (on blockH blockA)
          (on-table blockA)
          (clear blockE)
          (on blockE blockG)
          (on blockG blockB)
          (on blockB blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockH)
          (on-table blockH)
          (clear blockG)
          (on blockG blockB)
          (on-table blockB)
))))