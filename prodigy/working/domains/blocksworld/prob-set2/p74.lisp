(setf (current-problem)
  (create-problem
    (name p74)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockH)
          (on-table blockH)
          (clear blockE)
          (on-table blockE)
          (clear blockF)
          (on blockF blockD)
          (on blockD blockG)
          (on blockG blockA)
          (on blockA blockB)
          (on blockB blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockF)
          (on blockF blockA)
          (on-table blockA)
))))