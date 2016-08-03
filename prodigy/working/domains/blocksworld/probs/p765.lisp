(setf (current-problem)
  (create-problem
    (name p765)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockD)
          (on blockD blockB)
          (on-table blockB)
          (clear blockH)
          (on blockH blockE)
          (on-table blockE)
          (clear blockF)
          (on blockF blockA)
          (on-table blockA)
          (clear blockG)
          (on blockG blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockE)
          (on blockE blockH)
          (on-table blockH)
))))