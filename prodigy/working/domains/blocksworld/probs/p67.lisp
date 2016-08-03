(setf (current-problem)
  (create-problem
    (name p67)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockF)
          (on blockF blockG)
          (on blockG blockD)
          (on blockD blockH)
          (on-table blockH)
          (clear blockB)
          (on blockB blockE)
          (on blockE blockA)
          (on blockA blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockD)
          (on-table blockD)
))))