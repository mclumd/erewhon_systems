(setf (current-problem)
  (create-problem
    (name p103)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockA)
          (on blockA blockE)
          (on blockE blockH)
          (on blockH blockG)
          (on-table blockG)
          (clear blockD)
          (on blockD blockC)
          (on-table blockC)
          (clear blockB)
          (on blockB blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockE)
          (on blockE blockF)
          (on blockF blockB)
          (on blockB blockH)
          (on-table blockH)
))))