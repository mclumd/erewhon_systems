(setf (current-problem)
  (create-problem
    (name p123)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockF)
          (on-table blockF)
          (clear blockE)
          (on blockE blockC)
          (on blockC blockG)
          (on blockG blockB)
          (on blockB blockD)
          (on blockD blockA)
          (on blockA blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockA)
          (on blockA blockB)
          (on-table blockB)
          (clear blockC)
          (on blockC blockG)
          (on-table blockG)
))))