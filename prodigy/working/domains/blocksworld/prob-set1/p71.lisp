(setf (current-problem)
  (create-problem
    (name p71)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockB)
          (on-table blockB)
          (clear blockH)
          (on-table blockH)
          (clear blockF)
          (on-table blockF)
          (clear blockC)
          (on blockC blockE)
          (on-table blockE)
          (clear blockG)
          (on blockG blockD)
          (on blockD blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockB)
          (on-table blockB)
))))