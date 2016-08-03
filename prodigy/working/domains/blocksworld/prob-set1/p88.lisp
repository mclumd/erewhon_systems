(setf (current-problem)
  (create-problem
    (name p88)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockF)
          (on blockF blockG)
          (on-table blockG)
          (clear blockD)
          (on blockD blockE)
          (on-table blockE)
          (clear blockA)
          (on blockA blockC)
          (on-table blockC)
          (clear blockB)
          (on blockB blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockE)
          (on blockE blockG)
          (on-table blockG)
))))