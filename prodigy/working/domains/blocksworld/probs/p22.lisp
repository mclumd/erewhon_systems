(setf (current-problem)
  (create-problem
    (name p22)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockH)
          (on-table blockH)
          (clear blockF)
          (on blockF blockD)
          (on blockD blockA)
          (on-table blockA)
          (clear blockC)
          (on blockC blockB)
          (on-table blockB)
          (clear blockG)
          (on blockG blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockB)
          (on-table blockB)
))))