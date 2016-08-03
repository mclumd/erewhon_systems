(setf (current-problem)
  (create-problem
    (name p911)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockB)
          (on-table blockB)
          (clear blockG)
          (on-table blockG)
          (clear blockH)
          (on blockH blockF)
          (on-table blockF)
          (clear blockC)
          (on blockC blockE)
          (on-table blockE)
          (clear blockA)
          (on blockA blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockE)
          (on-table blockE)
))))