(setf (current-problem)
  (create-problem
    (name p392)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockA)
          (on-table blockA)
          (clear blockF)
          (on-table blockF)
          (clear blockE)
          (on-table blockE)
          (clear blockC)
          (on blockC blockB)
          (on blockB blockG)
          (on-table blockG)
          (clear blockD)
          (on blockD blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockF)
          (on-table blockF)
))))