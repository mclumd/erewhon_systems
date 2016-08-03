(setf (current-problem)
  (create-problem
    (name p360)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockH)
          (on blockH blockF)
          (on blockF blockD)
          (on-table blockD)
          (clear blockG)
          (on blockG blockC)
          (on-table blockC)
          (clear blockB)
          (on blockB blockA)
          (on blockA blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockA)
          (on-table blockA)
))))