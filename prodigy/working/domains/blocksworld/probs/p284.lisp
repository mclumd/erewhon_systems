(setf (current-problem)
  (create-problem
    (name p284)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockH)
          (on blockH blockB)
          (on-table blockB)
          (clear blockE)
          (on blockE blockD)
          (on-table blockD)
          (clear blockA)
          (on blockA blockF)
          (on-table blockF)
          (clear blockC)
          (on blockC blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockC)
          (on blockC blockE)
          (on-table blockE)
))))