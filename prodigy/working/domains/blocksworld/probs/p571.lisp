(setf (current-problem)
  (create-problem
    (name p571)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockB)
          (on-table blockB)
          (clear blockC)
          (on-table blockC)
          (clear blockH)
          (on blockH blockE)
          (on blockE blockA)
          (on blockA blockD)
          (on blockD blockG)
          (on blockG blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockE)
          (on-table blockE)
))))