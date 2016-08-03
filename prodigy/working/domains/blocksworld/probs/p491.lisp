(setf (current-problem)
  (create-problem
    (name p491)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockH)
          (on blockH blockB)
          (on blockB blockA)
          (on blockA blockD)
          (on blockD blockE)
          (on blockE blockG)
          (on blockG blockF)
          (on blockF blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockA)
          (on blockA blockF)
          (on blockF blockH)
          (on-table blockH)
          (clear blockD)
          (on blockD blockB)
          (on blockB blockC)
          (on-table blockC)
))))