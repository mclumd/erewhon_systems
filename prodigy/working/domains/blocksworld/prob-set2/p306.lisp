(setf (current-problem)
  (create-problem
    (name p306)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockB)
          (on blockB blockF)
          (on-table blockF)
          (clear blockE)
          (on blockE blockD)
          (on-table blockD)
          (clear blockA)
          (on blockA blockG)
          (on-table blockG)
          (clear blockC)
          (on blockC blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockA)
          (on blockA blockD)
          (on-table blockD)
))))