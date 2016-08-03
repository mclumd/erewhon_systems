(setf (current-problem)
  (create-problem
    (name p683)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockF)
          (on-table blockF)
          (clear blockH)
          (on blockH blockA)
          (on blockA blockB)
          (on blockB blockG)
          (on blockG blockC)
          (on blockC blockE)
          (on blockE blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockA)
          (on-table blockA)
))))