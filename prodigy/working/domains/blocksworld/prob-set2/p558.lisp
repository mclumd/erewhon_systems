(setf (current-problem)
  (create-problem
    (name p558)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockC)
          (on-table blockC)
          (clear blockA)
          (on-table blockA)
          (clear blockH)
          (on-table blockH)
          (clear blockG)
          (on blockG blockB)
          (on blockB blockD)
          (on blockD blockE)
          (on blockE blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockG)
          (on-table blockG)
))))