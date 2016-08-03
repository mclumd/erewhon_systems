(setf (current-problem)
  (create-problem
    (name p219)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockA)
          (on blockA blockB)
          (on blockB blockD)
          (on blockD blockG)
          (on-table blockG)
          (clear blockH)
          (on blockH blockE)
          (on-table blockE)
          (clear blockC)
          (on blockC blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockF)
          (on blockF blockD)
          (on-table blockD)
))))