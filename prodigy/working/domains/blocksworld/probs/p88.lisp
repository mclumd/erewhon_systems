(setf (current-problem)
  (create-problem
    (name p88)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockF)
          (on blockF blockA)
          (on blockA blockB)
          (on-table blockB)
          (clear blockD)
          (on blockD blockG)
          (on blockG blockE)
          (on-table blockE)
          (clear blockC)
          (on blockC blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockF)
          (on blockF blockD)
          (on blockD blockE)
          (on blockE blockA)
          (on-table blockA)
))))