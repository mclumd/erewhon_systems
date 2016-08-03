(setf (current-problem)
  (create-problem
    (name p810)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockG)
          (on blockG blockH)
          (on-table blockH)
          (clear blockB)
          (on blockB blockA)
          (on-table blockA)
          (clear blockD)
          (on blockD blockC)
          (on blockC blockF)
          (on blockF blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockD)
          (on-table blockD)
))))