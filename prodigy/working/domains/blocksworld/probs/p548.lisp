(setf (current-problem)
  (create-problem
    (name p548)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockG)
          (on-table blockG)
          (clear blockA)
          (on blockA blockD)
          (on blockD blockB)
          (on blockB blockF)
          (on blockF blockE)
          (on blockE blockH)
          (on blockH blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockE)
          (on blockE blockG)
          (on blockG blockC)
          (on blockC blockA)
          (on-table blockA)
))))