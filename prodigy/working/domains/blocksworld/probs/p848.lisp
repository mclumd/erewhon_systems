(setf (current-problem)
  (create-problem
    (name p848)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockG)
          (on blockG blockA)
          (on blockA blockD)
          (on blockD blockC)
          (on blockC blockE)
          (on-table blockE)
          (clear blockB)
          (on blockB blockH)
          (on blockH blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockF)
          (on-table blockF)
))))