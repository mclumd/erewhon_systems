(setf (current-problem)
  (create-problem
    (name p899)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockF)
          (on-table blockF)
          (clear blockC)
          (on-table blockC)
          (clear blockG)
          (on-table blockG)
          (clear blockA)
          (on blockA blockB)
          (on blockB blockH)
          (on blockH blockD)
          (on blockD blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockG)
          (on blockG blockD)
          (on blockD blockF)
          (on-table blockF)
))))