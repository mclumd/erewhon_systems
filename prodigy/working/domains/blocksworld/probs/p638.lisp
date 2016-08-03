(setf (current-problem)
  (create-problem
    (name p638)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockD)
          (on-table blockD)
          (clear blockC)
          (on-table blockC)
          (clear blockH)
          (on blockH blockF)
          (on blockF blockB)
          (on-table blockB)
          (clear blockG)
          (on blockG blockA)
          (on blockA blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockA)
          (on blockA blockF)
          (on-table blockF)
))))