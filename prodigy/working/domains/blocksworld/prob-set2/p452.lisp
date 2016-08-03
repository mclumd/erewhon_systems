(setf (current-problem)
  (create-problem
    (name p452)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockB)
          (on-table blockB)
          (clear blockC)
          (on-table blockC)
          (clear blockH)
          (on blockH blockE)
          (on-table blockE)
          (clear blockD)
          (on blockD blockG)
          (on-table blockG)
          (clear blockA)
          (on blockA blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockG)
          (on blockG blockF)
          (on-table blockF)
          (clear blockH)
          (on blockH blockD)
          (on blockD blockC)
          (on blockC blockE)
          (on-table blockE)
))))