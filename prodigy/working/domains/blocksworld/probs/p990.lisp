(setf (current-problem)
  (create-problem
    (name p990)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockE)
          (on blockE blockC)
          (on-table blockC)
          (clear blockG)
          (on blockG blockD)
          (on-table blockD)
          (clear blockF)
          (on blockF blockA)
          (on-table blockA)
          (clear blockB)
          (on blockB blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockG)
          (on-table blockG)
))))