(setf (current-problem)
  (create-problem
    (name p135)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockD)
          (on-table blockD)
          (clear blockC)
          (on-table blockC)
          (clear blockE)
          (on-table blockE)
          (clear blockB)
          (on-table blockB)
          (clear blockG)
          (on-table blockG)
          (clear blockH)
          (on blockH blockF)
          (on blockF blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockC)
          (on-table blockC)
))))