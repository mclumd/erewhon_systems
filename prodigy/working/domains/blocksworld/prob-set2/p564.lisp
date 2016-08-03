(setf (current-problem)
  (create-problem
    (name p564)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockA)
          (on-table blockA)
          (clear blockE)
          (on blockE blockD)
          (on-table blockD)
          (clear blockC)
          (on blockC blockH)
          (on-table blockH)
          (clear blockF)
          (on blockF blockB)
          (on blockB blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockD)
          (on blockD blockE)
          (on blockE blockG)
          (on blockG blockB)
          (on-table blockB)
))))