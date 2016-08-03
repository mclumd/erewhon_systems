(setf (current-problem)
  (create-problem
    (name p447)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockG)
          (on-table blockG)
          (clear blockB)
          (on blockB blockC)
          (on blockC blockA)
          (on blockA blockF)
          (on-table blockF)
          (clear blockH)
          (on blockH blockE)
          (on blockE blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockD)
          (on blockD blockG)
          (on-table blockG)
))))