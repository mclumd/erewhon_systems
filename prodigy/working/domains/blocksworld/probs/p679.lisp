(setf (current-problem)
  (create-problem
    (name p679)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockF)
          (on-table blockF)
          (clear blockA)
          (on-table blockA)
          (clear blockC)
          (on-table blockC)
          (clear blockB)
          (on-table blockB)
          (clear blockG)
          (on-table blockG)
          (clear blockH)
          (on-table blockH)
          (clear blockD)
          (on blockD blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockE)
          (on-table blockE)
))))