(setf (current-problem)
  (create-problem
    (name p74)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockB)
          (on-table blockB)
          (clear blockF)
          (on blockF blockC)
          (on blockC blockG)
          (on blockG blockE)
          (on blockE blockD)
          (on blockD blockH)
          (on blockH blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockD)
          (on blockD blockE)
          (on blockE blockC)
          (on-table blockC)
))))