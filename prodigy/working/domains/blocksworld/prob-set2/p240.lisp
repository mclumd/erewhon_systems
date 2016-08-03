(setf (current-problem)
  (create-problem
    (name p240)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockE)
          (on-table blockE)
          (clear blockC)
          (on-table blockC)
          (clear blockF)
          (on blockF blockB)
          (on blockB blockG)
          (on blockG blockD)
          (on blockD blockA)
          (on blockA blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockE)
          (on blockE blockB)
          (on-table blockB)
))))