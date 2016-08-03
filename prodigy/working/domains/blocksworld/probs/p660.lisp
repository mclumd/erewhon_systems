(setf (current-problem)
  (create-problem
    (name p660)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockH)
          (on-table blockH)
          (clear blockE)
          (on-table blockE)
          (clear blockB)
          (on-table blockB)
          (clear blockF)
          (on-table blockF)
          (clear blockD)
          (on blockD blockG)
          (on-table blockG)
          (clear blockA)
          (on blockA blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockA)
          (on blockA blockC)
          (on-table blockC)
))))