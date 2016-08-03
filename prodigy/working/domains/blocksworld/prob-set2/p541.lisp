(setf (current-problem)
  (create-problem
    (name p541)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockG)
          (on blockG blockH)
          (on-table blockH)
          (clear blockB)
          (on blockB blockA)
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
          (on blockC blockA)
          (on-table blockA)
))))