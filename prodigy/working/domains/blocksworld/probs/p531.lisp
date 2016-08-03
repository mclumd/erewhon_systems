(setf (current-problem)
  (create-problem
    (name p531)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockE)
          (on blockE blockC)
          (on-table blockC)
          (clear blockF)
          (on blockF blockH)
          (on-table blockH)
          (clear blockA)
          (on blockA blockB)
          (on-table blockB)
          (clear blockG)
          (on blockG blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockC)
          (on-table blockC)
          (clear blockE)
          (on blockE blockH)
          (on-table blockH)
))))