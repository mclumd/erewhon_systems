(setf (current-problem)
  (create-problem
    (name p17)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockA)
          (on blockA blockC)
          (on-table blockC)
          (clear blockB)
          (on blockB blockD)
          (on-table blockD)
          (clear blockG)
          (on blockG blockE)
          (on-table blockE)
          (clear blockF)
          (on blockF blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockC)
          (on blockC blockF)
          (on-table blockF)
          (clear blockG)
          (on blockG blockH)
          (on blockH blockE)
          (on-table blockE)
))))