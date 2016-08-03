(setf (current-problem)
  (create-problem
    (name p6)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockC)
          (on blockC blockD)
          (on-table blockD)
          (clear blockE)
          (on blockE blockF)
          (on-table blockF)
          (clear blockH)
          (on blockH blockG)
          (on-table blockG)
          (clear blockB)
          (on blockB blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockC)
          (on-table blockC)
))))