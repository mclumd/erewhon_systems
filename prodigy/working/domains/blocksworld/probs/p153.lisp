(setf (current-problem)
  (create-problem
    (name p153)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockB)
          (on-table blockB)
          (clear blockA)
          (on blockA blockF)
          (on-table blockF)
          (clear blockC)
          (on blockC blockE)
          (on-table blockE)
          (clear blockG)
          (on blockG blockD)
          (on blockD blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockD)
          (on-table blockD)
))))