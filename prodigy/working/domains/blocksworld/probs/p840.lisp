(setf (current-problem)
  (create-problem
    (name p840)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockE)
          (on blockE blockC)
          (on-table blockC)
          (clear blockA)
          (on blockA blockG)
          (on-table blockG)
          (clear blockF)
          (on blockF blockD)
          (on-table blockD)
          (clear blockB)
          (on blockB blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockE)
          (on-table blockE)
          (clear blockB)
          (on blockB blockA)
          (on-table blockA)
))))