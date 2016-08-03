(setf (current-problem)
  (create-problem
    (name p217)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockH)
          (on-table blockH)
          (clear blockG)
          (on-table blockG)
          (clear blockD)
          (on blockD blockA)
          (on-table blockA)
          (clear blockE)
          (on blockE blockC)
          (on-table blockC)
          (clear blockB)
          (on blockB blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockC)
          (on-table blockC)
))))