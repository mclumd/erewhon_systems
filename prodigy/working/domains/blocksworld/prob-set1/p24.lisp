(setf (current-problem)
  (create-problem
    (name p24)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockH)
          (on blockH blockD)
          (on-table blockD)
          (clear blockC)
          (on blockC blockE)
          (on-table blockE)
          (clear blockG)
          (on blockG blockF)
          (on-table blockF)
          (clear blockA)
          (on blockA blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockG)
          (on blockG blockE)
          (on-table blockE)
))))