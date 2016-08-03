(setf (current-problem)
  (create-problem
    (name p534)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockE)
          (on-table blockE)
          (clear blockB)
          (on blockB blockF)
          (on blockF blockD)
          (on blockD blockG)
          (on-table blockG)
          (clear blockC)
          (on blockC blockA)
          (on blockA blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockD)
          (on blockD blockB)
          (on-table blockB)
))))