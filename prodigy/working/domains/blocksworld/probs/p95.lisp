(setf (current-problem)
  (create-problem
    (name p95)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockF)
          (clear blockE)
          (on-table blockE)
          (clear blockA)
          (on-table blockA)
          (clear blockH)
          (on-table blockH)
          (clear blockC)
          (on-table blockC)
          (clear blockG)
          (on-table blockG)
          (clear blockD)
          (on-table blockD)
          (clear blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockD)
          (on blockD blockH)
          (on-table blockH)
))))