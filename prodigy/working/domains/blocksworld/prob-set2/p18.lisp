(setf (current-problem)
  (create-problem
    (name p18)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockD)
          (on-table blockD)
          (clear blockA)
          (on blockA blockH)
          (on blockH blockE)
          (on blockE blockG)
          (on blockG blockB)
          (on-table blockB)
          (clear blockF)
          (on blockF blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockD)
          (on blockD blockC)
          (on blockC blockB)
          (on-table blockB)
))))