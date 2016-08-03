(setf (current-problem)
  (create-problem
    (name p577)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockE)
          (on-table blockE)
          (clear blockD)
          (on blockD blockH)
          (on-table blockH)
          (clear blockG)
          (on blockG blockF)
          (on blockF blockA)
          (on-table blockA)
          (clear blockB)
          (on blockB blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockD)
          (on-table blockD)
))))