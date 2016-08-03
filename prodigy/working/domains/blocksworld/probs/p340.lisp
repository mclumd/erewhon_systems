(setf (current-problem)
  (create-problem
    (name p340)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockE)
          (on-table blockE)
          (clear blockF)
          (on-table blockF)
          (clear blockC)
          (on blockC blockG)
          (on-table blockG)
          (clear blockB)
          (on blockB blockD)
          (on-table blockD)
          (clear blockA)
          (on blockA blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockG)
          (on-table blockG)
))))