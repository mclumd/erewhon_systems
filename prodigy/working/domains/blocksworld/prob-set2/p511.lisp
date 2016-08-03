(setf (current-problem)
  (create-problem
    (name p511)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockG)
          (on blockG blockE)
          (on-table blockE)
          (clear blockC)
          (on blockC blockD)
          (on blockD blockA)
          (on-table blockA)
          (clear blockH)
          (on blockH blockB)
          (on blockB blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockA)
          (on blockA blockF)
          (on-table blockF)
))))