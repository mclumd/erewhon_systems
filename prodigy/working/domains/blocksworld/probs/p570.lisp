(setf (current-problem)
  (create-problem
    (name p570)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockA)
          (on-table blockA)
          (clear blockC)
          (on-table blockC)
          (clear blockB)
          (on blockB blockH)
          (on-table blockH)
          (clear blockD)
          (on blockD blockF)
          (on-table blockF)
          (clear blockG)
          (on blockG blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockD)
          (on-table blockD)
))))