(setf (current-problem)
  (create-problem
    (name p182)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockF)
          (on blockF blockB)
          (on blockB blockC)
          (on blockC blockH)
          (on-table blockH)
          (clear blockG)
          (on blockG blockE)
          (on blockE blockD)
          (on blockD blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockF)
          (on-table blockF)
))))