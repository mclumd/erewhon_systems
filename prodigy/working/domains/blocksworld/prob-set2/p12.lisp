(setf (current-problem)
  (create-problem
    (name p12)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockC)
          (on-table blockC)
          (clear blockF)
          (on blockF blockH)
          (on blockH blockD)
          (on blockD blockB)
          (on blockB blockG)
          (on blockG blockA)
          (on blockA blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockG)
          (on blockG blockE)
          (on blockE blockC)
          (on blockC blockB)
          (on blockB blockF)
          (on-table blockF)
))))