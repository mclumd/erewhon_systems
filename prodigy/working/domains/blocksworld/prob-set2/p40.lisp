(setf (current-problem)
  (create-problem
    (name p40)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockC)
          (on-table blockC)
          (clear blockA)
          (on-table blockA)
          (clear blockD)
          (on-table blockD)
          (clear blockB)
          (on-table blockB)
          (clear blockH)
          (on-table blockH)
          (clear blockF)
          (on-table blockF)
          (clear blockE)
          (on-table blockE)
          (clear blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockB)
          (on blockB blockG)
          (on-table blockG)
))))