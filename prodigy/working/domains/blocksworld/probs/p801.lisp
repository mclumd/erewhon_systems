(setf (current-problem)
  (create-problem
    (name p801)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockE)
          (on blockE blockH)
          (on-table blockH)
          (clear blockC)
          (on blockC blockB)
          (on-table blockB)
          (clear blockD)
          (on blockD blockA)
          (on-table blockA)
          (clear blockG)
          (on blockG blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockA)
          (on-table blockA)
))))