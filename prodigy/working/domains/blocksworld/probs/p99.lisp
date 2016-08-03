(setf (current-problem)
  (create-problem
    (name p99)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockB)
          (on-table blockB)
          (clear blockA)
          (on blockA blockC)
          (on-table blockC)
          (clear blockG)
          (on blockG blockE)
          (on-table blockE)
          (clear blockD)
          (on blockD blockF)
          (on blockF blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockF)
          (on blockF blockB)
          (on-table blockB)
))))