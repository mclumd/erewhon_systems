(setf (current-problem)
  (create-problem
    (name p88)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockC)
          (on-table blockC)
          (clear blockF)
          (on blockF blockD)
          (on blockD blockA)
          (on blockA blockH)
          (on blockH blockG)
          (on blockG blockE)
          (on blockE blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockB)
          (on-table blockB)
))))