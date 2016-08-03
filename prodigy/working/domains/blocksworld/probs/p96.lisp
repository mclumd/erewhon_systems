(setf (current-problem)
  (create-problem
    (name p96)
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
          (clear blockH)
          (on-table blockH)
          (clear blockG)
          (on blockG blockA)
          (on blockA blockB)
          (on blockB blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockA)
          (on-table blockA)
))))