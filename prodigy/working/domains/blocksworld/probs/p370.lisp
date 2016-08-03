(setf (current-problem)
  (create-problem
    (name p370)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockE)
          (on-table blockE)
          (clear blockB)
          (on-table blockB)
          (clear blockA)
          (on blockA blockD)
          (on blockD blockF)
          (on-table blockF)
          (clear blockG)
          (on blockG blockH)
          (on blockH blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockF)
          (on blockF blockC)
          (on blockC blockB)
          (on blockB blockA)
          (on-table blockA)
))))