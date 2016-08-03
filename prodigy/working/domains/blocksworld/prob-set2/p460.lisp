(setf (current-problem)
  (create-problem
    (name p460)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockF)
          (on blockF blockB)
          (on blockB blockA)
          (on blockA blockH)
          (on-table blockH)
          (clear blockC)
          (on blockC blockG)
          (on-table blockG)
          (clear blockD)
          (on blockD blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockH)
          (on blockH blockG)
          (on blockG blockB)
          (on blockB blockF)
          (on-table blockF)
))))