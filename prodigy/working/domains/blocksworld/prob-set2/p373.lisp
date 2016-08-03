(setf (current-problem)
  (create-problem
    (name p373)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockH)
          (on blockH blockD)
          (on-table blockD)
          (clear blockB)
          (on blockB blockC)
          (on-table blockC)
          (clear blockG)
          (on blockG blockF)
          (on-table blockF)
          (clear blockA)
          (on blockA blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockC)
          (on-table blockC)
))))