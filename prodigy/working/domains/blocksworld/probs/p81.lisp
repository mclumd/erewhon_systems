(setf (current-problem)
  (create-problem
    (name p81)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockF)
          (on-table blockF)
          (clear blockD)
          (on-table blockD)
          (clear blockC)
          (on-table blockC)
          (clear blockB)
          (on blockB blockA)
          (on blockA blockE)
          (on blockE blockG)
          (on blockG blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockE)
          (on-table blockE)
))))