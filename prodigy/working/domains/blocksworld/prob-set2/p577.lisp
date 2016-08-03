(setf (current-problem)
  (create-problem
    (name p577)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockH)
          (on-table blockH)
          (clear blockB)
          (on-table blockB)
          (clear blockC)
          (on-table blockC)
          (clear blockD)
          (on-table blockD)
          (clear blockG)
          (on-table blockG)
          (clear blockE)
          (on-table blockE)
          (clear blockA)
          (on blockA blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockA)
          (on-table blockA)
))))