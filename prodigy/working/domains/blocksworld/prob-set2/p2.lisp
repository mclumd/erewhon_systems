(setf (current-problem)
  (create-problem
    (name p2)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockF)
          (on blockF blockB)
          (on blockB blockE)
          (on-table blockE)
          (clear blockD)
          (on blockD blockG)
          (on blockG blockH)
          (on-table blockH)
          (clear blockA)
          (on blockA blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockE)
          (on-table blockE)
))))