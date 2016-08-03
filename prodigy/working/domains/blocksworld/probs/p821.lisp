(setf (current-problem)
  (create-problem
    (name p821)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockC)
          (on blockC blockA)
          (on blockA blockE)
          (on blockE blockH)
          (on blockH blockF)
          (on blockF blockD)
          (on blockD blockB)
          (on blockB blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockC)
          (on blockC blockA)
          (on blockA blockB)
          (on-table blockB)
))))