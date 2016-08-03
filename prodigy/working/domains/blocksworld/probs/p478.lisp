(setf (current-problem)
  (create-problem
    (name p478)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockD)
          (on blockD blockE)
          (on-table blockE)
          (clear blockH)
          (on blockH blockG)
          (on-table blockG)
          (clear blockF)
          (on blockF blockB)
          (on-table blockB)
          (clear blockA)
          (on blockA blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockF)
          (on blockF blockA)
          (on-table blockA)
))))