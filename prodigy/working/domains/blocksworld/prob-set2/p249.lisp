(setf (current-problem)
  (create-problem
    (name p249)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockC)
          (on-table blockC)
          (clear blockG)
          (on blockG blockA)
          (on blockA blockB)
          (on blockB blockH)
          (on blockH blockE)
          (on blockE blockD)
          (on blockD blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockA)
          (on blockA blockD)
          (on blockD blockG)
          (on-table blockG)
))))