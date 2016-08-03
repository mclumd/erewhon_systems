(setf (current-problem)
  (create-problem
    (name p188)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockA)
          (on-table blockA)
          (clear blockB)
          (on-table blockB)
          (clear blockF)
          (on-table blockF)
          (clear blockG)
          (on-table blockG)
          (clear blockD)
          (on blockD blockH)
          (on-table blockH)
          (clear blockC)
          (on blockC blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockB)
          (on-table blockB)
))))