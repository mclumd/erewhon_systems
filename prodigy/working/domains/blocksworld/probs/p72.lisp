(setf (current-problem)
  (create-problem
    (name p72)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockG)
          (on-table blockG)
          (clear blockB)
          (on-table blockB)
          (clear blockF)
          (on blockF blockD)
          (on-table blockD)
          (clear blockH)
          (on blockH blockA)
          (on-table blockA)
          (clear blockC)
          (on blockC blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockA)
          (on blockA blockF)
          (on blockF blockH)
          (on-table blockH)
))))