(setf (current-problem)
  (create-problem
    (name p57)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockE)
          (on-table blockE)
          (clear blockD)
          (on blockD blockB)
          (on-table blockB)
          (clear blockA)
          (on blockA blockC)
          (on-table blockC)
          (clear blockF)
          (on blockF blockH)
          (on blockH blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockA)
          (on-table blockA)
))))