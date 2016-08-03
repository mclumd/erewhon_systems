(setf (current-problem)
  (create-problem
    (name p583)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockH)
          (on-table blockH)
          (clear blockG)
          (on-table blockG)
          (clear blockE)
          (on-table blockE)
          (clear blockA)
          (on blockA blockF)
          (on blockF blockB)
          (on-table blockB)
          (clear blockC)
          (on blockC blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockD)
          (on blockD blockA)
          (on-table blockA)
))))