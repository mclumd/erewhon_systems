(setf (current-problem)
  (create-problem
    (name p258)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockA)
          (on blockA blockC)
          (on-table blockC)
          (clear blockF)
          (on blockF blockH)
          (on-table blockH)
          (clear blockG)
          (on blockG blockD)
          (on-table blockD)
          (clear blockB)
          (on blockB blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockE)
          (on-table blockE)
))))