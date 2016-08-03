(setf (current-problem)
  (create-problem
    (name p389)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockH)
          (on-table blockH)
          (clear blockE)
          (on-table blockE)
          (clear blockB)
          (on blockB blockA)
          (on blockA blockC)
          (on-table blockC)
          (clear blockF)
          (on blockF blockD)
          (on blockD blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockA)
          (on-table blockA)
))))