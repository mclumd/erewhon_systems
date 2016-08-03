(setf (current-problem)
  (create-problem
    (name p845)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockF)
          (on-table blockF)
          (clear blockB)
          (on blockB blockD)
          (on-table blockD)
          (clear blockH)
          (on blockH blockE)
          (on blockE blockA)
          (on-table blockA)
          (clear blockC)
          (on blockC blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockA)
          (on-table blockA)
))))