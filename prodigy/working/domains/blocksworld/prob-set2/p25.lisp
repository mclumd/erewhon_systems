(setf (current-problem)
  (create-problem
    (name p25)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockC)
          (on blockC blockB)
          (on blockB blockA)
          (on blockA blockF)
          (on-table blockF)
          (clear blockG)
          (on blockG blockD)
          (on blockD blockE)
          (on blockE blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockE)
          (on-table blockE)
))))