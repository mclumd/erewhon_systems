(setf (current-problem)
  (create-problem
    (name p560)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockF)
          (on-table blockF)
          (clear blockB)
          (on-table blockB)
          (clear blockG)
          (on-table blockG)
          (clear blockA)
          (on blockA blockC)
          (on blockC blockE)
          (on blockE blockH)
          (on blockH blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockH)
          (on blockH blockC)
          (on blockC blockD)
          (on-table blockD)
))))