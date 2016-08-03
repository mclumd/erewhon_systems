(setf (current-problem)
  (create-problem
    (name p892)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockE)
          (on-table blockE)
          (clear blockG)
          (on-table blockG)
          (clear blockC)
          (on blockC blockD)
          (on-table blockD)
          (clear blockB)
          (on blockB blockA)
          (on-table blockA)
          (clear blockF)
          (on blockF blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockE)
          (on-table blockE)
))))