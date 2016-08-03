(setf (current-problem)
  (create-problem
    (name p253)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockA)
          (on-table blockA)
          (clear blockC)
          (on blockC blockG)
          (on blockG blockE)
          (on blockE blockD)
          (on-table blockD)
          (clear blockB)
          (on blockB blockH)
          (on blockH blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockE)
          (on blockE blockC)
          (on blockC blockD)
          (on blockD blockA)
          (on blockA blockF)
          (on-table blockF)
))))