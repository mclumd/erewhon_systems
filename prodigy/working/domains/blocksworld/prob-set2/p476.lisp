(setf (current-problem)
  (create-problem
    (name p476)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockC)
          (on-table blockC)
          (clear blockH)
          (on-table blockH)
          (clear blockF)
          (on blockF blockD)
          (on-table blockD)
          (clear blockA)
          (on blockA blockG)
          (on-table blockG)
          (clear blockB)
          (on blockB blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockB)
          (on blockB blockA)
          (on-table blockA)
))))