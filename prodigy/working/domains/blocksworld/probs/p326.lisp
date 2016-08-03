(setf (current-problem)
  (create-problem
    (name p326)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockD)
          (on blockD blockA)
          (on blockA blockF)
          (on blockF blockC)
          (on blockC blockB)
          (on blockB blockH)
          (on blockH blockG)
          (on blockG blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockD)
          (on blockD blockE)
          (on-table blockE)
))))