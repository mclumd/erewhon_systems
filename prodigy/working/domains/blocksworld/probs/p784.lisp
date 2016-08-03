(setf (current-problem)
  (create-problem
    (name p784)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockG)
          (on blockG blockB)
          (on blockB blockA)
          (on-table blockA)
          (clear blockD)
          (on blockD blockH)
          (on blockH blockF)
          (on blockF blockC)
          (on blockC blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockH)
          (on-table blockH)
))))