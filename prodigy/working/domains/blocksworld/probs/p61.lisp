(setf (current-problem)
  (create-problem
    (name p61)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockF)
          (on-table blockF)
          (clear blockD)
          (on-table blockD)
          (clear blockG)
          (on-table blockG)
          (clear blockH)
          (on-table blockH)
          (clear blockE)
          (on blockE blockB)
          (on blockB blockC)
          (on blockC blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockH)
          (on blockH blockC)
          (on-table blockC)
))))