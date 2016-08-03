(setf (current-problem)
  (create-problem
    (name p10)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockD)
          (on-table blockD)
          (clear blockA)
          (on-table blockA)
          (clear blockF)
          (on-table blockF)
          (clear blockB)
          (on-table blockB)
          (clear blockE)
          (on-table blockE)
          (clear blockH)
          (on-table blockH)
          (clear blockG)
          (on blockG blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockC)
          (on blockC blockD)
          (on blockD blockB)
          (on blockB blockH)
          (on-table blockH)
))))