(setf (current-problem)
  (create-problem
    (name p242)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockD)
          (on-table blockD)
          (clear blockG)
          (on-table blockG)
          (clear blockH)
          (on blockH blockE)
          (on-table blockE)
          (clear blockC)
          (on blockC blockA)
          (on-table blockA)
          (clear blockB)
          (on blockB blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockB)
          (on-table blockB)
))))