(setf (current-problem)
  (create-problem
    (name p668)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockG)
          (on blockG blockC)
          (on-table blockC)
          (clear blockB)
          (on blockB blockF)
          (on-table blockF)
          (clear blockD)
          (on blockD blockH)
          (on-table blockH)
          (clear blockE)
          (on blockE blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockG)
          (on blockG blockE)
          (on blockE blockA)
          (on blockA blockF)
          (on blockF blockB)
          (on blockB blockH)
          (on blockH blockD)
          (on-table blockD)
))))