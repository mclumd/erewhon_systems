(setf (current-problem)
  (create-problem
    (name p120)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockA)
          (on-table blockA)
          (clear blockE)
          (on-table blockE)
          (clear blockC)
          (on blockC blockF)
          (on-table blockF)
          (clear blockG)
          (on blockG blockH)
          (on-table blockH)
          (clear blockD)
          (on blockD blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockD)
          (on-table blockD)
))))