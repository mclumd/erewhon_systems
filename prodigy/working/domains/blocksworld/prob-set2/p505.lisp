(setf (current-problem)
  (create-problem
    (name p505)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockF)
          (on blockF blockA)
          (on blockA blockH)
          (on blockH blockE)
          (on-table blockE)
          (clear blockC)
          (on blockC blockG)
          (on-table blockG)
          (clear blockD)
          (on blockD blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockA)
          (on-table blockA)
))))