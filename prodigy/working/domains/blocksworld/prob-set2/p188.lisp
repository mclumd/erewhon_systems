(setf (current-problem)
  (create-problem
    (name p188)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockD)
          (on-table blockD)
          (clear blockC)
          (on blockC blockE)
          (on-table blockE)
          (clear blockH)
          (on blockH blockG)
          (on-table blockG)
          (clear blockF)
          (on blockF blockB)
          (on blockB blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockA)
          (on blockA blockG)
          (on blockG blockE)
          (on blockE blockB)
          (on blockB blockD)
          (on-table blockD)
))))