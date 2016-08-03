(setf (current-problem)
  (create-problem
    (name p247)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockE)
          (on blockE blockC)
          (on-table blockC)
          (clear blockA)
          (on blockA blockG)
          (on-table blockG)
          (clear blockD)
          (on blockD blockF)
          (on-table blockF)
          (clear blockH)
          (on blockH blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockH)
          (on-table blockH)
))))