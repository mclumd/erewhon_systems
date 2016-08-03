(setf (current-problem)
  (create-problem
    (name p211)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockA)
          (on blockA blockC)
          (on blockC blockH)
          (on blockH blockE)
          (on blockE blockD)
          (on blockD blockB)
          (on blockB blockF)
          (on blockF blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockA)
          (on-table blockA)
))))