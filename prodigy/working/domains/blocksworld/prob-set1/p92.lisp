(setf (current-problem)
  (create-problem
    (name p92)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockH)
          (on blockH blockD)
          (on-table blockD)
          (clear blockC)
          (on blockC blockE)
          (on-table blockE)
          (clear blockB)
          (on blockB blockA)
          (on-table blockA)
          (clear blockG)
          (on blockG blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockA)
          (on-table blockA)
))))