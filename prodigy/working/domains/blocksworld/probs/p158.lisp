(setf (current-problem)
  (create-problem
    (name p158)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockH)
          (on blockH blockA)
          (on-table blockA)
          (clear blockC)
          (on blockC blockF)
          (on-table blockF)
          (clear blockD)
          (on blockD blockE)
          (on-table blockE)
          (clear blockG)
          (on blockG blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockD)
          (on blockD blockG)
          (on-table blockG)
))))