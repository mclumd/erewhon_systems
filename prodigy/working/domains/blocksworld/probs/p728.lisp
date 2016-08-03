(setf (current-problem)
  (create-problem
    (name p728)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockD)
          (on blockD blockA)
          (on-table blockA)
          (clear blockG)
          (on blockG blockF)
          (on-table blockF)
          (clear blockB)
          (on blockB blockE)
          (on-table blockE)
          (clear blockH)
          (on blockH blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockC)
          (on-table blockC)
))))