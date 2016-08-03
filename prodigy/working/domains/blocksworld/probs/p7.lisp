(setf (current-problem)
  (create-problem
    (name p7)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockE)
          (on blockE blockH)
          (on-table blockH)
          (clear blockC)
          (on blockC blockG)
          (on-table blockG)
          (clear blockD)
          (on blockD blockF)
          (on-table blockF)
          (clear blockB)
          (on blockB blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockB)
          (on blockB blockA)
          (on blockA blockC)
          (on-table blockC)
))))