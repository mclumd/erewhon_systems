(setf (current-problem)
  (create-problem
    (name p18)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockB)
          (on blockB blockF)
          (on-table blockF)
          (clear blockD)
          (on blockD blockH)
          (on-table blockH)
          (clear blockG)
          (on blockG blockE)
          (on-table blockE)
          (clear blockA)
          (on blockA blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockG)
          (on-table blockG)
))))