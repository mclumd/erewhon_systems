(setf (current-problem)
  (create-problem
    (name p456)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockG)
          (on blockG blockC)
          (on-table blockC)
          (clear blockH)
          (on blockH blockB)
          (on-table blockB)
          (clear blockD)
          (on blockD blockF)
          (on-table blockF)
          (clear blockE)
          (on blockE blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockD)
          (on blockD blockA)
          (on blockA blockC)
          (on blockC blockG)
          (on-table blockG)
))))