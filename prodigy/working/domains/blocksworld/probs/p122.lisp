(setf (current-problem)
  (create-problem
    (name p122)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockC)
          (on blockC blockG)
          (on blockG blockA)
          (on blockA blockH)
          (on-table blockH)
          (clear blockF)
          (on blockF blockE)
          (on-table blockE)
          (clear blockD)
          (on blockD blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockH)
          (on blockH blockF)
          (on blockF blockE)
          (on-table blockE)
))))