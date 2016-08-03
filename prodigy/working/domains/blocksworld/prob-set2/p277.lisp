(setf (current-problem)
  (create-problem
    (name p277)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockF)
          (on-table blockF)
          (clear blockG)
          (on blockG blockC)
          (on-table blockC)
          (clear blockB)
          (on blockB blockD)
          (on-table blockD)
          (clear blockA)
          (on blockA blockH)
          (on blockH blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockE)
          (on-table blockE)
))))