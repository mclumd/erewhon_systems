(setf (current-problem)
  (create-problem
    (name p520)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockH)
          (on-table blockH)
          (clear blockF)
          (on blockF blockG)
          (on-table blockG)
          (clear blockB)
          (on blockB blockE)
          (on-table blockE)
          (clear blockC)
          (on blockC blockD)
          (on blockD blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockH)
          (on-table blockH)
))))