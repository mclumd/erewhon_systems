(setf (current-problem)
  (create-problem
    (name p671)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockF)
          (on-table blockF)
          (clear blockE)
          (on-table blockE)
          (clear blockG)
          (on-table blockG)
          (clear blockD)
          (on-table blockD)
          (clear blockH)
          (on blockH blockC)
          (on blockC blockB)
          (on blockB blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockG)
          (on blockG blockH)
          (on-table blockH)
))))