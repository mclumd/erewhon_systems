(setf (current-problem)
  (create-problem
    (name p931)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockE)
          (on blockE blockG)
          (on blockG blockB)
          (on blockB blockD)
          (on blockD blockC)
          (on blockC blockH)
          (on blockH blockA)
          (on blockA blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockD)
          (on-table blockD)
))))