(setf (current-problem)
  (create-problem
    (name p61)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockD)
          (on blockD blockE)
          (on-table blockE)
          (clear blockG)
          (on blockG blockH)
          (on-table blockH)
          (clear blockA)
          (on blockA blockC)
          (on-table blockC)
          (clear blockF)
          (on blockF blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockF)
          (on blockF blockD)
          (on-table blockD)
))))