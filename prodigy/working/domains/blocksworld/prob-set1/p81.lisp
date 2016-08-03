(setf (current-problem)
  (create-problem
    (name p81)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockH)
          (on-table blockH)
          (clear blockG)
          (on-table blockG)
          (clear blockA)
          (on-table blockA)
          (clear blockE)
          (on-table blockE)
          (clear blockF)
          (on-table blockF)
          (clear blockB)
          (on blockB blockC)
          (on blockC blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockF)
          (on blockF blockE)
          (on blockE blockB)
          (on blockB blockG)
          (on blockG blockH)
          (on blockH blockC)
          (on blockC blockD)
          (on-table blockD)
))))