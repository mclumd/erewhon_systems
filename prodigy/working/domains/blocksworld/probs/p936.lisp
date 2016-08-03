(setf (current-problem)
  (create-problem
    (name p936)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockH)
          (on-table blockH)
          (clear blockG)
          (on blockG blockC)
          (on blockC blockB)
          (on blockB blockF)
          (on blockF blockA)
          (on blockA blockD)
          (on blockD blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockG)
          (on-table blockG)
))))