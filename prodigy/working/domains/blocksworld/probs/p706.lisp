(setf (current-problem)
  (create-problem
    (name p706)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockH)
          (on-table blockH)
          (clear blockG)
          (on blockG blockC)
          (on-table blockC)
          (clear blockB)
          (on blockB blockE)
          (on blockE blockA)
          (on-table blockA)
          (clear blockD)
          (on blockD blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockC)
          (on blockC blockA)
          (on-table blockA)
))))