(setf (current-problem)
  (create-problem
    (name p123)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockA)
          (on-table blockA)
          (clear blockD)
          (on blockD blockB)
          (on-table blockB)
          (clear blockH)
          (on blockH blockG)
          (on blockG blockE)
          (on-table blockE)
          (clear blockC)
          (on blockC blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockG)
          (on-table blockG)
))))