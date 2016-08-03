(setf (current-problem)
  (create-problem
    (name p755)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockC)
          (on-table blockC)
          (clear blockD)
          (on blockD blockH)
          (on blockH blockG)
          (on-table blockG)
          (clear blockA)
          (on blockA blockE)
          (on-table blockE)
          (clear blockB)
          (on blockB blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockE)
          (on-table blockE)
))))