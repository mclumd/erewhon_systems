(setf (current-problem)
  (create-problem
    (name p90)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockG)
          (on blockG blockD)
          (on-table blockD)
          (clear blockA)
          (on blockA blockB)
          (on-table blockB)
          (clear blockH)
          (on blockH blockF)
          (on-table blockF)
          (clear blockC)
          (on blockC blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockE)
          (on-table blockE)
))))