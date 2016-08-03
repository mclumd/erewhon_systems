(setf (current-problem)
  (create-problem
    (name p259)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockE)
          (on blockE blockC)
          (on-table blockC)
          (clear blockH)
          (on blockH blockF)
          (on-table blockF)
          (clear blockB)
          (on blockB blockA)
          (on-table blockA)
          (clear blockD)
          (on blockD blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockH)
          (on-table blockH)
))))