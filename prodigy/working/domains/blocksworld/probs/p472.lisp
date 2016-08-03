(setf (current-problem)
  (create-problem
    (name p472)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockC)
          (on blockC blockH)
          (on-table blockH)
          (clear blockE)
          (on blockE blockA)
          (on blockA blockB)
          (on-table blockB)
          (clear blockD)
          (on blockD blockG)
          (on blockG blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockA)
          (on-table blockA)
))))