(setf (current-problem)
  (create-problem
    (name p398)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockH)
          (on blockH blockC)
          (on-table blockC)
          (clear blockD)
          (on blockD blockE)
          (on-table blockE)
          (clear blockA)
          (on blockA blockB)
          (on-table blockB)
          (clear blockG)
          (on blockG blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockA)
          (on blockA blockB)
          (on blockB blockD)
          (on blockD blockH)
          (on-table blockH)
))))