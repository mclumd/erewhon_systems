(setf (current-problem)
  (create-problem
    (name p192)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockE)
          (on-table blockE)
          (clear blockC)
          (on blockC blockB)
          (on-table blockB)
          (clear blockH)
          (on blockH blockG)
          (on blockG blockA)
          (on-table blockA)
          (clear blockD)
          (on blockD blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockF)
          (on-table blockF)
))))