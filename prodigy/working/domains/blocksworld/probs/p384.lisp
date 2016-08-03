(setf (current-problem)
  (create-problem
    (name p384)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockC)
          (on-table blockC)
          (clear blockD)
          (on blockD blockE)
          (on blockE blockG)
          (on-table blockG)
          (clear blockA)
          (on blockA blockB)
          (on-table blockB)
          (clear blockF)
          (on blockF blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockA)
          (on-table blockA)
))))