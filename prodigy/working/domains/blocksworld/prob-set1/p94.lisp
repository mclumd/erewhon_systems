(setf (current-problem)
  (create-problem
    (name p94)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockG)
          (on blockG blockD)
          (on-table blockD)
          (clear blockH)
          (on blockH blockC)
          (on-table blockC)
          (clear blockF)
          (on blockF blockE)
          (on-table blockE)
          (clear blockA)
          (on blockA blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockD)
          (on-table blockD)
))))