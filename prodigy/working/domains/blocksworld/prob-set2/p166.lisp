(setf (current-problem)
  (create-problem
    (name p166)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockC)
          (on-table blockC)
          (clear blockD)
          (on blockD blockA)
          (on blockA blockE)
          (on blockE blockG)
          (on-table blockG)
          (clear blockF)
          (on blockF blockB)
          (on blockB blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockD)
          (on-table blockD)
))))