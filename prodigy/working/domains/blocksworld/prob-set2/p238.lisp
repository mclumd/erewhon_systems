(setf (current-problem)
  (create-problem
    (name p238)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockC)
          (on-table blockC)
          (clear blockB)
          (on-table blockB)
          (clear blockH)
          (on blockH blockA)
          (on-table blockA)
          (clear blockE)
          (on blockE blockF)
          (on-table blockF)
          (clear blockG)
          (on blockG blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockG)
          (on-table blockG)
))))