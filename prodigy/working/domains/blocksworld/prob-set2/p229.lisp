(setf (current-problem)
  (create-problem
    (name p229)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockE)
          (on-table blockE)
          (clear blockH)
          (on blockH blockA)
          (on-table blockA)
          (clear blockF)
          (on blockF blockC)
          (on-table blockC)
          (clear blockD)
          (on blockD blockG)
          (on blockG blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockA)
          (on blockA blockD)
          (on blockD blockC)
          (on-table blockC)
))))