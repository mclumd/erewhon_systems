(setf (current-problem)
  (create-problem
    (name p312)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockF)
          (on blockF blockC)
          (on-table blockC)
          (clear blockH)
          (on blockH blockG)
          (on-table blockG)
          (clear blockB)
          (on blockB blockD)
          (on-table blockD)
          (clear blockA)
          (on blockA blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockF)
          (on blockF blockC)
          (on blockC blockA)
          (on blockA blockG)
          (on-table blockG)
))))