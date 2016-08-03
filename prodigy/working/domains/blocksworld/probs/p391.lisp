(setf (current-problem)
  (create-problem
    (name p391)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockG)
          (on blockG blockD)
          (on-table blockD)
          (clear blockF)
          (on blockF blockB)
          (on-table blockB)
          (clear blockH)
          (on blockH blockC)
          (on-table blockC)
          (clear blockA)
          (on blockA blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockG)
          (on-table blockG)
))))