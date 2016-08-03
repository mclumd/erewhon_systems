(setf (current-problem)
  (create-problem
    (name p79)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockA)
          (on-table blockA)
          (clear blockF)
          (on-table blockF)
          (clear blockE)
          (on-table blockE)
          (clear blockD)
          (on blockD blockH)
          (on blockH blockB)
          (on blockB blockC)
          (on blockC blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockD)
          (on-table blockD)
))))