(setf (current-problem)
  (create-problem
    (name p48)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockA)
          (on blockA blockG)
          (on blockG blockD)
          (on blockD blockH)
          (on blockH blockE)
          (on-table blockE)
          (clear blockC)
          (on blockC blockB)
          (on blockB blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockH)
          (on-table blockH)
))))