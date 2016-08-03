(setf (current-problem)
  (create-problem
    (name p623)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockF)
          (on blockF blockH)
          (on-table blockH)
          (clear blockG)
          (on blockG blockC)
          (on-table blockC)
          (clear blockB)
          (on blockB blockE)
          (on-table blockE)
          (clear blockA)
          (on blockA blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockE)
          (on-table blockE)
))))