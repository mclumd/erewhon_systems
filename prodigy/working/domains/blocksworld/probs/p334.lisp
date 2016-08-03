(setf (current-problem)
  (create-problem
    (name p334)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockC)
          (on blockC blockA)
          (on-table blockA)
          (clear blockH)
          (on blockH blockF)
          (on-table blockF)
          (clear blockD)
          (on blockD blockG)
          (on-table blockG)
          (clear blockB)
          (on blockB blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockD)
          (on-table blockD)
))))