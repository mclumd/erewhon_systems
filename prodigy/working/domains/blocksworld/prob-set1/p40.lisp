(setf (current-problem)
  (create-problem
    (name p40)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockF)
          (on-table blockF)
          (clear blockG)
          (on blockG blockC)
          (on blockC blockA)
          (on-table blockA)
          (clear blockD)
          (on blockD blockE)
          (on-table blockE)
          (clear blockB)
          (on blockB blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockA)
          (on blockA blockE)
          (on blockE blockD)
          (on-table blockD)
))))