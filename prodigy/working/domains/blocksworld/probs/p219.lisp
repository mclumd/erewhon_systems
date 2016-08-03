(setf (current-problem)
  (create-problem
    (name p219)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockB)
          (on blockB blockA)
          (on-table blockA)
          (clear blockG)
          (on blockG blockE)
          (on-table blockE)
          (clear blockD)
          (on blockD blockC)
          (on-table blockC)
          (clear blockH)
          (on blockH blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockG)
          (on-table blockG)
))))