(setf (current-problem)
  (create-problem
    (name p719)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockH)
          (on-table blockH)
          (clear blockC)
          (on-table blockC)
          (clear blockA)
          (on-table blockA)
          (clear blockE)
          (on-table blockE)
          (clear blockF)
          (on-table blockF)
          (clear blockD)
          (on blockD blockB)
          (on blockB blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockB)
          (on-table blockB)
))))