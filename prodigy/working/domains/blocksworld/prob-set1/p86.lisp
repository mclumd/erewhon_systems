(setf (current-problem)
  (create-problem
    (name p86)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockA)
          (on-table blockA)
          (clear blockD)
          (on blockD blockG)
          (on blockG blockH)
          (on blockH blockC)
          (on blockC blockE)
          (on blockE blockF)
          (on blockF blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockB)
          (on-table blockB)
          (clear blockD)
          (on blockD blockH)
          (on-table blockH)
))))