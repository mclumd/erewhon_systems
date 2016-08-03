(setf (current-problem)
  (create-problem
    (name p67)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockF)
          (on blockF blockB)
          (on blockB blockG)
          (on blockG blockA)
          (on blockA blockE)
          (on-table blockE)
          (clear blockD)
          (on blockD blockH)
          (on blockH blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockB)
          (on-table blockB)
))))