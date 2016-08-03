(setf (current-problem)
  (create-problem
    (name p833)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockE)
          (on blockE blockB)
          (on-table blockB)
          (clear blockF)
          (on blockF blockG)
          (on-table blockG)
          (clear blockA)
          (on blockA blockH)
          (on-table blockH)
          (clear blockD)
          (on blockD blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockF)
          (on blockF blockC)
          (on blockC blockD)
          (on-table blockD)
))))