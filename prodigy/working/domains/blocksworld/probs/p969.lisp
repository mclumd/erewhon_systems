(setf (current-problem)
  (create-problem
    (name p969)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockF)
          (on blockF blockC)
          (on-table blockC)
          (clear blockD)
          (on blockD blockG)
          (on blockG blockA)
          (on-table blockA)
          (clear blockB)
          (on blockB blockH)
          (on blockH blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockF)
          (on-table blockF)
          (clear blockC)
          (on blockC blockA)
          (on-table blockA)
))))