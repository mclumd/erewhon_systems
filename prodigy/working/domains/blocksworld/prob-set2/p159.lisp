(setf (current-problem)
  (create-problem
    (name p159)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockA)
          (on blockA blockB)
          (on-table blockB)
          (clear blockH)
          (on blockH blockE)
          (on-table blockE)
          (clear blockF)
          (on blockF blockD)
          (on-table blockD)
          (clear blockG)
          (on blockG blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockE)
          (on-table blockE)
))))