(setf (current-problem)
  (create-problem
    (name p531)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockB)
          (clear blockE)
          (on-table blockE)
          (clear blockG)
          (on blockG blockD)
          (on-table blockD)
          (clear blockF)
          (on blockF blockH)
          (on-table blockH)
          (clear blockC)
          (on blockC blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockE)
          (on blockE blockF)
          (on blockF blockD)
          (on-table blockD)
))))