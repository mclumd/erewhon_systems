(setf (current-problem)
  (create-problem
    (name p69)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockB)
          (on blockB blockG)
          (on-table blockG)
          (clear blockC)
          (on blockC blockE)
          (on-table blockE)
          (clear blockH)
          (on blockH blockD)
          (on-table blockD)
          (clear blockA)
          (on blockA blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockH)
          (on-table blockH)
))))