(setf (current-problem)
  (create-problem
    (name p169)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockH)
          (on-table blockH)
          (clear blockG)
          (on-table blockG)
          (clear blockF)
          (on-table blockF)
          (clear blockE)
          (on blockE blockA)
          (on blockA blockB)
          (on-table blockB)
          (clear blockD)
          (on blockD blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockF)
          (on-table blockF)
))))