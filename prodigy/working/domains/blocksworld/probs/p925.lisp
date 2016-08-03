(setf (current-problem)
  (create-problem
    (name p925)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockC)
          (on-table blockC)
          (clear blockB)
          (on-table blockB)
          (clear blockD)
          (on-table blockD)
          (clear blockA)
          (on-table blockA)
          (clear blockH)
          (on-table blockH)
          (clear blockG)
          (on-table blockG)
          (clear blockE)
          (on-table blockE)
          (clear blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockH)
          (on blockH blockD)
          (on-table blockD)
          (clear blockE)
          (on blockE blockF)
          (on-table blockF)
))))