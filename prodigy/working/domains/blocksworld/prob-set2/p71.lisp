(setf (current-problem)
  (create-problem
    (name p71)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockF)
          (clear blockD)
          (on blockD blockB)
          (on-table blockB)
          (clear blockC)
          (on blockC blockH)
          (on-table blockH)
          (clear blockE)
          (on blockE blockG)
          (on blockG blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockC)
          (on blockC blockG)
          (on blockG blockE)
          (on blockE blockH)
          (on-table blockH)
))))