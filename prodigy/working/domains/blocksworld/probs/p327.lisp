(setf (current-problem)
  (create-problem
    (name p327)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockF)
          (on-table blockF)
          (clear blockC)
          (on blockC blockH)
          (on-table blockH)
          (clear blockA)
          (on blockA blockB)
          (on blockB blockE)
          (on-table blockE)
          (clear blockG)
          (on blockG blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockH)
          (on blockH blockC)
          (on-table blockC)
))))