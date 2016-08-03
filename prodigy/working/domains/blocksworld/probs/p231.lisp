(setf (current-problem)
  (create-problem
    (name p231)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockH)
          (on-table blockH)
          (clear blockB)
          (on blockB blockG)
          (on blockG blockA)
          (on-table blockA)
          (clear blockD)
          (on blockD blockE)
          (on-table blockE)
          (clear blockF)
          (on blockF blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockG)
          (on blockG blockF)
          (on-table blockF)
          (clear blockD)
          (on blockD blockA)
          (on-table blockA)
))))